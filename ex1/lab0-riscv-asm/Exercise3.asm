	lui	s0,0xFFFFF	# 基地址
	addi	t1,zero,0x001	# t1 常数 1
	addi 	t2,zero,0x400
	slli	t2,t2,0x005	# t2 常数 1000 0000 0000 0000
	addi 	t3,zero,0x0FF
	slli 	t3,t3,0x004
	addi 	t3,t3,0x00F	# t3 常数 0xFFF
	addi 	t4,zero,0x0FF	# t4 常数 0xFFFF
	slli 	t4,t4,0x008
	addi 	t4,t4,0x0FF
	slli 	t5,t1,0x017 	# t5 常数 0x800000

	
switread:
	lw	s1,0x072(s0)	# s1 高8位拨码
	andi	a0,s1,0x0C0	# 模式码
	addi	a1,zero,0x080
	beq	a0,a1,mode2	# 模式二
	addi	a1,zero,0x040
	beq	a0,a1,mode3	# 模式三
	# 其余情况模式一
mode1:
	# 初始化，正在用着的寄存器：s0(基地址), s1(高8位拨码), s2(低16位拨码), t0(延时循环变量), t1(常数 1), s3(高8位灯), s4(低16位灯)
	add	s3,zero,zero
	add 	s4,zero,zero
	sw	zero,0x060(s0)
	sw	zero,0x062(s0)	# 让所有灯全灭
	add 	a2,zero,zero	# a2 为阶段码，共四个阶段
loop_m1_1:
	# 延迟1
	addi	t0,zero,0x00F	# 设置延时时间
loop_dl_1:
	sub	t0,t0,t1	# 自减 1
	bne	t0,zero,loop_dl_1
	# 检查有没有切换模式
	lw	s1,0x072(s0)
	andi	a0,s1,0x0C0	# 当前模式码
	addi	a1,zero,0x080
	beq 	a0,a1,mode2
	addi 	a1,zero,0x040
	beq 	a0,a1,mode3
	# mode1 正常流动，阶段匹配
	beq	a2,zero,loop_m1_000
	addi 	a3,zero,0x001
	beq	a2,a3,loop_m1_001
	addi 	a3,zero,0x002
	beq 	a2,a3,loop_m1_002
	addi 	a3,zero,0x003
	beq 	a2,a3,loop_m1_003
	jal 	loop_m1_1
loop_m1_000:			# 亮灯
	sra	s3,s3,t1	# 先右移，再第8位加1
	addi 	s3,s3,0x080
	sll	s4,s4,t1	# 先左移，再第1位加1
	add 	s4,s4,t1
	sw	s3,0x062(s0)	# 让灯亮起来
	sw	s4,0x060(s0)
	addi 	a3,zero,0x0FF
	bne	s3,a3,loop_m1_1
	addi 	a2,zero,0x001
	jal 	loop_m1_1
loop_m1_001:			# 亮灯2
	addi 	a3,zero,0x0FF
	bne 	s4,a3,loop_m1_2
	add	a4,zero,zero 	# a4 是右移的部分
loop_m1_2:
	sra 	a4,a4,t1
	add 	a4,a4,t2
	sll	s4,s4,t1
	add	s4,s4,t1
	add 	a5,a4,s4
	sw 	a5,0x060(s0)
	bne 	s4,t3,loop_m1_1
	addi 	a2,zero,0x002
	jal 	loop_m1_1
loop_m1_002:			# 灭灯
	sub 	a4,a4,t2
	sll 	a4,a4,t1
	sra 	s4,s4,t1
	add 	a5,s4,a4
	sw 	a5,0x060(s0)
	addi	a3,zero,0x0FF
	bne 	s4,a3,loop_m1_1
	addi 	a2,zero,0x003
	jal 	loop_m1_1
loop_m1_003:			# 灭灯2
	addi	a3,zero,0x080
	sub 	s3,s3,a3
	sll 	s3,s3,t1
	sra 	s4,s4,t1
	sw	s3,0x062(s0)
	sw 	s4,0x060(s0)
	bne 	s3,zero,loop_m1_1
	addi 	a2,zero,0x000
	jal 	loop_m1_1
mode2:
	# 初始化，灯全灭
	add 	s3,zero,zero
	add 	s4,zero,zero
	sw 	zero,0x062(s0)
	sw 	zero,0x060(s0)
	add 	a2,zero,zero	# 阶段码，共四个阶段
loop_m2_1:
	# 延迟2
	addi	t0,zero,0x00F	# 设置延时时间
loop_dl_2:
	sub	t0,t0,t1	# 自减 1
	bne	t0,zero,loop_dl_2
	# 检查是否切换模式
	lw	s1,0x072(s0)
	andi	a0,s1,0x0C0
	addi 	a1,zero,0x040
	beq 	a0,a1,mode3
	addi	a1,zero,0x080
	bne 	a0,a1,mode1
	# 正式开始mode2的流程，首先阶段匹配
	beq 	a2,zero,loop_m2_000
	addi 	a3,zero,0x001
	beq 	a2,a3,loop_m2_001
	addi 	a3,zero,0x002
	beq 	a2,a3,loop_m2_002
	addi 	a3,zero,0x003
	beq 	a2,a3,loop_m2_003
	jal 	loop_m2_1
loop_m2_000:			# 阶段000: 高位灯点亮
	sra 	s3,s3,t1
	addi 	s3,s3,0x080
	sw 	s3,0x062(s0)
	addi	a3,zero,0x0FF
	bne 	s3,a3,loop_m2_1
	addi 	a2,zero,0x001
	jal 	loop_m2_1 
loop_m2_001:			# 阶段001: 低位灯点亮
	sra 	s4,s4,t1
	add 	s4,s4,t2
	sw 	s4,0x060(s0)
	and	a3,s4,t1
	bne 	a3,t1,loop_m2_1
	addi 	a2,zero,0x002
	jal 	loop_m2_1
loop_m2_002:			# 阶段002: 高位点熄灭
	sra 	s3,s3,t1
	sw 	s3,0x062(s0)
	bne 	s3,zero,loop_m2_1
	addi 	a2,zero,0x003
	jal 	loop_m2_1
loop_m2_003:			# 阶段003: 低位灯熄灭
	sra 	s4,s4,t1
	sw 	s4,0x060(s0)
	bne 	s4,zero,loop_m2_1
	addi 	a2,zero,0x000
	jal 	loop_m2_1
mode3:
	# 初始化，灯亮SW[4:0]盏，连续靠左
	add 	s3,zero,zero
	add 	s4,zero,zero
	lw 	s2,0x070(s0)
	andi 	s2,s2,0x01F	# 筛选出SW[4:0]
	add 	s5,zero,s2	# s5 用于保存当前灯数量
	addi 	a1,zero,0x009
	blt 	s2,a1,mark_m3_1	# 跳转，小于等于8
	# 不跳转，大于等于9
	# 重要！防止大于24的情况出现
	addi 	a1,zero,0x019
	blt 	s2,a1,mark_m3_5
	addi 	s2,zero,0x018
mark_m3_5:
	addi 	s3,zero,0x0FF
	addi 	a1,zero,0x008
	sub 	t0,s2,a1
loop_m3_2:
	sra 	s4,s4,t1
	add 	s4,s4,t2
	sub 	t0,t0,t1
	bne 	t0,zero,loop_m3_2
	jal 	mark_m3_2
mark_m3_1: 
	# 重要！判断SW[4:0]是否为0，否则会进入死循环
	bne	s2,zero,mark_m3_4
	sw 	zero,0x062(s0)
	sw 	zero,0x060(s0)
	jal 	switread
mark_m3_4:
	add 	t0,zero,s2
loop_m3_0:
	sra 	s3,s3,t1
	addi 	s3,s3,0x080
	sub 	t0,t0,t1
	bne 	t0,zero,loop_m3_0
mark_m3_2:			# s3,s4设置完成
	sw	s3,0x062(s0)
	sw 	s4,0x060(s0)
	addi 	a2,zero,0x000 	# 阶段码
	addi 	a3,zero,0x018
	bne 	s2,a3,mark_m3_3
	addi 	a2,zero,0x001
mark_m3_3:
	add 	s6,s3,zero	# 设置 s6 来保存24位灯的信息
	slli 	s6,s6,0x010
	add 	s6,s6,s4
	# 初始化完毕（好长 TwT ）
loop_m3_1:
	# 延迟3
	addi	t0,zero,0x00F	# 设置延时时间
loop_dl_3:
	sub	t0,t0,t1	# 自减 1
	bne	t0,zero,loop_dl_3
	# 检查是否切换模式
	lw	s1,0x072(s0)
	andi	a0,s1,0x0C0
	addi	a1,zero,0x080
	beq 	a0,a1,mode2
	addi 	a1,zero,0x040
	bne 	a0,a1,mode1
	# 检查是否更改灯的数量
	lw 	a0,0x070(s0)
	andi 	a0,a0,0x01F
	bne 	s5,a0,mode3	# 重新初始化
	# 开始 mode3 流程，首先阶段匹配
	beq 	a2,zero,loop_m3_000
	addi 	a3,zero,0x001
	beq 	a2,a3,loop_m3_001
loop_m3_000:			# 阶段000
	sra 	s6,s6,t1
	and 	s4,s6,t4
	srai 	s3,s6,0x010
	sw 	s3,0x062(s0)
	sw 	s4,0x060(s0)
	and 	a3,s4,t1
	bne 	a3,t1,loop_m3_1
	addi 	a2,zero,0x001
	jal 	loop_m3_1
loop_m3_001:			# 阶段001
	addi 	a3,zero,0x018
	beq 	s5,a3,loop_m3_1	# 如果24个灯全亮则一直亮着
	sra 	s6,s6,t1
	add 	s6,s6,t5
	and 	s4,s6,t4
	srai 	s3,s6,0x010
	sw 	s3,0x062(s0)
	sw 	s4,0x060(s0)
	and 	a3,s4,t1
	beq 	a3,t1,loop_m3_1
	addi 	a2,zero,0x000
	jal 	loop_m3_1
# loop_sr_1:			# 好像没什么用
# 	jal	switread
	
	


# delay1:
# 	addi	t0,zero,0x7FF	# 设置延时时间
# loop_dl_1:
# 	sub	t0,t0,t1	# 自减 1
# 	bne	t0,zero,loop_dl_1



