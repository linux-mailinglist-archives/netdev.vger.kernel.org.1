Return-Path: <netdev+bounces-62216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E948263DB
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 12:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C7D1C20B4D
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5094412B8A;
	Sun,  7 Jan 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2FfSGlr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819612E40
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e67e37661so1123425e87.0
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 03:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704625420; x=1705230220; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhpIoPfcltdksIbdLXaQuqx8cV/sX4/Brd7fg6fTS7c=;
        b=c2FfSGlrDJKDyEeHct38b1ccBDW3d5gQECnQbQ/LjwsmGzgGwJLSz/EzUERZJDiUS1
         GsPmbvC+ipEplpXWolfxir0US30WcAnXLzx9UPqRgB9iPf8Zw3P6n1aezej3yw7ewaAr
         YHfJMNtw2ui1H+2Tb3W/pavkqV9z+GWc+3S884Lcb2Mfs9uOZh9ghnJ5KfafVpf6VeFb
         oj+N9lqzocX9SuMdYK+hQaIQ+yGFZLWvrIi2D73nioJGNKiWMa0iu9sCDFfnOcYMwfp+
         js9DVli3gfXe+E9xvBva2h4YznA60BpMMQmkUWEpv37EXzKPss/NUOoYbhRSDwBineBi
         5fEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704625420; x=1705230220;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhpIoPfcltdksIbdLXaQuqx8cV/sX4/Brd7fg6fTS7c=;
        b=WnMC96YeztnJJFEK2FeTD0QdTo8+08s3WJui+O38756JRmOUaO4QiEGPe9z3pRckn5
         8VHQyhEuh7fdCgtvH7I+8Yi2RxQ2USbuijw0ZpYL9/pEE6wTI0PA7oFHr6RuSCXttV0r
         PuKLZ11BV8ssS4OmuG+MRhJk4mvwi8m4hNG7RINXg8pcX+C0fAOjWVtfw8I2+dFRFq1U
         b5WDxIzhCn6sBy/AxAgbpvyHcTN02/LNpVLXpN/qUgwmVHnWdpavNP2Yvw+odwRnO6w8
         xKrlpuuqoArhBymZahpT3xoii2fyxlAww+VtoeoVA9GkNsPn+1bTh99U494WPkNQpYvz
         3W0g==
X-Gm-Message-State: AOJu0YyN7g312LTP36nZFQN0P6LPBt5A9l2O6hwkIMHN7NC+Tl4SPEff
	BypuIdWyrzlSHyHJMnB/NX0=
X-Google-Smtp-Source: AGHT+IEAebcXio2m4DRdr8xHmxE7NN1B2wLXycs55xv5oCEuwHDEbxbb4k+RCOYSqf9njINnwfP4bw==
X-Received: by 2002:a19:ca04:0:b0:50e:3e3a:3d6e with SMTP id a4-20020a19ca04000000b0050e3e3a3d6emr750816lfg.110.1704625419618;
        Sun, 07 Jan 2024 03:03:39 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id b1-20020a170906490100b00a26b36311ecsm2966535ejq.146.2024.01.07.03.03.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jan 2024 03:03:38 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <E6A168E5-5BB6-47AD-B8D6-D6BE2F2C528F@gmail.com>
Date: Sun, 7 Jan 2024 13:03:27 +0200
Cc: peterz@infradead.org,
 netdev <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org,
 dsahern@gmail.com,
 Eric Dumazet <edumazet@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CD1762C-C6C0-4840-A4BD-3A77F40CA02A@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
 <D773F198-BCE3-4D43-9C27-2C2CA34062AC@gmail.com>
 <8E92BAA8-0FC6-4D29-BB4D-B6B60047A1D2@gmail.com>
 <5E63894D-913B-416C-B901-F628BB6C00E0@gmail.com> <87lea4qqun.ffs@tglx>
 <2B5C19AE-C125-45A3-8C6F-CA6BBC01A6D9@gmail.com> <87r0jrp9qi.ffs@tglx>
 <6D816814-1334-4F22-AFF8-B5E42254038E@gmail.com> <87v88ul14z.ffs@tglx>
 <FBF0EB18-E2B6-4076-968A-5F2ABE0F27E4@gmail.com>
 <7D08EC48-F22C-4CC8-839F-2A9677E93DF0@gmail.com>
 <E6A168E5-5BB6-47AD-B8D6-D6BE2F2C528F@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Thomas=20

this is one more report from one machine=20

Here you will see have to bug report in same day:


[Sat Jan  6 07:37:23 2024] ------------[ cut here ]------------
[Sat Jan 6 07:37:23 2024] WARNING: CPU: 12 PID: 0 at lib/rcuref.c:294 =
rcuref_put_slowpath (lib/rcuref.c:294 (discriminator 1))
[Sat Jan  6 07:37:23 2024] Modules linked in:  pppoe pppox ppp_generic =
slhc nft_limit nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding mlx5_core mlxfw mlx4_en mlx4_core i40e ixgbe mdio =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghandler =
rtc_cmos megaraid_sas
[Sat Jan  6 07:37:23 2024] CPU: 12 PID: 0 Comm: swapper/12 Tainted: G    =
       O       6.6.10 #1
[Sat Jan  6 07:37:23 2024] Hardware name: Huawei 2288H V5/BC11SPSCB0, =
BIOS 7.80 10/28/2020
[Sat Jan 6 07:37:23 2024] RIP: 0010:rcuref_put_slowpath =
(lib/rcuref.c:294 (discriminator 1))
[Sat Jan 6 07:37:23 2024] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f =
b1 17 83 f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 =
14 85 c0 78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d =
b2 4a e3 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	07                   	(bad)
   1:	83 f8 ff             	cmp    $0xffffffff,%eax
   4:	75 19                	jne    0x1f
   6:	ba 00 00 00 e0       	mov    $0xe0000000,%edx
   b:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
   f:	83 f8 ff             	cmp    $0xffffffff,%eax
  12:	74 04                	je     0x18
  14:	31 c0                	xor    %eax,%eax
  16:	5b                   	pop    %rbx
  17:	c3                   	ret
  18:	b8 01 00 00 00       	mov    $0x1,%eax
  1d:	5b                   	pop    %rbx
  1e:	c3                   	ret
  1f:	3d ff ff ff bf       	cmp    $0xbfffffff,%eax
  24:	77 14                	ja     0x3a
  26:	85 c0                	test   %eax,%eax
  28:	78 06                	js     0x30
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	31 c0                	xor    %eax,%eax
  2e:	eb e6                	jmp    0x16
  30:	c7 07 00 00 00 a0    	movl   $0xa0000000,(%rdi)
  36:	31 c0                	xor    %eax,%eax
  38:	eb dc                	jmp    0x16
  3a:	80                   	.byte 0x80
  3b:	3d b2 4a e3 00       	cmp    $0xe34ab2,%eax

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	31 c0                	xor    %eax,%eax
   4:	eb e6                	jmp    0xffffffffffffffec
   6:	c7 07 00 00 00 a0    	movl   $0xa0000000,(%rdi)
   c:	31 c0                	xor    %eax,%eax
   e:	eb dc                	jmp    0xffffffffffffffec
  10:	80                   	.byte 0x80
  11:	3d b2 4a e3 00       	cmp    $0xe34ab2,%eax
[Sat Jan  6 07:37:23 2024] RSP: 0018:ffffa773091ccdd8 EFLAGS: 00010246
[Sat Jan  6 07:37:23 2024] RAX: 0000000000000000 RBX: ffff8f458c192d00 =
RCX: 0000000000000042
[Sat Jan  6 07:37:23 2024] RDX: ffff8f455ad71800 RSI: 0000000000000000 =
RDI: ffff8f458c192d00
[Sat Jan  6 07:37:23 2024] RBP: ffff8f455ad71ec0 R08: 0000000000000000 =
R09: 0000000000000000
[Sat Jan  6 07:37:23 2024] R10: 0000000000000002 R11: ffffa773091ccd90 =
R12: ffff8f25c68df800
[Sat Jan  6 07:37:23 2024] R13: 000000000000000e R14: 0000000000000010 =
R15: ffff8f64bf8a4d10
[Sat Jan  6 07:37:23 2024] FS:  0000000000000000(0000) =
GS:ffff8f64bf880000(0000) knlGS:0000000000000000
[Sat Jan  6 07:37:23 2024] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
[Sat Jan  6 07:37:23 2024] CR2: 00007fbd91318650 CR3: 000000177e014005 =
CR4: 00000000003706e0
[Sat Jan  6 07:37:23 2024] DR0: 0000000000000000 DR1: 0000000000000000 =
DR2: 0000000000000000
[Sat Jan  6 07:37:23 2024] DR3: 0000000000000000 DR6: 00000000fffe0ff0 =
DR7: 0000000000000400
[Sat Jan  6 07:37:23 2024] Call Trace:
[Sat Jan  6 07:37:23 2024]  <IRQ>
[Sat Jan 6 07:37:23 2024] ? __warn (kernel/panic.c:235 =
kernel/panic.c:673)
[Sat Jan 6 07:37:23 2024] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[Sat Jan 6 07:37:23 2024] ? handle_bug (arch/x86/kernel/traps.c:237)
[Sat Jan 6 07:37:23 2024] ? exc_invalid_op (arch/x86/kernel/traps.c:258 =
(discriminator 1))
[Sat Jan 6 07:37:23 2024] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
[Sat Jan 6 07:37:23 2024] ? rcuref_put_slowpath (lib/rcuref.c:294 =
(discriminator 1))
[Sat Jan 6 07:37:23 2024] dst_release (net/core/dst.c:166 (discriminator =
1))
[Sat Jan 6 07:37:23 2024] __dev_queue_xmit (./include/net/dst.h:283 =
net/core/dev.c:4327)
[Sat Jan 6 07:37:23 2024] ? nf_hook_slow =
(./include/linux/netfilter.h:144 net/netfilter/core.c:626)
[Sat Jan 6 07:37:23 2024] ip_finish_output2 =
(./include/net/neighbour.h:526 ./include/net/neighbour.h:540 =
net/ipv4/ip_output.c:233)
[Sat Jan 6 07:37:23 2024] process_backlog (net/core/dev.c:6000)
[Sat Jan 6 07:37:23 2024] __napi_poll (net/core/dev.c:6559)
[Sat Jan 6 07:37:23 2024] net_rx_action (net/core/dev.c:6628 =
net/core/dev.c:6759)
[Sat Jan 6 07:37:23 2024] __do_softirq =
(./arch/x86/include/asm/preempt.h:27 kernel/softirq.c:564)
[Sat Jan 6 07:37:23 2024] irq_exit_rcu (kernel/softirq.c:436 =
kernel/softirq.c:641 kernel/softirq.c:653)
[Sat Jan 6 07:37:23 2024] sysvec_call_function_single =
(arch/x86/kernel/smp.c:262 (discriminator 47))
[Sat Jan  6 07:37:23 2024]  </IRQ>
[Sat Jan  6 07:37:23 2024]  <TASK>
[Sat Jan 6 07:37:23 2024] asm_sysvec_call_function_single =
(./arch/x86/include/asm/idtentry.h:656)
[Sat Jan 6 07:37:23 2024] RIP: 0010:acpi_safe_halt =
(./arch/x86/include/asm/irqflags.h:37 =
./arch/x86/include/asm/irqflags.h:72 drivers/acpi/processor_idle.c:113)
[Sat Jan 6 07:37:23 2024] Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 =
66 90 65 48 8b 04 25 40 32 02 00 48 8b 00 a8 08 75 0c eb 07 0f 00 2d c7 =
0c 2c 00 fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b =
7f 04 eb 9f
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	ed                   	in     (%dx),%eax
   1:	c3                   	ret
   2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 00
   d:	66 90                	xchg   %ax,%ax
   f:	65 48 8b 04 25 40 32 	mov    %gs:0x23240,%rax
  16:	02 00
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	eb 07                	jmp    0x28
  21:	0f 00 2d c7 0c 2c 00 	verw   0x2c0cc7(%rip)        # 0x2c0cef
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	fa                   	cli    		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 00             	nopl   (%rax)
  2f:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
  33:	3c 01                	cmp    $0x1,%al
  35:	74 0b                	je     0x42
  37:	3c 02                	cmp    $0x2,%al
  39:	74 05                	je     0x40
  3b:	8b 7f 04             	mov    0x4(%rdi),%edi
  3e:	eb 9f                	jmp    0xffffffffffffffdf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	fa                   	cli
   1:	c3                   	ret
   2:	0f 1f 00             	nopl   (%rax)
   5:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
   9:	3c 01                	cmp    $0x1,%al
   b:	74 0b                	je     0x18
   d:	3c 02                	cmp    $0x2,%al
   f:	74 05                	je     0x16
  11:	8b 7f 04             	mov    0x4(%rdi),%edi
  14:	eb 9f                	jmp    0xffffffffffffffb5
[Sat Jan  6 07:37:23 2024] RSP: 0018:ffffa773007fbe80 EFLAGS: 00000246
[Sat Jan  6 07:37:23 2024] RAX: 0000000000004000 RBX: 0000000000000001 =
RCX: 000000000000001f
[Sat Jan  6 07:37:23 2024] RDX: ffff8f64bf880000 RSI: ffff8f454c6f6800 =
RDI: ffff8f454c6f6864
[Sat Jan  6 07:37:23 2024] RBP: ffffffffaa216ea0 R08: ffffffffaa216ea0 =
R09: 0000000000000003
[Sat Jan  6 07:37:23 2024] R10: 0000000000000002 R11: 0000000000000007 =
R12: 0000000000000001
[Sat Jan  6 07:37:23 2024] R13: ffffffffaa216f08 R14: ffffffffaa216f20 =
R15: 0000000000000000
[Sat Jan 6 07:37:23 2024] acpi_idle_enter =
(drivers/acpi/processor_idle.c:709)
[Sat Jan 6 07:37:23 2024] cpuidle_enter_state =
(drivers/cpuidle/cpuidle.c:267)
[Sat Jan 6 07:37:23 2024] cpuidle_enter (drivers/cpuidle/cpuidle.c:390 =
(discriminator 2))
[Sat Jan 6 07:37:23 2024] do_idle (kernel/sched/idle.c:134 =
kernel/sched/idle.c:215 kernel/sched/idle.c:282)
[Sat Jan 6 07:37:23 2024] cpu_startup_entry (kernel/sched/idle.c:379)
[Sat Jan 6 07:37:23 2024] start_secondary =
(arch/x86/kernel/smpboot.c:326)
[Sat Jan 6 07:37:23 2024] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:449)
[Sat Jan  6 07:37:23 2024]  </TASK>
[Sat Jan  6 07:37:23 2024] ---[ end trace 0000000000000000 ]---
[Sat Jan  6 21:33:28 2024] ------------[ cut here ]------------
[Sat Jan  6 21:33:28 2024] rcuref - imbalanced put()
[Sat Jan 6 21:33:28 2024] WARNING: CPU: 26 PID: 0 at lib/rcuref.c:279 =
rcuref_put_slowpath (lib/rcuref.c:279 (discriminator 1))
[Sat Jan  6 21:33:28 2024] Modules linked in: pppoe pppox ppp_generic =
slhc nft_limit nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding mlx5_core mlxfw mlx4_en mlx4_core i40e ixgbe mdio =
nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ipmi_si ipmi_devintf ipmi_msghandler =
rtc_cmos megaraid_sas
[Sat Jan  6 21:33:28 2024] CPU: 26 PID: 0 Comm: swapper/26 Tainted: G    =
    W  O       6.6.10 #1
[Sat Jan  6 21:33:28 2024] Hardware name: Huawei 2288H V5/BC11SPSCB0, =
BIOS 7.80 10/28/2020
[Sat Jan 6 21:33:28 2024] RIP: 0010:rcuref_put_slowpath =
(lib/rcuref.c:279 (discriminator 1))
[Sat Jan 6 21:33:28 2024] Code: 31 c0 eb dc 80 3d b2 4a e3 00 00 74 0a =
c7 03 00 00 00 e0 31 c0 eb c9 48 c7 c7 54 29 e4 a9 c6 05 98 4a e3 00 01 =
e8 db 7c c3 ff <0f> 0b eb df cc cc cc cc cc cc cc 48 89 fa 83 e2 07 48 =
85 f6 74 7f
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	31 c0                	xor    %eax,%eax
   2:	eb dc                	jmp    0xffffffffffffffe0
   4:	80 3d b2 4a e3 00 00 	cmpb   $0x0,0xe34ab2(%rip)        # =
0xe34abd
   b:	74 0a                	je     0x17
   d:	c7 03 00 00 00 e0    	movl   $0xe0000000,(%rbx)
  13:	31 c0                	xor    %eax,%eax
  15:	eb c9                	jmp    0xffffffffffffffe0
  17:	48 c7 c7 54 29 e4 a9 	mov    $0xffffffffa9e42954,%rdi
  1e:	c6 05 98 4a e3 00 01 	movb   $0x1,0xe34a98(%rip)        # =
0xe34abd
  25:	e8 db 7c c3 ff       	call   0xffffffffffc37d05
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb df                	jmp    0xd
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	48 89 fa             	mov    %rdi,%rdx
  38:	83 e2 07             	and    $0x7,%edx
  3b:	48 85 f6             	test   %rsi,%rsi
  3e:	74 7f                	je     0xbf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2
   2:	eb df                	jmp    0xffffffffffffffe3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	48 89 fa             	mov    %rdi,%rdx
   e:	83 e2 07             	and    $0x7,%edx
  11:	48 85 f6             	test   %rsi,%rsi
  14:	74 7f                	je     0x95
[Sat Jan  6 21:33:28 2024] RSP: 0018:ffffa7730d528dd8 EFLAGS: 00010292
[Sat Jan  6 21:33:28 2024] RAX: 0000000000000019 RBX: ffff8f4573f7d000 =
RCX: 00000000ffefffff
[Sat Jan  6 21:33:28 2024] RDX: 00000000ffefffff RSI: 0000000000000001 =
RDI: 00000000ffffffea
[Sat Jan  6 21:33:28 2024] RBP: ffff8f265f02d6c0 R08: 0000000000000000 =
R09: 00000000ffefffff
[Sat Jan  6 21:33:28 2024] R10: ffff8f64b6800000 R11: 0000000000000003 =
R12: ffff8f25c68df800
[Sat Jan  6 21:33:28 2024] R13: 000000000000000e R14: 0000000000000010 =
R15: ffff8f44c0024d10
[Sat Jan  6 21:33:28 2024] FS:  0000000000000000(0000) =
GS:ffff8f44c0000000(0000) knlGS:0000000000000000
[Sat Jan  6 21:33:28 2024] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
[Sat Jan  6 21:33:28 2024] CR2: 00007fd79aca5000 CR3: 000000015d226005 =
CR4: 00000000003706e0
[Sat Jan  6 21:33:28 2024] DR0: 0000000000000000 DR1: 0000000000000000 =
DR2: 0000000000000000
[Sat Jan  6 21:33:28 2024] DR3: 0000000000000000 DR6: 00000000fffe0ff0 =
DR7: 0000000000000400
[Sat Jan  6 21:33:28 2024] Call Trace:
[Sat Jan  6 21:33:28 2024]  <IRQ>
[Sat Jan 6 21:33:28 2024] ? __warn (kernel/panic.c:235 =
kernel/panic.c:673)
[Sat Jan 6 21:33:28 2024] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[Sat Jan 6 21:33:28 2024] ? handle_bug (arch/x86/kernel/traps.c:237)
[Sat Jan 6 21:33:28 2024] ? exc_invalid_op (arch/x86/kernel/traps.c:258 =
(discriminator 1))
[Sat Jan 6 21:33:28 2024] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
[Sat Jan 6 21:33:28 2024] ? rcuref_put_slowpath (lib/rcuref.c:279 =
(discriminator 1))
[Sat Jan 6 21:33:28 2024] ? rcuref_put_slowpath (lib/rcuref.c:279 =
(discriminator 1))
[Sat Jan 6 21:33:28 2024] dst_release (net/core/dst.c:166 (discriminator =
1))
[Sat Jan 6 21:33:28 2024] __dev_queue_xmit (./include/net/dst.h:283 =
net/core/dev.c:4327)
[Sat Jan 6 21:33:28 2024] ? nf_hook_slow =
(./include/linux/netfilter.h:144 net/netfilter/core.c:626)
[Sat Jan 6 21:33:28 2024] ip_finish_output2 =
(./include/net/neighbour.h:526 ./include/net/neighbour.h:540 =
net/ipv4/ip_output.c:233)
[Sat Jan 6 21:33:28 2024] process_backlog (net/core/dev.c:6000)
[Sat Jan 6 21:33:28 2024] __napi_poll (net/core/dev.c:6559)
[Sat Jan 6 21:33:28 2024] net_rx_action (net/core/dev.c:6628 =
net/core/dev.c:6759)
[Sat Jan 6 21:33:28 2024] __do_softirq =
(./arch/x86/include/asm/preempt.h:27 kernel/softirq.c:564)
[Sat Jan 6 21:33:28 2024] irq_exit_rcu (kernel/softirq.c:436 =
kernel/softirq.c:641 kernel/softirq.c:653)
[Sat Jan 6 21:33:28 2024] sysvec_call_function_single =
(arch/x86/kernel/smp.c:262 (discriminator 47))
[Sat Jan  6 21:33:28 2024]  </IRQ>
[Sat Jan  6 21:33:28 2024]  <TASK>
[Sat Jan 6 21:33:28 2024] asm_sysvec_call_function_single =
(./arch/x86/include/asm/idtentry.h:656)
[Sat Jan 6 21:33:28 2024] RIP: 0010:acpi_safe_halt =
(./arch/x86/include/asm/irqflags.h:37 =
./arch/x86/include/asm/irqflags.h:72 drivers/acpi/processor_idle.c:113)
[Sat Jan 6 21:33:28 2024] Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 =
66 90 65 48 8b 04 25 40 32 02 00 48 8b 00 a8 08 75 0c eb 07 0f 00 2d c7 =
0c 2c 00 fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b =
7f 04 eb 9f
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	ed                   	in     (%dx),%eax
   1:	c3                   	ret
   2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 00
   d:	66 90                	xchg   %ax,%ax
   f:	65 48 8b 04 25 40 32 	mov    %gs:0x23240,%rax
  16:	02 00
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	eb 07                	jmp    0x28
  21:	0f 00 2d c7 0c 2c 00 	verw   0x2c0cc7(%rip)        # 0x2c0cef
  28:	fb                   	sti
  29:	f4                   	hlt
  2a:*	fa                   	cli    		<-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 00             	nopl   (%rax)
  2f:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
  33:	3c 01                	cmp    $0x1,%al
  35:	74 0b                	je     0x42
  37:	3c 02                	cmp    $0x2,%al
  39:	74 05                	je     0x40
  3b:	8b 7f 04             	mov    0x4(%rdi),%edi
  3e:	eb 9f                	jmp    0xffffffffffffffdf

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	fa                   	cli
   1:	c3                   	ret
   2:	0f 1f 00             	nopl   (%rax)
   5:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
   9:	3c 01                	cmp    $0x1,%al
   b:	74 0b                	je     0x18
   d:	3c 02                	cmp    $0x2,%al
   f:	74 05                	je     0x16
  11:	8b 7f 04             	mov    0x4(%rdi),%edi
  14:	eb 9f                	jmp    0xffffffffffffffb5
[Sat Jan  6 21:33:28 2024] RSP: 0018:ffffa77300e7be80 EFLAGS: 00000246
[Sat Jan  6 21:33:28 2024] RAX: 0000000000004000 RBX: 0000000000000001 =
RCX: 000000000000001f
[Sat Jan  6 21:33:28 2024] RDX: ffff8f44c0000000 RSI: ffff8f454c6fc800 =
RDI: ffff8f454c6fc864
[Sat Jan  6 21:33:28 2024] RBP: ffffffffaa216ea0 R08: ffffffffaa216ea0 =
R09: 00003fd7b44cb0a0
[Sat Jan  6 21:33:28 2024] R10: 0000000000000002 R11: 0000000000000007 =
R12: 0000000000000001
[Sat Jan  6 21:33:28 2024] R13: ffffffffaa216f08 R14: ffffffffaa216f20 =
R15: 0000000000000000
[Sat Jan 6 21:33:28 2024] acpi_idle_enter =
(drivers/acpi/processor_idle.c:709)
[Sat Jan 6 21:33:28 2024] cpuidle_enter_state =
(drivers/cpuidle/cpuidle.c:267)
[Sat Jan 6 21:33:28 2024] cpuidle_enter (drivers/cpuidle/cpuidle.c:390 =
(discriminator 2))
[Sat Jan 6 21:33:28 2024] do_idle (kernel/sched/idle.c:134 =
kernel/sched/idle.c:215 kernel/sched/idle.c:282)
[Sat Jan 6 21:33:28 2024] cpu_startup_entry (kernel/sched/idle.c:379)
[Sat Jan 6 21:33:28 2024] start_secondary =
(arch/x86/kernel/smpboot.c:326)
[Sat Jan 6 21:33:28 2024] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:449)
[Sat Jan  6 21:33:28 2024]  </TASK>
[Sat Jan  6 21:33:28 2024] ---[ end trace 0000000000000000 ]---

> On 4 Jan 2024, at 22:51, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> Hi Thomas ,
>=20
> Happy New Year!
>=20
> here is two debugs from two new installed machins with kernel 6.6.9:
>=20
> dmesg1 :
>=20
> [ 2257.449125] ------------[ cut here ]------------
> [ 2257.449245] WARNING: CPU: 1 PID: 40622 at lib/rcuref.c:294 =
rcuref_put_slowpath+0x2f/0x70
> [ 2257.449373] Modules linked in: nft_limit nf_conntrack_netlink pppoe =
pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding ixgbe mdio i40e nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
> [ 2257.449642] CPU: 1 PID: 40622 Comm: nc Tainted: G           O       =
6.6.9 #1
> [ 2257.449761] Hardware name: Supermicro =
PIO-5038MR-H8TRF-NODE/X10SRD-F, BIOS 3.3 10/28/2020
> [ 2257.449883] RIP: 0010:rcuref_put_slowpath+0x2f/0x70
> [ 2257.449977] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 =
f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 =
78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4c e3 =
00
> [ 2257.450135] RSP: 0000:ffffb455cef83b78 EFLAGS: 00010246
> [ 2257.450227] RAX: 0000000000000000 RBX: ffff94873bb77dc0 RCX: =
ffff9486c0d46b80
> [ 2257.450341] RDX: ffff948736578428 RSI: 00000000fffffe01 RDI: =
ffff94873bb77dc0
> [ 2257.450456] RBP: ffff948736578428 R08: ffff948e1fa64f08 R09: =
0000000000000001
> [ 2257.450570] R10: 0000000000028530 R11: 0000000000000001 R12: =
ffff94873bb77d80
> [ 2257.450685] R13: ffff94873bb77de8 R14: ffff948e1fa64f08 R15: =
000000000266f59d
> [ 2257.450802] FS:  00007f0cdbc73800(0000) GS:ffff948e1fa40000(0000) =
knlGS:0000000000000000
> [ 2257.450918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2257.451012] CR2: 00007f0cdc3f5c30 CR3: 0000000178ea0002 CR4: =
00000000003706e0
> [ 2257.451127] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [ 2257.451240] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
> [ 2257.451353] Call Trace:
> [ 2257.451441]  <TASK>
> [ 2257.451526]  ? __warn+0x6c/0x130
> [ 2257.451616]  ? report_bug+0x1b8/0x200
> [ 2257.451707]  ? handle_bug+0x36/0x70
> [ 2257.451797]  ? exc_invalid_op+0x17/0x1a0
> [ 2257.451886]  ? asm_exc_invalid_op+0x16/0x20
> [ 2257.452038]  ? rcuref_put_slowpath+0x2f/0x70
> [ 2257.452129]  dst_release+0x1c/0x40
> [ 2257.452222]  rt_cache_route+0xbd/0xf0
> [ 2257.452313]  ? kmem_cache_alloc+0x31/0x390
> [ 2257.452404]  rt_set_nexthop.isra.0+0x1b6/0x450
> [ 2257.452495]  ip_route_input_slow+0x5d9/0xcc0
> [ 2257.452586]  ? nft_nat_do_chain+0x7f/0xd0 [nft_chain_nat]
> [ 2257.452681]  ? nf_conntrack_udp_packet+0xcf/0x240 [nf_conntrack]
> [ 2257.452784]  ? nf_nat_inet_fn+0x36f/0x3f0 [nf_nat]
> [ 2257.452880]  ip_route_input_noref+0xe0/0xf0
> [ 2257.452970]  ip_rcv_finish_core.isra.0+0xbb/0x440
> [ 2257.453064]  ip_rcv+0xd5/0x110
> [ 2257.453151]  ? ip_rcv_core+0x360/0x360
> [ 2257.453240]  process_backlog+0x107/0x210
> [ 2257.453330]  __napi_poll+0x20/0x180
> [ 2257.453420]  net_rx_action+0x29f/0x380
> [ 2257.453510]  __do_softirq+0xd0/0x202
> [ 2257.453599]  irq_exit_rcu+0x82/0xa0
> [ 2257.453689]  sysvec_call_function_single+0x32/0x80
> [ 2257.453781]  asm_sysvec_call_function_single+0x16/0x20
> [ 2257.453874] RIP: 0033:0x7f0cdc5928b2
> [ 2257.453963] Code: 06 00 00 4c 89 65 88 49 83 fd 08 0f 84 f7 06 00 =
00 49 83 fd 26 0f 84 05 07 00 00 4d 85 ed 0f 84 5f 01 00 00 41 0f b6 44 =
24 04 <89> c6 40 c0 ee 04 0f 84 72 06 00 00 41 0f b6 54 24 05 83 e2 03 =
ff
> [ 2257.454121] RSP: 002b:00007ffc04d3e890 EFLAGS: 00000206
> [ 2257.454215] RAX: 0000000000000012 RBX: 00007f0cdc444db8 RCX: =
00007f0cdc4e6e60
> [ 2257.454329] RDX: 0000000000000009 RSI: 00007f0cdc57ef30 RDI: =
00007f0cdc42c808
> [ 2257.454442] RBP: 00007ffc04d3e9b0 R08: 00007f0cdc445028 R09: =
00007ffc04d3e940
> [ 2257.454555] R10: 00007f0cdbf00be8 R11: 0000000000000000 R12: =
00007f0cdc42c898
> [ 2257.454670] R13: 0000000000000006 R14: 0000000600000006 R15: =
00007f0cdc581000
> [ 2257.454784]  </TASK>
> [ 2257.454869] ---[ end trace 0000000000000000 ]=E2=80=94
>=20
>=20
> [ 2257.449125] ------------[ cut here ]------------
> [ 2257.449245] WARNING: CPU: 1 PID: 40622 at lib/rcuref.c:294 =
rcuref_put_slowpath (lib/rcuref.c:294 (discriminator 1))
> [ 2257.449373] Modules linked in: nft_limit nf_conntrack_netlink pppoe =
pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding ixgbe mdio i40e nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
> [ 2257.449642] CPU: 1 PID: 40622 Comm: nc Tainted: G           O       =
6.6.9 #1
> [ 2257.449761] Hardware name: Supermicro =
PIO-5038MR-H8TRF-NODE/X10SRD-F, BIOS 3.3 10/28/2020
> [ 2257.449883] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:294 =
(discriminator 1))
> [ 2257.449977] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 =
f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 =
78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4c e3 =
00
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>   0: 07                    (bad)
>   1: 83 f8 ff              cmp    $0xffffffff,%eax
>   4: 75 19                 jne    0x1f
>   6: ba 00 00 00 e0        mov    $0xe0000000,%edx
>   b: f0 0f b1 17           lock cmpxchg %edx,(%rdi)
>   f: 83 f8 ff              cmp    $0xffffffff,%eax
>  12: 74 04                 je     0x18
>  14: 31 c0                 xor    %eax,%eax
>  16: 5b                    pop    %rbx
>  17: c3                    ret
>  18: b8 01 00 00 00        mov    $0x1,%eax
>  1d: 5b                    pop    %rbx
>  1e: c3                    ret
>  1f: 3d ff ff ff bf        cmp    $0xbfffffff,%eax
>  24: 77 14                 ja     0x3a
>  26: 85 c0                 test   %eax,%eax
>  28: 78 06                 js     0x30
>  2a:* 0f 0b                 ud2     <-- trapping instruction
>  2c: 31 c0                 xor    %eax,%eax
>  2e: eb e6                 jmp    0x16
>  30: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>  36: 31 c0                 xor    %eax,%eax
>  38: eb dc                 jmp    0x16
>  3a: 80                    .byte 0x80
>  3b: 3d e2 4c e3 00        cmp    $0xe34ce2,%eax
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   0: 0f 0b                 ud2
>   2: 31 c0                 xor    %eax,%eax
>   4: eb e6                 jmp    0xffffffffffffffec
>   6: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>   c: 31 c0                 xor    %eax,%eax
>   e: eb dc                 jmp    0xffffffffffffffec
>  10: 80                    .byte 0x80
>  11: 3d e2 4c e3 00        cmp    $0xe34ce2,%eax
> [ 2257.450135] RSP: 0000:ffffb455cef83b78 EFLAGS: 00010246
> [ 2257.450227] RAX: 0000000000000000 RBX: ffff94873bb77dc0 RCX: =
ffff9486c0d46b80
> [ 2257.450341] RDX: ffff948736578428 RSI: 00000000fffffe01 RDI: =
ffff94873bb77dc0
> [ 2257.450456] RBP: ffff948736578428 R08: ffff948e1fa64f08 R09: =
0000000000000001
> [ 2257.450570] R10: 0000000000028530 R11: 0000000000000001 R12: =
ffff94873bb77d80
> [ 2257.450685] R13: ffff94873bb77de8 R14: ffff948e1fa64f08 R15: =
000000000266f59d
> [ 2257.450802] FS:  00007f0cdbc73800(0000) GS:ffff948e1fa40000(0000) =
knlGS:0000000000000000
> [ 2257.450918] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2257.451012] CR2: 00007f0cdc3f5c30 CR3: 0000000178ea0002 CR4: =
00000000003706e0
> [ 2257.451127] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [ 2257.451240] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
> [ 2257.451353] Call Trace:
> [ 2257.451441]  <TASK>
> [ 2257.451526] ? __warn (kernel/panic.c:235 kernel/panic.c:673)
> [ 2257.451616] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> [ 2257.451707] ? handle_bug (arch/x86/kernel/traps.c:237)
> [ 2257.451797] ? exc_invalid_op (arch/x86/kernel/traps.c:258 =
(discriminator 1))
> [ 2257.451886] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
> [ 2257.452038] ? rcuref_put_slowpath (lib/rcuref.c:294 (discriminator =
1))
> [ 2257.452129] dst_release (net/core/dst.c:166 (discriminator 1))
> [ 2257.452222] rt_cache_route (net/ipv4/route.c:1499)
> [ 2257.452313] ? kmem_cache_alloc (mm/slab.h:711 (discriminator 1) =
mm/slub.c:3461 (discriminator 1) mm/slub.c:3487 (discriminator 1) =
mm/slub.c:3494 (discriminator 1) mm/slub.c:3503 (discriminator 1))
> [ 2257.452404] rt_set_nexthop.isra.0 (net/ipv4/route.c:1606 =
(discriminator 1))
> [ 2257.452495] ip_route_input_slow (./include/net/lwtunnel.h:140 =
net/ipv4/route.c:1875 net/ipv4/route.c:2154 net/ipv4/route.c:2337)
> [ 2257.452586] ? nft_nat_do_chain (net/netfilter/nft_chain_nat.c:33) =
nft_chain_nat
> [ 2257.452681] ? nf_conntrack_udp_packet =
(net/netfilter/nf_conntrack_proto_udp.c:130) nf_conntrack
> [ 2257.452784] ? nf_nat_inet_fn (net/netfilter/nf_nat_core.c:844) =
nf_nat
> [ 2257.452880] ip_route_input_noref (net/ipv4/route.c:2499)
> [ 2257.452970] ip_rcv_finish_core.isra.0 (net/ipv4/ip_input.c:367 =
(discriminator 1))
> [ 2257.453064] ip_rcv (net/ipv4/ip_input.c:448 =
./include/linux/netfilter.h:304 ./include/linux/netfilter.h:298 =
net/ipv4/ip_input.c:569)
> [ 2257.453151] ? ip_rcv_core (net/ipv4/ip_input.c:436)
> [ 2257.453240] process_backlog (net/core/dev.c:6000)
> [ 2257.453330] __napi_poll (net/core/dev.c:6559)
> [ 2257.453420] net_rx_action (net/core/dev.c:6628 net/core/dev.c:6759)
> [ 2257.453510] __do_softirq (./arch/x86/include/asm/preempt.h:27 =
kernel/softirq.c:564)
> [ 2257.453599] irq_exit_rcu (kernel/softirq.c:436 kernel/softirq.c:641 =
kernel/softirq.c:653)
> [ 2257.453689] sysvec_call_function_single (arch/x86/kernel/smp.c:262 =
(discriminator 69))
> [ 2257.453781] asm_sysvec_call_function_single =
(./arch/x86/include/asm/idtentry.h:656)
> [ 2257.453874] RIP: 0033:0x7f0cdc5928b2
> [ 2257.453963] Code: 06 00 00 4c 89 65 88 49 83 fd 08 0f 84 f7 06 00 =
00 49 83 fd 26 0f 84 05 07 00 00 4d 85 ed 0f 84 5f 01 00 00 41 0f b6 44 =
24 04 <89> c6 40 c0 ee 04 0f 84 72 06 00 00 41 0f b6 54 24 05 83 e2 03 =
ff
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>   0: 06                    (bad)
>   1: 00 00                 add    %al,(%rax)
>   3: 4c 89 65 88           mov    %r12,-0x78(%rbp)
>   7: 49 83 fd 08           cmp    $0x8,%r13
>   b: 0f 84 f7 06 00 00     je     0x708
>  11: 49 83 fd 26           cmp    $0x26,%r13
>  15: 0f 84 05 07 00 00     je     0x720
>  1b: 4d 85 ed              test   %r13,%r13
>  1e: 0f 84 5f 01 00 00     je     0x183
>  24: 41 0f b6 44 24 04     movzbl 0x4(%r12),%eax
>  2a:* 89 c6                 mov    %eax,%esi <-- trapping instruction
>  2c: 40 c0 ee 04           shr    $0x4,%sil
>  30: 0f 84 72 06 00 00     je     0x6a8
>  36: 41 0f b6 54 24 05     movzbl 0x5(%r12),%edx
>  3c: 83 e2 03              and    $0x3,%edx
>  3f: ff                    .byte 0xff
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   0: 89 c6                 mov    %eax,%esi
>   2: 40 c0 ee 04           shr    $0x4,%sil
>   6: 0f 84 72 06 00 00     je     0x67e
>   c: 41 0f b6 54 24 05     movzbl 0x5(%r12),%edx
>  12: 83 e2 03              and    $0x3,%edx
>  15: ff                    .byte 0xff
> [ 2257.454121] RSP: 002b:00007ffc04d3e890 EFLAGS: 00000206
> [ 2257.454215] RAX: 0000000000000012 RBX: 00007f0cdc444db8 RCX: =
00007f0cdc4e6e60
> [ 2257.454329] RDX: 0000000000000009 RSI: 00007f0cdc57ef30 RDI: =
00007f0cdc42c808
> [ 2257.454442] RBP: 00007ffc04d3e9b0 R08: 00007f0cdc445028 R09: =
00007ffc04d3e940
> [ 2257.454555] R10: 00007f0cdbf00be8 R11: 0000000000000000 R12: =
00007f0cdc42c898
> [ 2257.454670] R13: 0000000000000006 R14: 0000000600000006 R15: =
00007f0cdc581000
> [ 2257.454784]  </TASK>
> [ 2257.454869] ---[ end trace 0000000000000000 ]=E2=80=94
>=20
>=20
> dmesg2 :=20
>=20
> [ 2567.167952] ------------[ cut here ]------------
> [ 2567.168053] WARNING: CPU: 11 PID: 0 at lib/rcuref.c:294 =
rcuref_put_slowpath+0x2f/0x70
> [ 2567.168175] Modules linked in: nft_limit nf_conntrack_netlink pppoe =
pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding ixgbe mdio i40e nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
> [ 2567.168445] CPU: 11 PID: 0 Comm: swapper/11 Tainted: G           O  =
     6.6.9 #1
> [ 2567.168561] Hardware name: Supermicro X10SRD-F/X10SRD-F, BIOS 3.4 =
06/05/2021
> [ 2567.168675] RIP: 0010:rcuref_put_slowpath+0x2f/0x70
> [ 2567.168767] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 =
f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 =
78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4c e3 =
00
> [ 2567.168924] RSP: 0018:ffffaeaf80418d00 EFLAGS: 00010246
> [ 2567.169017] RAX: 0000000000000000 RBX: ffff9fef84d6a940 RCX: =
0000000000000074
> [ 2567.169132] RDX: ffff9fefe2e30000 RSI: 0000000000000000 RDI: =
ffff9fef84d6a940
> [ 2567.169246] RBP: ffff9fefe2e306c0 R08: 0000000000000000 R09: =
0000000000029300
> [ 2567.169359] R10: 0000000000029300 R11: ffffaeaf80418d90 R12: =
ffff9fef8aebe000
> [ 2567.169473] R13: ffff9fef80896800 R14: ffff9fef85335200 R15: =
ffff9fef8ae07080
> [ 2567.169586] FS:  0000000000000000(0000) GS:ffff9ff6dfcc0000(0000) =
knlGS:0000000000000000
> [ 2567.169702] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2567.169795] CR2: 00007f4eaa7e6650 CR3: 0000000156dcd006 CR4: =
00000000003706e0
> [ 2567.169908] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [ 2567.170022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
> [ 2567.170137] Call Trace:
> [ 2567.170224]  <IRQ>
> [ 2567.170309]  ? __warn+0x6c/0x130
> [ 2567.170399]  ? report_bug+0x1b8/0x200
> [ 2567.170488]  ? handle_bug+0x36/0x70
> [ 2567.170577]  ? exc_invalid_op+0x17/0x1a0
> [ 2567.170667]  ? asm_exc_invalid_op+0x16/0x20
> [ 2567.170758]  ? rcuref_put_slowpath+0x2f/0x70
> [ 2567.170850]  dst_release+0x1c/0x40
> [ 2567.170939]  __dev_queue_xmit+0x598/0xce0
> [ 2567.171029]  vlan_dev_hard_start_xmit+0x82/0xc0
> [ 2567.171122]  dev_hard_start_xmit+0x95/0xe0
> [ 2567.171216]  __dev_queue_xmit+0x863/0xce0
> [ 2567.171305]  ? eth_header+0x25/0xc0
> [ 2567.171394]  ip_finish_output2+0x1a0/0x530
> [ 2567.171485]  process_backlog+0x107/0x210
> [ 2567.171575]  __napi_poll+0x20/0x180
> [ 2567.171663]  net_rx_action+0x29f/0x380
> [ 2567.171752]  ? rebalance_domains+0x14c/0x300
> [ 2567.171843]  __do_softirq+0xd0/0x202
> [ 2567.171932]  irq_exit_rcu+0x82/0xa0
> [ 2567.172022]  common_interrupt+0x7a/0xa0
> [ 2567.172111]  </IRQ>
> [ 2567.172198]  <TASK>
> [ 2567.172283]  asm_common_interrupt+0x22/0x40
> [ 2567.172374] RIP: 0010:cpuidle_enter_state+0xa3/0x6a0
> [ 2567.172467] Code: 46 40 40 0f 84 02 01 00 00 e8 c9 a0 70 ff e8 d4 =
f6 ff ff 31 ff 49 89 c6 e8 0a b9 6f ff 45 84 ff 0f 85 d9 00 00 00 fb 45 =
85 ed <0f> 88 b8 00 00 00 49 63 cd 48 8b 04 24 48 6b f1 68 49 29 c6 48 =
8d
> [ 2567.172623] RSP: 0018:ffffaeaf80177e98 EFLAGS: 00000202
> [ 2567.172715] RAX: ffff9ff6dfce3a80 RBX: ffff9fef81338000 RCX: =
000000000000001f
> [ 2567.172828] RDX: 00000255b721ed84 RSI: 00000000238e3b7a RDI: =
0000000000000000
> [ 2567.172942] RBP: ffffffffba216ea0 R08: 0000000000000004 R09: =
ffff9ff6dfcdef00
> [ 2567.173055] R10: ffff9ff6dfcdef00 R11: 0000000000000007 R12: =
0000000000000001
> [ 2567.173168] R13: 0000000000000001 R14: 00000255b721ed84 R15: =
0000000000000000
> [ 2567.173283]  ? cpuidle_enter_state+0x96/0x6a0
> [ 2567.173374]  cpuidle_enter+0x24/0x40
> [ 2567.173464]  do_idle+0x1a7/0x210
> [ 2567.173552]  cpu_startup_entry+0x21/0x30
> [ 2567.173642]  start_secondary+0xe1/0xf0
> [ 2567.173732]  secondary_startup_64_no_verify+0x178/0x17b
> [ 2567.173825]  </TASK>
> [ 2567.173910] ---[ end trace 0000000000000000 ]=E2=80=94
>=20
>=20
> [ 2567.167952] ------------[ cut here ]------------
> [ 2567.168053] WARNING: CPU: 11 PID: 0 at lib/rcuref.c:294 =
rcuref_put_slowpath (lib/rcuref.c:294 (discriminator 1))
> [ 2567.168175] Modules linked in: nft_limit nf_conntrack_netlink pppoe =
pppox ppp_generic slhc nft_ct nft_nat nft_chain_nat nf_tables netconsole =
coretemp bonding ixgbe mdio i40e nf_nat_sip nf_conntrack_sip nf_nat_pptp =
nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat_ftp =
nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos
> [ 2567.168445] CPU: 11 PID: 0 Comm: swapper/11 Tainted: G           O  =
     6.6.9 #1
> [ 2567.168561] Hardware name: Supermicro X10SRD-F/X10SRD-F, BIOS 3.4 =
06/05/2021
> [ 2567.168675] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:294 =
(discriminator 1))
> [ 2567.168767] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 =
f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 =
78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4c e3 =
00
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>   0: 07                    (bad)
>   1: 83 f8 ff              cmp    $0xffffffff,%eax
>   4: 75 19                 jne    0x1f
>   6: ba 00 00 00 e0        mov    $0xe0000000,%edx
>   b: f0 0f b1 17           lock cmpxchg %edx,(%rdi)
>   f: 83 f8 ff              cmp    $0xffffffff,%eax
>  12: 74 04                 je     0x18
>  14: 31 c0                 xor    %eax,%eax
>  16: 5b                    pop    %rbx
>  17: c3                    ret
>  18: b8 01 00 00 00        mov    $0x1,%eax
>  1d: 5b                    pop    %rbx
>  1e: c3                    ret
>  1f: 3d ff ff ff bf        cmp    $0xbfffffff,%eax
>  24: 77 14                 ja     0x3a
>  26: 85 c0                 test   %eax,%eax
>  28: 78 06                 js     0x30
>  2a:* 0f 0b                 ud2     <-- trapping instruction
>  2c: 31 c0                 xor    %eax,%eax
>  2e: eb e6                 jmp    0x16
>  30: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>  36: 31 c0                 xor    %eax,%eax
>  38: eb dc                 jmp    0x16
>  3a: 80                    .byte 0x80
>  3b: 3d e2 4c e3 00        cmp    $0xe34ce2,%eax
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   0: 0f 0b                 ud2
>   2: 31 c0                 xor    %eax,%eax
>   4: eb e6                 jmp    0xffffffffffffffec
>   6: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>   c: 31 c0                 xor    %eax,%eax
>   e: eb dc                 jmp    0xffffffffffffffec
>  10: 80                    .byte 0x80
>  11: 3d e2 4c e3 00        cmp    $0xe34ce2,%eax
> [ 2567.168924] RSP: 0018:ffffaeaf80418d00 EFLAGS: 00010246
> [ 2567.169017] RAX: 0000000000000000 RBX: ffff9fef84d6a940 RCX: =
0000000000000074
> [ 2567.169132] RDX: ffff9fefe2e30000 RSI: 0000000000000000 RDI: =
ffff9fef84d6a940
> [ 2567.169246] RBP: ffff9fefe2e306c0 R08: 0000000000000000 R09: =
0000000000029300
> [ 2567.169359] R10: 0000000000029300 R11: ffffaeaf80418d90 R12: =
ffff9fef8aebe000
> [ 2567.169473] R13: ffff9fef80896800 R14: ffff9fef85335200 R15: =
ffff9fef8ae07080
> [ 2567.169586] FS:  0000000000000000(0000) GS:ffff9ff6dfcc0000(0000) =
knlGS:0000000000000000
> [ 2567.169702] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2567.169795] CR2: 00007f4eaa7e6650 CR3: 0000000156dcd006 CR4: =
00000000003706e0
> [ 2567.169908] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [ 2567.170022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
> [ 2567.170137] Call Trace:
> [ 2567.170224]  <IRQ>
> [ 2567.170309] ? __warn (kernel/panic.c:235 kernel/panic.c:673)
> [ 2567.170399] ? report_bug (lib/bug.c:180 lib/bug.c:219)
> [ 2567.170488] ? handle_bug (arch/x86/kernel/traps.c:237)
> [ 2567.170577] ? exc_invalid_op (arch/x86/kernel/traps.c:258 =
(discriminator 1))
> [ 2567.170667] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
> [ 2567.170758] ? rcuref_put_slowpath (lib/rcuref.c:294 (discriminator =
1))
> [ 2567.170850] dst_release (net/core/dst.c:166 (discriminator 1))
> [ 2567.170939] __dev_queue_xmit (./include/net/dst.h:283 =
net/core/dev.c:4327)
> [ 2567.171029] vlan_dev_hard_start_xmit (net/8021q/vlan_dev.c:130)
> [ 2567.171122] dev_hard_start_xmit (./include/linux/netdevice.h:4926 =
net/core/dev.c:3576 net/core/dev.c:3592)
> [ 2567.171216] __dev_queue_xmit (./include/linux/netdevice.h:3300 =
(discriminator 25) net/core/dev.c:4373 (discriminator 25))
> [ 2567.171305] ? eth_header (net/ethernet/eth.c:85)
> [ 2567.171394] ip_finish_output2 (./include/net/neighbour.h:542 =
(discriminator 2) net/ipv4/ip_output.c:233 (discriminator 2))
> [ 2567.171485] process_backlog (net/core/dev.c:6000)
> [ 2567.171575] __napi_poll (net/core/dev.c:6559)
> [ 2567.171663] net_rx_action (net/core/dev.c:6628 net/core/dev.c:6759)
> [ 2567.171752] ? rebalance_domains (kernel/sched/fair.c:11719 =
kernel/sched/fair.c:11895)
> [ 2567.171843] __do_softirq (./arch/x86/include/asm/preempt.h:27 =
kernel/softirq.c:564)
> [ 2567.171932] irq_exit_rcu (kernel/softirq.c:436 kernel/softirq.c:641 =
kernel/softirq.c:653)
> [ 2567.172022] common_interrupt (arch/x86/kernel/irq.c:247 =
(discriminator 47))
> [ 2567.172111]  </IRQ>
> [ 2567.172198]  <TASK>
> [ 2567.172283] asm_common_interrupt =
(./arch/x86/include/asm/idtentry.h:640)
> [ 2567.172374] RIP: 0010:cpuidle_enter_state =
(drivers/cpuidle/cpuidle.c:291)
> [ 2567.172467] Code: 46 40 40 0f 84 02 01 00 00 e8 c9 a0 70 ff e8 d4 =
f6 ff ff 31 ff 49 89 c6 e8 0a b9 6f ff 45 84 ff 0f 85 d9 00 00 00 fb 45 =
85 ed <0f> 88 b8 00 00 00 49 63 cd 48 8b 04 24 48 6b f1 68 49 29 c6 48 =
8d
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>   0: 46                    rex.RX
>   1: 40                    rex
>   2: 40 0f 84 02 01 00 00 rex je 0x10b
>   9: e8 c9 a0 70 ff        call   0xffffffffff70a0d7
>   e: e8 d4 f6 ff ff        call   0xfffffffffffff6e7
>  13: 31 ff                 xor    %edi,%edi
>  15: 49 89 c6              mov    %rax,%r14
>  18: e8 0a b9 6f ff        call   0xffffffffff6fb927
>  1d: 45 84 ff              test   %r15b,%r15b
>  20: 0f 85 d9 00 00 00     jne    0xff
>  26: fb                    sti
>  27: 45 85 ed              test   %r13d,%r13d
>  2a:* 0f 88 b8 00 00 00     js     0xe8 <-- trapping instruction
>  30: 49 63 cd              movslq %r13d,%rcx
>  33: 48 8b 04 24           mov    (%rsp),%rax
>  37: 48 6b f1 68           imul   $0x68,%rcx,%rsi
>  3b: 49 29 c6              sub    %rax,%r14
>  3e: 48                    rex.W
>  3f: 8d                    .byte 0x8d
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   0: 0f 88 b8 00 00 00     js     0xbe
>   6: 49 63 cd              movslq %r13d,%rcx
>   9: 48 8b 04 24           mov    (%rsp),%rax
>   d: 48 6b f1 68           imul   $0x68,%rcx,%rsi
>  11: 49 29 c6              sub    %rax,%r14
>  14: 48                    rex.W
>  15: 8d                    .byte 0x8d
> [ 2567.172623] RSP: 0018:ffffaeaf80177e98 EFLAGS: 00000202
> [ 2567.172715] RAX: ffff9ff6dfce3a80 RBX: ffff9fef81338000 RCX: =
000000000000001f
> [ 2567.172828] RDX: 00000255b721ed84 RSI: 00000000238e3b7a RDI: =
0000000000000000
> [ 2567.172942] RBP: ffffffffba216ea0 R08: 0000000000000004 R09: =
ffff9ff6dfcdef00
> [ 2567.173055] R10: ffff9ff6dfcdef00 R11: 0000000000000007 R12: =
0000000000000001
> [ 2567.173168] R13: 0000000000000001 R14: 00000255b721ed84 R15: =
0000000000000000
> [ 2567.173283] ? cpuidle_enter_state (drivers/cpuidle/cpuidle.c:285)
> [ 2567.173374] cpuidle_enter (drivers/cpuidle/cpuidle.c:390 =
(discriminator 2))
> [ 2567.173464] do_idle (kernel/sched/idle.c:134 =
kernel/sched/idle.c:215 kernel/sched/idle.c:282)
> [ 2567.173552] cpu_startup_entry (kernel/sched/idle.c:379)
> [ 2567.173642] start_secondary (arch/x86/kernel/smpboot.c:326)
> [ 2567.173732] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:449)
> [ 2567.173825]  </TASK>
> [ 2567.173910] ---[ end trace 0000000000000000 ]=E2=80=94
>=20
> best regards,
> Martin
>=20
>=20
>> On 29 Dec 2023, at 14:00, Martin Zaharinov <micron10@gmail.com> =
wrote:
>>=20
>> Hi Thomas,
>>=20
>> One more report from second machine:
>>=20
>> [21299.954952] ------------[ cut here ]------------
>> [21299.955047] WARNING: CPU: 15 PID: 0 at lib/rcuref.c:294 =
rcuref_put_slowpath (lib/rcuref.c:294 (discriminator 1))
>> [21299.955153] Modules linked in: nft_limit nft_ct nft_nat =
nft_chain_nat nf_tables netconsole coretemp virtio_net net_failover =
failover virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio =
virtio_ring e1000e e1000 vmxnet3 i40e ixgbe mdio bnxt_en nf_nat_sip =
nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp =
nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 rtc_cmos
>> [21299.955378] CPU: 15 PID: 0 Comm: swapper/15 Tainted: G           O =
      6.6.8 #1
>> [21299.955475] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 =
Gen10, BIOS U30 02/09/2023
>> [21299.955575] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:294 =
(discriminator 1))
>> [21299.955662] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 =
f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 =
78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4e e3 =
00
>> All code
>> =3D=3D=3D=3D=3D=3D=3D=3D
>>  0: 07                    (bad)
>>  1: 83 f8 ff              cmp    $0xffffffff,%eax
>>  4: 75 19                 jne    0x1f
>>  6: ba 00 00 00 e0        mov    $0xe0000000,%edx
>>  b: f0 0f b1 17           lock cmpxchg %edx,(%rdi)
>>  f: 83 f8 ff              cmp    $0xffffffff,%eax
>> 12: 74 04                 je     0x18
>> 14: 31 c0                 xor    %eax,%eax
>> 16: 5b                    pop    %rbx
>> 17: c3                    ret
>> 18: b8 01 00 00 00        mov    $0x1,%eax
>> 1d: 5b                    pop    %rbx
>> 1e: c3                    ret
>> 1f: 3d ff ff ff bf        cmp    $0xbfffffff,%eax
>> 24: 77 14                 ja     0x3a
>> 26: 85 c0                 test   %eax,%eax
>> 28: 78 06                 js     0x30
>> 2a:* 0f 0b                 ud2     <-- trapping instruction
>> 2c: 31 c0                 xor    %eax,%eax
>> 2e: eb e6                 jmp    0x16
>> 30: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>> 36: 31 c0                 xor    %eax,%eax
>> 38: eb dc                 jmp    0x16
>> 3a: 80                    .byte 0x80
>> 3b: 3d e2 4e e3 00        cmp    $0xe34ee2,%eax
>>=20
>> Code starting with the faulting instruction
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  0: 0f 0b                 ud2
>>  2: 31 c0                 xor    %eax,%eax
>>  4: eb e6                 jmp    0xffffffffffffffec
>>  6: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>>  c: 31 c0                 xor    %eax,%eax
>>  e: eb dc                 jmp    0xffffffffffffffec
>> 10: 80                    .byte 0x80
>> 11: 3d e2 4e e3 00        cmp    $0xe34ee2,%eax
>> [21299.955793] RSP: 0018:ffff96a7c0578c30 EFLAGS: 00010246
>> [21299.955879] RAX: 0000000000000000 RBX: ffff8b75d1e49a80 RCX: =
ffff8b75c6667c80
>> [21299.955974] RDX: ffff8b84bfbe4f08 RSI: 00000000fffffe01 RDI: =
ffff8b75d1e49a80
>> [21299.956070] RBP: ffff8b84bfbe4f08 R08: ffff8b84bfbe4f08 R09: =
0000000000000001
>> [21299.956167] R10: 0000000000028530 R11: 0000000000000001 R12: =
ffff8b75d1e49a40
>> [21299.956261] R13: ffff8b75d1e49aa8 R14: ffff8b84bfbe4f08 R15: =
00000000c26ab667
>> [21299.956358] FS:  0000000000000000(0000) GS:ffff8b84bfbc0000(0000) =
knlGS:0000000000000000
>> [21299.956457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [21299.956540] CR2: 00007f2e185c73c8 CR3: 0000000950014003 CR4: =
00000000003706e0
>> [21299.956635] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
>> [21299.956730] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
>> [21299.956826] Call Trace:
>> [21299.956905]  <IRQ>
>> [21299.956983] ? __warn (kernel/panic.c:235 kernel/panic.c:673)
>> [21299.957065] ? report_bug (lib/bug.c:180 lib/bug.c:219)
>> [21299.957147] ? handle_bug (arch/x86/kernel/traps.c:237)
>> [21299.957228] ? exc_invalid_op (arch/x86/kernel/traps.c:258 =
(discriminator 1))
>> [21299.957308] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
>> [21299.957393] ? rcuref_put_slowpath (lib/rcuref.c:294 (discriminator =
1))
>> [21299.957476] dst_release (net/core/dst.c:166 (discriminator 1))
>> [21299.957559] rt_cache_route (net/ipv4/route.c:1499)
>> [21299.957641] rt_set_nexthop.isra.0 (net/ipv4/route.c:1606 =
(discriminator 1))
>> [21299.957722] ip_route_input_slow (./include/net/lwtunnel.h:140 =
net/ipv4/route.c:1875 net/ipv4/route.c:2154 net/ipv4/route.c:2337)
>> [21299.957804] ? free_unref_page (./include/linux/list.h:150 =
(discriminator 1) ./include/linux/list.h:169 (discriminator 1) =
mm/page_alloc.c:2377 (discriminator 1) mm/page_alloc.c:2428 =
(discriminator 1))
>> [21299.957889] ip_route_input_noref (net/ipv4/route.c:2499)
>> [21299.957972] ip_rcv_finish_core.isra.0 (net/ipv4/ip_input.c:367 =
(discriminator 1))
>> [21299.958058] ip_rcv (net/ipv4/ip_input.c:448 =
./include/linux/netfilter.h:304 ./include/linux/netfilter.h:298 =
net/ipv4/ip_input.c:569)
>> [21299.958139] ? ip_rcv_core (net/ipv4/ip_input.c:436)
>> [21299.958220] process_backlog (net/core/dev.c:5997)
>> [21299.958302] __napi_poll (net/core/dev.c:6556)
>> [21299.958384] net_rx_action (net/core/dev.c:6625 =
net/core/dev.c:6756)
>> [21299.958466] __do_softirq (./arch/x86/include/asm/preempt.h:27 =
kernel/softirq.c:564)
>> [21299.958549] irq_exit_rcu (kernel/softirq.c:436 =
kernel/softirq.c:641 kernel/softirq.c:653)
>> [21299.958631] sysvec_call_function_single (arch/x86/kernel/smp.c:262 =
(discriminator 47))
>> [21299.958714]  </IRQ>
>> [21299.958792]  <TASK>
>> [21299.958869] asm_sysvec_call_function_single =
(./arch/x86/include/asm/idtentry.h:656)
>> [21299.958953] RIP: 0010:acpi_safe_halt =
(./arch/x86/include/asm/irqflags.h:37 =
./arch/x86/include/asm/irqflags.h:72 drivers/acpi/processor_idle.c:113)
>> [21299.959038] Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 =
48 8b 04 25 40 32 02 00 48 8b 00 a8 08 75 0c eb 07 0f 00 2d 57 0f 2c 00 =
fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb =
9f
>> All code
>> =3D=3D=3D=3D=3D=3D=3D=3D
>>  0: ed                    in     (%dx),%eax
>>  1: c3                    ret
>>  2: 66 66 2e 0f 1f 84 00 data16 cs nopw 0x0(%rax,%rax,1)
>>  9: 00 00 00 00
>>  d: 66 90                 xchg   %ax,%ax
>>  f: 65 48 8b 04 25 40 32 mov    %gs:0x23240,%rax
>> 16: 02 00
>> 18: 48 8b 00              mov    (%rax),%rax
>> 1b: a8 08                 test   $0x8,%al
>> 1d: 75 0c                 jne    0x2b
>> 1f: eb 07                 jmp    0x28
>> 21: 0f 00 2d 57 0f 2c 00 verw   0x2c0f57(%rip)        # 0x2c0f7f
>> 28: fb                    sti
>> 29: f4                    hlt
>> 2a:* fa                    cli     <-- trapping instruction
>> 2b: c3                    ret
>> 2c: 0f 1f 00              nopl   (%rax)
>> 2f: 0f b6 47 08           movzbl 0x8(%rdi),%eax
>> 33: 3c 01                 cmp    $0x1,%al
>> 35: 74 0b                 je     0x42
>> 37: 3c 02                 cmp    $0x2,%al
>> 39: 74 05                 je     0x40
>> 3b: 8b 7f 04              mov    0x4(%rdi),%edi
>> 3e: eb 9f                 jmp    0xffffffffffffffdf
>>=20
>> Code starting with the faulting instruction
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>  0: fa                    cli
>>  1: c3                    ret
>>  2: 0f 1f 00              nopl   (%rax)
>>  5: 0f b6 47 08           movzbl 0x8(%rdi),%eax
>>  9: 3c 01                 cmp    $0x1,%al
>>  b: 74 0b                 je     0x18
>>  d: 3c 02                 cmp    $0x2,%al
>>  f: 74 05                 je     0x16
>> 11: 8b 7f 04              mov    0x4(%rdi),%edi
>> 14: eb 9f                 jmp    0xffffffffffffffb5
>> [21299.959162] RSP: 0018:ffff96a7c015be80 EFLAGS: 00000246
>> [21299.959247] RAX: 0000000000004000 RBX: 0000000000000001 RCX: =
000000000000001f
>> [21299.959343] RDX: ffff8b84bfbc0000 RSI: ffff8b75c76ba000 RDI: =
ffff8b75c76ba064
>> [21299.959437] RBP: ffffffffae216ea0 R08: ffffffffae216ea0 R09: =
0000000000000003
>> [21299.959533] R10: 0000000000000002 R11: 0000000000000008 R12: =
0000000000000001
>> [21299.959630] R13: ffffffffae216f08 R14: ffffffffae216f20 R15: =
0000000000000000
>> [21299.959725] acpi_idle_enter (drivers/acpi/processor_idle.c:709)
>> [21299.959807] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:267)
>> [21299.959890] cpuidle_enter (drivers/cpuidle/cpuidle.c:390 =
(discriminator 2))
>> [21299.959975] do_idle (kernel/sched/idle.c:134 =
kernel/sched/idle.c:215 kernel/sched/idle.c:282)
>> [21299.960058] cpu_startup_entry (kernel/sched/idle.c:379)
>> [21299.960140] start_secondary (arch/x86/kernel/smpboot.c:326)
>> [21299.960223] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:433)
>> [21299.960306]  </TASK>
>> [21299.960384] ---[ end trace 0000000000000000 ]---
>>=20
>>> On 22 Dec 2023, at 19:26, Martin Zaharinov <micron10@gmail.com> =
wrote:
>>>=20
>>> Hi Thomas,
>>>=20
>>> this is with applyed patch from you.
>>> See logs
>>>=20
>>>=20
>>> [43040.198064] ------------[ cut here ]------------
>>> [43040.198407] WARNING: CPU: 47 PID: 0 at lib/rcuref.c:294 =
rcuref_put_slowpath+0x2f/0x70
>>> [43040.198685] Modules linked in: pppoe pppox ppp_generic slhc =
nft_limit nft_ct nft_nat nft_chain_nat nf_tables netconsole tg3 igb =
i2c_algo_bit e1000e bnxt_en mlx5_core mlxfw mlx4_en mlx4_core i40e ixgbe =
mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp =
nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipmi_devintf ipmi_msghandler =
rtc_cmos
>>> [43040.199478] CPU: 47 PID: 0 Comm: swapper/47 Tainted: G           =
O       6.6.8 #1
>>> [43040.199660] Hardware name: VMware, Inc. VMware Virtual =
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>> [43040.199886] RIP: 0010:rcuref_put_slowpath+0x2f/0x70
>>> [43040.200028] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 =
f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 =
78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4e e3 =
00
>>> [43040.200387] RSP: 0018:ffffa39d83e88c30 EFLAGS: 00010246
>>> [43040.200528] RAX: 0000000000000000 RBX: ffff9c58e966b840 RCX: =
ffff9c5bc4e35680
>>> [43040.200700] RDX: ffff9c5fafde4f08 RSI: 00000000fffffe01 RDI: =
ffff9c58e966b840
>>> [43040.200871] RBP: ffff9c5fafde4f08 R08: ffff9c5fafde4f08 R09: =
0000000000000001
>>> [43040.201044] R10: 00000000000286e0 R11: 0000000000000001 R12: =
ffff9c58e966b800
>>> [43040.201255] R13: ffff9c58e966b868 R14: ffff9c5fafde4f08 R15: =
000000008f5de42b
>>> [43040.201439] FS:  0000000000000000(0000) GS:ffff9c5fafdc0000(0000) =
knlGS:0000000000000000
>>> [43040.201642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [43040.201799] CR2: 00007f1401217714 CR3: 0000000464b94003 CR4: =
00000000001706e0
>>> [43040.201994] Call Trace:
>>> [43040.202095]  <IRQ>
>>> [43040.202187]  ? __warn+0x6c/0x130
>>> [43040.202301]  ? report_bug+0x1b8/0x200
>>> [43040.202418]  ? handle_bug+0x36/0x70
>>> [43040.202534]  ? exc_invalid_op+0x17/0x1a0
>>> [43040.202652]  ? asm_exc_invalid_op+0x16/0x20
>>> [43040.202781]  ? rcuref_put_slowpath+0x2f/0x70
>>> [43040.202909]  dst_release+0x1c/0x40
>>> [43040.203026]  rt_cache_route+0xbd/0xf0
>>> [43040.203143]  rt_set_nexthop.isra.0+0x1b6/0x450
>>> [43040.203272]  ip_route_input_slow+0x5d9/0xcc0
>>> [43040.203401]  ? nf_conntrack_udp_packet+0x17c/0x240 [nf_conntrack]
>>> [43040.203581]  ip_route_input_noref+0xe0/0xf0
>>> [43040.203704]  ip_rcv_finish_core.isra.0+0xbb/0x440
>>> [43040.203855]  ip_rcv+0xd5/0x110
>>> [43040.203962]  ? ip_rcv_core+0x360/0x360
>>> [43040.204079]  process_backlog+0x107/0x210
>>> [43040.204201]  __napi_poll+0x20/0x180
>>> [43040.204315]  net_rx_action+0x29f/0x380
>>> [43040.204432]  __do_softirq+0xd0/0x202
>>> [43040.204549]  irq_exit_rcu+0x82/0xa0
>>> [43040.204667]  common_interrupt+0x7a/0xa0
>>> [43040.204786]  </IRQ>
>>> [43040.204876]  <TASK>
>>> [43040.204965]  asm_common_interrupt+0x22/0x40
>>> [43040.205090] RIP: 0010:acpi_safe_halt+0x1b/0x20
>>> [43040.205220] Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 =
48 8b 04 25 40 32 02 00 48 8b 00 a8 08 75 0c eb 07 0f 00 2d 57 0f 2c 00 =
fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb =
9f
>>> [43040.205578] RSP: 0018:ffffa39d8234fe80 EFLAGS: 00000246
>>> [43040.205718] RAX: 0000000000004000 RBX: 0000000000000001 RCX: =
000000000000001f
>>> [43040.205890] RDX: ffff9c5fafdc0000 RSI: ffff9c5882e95800 RDI: =
ffff9c5882e95864
>>> [43040.206063] RBP: ffffffffa9216ea0 R08: ffffffffa9216ea0 R09: =
0000000000000003
>>> [43040.206246] R10: 0000000000000002 R11: 0000000000000008 R12: =
0000000000000001
>>> [43040.206419] R13: ffffffffa9216f08 R14: ffffffffa9216f20 R15: =
0000000000000000
>>> [43040.206593]  acpi_idle_enter+0x77/0xc0
>>> [43040.206711]  cpuidle_enter_state+0x69/0x6a0
>>> [43040.206835]  cpuidle_enter+0x24/0x40
>>> [43040.206954]  do_idle+0x1a7/0x210
>>> [43040.207066]  cpu_startup_entry+0x21/0x30
>>> [43040.207188]  start_secondary+0xe1/0xf0
>>> [43040.207310]  secondary_startup_64_no_verify+0x166/0x16b
>>> [43040.207451]  </TASK>
>>> [43040.207542] ---[ end trace 0000000000000000 ]---
>>>=20
>>>=20
>>>=20
>>> [43040.198064] ------------[ cut here ]------------
>>> [43040.198407] WARNING: CPU: 47 PID: 0 at lib/rcuref.c:294 =
rcuref_put_slowpath (lib/rcuref.c:294 (discriminator 1))
>>> [43040.198685] Modules linked in: pppoe pppox ppp_generic slhc =
nft_limit nft_ct nft_nat nft_chain_nat nf_tables netconsole tg3 igb =
i2c_algo_bit e1000e bnxt_en mlx5_core mlxfw mlx4_en mlx4_core i40e ixgbe =
mdio nf_nat_sip nf_conntrack_sip nf_nat_pptp nf_conntrack_pptp =
nf_nat_tftp nf_conntrack_tftp nf_nat_ftp nf_conntrack_ftp nf_nat =
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipmi_devintf ipmi_msghandler =
rtc_cmos
>>> [43040.199478] CPU: 47 PID: 0 Comm: swapper/47 Tainted: G           =
O       6.6.8 #1
>>> [43040.199660] Hardware name: VMware, Inc. VMware Virtual =
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
>>> [43040.199886] RIP: 0010:rcuref_put_slowpath (lib/rcuref.c:294 =
(discriminator 1))
>>> [43040.200028] Code: 07 83 f8 ff 75 19 ba 00 00 00 e0 f0 0f b1 17 83 =
f8 ff 74 04 31 c0 5b c3 b8 01 00 00 00 5b c3 3d ff ff ff bf 77 14 85 c0 =
78 06 <0f> 0b 31 c0 eb e6 c7 07 00 00 00 a0 31 c0 eb dc 80 3d e2 4e e3 =
00
>>> All code
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>> 0: 07                    (bad)
>>> 1: 83 f8 ff              cmp    $0xffffffff,%eax
>>> 4: 75 19                 jne    0x1f
>>> 6: ba 00 00 00 e0        mov    $0xe0000000,%edx
>>> b: f0 0f b1 17           lock cmpxchg %edx,(%rdi)
>>> f: 83 f8 ff              cmp    $0xffffffff,%eax
>>> 12: 74 04                 je     0x18
>>> 14: 31 c0                 xor    %eax,%eax
>>> 16: 5b                    pop    %rbx
>>> 17: c3                    ret
>>> 18: b8 01 00 00 00        mov    $0x1,%eax
>>> 1d: 5b                    pop    %rbx
>>> 1e: c3                    ret
>>> 1f: 3d ff ff ff bf        cmp    $0xbfffffff,%eax
>>> 24: 77 14                 ja     0x3a
>>> 26: 85 c0                 test   %eax,%eax
>>> 28: 78 06                 js     0x30
>>> 2a:* 0f 0b                 ud2     <-- trapping instruction
>>> 2c: 31 c0                 xor    %eax,%eax
>>> 2e: eb e6                 jmp    0x16
>>> 30: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>>> 36: 31 c0                 xor    %eax,%eax
>>> 38: eb dc                 jmp    0x16
>>> 3a: 80                    .byte 0x80
>>> 3b: 3d e2 4e e3 00        cmp    $0xe34ee2,%eax
>>>=20
>>> Code starting with the faulting instruction
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> 0: 0f 0b                 ud2
>>> 2: 31 c0                 xor    %eax,%eax
>>> 4: eb e6                 jmp    0xffffffffffffffec
>>> 6: c7 07 00 00 00 a0     movl   $0xa0000000,(%rdi)
>>> c: 31 c0                 xor    %eax,%eax
>>> e: eb dc                 jmp    0xffffffffffffffec
>>> 10: 80                    .byte 0x80
>>> 11: 3d e2 4e e3 00        cmp    $0xe34ee2,%eax
>>> [43040.200387] RSP: 0018:ffffa39d83e88c30 EFLAGS: 00010246
>>> [43040.200528] RAX: 0000000000000000 RBX: ffff9c58e966b840 RCX: =
ffff9c5bc4e35680
>>> [43040.200700] RDX: ffff9c5fafde4f08 RSI: 00000000fffffe01 RDI: =
ffff9c58e966b840
>>> [43040.200871] RBP: ffff9c5fafde4f08 R08: ffff9c5fafde4f08 R09: =
0000000000000001
>>> [43040.201044] R10: 00000000000286e0 R11: 0000000000000001 R12: =
ffff9c58e966b800
>>> [43040.201255] R13: ffff9c58e966b868 R14: ffff9c5fafde4f08 R15: =
000000008f5de42b
>>> [43040.201439] FS:  0000000000000000(0000) GS:ffff9c5fafdc0000(0000) =
knlGS:0000000000000000
>>> [43040.201642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [43040.201799] CR2: 00007f1401217714 CR3: 0000000464b94003 CR4: =
00000000001706e0
>>> [43040.201994] Call Trace:
>>> [43040.202095]  <IRQ>
>>> [43040.202187] ? __warn (kernel/panic.c:235 kernel/panic.c:673)
>>> [43040.202301] ? report_bug (lib/bug.c:180 lib/bug.c:219)
>>> [43040.202418] ? handle_bug (arch/x86/kernel/traps.c:237)
>>> [43040.202534] ? exc_invalid_op (arch/x86/kernel/traps.c:258 =
(discriminator 1))
>>> [43040.202652] ? asm_exc_invalid_op =
(./arch/x86/include/asm/idtentry.h:568)
>>> [43040.202781] ? rcuref_put_slowpath (lib/rcuref.c:294 =
(discriminator 1))
>>> [43040.202909] dst_release (net/core/dst.c:166 (discriminator 1))
>>> [43040.203026] rt_cache_route (net/ipv4/route.c:1499)
>>> [43040.203143] rt_set_nexthop.isra.0 (net/ipv4/route.c:1606 =
(discriminator 1))
>>> [43040.203272] ip_route_input_slow (./include/net/lwtunnel.h:140 =
net/ipv4/route.c:1875 net/ipv4/route.c:2154 net/ipv4/route.c:2337)
>>> [43040.203401] ? nf_conntrack_udp_packet =
(net/netfilter/nf_conntrack_proto_udp.c:124) nf_conntrack
>>> [43040.203581] ip_route_input_noref (net/ipv4/route.c:2499)
>>> [43040.203704] ip_rcv_finish_core.isra.0 (net/ipv4/ip_input.c:367 =
(discriminator 1))
>>> [43040.203855] ip_rcv (net/ipv4/ip_input.c:448 =
./include/linux/netfilter.h:304 ./include/linux/netfilter.h:298 =
net/ipv4/ip_input.c:569)
>>> [43040.203962] ? ip_rcv_core (net/ipv4/ip_input.c:436)
>>> [43040.204079] process_backlog (net/core/dev.c:5997)
>>> [43040.204201] __napi_poll (net/core/dev.c:6556)
>>> [43040.204315] net_rx_action (net/core/dev.c:6625 =
net/core/dev.c:6756)
>>> [43040.204432] __do_softirq (./arch/x86/include/asm/preempt.h:27 =
kernel/softirq.c:564)
>>> [43040.204549] irq_exit_rcu (kernel/softirq.c:436 =
kernel/softirq.c:641 kernel/softirq.c:653)
>>> [43040.204667] common_interrupt (arch/x86/kernel/irq.c:247 =
(discriminator 47))
>>> [43040.204786]  </IRQ>
>>> [43040.204876]  <TASK>
>>> [43040.204965] asm_common_interrupt =
(./arch/x86/include/asm/idtentry.h:640)
>>> [43040.205090] RIP: 0010:acpi_safe_halt =
(./arch/x86/include/asm/irqflags.h:37 =
./arch/x86/include/asm/irqflags.h:72 drivers/acpi/processor_idle.c:113)
>>> [43040.205220] Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 =
48 8b 04 25 40 32 02 00 48 8b 00 a8 08 75 0c eb 07 0f 00 2d 57 0f 2c 00 =
fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb =
9f
>>> All code
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>> 0: ed                    in     (%dx),%eax
>>> 1: c3                    ret
>>> 2: 66 66 2e 0f 1f 84 00 data16 cs nopw 0x0(%rax,%rax,1)
>>> 9: 00 00 00 00
>>> d: 66 90                 xchg   %ax,%ax
>>> f: 65 48 8b 04 25 40 32 mov    %gs:0x23240,%rax
>>> 16: 02 00
>>> 18: 48 8b 00              mov    (%rax),%rax
>>> 1b: a8 08                 test   $0x8,%al
>>> 1d: 75 0c                 jne    0x2b
>>> 1f: eb 07                 jmp    0x28
>>> 21: 0f 00 2d 57 0f 2c 00 verw   0x2c0f57(%rip)        # 0x2c0f7f
>>> 28: fb                    sti
>>> 29: f4                    hlt
>>> 2a:* fa                    cli     <-- trapping instruction
>>> 2b: c3                    ret
>>> 2c: 0f 1f 00              nopl   (%rax)
>>> 2f: 0f b6 47 08           movzbl 0x8(%rdi),%eax
>>> 33: 3c 01                 cmp    $0x1,%al
>>> 35: 74 0b                 je     0x42
>>> 37: 3c 02                 cmp    $0x2,%al
>>> 39: 74 05                 je     0x40
>>> 3b: 8b 7f 04              mov    0x4(%rdi),%edi
>>> 3e: eb 9f                 jmp    0xffffffffffffffdf
>>>=20
>>> Code starting with the faulting instruction
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> 0: fa                    cli
>>> 1: c3                    ret
>>> 2: 0f 1f 00              nopl   (%rax)
>>> 5: 0f b6 47 08           movzbl 0x8(%rdi),%eax
>>> 9: 3c 01                 cmp    $0x1,%al
>>> b: 74 0b                 je     0x18
>>> d: 3c 02                 cmp    $0x2,%al
>>> f: 74 05                 je     0x16
>>> 11: 8b 7f 04              mov    0x4(%rdi),%edi
>>> 14: eb 9f                 jmp    0xffffffffffffffb5
>>> [43040.205578] RSP: 0018:ffffa39d8234fe80 EFLAGS: 00000246
>>> [43040.205718] RAX: 0000000000004000 RBX: 0000000000000001 RCX: =
000000000000001f
>>> [43040.205890] RDX: ffff9c5fafdc0000 RSI: ffff9c5882e95800 RDI: =
ffff9c5882e95864
>>> [43040.206063] RBP: ffffffffa9216ea0 R08: ffffffffa9216ea0 R09: =
0000000000000003
>>> [43040.206246] R10: 0000000000000002 R11: 0000000000000008 R12: =
0000000000000001
>>> [43040.206419] R13: ffffffffa9216f08 R14: ffffffffa9216f20 R15: =
0000000000000000
>>> [43040.206593] acpi_idle_enter (drivers/acpi/processor_idle.c:709)
>>> [43040.206711] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:267)
>>> [43040.206835] cpuidle_enter (drivers/cpuidle/cpuidle.c:390 =
(discriminator 2))
>>> [43040.206954] do_idle (kernel/sched/idle.c:134 =
kernel/sched/idle.c:215 kernel/sched/idle.c:282)
>>> [43040.207066] cpu_startup_entry (kernel/sched/idle.c:379)
>>> [43040.207188] start_secondary (arch/x86/kernel/smpboot.c:326)
>>> [43040.207310] secondary_startup_64_no_verify =
(arch/x86/kernel/head_64.S:433)
>>> [43040.207451]  </TASK>
>>> [43040.207542] ---[ end trace 0000000000000000 ]---
>>>=20
>>>> On 19 Dec 2023, at 16:26, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>>>>=20
>>>> On Tue, Dec 19 2023 at 11:25, Martin Zaharinov wrote:
>>>>>> On 12 Dec 2023, at 20:16, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>>>>>> Btw, how easy is this to reproduce?
>>>>>=20
>>>>> Its not easy this report is generate on machine with 5-6k users , =
with
>>>>> traffic and one time is show on 1 day , other show after 4-5 =
days=E2=80=A6
>>>>=20
>>>> I love those bugs ...
>>>>=20
>>>>> Apply this patch and will upload image on one machine as fast as
>>>>> possible and when get any reports will send you.
>>>>=20
>>>> Let's see how that goes!
>>>>=20
>>>> Thanks,
>>>>=20
>>>>     tglx
>>>=20
>>=20
>=20


