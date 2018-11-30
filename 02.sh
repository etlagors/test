read -p 'Delete user ' USERNAME

getent passwd $USERNAME > /dev/null
if [ $? -ne 0 ]; then
	echo "Invalid user"
	exit
fi

ID_USER_TO_DEL=$(id -u $USERNAME)
ID_USER=$(id -u $USER)

if [ $ID_USER_TO_DEL -eq $ID_USER ] || [ $ID_USER_TO_DEL -eq 1000 ]; then
	echo "You don't want to delete yourself, trust me"
	exit
fi

LOG_TO_DEL=$(who -u | grep $USERNAME)
if [ -z $LOG_TO_DEL ]; then
	echo "The user you are trying to delete is not logged"
	exit
fi

passwd -l $USERNAME
killall -KILL -u $USERNAME
userdel -f $USERNAME
