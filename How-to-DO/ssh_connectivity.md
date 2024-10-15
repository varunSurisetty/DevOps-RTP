How to connect a master machine with a slave machine in linux

1. create ssh_key in master machine
> ssh-keygen -t rsa

2. copy the ssh key
> cat /root/.ssh/id_rsa.pub

3. go to authorisation section folder of slave machine and add the copied key in last
> vi /root/ssh/authorised_keys
