
######################################################################

I. Project Structure
├── data_gen/                 # Folder related to underwater acoustic channel data generation
│   ├── main.m                    # Main process for ocean acoustic channel data generation
│   ├── Pos1Azi1freq100Hz.env     # Environmental parameter file for sound source A
│   ├── Pos1Azi1freq100Hz.brc     # Configuration file for sound source A
│   ├── Pos1Azi1freq100Hz.bty     # Seabed terrain data file for sound source A
│   ├── Pos1Azi1freq100Hz.ssp     # Sound speed profile data file for sound source A
│   ├── Pos1Azi1freq100Hz.arr     # Arrival data file for sound source A
│   ├── Pos1Azi1freq100Hz_1.env   # Environmental parameter file for sound source B
│   ├── Pos1Azi1freq100Hz_1.brc   # Configuration file for sound source B
│   ├── Pos1Azi1freq100Hz_1.bty   # Seabed terrain data file for sound source B
│   ├── Pos1Azi1freq100Hz_1.ssp   # Sound speed profile data file for sound source B
│   ├── Pos1Azi1freq100Hz_1.arr   # Arrival data file for sound source B
│   ├── bellhop.m                 # Run BELLHOP program
│   ├── funNorm.m                 # Normalize signals by mean value
│   ├── funMulti_Eff.m            # Ocean environment multipath effect modeling function
│   ├── funReadTestLb.m           # Read test label text file

II. Dataset Structure
├── deepship_5s_32k_combine/  # Audio folder synthesized from deepship dataset
│   ├── xxx.wav                   # Synthesized audio files
│   ├── ...                       
├── deepship_5s_32k/          # deepship dataset audio folder
│   ├── xxx.wav                   # Audio files
│   ├── ... 
├── shipsear_5s_16k_combine/  # Audio folder synthesized from shipsear dataset
│   ├── xxx.wav                   # Synthesized audio files
│   ├── ... 
├── shipsear_5s_16k/          # shipsear dataset audio folder
│   ├── xxx.wav                   # Audio files
│   ├── ...
