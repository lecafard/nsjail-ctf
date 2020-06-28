nsjail
======

nsjail container to run ctf challenges from. see the sample folder to see how to set up the challenge
container.

requires docker's `--privileged` mode for nsjail to function properly, as it creates a separate
linux namespace for each connection (each player won't be able to interfere with another player).
