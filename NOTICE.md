# 第三方素材与数据说明 (NOTICE)

本仓库包含的第三方内容及其来源如下。除特别注明外，仓库中自研的代码、页面与程序化生成贴图
均以 [MIT License](LICENSE) 发布；下列第三方内容**不属于** MIT 授权范围，各自遵循其原始许可。

## 1. three.js (`web-animation/vendor/`)

- 版本: 0.185（本地副本，离线可用，未修改）
- 许可: MIT License
- 版权: Copyright © 2010-2026 three.js authors
- 主页: https://threejs.org · 源码: https://github.com/mrdoob/three.js

```
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 2. MathWorks 官方示例（数据与截图来源）

- 遥测数据 `web-animation/data/telemetry.js` 由 MATLAB R2026a 运行 MathWorks 官方示例
  **"Designing a Guidance System in MATLAB and Simulink" (aero_guidance)** 导出，
  仅包含仿真输出的数值结果。
- `web-showcase/assets/` 中的 `DesigningAGuidanceSystemInMATLABAndSimulinkExample_*.png`
  为该官方示例配套文档页面的截图，`xxguidance_*.png` 为 MATLAB/Simulink 产品界面截图。
- MATLAB® 与 Simulink® 是 The MathWorks, Inc. 的注册商标。本仓库为独立的学习/教学演示项目，
  与 MathWorks 无隶属或背书关系；截图按 MathWorks 关于屏幕截图使用的政策附带本说明引用。

## 3. 摄影类贴图素材 (`web-animation/textures/`)

| 文件 | 来源 | 状态 |
|---|---|---|
| `cloud_cumulus.png` | PNGkey（免费透明底素材站） | ⚠️ 再分发许可待核实，发布前建议替换为 CC0 素材或程序化生成 |
| `ground_soil.jpg` | RenderHub 免费贴图 | ⚠️ 同上 |
| `ground_soil_hd.jpg` | 由 `ground_soil.jpg` 上采样 + 细节噪声合成 | ⚠️ 继承上一条 |
| `smoke_plume.png` | PNG All（免费透明底素材站） | ⚠️ 同上 |

其余全部贴图（`*_2k.png`、`*_1k.png`、`ground_detail_*.png` 及页面内程序化绘制的
弹体/目标机蒙皮）为作者使用自研程序化工具生成，属本仓库 MIT 授权范围。

任一贴图缺失时页面会自动回退到低分辨率版或纯程序化外观，不影响播放——
因此删除上述 ⚠️ 文件后动画仍可运行，只是部分观感降级。
