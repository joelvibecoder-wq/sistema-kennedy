# Planejamento do Aplicativo Kennedy Presente

> Documento de planejamento. Este arquivo é independente de `index.html` (sistema atual) e `mobile.html` (protótipo do aplicativo). Não contém dados reais de estudantes, credenciais ou segredos.

## 1. Visão geral

**Nome do projeto:** Kennedy Presente  
**Objetivo:** desenvolver um aplicativo web instalável (PWA) para que cada estudante autorizado consulte, no próprio celular, sua identificação escolar digital com foto, CGM e QR Code individual.

O aplicativo deverá funcionar em celulares e computadores, com interface responsiva e possibilidade de instalação na tela inicial. O acesso aos dados reais só será liberado depois da autorização da escola e da implantação de um servidor seguro.

## 2. Objetivos

- Permitir entrada por conta Google institucional.
- Confirmar no servidor que a conta pertence a um estudante autorizado.
- Exibir somente os dados do estudante autenticado.
- Apresentar foto, nome, CGM e QR Code individual.
- Permitir que a escola valide o QR Code por um sistema autorizado.
- Oferecer uma experiência simples, acessível e adequada a celulares.
- Proteger os dados pessoais e manter registros mínimos de acesso e operações administrativas.

## 3. Escopo funcional

### Área do estudante

1. Tela inicial com a identidade visual da escola.
2. Entrada com Google institucional.
3. Validação da identidade no servidor.
4. Exibição do cartão digital com:
   - foto cadastrada pela escola;
   - nome do estudante;
   - CGM;
   - QR Code individual.
5. Atualização dos dados quando houver alteração autorizada.
6. Encerramento seguro da sessão.

### Área administrativa (etapa posterior)

- Acesso restrito a funcionários autorizados.
- Importação controlada de cadastros por arquivo padronizado.
- Associação entre conta institucional e registro escolar.
- Atualização de foto e dados cadastrais.
- Emissão, bloqueio e renovação de identificadores QR.
- Consulta de registros de validação conforme as regras da escola.

A área administrativa não deve ficar acessível a estudantes comuns.

## 4. Fluxo de funcionamento

1. O estudante abre o aplicativo.
2. Seleciona **Entrar com Google**.
3. O Google autentica a conta e fornece um token de identidade.
4. O servidor valida esse token, verifica o domínio institucional permitido e identifica o cadastro correspondente.
5. O servidor retorna apenas os dados necessários para o cartão daquele estudante.
6. O aplicativo apresenta o cartão e o QR Code.
7. Na validação, o sistema autorizado consulta o servidor para verificar se o identificador QR é válido e está ativo.

**Importante:** o aplicativo não deve confiar apenas em informações guardadas no navegador. A autorização e a validação dos dados devem ocorrer no servidor.

## 5. Arquitetura técnica proposta

| Camada | Responsabilidade |
|---|---|
| Aplicativo web/PWA | Interface para celular, instalação e exibição do cartão |
| Login Google | Autenticação da conta institucional |
| API/backend | Validação de identidade, autorização e entrega dos dados |
| Banco de dados | Cadastros autorizados, associação de conta e token QR |
| Armazenamento de imagens | Fotos escolares com acesso controlado |
| Validador QR | Consulta ao servidor para validar o identificador |

### Tecnologias possíveis

- **Frontend:** HTML, CSS e JavaScript no protótipo; evolução para uma estrutura PWA.
- **Autenticação:** Google Identity Services / OAuth 2.0, configurado pela escola.
- **Backend:** Node.js com API HTTPS (ou tecnologia equivalente aprovada pela equipe responsável).
- **Banco de dados:** PostgreSQL.
- **Hospedagem:** serviço com HTTPS, variáveis secretas protegidas, backups e monitoramento.

A escolha final das tecnologias e dos fornecedores deve ser aprovada pela escola ou equipe técnica responsável.

## 6. Modelo de dados sugerido

Estrutura conceitual mínima:

### Estudante
- identificador interno aleatório;
- nome;
- CGM;
- e-mail institucional;
- referência da foto;
- turma (se necessária);
- situação do cadastro.

### Identidade de acesso
- identificador do provedor Google;
- identificador interno do estudante;
- situação da autorização.

### Identificador QR
- token aleatório e não sequencial;
- estudante associado no servidor;
- situação (ativo, bloqueado ou substituído);
- datas de criação e atualização.

Não colocar nome, CGM, e-mail ou outros dados pessoais diretamente dentro do QR Code. O QR deve conter somente um identificador aleatório, que será verificado pelo servidor.

## 7. Segurança e privacidade

- Obter autorização formal da direção e dos responsáveis institucionais antes de usar dados reais.
- Definir com a escola a base legal, finalidade, prazo de retenção e responsáveis pelo tratamento dos dados, observando a LGPD.
- Não solicitar nem armazenar a senha Google do estudante.
- Validar tokens de autenticação no backend; nunca confiar somente no frontend.
- Restringir o acesso ao domínio institucional aprovado e a cadastros previamente autorizados.
- Garantir que cada estudante veja somente seu próprio cartão.
- Usar HTTPS, controle de sessão, proteção contra tentativas abusivas e permissões mínimas.
- Guardar segredos somente no servidor, em variáveis de ambiente protegidas.
- Limitar o acesso administrativo e registrar operações relevantes sem armazenar dados excessivos.
- Definir processo para corrigir dados, bloquear acessos e responder a incidentes.
- Usar dados fictícios durante o desenvolvimento e os testes.

**Atenção:** foto e CGM são dados pessoais. Não publicar planilhas, fotos ou cadastros de estudantes em repositórios públicos. O repositório de código deve conter apenas código e exemplos fictícios.

## 8. Etapas de desenvolvimento

### Etapa 1 — Planejamento e aprovação
- Validar o objetivo com a direção e a equipe responsável.
- Confirmar quais contas Google institucionais serão aceitas.
- Definir quem pode administrar cadastros e validar QR Codes.
- Aprovar regras de privacidade e segurança.

**Entrega:** requisitos aprovados e responsáveis definidos.

### Etapa 2 — Protótipo visual
- Revisar a interface de `mobile.html`.
- Melhorar a navegação em telas pequenas.
- Preparar estados de carregamento, erro, acesso negado e sessão encerrada.
- Manter dados de demonstração fictícios.

**Entrega:** protótipo navegável, sem autenticação ou dados reais.

### Etapa 3 — Backend e banco de dados
- Criar API HTTPS.
- Criar estrutura de banco de dados.
- Implementar cadastro e associação de contas a estudantes.
- Implementar autorização por perfil.
- Preparar armazenamento protegido de fotos.

**Entrega:** backend de teste com registros fictícios.

### Etapa 4 — Login institucional
- Criar configuração OAuth no ambiente administrado pela escola.
- Configurar origens e domínios permitidos.
- Validar o token Google no servidor.
- Relacionar a identidade autenticada ao cadastro autorizado.
- Implementar saída e expiração de sessão.

**Entrega:** login de teste funcionando com contas de teste autorizadas.

### Etapa 5 — Cartão digital e QR Code
- Buscar os dados do estudante autenticado no servidor.
- Exibir foto, nome e CGM.
- Gerar ou recuperar token QR individual no servidor.
- Implementar validação online do QR.
- Permitir bloqueio e substituição de QR comprometido.

**Entrega:** cartão de demonstração com QR validável.

### Etapa 6 — Testes e segurança
- Testar em Android, iPhone e computador.
- Testar conta não autorizada e sessão expirada.
- Verificar se um estudante não consegue consultar dados de outro.
- Testar QR inválido, bloqueado e duplicado.
- Revisar permissões, logs, backups e recuperação.
- Corrigir falhas antes de qualquer uso real.

**Entrega:** relatório de testes e lista de pendências resolvidas.

### Etapa 7 — Implantação controlada
- Obter aprovação final da escola.
- Configurar domínio, HTTPS e ambiente de produção.
- Cadastrar dados por processo autorizado e seguro.
- Orientar estudantes e funcionários.
- Monitorar o funcionamento e manter canal de suporte.

**Entrega:** versão piloto autorizada pela escola.

## 9. Critérios de conclusão

O aplicativo só poderá ser considerado pronto para uso real quando:

- o login Google institucional for validado no backend;
- somente contas autorizadas conseguirem entrar;
- cada estudante visualizar exclusivamente o próprio cadastro;
- foto e CGM vierem de fonte institucional autorizada;
- cada QR for único, aleatório e validado pelo servidor;
- houver processo para bloquear e substituir QR;
- testes de segurança e privacidade forem aprovados;
- a escola autorizar formalmente a implantação.

## 10. Riscos e cuidados

| Risco | Prevenção |
|---|---|
| Conta pessoal tentar acessar | Restringir domínio e lista de cadastros no servidor |
| Estudante visualizar dados de outro | Autorizar cada consulta com base na sessão autenticada |
| QR copiado ou compartilhado | Validar no servidor e permitir bloqueio/substituição |
| Exposição de fotos ou CGM | Armazenamento privado e acesso autenticado |
| Perda de dados | Backups e procedimento de recuperação |
| Uso antes da aprovação | Manter ambiente de demonstração com dados fictícios |

## 11. Situação atual

- [x] Repositório do projeto existente.
- [x] Sistema atual mantido em `index.html`.
- [x] Protótipo móvel separado em `mobile.html`.
- [ ] Planejamento aprovado pela escola.
- [ ] Configuração oficial do Google OAuth.
- [ ] Backend e banco de dados.
- [ ] Integração com cadastro institucional autorizado.
- [ ] Validação de QR Code no servidor.
- [ ] Testes de segurança e acessibilidade.
- [ ] Implantação autorizada.

## 12. Próximas prioridades

1. Apresentar este planejamento à direção/equipe de tecnologia da escola.
2. Confirmar domínio institucional, responsáveis e regras de acesso.
3. Desenvolver o backend de teste com dados fictícios.
4. Integrar o login Google institucional.
5. Conectar o protótipo móvel à API.
6. Realizar testes e obter aprovação antes de usar dados reais.

---

**Status do documento:** planejamento inicial.  
**Observação:** a versão atual de `mobile.html` é somente um protótipo de interface. Login Google real, backend, banco de dados e integração institucional ainda precisam ser implementados e aprovados.
