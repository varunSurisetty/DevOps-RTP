# Minimum hardware requirements:

# 256 MB of RAM

# 1 GB of drive space (although 10 GB is a recommended minimum if running Jenkins as a Docker container)
#max
# 4 GB+ of RAM

# 50 GB+ of drive space

sudo apt update
sudo apt install openjdk-17-jre-headless -y

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins


http://localhost:8080
sudo cat /var/lib/jenkins/secrets/initialAdminPassword