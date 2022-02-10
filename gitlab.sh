#!/bin/sh
# Get the registration token from:
# http://localhost/root/${project}/settings/ci_cd

registration_token="_qFcQLKRAKR3GUrxbWzK"

docker exec -it gitlab-runner1 \
    gitlab-runner register \
        --non-interactive \
        --registration-token ${registration_token} \
        --locked=false \
        --description docker-stable \
        --url http://gitlab-web \
        --executor docker \
        --docker-image etiennec27/laravelphp:latest \
        --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
        --docker-network-mode gitlab-network

docker exec -it gitlab-runner2 \
    gitlab-runner register \
        --non-interactive \
        --registration-token ${registration_token} \
        --locked=false \
        --description docker-stable \
        --url http://gitlab-web \
        --executor docker \
        --docker-image etiennec27/laravelphp:latest \
        --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
        --docker-network-mode gitlab-network