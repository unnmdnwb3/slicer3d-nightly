# Slicer3D-Nightly

This is the unofficial image for the **Slicer3D** `nightly-master` branch.

The image can be found on [dockerhub](https://hub.docker.com/r/unnmdnwb3/slicer3d-nightly) , under [unnmdnwb3/slicer3d-nightly](https://hub.docker.com/r/unnmdnwb3/slicer3d-nightly).

## Details

This repository contains the **Dockerfile** to build the image `unnmdnwb3/slicer3d-nightly` - a testing environment for [Slicer3D Nightly Build](https://github.com/Slicer/Slicer/tree/nightly-master) and therefore **Slicer 4.11**. The image can be used by project-teams working on extensions for Slicer3D.

In contrast to the [official Slicer images](https://github.com/thewtex/SlicerDocker), this image is based on the **nightly-build** branch of Slicer - and hence explicitly **not** on the stable **master**. Therefore, this image supports `python3`.

However, the image is based on the `slicer/buildenv-qt5-centos7` [Dockerfile](https://github.com/Slicer/SlicerBuildEnvironment/blob/master/Docker/qt5-centos7/Dockerfile), also hosted on [Dockerhub](https://hub.docker.com/r/slicer/buildenv-qt5-centos7), which the official Slicer-images use as well.

## Prerequisites

To be able to use `unnmdnwb3/slicer3d-nightly` locally, you have to have `Docker` installed.
Please download Slicer from their [official website](https://www.docker.com/get-started) and build it [manually](https://www.slicer.org/wiki/Documentation/Nightly/Developers/Build_Instructions).

## Installation

### Use the Dockerfile

To build the Dockerfile from scratch

```bash
cd <dockerfile-directory>
docker build . --tag unnmdnwb3/slicer3d-nightly:<tag> --no-cache
```

Push the newest image to dockerhub (if you are an *accepted collaborator*):

```bash
cd <dockerfile-directory>
docker push unnmdnwb3/slicer3d-nightly:<tag>
```

### Use the Image

To use the image, you have to **pull** the newest version first:

```bash
docker pull unnmdnwb3/slicer3d-nightly:<tag>
```

To **run** it, use the following command:

```bash
docker run -dit unnmdnwb3/slicer3d-nightly:<tag>
```

If you run the following command, you get an overview over all your container instance and can retrieve the **container's id**:

```bash
docker ps -a
```

To get access to the container's **shell**, use:

```bash
docker exec -it <container-id> /bin/bash
```

If you don't use the container anymore, feel free to delete it:

```bash
docker ps -a
docker kill <container-id>
docker rm <container-id>
```

If you even want to delete the image itself, just use:

```bash
docker images
docker image rm <image-id>
```

Please note though, that removing an image can not be undone. You would have to download the whole image from scratch again.
Also, if you have a running container based on the image you want to remove, you have to remove it with force `-f`.

## Supported Components

This image inherits several components, which are used to build Slicer and its dependencies.

This list includes, but is not limited to:

- *gcc*
- *g++*
- *git*
- *cmake*
- *make*
- *wget*
- *Qt5*
- *Xvfb*
- *Xorg*

## Limitations

Please be aware that this docker image is `work-in-progress`! The image should therefore only used in testing.
The author does not accept any responsability for using the code.

Please note that the image versions on [dockerhub](https://hub.docker.com/r/unnmdnwb3/slicer3d-nightly) are currently fixed to commits on [nightly-master](https://github.com/Slicer/Slicer/tree/nightly-master), which introduce breaking changes.

Future versions of the image should be *updated*, whenever the branch is enhanced - currently though the image remains static. However, currently all versions have to build locally, since dockerhub enforces some [resource-limits](https://success.docker.com/article/what-are-the-current-resource-limits-placed-on-automated-builds) which are way to low for building Slicer from scratch. Therefore, the bulding process will possibly moved to `travis`, since they offer better [specs](https://docs.travis-ci.com/user/reference/overview/).

## Warning

Building the underlying `Dockerfile` takes quite some time to build locally (`make -j 1` needed *4h 17m 24s*). In order to successfully build the image, docker possibly needs more ressources than set by default. The following configuration should work for `make -j 4`:

```bash
CPUs: 6
Memory: 4 GiB
Swap: 2 GiB
```

If you experience crashes such as the following one, please *increase* the resources for docker:

```bash
g++: internal compiler error: Killed (program cc1plus)
```
