# Factorio-Zooming-Reinvented
Factorio mod that improves zooming controls


# Short description

This mod allows to heavily customise the zooming behaviour, in particular it allows to:

* change how far you can zoom out (and still see the world)
* change how aggressive the zooming is (equivalent to changing mouse wheel sensitivity)
* change at what position and zoom level the map opens
* zoom in or out instantly with a single key stroke (or mouse wheel move)

Note: see homepage/mod portal/readme for a full explanation of how this mod works.

Your help is needed! Please report any bugs and usability issues you find to help make this mod better. Your feedback is much appreciated.


# How is this mod different from other mods that allow to zoom out farther than the base game?

This mod **replaces** the base game's zooming behaviour to make the user experience as natural as possible (given the severe restrictions of the modding API). There is no extra GUI buttons, there is no extra keyboard shortcuts, and it doesn't require the map to be closed - there is just the mouse wheel that you are already used to. Also, this mod does much better job at preventing the sudden zoom level changes when using different controls. Finally, this mod adds a lot of customisable settings so you can tailor them to your needs.


# Controls

![Controls](https://raw.githubusercontent.com/Jarcionek/Factorio-Zooming-Reinvented/master/screenshots/controls.png)

This mod changes the behaviour of the following game controls:

* Zoom in - disabled (using control assigned to it will be ignored)
* Zoom out - disabled (using control assigned to it will be ignored)
* Alternative zoom in - overridden, with the exception of the map view (see known issues below)
* Alternative zoom out - overridden
* Toggle world map - overridden

Furthermore, it adds the following controls:

* Quick zoom in - opens a map in the 'zoom to world' view, fully zoomed out, at the last known map position. This can be used to:
    1. Zoom back in to the world after you accidentally zoomed out too much and got switched to the map view.
    2. Reopen a map at the last known map position after you closed it.
    3. Zoom out fully if you are already in 'zoom to world' view. Additionally, if you select an object in the world by hovering over it, the map will get centered on this object.
* Quick zoom out - opens a map in the map view at the configured zoom level at the centre of the map

Finally, it adds a Binoculars item to allow to quickly zoom in to world from the map. See known issues below for an explanation why this item exists at all.

![Binoculars](https://raw.githubusercontent.com/Jarcionek/Factorio-Zooming-Reinvented/master/screenshots/binoculars-screenshot.png)


# Customisation

![Mod settings](https://raw.githubusercontent.com/Jarcionek/Factorio-Zooming-Reinvented/master/screenshots/mod-settings.png)

* Zoom sensitivity - defines how big is the change when zooming in or out. Doesn't apply to zooming in on the map (unless in zoom to world view). Base game's value is about 1.1 when the map is closed and about 1.25 when the map is open (regardless of whether it is in a zoom to world view or in a map view).
* Max world zoom out level - defines how far you can zoom out and still see the world. In player view it defines maximum zoom out, in the map it defines when zoom to world view switches back to map view. Base game's value is about 0.4.
* Default map zoom level - defines at what zoom level the map opens. Base game's value is about 0.0313. Note that map labels disappear at zoom level below 0.0157.
* 'Quick zoom out' map zoom level - defines at what zoom level the map opens when using 'Quick zoom out'. Note that map labels disappear at zoom level below 0.0157.
* Binoculars zoom level - defines at what zoom level the map opens when using Binoculars item.
* Enable Binoculars double-action - if enabled, when using Binoculars in the map view and the labels on the map are not visible, Binoculars will first zoom in only enough to show the map labels. Using them again will zoom in to the configured 'Binoculars zoom level'.
* Disable map zoom out after map move - defines whether to disable map zooming out after the map position has changed (by dragging, using move controls or zooming in). This to prevent sudden map position changes when zooming out (see known issues for explanation why this happens). If this option is selected, after you move the map, the only way to zoom out is to close and open the map again or use 'Quick zoom out'.


# Known Issues

### Zooming in while in the map view does not respect "Zoom sensitivity" and "Max world zoom out" mod settings.

This is due to limitations in the modding API. It is not possible for a script to just zoom in the map in its current position, the only function available is to set it to a specific position and zoom level. However, it is not possible to get the current map's position. Also, it is not possible to get a position of the mouse pointer, hence the script would not be able to zoom in towards it. Finally, opening a zoom to world view also requires to provide a position and a zoom level. Therefore, the only reasonable option was to leave the zooming in while in the map as it is in the base game.

As a workaround, you can use Binoculars item. Note that it can only be used within artillery range. Although it behaves like an artillery remote, don't worry - artillery will not fire at that location.

### After moving the map (in the map view), zooming out causes the map to jump to another location

Because of all the limitations listed above, this mod keeps track of the last entity you selected (i.e. hovered over) and assumes that this is where the map is. If you zoom in to see the world and hover over some buildings (which usually happens all the time, without you even realising it) and then just zoom out to see more world, this works reasonably well. The existing modding API doesn't offer any functionality that could allow to address other use cases.

As a workaround, you might want to disable zooming out on the map after dragging in the Mod Settings. Then the only way to zoom out is to (re)open the map or use 'Quick zoom out'.

### 'Quick zoom in' and 'Quick zoom out' controls are not assigned to the mouse wheel by default

Apparently, the scripts are not allowed to set the control to the mouse wheel, but luckily you can do it yourself!


# Known Bugs (to be addressed)

* After opening a map by clicking on the minimap and zooming out, the map jumps to another location
* After opening a map by clicking on the "Open this location in map." in the locomotive GUI and zooming out, the map jumps to another location


# Credits

Graphics come from http://clipart-library.com/


# [Changelog](https://raw.githubusercontent.com/Jarcionek/Factorio-Zooming-Reinvented/master/changelog.txt)
