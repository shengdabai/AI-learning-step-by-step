# Claude Code 完整使用指南

> Adam 的 macOS 定制版 | v2.1.94 | Opus 4.6 (1M) | 2026-04-08

---

## 0. 场景速查 — 我要做什么？

> 不知道用什么命令？从这里开始。找到你的场景，直接复制命令。

### 日常高频场景

| 我想... | 用这个 | 备注 |
|---------|--------|------|
| 写新功能 | `/gsd:plan-phase` → `/gsd:execute-phase` | 完整规划+执行 |
| 快速改个小东西 | `/gsd:fast` 或直接说 | 无需规划 |
| 全自动做完 | `/oh-my-claudecode:autopilot` | 从创意到代码 |
| 循环做到完美 | `/oh-my-claudecode:ralph` | 自动迭代 |
| 并行加速 | `/oh-my-claudecode:ultrawork` | 多 Agent 并行 |
| 修 Bug | `/investigate` | 系统化根因分析 |
| 审查代码 | `/review` | PR 着陆前审查 |
| 测试功能 | `/qa` | 自动 QA+修复 |
| 只看报告不修 | `/qa-only` | 只报告 |
| 发布上线 | `/ship` | 测试+审查+PR |
| 设计 UI | `/impeccable:frontend-design` | 高质量前端 |
| 审计设计质量 | `/impeccable:audit` | a11y/性能/主题 |
| 需求不清楚 | `/oh-my-claudecode:deep-interview` | 苏格拉底式澄清 |
| 多 AI 讨论决策 | `/llm-council` | 5 模型投票 |
| 写文档 | `/doc-coauthoring` | 协同撰写 |
| 处理 PDF/Excel/PPT | `/pdf` `/xlsx` `/pptx` | 办公文件处理 |
| 搜索记忆 | `/mem-search` | 跨会话搜索 |
| 查框架文档 | 自动用 context7 MCP | 最新官方文档 |
| 浏览网页 | `/browse` 或 `/web-access` | 无头浏览器 |
| 周复盘 | `/retro` | 提交/质量分析 |

### 决策树：该用哪个执行模式？

```
需要做什么？
├── 简单任务（<10 分钟）
│   ├── 直接描述需求 → Claude 直接做
│   └── 需要原子提交 → /gsd:fast 或 /gsd:quick
├── 中等任务（10-60 分钟）
│   ├── 想全自动 → /oh-my-claudecode:autopilot
│   ├── 想迭代到完美 → /oh-my-claudecode:ralph
│   └── 想并行加速 → /oh-my-claudecode:ultrawork
├── 大型任务（1+ 小时）
│   ├── 先规划 → /make-plan 或 /gsd:plan-phase
│   ├── 再执行 → /do 或 /gsd:execute-phase
│   └── 全自主 → /gsd:autonomous
└── 需要多人/多 AI → /oh-my-claudecode:team
```

### 决策树：该用哪个调试工具？

```
遇到问题了？
├── 代码 Bug → /investigate（系统化根因调试）
├── 构建失败 → /gsd:debug（持久化状态调试）
├── UI 问题 → /impeccable:critique（UX 评估）
├── 性能问题 → /impeccable:optimize 或 /benchmark
├── 安全问题 → /cso（首席安全官审计）
└── 不确定原因 → /oh-my-claudecode:trace（因果追踪）
```

### 决策树：该用哪个审查工具？

```
需要审查什么？
├── 代码质量 → /review（PR 级代码审查）
├── 设计质量 → /design-review 或 /impeccable:audit
├── 技术方案 → /plan-eng-review（工程架构审查）
├── 产品方向 → /plan-ceo-review（创始人视角）
├── UI 设计方案 → /plan-design-review（设计审计）
├── 全部都要 → /autoplan（CEO+设计+工程三合一）
└── AI 生成的垃圾代码 → /oh-my-claudecode:ai-slop-cleaner
```

---

## 1. 核心能力速查（TOP 10 必背）

| # | 命令 | 一句话 | 频率 |
|---|------|--------|------|
| 1 | `/compact` | 压缩上下文省 token | 每天 |
| 2 | `/gsd:next` | 自动推进下一步 | 每天 |
| 3 | `/oh-my-claudecode:autopilot` | 全自主执行 | 每天 |
| 4 | `/review` | 代码审查 | 每天 |
| 5 | `/ship` | 一键发布 | 每周 |
| 6 | `/qa` | 自动 QA 测试+修复 | 每周 |
| 7 | `/investigate` | 系统化调试 | 遇 Bug |
| 8 | `/impeccable:audit` | 设计质量审计 | 完成功能后 |
| 9 | `/oh-my-claudecode:ralph` | 循环到完美 | 复杂任务 |
| 10 | `/model opus` | 切换到最强模型 | 复杂推理 |

### 常用 30（熟悉即可）

| 领域 | 命令 |
|------|------|
| **执行** | `autopilot`, `ralph`, `ultrawork`, `team`, `/gsd:fast`, `/gsd:execute-phase` |
| **规划** | `/make-plan`, `/do`, `/gsd:plan-phase`, `ralplan`, `deep-interview` |
| **审查** | `/review`, `/qa`, `/design-review`, `/plan-ceo-review`, `/plan-eng-review` |
| **调试** | `/investigate`, `/gsd:debug`, `trace`, `/impeccable:optimize` |
| **设计** | `/impeccable:frontend-design`, `/impeccable:audit`, `/impeccable:polish` |
| **发布** | `/ship`, `/land-and-deploy`, `/retro`, `/document-release` |
| **效率** | `/clear`, `/fast`, `/history`, `/mem-search`, `/web-access` |

> 其余 80+ 长尾指令见后续完整参考章节，按需搜索即可。

---

## 2. 何时用 X 不用 Y — 易混淆工具对比

### 执行模式对比

| 场景 | autopilot | ralph | ultrawork | team |
|------|-----------|-------|-----------|------|
| 核心特征 | 全自主一次性 | 循环迭代到完美 | 并行多 Agent | N 个 Agent 协作 |
| 适合 | 需求明确的中等任务 | 需要反复打磨 | 独立子任务多 | 需要分工协作 |
| 不适合 | 需求模糊 | 简单任务 | 任务间有依赖 | 单一任务 |
| 触发词 | "autopilot" | "ralph" | "ulw" | "/team" |

### QA 工具对比

| 场景 | /qa | /qa-only | /browse | /webapp-testing |
|------|-----|----------|---------|-----------------|
| 修不修 | 测试+修复 | 只报告 | 交互式浏览 | Playwright 脚本 |
| 适合 | 要求快速修好 | 只想看报告 | 手动验证 | 自动化回归 |

### 规划工具对比

| 场景 | /make-plan | /gsd:plan-phase | /oh-my-claudecode:plan | ralplan |
|------|-----------|-----------------|----------------------|---------|
| 特征 | 轻量级计划 | GSD 完整规划 | 支持访谈 | 多角色共识 |
| 适合 | 独立功能 | 大型阶段 | 需求不明确 | 团队决策 |

### 调试工具对比

| 场景 | /investigate | /gsd:debug | /oh-my-claudecode:trace |
|------|-------------|-----------|------------------------|
| 方法论 | 系统化根因分析 | 持久化检查点 | 竞争假设追踪 |
| 适合 | 一般 Bug | 跨会话大 Bug | 因果链不清 |

---

## 3. 端到端工作流示例

### 工作流 A：从零开发新功能

```
1. /oh-my-claudecode:deep-interview    ← 澄清需求
2. /gsd:plan-phase                     ← 详细规划
3. /gsd:execute-phase                  ← 执行开发
4. /impeccable:audit                   ← 设计质量审计（目标 20/20）
5. /review                             ← 代码审查
6. /qa                                 ← 自动 QA
7. /ship                               ← 发布 PR
```

### 工作流 B：紧急修 Bug

```
1. /investigate                        ← 根因分析
2. 直接修复                             ← Claude 实现修复
3. /qa                                 ← 验证修复
4. /ship                               ← 发布
```

### 工作流 C：设计+前端开发

```
1. /design-consultation                ← 建立设计系统
2. /impeccable:frontend-design         ← 实现界面
3. /impeccable:animate                 ← 添加动效
4. /impeccable:adapt                   ← 响应式适配
5. /impeccable:audit                   ← 质量审计 → 迭代到满分
6. /ship                               ← 发布
```

### 工作流 D：多 AI 协同大项目

```
1. /llm-council "该用什么技术栈？"      ← 多模型投票决策
2. /gsd:new-project                    ← 初始化项目
3. /gsd:autonomous                     ← 全自主执行所有阶段
4. /retro                              ← 周复盘
```

---

## 4. MCP 服务器（11 个）— 何时用哪个？

| 服务器 | 一句话 | 何时选它 |
|--------|--------|---------|
| **context7** | 框架/库官方文档 | 写代码前查最新 API，替代过时记忆 |
| **playwright** | 浏览器自动化 | 测试网页、截图、点击、填表 |
| **github** | GitHub API | 创建 PR/Issue、查看 CI 状态 |
| **exa** | AI 搜索引擎 | 搜索技术文章、找解决方案 |
| **firecrawl** | 网页爬取 | 提取网页全文内容（比 exa 更深） |
| **notion** | Notion 操作 | 读写 Notion 页面和数据库 |
| **lark** | 飞书集成 | 读写飞书文档 |
| **airmcp** | Airtable 操作 | 读写 Airtable 数据库 |
| **getnote** | 教学录音笔记 | 访问 200h 教学录音数据 |
| **notebooklm** | NotebookLM | Google NotebookLM 集成 |
| **gmail** | Gmail 邮件 | 搜索/读取/草拟邮件（内置连接器） |

### MCP 选择决策

```
需要什么信息？
├── 框架/库文档 → context7（resolve-library-id → get-library-docs）
├── 搜索互联网 → exa（AI 语义搜索）
├── 抓取特定网页 → firecrawl（全文提取）
├── 操作浏览器 → playwright（导航/截图/交互）
├── GitHub 操作 → github（PR/Issue/CI）
├── 项目管理数据 → notion / airmcp / lark
├── 教学录音 → getnote
└── 邮件 → gmail
```

---

## 5. 官方内置指令

### 交互式指令

| 指令 | 说明 |
|------|------|
| `/help` | 显示帮助 |
| `/clear` | 清空对话上下文 |
| `/compact` | 压缩上下文节省 token |
| `/compact [指令]` | 按自定义指令压缩 |
| `/model opus/sonnet/haiku` | 切换模型 |
| `/fast` | 切换快速模式（同模型加速） |
| `/cost` | 显示 token 使用量和费用 |
| `/doctor` | 诊断配置问题 |
| `/config` | 管理配置 |
| `/permissions` | 管理权限 |
| `/hooks` | 管理 hooks |
| `/mcp` | 管理 MCP 服务器 |
| `/plugins` | 管理插件 |
| `/init` | 初始化项目 CLAUDE.md |
| `/memory` | 编辑记忆文件 |
| `/vim` | 切换 vim 模式 |
| `/login` / `/logout` | 登录/登出 |
| `/bug` | 报告 bug |
| `/exit` | 退出 |

### 快捷操作

| 操作 | 说明 |
|------|------|
| `! <cmd>` | 执行 shell 命令（如 `! npm run dev`） |
| `@file` | 引入文件到上下文（如 `@src/config.ts`） |
| `Ctrl+C` × 2 | 退出 |
| `Shift+Enter` | 换行不发送 |
| 拖拽文件 | 自动添加路径 |
| 粘贴图片 | 多模态输入（截图/设计稿） |
| `↑` / `↓` | 浏览历史 |

### 命令行参数

```bash
claude                              # 交互式会话
claude -p "prompt"                  # 单次执行
claude --resume [id]                # 恢复会话
claude --continue                   # 继续最近会话
claude --model opus                 # 指定模型
claude --fast                       # 快速模式
claude --dangerously-skip-permissions  # 跳过权限
claude --max-turns <n>              # 限制轮数
claude --output-format json         # JSON 输出
claude --system-prompt "..."        # 自定义系统提示
claude --mcp-config <path>          # 指定 MCP 配置
claude --add-dir <path>             # 添加工作目录
cat file | claude -p "review"       # 管道输入
```

---

## 6. 全部能力索引（按任务域分类）

> 以下将 Skills、Commands、Agents 按「你想做什么」统一组织，不再按插件来源分类。
> 频率标记：`***` 核心 | `**` 常用 | `*` 长尾

### 6.1 编码与执行

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/oh-my-claudecode:autopilot` | 全自主：创意→代码 | OMC | *** |
| `/oh-my-claudecode:ralph` | 循环迭代到完成 | OMC | *** |
| `/oh-my-claudecode:ultrawork` | 并行执行引擎 | OMC | *** |
| `/gsd:execute-phase` | 阶段执行（波次并行） | GSD | *** |
| `/gsd:fast` | 内联快速执行 | GSD | *** |
| `/gsd:quick` | 快速执行+原子提交 | GSD | ** |
| `/gsd:autonomous` | 全自主跑完所有阶段 | GSD | ** |
| `/oh-my-claudecode:team` | N 个 Agent 协同 | OMC | ** |
| `/oh-my-claudecode:ultraqa` | 循环 QA 测试修复 | OMC | ** |
| `/oh-my-claudecode:pua-loop` | PUA 驱动自动循环 | OMC | * |
| `/oh-my-claudecode:self-improve` | 自主进化代码改进 | OMC | * |
| `/superpowers:subagent-driven-development` | 子 Agent 驱动 | SP | * |
| `/superpowers:dispatching-parallel-agents` | 派发并行 Agent | SP | * |
| `/oh-my-claudecode:cancel` | 取消所有活跃模式 | OMC | ** |

### 6.2 规划与需求

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/gsd:plan-phase` | 创建阶段计划 | GSD | *** |
| `/make-plan` | 创建分阶段实现计划 | 本地 | *** |
| `/do` | 执行计划 | 本地 | *** |
| `/oh-my-claudecode:deep-interview` | 苏格拉底式需求澄清 | OMC | ** |
| `/oh-my-claudecode:plan` | 战略规划 | OMC | ** |
| `/oh-my-claudecode:ralplan` | 多角色共识规划 | OMC | ** |
| `/gsd:discuss-phase` | 收集阶段上下文 | GSD | ** |
| `/gsd:research-phase` | 研究如何实现 | GSD | ** |
| `/superpowers:brainstorming` | 创意探索（自动触发） | SP | ** |
| `/superpowers:writing-plans` | 编写实现计划 | SP | * |
| `/planning-with-files` | Manus 风格文件化管理 | 本地 | * |
| `/swarm-coordinator` | 蜂群协调 | 本地 | * |
| `/oh-my-claudecode:deep-dive` | 追踪+深度访谈 | OMC | * |
| `/oh-my-claudecode:sciomc` | 并行科学分析 | OMC | * |

### 6.3 审查与质量

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/review` | PR 代码审查 | 本地 | *** |
| `/impeccable:audit` | 技术质量审计 | IMP | *** |
| `/plan-ceo-review` | CEO 视角审查 | 本地 | ** |
| `/plan-eng-review` | 工程经理审查 | 本地 | ** |
| `/plan-design-review` | 设计师视角审查 | 本地 | ** |
| `/autoplan` | 三合一自动审查 | 本地 | ** |
| `/impeccable:critique` | UX 设计评估 | IMP | ** |
| `/impeccable:polish` | 最终精打细磨 | IMP | ** |
| `/simplify` | 代码重用/质量 | 本地 | * |
| `/verification-gate` | 只读验证通行证 | 本地 | * |
| `/oh-my-claudecode:ai-slop-cleaner` | AI 代码清理 | OMC | * |
| `/oh-my-claudecode:verify` | 完成前真实验证 | OMC | ** |
| `/oh-my-claudecode:visual-verdict` | 截图视觉对比 | OMC | * |
| `/superpowers:verification-before-completion` | 完成前验证（自动触发） | SP | * |

### 6.4 调试与修复

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/investigate` | 系统化根因调试 | 本地 | *** |
| `/gsd:debug` | 持久化状态调试 | GSD | ** |
| `/oh-my-claudecode:trace` | 因果追踪 | OMC | * |
| `/oh-my-claudecode:debug` | OMC 会话/仓库诊断 | OMC | * |
| `/gsd:forensics` | GSD 失败工作流事后分析 | GSD | * |
| `/superpowers:systematic-debugging` | 系统化调试（自动触发） | SP | * |

### 6.5 测试与 QA

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/qa` | 自动 QA+修复 | 本地 | *** |
| `/qa-only` | 只报告不修复 | 本地 | ** |
| `/browse` | 无头浏览器 QA | 本地 | ** |
| `/gstack` | 无头浏览器站点测试 | 本地 | ** |
| `/webapp-testing` | Playwright 测试 | 本地 | * |
| `/benchmark` | 性能回归检测 | 本地 | * |
| `/canary` | 部署后金丝雀监控 | 本地 | * |
| `/superpowers:test-driven-development` | TDD（自动触发） | SP | * |
| `/gsd:verify-work` | 对话式 UAT 验证 | GSD | * |
| `/gsd:validate-phase` | 回溯审计验证覆盖率 | GSD | * |
| `/gsd:audit-uat` | 跨阶段 UAT 审计 | GSD | * |
| `/gsd:ui-phase` | 生成 UI 设计合约 | GSD | * |
| `/gsd:ui-review` | 前端 6 维视觉审计 | GSD | * |
| `/gsd:add-tests` | 为阶段生成测试 | GSD | * |

### 6.6 设计与前端

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/impeccable:frontend-design` | 高质量前端创建 | IMP | *** |
| `/frontend-design` | 高质量前端（本地版） | 本地 | ** |
| `/design-consultation` | 完整设计系统咨询 | 本地 | ** |
| `/design-review` | 设计师视角 QA | 本地 | ** |
| `/impeccable:animate` | 添加动效微交互 | IMP | ** |
| `/impeccable:arrange` | 改善布局节奏 | IMP | * |
| `/impeccable:adapt` | 响应式适配 | IMP | * |
| `/impeccable:colorize` | 添加战略性色彩 | IMP | * |
| `/impeccable:typeset` | 改善字体排版 | IMP | * |
| `/impeccable:bolder` | 增强视觉冲击 | IMP | * |
| `/impeccable:quieter` | 降低视觉攻击性 | IMP | * |
| `/impeccable:distill` | 简化去噪 | IMP | * |
| `/impeccable:clarify` | 改善 UX 文案 | IMP | * |
| `/impeccable:harden` | 增强健壮性 | IMP | * |
| `/impeccable:delight` | 添加愉悦细节 | IMP | * |
| `/impeccable:normalize` | 对齐设计系统 | IMP | * |
| `/impeccable:extract` | 提取可复用组件 | IMP | * |
| `/impeccable:onboard` | 设计引导流程 | IMP | * |
| `/impeccable:optimize` | 优化 UI 性能 | IMP | * |
| `/impeccable:overdrive` | 极限技术实现 | IMP | * |
| `/canvas-design` | 视觉设计（海报/艺术） | 本地 | * |
| `/algorithmic-art` | p5.js 生成艺术 | 本地 | * |
| `/brand-guidelines` | Anthropic 品牌指南 | 本地 | * |
| `/theme-factory` | 主题工厂 | 本地 | * |
| `/web-artifacts-builder` | HTML 组件构建 | 本地 | * |
| `/slack-gif-creator` | Slack GIF 创建 | 本地 | * |
| `/impeccable:teach-impeccable` | 初始化设计上下文 | IMP | * |

### 6.7 发布与运维

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/ship` | 一键发布流程 | 本地 | *** |
| `/land-and-deploy` | 合并+部署+健康检查 | 本地 | ** |
| `/retro` | 周复盘 | 本地 | ** |
| `/gsd:ship` | GSD 发布 | GSD | ** |
| `/document-release` | 发布后文档更新 | 本地 | * |
| `/setup-deploy` | 配置部署设置 | 本地 | * |
| `/gsd:pr-branch` | 创建干净 PR 分支 | GSD | * |
| `/superpowers:using-git-worktrees` | Git worktree 隔离 | SP | * |
| `/superpowers:finishing-a-development-branch` | 完成分支 | SP | * |
| `/superpowers:requesting-code-review` | 请求审查 | SP | * |

### 6.8 文档与内容

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/pdf` | PDF 处理 | 本地 | ** |
| `/xlsx` | Excel 处理 | 本地 | ** |
| `/pptx` | PowerPoint 处理 | 本地 | * |
| `/docx` | Word 文档处理 | 本地 | * |
| `/doc-coauthoring` | 文档协同撰写 | 本地 | * |
| `/internal-comms` | 内部沟通模板 | 本地 | * |

### 6.9 研究与搜索

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/web-access` | 联网操作统一入口 | 本地 | ** |
| `/smart-explore` | AST 解析代码搜索 | 本地 | ** |
| `/oh-my-claudecode:external-context` | 并行外部文档搜索 | OMC | * |
| `/oh-my-claudecode:ccg` | Claude+Codex+Gemini 协同 | OMC | * |
| `/oh-my-claudecode:ask` | 多模型问答 | OMC | * |
| `/llm-council` | 多模型议会投票 | 本地 | * |
| `/codex` | Codex CLI 包装器 | 本地 | * |
| `/office-hours` | YC 式创业问诊 | 本地 | * |

### 6.10 项目管理（GSD 框架）

| 命令 | 说明 | 频率 |
|------|------|------|
| `/gsd:new-project` | 新项目初始化 | ** |
| `/gsd:new-milestone` | 新里程碑 | ** |
| `/gsd:next` | 自动下一步 | *** |
| `/gsd:progress` | 检查进度 | ** |
| `/gsd:add-todo` | 捕获待办 | ** |
| `/gsd:check-todos` | 列出待办 | ** |
| `/gsd:note` | 零摩擦笔记 | ** |
| `/gsd:pause-work` | 暂停+交接 | * |
| `/gsd:resume-work` | 恢复工作 | * |
| `/gsd:add-phase` | 添加阶段 | * |
| `/gsd:insert-phase` | 插入紧急阶段 | * |
| `/gsd:remove-phase` | 移除阶段 | * |
| `/gsd:add-backlog` | 添加积压 | * |
| `/gsd:review-backlog` | 审查积压 | * |
| `/gsd:plant-seed` | 种前瞻想法 | * |
| `/gsd:workstreams` | 并行工作流 | * |
| `/gsd:thread` | 持久化线程 | * |
| `/gsd:audit-milestone` | 里程碑审计 | * |
| `/gsd:complete-milestone` | 归档里程碑 | * |
| `/gsd:milestone-summary` | 里程碑报告 | * |
| `/gsd:map-codebase` | 代码库分析 | * |
| `/gsd:stats` | 项目统计 | * |
| `/gsd:session-report` | 会话报告 | * |
| `/gsd:do` | 自然语言路由到 GSD 命令 | ** |
| `/gsd:manager` | 多阶段交互式控制台 | ** |
| `/gsd:cleanup` | 归档已完成阶段目录 | * |
| `/gsd:profile-user` | 开发者行为画像 | * |
| `/gsd:new-workspace` | 创建隔离工作区 | * |
| `/gsd:remove-workspace` | 移除工作区 | * |
| `/gsd:list-workspaces` | 列出活跃工作区 | * |
| `/gsd:set-profile` | 切换 Agent 模型配置 | * |
| `/gsd:reapply-patches` | 更新后重新应用补丁 | * |
| `/gsd:plan-milestone-gaps` | 根据审计创建补缺阶段 | * |
| `/gsd:list-phase-assumptions` | 暴露阶段假设 | * |
| `/gsd:forensics` | GSD 失败事后分析 | * |
| `/gsd:join-discord` | 加入 GSD Discord 社区 | * |

### 6.11 AI/Agent 构建

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/agent-builder` | 设计构建 AI Agent | 本地 | * |
| `/mcp-builder` | 创建 MCP 服务器 | 本地 | * |
| `/claude-api` | Claude API/SDK | 本地 | * |
| `/skill-creator` | 创建/测试 Skills | 本地 | * |

### 6.12 效率与工具

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/history` | 浏览对话历史 | 本地 | ** |
| `/mem-search` | 跨会话记忆搜索 | 本地 | ** |
| `/memory-extractor` | 提取持久记忆 | 本地 | * |
| `/dream-memory` | 整理记忆文件 | 本地 | * |
| `/oh-my-claudecode:remember` | 审查并持久化项目知识 | OMC | * |
| `/oh-my-claudecode:wiki` | LLM Wiki 持久知识库 | OMC | * |
| `/oh-my-claudecode:skillify` | 对话工作流转技能 | OMC | * |
| `/timeline-report` | 开发历史报告 | 本地 | * |
| `/smux` | tmux Agent 通信 | 本地 | * |
| `/loop` | 定时循环执行 | 本地 | * |
| `/rename` | 重命名终端标签 | 本地 | * |
| `/remote-control` | 手机/浏览器同步 | 本地 | * |
| `/limit-continue-work` | 限额后自动恢复 | 本地 | * |
| `/structured-context-compressor` | 上下文压缩续写 | 本地 | * |
| `/kairos-lite` | 后台主动模式 | 本地 | * |
| `/risk-guard` | 账户封禁风险监控 | 本地 | * |

### 6.13 安全与防护

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/cso` | 首席安全官审计 | 本地 | * |
| `/guard` | 完整安全模式 | 本地 | * |
| `/careful` | 危险命令警告 | 本地 | * |
| `/freeze` / `/unfreeze` | 锁定/解锁编辑目录 | 本地 | * |

### 6.14 高压驱动模式

| 命令 | 说明 | 风格 |
|------|------|------|
| `/pua` | 大厂 PUA | 中文施压 |
| `/pua-en` | 西方 PIP | 英文绩效改进 |
| `/pua-ja` | 日式「詰め」 | 日文追问 |
| `/mama` | 妈妈唠叨 | 中文碎碎念 |
| `/yes` | 夸夸领导 | 中文鼓励 |
| `/shot` | PUA 浓缩 | 全量注入 |
| `/pro` | 进化追踪 | KPI/排行 |

### 6.15 社交与内容

| 命令 | 说明 | 来源 |
|------|------|------|
| `/twitter` | X/Twitter 发推 | 本地 |
| `/youtube` | YouTube 视频创建 | 本地 |

### 6.16 工程师角色模式

| 命令 | 说明 |
|------|------|
| `/p7` | P7 高级工程师：方案驱动执行 |
| `/p9` | P9 Tech Lead：任务拆解+团队管理 |
| `/p10` | P10 CTO：战略方向+组织设计 |

### 6.17 n8n 专用

| 命令 | 说明 |
|------|------|
| `/n8n-workflow-patterns` | 工作流架构模式 |
| `/n8n-mcp-tools-expert` | MCP 工具专家 |
| `/n8n-validation-expert` | 验证错误解读 |
| `/n8n-code-javascript` | Code 节点 JS |
| `/n8n-code-python` | Code 节点 Python |
| `/n8n-expression-syntax` | 表达式语法 |
| `/n8n-node-configuration` | 节点配置指南 |

### 6.18 生活与趣味

| 命令 | 说明 | 来源 | 频率 |
|------|------|------|------|
| `/fit-coach` | 健身教练（营养+训练） | 本地 | * |
| `/buddy-change` | 更换电子宠物 | 本地 | * |
| `/5-steps` | 马斯克五步工作法 | 本地 | * |

### 6.19 配置与诊断

| 命令 | 说明 | 来源 |
|------|------|------|
| `/oh-my-claudecode:omc-setup` | 安装 OMC | OMC |
| `/oh-my-claudecode:setup` | 统一设置入口 | OMC |
| `/oh-my-claudecode:mcp-setup` | 配置 MCP | OMC |
| `/oh-my-claudecode:omc-doctor` | 诊断 OMC | OMC |
| `/oh-my-claudecode:hud` | 配置 HUD | OMC |
| `/oh-my-claudecode:configure-notifications` | 配置通知 | OMC |
| `/oh-my-claudecode:skill` | 管理技能 | OMC |
| `/oh-my-claudecode:learner` | 从对话提取技能 | OMC |
| `/oh-my-claudecode:deepinit` | 深度代码库初始化 | OMC |
| `/oh-my-claudecode:project-session-manager` | 会话管理 | OMC |
| `/oh-my-claudecode:release` | 自动发布工作流 | OMC |
| `/oh-my-claudecode:writer-memory` | 写作记忆系统 | OMC |
| `/claude-hud:setup` | 配置 HUD 状态栏 | HUD |
| `/claude-hud:configure` | HUD 显示选项 | HUD |
| `/superpowers:writing-skills` | 创建/编辑 Skills | SP |
| `/gsd:health` | 诊断 GSD | GSD |
| `/gsd:settings` | GSD 配置 | GSD |
| `/gsd:update` | 更新 GSD | GSD |
| `/gsd:help` | GSD 帮助 | GSD |
| `/setup-browser-cookies` | 导入浏览器 Cookies | 本地 |

---

## 7. Agent 速查

### GSD Agent（18 个）— 由 GSD 框架自动调度

| Agent | 一句话角色 |
|-------|-----------|
| `gsd-project-researcher` | 领域生态研究 |
| `gsd-research-synthesizer` | 研究综合 |
| `gsd-roadmapper` | 路线图 |
| `gsd-phase-researcher` | 阶段研究 |
| `gsd-planner` | 计划创建 |
| `gsd-plan-checker` | 计划验证 |
| `gsd-executor` | 执行（原子提交） |
| `gsd-verifier` | 目标验证 |
| `gsd-debugger` | 科学调试 |
| `gsd-codebase-mapper` | 代码库分析 |
| `gsd-assumptions-analyzer` | 假设分析 |
| `gsd-advisor-researcher` | 决策研究 |
| `gsd-user-profiler` | 行为画像 |
| `gsd-integration-checker` | 集成检查 |
| `gsd-nyquist-auditor` | 覆盖率审计 |
| `gsd-ui-researcher` | UI 规格研究 |
| `gsd-ui-checker` | UI 质量验证 |
| `gsd-ui-auditor` | UI 回顾审计 |

### OMC Agent（19 个）— 按需手动或自动调度

| Agent | 角色 | 推荐模型 | 何时用 |
|-------|------|---------|--------|
| `executor` | 代码实现 | sonnet/opus | 写代码 |
| `architect` | 架构设计 | opus | 系统设计 |
| `planner` | 规划 | opus | 制定计划 |
| `explorer` | 代码搜索 | sonnet | 探索代码库 |
| `designer` | UI/UX | sonnet | 设计界面 |
| `code-reviewer` | 代码审查 | sonnet | 审查 PR |
| `debugger` | 调试 | sonnet | 修 Bug |
| `test-engineer` | 测试 | sonnet | 写测试 |
| `verifier` | 验证 | sonnet | 确认完成 |
| `critic` | 评审 | opus | 深度评审 |
| `analyst` | 需求分析 | opus | 需求分析 |
| `scientist` | 数据研究 | sonnet | 数据分析 |
| `security-reviewer` | 安全检测 | sonnet | 安全审计 |
| `qa-tester` | QA 测试 | sonnet | 交互测试 |
| `writer` | 文档 | haiku | 写文档 |
| `code-simplifier` | 精简 | sonnet | 简化代码 |
| `tracer` | 追踪 | sonnet | 因果追踪 |
| `git-master` | Git | sonnet | Git 操作 |
| `document-specialist` | 文档检索 | sonnet | 查外部文档 |

---

## 8. 插件系统

| 插件 | 版本 | 说明 | 提供的能力 |
|------|------|------|-----------|
| **oh-my-claudecode** | 4.11.1 | 多 Agent 编排核心 | 35+ skills + 19 agents + hooks + HUD |
| **superpowers** | 5.0.7 | 官方工作流增强 | 15 skills（TDD/调试/计划/审查） |
| **impeccable** | 1.6.0 | 设计质量增强 | 20 skills（前端设计全链路） |
| **claude-hud** | 0.0.12 | 状态栏显示 | 2 skills（HUD 配置） |

```bash
claude plugins list      # 查看已安装
claude plugins update    # 更新所有
/plugins                 # 交互管理
```

---

## 9. Hooks 钩子系统

### 已配置 Hooks

| 事件 | 脚本 | 做什么 |
|------|------|--------|
| SessionStart | `gsd-check-update.js` | GSD 更新检查 |
| SessionStart/End/Stop/Submit | `vibe-island-bridge` | Vibe Island 同步 |
| PreToolUse (Write/Edit) | `gsd-prompt-guard.js` | 写入保护 |
| PostToolUse (Bash/Edit/Write/Agent) | `gsd-context-monitor.js` | 上下文监控 |
| Notification | ntfy.sh | 推送"需要回复"到手机 |
| Stop | ntfy.sh | 推送"任务完成"到手机 |

### Hook 事件类型

| 事件 | 触发时机 | 可做什么 |
|------|---------|---------|
| `SessionStart` | 会话开始 | 初始化检查 |
| `SessionEnd` | 会话结束 | 清理/同步 |
| `PreToolUse` | 工具调用前 | 拦截/保护 |
| `PostToolUse` | 工具调用后 | 监控/记录 |
| `Notification` | 需注意时 | 推送通知 |
| `Stop` | 回复完成 | 通知完成 |
| `UserPromptSubmit` | 用户发送 | 预处理 |
| `SubagentStop` | 子 Agent 完成 | 回调 |

---

## 10. 配置体系

### CLAUDE.md 优先级

```
~/.claude/CLAUDE.md                    ← 全局（所有项目）
项目根/CLAUDE.md                       ← 项目级
项目根/.claude/CLAUDE.md               ← 项目级（隐藏）
子目录/CLAUDE.md                       ← 目录级
~/.claude/projects/<path>/CLAUDE.md    ← 项目私有（不入 git）
```

### 你的全局配置要点

- **技术栈**：TypeScript + Next.js, Python, JavaScript
- **部署**：Vercel + Railway
- **语言**：中文输出 / 英文思考 / 代码英文
- **质量**：设计审计满分 20/20 才算完成
- **交互**：不停下问问题，做合理假设
- **模型**：复杂任务提醒切 Opus

### 关键配置文件

| 文件 | 路径 |
|------|------|
| 全局设置 | `~/.claude/settings.json` |
| 本地权限 | `~/.claude/settings.local.json` |
| 插件 | `~/.claude/plugins/` |
| 技能 | `~/.claude/skills/` |
| 命令 | `~/.claude/commands/` |
| Agent | `~/.claude/agents/` |
| Hooks | `~/.claude/hooks/` |
| 记忆 | `~/.claude/projects/<path>/memory/` |
| HUD | `~/.claude/hud/` |
| GSD 状态 | `.omc/state/` |

### 记忆系统

| 类型 | 用途 |
|------|------|
| `user` | 用户画像（角色/偏好/知识） |
| `feedback` | 行为反馈（做/不做什么） |
| `project` | 项目上下文（目标/约束） |
| `reference` | 外部资源指针 |

### 环境变量

| 变量 | 说明 |
|------|------|
| `CLAUDE_CODE_DISABLE_TELEMETRY=1` | 禁用遥测 |
| `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` | 启用 Agent 团队 |
| `CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1` | 不改终端标题 |

---

## 11. 高效使用技巧

### 模型选择

| 场景 | 模型 | 命令 |
|------|------|------|
| 复杂推理/架构 | Opus 4.6 | `/model opus` |
| 日常编码 | Sonnet 4.6 | `/model sonnet` |
| 快速查询 | Haiku 4.5 | `/model haiku` |
| 加速输出 | 快速模式 | `/fast` |

### 上下文管理

- `/compact` — 长对话及时压缩
- `/clear` — 切换任务清空
- 新终端 — 不相关任务开新会话
- `@file` — 精确引入需要的文件

### 高效提示词

```
差：帮我改一下登录页面
好：在 src/pages/login.tsx 中，把表单验证改成实时校验，
    参考 src/utils/validators.ts 中的校验函数

原则：给路径 + 给范围 + 给参考
```

### 不要做的事

- 不要在 Hooks/MCP 中用 `npx`（必须 `npm i -g` + 绝对路径）
- 不要假设沙箱环境有 Node.js globals（先调查可用 API）
- 不要凭记忆猜 API 字段名（先用 context7 查文档）
- 不要在 smux 团队环境中用 Agent tool（用 tmux-bridge）

---

## 12. 故障排查

### 决策树

```
出了什么问题？
├── Token 超限 → /compact 或开新会话
├── MCP 无响应 → /mcp 检查状态，重启 Claude Code
├── Hook 失败 → 检查 ~/.claude/hooks/ 脚本权限
├── Node.js 路径 → 用绝对路径 ~/.nvm/versions/node/v24.14.0/bin/node
├── NVM lazy-loading → source ~/.nvm/nvm.sh 或用绝对路径
├── 插件不生效 → /plugins 检查启用状态
├── 5 小时限额 → /limit-continue-work 自动恢复
└── 不确定什么问题 → /doctor 全面诊断
```

### 诊断命令

```bash
claude --version                    # 版本
/doctor                             # 全面诊断
/oh-my-claudecode:omc-doctor        # OMC 诊断
/gsd:health                         # GSD 诊断
/risk-guard                         # 使用风险检查
```

---

> 本指南基于 Adam 的 macOS 环境实际配置 + LLM Council 5 模型优化
> Claude Code v2.1.94 | OMC v4.11.1 | Superpowers v5.0.7 | Impeccable v1.6.0 | Claude HUD v0.0.12
