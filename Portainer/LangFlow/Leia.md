# Instruções Vector Storage Supabase

- No video Base usado Ollama para gerar os embeddings , para criar um banco de dados no Supabase voce deve usar este comando

```

-- Habilitar a extensão pgvector para trabalhar com vetores de embedding
CREATE EXTENSION IF NOT EXISTS vector;

-- Habilitar a extensão para geração de UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Criar uma tabela para armazenar seus documentos
CREATE TABLE documents (
    id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),  -- Usando UUID para o ID
    content text,  -- Corresponde ao Document.pageContent
    metadata jsonb,  -- Corresponde ao Document.metadata
    embedding vector(4096)  -- Ajustado para 4096 conforme necessário
);

-- Criar uma função para buscar documentos
CREATE OR REPLACE FUNCTION match_documents (
    query_embedding vector(4096),
    match_count int DEFAULT null,
    filter jsonb DEFAULT '{}'
) RETURNS TABLE (
    id uuid,  -- Ajustado para retornar UUID
    content text,
    metadata jsonb,
    similarity float
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.id,              -- Usando o alias 'd' para a tabela 'documents'
        d.content,
        d.metadata,
        1 - (d.embedding <=> query_embedding) AS similarity
    FROM documents d     -- Definindo 'd' como alias para 'documents'
    WHERE d.metadata @> filter
    ORDER BY d.embedding <=> query_embedding
    LIMIT match_count;
END;
$$;


```