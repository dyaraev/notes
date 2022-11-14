# fail if any of the commands fails
set -e

# requires all varibles to be set
set -u

# copy directory to minikube
scp -r -i $(minikube ssh-key) <from-path> docker@$(minikube ip):<to-path>

# find and delete non-empty directories
# -type should be specified after -name to improve performance
find . -name <dir-name> -type d -exec rm -r {} +
