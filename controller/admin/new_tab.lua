local fs=require "nixio.fs"

module("luci.controller.admin.new_tab",package.seeall)

function index()
	entry({"admin","new_tab"},firstchild(),"New Tab",30).dependent=false
	entry({"admin","new_tab","tab_from_cbi"},cbi("admin_myapp/cbi_tab"),"Cbi Tab",1)
	entry({"admin","new_tab","tab_from_view"},template("admin_myapp/view_tab"),"View Tab",2)
	entry({"admin","new_tab","action_counter"},call("counter"),_("Click here"),3).leaf=true
	entry({"admin","new_tab","reboot"},cbi("admin_myapp/reboot"),_("Reboot"),4)
	entry({"admin","new_tab","get_user"},call("getuser"),_("Show User"),5)
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

function getuser()
	sql=require "luasql.mysql"
	local env = sql.mysql()
	local conn = env:connect('test','root','5238222','127.0.0.1',3306)

	cursor,errorInfo=conn:execute([[select * from user;]])

	row=cursor:fetch({},"a")
	while row do
		luci.http.write(string.format("Id: %s, Name: %s",row.id,row.username))
		row=cursor:fetch(row,"a")
	end
	cursor:close()
	conn:close()
	env:close()
end
