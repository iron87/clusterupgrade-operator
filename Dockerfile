FROM quay.io/operator-framework/ansible-operator:v1.29.0

COPY requirements.yml ${HOME}/requirements.yml
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible
USER 0
RUN yum -y install openssh-clients
USER 1001
COPY watches.yaml ${HOME}/watches.yaml
COPY --chown=ansible roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/
