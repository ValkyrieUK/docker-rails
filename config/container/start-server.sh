# start-server.sh

#!/bin/bash
cd /rails
sudo -s
source /etc/profile.d/rvm.sh
bundle exec unicorn -D -p 8080
nginx