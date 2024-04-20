DROP DATABASE IF EXISTS escola_tecnologia;
CREATE DATABASE escola_tecnologia;
USE escola_tecnologia;

-- Tabela de Alunos
CREATE TABLE aluno (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    data_nascimento DATE NOT NULL
);

-- Tabela de Cursos
CREATE TABLE curso (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(200),
    carga_horaria INT NOT NULL
);

CREATE TABLE tecnologia(
    id_tecnologia INT AUTO_INCREMENT PRIMARY KEY,
    nome_tecnologia VARCHAR(80) NOT NULL
);

CREATE TABLE curso_tecnologia (
    id_curso INT NOT NULL,
    id_tecnologia INT NOT NULL,
    PRIMARY KEY (id_curso, id_tecnologia),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_tecnologia) REFERENCES tecnologia(id_tecnologia)
);

-- Tabela de Professores
CREATE TABLE professor (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20)
);

-- Tabela de Turmas
CREATE TABLE turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    id_professor INT NOT NULL,
    sala CHAR(2) NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL,
    dia_semana VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

-- Tabela de Matrículas
CREATE TABLE matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,
    data_matricula DATE NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
);

-- Inserir alguns dados de exemplo
INSERT INTO aluno (nome, email, telefone, data_nascimento) VALUES
    ('João Silva', 'joao@example.com', '123456789', '1998-05-15'),
    ('Maria Santos', 'maria@example.com', '987654321', '2000-10-20');

INSERT INTO professor (nome, email, telefone, especialidade) VALUES
    ('Kauan', 'kauans@example.com', '555123456', 'Desenvolvimento Web'),
    ('Marcelo', 'marcelo@example.com', '555987654', 'Ciência de Dados');

INSERT INTO curso (nome, descricao, carga_horaria) VALUES
    ('PHP ESSENCIAL', 'Curso completo de PHP', 300),
    ('LINGUAGEM PYTHON', 'Curso de Python', 250),
    ('LINGUAGEM SQL','Curso de Mysql/SQL', 90),
    ('ANÁLISE DE DADOS','Curso de Análise de dados', 90);

INSERT INTO tecnologia(id_tecnologia, nome_tecnologia) VALUES
    (1,'HTML'),
    (2,'CSS'),
    (3,'JAVASCRIPT'),
    (4,'PYTHON'),
    (5,'JAVA');

INSERT INTO curso_tecnologia (id_curso, id_tecnologia)
VALUES
    -- Relações para o curso PHP ESSENCIAL
    (1, 1),  -- HTML
    (1, 2),  -- CSS
    (1, 3),  -- JAVASCRIPT
    
    -- Relações para o curso LINGUAGEM PYTHON
    (2, 4),  -- PYTHON
    
    -- Relações para o curso ANÁLISE DE DADOS
    (4, 4); -- PYTHON



INSERT INTO turma (id_curso, id_professor, sala, horario_inicio, horario_fim, dia_semana) VALUES
    (1, 1, 'Sala 01', '19:00:00', '21:00:00', 'Segunda-feira'),
    (1, 1, 'Sala 01', '14:00:00', '16:00:00', 'Quarta-feira'),
    (2, 2, 'Sala 02', '16:00:00', '18:00:00', 'Sexta-feira'),
    (3, 2, 'Sala 02', '16:00:00', '18:00:00', 'Sexta-feira');

INSERT INTO matricula (id_aluno, id_turma, data_matricula) VALUES
    (1, 1, '2024-01-01'),
    (1, 2, '2024-01-01'),
    (2, 3, '2024-01-02');

---- TESTES ----
SELECT
    c.nome AS curso_nome,
    t.nome_tecnologia AS tecnologia_nome
FROM
    curso_tecnologia ct
    JOIN curso c ON ct.id_curso = c.id_curso
    JOIN tecnologia t ON ct.id_tecnologia = t.id_tecnologia;
