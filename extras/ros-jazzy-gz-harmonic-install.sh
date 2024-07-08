#!/bin/bash
# Script to install development tools and libraries for robotics and simulation
echo
echo -e "\033[94m============================================================\033[0m"
echo -e "\033[94m== One-liner Installation Script for ROS-Gazebo Framework ==\033[0m"
echo -e "\033[94m============================================================\033[0m"
echo -e "Requirements: Ubuntu 24.04 LTS Noble"
echo -e "\033[94m============================================================\033[0m"

echo
echo -e "\033[96m(1/4) -------------    Updating the System  ----------------\033[0m"
echo "Performing full system upgrade (this might take a while)..."
sudo sudo apt update && apt full-upgrade -y

echo
echo -e "\033[96m(2/4) ------------    Install Dependencies   ---------------\033[0m"
echo -e "\033[34mInstalling essential tools and libraries...\033[0m"
sudo apt install -y \
    build-essential \
    cmake \
    cppcheck \
    curl \
    git \
    gnupg \
    libeigen3-dev \
    libgles2-mesa-dev \
    lsb-release \
    pkg-config \
    protobuf-compiler \
    python3-dbg \
    python3-pip \
    python3-venv \
    qtbase5-dev \
    ruby \
    software-properties-common \
    sudo \
    wget

echo
echo -e "\033[96m(3/4) ------------    Install Package Keys   ---------------\033[0m"
echo -e "\033[34mInstalling Signing Keys for ROS and Gazebo...\033[0m"
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg
sudo wget https://packages.osrfoundation.org/gazebo.gpg \
    -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg

ARCH=$(dpkg --print-architecture)
# shellcheck disable=SC1091
UBUNTU_CODENAME=$( . /etc/os-release && echo "$UBUNTU_CODENAME")
REPO="deb [arch=$ARCH signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
http://packages.ros.org/ros2/ubuntu $UBUNTU_CODENAME main"
echo "$REPO" | sudo tee /etc/apt/sources.list.d/ros2.list >/dev/null

DISTRO=$(lsb_release -cs)
REPO="deb [arch=$ARCH signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] \
http://packages.osrfoundation.org/gazebo/ubuntu-stable $DISTRO main"
echo "$REPO" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list >/dev/null

echo
echo -e "\033[96m(4/4) ------------     Install ROS-Gazebo    ---------------\033[0m"
DIST=jazzy
GAZEBO=gz-harmonic

echo -e "\033[34mInstalling ROS Gazebo framework...\033[0m"
sudo apt update && apt install -y \
    python3-rosdep \
    python3-rosinstall-generator \
    python3-vcstool \
    $GAZEBO \
    ros-$DIST-desktop-full \
    ros-$DIST-gz-plugin-vendor \
    ros-$DIST-gz-ros2-control \
    ros-$DIST-effort-controllers \
    ros-$DIST-geographic-info \
    ros-$DIST-image-view \
    ros-$DIST-joint-state-publisher \
    ros-$DIST-joy \
    ros-$DIST-joy-teleop \
    ros-$DIST-key-teleop \
    ros-$DIST-moveit-planners \
    ros-$DIST-moveit-simple-controller-manager \
    ros-$DIST-moveit-ros-visualization \
    ros-$DIST-pcl-ros \
    ros-$DIST-robot-localization \
    ros-$DIST-robot-state-publisher \
    ros-$DIST-ros-base \
    ros-$DIST-ros2-controllers \
    ros-$DIST-rqt \
    ros-$DIST-rqt-common-plugins \
    ros-$DIST-rviz2 \
    ros-$DIST-teleop-tools \
    ros-$DIST-teleop-twist-joy \
    ros-$DIST-teleop-twist-keyboard \
    ros-$DIST-tf2-geometry-msgs \
    ros-$DIST-tf2-tools \
    ros-$DIST-urdfdom-py \
    ros-$DIST-xacro \
    ros-dev-tools \
    ros-$DIST-ros-gz

echo
echo -e "\033[32m============================================================\033[0m"
echo -e "\033[32mROS-Gazebo Framework Installation completed. Awesome! 🤘🚀 \033[0m"
echo -e "Following command will set-up ROS environment variables to run it"
echo -e "\033[95msource /opt/ros/jazzy/setup.bash\033[0m"
echo -e "You may check ROS, and Gazebo version installed with \033[33mprintenv ROS_DISTRO\033[0m and \033[33mecho \$GZ_VERSION\033[0m"
echo
