# Feature: Repo Interrogator

## Description

A powerful and complex extension that acts as a "reality check" by connecting architectural plans (like ADRs) to the actual code. It will analyze the codebase to identify discrepancies, enforce architectural constraints, and answer complex questions about the implementation.

## Tasks

-   [done] Implement code parsing and analysis capabilities (e.g., using ASTs).
-   [done] Integrate with the `adr-manager` to cross-reference decisions with code.
-   [done] Develop a query engine to answer natural language questions about the codebase.
-   [done] Implement logic to detect architectural drift and violations.

## User Stories

-   As an architect, I want to ask "Does the current implementation of the payment service adhere to ADR-005?" to ensure compliance.
-   As a developer, I want to ask "Where is the authentication logic implemented?" to quickly locate relevant code.
-   As a tech lead, I want to be alerted when a change introduces a dependency that violates our stated architecture.
