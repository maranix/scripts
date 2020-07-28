import subprocess
import platform

remotes = ["Edu", "Mavi_New", "Mavi_Old", "Mavi_Alvro"]
mount_points = ["D", "F", "G", "H"]

if __name__ == "__main__":

    print("Detecting platform....")
    print("Platform type: {}".format(platform.system()))
    if platform.system() == "Linux":
        print("Creating mount points in /tmp/")
        for i in range(len(mount_point)):
            subprocess.run(["mkdir", "~/CloudDrives/{}".format(mount_point[i])])

        print("Inserting drives into their respective mount points")
        for i in range(len(remotes)):
            subprocess.run(["rclone", "mount", "{}:".format(remotes[i]), "~/CloudDrives/{}:".format(mount_points[i]), "--allow-non-empty", "--daemon"])
        print("All drives mounted successfuly")
    elif platform.system() == "Windows":
        print("""
        Warning working environment is Windows
        Currently rclone doesn't run as a background service on windows so only a single
        instance can be executed at once.

        Make Sure You Have WinFSP installed to mount drives as network drives.
        """)
        print("Select a drive to mount:")
        for i in range(len(remotes)):
            print("%d.{}".format(remotes[i]) % i)
        m = int(input())
        print("Mounting {}".format(remotes[m]))
        subprocess.run(["powershell", "Start-Job", "-Name " + "\"%s\"" % remotes[m], "-ScriptBlock", "{", "rclone", "mount", "{}:".format(remotes[m]), "{}:".format(mount_points[m]), "--fuse-flag", "--VolumePrefix=\server\{}".format(remotes[m]), "--vfs-cache-mode", "writes", "}", ";", "echo", "\"Mounting Successful\"", ";" , "PAUSE" ])