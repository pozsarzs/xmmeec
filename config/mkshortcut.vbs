'+-----------------------------------------------------------------------------+
'| XMMEEC v0.3 * Environment characteristic editor for MMxD devices            |
'| Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>        |
'| mkshortcut.vbs                                                              |
'| Make shortcut                                                               |
'+-----------------------------------------------------------------------------+

set WshShell = WScript.CreateObject("WScript.Shell" )
set oShellLink = WshShell.CreateShortcut(Wscript.Arguments.Named("shortcut") & ".lnk")
oShellLink.TargetPath = Wscript.Arguments.Named("target")
oShellLink.WindowStyle = 1
oShellLink.Save

