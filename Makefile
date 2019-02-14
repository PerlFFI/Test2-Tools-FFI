all:
	maint/fbx all

realclean clean:
	maint/fbx clean

test: all
	prove -PShareDirDist -lvm
