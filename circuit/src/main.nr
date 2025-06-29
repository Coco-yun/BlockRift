// 证明 x = y²
fn main(x: Field, y: Field) {
    // 计算 y 的平方
    let y_squared = y * y;
    
    // 约束: x 必须等于 y_squared
    constrain x == y_squared;
}
