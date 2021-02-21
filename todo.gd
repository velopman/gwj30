# Godot Wild Jam 30
# theme: Heartbeat
# wildcards: Flattery*

# circulation game
# 	control blood flow, removing blockages, keeping all limbs alive
# 	if a blockage remains for a certain period of time, limbs will degrade,
#		needing to be removed
# 	heart rate that needs to stay within a health level
#	score that goes up based on a limb multipler, so more limbs = higher score
#	blockages increase in rate over time

# nodes linked list
# - heart
# - veins
# - potenital blockage
# -


# heart -> veins -> potential blockage -> normal path / blocked path

#  heart
#	- outgoing_nodes
#	- beat()
#
# circulation_node
#  veins
#	- outgoing_node
#	- flow()
#
#  blockage
#	- default_node
#	- blocked_node
#	- block()
#	- unblock()
#	- flow()


# Systems
#	events -> blockages
#	heartrate -> optimal zone, outside of which limbs decay faster
#		head is a balloon that too much pumping will pop, not enough pumping will deflate
#	minigames -> clean pipe, patch pipe, unbend pipe


# [x] update all nodes to be blockable (veins)
# [x] remove blockage node
# [x] add limb controller that knows about all the elements and if one of them
#	is blocked (preventing two blockages in the same limb)
# [x] update blockage creator
# [x] add scoring system
# [x] add new pipe clean mini game
# [x] balance timings for blockages
# [x] add blockage handling to shader
# [x] add death handling to shader
# [x] fix rotation of right arm symbols
# [ ] add new pipe bend mini game
# [ ] add bpm mechanic to score / timer
# [x] add menu
# [ ] POLISH
# [x] add ui

# [x] Add limb health UI
# [x] Add score UI
# [x] Add end game UI
	# [x] Show score
	# [x] Add ability to restart
	# [x] Add ability to go to main menu
# [x] Add pause screen
	# [x] Add ability to restart
	# [x] Add ability to set settings
	# [x] Add ability to go to main menu
# [x] Add main menu
	# [x] Add title image
# [x] Add settings menu
# [ ] Create Itch page
	# [ ] Add icons
	# [ ] Ensure mobile support
	# [ ] Clean up assets and builds
	# [x] Title image
	# [ ] Screenshots
	# [ ] Background image
	# [ ] Style
# [ ] Change heart to dark when dead
# [x] Add sound effects to the buttons (hazard)
# [x] Add tutorial
	# [x] pump heart command
	# [x] fix hazard command
# [ ] Fix z index ordering of limbs once dead
# [x] Fix bug where hazard can't be clicked
# [ ] Fix audio sliders not matching settings
# [ ] Fix audio slider levels
# [ ] STRETCH: Add BPM mechanic
# [ ] STRETCH: Add third mini game
# [x] Create font: score, limb, lost, 0-9, %, :


