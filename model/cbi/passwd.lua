f=SimpleForm("password",translate("a_s_changepw"),translate("a_s_changepw1"))
pw1=f:field(Value,"pw1",translate("password"))
pw1.rmempty=false
pw2=f:field(Value,"pw2",translate("confirmation"))
pw2.rmempty=false

function pw2.validate(self,value,section)
	return pw1:formvalue(section)==value and value
end

function f.handle(self,state,data)
	if state==FORM_VALID then
		local stat=luci.sys.user.setpasswd("admin",data.pw1)==0
		if stat then
			f.message=translate("a_s_changepw_changed")
		else
			f.errmessage=translate("unknownerror")
		end
		
		data.pw1=nil
		data.pw2=nil
	end
	return true
end
return f
