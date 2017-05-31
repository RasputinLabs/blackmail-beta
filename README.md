# BlackMailApp (beta)

This version of the 'BlackMailApp' features a less monolithic Dockerfile structure and utilizes other Docker images to implement modularity and re-usable docker images, leveraging layering and caching more effectively.

FROM:
[rasputinlabs/base-php][1] -> [rasputinlabs/server][2]

# Improvements from Alpha
- This image drops the local MySQL and Redis servers in favor of splitting the app into separate services.
- The supervisord configuration includes sub processes that run only once to handle on deploy steps to make the entrypoint slimmer
- Includes wait-for-it.sh to prevent the app from running until there is a MySQL server it can talk to.
- Replaces .env file variables with ENVIRONMENT Variables this is somewhat curious in it's own right.

# Notable issues
- This repo is including node_modules and vendor for dependencies and is a bad practice. It is smoother for demonstration to not have to fetch dependencies however and removes build steps. (In any case this is ideally handled on the build server)
- No Automatic Tests! This is bad!

[1]: https://github.com/RasputinLabs/base-php/
[2]: https://github.com/RasputinLabs/server/
