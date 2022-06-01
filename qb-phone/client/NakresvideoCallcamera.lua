local slf = true
local cam = false

RegisterNUICallback("openCam", function()
    selfie(true)
	cam = true
    CreateMobilePhone(2)
    CellCamActivate(true, true)
    startStopVideoCallAnim()
	while cam do
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()
			EnableControlAction(0, 1, false)
			EnableControlAction(0, 2, false)
			Citizen.Wait(0)
	end
end)

RegisterNUICallback("closeCam", function()
    startStopVideoCallAnim()
	cam = false
    CellCamActivate(false, false)
    DestroyMobilePhone()
	local ped = PlayerPedId()
	if not IsEntityPlayingAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3) then
		LoadAnimation(PhoneData.AnimationData.lib)
		TaskPlayAnim(ped, PhoneData.AnimationData.lib, PhoneData.AnimationData.anim, 3.0, 3.0, -1, 50, 0, false, false, false)
	end
end)

RegisterNUICallback("swapCam", function()
    slf = not slf
    selfie(slf)
end)

function selfie(boolean)
    Citizen.InvokeNative(0x2491A93618B7D838, boolean) -- Selfie modu
end
