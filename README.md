## Pix-Locker-AHK
Lock your computer and take a picture of intruders. When this script is activated, any inputs (mouse or keyboard) will trigger the integrated camera. It will take a picture, save it, and lock any further use of the inputs.
This script was done by iDream3r


### Requirments
Works with Windows.
To use it you'll need to download and instal AutoHotkey.

__IMPORTANT__ : You'll need to use the __GDI+ library__. Place it by default in the same directory as the script. If you have it elsewhere or if you already have it, you should edit the path in the .ahk file.

__IMPORTANT__ : To use the Microsoft integrated camera you'll need to create a shortcut of the camera application and place it in a dedicated directory. By default the script use __"C:\WinApps\Cam"__, but you can edit it in the .ahk file.
__HOW TO__ : You can create a shortcut of the camera application by clicking on the Windows icon in your toolbar, searching for "Camera" and dragging the icon on your desktop. Then create a new folder in "C:\" call it "WinApps" and rename the shortcut "Cam" (for a better compatibility with all languages).
You should have "C:\WinApps\Cam"


### How to use

Use __MENU+L__ to activate the locker. A MsgBox will appear.

Use __MENU+L__ again to deactivate the locker. It will also unlock the inputs. A MsgBox will appear.

Use __MENU+X__ to exit the script.

Note : Be carefull if you change the HotKeys, most aren't recognized when BlockInput is on.


### How it run

With this you can protect your computer from intruders, and even take a pictures of them.
When this script is activated, any inputs (mouse or keyboard) will trigger the integrated Microsoft camera. It will take a picture, save it in the previous folder of the script directory with a date/hour name in .png, and then lock any further use of the inputs until deactivated.


### Security Concern

Please note that to activate BlockInput (the command to lock mouse and keyboard inputs), the script has to be run as Admin. An authorization request will appear when you'll launch the script. That mean that you must have the Admin rights on the computer, and that the camera and its dependencies will also be run as Admin.


### Upcoming features

Add an option to automatically hide the saved .png file. Why ? Because if an intruder restart your computer he can find and suppress the picture.
