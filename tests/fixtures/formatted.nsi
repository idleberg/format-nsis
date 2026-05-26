!include "MUI2.nsh"

Name "Test Installer"
OutFile "test-setup.exe"
InstallDir "$PROGRAMFILES\Test"

Section "Main" SEC_MAIN
	SetOutPath "$INSTDIR"
	File "app.exe"
	File "readme.txt"

	CreateDirectory "$SMPROGRAMS\Test"
	CreateShortcut "$SMPROGRAMS\Test\App.lnk" "$INSTDIR\app.exe"

	WriteUninstaller "$INSTDIR\uninstall.exe"
SectionEnd

Section "Uninstall"
	Delete "$INSTDIR\app.exe"
	Delete "$INSTDIR\readme.txt"
	Delete "$INSTDIR\uninstall.exe"

	RMDir "$INSTDIR"
	Delete "$SMPROGRAMS\Test\App.lnk"
	RMDir "$SMPROGRAMS\Test"
SectionEnd

Function .onInit
	MessageBox MB_OK "Welcome to the installer!"
FunctionEnd
