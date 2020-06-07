## Create Floppy Images in Mac OS X

### Create Image

```shell
dd if=/dev/zero of=floppy.img bs=1024 count=1440

# bs is a block size in bytes
# count is a number of blocks to copy
# floppy.img is a path to the image file
```

### Format Image

```shell
diskutil eraseVolume MS-DOS DISKNAME `hdiutil attach -nomount floppy.img`

# MS-DOS is a filesystem
# DISKNAME is disk label
# floppy.img is a path to the image file
```

