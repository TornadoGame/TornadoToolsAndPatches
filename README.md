# The Tornado Project
## Tools, Add-Ons and Patches

Source: [TornadoMan's Bunker](http://www.moodurian.com/tornado/tor/mods.html)

### Tornado Map Fax Machine (TMF)
[TMF 1.06](TMF106/)
[TMF 1.07](TMF107/) (Version 1.07 Fixes a bug that was introduced in
1.06 an prevented NVG s to work in the Desert Storm scenario)

This allows you to print captured screens of the Tornado Mission Planner
(without having to leave Tornado) on most HP laser/inkjet and EPSON or
NEC 24 needle printers (and compatible printers) as gray-scale maps
(much like a fax, hence the name of the tool). These hardcopies can be
used as maps for the planned missions. This will give you better
orientation during the flight, and you can use a series of maps to
document and analyse the progress of your campaign. Printed maps are
especially helpful when you have to attack (say) an NBC factory with
LGBs but you forgot which of the factory buildings is the NBC
factory. It's also very useful if you have to divert from your
pre-planned route and you need to find a safe way home thru the enemy
air defences (e.g. when short on fuel or after aborting a mission
because of system damage).

#### NVG
Another add-on that comes with TMF is an optional simulation of
night vision goggles (NVGs), helmet mounted devices that enhance the
ambient light at night. You can switch them off and on during flight.

#### TMF's snow
Included in the TMF package is an unofficial patch of Tornado that will
optionally give the impression of a winter landscape in the European
warzones, that is the ground and buildings appear to be covered by snow
and (optionally) some aircraft are painted in winter camo.

### Soundblaster Cannon patch (T_CANNON)
[T_CANNON](T_CANNON/)

Many users of Tornado versions 1.0c - 1.0e have reported problems when
using a Soundblaster SB 16 sound card. Frequently, the computer locks up
after firing the cannon. The only known cure so known until now was to
switch to the ADLIB driver on the PREFERENCES Screen, but this resulted
in slightly less realistic sounds. This is a beta test patch to correct
the problem. It should work with the following versions of Tornado:

- European (DI) versions 1.0c, 1.0d, 10.e
- American Versions 1.0c, 1.0d
- American Versions 1.0d patched with the European 1.0e patch

It will not work with the Trimark Interactive 1.0e Edition of
Tornado. The reason for this is that in the Trimark release,
Soundblaster support was intentionally disabled internally (probably
because of the SB16 problems).

Soundblaster compatibility (or the lack of it) was a problem for Tornado
right from its release. Some versions would not work with any
soundblaster card, but version 1.0c seemed to fix most problems except
for SoundBlaster 16 owners: Firing the cannon could lock your computer
when selecting SoundBlaster as the sound device. The only option for
SB16 users was to switch to the somewhat less dramatic Adlib
sounds. This problem was so bad that some subsequent releases of Tornado
had their entire Soundblaster support disabled for good internally. Even
if you select the SoundBlaster option, the program will automatically
choose the Adlib driver. For those SB16 owners who still have
Soundblaster support in their copy of Tornado and experience the
cannon-lockup-problem, I wrote a little patch that seems to fix the
lock-up problem on most systems.

### Generic Tornado Patcher (TPATCHER)

[TPATCHER](TPATCHER/)

You'll also have to download this Generic Tornado Patcher to use the
cannon patch.

### Action 16 Edition SoundBlaster patch (A16_SB)

[A16_SB](A16_SB/)

The Action 16 edition (mainly sold in Europe) of Tornado is a budget
version that has the Desert Storm extension on it (version 1.0e) and
comes on a CD-ROM, either in a box or in a jewel case with an online
Adobe PDF manual. A similar edition was published as a cover-CD-ROM on
the German language magazine "Bestseller Games Collection" (issue
12). The problem with these versions is that Soundblaster sound effects
were disabled in these editions with the exception of the Quickstart
option where you still can hear digitized sound effects. I've written a
patch that will allow you to hear Soundblaster effects in all parts of
the simulation. Note that this patch will probably not work with the
American Trimark edition that also had it's SB effects disabled.

### The Logbook Editor (TLE12B)

[TLE12B](TLE12B/)

The Tornado Logbook Editor (TLE) is a tiny program to edit almost all
aspects of the Tornado pilot logbooks. Yes, you can actually promote
your pilot!

### A Safer Keyboard Layout (TKM)

[TKM](TKM/)

Tornado Keyboard Mapper is a little memory resident program that will
change the keyboard layout of Tornado. I wrote it after I had (for the
third time) ejected by accident from my Tornado (I wanted to press
CTRL-R to switch off the radar, but actually hit CTRL-E: eject).

### Soundblaster Autodetect patch (T_SBDT)

[T_SBDT](T_SBDT/)

When Tornado was released, a 486-DX-33 was quite a fast machine. Like
many other games, Tornado has problems on some fast machines, especially
with the routines for Sound Blaster autodetection (the program (at least
version 1.0c upwards) ignores the value of the BLASTER environment
variable and tries to find out the correct values for IRQ and port
address by "experimentation", it always uses DMA channel 1, by the way,
and the only IRQ values supported by Tornado are 2,3,5 and 7. If your
soundcard is set to use a different IRQ, it won't work with Tornado
1.0c - 1.0e). On fast machines, this autodetection mechanism sometimes
fails. After you select "TAKE OFF" in the Mission Planner, the cockpit
fails to show up and you are thrown back into the mission planner with a
warning like "soundcard not present". In this case, the patch T_SBDT.ZIP
might be helpful.

### showPT2

[SHOWPT2](SHOWPT2/)

The Review feature of Tornado contains a library of nice pictures of the
different types of aircraft and other vehicles modelled in the
simulation. Those pictures are stored in a file format that seems to be
used only by DI. The program ShowPT2 will convert these pictures to the
BMP Bitmap format, so you can use those pictures for private purposes
like MS Windows wallpaper (and only for private use because those
pictures are (c) by DI !!). This version features optional correction of
the aspect ratio and clipping of black borders around some pictures.

### TCSC (For Windows 3.1/Windows 98)

[TCSC](TCSC/)

Tornado Command and Staff College (TCSC) is a tutorial for Tornado
Command Campaign gameplay, discussing how to survive and win a virtual
campaign in Tornado both from the tactical pilot and the strategic
commander perspective. It was written by Eric Joiner, Basil Copeland and
Heinz-Bernd Eggenstein (that's me).  Unlike many other strategy guides
and FAQ lists, TCSC is not a mere ASCII file, it was written in Windows
3.1 helpfile format, so it has hypertext links, 256-color graphics and
even (optionally) some sound bites.  Discussing TCSC is beyond the scope
and capacity of this website. To learn all about TCSC (and much more),
go to one of the hottest flight sim related sites on the WWW: the TCSC
homepage. TCSC is shareware (US$ 10). In return for the 10 bucks, you'll
also get a password which can be used to decrypt additional goodies:
several hot Tornado add-on programs.

### Tornado Spouse Reminder Tool (TSRT)

[TSRT](TSRT/)

Has this ever happened to you? You fly a really exciting Tornado
mission, evading lots of SAMs and bombing the hell out of those orange
enemies. Suddenly, a complete stranger enters the cockpit, and wants to
talk to you about some irrelevant things like your children, mortgages,
plans for spending weekends together etc. After some time, you realize
this person is not really a complete stranger, she looks familiar
... she's your wife! How embarrassing! During all those hours in the
cockpit, you forgot what she looks like! Now, with this incredible new
tool, the result of months of scientific work by our team of experts,
this can no longer happen to you: We are proud to introduce the Tornado
Spouse Reminder Tool (TSRT). This program allows you to stick a photo of
your spouse to Tornado's front cockpit dashboard!

### Tornado Ordinance Management (T_ORDN)

[T_ORDN](T_ORDN/)

Tornado by DI is supposed to simulate a limited supply of ordnance from
which you have to take configure your Tornados. However, this feature
does not work correctly, making it impossible to run out of ordnance in
even the most costly and long campaign. But there's nothing that can
keep us Tornadoholics from simulating a limited supply of weaponry
independently. This can be tedious if you do it all by pencil and paper,
e.g. counting all the different bombs and missiles loaded to the up to 8
Tornados in a mission can be a pain. To assist in this task, I wrote a
program ORDNANCE.EXE and a simple Excel 3.0 spreadsheet ORDNANCE.XLS
that will help you automate this process a bit. (There's also an
identical spreadsheet file ORDNANCE.wk1 in Lotus-1-2-3 file format)

### TCSC add-on: Desert Storm: Gulf '96 add-on campaign

[TCSC](TCSC/)

This is an encrypted file. Unless you are a registered TCSC user and
have the registration password, don't download it. Gulf '96 is an add-on
campaign and bug-fix package for the "Operation Desert Storm" part of
Tornado (versions 1.0d and 1.0e only). It adds a campaign that is much
harder than the original ODS campaign and fixes some bugs in ODS as
well. This zip file also includes the TORNADO ODS Enhancement Patch.

### Time Compression TSR program (TTC10)

[TTC10](TTC10)

This handy tool allows you to speed up the actual gameplay by N times,
thereby allow you to fast-forward past the "boring" parts of the
mission, and to quickly go to crucial points of the mission. TTC is a
simple TSR that allows time compression during Tornado missions. Time
compression makes events happen faster, and is normally used to quickly
skip "less interesting" parts of a mission. In Tornado, the outcome of a
mission might not always be successful. The mission must be aborted and
repeated unless you want your favorite "pilot" to be forever KIA. If
nothing else is changed a repeated mission will closely resemble the
original. Often this implies a lot of waiting (in real-time) while the
auto-pilot goes from turn-point to turn-point. YOU know that until
way-point so-and-so is reached nothing interesting will happen. And you
will go and make a cup of cofee. But after several retries you sort of
get fed up with making cofee, and you don't really have anything else
(short-term) to do. It gets a bit boring (and time-consuming) to wait
for the action (sorry DI). TTC will reduce the waiting time by a factor
2-8.

### Liberation Campaign (LIBERAT)

[LIBERAT](LIBERAT/)

This is an add-on initial campaign situation for the European Warzone
no. 2. It's meant to be much harder to win than the other campaigns that
come with DI's Tornado, as you start with a disadvantage and because the
enemy is less ambitious.

### Morale Patch (T_MORALE)

[T_MORALE](T_MORALE/)

This unofficial patch fixes a slight bug in the way Tornado calculates
allied and enemy morale during campaigns.

### Terrain Following Realism Patch (T_RIDE_P)

[T_RIDE_P](T_RIDE_P/)

This unofficial patch allows you to fly in TF mode at 100ft AGL (real
MRCA Tornados can do that)! While this will help you evade missiles and
enemy radar, it also has a downside to fly that low: power lines! So be
careful.

### Default Speed Patch (T_DSPEED)

[T_DSPEED](T_DSPEED/)

Another unofficial patch, this one allows you to set the default mission
planner waypoint speed to values higher than 420 kts. Usually, you'd
like the IDS Tornados to cruise at 500+ kts, which is more fuel
efficient than the usual 420 kts for navigation waypoints, as the latter
means you have to accelerate fast to get to 500+ kts for the target
waypoints.

### BDA Patch (TBDA)

[TBDA](TBDA/)

This tool generates ASCII reports of the debriefing texts after a
mission, this is especially useful when doing e-mail campaigns with
others

### Tornado Mission Exchange Tool (TDO_TMX)

[TDO_TMX](TDO_TMX/)

TMX (for short) allows you to refly missions or exchange missions with
others (similar to Red Flag missions in Falcon 3.0). It comes with
several example missions.

### Tornado Joystick Doctor (TJOY_DOC)

[TJOY_DOC](TJOY_DOC/)

This unofficial patch can significantly improve the joystick routines in
Tornado on most machines, especially fast machines (fast by the
standards of Tornado's release time: anything faster than a 486-DX-33!).

### Mission Summary Text Extractor (TDOMISS)

[TDOMISS](TDOMISS/)

This is the first revision of a program to extract a mission summary
from Tornado's .mis and .dta files, listing mission objectives and
waypoints. Copy it to a directory in your path and e.g.

`tdomiss miss1 >miss1.txt`

or

`tdomiss \games\tornado\amp\map5\miss1`

will extract the info for mission 1, to the screen or to disk as
required. Any comments and suggestions gratefully received, particularly
any info on the contents of .dta and .mis files so I can improve the
output. tdomiss has been tested on the missions supplied with 1.0e
Europe. keith.bedford@uk03.bull.co.uk

## Credits (1995)
- Heinz-Bernd Eggenstein,
- Basil Copeland,
- Eric Joiner (TCSC Associates) and
- Kenneth Larsen for the Time Compression utility!
