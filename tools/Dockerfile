FROM ubuntu:16.04

RUN apt-get update && apt-get install -y python python-pip vim \
libssl-dev openssh-client git unzip

ENV ANSIBLE_VERSION=2.4

RUN apt-get clean && rm -rf /var/lib/apt/lists

RUN pip install ansible==${ANSIBLE_VERSION}

ENV PACKER_VERSION=1.1.3

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./

RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

ENV TERRAFORM_VERSION=0.11.3

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip ./

RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin
RUN rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

ENTRYPOINT ["/bin/bash"]