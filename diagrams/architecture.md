# Enterprise Azure Landing Zone Architecture

```mermaid
flowchart TB
    subgraph Azure["Azure Subscription"]
        Policy["Azure Policy<br/>Require Environment Tag"]

        subgraph DEV["DEV Landing Zone — rg-landingzone-dev"]
            HUB["Hub VNet<br/>vnet-hub-dev<br/>10.0.0.0/16"]
            MGMT["Management Subnet<br/>snet-management<br/>10.0.1.0/24"]

            SPOKE["Spoke VNet<br/>vnet-spoke-dev<br/>10.1.0.0/16"]
            APP["Application Subnet<br/>snet-app<br/>10.1.1.0/24"]

            LAW["Log Analytics Workspace<br/>law-landingzone-dev"]

            HUB --> MGMT
            SPOKE --> APP
            HUB <-->|VNet Peering| SPOKE
        end

        Policy -->|Scoped Assignment| DEV
    end

    BICEP["Modular Bicep IaC"] --> DEV
    BICEP --> Policy
```

## Environment Strategy

| Environment | Hub VNet | Spoke VNet | Deployment |
|---|---|---|---|
| DEV | 10.0.0.0/16 | 10.1.0.0/16 | Deployed |
| PROD | 10.10.0.0/16 | 10.11.0.0/16 | Validated only |

Production uses the same modular Bicep templates with environment-specific parameters, allowing infrastructure reuse without duplicating deployment logic.

