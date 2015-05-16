import fontforge
import sys

sourcefile = sys.argv[1]
destfile = sys.argv[2]

font = fontforge.open (sourcefile)

for glyph in font.glyphs():
#	if not ( glyph.background.isEmpty() ):
		glyph.layers[1] += glyph.background
		glyph.layerrefs[1] += glyph.layerrefs[0]
		glyph.layers[0] = fontforge.layer()

xheight = font.os2_xheight
capheight = font.os2_capheight
scale = 1024 / font.em
font.em = 1024
font.os2_xheight = xheight * scale
font.os2_capheight = capheight * scale

fontforge.setPrefs ('FoundryName', 'NCSM'); 
fontforge.setPrefs ('TTFFoundry', 'NCSM') 

fontforge.setPrefs ('AutoHint', 0)

font.selection.all ()
font.round ()

font.generate ( destfile, flags=['short-post', 'opentype', 'omit-instructions', 'TeX-table'] )
