module("luci.controller.mymodule",package.seeall)

function index()
	entry({"admin","network","mymodule"},template("http://www.baidu.com"))
end

