# BlackMailApp (beta)

This version of the 'BlackMailApp' features a less monolithic Dockerfile structure and utilizes other Docker images to implement modularity and re-usable docker images, leveraging layering and caching more effectively.

FROM:
[rasputinlabs/base-php][1] -> [rasputinlabs/server][2]

[1]: https://github.com/RasputinLabs/base-php/
[2]: https://github.com/RasputinLabs/server/
