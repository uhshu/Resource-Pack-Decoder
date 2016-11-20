# ##################################
#   __                   __         __            
#  /__)_  _     _ _ _   /__)_ _ /  /  )_ _   _/_ _
# / ( (-_) ()(// ( (-  /   (/( /( /(_/(-( ()(/(-/ 
#
#     Decode your Minecraft Resource Pack.
#     Created by uhshu. Version 0.1.
# 
# ##################################

# Check if an input variable was specified, if not we ask.
if [ $# -eq 0 ]
then
	echo "INF : Please enter the version of which Minecraft you wish to decompile. "
	read input_variable
else
	input_variable=$1
fi

# Repeat the input back to the user (for debugging).
echo "INF : You've chosen to decompile $input_variable"

# Check that our variable's folder exsists, if not error..
if [ ! -d "/Users/$USER/Library/Application Support/minecraft/versions/$input_variable" ]; then
	echo "ERR : /Users/$USER/Library/Application Support/minecraft/versions/$input_variable doesnt exist!"
	exit
fi

# ##################################

# Duplicate the folder.
cp -a ~/Library/Application\ Support/minecraft/versions/$input_variable ~/Library/Application\ Support/minecraft/versions/$input_variable\ unarchive > /dev/null

# Duplicate our Jar file as a Zip.
cp -a ~/Library/Application\ Support/minecraft/versions/$input_variable\ unarchive/$input_variable.jar ~/Library/Application\ Support/minecraft/versions/$input_variable\ unarchive/$input_variable.zip

# Change directories to our archive.
cd ~/Library/Application\ Support/minecraft/versions/$input_variable\ unarchive/

# Unzip its contents.
unzip -o $input_variable.zip > /dev/null

# ##################################

# Check that our new folder doesnt already exsist.
if [ -d "/Users/$USER/Desktop/$input_variable ResourcePack" ]; then
	echo "ERR : ~/Desktop/$input_variable ResourcePack already exists!"
	exit
fi

# Create a directory to store our new content in.
mkdir -p ~/Desktop/$input_variable\ ResourcePack

# Create an assets folder then inside of that.
mkdir -p ~/Desktop/$input_variable\ ResourcePack/assets

# Copy the assets to said new foler.
cp -r ~/Library/Application\ Support/minecraft/versions/$input_variable\ unarchive/assets/minecraft/textures ~/Desktop/$input_variable\ ResourcePack/assets

# Make a mcmeta.info file.
{
	echo '{'
	echo '   "pack":{'
	echo '      "pack_format":3,'
	echo '      "description":"www.mcpack.co\nexample pack"'
	echo '   }'
	echo '}'
} > ~/Desktop/$input_variable\ ResourcePack/mcmeta.info

# ##################################

# Cleanup all of our dumb excess by removing the archive.
rm -r ~/Library/Application\ Support/minecraft/versions/$input_variable\ unarchive/
