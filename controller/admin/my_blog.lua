module("luci.controller.admin.my_blog",package.seeall)

function index()
	entry({"admin","my_blog"},firstchild(),"Blog",30).dependent=false
	entry({"admin","my_blog","publish_blog"},template("admin_myapp/add_blog"),_("Publish Blog"),1)
	entry({"admin","my_blog","show_blog"},template("admin_myapp/list_blog"),_("Show Blog"),2)
	entry({"admin","my_blog","view_blog"},call("blog_view"),_("View Blog"),3)
	entry({"admin","my_blog","update_blog"},call("blog_update"),_("Update Blog"),4)
	entry({"admin","my_blog","remove_blog"},call("blog_remove"),_("Remove Blog"),5)
end

function blog_view()
	local viewId=luci.http.formvalue("view_id")
	if viewId then
		luci.template.render("admin_myapp/view_blog")
	else
		luci.template.render("admin_myapp/list_blog")
	end
end

function blog_update()
	local updateId=luci.http.formvalue("update_id")
	if updateId then
		luci.template.render("admin_myapp/update_blog")
	else
		luci.template.render("admin_myapp/list_blog")
	end
end

function blog_remove()
	local removeId=luci.http.formvalue("remove_id")
	if removeId then
		local sql=require "luasql.mysql"
		local env=sql.mysql()
		local conn=env:connect('test','root','5238222','127.0.0.1',3306)
		local str=string.format([[delete from blog where id=%s;]],removeId)
		local res=assert(conn:execute(str))
		conn:close()
		env:close()
	end
	luci.template.render("admin_myapp/list_blog")
end
