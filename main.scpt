# By chris1111
#
# Copyright (c) 2021, chris1111. All Right Reserved
# Credit: Apple
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
# Version "1.0" by chris1111
# Vars

set theAction to button returned of (display dialog "
Welcome Create macOS Image and Restore Image

*****************************" with icon note buttons {"Quit", "Create macOS Image", "Restore Image"} cancel button "Quit" default button {"Create macOS Image"})
if theAction = "Restore Image" then
	
	--If Restore Image
	set the_command to quoted form of POSIX path of (path to resource "Restore-Helper" in directory "Scripts")
	do shell script the_command
end if
if theAction = "Create macOS Image" then
	
	--If Create macOS Image
	## Set use_terminal to true to run the script in a terminal
	set the_command to quoted form of POSIX path of (path to resource "Image-Helper" in directory "Scripts")
	set progress description to "Create Image 
Please wait. . . . ."
	delay 4
	
	set progress total steps to 3
	repeat with i from 1 to 4
		
		set progress completed steps to i
	end repeat
	do shell script the_command
	set progress description to "Image is create Done."
	delay 1
	activate me
	set all to paragraphs of (do shell script "ls /Volumes")
	set w to choose from list all with prompt " 
To continue, select the volume macOSInstaller then press the OK button
The volume will be renamed INSTAL-MEDIA and Create Install Media will proceed!" OK button name "OK" with multiple selections allowed
	if w is false then
		display dialog "Quit Installer " with icon 0 buttons {"EXIT"} default button {"EXIT"}
		return
	end if
	try
		
		repeat with teil in w
			do shell script "diskutil `diskutil list | awk '/ " & teil & "  / {print $NF}'`"
		end repeat
	end try
	set theName to "INSTAL-MEDIA"
	tell application "Finder"
		set name of disk w to theName
	end tell
	--If Continue
	set theAction to button returned of (display dialog "

Choose the location of your Install macOS.app" with icon note buttons {"Quit", "10.9 to 10.12", "10.13 to Monterey 12"} cancel button "Quit" default button {"10.13 to Monterey 12"})
	if theAction = "10.13 to Monterey 12" then
		--If 10.13 to Monterey 12
		display dialog "
Your choice is 10.13 to Monterey 12
Choose your Install OS X.app 
From macOS High Sierra to macOS Monterey" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
		
		set InstallOSX to choose file of type {"XLSX", "APPL"} default location (path to applications folder) with prompt "Choose your Install macOS.app"
		set OSXInstaller to POSIX path of InstallOSX
		
		delay 1
		set progress description to "Create Image Media for Deploy
======================================
The installation time is 2 to 3 min depending on the 
Install macOS.app
======================================"
		set progress total steps to 6
		
		set progress additional description to "Install macOS to the image"
		delay 1
		set progress completed steps to 1
		
		set progress additional description to "Install macOS to the image 20%"
		delay 1
		set progress completed steps to 2
		
		set progress additional description to "Install macOS 30%"
		delay 1
		set progress completed steps to 3
		
		set progress additional description to "Install macOS 40%"
		delay 1
		set progress completed steps to 4
		
		set progress additional description to "Install macOS Wait . . . . ."
		delay 1
		set progress completed steps to 5
		
		set cmd to "sudo \"" & OSXInstaller & "Contents/Resources/createinstallmedia\" --volume /Volumes/INSTAL-MEDIA --nointeraction "
		
		do shell script cmd with administrator privileges
		delay 1
		set progress completed steps to "Create Image Media Completed ➤  100%"
		delay 1
		display dialog "Create Image succesfully." with icon note buttons {"Done"} default button {"Done"} giving up after 10
		
		do shell script "Open /Volumes/Install*"
		tell application "Finder"
			if exists disk "Shared Support" then
				eject disk "Shared Support"
			end if
		end tell
		tell application "Finder"
			if exists disk "Shared Support 1" then
				eject disk "Shared Support 1"
			end if
		end tell
		
	else if theAction = "10.9 to 10.12" then
		
		--If 10.9 to 10.12
		display dialog "
10.9 to 10.12
Choose the location of your Install macOS.app
" with icon note buttons {"Quit", "Continue"} cancel button "Quit" default button {"Continue"}
		
		set InstallOSX to choose file of type {"XLSX", "APPL"} default location (path to applications folder) with prompt "Choose your Install macOS.app"
		set OSXInstaller to POSIX path of InstallOSX
		delay 1
		set progress description to "Create Image Media for Deploy
======================================
The installation time is 2 to 3 min depending on the 
Install macOS.app
======================================"
		set progress total steps to 3
		
		set progress additional description to "Install macOS to the image"
		delay 1
		set progress completed steps to 1
		
		set progress additional description to "Install macOS to the image"
		delay 1
		set progress completed steps to 2
		
		set progress additional description to "Install macOS Wait . . . . ."
		delay 1
		set progress completed steps to 3
		
		set cmd to "sudo \"" & OSXInstaller & "Contents/Resources/createinstallmedia\" --volume /Volumes/INSTAL-MEDIA --applicationpath \"" & OSXInstaller & "\" --nointeraction "
		
		do shell script cmd with administrator privileges
		delay 1
		set progress completed steps to "Create Image Media Completed ➤  100%"
		delay 1
		display dialog "Create Image succesfully." with icon note buttons {"Done"} default button {"Done"} giving up after 10
		do shell script "Open /Volumes/Install*"
		tell application "Finder"
			if exists disk "Shared Support" then
				eject disk "Shared Support"
			end if
		end tell
		tell application "Finder"
			if exists disk "Shared Support 1" then
				eject disk "Shared Support 1"
			end if
		end tell
		
	end if
end if

