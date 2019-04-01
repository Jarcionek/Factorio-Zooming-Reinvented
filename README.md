# Factorio-Zooming-Reinvented
Factorio mod that improves zooming controls


# Description

This mod allows to heavily customise the zooming behaviour, in particular it allows to:
* change how far you can zoom out (and still see the world)
* change how aggressive the zooming is (equivalent to changing mouse wheel sensitivity)
* change at what position and zoom level the map opens
* zoom in or out instantly with a single key stroke


# Known Issues

### Zooming in while in the map view does not respect Zoom sensitivity and Max world zoom out.

This is due to limitations in the modding API. It is not possible for a script to just zoom in the map in its current position, the only function available is to set it to a specific position and zoom level. However, it is not possible to get the current map's position. Also, it is not possible to get a position of the mouse pointer, hence the script would not be able to zoom in towards it. Finally, opening a zoom to world view also requires to provide a position and a zoom level. Therefore, the only reasonable option was to leave the zooming in while in the map as it is in the base game.


# Changelog

### 1.0.0 (pending)
* Initial release.
