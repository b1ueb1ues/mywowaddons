The folder for this addon contains a copy of the "Skinning.txt" file that can be found in the Minimap Button Frame addon's main folder. 

That text file tells you how to add a "skin" to MBF. It also says:"The easiest way is to create a small addon that with the lua file containing only



if not IsAddOnLoaded("MinimapButtonFrame") then
	return
end

MBFAddSkin( "NAME", "BorderPath" , "BackdropPath", size)





You would still have to create a .TOC file as per a normal addon and make sure that your textures were included."

I am assuming that the original author, Bachlott, is using this as a method to give his permission to you to make an addon that uses MBF as the parent for your own "skin" pack. You, obviously, have to use the code he has set forth to make the addon work with MBF and that is why I assume he is giving permission to do so.

That being said: You know what happens when you you take the word "assume" apart, and I'm REALLY hoping that is not the case at this juncture.

Anyway, have fun with this little addition to MBF and I hope you like it.

                          jeffy162  6:06 PM 12/7/2009 