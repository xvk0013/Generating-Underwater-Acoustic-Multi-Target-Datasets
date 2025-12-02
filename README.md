##一.项目结构
```
├── data_gen/                 # 水下声信道数据生成相关文件夹
│   ├── main.m                    # 海洋声信道数据生成主流程
│   ├── Pos1Azi1freq100Hz.env     # 声源A的环境参数文件
│   ├── Pos1Azi1freq100Hz.brc     # 声源A的配置文件
│   ├── Pos1Azi1freq100Hz.bty     # 声源A的海底地形数据文件
│   ├── Pos1Azi1freq100Hz.ssp     # 声源A的声速剖面数据文件
│   ├── Pos1Azi1freq100Hz.arr     # 声源A的到达数据文件
│   ├── Pos1Azi1freq100Hz_1.env   # 声源B的环境参数文件
│   ├── Pos1Azi1freq100Hz_1.brc   # 声源B的配置文件
│   ├── Pos1Azi1freq100Hz_1.bty   # 声源B的海底地形数据文件
│   ├── Pos1Azi1freq100Hz_1.ssp   # 声源B的声速剖面数据文件
│   ├── Pos1Azi1freq100Hz_1.arr   # 声源B的到达数据文件
│   ├── bellhop.m                 # 运行BELLHOP程序
│   ├── funNorm.m                 # 对信号进行均值归一化处理
│   ├── funMulti_Eff.m            # 海洋环境多径效应建模函数
│   ├── funReadTestLb.m           # 读取测试标签文本文件
```

##二.数据集结构
```
├── deepship_5s_32k_combine/  # deepship数据集合成的音频文件夹
│   ├── xxx.wav                   # 合成的音频文件
│   ├── ...                       
├── deepship_5s_32k/          # deepship数据集音频文件夹
│   ├── xxx.wav                   # 音频文件
│   ├── ... 
├── shipsear_5s_16k_combine/  # shipsear数据集合成音频文件夹
│   ├── xxx.wav                   # 合成的音频文件
│   ├── ... 
├── shipsear_5s_16k/          # shipsear数据集音频文件夹
│   ├── xxx.wav                   # 音频文件
│   ├── ... 
```
##################################################################

##I. Project Structure
```
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
```

##II. Dataset Structure
```
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
```
