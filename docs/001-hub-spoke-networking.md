# ADR 001: Hub-and-Spoke Network Architecture

## Status

Accepted

## Context

The landing zone requires a network design that separates shared infrastructure from application workloads while supporting controlled connectivity between environments and services.

## Decision

Use a hub-and-spoke virtual network architecture.

The DEV environment contains:

- Hub VNet: `vnet-hub-dev` — `10.0.0.0/16`
- Management subnet: `snet-management` — `10.0.1.0/24`
- Spoke VNet: `vnet-spoke-dev` — `10.1.0.0/16`
- Application subnet: `snet-app` — `10.1.1.0/24`
- Bidirectional VNet peering between the hub and spoke

The infrastructure is implemented through reusable Bicep modules and environment-specific parameter files.

## Rationale

Hub-and-spoke architecture provides separation between shared services and application workloads while allowing the network topology to expand with additional spokes.

Using parameterized Bicep also allows the same architecture to be validated or deployed across multiple environments without duplicating infrastructure code.

## Consequences

The architecture introduces additional network objects and peering relationships that must be managed consistently.

Bicep resource dependencies are explicitly defined so subnet provisioning completes before VNet peering operations begin.