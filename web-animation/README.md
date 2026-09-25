# 导弹拦截交战可视化 (three.js 网页动画)

把 MATLAB 官方制导示例 **aero_guidance** 的仿真输出,变成一个精美的 three.js 三维交战动画网页。
MATLAB/Simulink 仿真作为"背后的基座"提供全部数学与物理数据;网页**逐帧线性插值回放**,
不做任何外推、平滑或美化 —— 屏幕上的一切严格来自仿真数据。

![数据流](https://img.shields.io/badge/data-MATLAB_aero_guidance-0071E3)

## 快速开始

**在线版（零安装）**：<https://sogersen.github.io/missile-guidance-web/web-animation/index.html>
—— GitHub Pages 托管，浏览器直接打开即可，无需本地服务器。

本地运行：**双击 `start_web_demo.bat`** —— 自动启动本地服务器并打开浏览器。
(浏览器禁止 file:// 直接加载 ES 模块,必须走本地服务器;关掉最小化的服务器窗口即停止。)

手动等价方式:

```bat
cd /d "%~dp0"
python -m http.server 8137 --bind 127.0.0.1
:: 浏览器打开 http://127.0.0.1:8137/index.html
```

## 功能

| 区域 | 内容 |
|---|---|
| 3D 视口 | 拦截弹(蒙皮贴图弹身+**尾焰: 喷口激波钻石链(马赫环)+扩张羽流**+发动机烟云) + 喷气目标机(后掠翼, 姿态随遥测速度矢量) + 全程/已飞弹道线 + 发射/拦截点标记 + **命中特效:双层火球/冲击环/烟柱/闪光/震屏 → 弹体解体为破片+火星 → 目标机受损失控坠机(断翼/拖黑烟)** + **拦截结果卡**(数值全部来自仿真 summary) |
| 场景 | 真实积云贴图云层(照片版 + 程序化 2K 版混用, 近/远/走廊三层, 随机旋转与高宽比) · 地面沙土贴图(**3072² 高清版 + 细节噪声**, 各向异性拉满) · 程序化双层山脊剪影 · 渐变天空穹顶(太阳方位暖晕) · PBR 环境反射 · 距离雾 · 星空(深色); 工程网格仅分析视图(侧视/顶视/环绕)显示 |
| 视角 | **原版**(默认,复刻 Simulink 3DoF 动画机位) · 侧视(全场) · 环绕(拖拽/滚轮/右键) · 影院(自动环绕) · 追弹(侧后 3/4, **命中后自动切到侧下方跟拍受损坠机的目标机**) · 顶视; 切换时位置与视场角平滑过渡 |
| 实时遥测 | T+、高度、空速、马赫(模型信号)、俯仰 θ、攻角 α、切向过载、弹目距离、接近速率、目标状态 |
| 图表 | 高度 / 马赫 / 攻角 / 弹目距离 四指标,全程曲线 + 时间光标(横轴为真实交战秒) |
| 播放 | 播放/暂停、**1× 实时**(默认,与原版 Simulink 动画同速) / 0.5× / 0.2× / 0.1× 慢放、**终段慢放**(命中前 0.6 s 自动渐变到 0.2×)、时间轴拖动、结束自动暂停+重播 |
| 快捷键 | `Space` 播放/暂停 · `←/→` ±0.1 真实秒(Shift ±1 s) · `Home` 回起点 · `1-4` 速率 · `C` 切机位 · `F` 沉浸模式 · `Esc` 退出沉浸 |
| 主题 | 深/浅双主题 (Apple HIG 玻璃面板),自动记忆 |
| 界面 | **全部面板可拖拽**(按住顶部握把拖动, 越界自动收回, 位置本地记忆) · **可折叠**(面板右上角箭头, 折叠状态同样记忆) · **沉浸模式**(`F` 或右上角按钮: 隐藏全部 UI、只留右下角半透明退出按钮并进入全屏; 2.5 s 无操作自动隐藏鼠标指针, 单击画面播放/暂停, `Esc` 或退出按钮返回) |
| 出片 | 页内 `⏺ 录制视频`(MediaRecorder 实时录) · **`Tools/OfflineRender` 逐帧离线渲染 → ffmpeg 直出 MP4**(不丢帧, 可 4K; `--mode canvas` 纯三维 / `--mode page` 整页含面板) · **`--spec` 规格预设**: `1080p240`(高帧率, 可慢放) / `4k60`(高分辨率) · **`render_all_views.bat` 一键出 6 视角 × 2 规格 = 12 条纯画面视频** |

> 注: 下文提到的 `Tools/OfflineRender` 与 `Tools/TextureForge` 是作者工作区的内部工具，未随本仓库发布；仓库内网页本身不依赖它们。

交战关键数据(来自仿真):导弹从 **3 048 m** 仰攻,Mach 最大 **3.10**,攻角最大 **17.4°**;
目标 **3 548 m** 高度以 329 m/s 巡航;T+3.44 s 弹目距离最小 **0.1 m** —— 完美拦截。

> 注:弹体模型显示尺寸放大 16× 便于观察(官方 3DoF 动画同样把弹体画大 ~100 倍);
> **轨迹、时间轴、全部遥测数值严格按仿真数据**。

## 默认机位 = 原版 Simulink 动画机位

官方示例的 `3DoF Animation` 块 (aerolibanim) 掩码配置为:

```
camera_view = 'Fixed position'      % 固定视点
camera_pos  = [2000 500 -3150]      % 数据系 [前向 2000 m, 侧向 500 m, 高度 3150 m]
view angle  = 10°                   % 视场角
cameraTarget = 导弹位置             % 每帧注视导弹
up vector   = [0 0 -1]              % 高度向上
```

网页 `原版` 视角逐项复刻:相机固定在 (X=2000, 海拔 3150, 侧向 500) m,
每帧 `lookAt(导弹)`,竖直视场角 10°,上方向 = 海拔向上 ——
构图与官方动画一致(弹体居中、视线来自弹前方偏右侧上方)。
想要全场概览时点 `侧视`,想要自由观察时点 `环绕`。

`?t=<秒>` URL 参数按**真实交战秒**(0~3.44)直达某一瞬间并暂停,例如
`http://127.0.0.1:8137/index.html?t=1.72`。
还支持 `?cam=<机位>` (orig/side/orbit/cinema/chase/top) 与 `?theme=<dark|light>`,
可组合使用,便于分享与截图,如 `index.html?t=2.0&cam=chase&theme=light`。

## 贴图素材 (textures/)

| 文件 | 尺寸 | 用途 | 来源 |
|---|---|---|---|
| `cloud_cumulus.png` | 1600×691 | 云层公告板（照片版，占约 2/3） | PNGkey (免费透明底积云) |
| `cloud_cumulus_2k.png` | 2048×1024 | 云层公告板（程序化版，占约 1/3，打破重复感） | `Tools/TextureForge` 程序化生成 |
| `ground_soil.jpg` | 1400×1100 | 地面沙土（回退用） | RenderHub 免费贴图 |
| `ground_soil_hd.jpg` | 3072×2412 | 地面沙土（首选：上采样 + 细节噪声叠加，支撑 4K） | 由 `ground_soil.jpg` + 程序化细节合成 |
| `smoke_plume.png` | 640×888 | 命中烟柱（回退用） | PNG All (免费透明底烟柱) |
| `smoke_plume_2k.png` | 1024×2048 | 命中烟柱（首选，程序化湍流烟柱） | `Tools/TextureForge` |
| `smoke_plume_dark_2k.png` | 1024×2048 | 燃烧残骸拖烟（深色） | `Tools/TextureForge` |
| `smoke_puff_1k.png` | 1024×1024 | 发动机尾烟 / 烟团 | `Tools/TextureForge` |
| `fireball_1k.png` | 1024×1024 | 火球（内/外双层共用） | `Tools/TextureForge` |

弹体蒙皮（1024²）与目标机蒙皮（512²，含面板线/铆钉/标识带）由页面内 canvas 程序化绘制，
无需外部文件。贴图走相对路径、由本地服务器加载；任一贴图缺失时页面自动回退到低分辨率版或
纯程序化外观，不影响播放。

## 文件结构

```
WebAnimation/
  index.html            主页面 (全部 UI/3D/回放逻辑, 无构建步骤)
  data/telemetry.js     仿真遥测 (由 MATLAB export_telemetry_web.m 生成, 勿手改)
  textures/             真实贴图素材 (云/沙土/烟柱, 见上表)
  vendor/               three.js 0.185 本地副本 (离线可用)
    three.module.min.js
    three.core.min.js
  start_web_demo.bat    一键启动
```

## 数据管线 (更新数据)

```
Simulink aero_guidance (官方示例, 只读)
  → Src/Matlab/flightgear/export_telemetry_web.m   在 MATLAB 中运行
      读取 Miss_pos / Tgt_pos / Incid / Mach (To Workspace 信号)
      计算高度/空速/航迹角/俯仰/攻角/过载/弹目距离
  → Outputs/02_Finals/WebAnimation/data/telemetry.js
  → 刷新网页即可
```

换任何其它弹道:只需让新脚本产出相同结构的 `window.TELEMETRY`
(`missile`/`target`/`range` 各含 t 与逐帧数组),网页零改动。

## 三维场景约定

- 坐标系: X = 前向距离 (m),Y = 海拔 (m),Z = 侧向;1 单位 = 1 m
- 时间: 遥测内部时间轴为 ×10 慢放采样 (34.39 s),播放器按 `slowFactor` 换算回真实秒;
  **默认 1× = 真实 3.44 s**(与原版 Simulink 动画同速),慢放档位在播放条上选
- 插值: 帧间线性 (数据 100 Hz,帧间隔 0.01 s)
