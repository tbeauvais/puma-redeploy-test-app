# puma-redeploy-test-app
App used to test the [puma-redeploy](https://github.com/tbeauvais/puma-redeploy) gem.

## Running the App Locally
The following step will walk you through building an application archive and running running the app in a docker container.
The build container and runtime container are from dockerhub and were built using the [Github action](https://github.com/tbeauvais/puma-redeploy-test-app/actions) in this repo. However we will build the application archive zip locally.


### Build an application archive using docker build container
This will place the application artifact in the current directory under `build/pkg`

```shell
docker run --rm -e ARCHIVE_NAME=test_app -e BRANCH_NAME=master -e REPO_NAME=tbeauvais/puma-redeploy-test-app -v $PWD/build/pkg:/build/pkg tbeauvais/archive-builder:latest
```

### Create Local Watch File
Create a `watch.me` file in the `build/pkg` folder where its contents is the path to the application archive created above.
The path is from the perspective of the docker container. 

For example when using the puma-redeploy file handler the `watch.me` contents would look like the following.
```shell
/app/pkg/test_app_0.0.3.zip
```

For example when using the puma-redeploy with a S3 handler the `watch.me` contents would look like the following. In this case the `test_app_0.0.3.zip` must exist in the `puma-test-app-archives` S3 bucket.
```shell
s3://puma-test-app-archives/test_app_0.0.3.zip
```

### Start the Application
When the container starts, the `run.sh` script within the docker runtime container will use the `load_archive` cli from the `puma-redeploy` gem to deploy the archive before starting the puma server.

When using the file handler you will set the WATCH_FILE environment variable to the location of the `watch.me` from the perspective of the running container.
```shell
docker run --rm -p 3000:3000 -e WATCH_FILE=/app/pkg/watch.me -v $PWD/build/pkg:/app/pkg tbeauvais/app-runner:latest
```

When using the S3 handler you will set the `WATCH_FILE` environment variable to the location of the `watch.me` in S3. Be sure to also set the AWS credentials environment variables.
See the `s3.env.template`. You can copy this template to `s3.env` and set the proper `WATCH_FILE` and AWS credentials for accessing S3.
```shell
docker run --rm -p 3000:3000 --env-file s3.env -v $PWD/build/pkg:/app/pkg tbeauvais/app-runner:latest
```


### Test endpoint

This endpoint does exist
Open a browser and hit http://localhost:3000/ping

Check version
Open a browser and hit http://localhost:3000/version

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
docker run -e ARCHIVE_NAME=test_app -e BRANCH_NAME=add-ding -e REPO_NAME=tbeauvais/puma-redeploy-test-app -v $PWD/build/pkg:/build/pkg tbeauvais/archive-builder:latest
```

### Touch the watch.me file

Touch(change its timestamp) the watch file and within a few seconds you should see the running fetch the archive, unzip it, and then perform a phased-restart.
```shell
touch build.pkg/watch.me
```

### Test endpoint

This endpoint does exist
Open a browser and hit http://localhost:3000/ping

Check version(should have new version after redeploy)
Open a browser and hit http://localhost:3000/version

This endpoint should now work!
Open a browser and hit http://localhost:3000/ding

## Miscellaneous Commands

### Re-fetch Docker Images Locally
If you rebuild the images using the Github actions you will need to pull down the new version.

The archive builder image
```shell
docker pull tbeauvais/archive-builder:latest
```

The application runtime image
```shell
docker pull tbeauvais/app-runner:latest
```
