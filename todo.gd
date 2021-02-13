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
