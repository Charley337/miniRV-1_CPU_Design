	# s0 是基址地址
	# s1 是拨码开关高 8 位		# 对应的偏移地址 0x072
	# s2 是拨码开关低 16 位		# 对应的偏移地址 0x070
	# s3 是灯高 8 位		# 对应的偏移地址 0x062
	# s4 是灯低 16 位		# 对应的偏移地址 0x060
	# s5 是变量 VAL 寄存器
	# s6 是 SW[23:21] 操作码现态
	# s7 是 SW[23:21] 操作码次态
	lui	s0,0xFFFFF	# 基址地址
	add 	s3,zero,zero
	add 	s4,zero,zero
	# 常数：
	# t1: 0x001
	# t2: 0x7FFF
	# t3: 0x8000
	addi 	t1,zero,0x001
	addi 	t2,zero,0x07F
	slli 	t2,t2,0x008
	addi 	t2,t2,0x0FF
	add 	t3,zero,t1
	slli 	t3,t3,0x00F
	# 循环变量 t0
	# 临时变量：
	# a0 临时生成立即数
	# 初始化
	sw 	s3,0x062(s0)
	sw 	s4,0x060(s0)


switread:
	# 读拨码 SW[23:21] 作为操作码，并赋值给 s7 次态
	lw 	s1,0x072(s0)
	srai	s7,s1,0x005
	# 根据操作码 s6 现态和 s7 次态比较，判断动作是哪一个，是否需要改变
	bne 	s6,s7,change_1
	# no change 不用跳到初始化
	addi 	a0,zero,0x001
	beq 	s7,a0,movement_001
	addi 	a0,zero,0x002
	beq 	s7,a0,movement_010
	addi 	a0,zero,0x003
	beq 	s7,a0,movement_011
	addi 	a0,zero,0x005
	beq 	s7,a0,movement_101
	addi 	a0,zero,0x006
	beq 	s7,a0,movement_110
	addi 	a0,zero,0x007
	beq 	s7,a0,movement_111
	# 剩下的就是 X00 无动作，直接跳刷新部分
	jal 	refresh_1
change_1:			# 要跳到初始化
	addi 	a0,zero,0x001
	beq 	s7,a0,init_001
	addi 	a0,zero,0x002
	beq 	s7,a0,init_010
	addi 	a0,zero,0x003
	beq 	s7,a0,init_011
	addi 	a0,zero,0x005
	beq 	s7,a0,init_101
	addi 	a0,zero,0x006
	beq 	s7,a0,init_110
	addi 	a0,zero,0x007
	beq 	s7,a0,init_111
	# 剩下的就是 X00 无动作，直接跳刷新部分
	jal 	refresh_1
	# 动作初始化
init_001:
	# 操作 001 没有什么要初始化的
	jal 	movement_001
init_010:
	# 操作010 没有什么要初始化的
	jal 	movement_010
init_011:
	# 好像也没有什么要初始化的
	jal 	movement_011
init_101:
	# 好像都没有什么要初始化的
	jal 	movement_101
init_110:
	jal 	movement_110
init_111:
	jal 	movement_111
	# 执行具体动作的流程
movement_001:
	lw 	s2,0x070(s0)
	lw 	s5,0x070(s0)
	jal 	refresh_1
movement_010:
	add 	s5,s5,t1
	# 延迟 1
	addi 	t0,zero,0x01F
delay_1:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_1
	jal 	refresh_1
movement_011:
	sub 	s5,s5,t1
	# 延迟 2
	addi 	t0,zero,0x01F
delay_2:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_2
	jal 	refresh_1
movement_101:
	sll	s5,s5,t1
	# 延迟 3
	addi 	t0,zero,0x01F
delay_3:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_3
	jal 	refresh_1
movement_110:
	srl 	s5,s5,t1
	# 延迟 4
	addi 	t0,zero,0x01F
delay_4:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_4
	jal 	refresh_1
movement_111:
	and 	a1,s5,t3
	bne 	a1,t3,mark_m111_1
	# 如果是负数
	andi 	a2,s5,t2	# a2 是提取出来的前 15 位
	sra 	s5,a2,t1
	add 	s5,s5,t3
	jal 	mark_m111_2
mark_m111_1:			# 如果是正数
	sra 	s5,s5,t1
mark_m111_2:
	# 延迟 5
	addi 	t0,zero,0x01F
delay_5:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_5
	# jal 	refresh_1	# 可以不用谢，省一条指令
	# 刷新 LED 灯, s6 现态等于 s7 次态
refresh_1:
	add 	s4,zero,s5
	sw 	s4,0x060(s0)
	add 	s6,zero,s7
loop_sr_1:
	jal 	switread	# 无限循环
