# Git LFS Custom Adapter for Bitbucket

This custom transfer adapter for [Git LFS](https://git-lfs.github.com) speeds up
uploads and downloads to/from [Bitbucket Cloud](https://bitbucket.org).

## Installation

1. Place `git-lfs-bitbucket-media-api[.exe]` in a location of your choice
1. Run the following command in your terminal:
```sh
git config --global lfs.customtransfer.bitbucket-media-api.path /path/to/git-lfs-bitbucket-media-api
```

## Sourcetree users

Sourcetree comes pre-packaged with this adapter so you only need to install this
if you want it to work with other clients.

## FAQ

1. **What does it actually do?**
   This adapter implements a custom protocol between Git LFS and Bitbucket's
   media storage system which takes advantage of better parallelism, and
   de-duplication of chunks of data. Modified files may not need to be
   uploaded in their entirety if only parts of them have changed for example.

1. **Will this affect any other git servers I use?**
   No. It simply makes the custom protocol available, and Git LFS only uses it
   if the server signals its support (which only bitbucket.org does). You can
   install it and continue to work with any server, but you'll benefit when
   you use bitbucket.org.

1. **How can I see what it's doing?**
   Running any Git LFS command with `GIT_TRACE=1` will output debug information
   which shows the adapter being used. Note that bitbucket.org will only enable
   the adapter when at least one file is larger than 4MB, since it only
   benefits larger files.

## Changelog

### 1.0.6

- Fix race condition which could cause a crash when uploading very large files

### 1.0.5

- Fix problem with single files larger than ~7.8GB

### 1.0.4

- Changes to support updated Media API

### 1.0.2

- Fix bug when `TEMP` is on a different physical drive to the Git repo

### 1.0.1

- Report Go version used to build adapter in `--version` output

### 1.0.0

- Initial release
