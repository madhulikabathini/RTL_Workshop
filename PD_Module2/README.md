# Physical Design – Module 2

## Overview

This module focuses on the Physical Design implementation flow and Library Characterization and Modelling.

The module explains how a synthesized design is converted into a physical layout and how standard cells are characterized for timing and power analysis.

The major topics covered in this module include:

- OpenLane configuration
- Floorplanning
- Core and die definition
- Pre-placed cells
- Power planning
- Placement
- Logical cell placement
- Placement optimization
- Routing
- Standard-cell design flow
- Library characterization
- NLDM and CCS characterization concepts
- Timing characterization
- Timing thresholds
- Propagation delay
- Transition time
- Noise margin

---

## 1. OpenLane Configuration

OpenLane uses configuration files to define important parameters required for the RTL-to-GDSII implementation flow.

The configuration includes parameters such as:

- Design name
- Verilog source files
- Clock port
- Clock period
- Clock net
- Standard-cell library
- Synthesis parameters
- Floorplanning parameters
- Placement and routing parameters

The configuration file allows the implementation flow to be controlled according to the requirements of the design.

<img width="1405" height="879" alt="Screenshot 2026-09-05 232700" src="https://github.com/user-attachments/assets/c310993c-f69a-47fd-989a-cff720488de9" />

<img width="1430" height="840" alt="Screenshot 2026-09-05 232057" src="https://github.com/user-attachments/assets/140e62fb-ae8c-4e66-9214-12d75a1df3cb" />

---

## 2. Physical Design Flow

The Physical Design flow converts the synthesized netlist into a physical implementation.

The major stages include:

1. Floorplanning
2. Power planning
3. Placement
4. Clock Tree Synthesis
5. Routing
6. Physical verification
7. GDSII generation

The objective is to obtain a layout that satisfies area, timing, power and routing requirements.


---

## 3. Floorplanning

Floorplanning is the first major step in physical design.

It defines the physical organization of the chip by determining:

- Core dimensions
- Die dimensions
- Aspect ratio
- Utilization factor
- Locations of large blocks and IPs
- Power distribution structure

The core is the region where the standard cells are placed, while the die represents the complete physical chip area.

The utilization factor determines how much of the available core area is occupied by cells.

<img width="1356" height="829" alt="Screenshot 2026-09-05 232338" src="https://github.com/user-attachments/assets/a288db6b-fb1f-46d0-9628-9023bbd0e5f7" />
<img width="1398" height="872" alt="Screenshot 2026-09-05 235636" src="https://github.com/user-attachments/assets/b7938681-649b-4888-b5d3-9ffba398032a" />
<img width="1401" height="864" alt="Screenshot 2026-09-06 000540" src="https://github.com/user-attachments/assets/1d9cc305-f0a6-45de-8c62-4896aa25cb63" />
<img width="1346" height="818" alt="Screenshot 2026-09-06 000301" src="https://github.com/user-attachments/assets/6d49c301-8db0-413a-b2d9-bbfb371ab708" />


<img width="1342" height="820" alt="Screenshot 2026-09-05 232428" src="https://github.com/user-attachments/assets/6b5a17de-da30-4bb2-82a3-7490c3322261" />


---

## 4. Pre-placed Cells

Some blocks or IPs require predefined physical locations before automated placement.

Examples include:

- Memory blocks
- Clock-gating cells
- Comparators
- Multiplexers
- Other large or critical IP blocks

These blocks are called pre-placed cells because their locations are defined before the remaining standard cells are automatically placed.
<img width="1405" height="879" alt="Screenshot 2026-09-05 232700" src="https://github.com/user-attachments/assets/737c5998-0d29-4f88-afc1-403b843589fd" />



---

## 5. Power Planning

Power planning creates the power distribution network required to supply power and ground to the cells in the design.

The power network generally consists of:

- VDD
- VSS
- Power rings
- Power straps
- Standard-cell power connections

Decoupling capacitors can also be placed near blocks to help stabilize the power supply and reduce voltage fluctuations.
<img width="1331" height="703" alt="Screenshot 2026-09-04 182037" src="https://github.com/user-attachments/assets/dec6d6d4-2c54-4e87-b5fe-96fa3a84b546" />


---

## 6. Placement

Placement determines the physical locations of standard cells inside the core area.

The main objectives of placement are:

- Reduce wire length
- Reduce congestion
- Improve timing
- Optimize area
- Maintain proper power distribution
- Provide better routing resources

The placement process can be broadly understood as:

1. Bind the logical netlist with physical cells
2. Perform initial placement
3. Optimize the placement
4. Estimate wire length and capacitance
5. Insert buffers or repeaters when required
<img width="1413" height="720" alt="Screenshot 2026-09-04 194218" src="https://github.com/user-attachments/assets/ff7b5eee-2b6e-46f3-af74-3cb8305f6517" />
<img width="1454" height="865" alt="Screenshot 2026-09-06 001942" src="https://github.com/user-attachments/assets/0fb547d1-f936-49e5-a968-50012dc51ae2" />
<img width="1448" height="897" alt="Screenshot 2026-09-06 002025" src="https://github.com/user-attachments/assets/17d7033f-17d8-4d0d-8150-99a832b315f3" />
<img width="1524" height="920" alt="Screenshot 2026-09-06 002507" src="https://github.com/user-attachments/assets/f7ac0c88-67ee-4c0d-b4ce-c6a0a7daf4f5" />

<img width="1402" height="831" alt="Screenshot 2026-09-05 233958" src="https://github.com/user-attachments/assets/7716ebc2-ac28-4dad-bf51-45fe0f7a3959" />

---

## 7. Logical Cell Placement Blockage

Placement blockages are regions where standard cells should not be placed.

They may be required around:

- Pre-placed IPs
- Memory blocks
- Power structures
- Reserved regions
- Critical routing areas

Placement blockages help prevent unwanted cell placement and provide sufficient routing resources around important blocks.
<img width="1390" height="856" alt="Screenshot 2026-09-06 000813" src="https://github.com/user-attachments/assets/ca311d85-3e30-433d-bc5a-0fcde97e1fb1" />

---

## 8. Placement Optimization

After the initial placement, the design is optimized to improve physical and timing characteristics.

During optimization, the tool may:

- Move cells
- Resize cells
- Insert buffers
- Reduce wire length
- Reduce capacitance
- Improve timing
- Reduce routing congestion

The objective is to obtain a placement that provides better overall physical implementation.
<img width="1384" height="699" alt="Screenshot 2026-09-04 194429" src="https://github.com/user-attachments/assets/b135af4d-2865-46ea-8b89-d9188a03ce2b" />
<img width="1418" height="885" alt="Screenshot 2026-09-06 001323" src="https://github.com/user-attachments/assets/08d1b1e3-e15d-4dac-8374-ac305cae497e" />

---

## 9. Routing

Routing connects the placed cells according to the logical netlist.

The routing process creates physical metal connections between:

- Standard cells
- Input/output ports
- Clock connections
- Power connections
- Other design blocks

Routing must satisfy design-rule and connectivity requirements while minimizing congestion and parasitic effects.

The final routed layout represents the physical connectivity of the design.

---

## 10. Standard Cell Design Flow

Standard cells are basic building blocks used during physical implementation.

Examples include:

- Inverter
- Buffer
- AND gate
- OR gate
- Flip-flop

The standard-cell design flow includes:

1. Circuit design
2. Layout design
3. Characterization
4. Library generation

The inputs may include:

- Process design kits (PDKs)
- DRC and LVS rules
- SPICE models
- Library specifications
- User-defined specifications

The outputs include:

- Circuit description
- Layout
- Extracted netlist
- Timing information
- Power information
- Functional information

<img width="1326" height="710" alt="Screenshot 2026-09-04 194513" src="https://github.com/user-attachments/assets/9a0672c8-e943-48dd-80f9-c1cc38c60dbf" />


---

## 11. Library Characterization

Library characterization is the process of measuring and modelling the electrical behaviour of standard cells.

A cell is simulated under different operating conditions to obtain information such as:

- Delay
- Transition time
- Input capacitance
- Output capacitance
- Power consumption
- Timing behaviour

The resulting information is stored in standard-cell libraries and is used by EDA tools during synthesis and physical design.

<img width="1419" height="710" alt="Screenshot 2026-09-04 194605" src="https://github.com/user-attachments/assets/0124f8f5-90d5-4e4b-816f-257e081893c9" />

---

## 12. Timing Characterization

Timing characterization determines the timing behaviour of a standard cell.

Important timing parameters include:

- Propagation delay
- Input transition
- Output transition
- Timing thresholds
- Rise time
- Fall time

The input and output waveforms are analysed to determine how quickly a signal propagates through the cell.
<img width="1380" height="725" alt="Screenshot 2026-09-04 195352" src="https://github.com/user-attachments/assets/f14fa3e6-e840-4974-a2f9-36ec212edf6b" />



---

## 13. Timing Threshold Definitions

Timing measurements use predefined voltage thresholds.

Typical threshold definitions include:

- `slew_low_rise_thr` – 20%
- `slew_high_rise_thr` – 80%
- `slew_low_fall_thr` – 20%
- `slew_high_fall_thr` – 80%
- `in_rise_thr` – 50%
- `in_fall_thr` – 50%
- `out_rise_thr` – 50%
- `out_fall_thr` – 50%

These thresholds are used to measure input and output transition times and propagation delays.
<img width="1337" height="731" alt="Screenshot 2026-09-04 195408" src="https://github.com/user-attachments/assets/27b8cccf-395d-4618-8d92-879f0b90ae84" />

---

## 14. Propagation Delay

Propagation delay is the time required for a change at the input of a cell to produce the corresponding change at its output.

It is measured using defined input and output timing thresholds.

For example:

- Input transition is measured at the specified input threshold.
- Output transition is measured at the specified output threshold.
- The difference between the two times gives the propagation delay.

Propagation delay is an important parameter for timing analysis and optimization.
<img width="1277" height="737" alt="Screenshot 2026-09-04 195554" src="https://github.com/user-attachments/assets/e5344e38-6277-45d8-acee-3e456dbdf091" />

---

## 15. Transition Time

Transition time represents how quickly a signal changes between its logic levels.

For rise transitions, the signal is generally measured between the 20% and 80% voltage levels.

For fall transitions, the signal is also measured between the 80% and 20% voltage levels.

Transition time is commonly referred to as signal slew.

A smaller transition time generally indicates a faster signal transition.
<img width="1325" height="689" alt="Screenshot 2026-09-04 195626" src="https://github.com/user-attachments/assets/070e077e-5b45-436d-89b6-9ba9e3576599" />

---

## 16. Noise Margin

Noise margin indicates how much unwanted noise a digital signal can tolerate without being interpreted as an incorrect logic level.

The two important noise margins are:

- Noise Margin High (NMH)
- Noise Margin Low (NML)

A sufficient noise margin improves the reliability of digital circuits.
<img width="1167" height="694" alt="Screenshot 2026-09-04 181737" src="https://github.com/user-attachments/assets/15df53be-a741-476b-b55d-f433f0239a7d" />

---

## 17. NLDM and CCS

Library characterization can use different modelling techniques.

### NLDM

Non-Linear Delay Model (NLDM) represents cell timing behaviour using lookup tables based on parameters such as:

- Input transition
- Output load

### CCS

Composite Current Source (CCS) provides a more detailed representation of cell timing and current behaviour.

These characterization models are used by EDA tools for timing and power analysis.

---

## 18. Key Learnings

Through this module, the following concepts were studied:

- OpenLane configuration
- Physical design implementation
- Floorplanning
- Core and die dimensions
- Utilization factor
- Pre-placed cells
- Power planning
- Placement
- Placement optimization
- Placement blockages
- Routing
- Standard-cell design flow
- Library characterization
- Timing characterization
- Timing thresholds
- Propagation delay
- Transition time
- Noise margin
- NLDM and CCS modelling

---

## Conclusion

Physical Design transforms the logical representation of a circuit into an optimized physical layout.

This module provided an understanding of floorplanning, placement, power planning and routing, along with the characterization of standard cells.

Library characterization provides the timing and power information required by EDA tools to accurately analyse and optimize digital designs.

Together, these concepts form an important part of the ASIC RTL-to-GDSII implementation flow.
