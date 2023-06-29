# ClusterUpgrade Operator 

This project is an Ansible operator built with Operator SDK, designed to execute the playbook located in `playbooks/playbook.yaml`. The operator provides a custom resource definition (CRD) called `ClusterUpgrade`, defined in the `config` directory. The CR (Custom Resource) allows passing extra variables to Ansible as key-value pairs within the spec. In this case, we utilize it to pass the IP addresses of the nodes where the `clusterupgrade` role, defined in the `roles/clusterupgrade` directory, will be executed. An example CR can be found in the `config/samples` folder.

## Directory Structure

- `playbooks`: Contains the playbook (`playbook.yaml`) to be executed by the operator.
- `config`: Includes the CRD definition and sample CRs.
- `roles/clusterupgrade`: Holds the Ansible role for performing the cluster upgrade custom logic.
     - `files`: This directory should contain the private key file named `test-key` for connecting to the nodes. The name and path can be modified within the playbook, where the user for node connections can also be configured.


## Building and Deploying the Operator

1. Build and push the operator image to a registry using the following commands:

```bash
make docker-build docker-push
```
Make sure to refer to the [documentation](https://sdk.operatorframework.io/docs/building-operators/ansible/tutorial/#configure-the-operators-image-registry) for modifying the image registry configuration.

2. Deploy the operator to the Kubernetes cluster using the following command:

```bash
make deploy
```

This will install the operator and make it ready to handle CRs of type `ClusterUpgrade`.

## Getting Started

To get started with using the Ansible operator, follow these steps:

1. Create a `ClusterUpgrade` custom resource YAML file based on the provided sample:

```bash
cp config/samples/clusterupgrade_v1alpha1_clusterupgrade.yaml <yourdir>/cr.yaml
```
Modify `config/cr.yaml` to set the desired extra variables and other configuration options.

2. Apply the custom resource to the cluster:

```bash
kubectl apply -f <yourdir>/cr.yaml
```

The operator will pick up the CR and execute the playbook, using the specified extra variables.
