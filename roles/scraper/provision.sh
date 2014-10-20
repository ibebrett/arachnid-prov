sleep 30 # sleep so that the provisioner can install

USER_HOME=/home/ubuntu

# install apt dependencies
sudo apt-get update
sudo apt-get install -y \
    libpq-dev  \
    python-dev \
    python-pip \
    git \
    supervisor

# install supervisor confs
sudo cp /tmp/scraper.conf /etc/supervisor/conf.d/scraper.conf

# move tools
mkdir -p $USER_HOME/tools/
tar --directory $USER_HOME/tools/ -xvf /tmp/phantomjs.tar.bz2

# clone the arachnid repo
git clone https://github.com/ibebrett/arachnid.git $USER_HOME/arachnid
sudo pip install $USER_HOME/arachnid

# create environment file
cat <<EOF > $USER_HOME/env.sh
export PATH=\$PATH:/home/ubuntu/phantom/bin
EOF
