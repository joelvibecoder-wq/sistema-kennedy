# Planejamento — Integração do Kennedy Presente com RCO/LRCO

> Documento independente. Não altera `index.html`, `mobile.html` nem `PLANEJAMENTO-APP.md`. Planejamento técnico e institucional; não contém credenciais nem dados reais de estudantes.

## 1. Objetivo

Planejar como o Kennedy Presente poderá registrar a chegada de estudantes por leitura de QR Code na entrada da escola e, se a SEED-PR autorizar uma integração oficial, trocar informações com o RCO/LRCO.

O resultado desejado é:
- registrar que um estudante passou pela entrada, com data e horário;
- mostrar essa informação no painel da escola;
- comparar chegada, turno, turma e horário;
- sinalizar situações que precisam de conferência;
- futuramente, enviar informações ao sistema oficial somente por mecanismo autorizado pela SEED-PR.

**Distinção essencial:** passar o QR Code na portaria comprova apenas um evento de leitura/chegada. Não comprova automaticamente presença em todas as aulas do dia, nem substitui o procedimento oficial de frequência. Um aluno pode chegar atrasado, sair antes, estar em atividade externa ou ter aula em horário diferente.

## 2. Regra institucional e limite da integração

A documentação pública consultada da SEED-PR informa que o RCO/LRCO é o sistema oficial de registro de frequência. A Resolução GS/SEED nº 3.550/2022 institui o Livro Registro de Classe e o LRCO. A Resolução GS/SEED nº 2.865/2023 determina, para a rede estadual, o registro de frequência dos estudantes no horário da aula mediante reconhecimento facial biométrico, com previsão de registro manual em situações técnicas excepcionais. A regulamentação também atribui à instituição a responsabilidade pela fidedignidade dos registros.

Assim:
- o QR do Kennedy Presente deve ser tratado inicialmente como **controle auxiliar de chegada**, não como chamada oficial;
- não presumir que exista API pública do RCO/LRCO;
- não automatizar cliques, formulários, sessões ou chamadas internas do RCO;
- não guardar senha de professor, funcionário ou estudante;
- não contornar autenticação, biometria, permissões ou controles da SEED-PR;
- qualquer gravação direta no RCO/LRCO depende de autorização formal e documentação técnica oficial da SEED-PR.

A escola deve consultar a direção, o Núcleo Regional de Educação (NRE) de Ponta Grossa e os canais oficiais da SEED-PR/DTI para saber se existe integração homologada e quais condições se aplicam.

## 3. Arquitetura proposta

### Componentes

| Componente | Função |
|---|---|
| App Kennedy Presente | Exibir cartão digital e QR individual |
| Leitor na portaria | Ler QR e enviar evento de chegada |
| API do Kennedy Presente | Validar token, horário, escola e autorização |
| Banco de dados | Guardar cadastro mínimo e eventos de leitura |
| Painel da secretaria | Consultar chegadas, atrasos e eventos pendentes |
| Módulo de integração oficial (futuro) | Trocar dados com RCO/LRCO apenas por interface autorizada |

### Fluxo inicial — sem integração com RCO

1. O estudante apresenta o QR na entrada.
2. O leitor envia o token ao servidor por conexão segura.
3. O servidor verifica se o token existe, está ativo e pertence ao cadastro autorizado.
4. O servidor registra um evento com data/hora oficial do servidor, leitor/portão e resultado.
5. O painel mostra “chegada registrada” e a hora.
6. Releituras próximas são sinalizadas como duplicadas, sem criar várias chegadas.
7. A equipe escolar confere exceções e aplica os procedimentos oficiais de frequência no sistema da SEED-PR.

O QR deve conter apenas um token aleatório opaco. Não incluir nome, CGM, turma, e-mail, foto ou outros dados pessoais no conteúdo do QR.

## 4. Como comparar chegada com horário escolar

A escola deverá fornecer e validar os horários oficiais de cada turno e, se necessário, as grades de turma.

Exemplo meramente fictício:
- início do turno: 07:30;
- tolerância de chegada: definida pela escola;
- leitura às 07:24: chegada antes do início;
- leitura às 07:42: chegada após o início, sinalizada para conferência;
- nenhuma leitura: “sem leitura registrada”, e **não** “falta confirmada”.

O sistema não deve transformar automaticamente ausência de leitura em falta. Pode haver esquecimento do cartão, falha de internet, leitor indisponível, entrada alternativa, atividade autorizada ou outro motivo.

O painel deve usar estados distintos:
- **Chegada registrada:** QR válido lido no portão.
- **Chegada após o horário:** leitura ocorreu depois do limite definido pela escola.
- **Sem leitura registrada:** nenhum evento foi encontrado; não significa falta confirmada.
- **Leitura inválida:** token desconhecido, bloqueado ou expirado.
- **Conferência necessária:** evento duplicado, horário incoerente ou exceção.
- **Frequência oficial:** situação consultada ou lançada no sistema oficial por pessoa autorizada, quando aplicável.

## 5. Integração futura com RCO/LRCO — somente se autorizada

### Etapa A — Solicitar orientação oficial

A direção da escola deverá formalizar consulta à SEED-PR/DTI, com apoio do NRE, solicitando resposta documentada para estas perguntas:

1. Existe API, serviço de integração ou mecanismo oficial homologado para consultar matrículas, turmas e frequência do RCO/LRCO?
2. Existe mecanismo homologado para enviar ou atualizar frequência?
3. Qual sistema é a fonte oficial de identidade do estudante e de matrícula ativa?
4. Quais perfis podem autorizar essa integração?
5. A leitura de QR na portaria pode ser usada como evidência auxiliar? Em quais condições?
6. Como tratar atraso, saída antecipada, entrada alternativa, falha técnica, duplicidade e atividade externa?
7. Quais requisitos de segurança, auditoria, LGPD e homologação são exigidos?
8. A regra vigente permite algum fluxo diferente do registro oficial atualmente exigido?

**Não avançar para escrita automática no RCO/LRCO sem resposta e autorização formal.**

### Etapa B — Integração técnica autorizada

Se a SEED-PR fornecer uma API ou mecanismo oficial:
- usar somente documentação, endpoints e credenciais emitidos oficialmente;
- autenticar serviço a serviço, com credenciais guardadas no servidor;
- aplicar menor privilégio, HTTPS e rotação de credenciais;
- mapear o identificador institucional do estudante sem depender apenas do nome;
- consultar matrícula, turma, turno e calendário por fonte oficial;
- enviar somente os campos permitidos pela documentação;
- registrar protocolo, horário, resultado e identificador da operação;
- implementar idempotência para impedir lançamentos duplicados;
- tratar erros e indisponibilidade sem inventar presença ou falta;
- disponibilizar trilha de auditoria e procedimento de correção.

Se não existir integração oficial, manter o Kennedy Presente como painel auxiliar de chegada e não tentar manipular a interface interna do RCO/LRCO.

### Etapa C — Homologação e piloto

1. Desenvolver em ambiente de teste oficialmente disponibilizado.
2. Usar estudantes e matrículas fictícios.
3. Comparar os eventos do QR com os procedimentos oficiais, sem gravar frequência real.
4. Obter aprovação técnica e institucional.
5. Fazer piloto pequeno, supervisionado e autorizado.
6. Auditar divergências antes de ampliar o uso.

## 6. Modelo de dados proposto

### Evento de chegada
- identificador aleatório do evento;
- identificador interno do estudante;
- data e hora geradas pelo servidor;
- identificador do leitor/portão;
- resultado da validação;
- indicador de duplicidade;
- origem do evento;
- estado de conferência.

### Configuração de horário
- escola;
- turno;
- horário de início;
- tolerância aprovada;
- vigência da configuração;
- responsável pela aprovação.

### Registro de integração (somente futuro)
- identificador da operação;
- referência ao evento de chegada;
- sistema de destino;
- data/hora da tentativa;
- resultado e código de retorno;
- referência de auditoria;
- usuário ou serviço autorizado responsável.

Não armazenar biometria facial no Kennedy Presente. Não tentar replicar a biometria do sistema oficial.

## 7. Painel da escola

O painel deverá mostrar:
- total de leituras válidas no dia;
- estudantes com chegada registrada;
- chegadas após o horário configurado;
- estudantes sem leitura registrada (sem classificá-los como faltosos);
- leituras inválidas e duplicadas;
- eventos aguardando conferência;
- estado da conexão com o leitor e com o servidor;
- relatório exportável apenas para perfis autorizados.

A atualização visual do painel deve ocorrer assim que o servidor confirmar o evento. A situação oficial de frequência deve aparecer separadamente e só poderá ser exibida se vier de fonte oficial autorizada.

## 8. Segurança, privacidade e proteção de menores

- Aprovação formal da direção e da SEED-PR antes de qualquer integração real.
- Definir finalidade, base legal, responsáveis, retenção e direitos dos titulares conforme LGPD.
- Usar dados fictícios em desenvolvimento e demonstrações.
- Não colocar planilhas, fotos, CGMs, e-mails, tokens ou dados de estudantes no GitHub.
- Não publicar segredos, senhas, cookies, tokens de sessão ou chaves de API.
- Restringir o painel por perfil e autenticação institucional.
- Proteger tráfego com HTTPS e dados armazenados com controles adequados.
- Registrar auditoria de operações administrativas e correções.
- Estabelecer procedimento para falhas do leitor e operação manual.
- Limitar acesso a fotos e dados cadastrais ao estritamente necessário.
- Não usar o QR como mecanismo de vigilância ou como prova absoluta de permanência do estudante na escola.

## 9. Plano de implementação por fases

### Fase 1 — Demonstração
- [ ] Manter modo de teste com estudante fictício.
- [ ] Criar leitor QR de demonstração.
- [ ] Registrar eventos fictícios com data/hora.
- [ ] Exibir painel de chegadas fictícias.
- [ ] Testar QR inválido, duplicado e bloqueado.

**Entrega:** simulação ponta a ponta sem dados reais e sem conexão com RCO.

### Fase 2 — Controle auxiliar autorizado
- [ ] Obter aprovação da direção para piloto de controle de chegada.
- [ ] Definir portão, horários e responsáveis.
- [ ] Configurar autenticação e permissões do painel.
- [ ] Testar contingência quando faltar internet ou energia.
- [ ] Avaliar precisão e fluxo de atendimento.

**Entrega:** controle de chegada separado da frequência oficial.

### Fase 3 — Consulta oficial
- [ ] Solicitar documentação e autorização à SEED-PR/DTI e ao NRE.
- [ ] Confirmar fonte oficial de matrículas, turmas e horários.
- [ ] Implementar consulta somente se houver serviço oficial autorizado.
- [ ] Exibir divergências para conferência humana.

**Entrega:** painel que compara dados autorizados sem alterar a frequência oficial.

### Fase 4 — Escrita oficial (condicional)
- [ ] Confirmar autorização expressa para registrar dados no RCO/LRCO.
- [ ] Receber API/documentação e ambiente de homologação oficiais.
- [ ] Validar regras, permissões e trilha de auditoria.
- [ ] Homologar com dados fictícios.
- [ ] Obter aprovação final antes de qualquer operação real.

**Entrega:** integração de escrita apenas se oficialmente disponibilizada e homologada. Caso contrário, esta fase permanece bloqueada.

## 10. Critérios para considerar o projeto pronto

- A leitura de QR registra apenas chegada e não cria falta automaticamente.
- A ausência de leitura nunca é tratada sozinha como falta confirmada.
- Duplicidades e falhas são detectadas e exibidas.
- Os horários são configurados e aprovados pela escola.
- A equipe autorizada consegue revisar exceções.
- A frequência oficial permanece no fluxo determinado pela SEED-PR.
- Qualquer integração com RCO/LRCO usa somente mecanismo oficial autorizado.
- Há testes, auditoria, segurança, contingência e aprovação institucional.

## 11. Fontes oficiais consultadas

1. **SEED-PR — Acessar Registro de Classe On-line da Rede de Ensino (RCO):**  
   https://www.educacao.pr.gov.br/servicos/Educacao/Professores-e-servidores/Acessar-Registro-de-Classe-On-line-da-Rede-de-Ensino-RCO-JGoM5vo0

2. **Legislação do Paraná — Resolução SEED nº 3.550/2022 (institui LRC/LRCO):**  
   https://www.legislacao.pr.gov.br/legislacao/listarAtosAno.do?action=exibir&codAto=267067&codItemAto=1697000

3. **Legislação do Paraná — Resolução GS/SEED nº 2.865/2023 (registro de frequência por reconhecimento facial biométrico):**  
   https://www.legislacao.pr.gov.br/legislacao/listarAtosAno.do?action=exibir&codAto=293453

4. **SEED-PR — Tutoriais e orientações sobre registro de frequência:**  
   https://www.educacao.pr.gov.br/frequencia/tutoriais-professor-sala-aula

5. **SEED-PR — Sistemas da Seed:**  
   https://www.educacao.pr.gov.br/sistemas

6. **SEED-PR — Presente na Escola:**  
   https://www.educacao.pr.gov.br/presente-escola

## 12. Situação e próxima ação

**Status:** planejamento inicial; integração com RCO/LRCO não implementada e não autorizada neste documento.

Próximo passo recomendado: apresentar este documento à direção e solicitar que a escola, por meio do NRE de Ponta Grossa, consulte formalmente a SEED-PR/DTI sobre a existência de API ou mecanismo oficial homologado para integração.

Até receber autorização e documentação, desenvolver somente a demonstração e o controle auxiliar de chegada, usando dados fictícios.
