# 导弹制导交战 · 网页可视化合集

> Missile Guidance Engagement — Web Visualizations
> 把 MATLAB 官方制导示例 **aero_guidance**（Designing a Guidance System in MATLAB and Simulink）
> 的仿真结果，做成两个零构建、纯前端的网页演示。

| 子项目 | 内容 | 上手方式 |
|---|---|---|
| [`web-animation/`](web-animation/) | three.js 三维拦截交战动画：真实贴图场景、6 种机位、实时遥测与曲线、命中特效、慢放/离线渲染出片 | 双击 `start_web_demo.bat`（详见其 [README](web-animation/README.md)） |
| [`web-showcase/`](web-showcase/) | 示例逐页精读展示页：对官方制导系统设计示例的结构、公式与调参逐页讲解 | 双击 `index.html` 直接打开 |

两个页面均为单文件 HTML + 本地资源，**无构建步骤、无外部 CDN 依赖**。

## 在线演示（推荐，零安装）

仓库已通过 GitHub Pages 托管，浏览器直接打开即可，**不需要装 Python、不需要本地服务器**：

- 入口（两个演示的导航页）：<https://sogersen.github.io/missile-guidance-web/>
- 三维交战动画：<https://sogersen.github.io/missile-guidance-web/web-animation/index.html>
- 示例逐页精读：<https://sogersen.github.io/missile-guidance-web/web-showcase/index.html>

## 本地运行

想在自己电脑上跑（比如改了代码想看效果）：

```bat
git clone https://github.com/SOGERSEN/missile-guidance-web.git
cd missile-guidance-web

:: web-animation 需要 ES 模块加载（浏览器禁止 file://），走本地服务器：
cd web-animation
start_web_demo.bat            :: 或手动: python -m http.server 8137 --bind 127.0.0.1

:: web-showcase 是普通页面，直接双击 index.html 即可
```

`web-animation` 支持 URL 深链，便于分享定位：
`index.html?t=2.0&cam=chase&theme=light`（时间 / 机位 / 主题，详见其 README）。

## 数据从哪来

网页不自己算弹道。MATLAB/Simulink 侧运行官方示例 aero_guidance，
导出脚本把导弹/目标逐帧位置、马赫数、攻角等遥测写成 `web-animation/data/telemetry.js`，
页面逐帧线性插值回放——屏幕上的一切严格来自仿真输出，无外推、无美化。
换一条弹道只需产出同结构的 `window.TELEMETRY`，网页零改动。

- 交战结果：导弹 3 048 m 仰攻（Mach 最大 3.10），T+3.44 s 命中，脱靶量 0.1 m
- 坐标约定、慢放采样等细节见 [`web-animation/README.md`](web-animation/README.md)

## 目录结构

```
missile-guidance-web/
├── index.html              Pages 入口导航页
├── web-animation/          three.js 交战动画（遥测数据 + 贴图 + three.js 本地副本）
├── web-showcase/           官方示例逐页精读页（assets/ 为示例文档截图）
├── LICENSE                 本仓库代码：MIT
└── NOTICE.md               第三方素材与数据来源、各自许可与注意事项
```

## 许可与署名

代码以 [MIT](LICENSE) 发布。`vendor/` 内的 three.js 为 MIT；
`web-showcase/assets/` 的截图来自 MathWorks 官方示例文档（附署名，非背书）；
少数摄影类贴图来自免费素材站，再分发许可见 [NOTICE.md](NOTICE.md) 中的 ⚠️ 条目。
