# prepare zip file
mkdir ZoomingReinvented_1.2.2
cp README.md ZoomingReinvented_1.2.2
cp LICENSE ZoomingReinvented_1.2.2
cp changelog.txt ZoomingReinvented_1.2.2
cp -R src/* ZoomingReinvented_1.2.2
zip -r ZoomingReinvented_1.2.2{.zip,}

# move zip to factorio mods folder (overriding existing one if present)
mv ZoomingReinvented_1.2.2.zip "/cygdrive/c/Users/${USER}/AppData/Roaming/Factorio/mods"

# cleanup
rm -r ZoomingReinvented_1.2.2
