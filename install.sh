# prepare zip file
mkdir ZoomingReinvented_1.1.0
cp README.md ZoomingReinvented_1.1.0
cp LICENSE ZoomingReinvented_1.1.0
cp -R src/* ZoomingReinvented_1.1.0
zip -r ZoomingReinvented_1.1.0{.zip,}

# move zip to factorio mods folder (overriding existing one if present)
mv ZoomingReinvented_1.1.0.zip "/cygdrive/c/Users/${USER}/AppData/Roaming/Factorio/mods"

# cleanup
rm -r ZoomingReinvented_1.1.0
