# Factorio-Zooming-Reinvented
Factorio mod that improves zooming controls


# Short description

This mod allows to heavily customise the zooming behaviour, in particular it allows to:

* change how far you can zoom out (and still see the world)
* change how aggressive the zooming is (equivalent to changing mouse wheel sensitivity)
* re-open a map at the location where it was closed
* zoom in or out instantly with a single key stroke (or mouse wheel move)

See homepage/mod portal/readme for a full explanation of how this mod works. Please report any bugs and usability issues you find to help make this mod better - your feedback is much appreciated.


# How is this mod different from other mods that allow to zoom out farther than the base game?

This mod **replaces** the base game's zooming behaviour to make the user experience as natural as possible (given the severe restrictions of the modding API). There is no extra GUI buttons, there is no extra keyboard shortcuts, and it doesn't require the map to be closed - there is just the mouse wheel that you are already used to. Also, this mod does much better job at preventing the sudden zoom level changes when using different controls. Finally, this mod adds a lot of customisable settings so you can tailor them to your needs.


# 'Last known map position' - what is it and how do I eat it?

Last known map position is where this mod thinks your map position is. This is primarily used when zooming out in the map view. Due to various restrictions/lacking in the modding API, this might occasionally go out of sync - if this happens, you will experience sudden map position change. See known issues below for more details.

There are certain actions that can cause that desync which can be detected by the mod. That's what 'Disable map zoom out after map move' mod setting is for - if you were to experience non-user-friendly behaviour of map jumping to another location, it will simply not allow you to zoom out instead. To be able to zoom out again, you can either use 'Enable zoom out' control, you can do something that will update last known map position or something that will sync the map position - e.g. use 'Quick zoom in' (which opens a map at last known map position) or 'Quick zoom out'.

Last known map position is updated when you:

* open a map using 'Toggle world map' control (default: M)
* select any object in the world (by hovering with your mouse cursor over it), while in the 'zoom to world' view
* use Artillery targeting remote
* use Binoculars
* create, modify or delete a map tag


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
* Enable zoom out - re-enables zooming out, if you are playing with 'Disable map zoom out after map move' selected and want to zoom out regardless of whether the map jumps to another location.

Finally, it adds a Binoculars item to allow to quickly zoom in to world from the map. See known issues below for an explanation why this item exists at all.

![Binoculars](https://raw.githubusercontent.com/Jarcionek/Factorio-Zooming-Reinvented/master/screenshots/binoculars-screenshot.png)


# Customisation

![Mod settings](https://raw.githubusercontent.com/Jarcionek/Factorio-Zooming-Reinvented/master/screenshots/mod-settings.png)

* Zoom sensitivity - defines how big is the change when zooming in or out. Doesn't apply to zooming in on the map (unless in 'zoom to world' view). The current zoom level will be multiplied or divided by this value when you zoom in or out. Base game's value is about 1.1 when the map is closed and about 1.25 when the map is open (regardless of whether it is in the 'zoom to world' view or in the map view).
* Max world zoom out level - defines how far you can zoom out and still see the world. In the player view it defines maximum zoom out, in the map it defines when the 'zoom to world' view switches back to the map view. Base game's value is about 0.4.
* Default map zoom level - defines at what zoom level the map opens. Base game's value is about 0.0313. Note that map labels disappear at zoom level below 0.0157.
* 'Quick zoom out' map zoom level - defines at what zoom level the map opens when using 'Quick zoom out'. Note that map labels disappear at zoom level below 0.0157.
* Binoculars zoom level - defines at what zoom level the map opens when using the Binoculars item.
* Auto equip Binoculars - when 'Quick zoom out' is used, Binoculars will be automatically put in your hand. If you don't have Binoculars in your inventory, they will be given to you for free!
* Enable Binoculars double-action - if enabled, when using Binoculars in the map view and the labels on the map are not visible, Binoculars will first zoom in only enough to show the map labels. Using them again will zoom in to the configured 'Binoculars zoom level'.
* Disable map zoom out after map move - defines whether to disable map zooming out after the map position has changed (by dragging, using move controls or zooming in). This is to prevent sudden map position changes when zooming out (see known issues for explanation why this happens). If this option is selected, after you move the map, the only way to zoom out is to close and open the map again, use 'Quick zoom out' or use 'Enable zoom out'.


# Planned features

* Make position of 'Quick zoom out' configurable - center of the map (current behaviour), player position or last known map position.
* Make 'Toggle world map' position configurable - center of the map, player position (current behaviour) or last known map position.
* Add Binoculars auto trash so that they don't waste an inventory slot.
* Add a shortcut to get Binoculars (and remove the recipe) so that they can be obtained easily without requiring any items and empty crafting queue (and can be obtained without enabling 'Auto equip Binoculars' mod setting after the recipe is removed).
* Remember the zoom level when players open a map and restore it when player closes a map.


# Known Issues

### Zooming in while in the map view does not respect 'Zoom sensitivity' and 'Max world zoom out' mod settings

This is due to limitations in the modding API. It is not possible for a script to just zoom in the map in its current position, the only function available is to set it to a specific position and a zoom level. However, it is not possible to get the current map's position. Also, it is not possible to get a position of the mouse pointer, hence the mod is not be able to zoom in towards it. Finally, opening the 'zoom to world' view also requires to provide a position and a zoom level. Therefore, the only reasonable option was to leave the zooming in while in the map as it is in the base game.

As a workaround, you can use the Binoculars item. Note that it can only be used within the artillery range. Although it behaves like an artillery remote, don't worry - artillery will not fire at that location.

### zooming out in the map view causes the map to jump to another location

Because of all the limitations listed above, this mod keeps track of the last entity you selected (i.e. hovered over) and assumes that this is where the map is. If you zoom in to see the world and hover over some buildings (which usually happens all the time, without you even realising it) and then just zoom out to see more world, this works reasonably well. The existing modding API doesn't offer any functionality that could allow to address other use cases.

This can be caused by:

* moving a map (whether with WSAD controls or by dragging)
* clicking on the minimap to open a map
* clicking on the alert
* opening the map from the train GUI

As a workaround for the first case, you might want to disable 'map zoom out after map move' in the Mod Settings. Then the only way to zoom out is to reopen the map, use 'Quick zoom out' or zoom in to the 'zoom to world' view and hover over some object - this will update last known map position and allow to zoom out again. You can also use 'Enable zoom out' control if you don't mind the map position change.

Other three issues unfortunately cannot be addressed with the existing modding API. I have raised a [modding interface request](https://forums.factorio.com/viewtopic.php?f=28&t=69156) that would allow to address these issues.

### 'Quick zoom in' and 'Quick zoom out' controls are not assigned to the mouse wheel by default

Apparently, the scripts are not allowed to set the control to the mouse wheel, but luckily you can do it yourself!


# Known Bugs (to be addressed)

* Last known map position is not updated when player hovers over an object in the world while holding a blueprint in the hand
* Auto equipping Binoculars does not reserve an inventory slot for them
* First zoom in/out after loading the game causes a big zoom level change


# Credits

Graphics come from http://clipart-library.com/


# [Changelog](https://raw.githubusercontent.com/Jarcionek/Factorio-Zooming-Reinvented/master/changelog.txt)
