![grab-landing-page](https://itzlarsen.xyz/uploads/images/u9m4xRqQkvQf3L7F4UFeJdxrw.gif)

# qb-phone
Phone for QB-Core Framework. Edited for a NP-Style look with a few extra things, This file has been edited with the changes noted

# NOTE
NP does NOT have a suggested contact feature, therefore the tab for that in the Phone app has been removed. You can use /p# to show your number in chat in a small radius around you, or manually input the contacts.

# Known Issues
if you call from a payphone without a cell phone there is no way to hang up the call. The other person has to hang up the call. After they do that then the phone UI is stuck on your screen

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>

## Dependencies
- [qb-core](https://github.com/QBCore-framework/qb-core)
- [qb-policejob](https://github.com/QBCore-framework/qb-policejob) - MEOS, handcuff check etc. 
- [qb-crypto](https://github.com/QBCore-framework/qb-crypto) - Crypto currency trading 
- [qb-lapraces](https://github.com/QBCore-framework/qb-lapraces) - Creating routes and racing 
- [qb-houses](https://github.com/QBCore-framework/qb-houses) - House and Key Management App
- [qb-garages](https://github.com/QBCore-framework/qb-garages) - For Garage App
- [qb-banking](https://github.com/QBCore-framework/qb-banking) - For Banking App
- [screenshot-basic](https://github.com/citizenfx/screenshot-basic) - For Taking Photos
- A Webhook for hosting photos (Discord or Imgur can provide this)
- Some sort of help app for your Help icon to function, just place your event for opening it in client.lua line 2403 
```
RegisterNUICallback('openHelp', function()  
    TriggerEvent('eventgoeshere')  <---------
end)
```


## Screenshots
![Home](https://cdn.discordapp.com/attachments/951493035173244999/951493181550243900/Screenshot_20.png)
![Messages](https://cdn.discordapp.com/attachments/951493035173244999/951493291243880499/Screenshot_21.png)
![Phone](https://cdn.discordapp.com/attachments/951493035173244999/951493463659122688/Screenshot_22.png)
![Settings](https://cdn.discordapp.com/attachments/951493035173244999/951493587072319498/Screenshot_23.png)
![MEOS](https://cdn.discordapp.com/attachments/951493035173244999/951495644563005470/Screenshot_35.png)
![Vehicles](https://cdn.discordapp.com/attachments/951493035173244999/951493876777103440/Screenshot_24.png)
![Email](https://cdn.discordapp.com/attachments/951493035173244999/951494010764140544/Screenshot_25.png)
![Advertisements](https://cdn.discordapp.com/attachments/951493035173244999/951494113788821624/Screenshot_26.png)
![Houses](https://cdn.discordapp.com/attachments/951493035173244999/951494238183505920/Screenshot_27.png)
![Services](https://cdn.discordapp.com/attachments/951493035173244999/951495770249502760/Screenshot_36.png)
![Racing](https://cdn.discordapp.com/attachments/951493035173244999/951495869289615400/Screenshot_37.png)
![Crypto](https://cdn.discordapp.com/attachments/951493035173244999/951494393397927956/Screenshot_28.png)
![Debt](https://cdn.discordapp.com/attachments/951493035173244999/951494527049433178/Screenshot_29.png)
![Wenmo](https://cdn.discordapp.com/attachments/951493035173244999/951494642019471370/Screenshot_30.png)
![Invoices](https://cdn.discordapp.com/attachments/951493035173244999/951494745648148560/Screenshot_31.png)
![Casino](https://cdn.discordapp.com/attachments/951493035173244999/951494899994329088/Screenshot_32.png)
![News](https://cdn.discordapp.com/attachments/951493035173244999/951495036351180860/Screenshot_33.png)
![Notepad](https://cdn.discordapp.com/attachments/951493035173244999/951495531153195038/Screenshot_34.png)
![Details](https://cdn.discordapp.com/attachments/951493035173244999/951496024885719111/Screenshot_38.png)
![JobCenter](https://cdn.discordapp.com/attachments/951493035173244999/951496191202451586/Screenshot_39.png)
![Employment](https://cdn.discordapp.com/attachments/951493035173244999/951496402008158328/Screenshot_40.png)
![Calculator](https://cdn.discordapp.com/attachments/951493035173244999/951496520073621544/Screenshot_41.png)

## Features
- Garages app to see your vehicle details
- Mails to inform the player
- Debt app for player invoices, Wenmo for quick bank transfers, Invoice app for legal invoices
- Racing app to create races
- MEOS app for police to search
- House app for house details and management
- Casino app for players to make bets and possibly multiply money
- News app for news postings
- Details tab for some player information at the palm of your hand
- Tweets save to database for recall on restarts, edit how long they stay in config
- Notepad app to make and save notes
- Calculator app
- Job Center and Employment apps just like the NoPickle

## Installation
### Manual
- Download the script and put it in the `[qb]` directory.
- Import `qb-phone.sql` in your database
- Add a third paramater in your Functions.AddMoney and Functions.RemoveMoney which will be a reaosn for your "Wenmo" app to show why you sent or received money. To do this you search all of your files for these 2 functions and add a reason to it.. Ex: 
```
Player.Functions.AddMoney('bank', payment)
```
would then be
```
 Player.Functions.AddMoney('bank', payment, "paycheck")
 ```
- Add the following code to your server.cfg/resouces.cfg
```
ensure qb-core
ensure screenshot-basic
ensure qb-phone
ensure qb-policejob
ensure qb-crypto
ensure qb-lapraces
ensure qb-houses
ensure qb-garages
ensure qb-banking
```

## Setup Webhook in `server/main.lua` for photos
Set the following variable to your webhook (For example, a Discord channel or Imgur webhook)
### To use Discord:
- Right click on a channel dedicated for photos
- Click Edit Channel
- Click Integrations
- Click View Webhooks
- Click New Webhook
- Confirm channel
- Click Copy Webhook URL
- Paste into `WebHook` in `server/main.lua`
```
local WebHook = ""
```
## To fixed undefined reason in Wenmo
- Go to qb-core/server/player.lua
- Replace this
```
    self.Functions.AddMoney = function(moneytype, amount, reason)
        reason = reason or 'unknown'
        local moneytype = moneytype:lower()
        local amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if self.PlayerData.money[moneytype] then
            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype], true)
            else
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype])
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, false)
            return true
        end
        return false
    end
    self.Functions.RemoveMoney = function(moneytype, amount, reason)
        reason = reason or 'unknown'
        local moneytype = moneytype:lower()
        local amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if self.PlayerData.money[moneytype] then
            for _, mtype in pairs(QBCore.Config.Money.DontAllowMinus) do
                if mtype == moneytype then
                    if self.PlayerData.money[moneytype] - amount < 0 then
                        return false
                    end
                end
            end
            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype], true)
            else
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype])
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, true)
            if moneytype == 'bank' then
                TriggerClientEvent('qb-phone:client:RemoveBankMoney', self.PlayerData.source, amount)
            end
            return true
        end
        return false
    end
```
- To this
```
    self.Functions.AddMoney = function(moneytype, amount, reason)
        reason = reason or 'unknown'
        local moneytype = moneytype:lower()
        local amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if self.PlayerData.money[moneytype] then
            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype], true)
            else
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype])
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, false, reason)
            return true
        end
        return false
    end
    self.Functions.RemoveMoney = function(moneytype, amount, reason)
        reason = reason or 'unknown'
        local moneytype = moneytype:lower()
        local amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if self.PlayerData.money[moneytype] then
            for _, mtype in pairs(QBCore.Config.Money.DontAllowMinus) do
                if mtype == moneytype then
                    if self.PlayerData.money[moneytype] - amount < 0 then
                        return false
                    end
                end
            end
            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype], true)
            else
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype])
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, true, reason)
            if moneytype == 'bank' then
                TriggerClientEvent('qb-phone:client:RemoveBankMoney', self.PlayerData.source, amount)
            end
            return true
        end
        return false
    end
```

## Change your `qb-smallresources/server/logs.lua` with this for adver&twitter discord log
```
local QBCore = exports['qb-core']:GetCoreObject()
local Webhooks = {
    ['default'] = '',
    ['testwebhook'] = '',
    ['playermoney'] = '',
    ['playerinventory'] = '',
    ['robbing'] = '',
    ['cuffing'] = '',
    ['drop'] = '',
    ['trunk'] = '',
    ['stash'] = '',
    ['glovebox'] = '',
    ['banking'] = '',
    ['vehicleshop'] = '',
    ['vehicleupgrades'] = '',
    ['shops'] = '',
    ['dealers'] = '',
    ['storerobbery'] = '',
    ['bankrobbery'] = '',
    ['powerplants'] = '',
    ['death'] = '',
    ['joinleave'] = '',
    ['ooc'] = '',
    ['report'] = '',
    ['me'] = '',
    ['pmelding'] = '',
    ['112'] = '',
    ['bans'] = '',
    ['anticheat'] = '',
    ['weather'] = '',
    ['moneysafes'] = '',
    ['bennys'] = '',
    ['bossmenu'] = '',
    ['robbery'] = '',
    ['casino'] = '',
    ['traphouse'] = '',
    ['911'] = '',
    ['palert'] = '',
    ['house'] = '',
    ['discordia'] = '',
    ['twitter'] = '',
    ['adwert'] = ''
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
    ['twitterblue'] = 2061822
}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone, urls)        
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local url = urls or nil
        username = 'QB Logs'
        botname = 'QB Logs'
        avatar = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670'
        icon = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670'
    if name == 'twitter' then
        username = 'Twitter'
        botname = ''
        avatar = 'https://i.pinimg.com/736x/ee/af/9c/eeaf9ce3ab22ecb3904daea1b2eab04a.jpg'
    elseif name == 'discordia' then
        username = 'Discordia'
        botname = ''
        avatar = 'https://i.pinimg.com/originals/0d/8b/43/0d8b437a4c1c788f036590bc4b71ff55.png'
    elseif name == 'adwert' then
        username = 'Advertisements'
        botname = ''
        avatar = 'https://www.yellowpages.com.pg/wp-content/uploads/2021/09/yellow-logo-fav.png'
    end
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = botname,
                ['icon_url'] = icon,
            },
            ['image'] ={
                ['url'] = url
            }
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = username, avatar_url = avatar, embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = username, content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function(source, args)
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')

```
