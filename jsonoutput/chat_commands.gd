#Place in func stats(name): after tweens
#
# Generate player stats JSON
	if game_stats_writer:
		game_stats_writer.write_player_stats_json(name, playerdatabase, table, tiertracker, characterdatabase)
	else:
		# Fallback: try to find the node dynamically
		var fallback_writer = get_node_or_null("../game_stats_writer")
		if fallback_writer:
			fallback_writer.write_player_stats_json(name, playerdatabase, table, tiertracker, characterdatabase)
		else:
			# Try another common path
			fallback_writer = get_node_or_null("%game_stats_writer")
			if fallback_writer:
				fallback_writer.write_player_stats_json(name, playerdatabase, table, tiertracker, characterdatabase)
			else:
				# Final fallback: use simple test function
				var simple_writer = get_node_or_null("../game_stats_writer")
				if simple_writer:
					simple_writer.test_player_stats_json(name)
