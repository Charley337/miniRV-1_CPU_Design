	lui	s0,0xFFFFF	# ����ַ
	addi	t1,zero,0x001	# t1 ���� 1
	addi 	t2,zero,0x400
	slli	t2,t2,0x005	# t2 ���� 1000 0000 0000 0000
	addi 	t3,zero,0x0FF
	slli 	t3,t3,0x004
	addi 	t3,t3,0x00F	# t3 ���� 0xFFF
	addi 	t4,zero,0x0FF	# t4 ���� 0xFFFF
	slli 	t4,t4,0x008
	addi 	t4,t4,0x0FF
	slli 	t5,t1,0x017 	# t5 ���� 0x800000

	
switread:
	lw	s1,0x072(s0)	# s1 ��8λ����
	andi	a0,s1,0x0C0	# ģʽ��
	addi	a1,zero,0x080
	beq	a0,a1,mode2	# ģʽ��
	addi	a1,zero,0x040
	beq	a0,a1,mode3	# ģʽ��
	# �������ģʽһ
mode1:
	# ��ʼ�����������ŵļĴ�����s0(����ַ), s1(��8λ����), s2(��16λ����), t0(��ʱѭ������), t1(���� 1), s3(��8λ��), s4(��16λ��)
	add	s3,zero,zero
	add 	s4,zero,zero
	sw	zero,0x060(s0)
	sw	zero,0x062(s0)	# �����е�ȫ��
	add 	a2,zero,zero	# a2 Ϊ�׶��룬���ĸ��׶�
loop_m1_1:
	# �ӳ�1
	addi	t0,zero,0x00F	# ������ʱʱ��
loop_dl_1:
	sub	t0,t0,t1	# �Լ� 1
	bne	t0,zero,loop_dl_1
	# �����û���л�ģʽ
	lw	s1,0x072(s0)
	andi	a0,s1,0x0C0	# ��ǰģʽ��
	addi	a1,zero,0x080
	beq 	a0,a1,mode2
	addi 	a1,zero,0x040
	beq 	a0,a1,mode3
	# mode1 �����������׶�ƥ��
	beq	a2,zero,loop_m1_000
	addi 	a3,zero,0x001
	beq	a2,a3,loop_m1_001
	addi 	a3,zero,0x002
	beq 	a2,a3,loop_m1_002
	addi 	a3,zero,0x003
	beq 	a2,a3,loop_m1_003
	jal 	loop_m1_1
loop_m1_000:			# ����
	sra	s3,s3,t1	# �����ƣ��ٵ�8λ��1
	addi 	s3,s3,0x080
	sll	s4,s4,t1	# �����ƣ��ٵ�1λ��1
	add 	s4,s4,t1
	sw	s3,0x062(s0)	# �õ�������
	sw	s4,0x060(s0)
	addi 	a3,zero,0x0FF
	bne	s3,a3,loop_m1_1
	addi 	a2,zero,0x001
	jal 	loop_m1_1
loop_m1_001:			# ����2
	addi 	a3,zero,0x0FF
	bne 	s4,a3,loop_m1_2
	add	a4,zero,zero 	# a4 �����ƵĲ���
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
loop_m1_002:			# ���
	sub 	a4,a4,t2
	sll 	a4,a4,t1
	sra 	s4,s4,t1
	add 	a5,s4,a4
	sw 	a5,0x060(s0)
	addi	a3,zero,0x0FF
	bne 	s4,a3,loop_m1_1
	addi 	a2,zero,0x003
	jal 	loop_m1_1
loop_m1_003:			# ���2
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
	# ��ʼ������ȫ��
	add 	s3,zero,zero
	add 	s4,zero,zero
	sw 	zero,0x062(s0)
	sw 	zero,0x060(s0)
	add 	a2,zero,zero	# �׶��룬���ĸ��׶�
loop_m2_1:
	# �ӳ�2
	addi	t0,zero,0x00F	# ������ʱʱ��
loop_dl_2:
	sub	t0,t0,t1	# �Լ� 1
	bne	t0,zero,loop_dl_2
	# ����Ƿ��л�ģʽ
	lw	s1,0x072(s0)
	andi	a0,s1,0x0C0
	addi 	a1,zero,0x040
	beq 	a0,a1,mode3
	addi	a1,zero,0x080
	bne 	a0,a1,mode1
	# ��ʽ��ʼmode2�����̣����Ƚ׶�ƥ��
	beq 	a2,zero,loop_m2_000
	addi 	a3,zero,0x001
	beq 	a2,a3,loop_m2_001
	addi 	a3,zero,0x002
	beq 	a2,a3,loop_m2_002
	addi 	a3,zero,0x003
	beq 	a2,a3,loop_m2_003
	jal 	loop_m2_1
loop_m2_000:			# �׶�000: ��λ�Ƶ���
	sra 	s3,s3,t1
	addi 	s3,s3,0x080
	sw 	s3,0x062(s0)
	addi	a3,zero,0x0FF
	bne 	s3,a3,loop_m2_1
	addi 	a2,zero,0x001
	jal 	loop_m2_1 
loop_m2_001:			# �׶�001: ��λ�Ƶ���
	sra 	s4,s4,t1
	add 	s4,s4,t2
	sw 	s4,0x060(s0)
	and	a3,s4,t1
	bne 	a3,t1,loop_m2_1
	addi 	a2,zero,0x002
	jal 	loop_m2_1
loop_m2_002:			# �׶�002: ��λ��Ϩ��
	sra 	s3,s3,t1
	sw 	s3,0x062(s0)
	bne 	s3,zero,loop_m2_1
	addi 	a2,zero,0x003
	jal 	loop_m2_1
loop_m2_003:			# �׶�003: ��λ��Ϩ��
	sra 	s4,s4,t1
	sw 	s4,0x060(s0)
	bne 	s4,zero,loop_m2_1
	addi 	a2,zero,0x000
	jal 	loop_m2_1
mode3:
	# ��ʼ��������SW[4:0]յ����������
	add 	s3,zero,zero
	add 	s4,zero,zero
	lw 	s2,0x070(s0)
	andi 	s2,s2,0x01F	# ɸѡ��SW[4:0]
	add 	s5,zero,s2	# s5 ���ڱ��浱ǰ������
	addi 	a1,zero,0x009
	blt 	s2,a1,mark_m3_1	# ��ת��С�ڵ���8
	# ����ת�����ڵ���9
	# ��Ҫ����ֹ����24���������
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
	# ��Ҫ���ж�SW[4:0]�Ƿ�Ϊ0������������ѭ��
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
mark_m3_2:			# s3,s4�������
	sw	s3,0x062(s0)
	sw 	s4,0x060(s0)
	addi 	a2,zero,0x000 	# �׶���
	addi 	a3,zero,0x018
	bne 	s2,a3,mark_m3_3
	addi 	a2,zero,0x001
mark_m3_3:
	add 	s6,s3,zero	# ���� s6 ������24λ�Ƶ���Ϣ
	slli 	s6,s6,0x010
	add 	s6,s6,s4
	# ��ʼ����ϣ��ó� TwT ��
loop_m3_1:
	# �ӳ�3
	addi	t0,zero,0x00F	# ������ʱʱ��
loop_dl_3:
	sub	t0,t0,t1	# �Լ� 1
	bne	t0,zero,loop_dl_3
	# ����Ƿ��л�ģʽ
	lw	s1,0x072(s0)
	andi	a0,s1,0x0C0
	addi	a1,zero,0x080
	beq 	a0,a1,mode2
	addi 	a1,zero,0x040
	bne 	a0,a1,mode1
	# ����Ƿ���ĵƵ�����
	lw 	a0,0x070(s0)
	andi 	a0,a0,0x01F
	bne 	s5,a0,mode3	# ���³�ʼ��
	# ��ʼ mode3 ���̣����Ƚ׶�ƥ��
	beq 	a2,zero,loop_m3_000
	addi 	a3,zero,0x001
	beq 	a2,a3,loop_m3_001
loop_m3_000:			# �׶�000
	sra 	s6,s6,t1
	and 	s4,s6,t4
	srai 	s3,s6,0x010
	sw 	s3,0x062(s0)
	sw 	s4,0x060(s0)
	and 	a3,s4,t1
	bne 	a3,t1,loop_m3_1
	addi 	a2,zero,0x001
	jal 	loop_m3_1
loop_m3_001:			# �׶�001
	addi 	a3,zero,0x018
	beq 	s5,a3,loop_m3_1	# ���24����ȫ����һֱ����
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
# loop_sr_1:			# ����ûʲô��
# 	jal	switread
	
	


# delay1:
# 	addi	t0,zero,0x7FF	# ������ʱʱ��
# loop_dl_1:
# 	sub	t0,t0,t1	# �Լ� 1
# 	bne	t0,zero,loop_dl_1



