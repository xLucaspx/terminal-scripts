# Nvidia

Arquivos de configuração e dicas sobre a ativação da placa de vídeo Nvidia.

## Ativação

Dependendo da placa e do sistema operacional, pode ser que ela não esteja ativada por padrão. Acredito que a melhor
opção é o modo híbrido. Pode ser necessário instalar e configurar os _drivers_ da placa manualmente. O ideal é pesquisar
o processo específico para a placa e o sistema operacional em questão. Pode ser preciso desativar o _secure boot_.

## Arquivos de configuração

Pode ser que a configuração da placa conflite com as configurações do sistema operacional; se for o caso, é possível
realizar ajustes criando arquivos dentro de `/etc/modprobe.d/`. O nome do arquivo em si não importa, desde que esteja em
tal diretório e tenha a extensão `.conf`.

> [!note]
> Apenas criar arquivos de configuração não tem efeito, é necessário aplicar os ajustes criados em `/etc/modprobe.d/`;
> para isso, o ideal é pesquisar o passo a passo de acordo com o sistema operacional.

- [`nvidia-power-management.conf`](./nvidia-power-management.conf): Usado para configurar a placa para suspensão
	automática, evitando travamentos.

## _Scripts_

Utilitários relacionados à placa de vídeo Nvidia.

- [`nvidia-offload`](./nvidia-offload): Em alguns sistemas operacionais, é possível que não exista um comando para
	executar uma aplicação explicitamente utilizando a placa de vídeo. Este _script_ serve para isso.
