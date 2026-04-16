# 公众号文章核心整理

整理时间：2026-04-10

## 1. Claude Code 推出 Monitor 功能，帮你随时盯梢

- 原文链接：[https://mp.weixin.qq.com/s/9FxcKbvJJcMVtnSdgUcZ8w](https://mp.weixin.qq.com/s/9FxcKbvJJcMVtnSdgUcZ8w)
- 来源：AGI Hunt
- 发布时间：2026-04-10 10:09:41 CST
- 核心一句话：`Monitor` 把 Claude Code 的“不断轮询”改成了“后台监听 + 事件触发”，让 Agent 只在真正有事时醒来处理。

### 核心内容

1. 文章认为 `Monitor` 解决的是 AI 编程工具里长期存在的轮询问题。过去让 Agent 盯日志、等 CI、查 PR 状态，常见做法是反复 `cat`、`curl`、`gh pr view` 或 `sleep` 定时检查，既笨重又耗 token。
2. `Monitor` 的机制是让 Claude Code 在后台挂一个持续运行的监控脚本，脚本正常运行时不打扰 Agent，一旦输出中出现关键事件，例如日志报错，Claude 才被唤醒并开始调查。
3. 文中用官方演示说明体验变化：用户只需说“帮我监控日志有没有报错”，Claude 会自己启动后台监控；当日志出现 `ERROR db: connection refused to postgres:5432` 时，主界面收到事件并自动开始排查。
4. 文章强调它本质上是从 `polling` 变成 `event-driven`。作者认为这比固定间隔巡检更合理，尤其适合长时间运行的 Agent 工作流，因为轮询会吞掉大量无效 token。
5. 适用场景包括日志监控、CI/CD 状态跟踪、开发服务器报错监控、数据库迁移监控、部署后稳定性观察，也可以和 hooks、后台 Agent 组合。
6. 文中把三类能力做了分工：
   - `/loop`：本地、按固定频率执行，适合短期高频巡检。
   - `/schedule`：云端、按时间表执行，适合周期性维护任务。
   - `Monitor`：持续监听，只有异常或事件发生时才触发。
7. 使用上需要在提示词里明确要求 Claude 使用 `Monitor`，否则它可能还是会用旧式轮询办法。
8. 文章提醒几个限制：监控脚本写得太粗会误报，写得太细会漏报；更适合本地开发环境；权限受 Bash allow/deny 规则影响；当前主要可用于 Claude Code CLI，托管平台暂不可用。
9. 作者最终判断是：`Monitor` 本身技术不算复杂，但它和 hooks、background agents、skills 一起，显示 Anthropic 正把 Claude Code 从“对话式编程助手”推向“可在后台持续运转的工程系统”。

### 一句话总结

这篇文章的重点不是“多了一个小功能”，而是 `Monitor` 代表 Claude Code 正在从“你一直盯着它干活”变成“它自己盯着系统，有事再叫你”。

## 2. 一行代码，Claude养虾成本降85%！最强Opus做大脑，Sonnet疯狂搬砖

- 原文链接：[https://mp.weixin.qq.com/s/RmU3albmI_T46NVoC0ieFQ](https://mp.weixin.qq.com/s/RmU3albmI_T46NVoC0ieFQ)
- 来源：新智元
- 发布时间：2026-04-10 09:43:39 CST
- 核心一句话：Anthropic 推出 `Advisor Strategy`，让 `Opus` 退到幕后做“顾问”，由 `Sonnet/Haiku` 执行具体任务，在尽量保留高水平智能的同时显著降低成本。

### 核心内容

1. 文章介绍的主角是 `Advisor Strategy`。其思路不是让最强模型始终站在前台统一拆任务，而是让 `Sonnet 4.6` 或 `Haiku 4.5` 负责端到端执行，只有遇到难题时才向 `Opus 4.6` 咨询。
2. 这种结构可以理解为：
   - `Opus`：做“大脑”或“军师”，给计划、纠偏或停止信号。
   - `Sonnet/Haiku`：做“执行者”，实际调用工具、运行流程、读取结果、推进任务。
3. 文章认为这反转了传统“大模型先拆解、小模型再搬砖”的常规套路，把最贵的推理资源只用在关键判断点上，从而提高性价比。
4. 文中列出的效果数据是全文重点：
   - `Sonnet 4.6 + Opus 4.6` 在 SWE-bench 上提升 2.7 个百分点，同时成本下降 11.9%。
   - `Haiku 4.5 + Opus 4.6` 在部分基准上性能翻倍，但成本极低，文中称相较 Sonnet 级方案可降至很小一部分，总体降本幅度可到 85% 左右。
   - 对高并发、预算敏感场景，文章特别看好 `Haiku + Opus 顾问` 组合。
5. 落地方式也很直接。文中强调在 Messages API 里只需增加一项 `advisor_20260301` 工具声明，就能让执行模型在单次请求内部静默地向顾问模型求助，不需要开发者手工搬运上下文。
6. 计费逻辑是分层计算：执行者按 `Sonnet/Haiku` 费率计费，顾问按 `Opus` 费率计费，但顾问通常只输出短计划，所以总体成本远低于全流程都用 `Opus`。
7. 开发者还可以通过 `max_uses` 控制单次请求中顾问的最大调用次数，并单独跟踪顾问 token 消耗。
8. 文章随后把这次更新放到更大的产品路线里看：同日还有 `Monitor`，更早还有 `Managed Agents` 与 `MCP Connectors`。作者的判断是，Anthropic 正在从“卖模型 API”走向“卖完整 Agent 运行时平台”。
9. 具体来说，文中的路线图是：
   - `Advisor Strategy`：优化模型调度与成本。
   - `Monitor`：优化等待和监听效率。
   - `Managed Agents`：接管运行环境和基础设施。
   - `MCP Connectors`：补齐工具接入和生态层。
10. 文末还提到关于 Claude 参数量的“彩蛋”，例如 Sonnet 约 1T、Opus 约 5T 等说法；这些内容在文中以外部言论和猜测形式出现，更适合看作行业传闻，不宜当作官方确认信息。

### 一句话总结

这篇文章的核心不是单一 API 更新，而是 Anthropic 在推动一种新范式：让便宜模型负责大部分执行，让最强模型只在关键决策点出手，把“高智能”变成按需调用的能力层。

## 综合结论

两篇文章其实在讲同一件事的两个侧面：

- `Monitor` 解决的是 Agent 的“等待方式”，从轮询转向事件驱动。
- `Advisor Strategy` 解决的是 Agent 的“思考成本”，把高阶推理变成按需咨询。
- 再叠加 `Managed Agents` 和 `MCP Connectors`，Anthropic 的方向已经很明确：不是只做更强模型，而是在搭一整套可托管、可调度、可监听、可接工具的 Agent 平台。
