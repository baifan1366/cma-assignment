# Scenario Comparison Summary

| Scenario | Doctors | Priority Queue | Arrivals | Served Within Shift | Avg Wait (min) | Avg Queue | Wait Prob. | Utilization |
|---|---:|---|---:|---:|---:|---:|---:|---:|
| baseline | 3 | Yes | 76.23 | 68.23 | 25.40 | 3.53 | 0.65 | 78.5% |
| improved | 4 | Yes | 76.23 | 73.23 | 5.26 | 0.76 | 0.33 | 60.8% |
| fifo | 3 | No | 76.23 | 70.20 | 19.10 | 2.64 | 0.64 | 78.2% |

## Priority Waiting Time Breakdown

| Scenario | P1 Critical (min) | P2 Urgent (min) | P3 Non-urgent (min) |
|---|---:|---:|---:|
| baseline | 3.98 | 11.21 | 43.02 |
| improved | 1.53 | 3.05 | 8.24 |
| fifo | 16.66 | 18.81 | 19.94 |

## Key Insights

- Lowest average waiting time: **improved** (5.26 minutes).
- Highest patients served within shift: **improved** (73.23 patients).
- Lowest critical-patient waiting time: **improved** (1.53 minutes).
