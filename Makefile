all:
	maint/fbx all

clean:
	maint/fbx clean

test: all
	prove -PShareDirDist -lvm
