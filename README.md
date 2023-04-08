# puma-redeploy-test-app
App used to test the [puma-redeploy](https://github.com/tbeauvais/puma-redeploy) gem.

## Running the App Locally
The following step will walk you through building an application archive and running running the app in a docker container.
The build container and runtime container are from dockerhub and were built using the [Github action](https://github.com/tbeauvais/sinatra-api-base/actions) in this repo. However we will build the application archive zip locally.


### Build an application archive using docker build container
This will place the application artifact in the current directory under `build/pkg`

```shell
docker run -e ARCHIVE_NAME=test_app -e BRANCH_NAME=main -e REPO_NAME=tbeauvais/sinatra-api-base -v $PWD/build/pkg:/build/pkg tbeauvais/archive-builder:latest
```

### Create Local Watch File
Create a `watch.me` file in the `build/pkg` folder where its contents is the path to the application archive created above.
The path is from the perspective of the docker container. For example:

```shell
/app/pkg/test_app_0.0.1.zip
```

### Start the Application
When the app starts the run script within the docker container will unzip the archive before starting puma.
```shell
 docker run -p 3000:3000 -e WATCH_FILE=/app/pkg/watch.me -v $PWD/build/pkg:/app/pkg tbeauvais/app-runner:latest
:latest
```

### Test endpoint

This endpoint does exist
Open a browser and hit http://localhost:3000/ping

This endpoint does not exist
Open a browser and hit http://localhost:3000/ding


### Make change to app (add new endpoint)
Make a change to the app by uncommenting out the `ding` endpoint in the `app.rb` file

Push change to a new branch
```text
git co -b add-ding
# make edits
git add .
git commit -m "Add new endpoint"
git push origin
```

### Build New Archive
Build the new archive from the branch with your change
```shell

# build the archive for the docker runtime container
docker run -e ARCHIVE_NAME=test_app -e BRANCH_NAME=add-ding -e REPO_NAME=tbeauvais/sinatra-api-base -v $PWD/build/pkg:/build/pkg tbeauvais/archive-builder:latest
```

### Touch the watch.me file

Touch(change its timestamp) the watch file and within a few seconds you should see the running fetch the archive, unzip it, and then perform a phased-restart.
```shell
touch build.pkg/watch.me
```

### Test endpoint

This endpoint does exist
Open a browser and hit http://localhost:3000/ping

This endpoint should now work!
Open a browser and hit http://localhost:3000/ding
