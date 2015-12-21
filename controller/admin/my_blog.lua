module("luci.controller.admin.my_blog",package.seeall)
--[[
function index()
	entry({"admin","new_tab"},firstchild(),"New Tab",30).dependent=false
	entry({"admin","new_tab","tab_from_cbi"},cbi("admin_myapp/cbi_tab"),"Cbi Tab",1)
	entry({"admin","new_tab","tab_from_view"},template("admin_myapp/view_tab"),"View Tab",2)
	entry({"admin","new_tab","action_counter"},call("counter"),_("Click here"),3).leaf=true
	entry({"admin","new_tab","reboot"},cbi("admin_myapp/reboot"),_("Reboot"),4)
	entry({"admin","new_tab","get_user"},call("getuser"),_("Show User"),5)
	entry({"admin","new_tab","db_config"},cbi("admin_myapp/db_conf"),_("database config"),6)
end
]]

function index()
	entry({"admin","my_blog"},firstchild(),"Blog",30).dependent=false
	entry({"admin","my_blog","publish_blog"},template("admin_myapp/add_blog"),"Publish Blog",1)
	entry({"admin","my_blog","test_blog"},template("admin_myapp/test_blog"),"Test",2)
end
