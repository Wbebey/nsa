FROM gitlab/gitlab-ce:latest

RUN curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permissions to execute
RUN chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab CI user
RUN useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as service
RUN gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
RUN gitlab-runner start

# RUN gitlab-runner register --url https://127.0.0.1/ --registration-token 5LzhskW-FYv3AWZhx-wX

ENTRYPOINT ["gitlab-runner", "register", "--url", "https://127.0.0.1/", "--registration-token", "5LzhskW-FYv3AWZhx-wX"]