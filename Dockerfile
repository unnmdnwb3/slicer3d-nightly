
# start from base with centos & qt5
FROM slicer/buildenv-qt5-centos7:latest

WORKDIR /usr/src

# get basics for the gui
RUN yum install Xvfb Xorg -y

# get slicer nighly version
RUN git clone -b nightly-master https://github.com/Slicer/Slicer.git && echo "Current commit:" && git rev-parse HEAD

# create slicer-build and environment
RUN mkdir /usr/src/Slicer-build && \
    cd /usr/src/Slicer-build && \ 
    # build slicer
    cmake \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DQt5_DIR:PATH=${Qt5_DIR} \
    -DSlicer_USE_SimpleITK:BOOL=OFF \
    -DSlicer_USE_QtTesting:BOOL=OFF \
    /usr/src/Slicer && \
    # build dependencies
    make -j 4

# start running container
CMD bash