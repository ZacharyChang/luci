local fs=require "nixio.fs"

module("luci.controller.admin.new_tab",package.seeall)

function index()
	entry({"admin","new_tab"},firstchild(),"New Tab",30).dependent=false
	entry({"admin","new_tab","tab_from_cbi"},cbi("admin_myapp/cbi_tab"),"Cbi Tab",1)
	entry({"admin","new_tab","tab_from_view"},template("admin_myapp/view_tab"),"View Tab",2)
	entry({"admin","new_tab","action_counter"},call("counter"),_("Click here"),3).leaf=true
end

function counter()
	local count=0
	if fs.access("/var/run/test") then
		count=tonumber((fs.readfile("/var/run/test")))
	end
	count=count+1
	fs.writefile("/var/run/test",string.format("%d\n",count))
	luci.http.write(tostring(count))
	return
end
