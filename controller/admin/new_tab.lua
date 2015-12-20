local fs=require "nixio.fs"

module("luci.controller.admin.new_tab",package.seeall)

function index()
	entry({"admin","new_tab"},firstchild(),"New Tab",30).dependent=false
	entry({"admin","new_tab","tab_from_cbi"},cbi("admin_myapp/cbi_tab"),"Cbi Tab",1)
	entry({"admin","new_tab","tab_from_view"},template("admin_myapp/view_tab"),"View Tab",2)
	entry({"admin","new_tab","action_counter"},call("counter"),_("Click here"),3).leaf=true
	entry({"admin","new_tab","reboot"},cbi("admin_myapp/reboot"),_("Reboot"),4)
	entry({"admin","new_tab","get_user"},call("getuser"),_("Show User"),5)
	entry({"admin","new_tab","db_config"},cbi("admin_myapp/db_conf"),_("database config"),6)
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
	local file=io.open("/etc/config/db_conf")
	local tab={}

	-- 读取配置文件中值
	for line in file:lines() do
		local a,b=string.find(line,"option")
		if b then
			local c,d=string.find(line,"%w+%s+",b+2)
			-- 字符串长度
			local e=string.len(line)
			-- 分别截取key和value，存入表中
			key=string.sub(line,c,d-1)
			value=string.sub(line,d+2,e-1)
			tab[key]=value
		end
	end

	local env = sql.mysql()
	local conn = env:connect(tab['database'],tab['name'],tab['password'],tab['ip'],tonumber(tab['port']))

	cursor,errorInfo=conn:execute([[select * from user;]])

	row=cursor:fetch({},"a")
	while row do
		luci.http.write(string.format("Id: %s, Name: %s<br>",row.id,row.username))
		row=cursor:fetch(row,"a")
	end
	cursor:close()
	conn:close()
	env:close()
end
