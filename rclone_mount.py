import subprocess, platform, os, random, string

remotes = ["Edu", "Mavi_New", "Mavi_Old", "Mavi_Alvro", "Mavi_Tv", "Mavi_Anime", "Mavi_Movies"]
mount_points = []

def genChar():
    point = random.choice(string.ascii_uppercase)

    if os.system("vol {}: 2>nul>nul".format(point)) == 0:
        genChar()
    else:
       mount_points.append(point)

def linux():
    for i in range(len(remotes)):
        subprocess.run(["mkdir", "{}".format(remotes[i])])
        subprocess.run(["rclone", "mount", "{}:".format(remotes[i]), "{}".format(remotes[i]), "--daemon"])

    print("All drives mounted successfuly")

def windows():
    print("""
        Warning working environment is Windows,
        Currently rclone doesn't run as a background service on windows so only a single
        instance can be executed at once.

        Make Sure You Have WinFSP installed to mount drives as network drives.
        """)

    for i in range(len(remotes)):
        print("%d.{}".format(remotes[i]) % i)

    genChar()
    m = int(input())

    print("Mounting {}".format(remotes[m]))

    subprocess.run(["powershell", "Start-Job", "-Name " + "\"%s\"" % remotes[m], "-ScriptBlock", "{", "rclone", "mount", "{}:".format(remotes[m]), "{}:".format(mount_points[0]), "--fuse-flag", "--VolumePrefix=\server\{}".format(remotes[m]), "--vfs-cache-mode", "writes", "}", ";", "echo", "\"Mounting Successful\"", ";" , "PAUSE" ])

if __name__ == "__main__":

    print("Detecting platform....")
    print("Platform type: {}".format(platform.system()))

    if platform.system() == "Linux":
        linux()
    elif platform.system() == "Windows":
        windows()