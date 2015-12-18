m=Map("button",translate("Reboot"),translate("reboot system"))

s=m:section(TypedSection,"reboot","Part reboot of the form")
s.addremove=false
s.anonymous=true

button=s:option(Button,"_button","Reboot")
button.inputtitle=translate("Reboot")
button.inputstyle="apply"

function button.write(self,section,value)
	s:option(DummyValue,"Reboot","reboot...")
	luci.sys.call("reboot")
end

s.optional=false
s.rmempty=false

return m
