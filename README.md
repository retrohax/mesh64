# Meshtastic 64

A Meshtastic terminal for the Commodore 64.

Sends and receives text messages over the Meshtastic mesh network using `TEXTMSG` serial mode.

> **Note:** In `TEXTMSG` mode, Meshtastic uses the device's primary channel (Index 0).

---

## Hardware Setup

Example configuration (when running in VICE emulator on Linux):

1. Linux host PC
2. VICE Commodore 64 Emulator (`x64sc`)
3. Heltec LoRa 32 V3
4. CP2102 USB-to-UART bridge

### Wiring

Connect the CP2102 USB-to-UART adapter to the Heltec board as follows:

| CP2102 Pin | Heltec LoRa 32 V3 Pin |
| ---------- | --------------------- |
| `GND`      | `GND`                 |
| `TX`       | `RX` (e.g., Pin `39`) |
| `RX`       | `TX` (e.g., Pin `40`) |

---

## Configuration

### 1. Identify Serial Port

Find the serial device path on your host system:

```bash
ls -l /dev/serial/by-id
```

### 2. Configure Meshtastic Radio

Configure the Meshtastic device for `TEXTMSG` mode over serial:

```bash
meshtastic --port /dev/ttyUSB1 --set serial.enabled true
meshtastic --port /dev/ttyUSB1 --set serial.echo false
meshtastic --port /dev/ttyUSB1 --set serial.mode TEXTMSG
meshtastic --port /dev/ttyUSB1 --set serial.baud BAUD_DEFAULT
meshtastic --port /dev/ttyUSB1 --set serial.txd 40
meshtastic --port /dev/ttyUSB1 --set serial.rxd 39
meshtastic --port /dev/ttyUSB1 --get serial
```

### 3. VICE Emulator RS-232 Settings

Navigate to **Peripheral devices** $\rightarrow$ **RS232**:

1. **Userport RS232 settings:** Select the CP2102 device and set the baud rate to **300** (matching the BASIC program).
2. **RS232 devices:** Set the CP2102 device speed to **38400** baud (matching Meshtastic `BAUD_DEFAULT`).

---

## Building and Running

Compile [mesh64.bas](mesh64.bas) with `petcat` and run it in VICE:

```bash
petcat -w2 -o mesh64.prg mesh64.bas
x64sc mesh64.prg
```

---

## Usage

- **Sending Messages:** At the `>` prompt, type your message and press **Enter** to broadcast it to the mesh.
- **Receiving Messages:** If a message arrives while waiting at the prompt, it will display on screen immediately.
- **Typing Buffer:** If a message arrives while you are typing, it queues until you press **Enter**.
- **Timeout Protection:** If you pause mid-message while incoming data fills the buffer, input will time out automatically so the incoming message can be displayed.


