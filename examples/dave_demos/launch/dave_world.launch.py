import os
from ament_index_python.packages import get_package_share_directory
from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, OpaqueFunction, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration


def launch_setup(context, *args, **kwargs):

    pkg_dave_worlds = get_package_share_directory("dave_worlds")
    pkg_ros_gz_sim = get_package_share_directory("ros_gz_sim")

    world_name = LaunchConfiguration("world_name").perform(context)
    world_file_name = f"{world_name}.world"

    world_path = os.path.join(pkg_dave_worlds, "worlds", world_file_name)

    # Gazebo simulation launch
    gz_sim = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(pkg_ros_gz_sim, "launch", "gz_sim.launch.py")),
        launch_arguments={"gz_args": f"-r {world_path}"}.items(),
    )

    return [gz_sim]


def generate_launch_description():
    return LaunchDescription(
        [
            DeclareLaunchArgument(
                "world_name",
                default_value="dave_bimanual_example",  # Default world file name without extension
                description="Name of the world file",
            ),
            OpaqueFunction(function=launch_setup),
        ]
    )


if __name__ == "__main__":
    generate_launch_description()
