# Debounced Multi-Light Street Lamp Controller for Automatic Dusk-to-Dawn Switching





## 1. Project Overview

The Debounced Multi-Light Street Lamp Controller is a digital design implemented using Verilog HDL. It controls four street lights based on a darkness input.

The design uses a debounce mechanism to prevent unwanted switching caused by unstable sensor inputs. The input must differ from the current light state for four consecutive clock edges before the controller changes its output.

The project covers RTL design, functional verification, logic synthesis, gate-level simulation, floorplanning, power planning, placement, clock tree synthesis, routing, static timing analysis, physical verification, and final GDSII generation.

## 2. Objectives

- Design a debounced street light controller using Verilog HDL.
- Control four lights using a single registered light state.
- Verify the design using a self-checking testbench.
- Perform logic synthesis using Yosys.
- Complete the physical design flow using OpenLane.
- Verify placement, clock tree synthesis, routing, and timing.
- Generate the final GDSII layout using the SKY130 technology library.

## 3. Tools and Technologies

| Tool | Purpose |
|---|---|
| Verilog HDL | RTL design |
| Icarus Verilog | RTL and gate-level simulation |
| GTKWave | Waveform analysis |
| Yosys | Logic synthesis |
| OpenLane v0.21 | Automated RTL-to-GDSII flow |
| OpenROAD | Physical design operations |
| OpenSTA | Static timing analysis |
| Magic | Layout viewing and DRC |
| SKY130 HD | Standard-cell technology library |
| Linux | Development environment |

## 4. Design Specifications

| Parameter | Value |
|---|---|
| Clock frequency | 200 MHz |
| Clock period | 5.0 ns |
| Number of light outputs | 4 |
| Debounce length | 4 consecutive clock edges |
| Reset | Asynchronous, active-high |
| Input | `dark` |
| Output | `lights[3:0]` |
| Target library | `sky130_fd_sc_hd` |
| Die area | 100 × 100 µm |
| Placement target density | 0.3 |

## 5. Working Principle

1. The controller receives a clock, reset, and darkness input.
2. When reset is activated, the counter is cleared and the lights are switched OFF.
3. The controller compares the darkness input with the current light state.
4. If the input matches the current state, the debounce counter is cleared.
5. If the input differs, the counter records consecutive clock edges.
6. After the required four consecutive edges, the light state changes.
7. All four outputs switch together: `0000` for OFF and `1111` for ON.

## 6. RTL Design and Verification

The RTL design contains the debounce counter, registered light state, asynchronous reset, and four light outputs.

### Verification results

- Self-checking testbench: 36/36 checks passed.
- RTL simulation completed.
- Gate-level simulation performed on the synthesized netlist.
- Waveforms inspected using GTKWave.

### Screenshot 1 — RTL design

<img width="1327" height="792" alt="image" src="https://github.com/user-attachments/assets/98f5a471-46e9-4691-979a-a0f29bc868b6" />


### Screenshot 2 — Testbench and simulation output

<img width="1399" height="838" alt="Screenshot 2026-10-10 111621" src="https://github.com/user-attachments/assets/0c0f0dcb-0e79-42d6-bab5-3e9bda113375" />


### Screenshot 3 — GTKWave waveform

<img width="1408" height="856" alt="Screenshot 2026-10-10 123219" src="https://github.com/user-attachments/assets/d671028b-b1bc-4aaa-a1a9-43b241d7fe14" />


## 7. Logic Synthesis

Logic synthesis converts the Verilog RTL into a technology-mapped netlist using standard cells from the SKY130 library.

### Reported synthesis results

| Synthesis flow | Cell count | Cell area |
|---|---:|---:|
| Manual Yosys synthesis | 22 | 220.21 µm² |
| OpenLane synthesis | 26 | 267.76 µm² |

### Screenshot 4 — Yosys synthesis results

<img width="1356" height="846" alt="Screenshot 2026-10-10 112342" src="https://github.com/user-attachments/assets/08ab9782-50b2-4764-87dc-656d792470d7" />
<img width="1399" height="852" alt="Screenshot 2026-10-10 112204" src="https://github.com/user-attachments/assets/c1257e12-ec2a-4c9c-b237-1b8ca8c11b0f" />

### Screenshot 5 — OpenLane synthesis results

<img width="1344" height="833" alt="Screenshot 2026-10-10 135425" src="https://github.com/user-attachments/assets/d6ef3433-90f0-4eb4-a11b-c9b899f2ffe3" />
## Gate-level simulation result
<img width="1337" height="883" alt="Screenshot 2026-10-10 152601" src="https://github.com/user-attachments/assets/4921100a-aaec-4aac-a87e-27e45e2b56fa" />


## 8. Floorplanning

Floorplanning defines the die and core dimensions and establishes the area in which the standard cells and routing resources will be placed.

The project uses a fixed die area of 100 × 100 µm.

### Screenshot 6 — Floorplan view

<img width="1337" height="791" alt="Screenshot 2026-10-10 113143" src="https://github.com/user-attachments/assets/c75f8a15-d2a1-4870-906e-35659e75e60c" />
<img width="1388" height="802" alt="Screenshot 2026-10-10 113423" src="https://github.com/user-attachments/assets/917fb037-eb83-4902-8539-9a5bcf057505" />


## 9. Power Planning

Power planning creates the power distribution network used to distribute supply and ground connections across the design.

### Screenshot 7 — Power distribution network

<img width="1355" height="833" alt="Screenshot 2026-10-10 095255" src="https://github.com/user-attachments/assets/7a4c5b44-66b4-4d55-ac23-4576aabcf1a3" />


### Screenshot 8 — VPWR power stripe and cell rows

<img width="1399" height="858" alt="Screenshot 2026-10-10 114313" src="https://github.com/user-attachments/assets/7c4d415f-1492-4799-967e-ed7fc6b4cbae" />

## 10. Placement

Placement positions the standard cells legally within the floorplan. The controller's logic cells and flip-flops are arranged to support the following routing stage.

### Screenshot 9 — Placement view

<img width="1370" height="806" alt="Screenshot 2026-10-10 113456" src="https://github.com/user-attachments/assets/e1295b2b-c9bf-498c-94c5-fe2af26bd8cb" />


## 11. Clock Tree Synthesis (CTS)

Clock tree synthesis builds a buffered clock network to distribute the clock signal to the sequential cells.

The report shows a clock buffer inserted near the flip-flop cluster.

### Screenshot 10 — Layout after CTS

<img width="1362" height="807" alt="Screenshot 2026-10-10 113821" src="https://github.com/user-attachments/assets/1700f014-1dd6-4492-a786-76b137ef0d54" />

## 12. Routing

Routing connects the placed standard cells using metal interconnects and vias.

The reported routed design has:

- Total wire length: 742 µm
- Number of vias: 199
- Routing violations: 0 reported

### Screenshot 11 — Routed layout

<img width="1359" height="845" alt="Screenshot 2026-10-10 114600" src="https://github.com/user-attachments/assets/8962b304-d0ce-4b5c-a9b5-cc2fcaa5136c" />


## 13. Physical Verification: DRC, LVS and Antenna

Physical verification checks whether the final layout satisfies the relevant design rules and matches the intended circuit netlist.

### Reported results

| Verification check | Result |
|---|---:|
| Magic DRC violations | 0 |
| LVS errors | 0 |
| Antenna violations | 0 |
| OpenLane flow | Completed |

### Screenshot 12 — Sign-off reports

<img width="1345" height="849" alt="drs+lvs_antenachecks" src="https://github.com/user-attachments/assets/85eeed20-1380-432d-a7f5-9d7df5b3f4b1" />


## 14. Static Timing Analysis (STA)

Static timing analysis evaluates the design's setup and hold timing under the specified clock constraints.

The project uses a 5.0 ns clock period and reports timing results for fast, typical, and slow process corners.

### Timing results

| Corner | Setup slack | Hold slack | TNS |
|---|---:|---:|---:|
| Fast | +3.59 ns | +0.31 ns | 0.00 ns |
| Typical | +3.29 ns | +0.50 ns | 0.00 ns |
| Slow | +2.22 ns | +0.61 ns | 0.00 ns |

All reported setup and hold slacks are positive.

### Screenshot 13 — Typical-corner timing report

<img width="1331" height="803" alt="sta1" src="https://github.com/user-attachments/assets/bffd69bb-5a62-4f12-b350-9bc7923a1e66" />
<img width="1346" height="816" alt="sta2" src="https://github.com/user-attachments/assets/dcaa995d-3efa-4a65-b3ec-352723928bc1" />

### Screenshot 14 — Timing comparison across corners

<img width="1396" height="850" alt="STA4" src="https://github.com/user-attachments/assets/c6871468-fd56-4872-a62f-bf151a68b05e" />

## 15. Final GDSII Layout

GDSII is the layout file format used to represent the physical design geometry. The completed OpenLane flow generated the final layout for the controller.

The report states that the final GDSII file is approximately 335 KB.

### Screenshot 15 — Final GDSII layout in Magic

<img width="1358" height="855" alt="Screenshot 2026-10-10 151901" src="https://github.com/user-attachments/assets/b1cd4c65-a445-4ac3-9740-a32bb61b47a2" />
<img width="986" height="800" alt="image" src="https://github.com/user-attachments/assets/c5d91f9a-8109-4e95-8374-397ea67c4bc7" />


## 16. Physical Design Summary

| Parameter | Reported result |
|---|---|
| Die area | 0.01 mm² |
| Core utilization | Approximately 4% |
| Synthesis cell count | 26 |
| Total physical cells, including tap cells | 146 |
| Total wire length | 742 µm |
| Vias | 199 |
| Clock period | 5.0 ns |
| Worst setup slack across reported corners | +2.22 ns |
| Worst hold slack across reported corners | +0.31 ns |
| Final layout | GDSII |
| DRC violations | 0 |
| LVS errors | 0 |
| Antenna violations | 0 |

## 17. Complete RTL-to-GDSII Flow

The complete project flow is:

1. RTL coding
2. Functional verification
3. Logic synthesis
4. Gate-level simulation
5. Floorplanning
6. Power planning
7. Standard-cell placement
8. Clock tree synthesis
9. Routing
10. Static timing analysis
11. Physical verification
12. Final GDSII generation

## 18. Applications

- Automatic street lighting systems
- Smart city lighting concepts
- Energy-efficient lighting control
- Digital control system demonstrations
- VLSI design and physical implementation learning

## 19. Conclusion

The Debounced Multi-Light Street Lamp Controller demonstrates the design and implementation of a digital control system using Verilog HDL and the SKY130 technology library. The project covers simulation, synthesis, floorplanning, power planning, placement, clock tree synthesis, routing, static timing analysis, physical verification, and final GDSII generation using the OpenLane flow.

## 20. Author

**B. Madhulika**  
B.Tech — Electronics and Communication Engineering  
Anurag University  
Academic Year: 2026–2027

---

