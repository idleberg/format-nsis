!ifndef HELPER_NSH
!define HELPER_NSH

!macro CheckAdmin
	UserInfo::GetAccountType
	Pop $0
	${If} $0 != "admin"
		MessageBox MB_ICONSTOP "Administrator privileges required."
		Abort
	${EndIf}
!macroend
!endif
