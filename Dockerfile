FROM ubuntu:18.04

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y curl unzip vim wget
RUN apt-get install -y build-essential libssl-dev openjdk-8-jre openjdk-8-jdk

# install Android Studio
RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

ENV WORKDIR=/tmp/rn_build_cache
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR

RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip 
RUN unzip sdk-tools-linux-4333796.zip
RUN mkdir -p /usr/lib/android-sdk
RUN mv ./tools /usr/lib/android-sdk/

# ANDROID ENV
ENV ANDROID_HOME=/usr/lib/android-sdk
ENV PATH=$PATH:$ANDROID_HOME/tools
ENV PATH=$PATH:$ANDROID_HOME/tools/bin
ENV PATH=$PATH:$ANDROID_HOME/platform-tools

# install android sdk
RUN yes | sdkmanager --licenses
RUN sdkmanager --update
RUN android update sdk -u --filter platform-tools,android-23 --use-sdk-wrapper
RUN android update sdk -u --filter platform-tools,android-26 --use-sdk-wrapper
RUN android update sdk -u --filter platform-tools,android-27 --use-sdk-wrapper
RUN android update sdk -u --filter platform-tools,android-28 --use-sdk-wrapper
RUN android update sdk -u --filter extra-android-m2repository --use-sdk-wrapper
RUN yes | sdkmanager "build-tools;23.0.0"
RUN yes | sdkmanager "build-tools;26.0.3"
RUN yes | sdkmanager "build-tools;27.0.3"
RUN yes | sdkmanager "build-tools;28.0.3"

# install node
ENV NVM_DIR=/root/.nvm
RUN mkdir -p $NVM_DIR
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN . $NVM_DIR/nvm.sh && nvm install 8.9.2
ENV PATH=$PATH:$NVM_DIR/versions/node/v8.9.2/bin/

# install react-native
RUN npm install -g react-native-cli yarn

# make some cache file for more fast build
RUN react-native init cache_rn
RUN cd cache_rn/android && ./gradlew assembleDebug


# make WORKDIR
ENV WORKDIR=/opt/app
RUN mkdir -p $WORKDIR
WORKDIR $WORKDIR
