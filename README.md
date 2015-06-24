# docker-sshd

###To run
```
docker run -d -p 2222:22 -p 8080:8080 jessefugitt/docker-sshd
```
###To connect with a client
```
ssh root@docker-sshd-ip-address -p 2222
```
###To reverse tunnel with a client
```
ssh -N -R *:1234:localhost:8080 root@docker-sshd-ip-address -p 2222
```
where the syntax is (no command with -N and reverse tunnel with -R)
```
ssh -N -R *:docker-sshd-host-port:local-ip-address:local-port root@docker-sshd-ip-address -p 2222
```

###To modify docker-sshd
```
git clone https://github.com/jessefugitt/docker-sshd.git
edit Dockerfile (or authorized_keys)
docker build -t jessefugitt/docker-sshd .
```

###To generate keys
```
ssh-keygen -t rsa -C "your_email@example.com"
cat ~/.ssh/id_rsa.pub >> authorized_keys
```
