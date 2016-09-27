'+-----------------------------------------------------------------------------+
'| Power Supplies v0.4.1 * Power supply calculator                             |
'| Copyright (C) 2011-2016 Pozsar Zsolt <pozsarzs@gmail.com>                   |
'| mkshortcut.vbs                                                              |
'| Make shortcut                                                               |
'+-----------------------------------------------------------------------------+

set WshShell = WScript.CreateObject("WScript.Shell" )
set oShellLink = WshShell.CreateShortcut(Wscript.Arguments.Named("shortcut") & ".lnk")
oShellLink.TargetPath = Wscript.Arguments.Named("target")
oShellLink.WindowStyle = 1
oShellLink.Save

