FROM react-native:latest

# download NDK
ENV WORKDIR=/tmp/rn_build_cache
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR

RUN wget https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip
RUN unzip ./android-ndk-r18b-linux-x86_64.zip -d /usr/lib
RUN rm ./android-ndk-r18b-linux-x86_64.zip

ENV NDK_PROJECT_PATH=/usr/lib/android-ndk-r18b
ENV PATH=$NDK_PROJECT_PATH/build:$PATH



# make WORKDIR
ENV WORKDIR=/opt/app
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR
