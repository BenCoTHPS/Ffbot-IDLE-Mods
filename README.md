# Ffbot-IDLE-Mods
Mods for Elbody's [FFBot Idle Game](https://elbody.itch.io/ffbot)

This is a pretty rough code base with poor instructions. For most of you, grab the latest release and the html files (you don't need index). Add them as obs browser sources or whatever you want to do. They will update with the game  when it generates jsons (new wave, stats command, freehire,ascend, missing etc). 

**Disclaimer:** Use of these mods may or may not ban you from game leaderboards! **Always back up your original `ffbot.pck` and save files before attempting to mod your game.**

## Project Overview
This mod enhances the FFBot experience by providing real-time data exports and audio-visual feedback. It was made possible using the [Godot PCK Explorer](https://dmitriysalnikov.itch.io/godot-pck-explorer).

Currently supports version **9.01** (latest at time of writing). I will attempt to keep this updated alongside game updates, but no promises can be made.

## Installation and Setup

### 1. Install the Mod (.pck)
To apply the mod to your game, you must replace the default game data with the modified version:
1. Go to the [Releases](https://github.com/enzemo/Ffbot-IDLE-Mods/releases) page.
2. Download the latest `.pck` file.
3. Open your FFBot game folder.
4. Replace the existing `.pck` file with the one you just downloaded.

### 2. Manual Integration Instructions
If you are manually adding these features to the game files or updating a custom version:
1. **Extract**: Use [Godot PCK Explorer](https://dmitriysalnikov.itch.io/godot-pck-explorer) to extract the contents of your original `ffbot.pck`.
2. **Add Writer**: Place the `game_stats_writer.gd` file into the `example/` folder of the extracted directory.
3. **Edit Code**: Open `table.gd` and integrate the mod logic into the appropriate functions (refer to the source files in this repo for exact hooks).
4. **Repack**: Use PCK Explorer to "Pack from Folder" to create your new `.pck` file.
5. **Replace**: Replace the existing `ffbot.pck` in your FFBot directory with your modified version.
6. **Verify**: Run the game and attempt to use the `!start` command. 
   - **Note**: If battles do not start correctly, the code has likely been placed in the wrong section of `table.gd`.

### 3. Audio Alerts
* **Game Over SFX**: Plays a sound when hitting a game over. 
* **Requirement**: Include a `gameover.wav` in the same folder as the game executable. You can find an example file in the project releases.
* **Ragtime Mouse SFX**: Plays a sound when encounting Ragtime Mouse/Trivia. 
* **Requirement**: Include a `ragtime.wav` in the same folder as the game executable.

### 4. Data Export (JSON)
Once the mod is running, it will generate two JSON files in the same location as the executable:
* **player_stats.json**: Persistent character data, core attributes (ATK, MAG, SPR), and growth metrics. Generated upon a user using the !stat or !stats command. 
* **game_stats.json**: Live session data, including current boss HP, wave progress, and party unit details. Generates when the first battle begins.
* **ascend_stats.json**: Gives ascension information
* **freehire.json**: Basic freehire info, useful if you intend to totally replace the stats screen. 

---

## OBS Browser Sources
Live examples of how this data can be visualized can be found here: [https://enzemo.github.io/Ffbot-IDLE-Mods/](https://enzemo.github.io/Ffbot-IDLE-Mods/)

### Integration Steps:
1. Add a new **Browser Source** in OBS.
2. Check the **Local File** box and browse to the desired HTML file (e.g., `game-stats-browser.html`).
3. Recommended dimensions:
    * **Game Stats Overlay**: 450 Width x 650 Height
    * **Player Stats Overlay**: 380 Width x 550 Height
4. Enable **Refresh browser when source becomes active**.

---

## Technical Data Points

### Player Profile Data
* **Base Attributes**: Monitors HP, Level, Attack, Magic, and Spirit.
* **Progression**: Tracks Ascension levels, Awakening EXP, and total wins.
* **Passive Roadmap**: Shows wins required for upcoming slot unlocks (e.g., Slot 1 at 100 wins).
* **Collection**: Monitors total items discovered (out of 129).

### Live Session Data
* **World State**: Displays Season, Cycle, Stage, Tier, and NG+ modifiers.
* **Battle Progress**: Live tracking of Boss Name, Boss HP, and Wave completion percentage.
* **Hire System**: Displays the currently available Hire (e.g., Vivi).
* **Party Status**: Real-time ATB, LB Charge, and Status Effects for all active units.

### Player stats html deserves it's own section 

# OBS Player Overlay System

A dynamic, data-driven browser overlay designed for OBS (Open Broadcaster Software). This overlay provides a real-time visual interface for player statistics, character collection progress, and automated event notifications.

## 🚀 Features

### Real-Time Statistics
The overlay continuously monitors `player_stats.json` (every 2 seconds) to provide up-to-date information on:
* **Identity**: Displays Player Name and current active Unit.
* **Attributes**: Tracks HP, Attack, Magic, and Spirit with automatic highlighting for the "Preferred Stat".
* **Progression**: Shows current Level and total Wins.
* **Passives**: Visualizes currently selected and available season passives, including unlock milestones (100w, 200w).

### Collection & Progress Tracking
* **Progress Bar**: Displays total units collected vs. total available units and a calculated percentage.
* **Missing Characters**: A specialized scrolling toast that lists characters yet to be hired.

### Intelligent Toast System
The system uses a priority-based queue to ensure events are displayed clearly without overlapping:
* **Ascension Toast**: Triggered by `ascend_stats.json`, showing a preview of new stats after an ascension event.
* **Freehire Toast**: Triggered by `freehire.json`, announcing new character assignments with unit icons.
* **Success State**: When collection is complete, a full-screen celebration triggers with a custom message and confetti animation.

## 🛠 Technical Details

- **Responsive Design**: Optimized for a 320px width OBS Browser Source.
- **Asset Mapping**: Uses `FFBot.csv` to dynamically map character names to local image assets in the `/units/` folder.
- **Performance**: Built with efficient `setInterval` polling and JSON fetching to minimize CPU impact while streaming.
- **UI/UX**: Features a glass-morphism aesthetic with backdrop blurring for maximum readability over various game backgrounds.

## 📂 Required Files

For the overlay to function correctly, ensure the following files are in the same directory as `player-stats.html`:

| File | Description |
| :--- | :--- |
| `player_stats.json` | Core player data and attributes |
| `ascend_stats.json` | Trigger for ascension events |
| `freehire.json` | Trigger for character hire events |
| `missing_characters.json` | Data for character collection list |
| `FFBot.csv` | Mapping file for unit icons |
| `/units/` | Folder containing `.png` unit icons |

## ⚙️ Setup in OBS

1. Add a new **Browser Source** in OBS.
2. Select **Local File** and point it to `player-stats.html`.
3. Set **Width** to `320` and **Height** to `400` (or higher if you have long passive lists).
4. (Optional) Use **Custom CSS** in OBS if you need to adjust the background transparency further.
