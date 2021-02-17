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


# [ ] update all nodes to be blockable (veins)
# [ ] remove blockage node
# [ ] add limb controller that knows about all the elements and if one of them
#	is blocked (preventing two blockages in the same limb)
# [ ] update blockage creator
# [ ] add scoring system
# [x] add new pipe clean mini game
# [ ] add new pipe bend mini game
# [ ] balance timings for blockages
#
