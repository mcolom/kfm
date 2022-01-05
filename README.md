# Kung-Fu Master (Spartan X) disassembly

![estimation](https://ipolcore.ipol.im/static/miguel/0016.png)</p>

This is an attempt to disassemble the Z80 code of the Kung-Fu Master/Spartan-X arcade machine designed by Takashi Nishiyama when he was working at Irem.
This videogame was released in November 24, 1984 in Japan and North America, and in early 1985 in Europe.

I've been playing this game since I was about 7 years old in the arcade machines, and even today I'm still having fun with it.
In September 2017 I started to disassemble the game to get into its most deep details :) by figuring out the meaning of its many variables and subroutines.
It's a long process, the same as others already did as for example with [Galaxian](https://seanriddle.com/galaxian.asm) but yet quite challenging or even addictive!

The main source code is stored at two different roms, `dis_a-4e-c.asm` (0x0000 - 0x3FFF) and `dis_a-4d-c.asm` (0x4000 - 0x7FFF) which I joined in a single `joint.asm` file inside the _dis/_ directory. The file I actively analize and comment is `dis/joint.asm`.

It's far from being finished and a work in progress...
