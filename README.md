# ENGL 318 Final Project

## Who

This is a collaboration project between Paolo Morgan Orso-Giacone and myself, Elijah Kliot.

## What

For this project, we will use a digital medium to express a story and its meaning, primarily through the use of parallax effects.

The story is centered on the main character, Sabah, of a yet-unnamed setting. Time has trickled past this weathered adventurer, and now he sits and recollects the stories of his once companions. Are they gone forever, passed on beyond the mortal plane, or merely lost among the countless leagues of this forsaken earth? Regardless, Sabah is here, now, and his memories are certain fact...

## Where

This setting takes place many millennia after the time we are familiar with today, after cataclysmic events have ruined civilization, sending humanity back to its savage roots while digging up another world, intimately tied to humanity yet long since forgotten. The comic itself begins some time after this cataclysm, enough time for civilization to take hold once more, for cities to be built and ruins explored, yet with much land and sea yet unclaimed by society.

## Why

Paolo and I have long since wanted to collaborate on a comic. We've played with this setting, a mix of Neil Gaiman's *Neverwhere* and Robert E Howard's *Hyboria*, where we wanted to chronicle an epic odyssey of a band of adventuring comrades, mortals faced with the darkness just behind the corner, an inhuman and eldritch second-world seeping into our own.

When we enrolled in a class at our university discussing the medium comics and graphic novels, and were offered the opportunity to create a comic of our own for the final project, it was not a question what we would create. This project lets us take a small snippet of our setting, to explore specific characters, and to combine our respective expertise into a project expressing a unique digital medium for comics.

## How

This project will utilize parallax effects and Paolo's paper cutout art to simulate depth and light effects inside a web browser. The expected technical tools will be javascript and an exacto blade.

The experience itself will center on a campfire, at which Sabah is seated. Around him are his comrades. Moving the mouse will dictate the parallax shifting, the mouse simulating a light source shining through the cutout image. Clicking on a character or a memento of theirs (tbd) will cause the campfire to kindle, sending the view upwards, where a vignette is played through comic panels, using a similar parallax effect. At the end of the vignette, the view shifts back to the campfire, where the observed character is now absent.

A key component of this project is to build a system which is lower-maintenance and allows us to focus on writing and art instead of fiddling with technical details. This is one of the greater successes of the project, utilizing a system of JSON files to specify exactly what images are arranged in the scene in which manner, including their properties such as opacity, depth, and positioning. Moving forwards, we would see this extended to being able to define entire comic strips and perhaps books, including panel transitions and special effects, defining those in a human-friendly file format and letting the engine handle the scene building.

One of the visual obstacles so far has been the layering of cutouts, as the blackness of each is absolute enough to blend into a single image and be unintelligible. To counteract this, we see multiple options.

One is to outline the cutouts with a pixel-thin border or glow, to give them their own space. However, this may be too loud of a change for intricate areas of the cutouts, such as chainmail.

Another option we are looking at is to fill the empty spaces of the cutouts with colour, a la Mike Mignola's art style, however this may diminish some of the cool effects of parallax with the holed cutouts. We use such an effect for the fire, which is not see-through, to a noticeable and fairly significant effect, lending a greater "tactile" understanding of depth.

The last option we see, which may be used in conjunction with the last, is to simply not use layers. We intend to use this at first for the comic strips/vignettes, where the whole strip is one layer with simply a shadow layer underneath, to see if this would betray one of the core unique aspects of this medium.
