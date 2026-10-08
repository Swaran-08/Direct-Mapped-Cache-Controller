# Direct-Mapped Cache Controller

A **Verilog HDL** design of a **Direct-Mapped Cache Controller** that connects the CPU with main memory. The controller improves memory access performance by reducing repeated memory accesses through cache hit/miss detection, address decomposition, FSM-based control, and automatic cache updates. The design was implemented and tested using **Xilinx Vivado**.

---

## Features

- Direct-Mapped Cache Organization
- 4 Cache Lines
- 2-Byte Cache Block Size
- 8-Bit Address Bus
- Address Decomposition into Tag, Index, and Offset
- Cache Memory with Valid Bit
- Cache Hit and Miss Detection
- FSM-Based Cache Control
- Automatic Cache Update During Miss Handling
- Direct-Mapped Cache Replacement
- Main Memory Interface
- Verilog Testbench-Based Functional Verification
- RTL Simulation using Xilinx Vivado

---

## Cache Specifications

| Parameter          | Value                      |
| ------------------ | -------------------------- |
| Cache Mapping      | Direct Mapped              |
| Address Width      | 8 Bits                     |
| Data Width        | 8 Bits                     |
| Number of Cache Lines | 4                       |
| Block Size         | 2 Bytes                    |
| Total Cache Capacity | 8 Bytes                 |
| Replacement Method | Direct Mapping (Overwrite) |
| Valid Bit          | Supported                  |
| Hardware Description Language | Verilog HDL       |
| Simulation Tool    | Xilinx Vivado              |

---

## Working

1. The CPU provides an 8-bit memory address to the cache controller.
2. The controller separates the address into **Tag**, **Index**, and **Offset** fields.
3. The index selects the corresponding cache line.
4. The stored tag is compared with the tag obtained from the CPU address.
5. When the tags match and the valid bit is set, a **Cache Hit** is detected and the requested data is supplied from the cache.
6. When the tags do not match or the valid bit is cleared, a **Cache Miss** is detected.
7. During a cache miss, the controller retrieves the required 2-byte block from main memory, provides the requested byte to the CPU, and updates the selected cache line with the newly fetched block.
8. When another memory block maps to the same cache index, the previously stored cache block is replaced by the new block, demonstrating the behavior of a Direct-Mapped Cache.

---

## Finite State Machine (FSM)

```text
IDLE
  │
  ▼
COMPARE_TAG
  ├── Hit  ─► CACHE_READ ─► DATA_RETURN
  │
  └── Miss ─► MEMORY_READ ─► CACHE_UPDATE ─► DATA_RETURN
```

---
## Verification

The design has been verified through a comprehensive Verilog testbench covering the following scenarios:

* Reset Verification
* Cache Miss Detection
* Cache Hit Detection
* Cache Block Update
* Cache Replacement
* Conflict Miss
* Cache Full Condition
* Valid Bit Verification
* Main Memory Read Operation

---

## Future Enhancements

* Write-Back Cache Policy
* Write-Allocate Support
* Dirty Bit Implementation
* Set-Associative Cache
* LRU Replacement Policy
* Performance Statistics (Hit Rate & Miss Rate)
* Configurable Cache Parameters

---

## Tools Used

* Verilog HDL
* Xilinx Vivado
* Vivado Simulator

---

## Author

**Peesu SwaranjithReddy**

**Roll No.: 124EC0033**

B.Tech – Electronics and Communication Engineering

National Institute of Technology Rourkela

---
