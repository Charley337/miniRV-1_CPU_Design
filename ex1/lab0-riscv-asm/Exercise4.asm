	# s0 �ǻ�ַ��ַ
	# s1 �ǲ��뿪�ظ� 8 λ		# ��Ӧ��ƫ�Ƶ�ַ 0x072
	# s2 �ǲ��뿪�ص� 16 λ		# ��Ӧ��ƫ�Ƶ�ַ 0x070
	# s3 �ǵƸ� 8 λ		# ��Ӧ��ƫ�Ƶ�ַ 0x062
	# s4 �ǵƵ� 16 λ		# ��Ӧ��ƫ�Ƶ�ַ 0x060
	# s5 �Ǳ��� VAL �Ĵ���
	# s6 �� SW[23:21] ��������̬
	# s7 �� SW[23:21] �������̬
	lui	s0,0xFFFFF	# ��ַ��ַ
	add 	s3,zero,zero
	add 	s4,zero,zero
	# ������
	# t1: 0x001
	# t2: 0x7FFF
	# t3: 0x8000
	addi 	t1,zero,0x001
	addi 	t2,zero,0x07F
	slli 	t2,t2,0x008
	addi 	t2,t2,0x0FF
	add 	t3,zero,t1
	slli 	t3,t3,0x00F
	# ѭ������ t0
	# ��ʱ������
	# a0 ��ʱ����������
	# ��ʼ��
	sw 	s3,0x062(s0)
	sw 	s4,0x060(s0)


switread:
	# ������ SW[23:21] ��Ϊ�����룬����ֵ�� s7 ��̬
	lw 	s1,0x072(s0)
	srai	s7,s1,0x005
	# ���ݲ����� s6 ��̬�� s7 ��̬�Ƚϣ��ж϶�������һ�����Ƿ���Ҫ�ı�
	bne 	s6,s7,change_1
	# no change ����������ʼ��
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
	# ʣ�µľ��� X00 �޶�����ֱ����ˢ�²���
	jal 	refresh_1
change_1:			# Ҫ������ʼ��
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
	# ʣ�µľ��� X00 �޶�����ֱ����ˢ�²���
	jal 	refresh_1
	# ������ʼ��
init_001:
	# ���� 001 û��ʲôҪ��ʼ����
	jal 	movement_001
init_010:
	# ����010 û��ʲôҪ��ʼ����
	jal 	movement_010
init_011:
	# ����Ҳû��ʲôҪ��ʼ����
	jal 	movement_011
init_101:
	# ����û��ʲôҪ��ʼ����
	jal 	movement_101
init_110:
	jal 	movement_110
init_111:
	jal 	movement_111
	# ִ�о��嶯��������
movement_001:
	lw 	s2,0x070(s0)
	lw 	s5,0x070(s0)
	jal 	refresh_1
movement_010:
	add 	s5,s5,t1
	# �ӳ� 1
	addi 	t0,zero,0x01F
delay_1:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_1
	jal 	refresh_1
movement_011:
	sub 	s5,s5,t1
	# �ӳ� 2
	addi 	t0,zero,0x01F
delay_2:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_2
	jal 	refresh_1
movement_101:
	sll	s5,s5,t1
	# �ӳ� 3
	addi 	t0,zero,0x01F
delay_3:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_3
	jal 	refresh_1
movement_110:
	srl 	s5,s5,t1
	# �ӳ� 4
	addi 	t0,zero,0x01F
delay_4:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_4
	jal 	refresh_1
movement_111:
	and 	a1,s5,t3
	bne 	a1,t3,mark_m111_1
	# ����Ǹ���
	andi 	a2,s5,t2	# a2 ����ȡ������ǰ 15 λ
	sra 	s5,a2,t1
	add 	s5,s5,t3
	jal 	mark_m111_2
mark_m111_1:			# ���������
	sra 	s5,s5,t1
mark_m111_2:
	# �ӳ� 5
	addi 	t0,zero,0x01F
delay_5:
	sub 	t0,t0,t1
	bne 	t0,zero,delay_5
	# jal 	refresh_1	# ���Բ���л��ʡһ��ָ��
	# ˢ�� LED ��, s6 ��̬���� s7 ��̬
refresh_1:
	add 	s4,zero,s5
	sw 	s4,0x060(s0)
	add 	s6,zero,s7
loop_sr_1:
	jal 	switread	# ����ѭ��
