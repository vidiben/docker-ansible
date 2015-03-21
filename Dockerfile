FROM debian:wheezy
MAINTAINER Benoît Vidis

RUN apt-get update && apt-get install -y \
    sudo \
    openssh-client \
    python-dev \
    python-pip 
RUN apt-get clean
RUN pip install paramiko PyYAML Jinja2 httplib2 ansible docker-py 

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN echo "TERM=xterm" >> /etc/environment

RUN rm /etc/localtime
RUN ln -sf /usr/share/zoneinfo/CET /etc/localtime

RUN groupadd -g 1013 user
RUN useradd -g user -u 1013 user
RUN usermod -a -G sudo user
RUN cp -r /etc/skel /home/user
RUN sed -ri "s|#alias ll='ls -l'|alias ll='ls -lh'|" /home/user/.bashrc
RUN echo 'eval `ssh-agent -s`' >> /home/user/.bashrc
RUN echo "export SSH_AUTH_SOCK=/ssh-agent" >> /home/user/.bashrc
RUN sed -ri 's|#force_color_prompt.*|force_color_prompt=yes|' /home/user/.bashrc
RUN echo "export TERM=xterm" >> /home/user/.bashrc

RUN chown -R user:user /home/user
RUN chsh -s /bin/bash user

RUN touch /ssh-agent

ADD bootstrap.sh /root/bootstrap.sh

ENTRYPOINT ["bash", "/root/bootstrap.sh"]
CMD ["ansible"]
