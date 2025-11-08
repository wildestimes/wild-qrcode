# Feature: adr-manager (Architectural Decision Record Service)

## Description

A structured RAG (Retrieval-Augmented Generation) extension fed by the `docs/adr/` folder. It allows for the creation and querying of Architectural Decision Records (ADRs).

## Tasks

- [in-progress] Implement a RAG service for ADRs.
    - [done] Define gRPC service and generate code.
    - [done] Implement gRPC server and `CreateAdr` method.
- [done] Create a command to initialize a new ADR.
- [done] The creation command should prompt for Context, Options, and Consequences.
- [done] Implement a query interface to search and retrieve existing ADRs.
- [done] Use Gemini to help flesh out trade-offs during ADR creation.

## User Stories

- As an architect, I want to create a new ADR by filling in a structured template so that I can maintain a consistent format for my design decisions.
- As a developer, I want to ask questions about past architectural decisions in natural language so that I can quickly understand the rationale behind them.
