# ADR 002: Scoped Azure Policy Enforcement

## Status

Accepted

## Context

The landing zone requires governance controls that enforce required resource metadata without unintentionally affecting unrelated Azure projects within the subscription.

## Decision

Define the custom `Environment` tag policy at subscription scope and assign it specifically to the landing zone resource group.

For the DEV environment:

- Policy definition: `Require Environment tag - dev`
- Enforcement scope: `rg-landingzone-dev`
- Effect: Deny resources that do not contain the required `Environment` tag

The policy definition and resource-group assignment are maintained as separate Bicep deployments.

## Rationale

Keeping the policy definition at subscription scope allows centralized governance, while limiting the assignment to the landing zone prevents the policy from affecting unrelated workloads.

This provides a safer governance boundary while maintaining reusable policy-as-code.

## Validation

Policy enforcement was tested using two deployment scenarios:

- A resource without the required `Environment` tag was denied.
- A compliant resource containing `Environment=dev` and the existing required `CostCenter` tag was successfully created.

The temporary validation resource was removed after testing.

## Consequences

Resources deployed within the governed resource group must comply with the assigned tagging policy.

Additional landing zones can reuse the policy definition while receiving independently scoped policy assignments.