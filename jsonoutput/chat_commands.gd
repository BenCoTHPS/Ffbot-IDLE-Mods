# Inside chat_commands.gd, within func ascension(name):

# ... after your newatk, newmag, newspi, newhp are calculated ...

var stats_to_save = {
    "atk": newatk,
    "mag": newmag,
    "spi": newspi,
    "hp": newhp
}

# put this after 
# var stat_1 = $"../infobox/stats_new"
#	stat_1.text = "Progress will reset, keep:" + "\n Atk: " + str(newatk) + " Spi: " + str(newspi) + "\n Mag: " + str(newmag) + " HP: " + str(newhp) + "\n Party EXP up: " + str(ascension*2)+"%" + "\n Type !yes to proceed"
#
table.update_ascend_output(name, newatk, newmag, newspi, newhp, ascension)
