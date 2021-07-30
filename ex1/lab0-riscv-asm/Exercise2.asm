	lui	s1,0xFFFFF	# 基地址
	
	
switread:
	lw	a0,0x70(s1)	# 低16位拨码
	lw	a1,0x72(s1)	# 高8位拨码，读取SW22和SW23的值，判断计算类型
	# 判断复位 SW[21] 是否有效，有效则一直显示零
	andi 	t5,a1,0x020
	addi 	t6,zero,0x020
	bne 	t5,t6,mark_sw21
	sw 	zero,0x060(s1)	# 复位则全熄灭
	jal 	switread
mark_sw21:
	addi	a2,zero,0x080	# 构造用来比较的数值
	addi	a3,zero,0x040
	addi	a4,zero,0x0C0
	andi	a1,a1,0x0C0	# 0000 1100 0000
	beq	a1,a2,pow3	# 如果等于 1000 0000 开立方
	beq	a1,a3,pow2	# 如果等于 0100 0000 开平方
	beq	a1,a4,pow3
	jal	loop2
loop1:
	sw	a0,0x60(s1)	# 低16位
	lw	a1,0x72(s1)	# 高8位，判断SW21清零是否有效，无效则一直在这循环
	andi	a1,a1,0x020	# 0010 0000
	beq	a1,zero,loop1
loop2:
	jal	switread	# 无限循环
	
	
pow3:				# 立方部分
	andi	a0,a0,0x00F	# 取SW[3:0]部分
	add	s0,a0,zero	# 乘数
	add	s7,a0,zero	# 另一个乘数备份
	addi	s2,zero,0x004	# 循环次数
	addi	s3,zero,0x001	# 数字1
	addi	s6,zero,0x008	# 数字8
	add	s5,a0,zero	# 保存被乘数
	addi	a0,zero,0x000	# a0是累加寄存器，保存计算结果
p3loop3:
	add	s4,s0,zero	# s4是读取一位
	slli	s0,s0,0x001	# 左移一位
	andi	s4,s4,0x008	# 取出s4第4位
	beq	s4,s6,p3mark1	# 如果为第4位是 1 则跳转
	jal	p3mark2
p3mark1:
	slli	a0,a0,0x001
	add	a0,a0,s5
	jal	p3mark3
p3mark2:
	slli	a0,a0,0x001
p3mark3:
	sub	s2,s2,s3	# 每次减一
	bne	s2,zero,p3loop3
				# 前面是求平方部分，结果中a0是平方结果,接下来是用a0乘以s7
	addi	s2,zero,0x004	# 更新循环次数
	add	s5,a0,zero	# 更新保存被乘数
	addi	a0,zero,0x000	# a0是累加寄存器，保存计算结果
p3loop4:
	add	s4,s7,zero
	slli	s7,s7,0x001
	andi	s4,s4,0x008
	beq	s4,s6,p3mark4
	jal	p3mark5
p3mark4:
	slli	a0,a0,0x001
	add	a0,a0,s5
	jal	p3mark6
p3mark5:
	slli	a0,a0,0x001
p3mark6:
	sub	s2,s2,s3
	bne	s2,zero,p3loop4
	jal	loop1
	
	
pow2:				# 平方部分
	andi	a0,a0,0x00F	# 取SW[3:0]部分
	add	s0,a0,zero	# 乘数
	addi	s2,zero,0x004	# 循环次数
	addi	s3,zero,0x001	# 数字1
	addi	s6,zero,0x008	# 数字8
	add	s5,a0,zero	# 保存被乘数
	addi	a0,zero,0x000	# a0是累加寄存器，保存计算结果
loop3:
	add	s4,s0,zero	# s4是读取一位
	slli	s0,s0,0x001	# 左移一位
	andi	s4,s4,0x008	# 取出s4第4位
	beq	s4,s6,mark1	# 如果为第4位是 1 则跳转
	jal	mark2
mark1:
	slli	a0,a0,0x001
	add	a0,a0,s5
	jal	mark3
mark2:
	slli	a0,a0,0x001
mark3:
	sub	s2,s2,s3	# 每次减一
	bne	s2,zero,loop3
	jal	loop1
	
	
	
	