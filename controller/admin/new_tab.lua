module("luci.controller.admin.new_tab",package.seeall)
function index()
	entry({"admin","new_tab"},firstchild(),"New Tab",30).dependent=false
	entry({"admin","new_tab","tab_from_cbi"},cbi("admin_myapp/cbi_tab"),"Cbi Tab",1)
	entry({"admin","new_tab","tab_from_view"},template("admin_myapp/view_tab"),"View Tab",2)
end
