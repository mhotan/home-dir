# Unix Machine Home Drive (~/)

Version controlled set of files used to set up my home directory.  This project is intended to assist the natural evolution of my Unix development machine.

## Usage

```sh
# Install package manager dependencies.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git

# Run setup scrript.
cd ~/
git clone https://github.com/mhotan/home-dir.git
# MacOs
home-dir/setup_mac.sh
```

```sh
# Elementary OS 6
sudo ./setup_elementary_6_linux.sh
```

### Update brew packages

```sh
$ cd ~/home-dir
$ ./update_casks.sh
```