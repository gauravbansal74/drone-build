IMAGENAME=drone-build
SHORTREV=`git rev-parse --short HEAD`
BRANCH=`git branch | grep "*" | cut -d\  -f2`
TAG=`git name-rev --tags --name-only $(git rev-parse HEAD)`

if [ $TAG != "undefined" ]; then
    IMAGEREV=`echo $TAG | sed "s/\^0$//"`
    echo "Using tag $IMAGEREV"
    echo "Resetting repo..."
    git reset --hard HEAD
    TAGINFO=`echo $TAG | sed "s/\^0$//"`
else
    IMAGEREV="$BRANCH-$SHORTREV"
    echo "Using tag $IMAGEREV"
    TAGINFO="$SHORTREV"
fi

CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' .


echo "Creating Info.json file to get latest version of commit"
echo "{ \"version\":"\"$TAGINFO\"", \"short\":"\"$SHORTREV\"", \"status\":\"OK\" }" > "data/info.json"
IMAGETAG=$IMAGENAME:$IMAGEREV

echo " version is \" $TAGINFO \" Here"

