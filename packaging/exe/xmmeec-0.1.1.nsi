; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "XMMEEC"
!define PRODUCT_VERSION "0.1.1"
!define PRODUCT_PUBLISHER "Pozsar Zsolt"
!define PRODUCT_WEB_SITE "http://www.szerafingomba.hu/softwares/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\xmmeec.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Uninstaller pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "$(MUILicense)" 
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_FINISHPAGE_RUN "$INSTDIR\xmmeec.exe"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\documents\readme.txt"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Hungarian"

; License Language
LicenseLangString MUILicense ${LANG_ENGLISH} "xmmeec\licence.txt"
LicenseLangString MUILicense ${LANG_HUNGARIAN} "xmmeec\licence.txt"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "xmmeec-0.1.1-win32.exe"
InstallDir "$PROGRAMFILES\XMMEEC"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Section "Main files" SEC01
  SetOutPath "$INSTDIR\documents"
  SetOverwrite try
  File "xmmeec\documents\authors.txt"
  File "xmmeec\documents\changelog.txt"
  File "xmmeec\documents\install.txt"
  File "xmmeec\documents\readme.txt"
  File "xmmeec\documents\version.txt"
  SetOutPath "$INSTDIR\settings"
  SetOverwrite try
  File "xmmeec\settings\xmmeec.ini"
  SetOutPath "$INSTDIR"
  File "xmmeec\xmmeec.exe"
  File "xmmeec\licence.txt"
  File "xmmeec\readme.txt"
  CreateShortCut "$DESKTOP\XMMEEC.lnk" "$INSTDIR\xmmeec.exe"
  CreateDirectory "$SMPROGRAMS\XMMEEC"
  CreateShortCut "$SMPROGRAMS\XMMEEC\XMMEEC.lnk" "$INSTDIR\xmmeec.exe"
SectionEnd

Section "Translate HU" SEC02
  SetOutPath "$INSTDIR\languages\hu"
  File "xmmeec\languages\hu\xmmeec.mo"
  File "xmmeec\languages\hu\xmmeec.po"
  SetOutPath "$INSTDIR\languages"
  File "xmmeec\languages\xmmeec.pot"
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  CreateDirectory "$SMPROGRAMS\XMMEEC"
  CreateShortCut "$SMPROGRAMS\XMMEEC\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\xmmeec.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\xmmeec.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
  LangString DESC_Section1 ${LANG_ENGLISH} "Required files"
  LangString DESC_Section2 ${LANG_ENGLISH} "Hungarian translate"
  LangString DESC_Section1 ${LANG_HUNGARIAN} "Kötelező állományok"
  LangString DESC_Section2 ${LANG_HUNGARIAN} "Magyar fordítás"
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} $(DESC_Section1)
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} $(DESC_Section2)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

; Section uninstall
  Function un.onInit
  !insertmacro MUI_UNGETLANGUAGE
  FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\readme.txt"
  Delete "$INSTDIR\licence.txt"
  Delete "$INSTDIR\xmmeec.exe"
  Delete "$INSTDIR\settings\xmmeec.ini"
  Delete "$INSTDIR\languages\xmmeec.pot"
  Delete "$INSTDIR\languages\hu\xmmeec.po"
  Delete "$INSTDIR\languages\hu\xmmeec.mo"
  Delete "$INSTDIR\documents\authors.txt"
  Delete "$INSTDIR\documents\changelog.txt"
  Delete "$INSTDIR\documents\install.txt"
  Delete "$INSTDIR\documents\readme.txt"
  Delete "$INSTDIR\documents\version.txt"

  Delete "$SMPROGRAMS\XMMEEC\Uninstall.lnk"
  Delete "$DESKTOP\XMMEEC.lnk"
  Delete "$SMPROGRAMS\XMMEEC\XMMEEC.lnk"

  RMDir "$SMPROGRAMS\XMMEEC"
  RMDir "$INSTDIR\languages\hu"
  RMDir "$INSTDIR\languages"
  RMDir "$INSTDIR\documents"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd
