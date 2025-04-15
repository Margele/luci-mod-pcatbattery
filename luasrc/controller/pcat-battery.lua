module("luci.controller.pcat-battery", package.seeall)

local fs = require "nixio.fs"

function index()
    local page

	page = entry({"admin", "services", "pcat-battery"}, call("action_info"))
	page = entry({"admin", "services", "pcat-battery", "status"}, call("action_battery"))
end

function action_info()
    local info = {
        version = "1.0.0",
        author  = "Shirona"
    }

    luci.http.prepare_content("application/json")
    luci.http.write_json(info)
end

function action_battery()
    luci.http.prepare_content("application/json")

	if not fs.access("/run/state/namespaces/Battery/OnBattery") then
        local failed_response = {
            status = 0
        }
    
        luci.http.write_json(failed_response)
        return
    end

    local battery = luci.sys.exec("awk '{printf \"%.2f\", $1}' /run/state/namespaces/Battery/ChargePercentage").."%"
    local voltage = luci.sys.exec("awk '{printf \"%.0f\", $1/1000}' /run/state/namespaces/Battery/Voltage").."mV"

    local charging = luci.i18n.translate("No")
    if string.find(luci.sys.exec("cat /run/state/namespaces/Battery/OnBattery"), "1") == nil then
        charging = luci.i18n.translate("Yes")
    end

    local photonicat = {
        status   = 1,
        battery  = battery,
        voltage  = voltage,
        charging = charging
    }

    luci.http.write_json(photonicat)
end
