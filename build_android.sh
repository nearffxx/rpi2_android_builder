mkdir -p ~/.local
mkdir -p ~/.local/bin
PATH=~/.local/bin:$PATH

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.local/bin/repo
chmod a+x ~/.local/bin/repo

cd ~
repo init -u https://android.googlesource.com/platform/manifest -b android-6.0.1_r13
cd ~/.repo
git clone https://github.com/peyo-hd/local_manifests -b marshmallow
repo sync

cd ..
rm prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/bin/ld
ln -s /usr/bin/ld.gold prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/x86_64-linux/bin/ld

. ~/.repo/build/envsetup.sh
lunch rpi2-eng
make
