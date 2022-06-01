let sender = false;
let serverId;
let callId;
let streaming = false;
let watching = false;
let callerId;
const RTCServers = {
  iceServers: [
    {
      urls: ["stun:stun1.l.google.com:19302", "stun:stun2.l.google.com:19302"],
    },
  ],
  iceCandidatePoolSize: 10,
};

async function handleSignallingData(data) {
  switch (data.type) {
    case "offer":
      let sessionDesc = new RTCSessionDescription(data.offer);
      await peerConn.setRemoteDescription(sessionDesc);
      createAndSendAnswer();
      break;
    case "candidate":
      let candidate = new RTCIceCandidate(data.candidate);
      peerConn.addIceCandidate(candidate);
  }
}

async function createAndSendAnswer() {
  let candidateAnswer = await peerConn.createAnswer();
  await peerConn.setLocalDescription(candidateAnswer);

  let answerObject = {
    sdp: candidateAnswer.sdp,
    type: candidateAnswer.type
  }
  sendData({
    type: "send_answer",
    answer: answerObject,
  });

}

function sendData(data) {
  //todo global
  data.callId = parseInt(callId);
  data.serverId = parseInt(serverId);
  $.post("https://qb-phone/sendData", JSON.stringify(data));
}

let localStream;
let peerConn;

function joinCall() {
  $.post("https://qb-phone/openCam");
  $(".phone-call-videocall").css("display", "block")
  $(".phone-call-ongoing").css("display", "none")
  $(".phone-currentcall-container").css("display", "none")
  $(".phone-home-container").prop("disabled", true);
  $(".phone-currentcall-container").css("display","none")

  watching = true;
  callId = serverId;
  peerConn = new RTCPeerConnection(RTCServers);
  let canvas = document.getElementById("local-video");
  canvas.style.display = "block"
  MainRender.renderToTarget(canvas);
  let stream = canvas.captureStream();

  localStream = stream;
  document.getElementById("local-video").srcObject = localStream;

  let video = document.getElementById("remote-video");
  video.srcObject = new MediaStream(); //? create a media stream for remote stream

  peerConn.onicecandidate = (e) => {
    if (e.candidate == null) return;
    let candidate = new RTCIceCandidate(e.candidate);
    peerConn.addIceCandidate(candidate);
    sendData({
      type: "send_candidate",
      candidate: candidate,
    });
  };

  peerConn.ontrack = (event) => {
    event.streams[0].getTracks().forEach((track) => {
      video.srcObject.addTrack(track);
    });
  };

  video.play();

  localStream.getTracks().forEach(function (track) {
    peerConn.addTrack(track, localStream);
  });

  sendData({
    type: "join_call",
  });
}

// ************************************************************************************************ //

async function handleSignallingDataSender(data) {
  switch (data.type) {
    case "answer":
      let answer = new RTCSessionDescription(data.answer);
      await SenderpeerConn.setRemoteDescription(answer);
      break;
    case "candidate":
      let candidate = new RTCIceCandidate(data.candidate);
      SenderpeerConn.addIceCandidate(candidate);
  }
}

function sendcallId(id) {
  console.log(id)
  callId = id
  sendData({
    type: "store_user",
  });
}

let SenderpeerConn;
async function startCall(id) {
  $.post("https://qb-phone/openCam");
  await sendcallId(id);
  $(".phone-call-ongoing").css("display", "none")
  $(".phone-currentcall-container").css("display", "none")
  $(".phone-call-videocall").css("display", "block")
  streaming = true;
  sender = true;

  let canvas = document.getElementById("local-video");
  canvas.style.display = "block"
  MainRender.renderToTarget(canvas);
  let stream = canvas.captureStream();

  localStream = stream;
  document.getElementById("local-video").srcObject = localStream;

  SenderpeerConn = new RTCPeerConnection(RTCServers);
  localStream.getTracks().forEach(function (track) {
    SenderpeerConn.addTrack(track, localStream);
  });

  SenderpeerConn.ontrack = function (event) {
    document.getElementById("remote-video").srcObject = event.streams[0];
  };

  document.getElementById("remote-video").play();

  SenderpeerConn.onicecandidate = (e) => {
    if (e.candidate == null) return;
    // console.log("sender")
    let Sendercandidate = new RTCIceCandidate(e.candidate);
    SenderpeerConn.addIceCandidate(Sendercandidate);
    sendData({
      type: "store_candidate",
      candidate: Sendercandidate,
    });
  };
  createAndSendOffer();
  $(".phone-home-container").prop("disabled", true);
  $.post("https://qb-phone/startCallId", JSON.stringify({ id: callId }));
}

async function createAndSendOffer() {
  let candidateOffer = await SenderpeerConn.createOffer();
  await SenderpeerConn.setLocalDescription(candidateOffer);
  let offerObject = {
    sdp: candidateOffer.sdp,
    type: candidateOffer.type,
  };

  sendData({
    type: "store_offer",
    offer: offerObject,
  });
}


function stopCall() {
  $(".phone-home-container").prop("disabled", false);
  $.post("https://qb-phone/closeCam");
  $(".phone-call-videocall").css("display", "none")
  $(".phone-call-ongoing").css("display", "none")
  $(".phone-currentcall-container").css("display", "block")
  let video = document.getElementById("remote-video");
  $("#phone-call-ongoing-videocall").css("background-color", "#2ecc70e5")
  $("#phone-call-ongoing-videocall").attr("onClick", "startVideCalls()")
  QB.Phone.Animations.TopSlideDown('.phone-application-container', 400, -160);
  QB.Phone.Functions.ToggleApp("phone-call", "none");
  if (streaming) {
    $("#vaid-video").css("display", "none")
    $.post(
      "https://qb-phone/deletServerUser");
    $.post(
      "https://qb-phone/stopVideoCall",
      JSON.stringify({ serverId: serverId, callId: callId })
    );
    streaming = false;
    sender = false;
    serverId = null
    callId = null
    SenderpeerConn.close();
    MainRender.stop();
  } else if (watching) {
    $.post(
      "https://qb-phone/stopVideoCall",
      JSON.stringify({ callId: callerId })
    );
    watching = false;
    sender = false;
    serverId = null
    callId = null
    peerConn.close();
  }
  MainRender.stop();
  video.pause();
  video.srcObject = null;
}

window.addEventListener("message", function (e) {
  const message = e.data;
  message.type == "sendData"
    ? ListenerServerData(message.data)
    : message.type == "answer"
      ? ($("#phone-call-ongoing-videocall").attr("onClick", "joinCall()") , $("#phone-call-ongoing-videocall").css("background-color", "green"),
        (serverId = message.serverId), (callerId = message.callerId)) :
      message.type == "stopCall" && stopCall();
});

function ListenerServerData(data) {
  sender ? handleSignallingDataSender(data) : handleSignallingData(data);
}


function swpCam() {
  $.post("https://qb-phone/swapCam");
}
