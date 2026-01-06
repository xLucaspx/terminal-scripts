# _Scripts_

Meus _scripts_ utilitários. Devem ser armazenados em:

- `~/.local/bin`: Atualmente preferido. Talvez seja necessário adicionar ao `PATH`;
- `/usr/local/bin`: _Scripts_ para todos os usuários.

Para _scripts_ que representam comandos, pode-se remover a extensão `.sh`; nesses casos, é imprescindível utilizar o
_shebang_ correto: `#!/usr/bin/env bash`.

- [`compress-pdf`](./compress-pdf): Utilitário para comprimir arquivos PDF;
- [`compress-pdf-dir`](./compress-pdf-dir): Utilitário para comprimir PDFs recursivamente em um diretório;
- [`run-jar.sh`](./run-jar.sh): Componente para a execução de arquivos `.jar`; se não vai ser utilizado como comando,
	pode ser armazenado em outro local (e.g., `~/.local/lib`).
