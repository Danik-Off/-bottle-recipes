# Install dependencies
flatpak install -y com.usebottles.bottles
pip install --user bottles-cli

# Define variables
BOTTLE_NAME="Office-2016"
BOTTLE_PATH="$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/$BOTTLE_NAME"

# Create a new bottle
bottles-cli create "$BOTTLE_NAME" --environment Custom --runner caffe-9.7 --arch x86

# Set compatibility to Windows 7
bottles-cli override "$BOTTLE_NAME" --set-version win7

# Configure registry tweaks
REGISTRY_PATH="$BOTTLE_PATH/user.reg"
echo "\n[Software\\Wine\\Direct2D]\n\"max_version_factory\"=dword:00000000\n" >> "$REGISTRY_PATH"
echo "\n[Software\\Wine\\Direct3D]\n\"MaxVersionGL\"=dword:00030002\n" >> "$REGISTRY_PATH"

# Install necessary dependencies
WINEPREFIX="$BOTTLE_PATH" winetricks corefonts msxml6 msxml4 vcrun2005 vcrun2008 \
  vcrun2010 vcrun2012 vcrun2013 vcrun2019 msftedit riched20 riched30 msxml6 gdiplus \
  mspatcha dotnet20 dotnet40 mfc100 cjkfonts wsh57

# Enable virtual desktop emulation
echo "\n[Software\\Wine\\Explorer]\n\"Desktop\"=\"1920x1000\"\n" >> "$REGISTRY_PATH"

# Download and place WinSCard.dll
wget -O "$BOTTLE_PATH/drive_c/windows/system32/WinSCard.dll" https://example.com/path/to/WinSCard.dll

# Print completion message
echo "Setup complete. Run Bottles and install Office 2016 manually."
