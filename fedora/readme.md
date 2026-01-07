# Fedora

Quando eu troquei de sistema operacional e passei a utilizar o Fedora (versão 43, Workstation - GNOME), tive que lidar
com diferenças e também aprendi algumas coisas. Deixo algumas delas documentadas para facilitar o processo na próxima
instalação de sistema operacional.

- [Atalhos de teclado](#atalhos-de-teclado)
- [Configuração do terminal](#configuração-do-terminal)
- [Gerenciador(es) de pacotes](#gerenciadores-de-pacotes)
- [LaTeX](#latex)
- [Programas instalados](#programas-instalados)
- [Extensões GNOME](#extensões-gnome)
- [Placa de vídeo](#placa-de-vídeo)

## Atalhos de teclado

Alguns atalhos de teclado não vêm definidos por padrão, mas podemos ajustá-los nas configurações.

- `Ctrl` + `Alt` + `T`: Abrir o terminal. Por padrão, o terminal do Fedora é o `ptyxis`,então esse é o comando que deve
	ser informado ao criar o atalho;
- `Super` + `E`: _Launch home folder_;
- `Super` + `,`: _Launch settings_.

Outros atalhos úteis:

- `Super` + `H`: Minimizar/esconder janela.

## Configuração do terminal

Arquivos utilizados e suas localizações:

- [`custom.sh`](./custom.sh): Usado para não editar diretamente o `.bashrc`. Deve estar em `~/.bashrc.d/`;
- [`inputrc`](./inputrc): Eu costumava alterar o global em `/etc/inputrc`, mas atualmente tenho preferido utilizar
	localmente em `~/.inputrc`.

## Gerenciador(es) de pacotes

O padrão no Fedora parece ser o `dnf`, que eu não conhecia até então. Os comandos são similares aos do `apt`, mas não é
necessário fazer `update` e `upgrade`; no `dnf` ambos fazem a mesma coisa, atualizam os repositórios e os pacotes, i.e.,
um pouco mais simples.

Além disso, algumas coisas podem ser instaladas via `flatpak`; sendo assim, de vez em quando podemos precisar dos
seguintes comandos: `flatpak update` e `flatpak uninstall --unused` (equivalente ao `autoremove`).

## LaTeX

Se instalar via _script_ pode ser necessário instalar, também, o `perl-core` (não vem por padrão no Fedora) e talvez
outros pacotes. A instalação local também apresenta outras questões: a atualização deve ser feita com `tlmgr` e pode
conflitar com pacotes instalados via `dnf`... No futuro, a melhor opção parece ser instalar o `texlive-scheme-full` com
o gerenciador de pacotes.

> [!tip]
> Pode ser interessante consultar a diferença de versões... O LaTeX disponível no gerenciador de pacotes pode ser mais
> desatualizado do que se pensava...

## Programas instalados

- Celluloid: _Player_ poderoso, gosto dele para ouvir músicas e também para executar CDs (parece ter performance melhor
	que o VLC para isso);
- Damask: Usado para alterar o plano de fundo automaticamente; instalado via `flatpak`, precisa das permissões de
	`background` e `wallpaper` (`flatpak permission-set wallpaper wallpaper app.drey.Damask yes` e
	`flatpak permission-set background background app.drey.Damask yes`);
- VLC: Para vídeos ainda é meu _player_ favorito.

No terminal:

- `gnuplot`;
- `octave`;
- Vim (`vim-enhanced`).

Aplicações `.jar`:

- Logisim Evolution;
- MARS;
- RARS.

## Extensões GNOME

- `clipboard-history`(`@alexsaveau.dev`): Usado para armazenar o histórico do _clipboard_. Vale notar que o Linux tem
	diferentes "áreas de transferência": _primary_ (copia ao selecionar e cola com `Shift` + `Ins` ou _mouse wheel_; usada
	principalmente no terminal) e _clipboard_ (copia com `Ctrl` + `C` e cola com `Ctrl` + `V`).

## Placa de vídeo

Para os _notebooks_ com placa de vídeo Nvidia, é necessário realizar um processo relativamente complexo de instalação
dos _drivers_ e ativação da placa. Creio que o ideal é manter no modo híbrido. Além disso, é necessário configurar o
_power management_, senão a máquina trava a cada suspensão (aparentemente tenta preservar as alocações de memória, e
ocorrem erros se não estiver devidamente configurada). Parece que usando Wayland esse problema é comum.

Outra questão é que, mesmo ativando a placa, não encontrei forma de executar um programa explicitamente usando a placa
(nem sei se este é o vocabulário correto). Porém, é possível criar um _script_ pra isso.

Detalhes e arquivos utilizados em: [Nvidia](../nvidia).
