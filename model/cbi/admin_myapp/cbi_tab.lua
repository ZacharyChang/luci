
m=Map("login",translate("Login Client"),translate("Please fill in the form below"))

s=m:section(TypedSection,"login","Part login of the form")

s.addremove=false

s.anonymous=true

enable=s:option(Flag,"enable",translate("Enable"))

name=s:option(Value,"username",translate("Username"))

pass=s:option(Value,"password",translate("Password"))
pass.password=true

domain=s:option(Value,"domain","Interfaces");

ifname=s:option(ListValue,"ifname",translate("Domain"))

for k,v in ipairs(luci.sys.net.devices()) do
	if v ~='lo' then
		ifname:value(v)
	end
end

s.optional=false;
s.rmempty=false;

local apply=luci.http.formvalue("cbi.apply")
if apply then
	luci.sys.exec("/etc/init.d/login start")
end

return m
