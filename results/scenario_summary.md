# Scenario Comparison Summary

| Scenario | Doctors | Priority Queue | Arrivals | Served Within Shift | Avg Wait (min) | Avg Queue | Wait Prob. | Utilization |
|---|---:|---|---:|---:|---:|---:|---:|---:|
<<<<<<< HEAD
| baseline | 3 | Yes | 85.90 | 67.03 | 67.69 | 9.96 | 0.78 | 83.9% |
| improved | 4 | Yes | 85.90 | 80.57 | 22.07 | 3.66 | 0.57 | 69.2% |
| fifo | 3 | No | 85.90 | 73.03 | 47.97 | 7.04 | 0.78 | 83.1% |
=======
| baseline | 3 | Yes | 76.23 | 68.23 | 25.40 | 3.53 | 0.65 | 78.5% |
| improved | 4 | Yes | 76.23 | 73.23 | 5.26 | 0.76 | 0.33 | 60.8% |
| fifo | 3 | No | 76.23 | 70.20 | 19.10 | 2.64 | 0.64 | 78.2% |
>>>>>>> 98a47cf510c2ed0828206d25de21103eaff1de40

## Priority Waiting Time Breakdown

| Scenario | P1 Critical (min) | P2 Urgent (min) | P3 Non-urgent (min) |
|---|---:|---:|---:|
<<<<<<< HEAD
| baseline | 7.35 | 28.92 | 116.54 |
| improved | 2.97 | 7.81 | 39.31 |
| fifo | 45.38 | 47.43 | 49.11 |

## Key Insights

- Lowest average waiting time: **improved** (22.07 minutes).
- Highest patients served within shift: **improved** (80.57 patients).
- Lowest critical-patient waiting time: **improved** (2.97 minutes).
=======
| baseline | 3.98 | 11.21 | 43.02 |
| improved | 1.53 | 3.05 | 8.24 |
| fifo | 16.66 | 18.81 | 19.94 |

## Key Insights

- Lowest average waiting time: **improved** (5.26 minutes).
- Highest patients served within shift: **improved** (73.23 patients).
- Lowest critical-patient waiting time: **improved** (1.53 minutes).
>>>>>>> 98a47cf510c2ed0828206d25de21103eaff1de40
