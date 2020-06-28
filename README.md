nsjail
======

nsjail container to run ctf challenges from. see the example nsjail.cfg to see how to set up your
challenge container.

requires docker's `--privileged` mode for nsjail to function properly, as it creates a separate
linux namespace for each connection (each player won't be able to interfere with another player).
