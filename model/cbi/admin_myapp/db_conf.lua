-- db_conf 对应/etc/config/db_conf文件
m=Map("db_conf",translate("Database Setting"),translate("Please set up the database configure."))

--这里的database对应/etc/config/db_conf文件中的config database
s=m:section(TypedSection,"database","Setting of the database")
s.addremove=false
s.anonymous=true


user=s:option(Value,"user",translate("User"))
pass=s:option(Value,"password",translate("Password"))
pass.password=true
ip=s:option(Value,"ip",translate("IP"))
port=s:option(Value,"port",translate("Port"))
database=s:option(Value,"database",translate("Database"))

s.optional=false
s.rmempty=false

return m
