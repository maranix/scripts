import subprocess, platform, os, random, string

remotes = ["Edu", "Mavi_New", "Mavi_Old", "Mavi_Alvro"]
mount_points = []

def createMounts():
    for i in range(len(remotes)):
        point = random.choice(string.ascii_uppercase)
        if os.system("vol {}: 2>nul>nul".format(point)) == 0:
            print("{} mount point already exists, generating another one.".format(point))
            i=i-1
        else:
           mount_points.append(point)

if __name__ == "__main__":

    print("Detecting platform....")
    print("Platform type: {}".format(platform.system()))
    print("Creating mount points")
    createMounts()
    if platform.system() == "Linux":
        for i in range(len(mount_point)):
            subprocess.run(["mkdir", "~/CloudDrives/{}".format(mount_points[i])])

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