open 'http://email.kih.kmart.com'
killall ssh
sleep 1
tunnel.rb w3-mml
sleep 3
open 'http://my-host.local:8080/mmh'
ssh w3-mml
