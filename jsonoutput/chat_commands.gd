# Inside chat_commands.gd, within func ascension(name):

# ... after your newatk, newmag, newspi, newhp are calculated ...

var stats_to_save = {
    "atk": newatk,
    "mag": newmag,
    "spi": newspi,
    "hp": newhp
}

# Trigger the JSON update through the table
if table.has_method("update_ascend_json"):
    table.update_ascend_json(name, stats_to_save, ascension)

# ... existing code for UI text and tweens ...
