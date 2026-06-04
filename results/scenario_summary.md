# Scenario Comparison Summary

| Scenario | Doctors | Priority Queue | Arrivals | Served Within Shift | Avg Wait (min) | Avg Queue | Wait Prob. | Utilization |
|---|---:|---|---:|---:|---:|---:|---:|---:|
| baseline | 3 | Yes | 85.90 | 67.03 | 67.69 | 9.96 | 0.78 | 83.9% |
| improved | 4 | Yes | 85.90 | 80.57 | 22.07 | 3.66 | 0.57 | 69.2% |
| fifo | 3 | No | 85.90 | 73.03 | 47.97 | 7.04 | 0.78 | 83.1% |

## Priority Waiting Time Breakdown

| Scenario | P1 Critical (min) | P2 Urgent (min) | P3 Non-urgent (min) |
|---|---:|---:|---:|
| baseline | 7.35 | 28.92 | 116.54 |
| improved | 2.97 | 7.81 | 39.31 |
| fifo | 45.38 | 47.43 | 49.11 |

## Key Insights

- Lowest average waiting time: **improved** (22.07 minutes).
- Highest patients served within shift: **improved** (80.57 patients).
- Lowest critical-patient waiting time: **improved** (2.97 minutes).
