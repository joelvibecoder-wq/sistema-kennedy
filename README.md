# Kennedy Presente

Sistema web de apoio ao registro de estudantes e ao acompanhamento de presença, desenvolvido como projeto educacional para o Colégio Estadual Presidente Kennedy.

> **Aviso:** projeto demonstrativo. Não é um sistema oficial da SEED-PR e não possui integração oficial com o RCO. Utilize dados fictícios ou autorizados para testes.

## Objetivo

Facilitar o cadastro de estudantes e a organização de informações de frequência em uma interface web, com autenticação e armazenamento em nuvem.

## Funcionalidades

- Cadastro e acesso de usuários por e-mail e senha com Firebase Authentication.
- Área administrativa com controle de acesso por função.
- Cadastro de estudantes.
- Armazenamento e sincronização dos dados pelo Cloud Firestore.
- Interface responsiva para computador e dispositivos móveis.
- Cópia local de apoio no navegador, sem substituir o banco de dados na nuvem.

> Os recursos disponíveis dependem da versão atualmente publicada. Este README descreve o funcionamento conhecido do projeto; não afirma que integração com sistemas oficiais esteja habilitada.

## Tecnologias

- HTML, CSS e JavaScript
- Firebase Authentication
- Cloud Firestore
- GitHub para versionamento
- Render para publicação da aplicação

## Configuração do Firebase

1. Crie ou selecione um projeto no [Firebase Console](https://console.firebase.google.com/).
2. Registre uma aplicação Web e copie as configurações do Firebase.
3. Ative o método de autenticação **E-mail/senha** em Authentication.
4. Crie o banco de dados Cloud Firestore.
5. Cadastre a conta administrativa pelo Authentication.
6. No Firestore, crie a coleção `admins` e um documento cujo ID seja o **UID** da conta administrativa. Adicione o campo:
   - `role`: `admin` (tipo texto)
7. Configure as regras do Firestore para permitir acesso somente conforme a autenticação e as permissões necessárias. Não publique regras abertas.

### Segurança

- Não coloque senhas, chaves privadas ou credenciais de serviço no repositório.
- A configuração web do Firebase identifica o projeto, mas a proteção dos dados depende também das regras do Firestore e das verificações de autorização.
- Não compartilhe dados pessoais reais de estudantes em demonstrações públicas.

## Executar e publicar

O projeto é versionado no GitHub e publicado no Render. Para atualizar a versão hospedada:

1. Faça as alterações nos arquivos do projeto.
2. Revise e teste localmente.
3. Envie as alterações para a branch conectada ao Render.
4. Aguarde a implantação terminar e verifique a aplicação publicada.

As configurações específicas de build e execução devem seguir as configurações já definidas no serviço do Render.

## Estrutura do projeto

A estrutura de arquivos pode variar conforme a versão. Consulte os arquivos e pastas deste repositório para identificar a entrada da aplicação e os módulos de autenticação e Firestore.

## Limitações conhecidas

- O projeto é educacional e demonstrativo.
- Não realiza integração oficial com o RCO/SEED-PR.
- O registro de presença não deve ser considerado oficial sem integração e validação institucional.
- A cópia local do navegador é apenas auxiliar; o Firestore é o armazenamento em nuvem configurado.

## Licença

Consulte a licença indicada neste repositório. Se nenhuma licença estiver definida, os direitos autorais permanecem com os autores do projeto.
