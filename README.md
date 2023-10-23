# VSCode and Jupyter Notebooks as Dockerized Servers

The purpose of the repo is to learn how to build custom vscode and notebook servers.

## Difference Compared to Kubeflow Examples

1. Get rid of S6 Overlay (I wasn't able to make it work)
2. Update Ubuntu version
3. Add GPU support via `nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04` base image
4. Add password to `jovyan` user
5. Grant root access to `jovyan` user (sometimes it's necessary to build/install dependencies)

## References

1. Kubeflow examples https://github.com/kubeflow/kubeflow/tree/master/components/example-notebook-servers
2. How to understand S6 Overlay v3 by Italo Baeza Cabrera https://darkghosthunter.medium.com/how-to-understand-s6-overlay-v3-95c81c04f075