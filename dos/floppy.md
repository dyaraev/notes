## Create Floppy Images in Mac OS X

### Create Image

```shell
dd if=/dev/zero of=floppy.img bs=1024 count=1440

# bs is a block size in bytes
# count is a number of blocks to copy
# floppy.img is a path to the image file
```

### Attach Image

```shell
hdiutil attach -nomount floppy.img
```

### Format Image

```shell
newfs_msdos -f 1440 -v LABEL /dev/disk2

# LABEL is disk label
# /dev/disk2 is the attached device to format
```

### Detach Image

```shell
hdiutil detach /dev/disk2
```


