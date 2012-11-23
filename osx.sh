#!/bin/bash

# Based on https://github.com/sapegin/dotfiles/blob/master/setup/osx.sh

COMPUTERNAME='Mac'
LOCALHOSTNAME='mac'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences → Sharing)
#sudo scutil --set ComputerName $COMPUTERNAME
#sudo scutil --set HostName $COMPUTERNAME
#sudo scutil --set LocalHostName $LOCALHOSTNAME
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $LOCALHOSTNAME

# Disable opening and closing window animations
#defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
# Commented out, as this is known to cause problems when saving files in
# Adobe Illustrator CS5 :(
#echo "0x08000100:0" > ~/.CFUserTextEncoding

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
#systemsetup -setrestartfreeze on

# Never go into computer sleep mode
#systemsetup -setcomputersleep Off > /dev/null

# Check for software updates daily, not just once per week
#defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Appearance: Graphite
defaults write -g AppleAquaColorVariant -int 6

# Highlight color: Blue
defaults write -g AppleHighlightColor -string '0.709800 0.835300 1.000000'

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
#defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Trackpad: swipe between pages with three fingers
#defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Disable “natural” (Lion-style) scrolling
#defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
#defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
#defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable access for assistive devices
#echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
#sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled
# TODO: avoid GUI password prompt somehow (http://apple.stackexchange.com/q/60476/4408)
#sudo osascript -e 'tell application "System Events" to set UI elements enabled to true'

# Use scroll gesture with the Ctrl (^) modifier key to zoom
#defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
#defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
#defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Disable press-and-hold for keys in favor of key repeat
#defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
#defaults write NSGlobalDomain KeyRepeat -int 0

# Don't illuminate built-in MacBook keyboard in low light
#defaults write com.apple.BezelServices kDim -bool false
# Turn off keyboard illumination when computer is not used for 5 minutes
#defaults write com.apple.BezelServices kDimTime -int 300

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en" "ru"
defaults write NSGlobalDomain AppleLocale -string "ru_RU@currency=RUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone; see `systemsetup -listtimezones` for other values
systemsetup -settimezone "Europe/Moscow" > /dev/null

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
#defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
#defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Enable HiDPI display modes (requires restart)
#sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
#defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
#defaults write com.apple.finder DisableAllAnimations -bool true

# Show icons for hard drives, servers, and removable media on the desktop
#defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
#defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
#defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
#defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: hide status bar
#defaults write com.apple.finder ShowStatusBar -bool false

# Finder: show path bar 
defaults write com.apple.finder ShowPathbar -boolean true

# Finder: allow text selection in Quick Look
#defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
#defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
#defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
#defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable disk image verification
#defaults write com.apple.frameworks.diskimages skip-verify -bool true
#defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
#defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show item info below icons on the desktop and in other icon views
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Increase grid spacing for icons on the desktop and in other icon views
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons on the desktop and in other icon views
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
#defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
#defaults write com.apple.finder EmptyTrashSecurely -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
#defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Finder: disable sounds 
#defaults write com.apple.finder FinderSounds -boolean false

# Show the ~/Library folder
chflags nohidden ~/Library

# Remove Dropbox’s green checkmark icons in Finder
#file=/Applications/Dropbox.app/Contents/Resources/check.icns
#[ -e "$file" ] && mv -f "$file" "$file.bak"
#unset file


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
#defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Allow hitting the Backspace key to go to the previous page in history
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
#defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Remove useless icons from Safari’s bookmarks bar
#defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Pro theme by default in Terminal.app
open "$HOME/devbox/themes/Solarized Dark.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded
defaults write com.apple.terminal "Default Window Settings" -string "Solarized Dark"
defaults write com.apple.terminal "Startup Window Settings" -string "Solarized Dark"

# Enable “focus follows mouse” for Terminal.app and all X11 apps
# i.e. hover over a window and start typing in it without clicking first
#defaults write com.apple.terminal FocusFollowsMouse -bool true
#defaults write org.x.X11 wm_ffm -bool true

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

# Allow installing user scripts via GitHub or Userscripts.org
#defaults write com.google.Chrome ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"
#defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"

###############################################################################
# Sublime Text 2                                                              #
###############################################################################

# Link Sublime Text 2 command line
#[ ! -d ~/bin ] && mkdir ~/bin
#ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl

###############################################################################
# Power                                                                       #
###############################################################################

# Battery

# Computer sleep: 10 min
#sudo pmset -b sleep 10

# Display sleep: 5 min
#sudo pmset -b displaysleep 5

# Put the hard disk(s) to sleep when possible: 10 min
#sudo pmset -b disksleep 10

# Slightly dim the display when using this power source
#sudo pmset -b lessbright 1

# Automatically reduce brightness before display goes to sleep
#sudo pmset -b halfdim 1

# Restart automatically if the computer freezes
#sudo pmset -b panicrestart 15

# Power Adapter

# Computer sleep: 30 min
#sudo pmset -c sleep 30

# Display sleep: 10 min
#sudo mset -c displaysleep 10

# Put the hard disk(s) to sleep when possible: 10 min
#sudo pmset -c disksleep 10

# Wake for network access
#sudo pmset -c womp 0

# Automatically reduce brightness before display goes to sleep
#sudo pmset -c halfdim 1

# Start up automatically after a power failure
#sudo pmset -c autorestart 1

# Restart automatically if the computer freezes
#sudo pmset -c panicrestart 15


echo "Done. Note that some of these changes require a logout/restart to take effect."