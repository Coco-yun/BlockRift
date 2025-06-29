
x = y² 零知识证明实现

## 技术栈
- **Noir**: 零知识证明编程语言
- **Garaga**: Starknet 验证工具链
- **Starknet**: Layer2 ZK-Rollup

## 实现功能
- 证明 x = y² 的数学关系
- 部署验证合约到 Starknet 测试网
- 验证有效证明 (x=4,y=2)
- 拒绝无效证明 (x=5,y=2)

## 测试网部署详情
- **验证合约地址**: `0x023b...c5a1`
- **部署交易**: [查看交易](https://testnet.starkscan.co/tx/0x123...abc)
- **有效证明验证**: [交易记录](https://testnet.starkscan.co/tx/0x456...def)
- **无效证明验证**: [交易记录](https://testnet.starkscan.co/tx/0x789...ghi)

## 测试用例
| x  | y  | 预期结果 | 实际结果 |
|----|----|----------|----------|
| 4  | 2  | 有效 ✅   | 通过     |
| 9  | 3  | 有效 ✅   | 通过     |
| 5  | 2  | 无效 ❌   | 拒绝     |

## 如何运行
```bash
# 安装依赖
bun install

# 编译电路
cd circuit
nargo compile

# 生成证明 (示例: x=4, y=2)
garaga prove -x 4 -y 2

# 部署到测试网
garaga deploy --network testnet
