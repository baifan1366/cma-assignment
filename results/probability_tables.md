# Probability Tables / Input Distributions

## Arrival Process

| Period | Start | End | Mean Inter-arrival Time | Lambda |
|---|---:|---:|---:|---:|
| Non-peak 1 | 0 | 120 | 8.00 min | 0.1250 |
| Peak | 120 | 360 | 4.00 min | 0.2500 |
| Non-peak 2 | 360 | 480 | 8.00 min | 0.1250 |

Formula: `inter-arrival time = -log(1 - R) / lambda`

## Priority Distribution

| Priority | Label | Probability | CDF | R range |
|---:|---|---:|---:|---|
| 1 | Critical | 0.15 | 0.15 | 0.00 <= R < 0.15 |
| 2 | Urgent | 0.35 | 0.50 | 0.15 <= R < 0.50 |
| 3 | Non-urgent | 0.50 | 1.00 | 0.50 <= R < 1.00 |

## Service Time Distribution

| Priority | Label | Mean Service Time | Mu |
|---:|---|---:|---:|
| 1 | Critical | 30.00 min | 0.0333 |
| 2 | Urgent | 20.00 min | 0.0500 |
| 3 | Non-urgent | 10.00 min | 0.1000 |

Formula: `service time = -log(1 - R) / mu`
