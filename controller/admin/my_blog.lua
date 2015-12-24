module("luci.controller.admin.my_blog",package.seeall)

function index()
	entry({"admin","my_blog"},firstchild(),"Blog",30).dependent=false
	entry({"admin","my_blog","publish_blog"},template("admin_myapp/add_blog"),_("Publish Blog"),1)
	entry({"admin","my_blog","test_blog"},template("admin_myapp/test_blog"),_("Test"),2)
	entry({"admin","my_blog","show_blog"},template("admin_myapp/list_blog"),_("Show Blog"),3)
	entry({"admin","my_blog","view_blog"},call("blog_view"),_("View Blog"),4)
end

function blog_view()
	local viewId=luci.http.formvalue("view_id")
	luci.template.render("admin_myapp/view_blog",{view_id=view_id})
end

