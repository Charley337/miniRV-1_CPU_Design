	lui	s1,0xFFFFF	# ����ַ
	
	
switread:
	lw	a0,0x70(s1)	# ��16λ����
	lw	a1,0x72(s1)	# ��8λ���룬��ȡSW22��SW23��ֵ���жϼ�������
	# �жϸ�λ SW[21] �Ƿ���Ч����Ч��һֱ��ʾ��
	andi 	t5,a1,0x020
	addi 	t6,zero,0x020
	bne 	t5,t6,mark_sw21
	sw 	zero,0x060(s1)	# ��λ��ȫϨ��
	jal 	switread
mark_sw21:
	addi	a2,zero,0x080	# ���������Ƚϵ���ֵ
	addi	a3,zero,0x040
	addi	a4,zero,0x0C0
	andi	a1,a1,0x0C0	# 0000 1100 0000
	beq	a1,a2,pow3	# ������� 1000 0000 ������
	beq	a1,a3,pow2	# ������� 0100 0000 ��ƽ��
	beq	a1,a4,pow3
	jal	loop2
loop1:
	sw	a0,0x60(s1)	# ��16λ
	lw	a1,0x72(s1)	# ��8λ���ж�SW21�����Ƿ���Ч����Ч��һֱ����ѭ��
	andi	a1,a1,0x020	# 0010 0000
	beq	a1,zero,loop1
loop2:
	jal	switread	# ����ѭ��
	
	
pow3:				# ��������
	andi	a0,a0,0x00F	# ȡSW[3:0]����
	add	s0,a0,zero	# ����
	add	s7,a0,zero	# ��һ����������
	addi	s2,zero,0x004	# ѭ������
	addi	s3,zero,0x001	# ����1
	addi	s6,zero,0x008	# ����8
	add	s5,a0,zero	# ���汻����
	addi	a0,zero,0x000	# a0���ۼӼĴ��������������
p3loop3:
	add	s4,s0,zero	# s4�Ƕ�ȡһλ
	slli	s0,s0,0x001	# ����һλ
	andi	s4,s4,0x008	# ȡ��s4��4λ
	beq	s4,s6,p3mark1	# ���Ϊ��4λ�� 1 ����ת
	jal	p3mark2
p3mark1:
	slli	a0,a0,0x001
	add	a0,a0,s5
	jal	p3mark3
p3mark2:
	slli	a0,a0,0x001
p3mark3:
	sub	s2,s2,s3	# ÿ�μ�һ
	bne	s2,zero,p3loop3
				# ǰ������ƽ�����֣������a0��ƽ�����,����������a0����s7
	addi	s2,zero,0x004	# ����ѭ������
	add	s5,a0,zero	# ���±��汻����
	addi	a0,zero,0x000	# a0���ۼӼĴ��������������
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
	
	
pow2:				# ƽ������
	andi	a0,a0,0x00F	# ȡSW[3:0]����
	add	s0,a0,zero	# ����
	addi	s2,zero,0x004	# ѭ������
	addi	s3,zero,0x001	# ����1
	addi	s6,zero,0x008	# ����8
	add	s5,a0,zero	# ���汻����
	addi	a0,zero,0x000	# a0���ۼӼĴ��������������
loop3:
	add	s4,s0,zero	# s4�Ƕ�ȡһλ
	slli	s0,s0,0x001	# ����һλ
	andi	s4,s4,0x008	# ȡ��s4��4λ
	beq	s4,s6,mark1	# ���Ϊ��4λ�� 1 ����ת
	jal	mark2
mark1:
	slli	a0,a0,0x001
	add	a0,a0,s5
	jal	mark3
mark2:
	slli	a0,a0,0x001
mark3:
	sub	s2,s2,s3	# ÿ�μ�һ
	bne	s2,zero,loop3
	jal	loop1
	
	
	
	