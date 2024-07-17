Return-Path: <netdev+bounces-111867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72420933C71
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D68F280E17
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88317F4F8;
	Wed, 17 Jul 2024 11:41:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659017F393
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216471; cv=none; b=VbCsiNqc7mdvx3lhwt/CLtirY/QmmihGv4KX0+G4b8v3RCc04XG9JdNp3FE1zXzjMwKtAEkA78jPZwfrCgYO1jnzdIaJzZp/HQMQFBwGcUYJIgHEsyIoa9edTlj9kei6Vigf06mYxyvRXVOD8u0T53enYiR7DB/PfoM1vZ92+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216471; c=relaxed/simple;
	bh=254uTCexr8uBQUhTS9ihtiQnrnVS43RCSF0LUxuBca0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dmc/FslDjISn+eD3qD1xnhk30L0pDZNgreyA/hvmsTaQmaRhhQwCXb0uy8+lMGeiwTlZaChuH1xOOOgF/uqynf3bUjL90t97FaLFiVCqhoULtxnp0uB51WwRQNu8LkEjCZ/JpERnXbSBTBDE6ilQmFhQF2suyF2qnmmlvbbwZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-595850e7e11so8040612a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 04:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721216467; x=1721821267;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nso0uLJ7OLUk8v92VinPBJkzOdpthduBLUQS8qHHmD8=;
        b=i3tQIBAfkA+7t5tV4xp8XiDJJVB92mwmaDsBZ+WHMrkbgEL4eDDQeoe3L8+Q1Qr1Xd
         6fIKXot8Hv+pFlIzd57mmYQ/M1+kGldN5a/FIyj56LpzPPxprBOGoec3fxRt3PP9kCCi
         IKhZLd5cZMBoy/XxqRH4E4kgDtE00s5A4ozVHLw7kecyjkDaDuSazFDwXBQycsKSb//p
         Vl3Oyt83T19FoF0l2kvSyWhhcPiTRqzHtTBibOAbU5YsmK7vljtMOji3Hrp8KDpBH2tf
         Ok8/LUqlo3BFWVVThK3aTHqAjkbdVG52APgLtrl7G+boLjyQnUorJce63rWdFFD5afVx
         GnNg==
X-Gm-Message-State: AOJu0YyVmrGQhxudplLPX0OvTmyrBu/2cugmvvmwj0eboZ2tZlx4p9Qr
	w+0j4m+PdqcO3BHbMJu1U/B5lZ2MnC6WZcjOSac7ThF+pf0Bcg6pRY59nA==
X-Google-Smtp-Source: AGHT+IGhtbSpTlKh2P3f9gj2bJCmhQc4Urr1p0WAQif4bycO30e7kAuQjQ1ePVQYsviLAGRnu9mtxg==
X-Received: by 2002:a17:906:7f0d:b0:a77:e7cb:2979 with SMTP id a640c23a62f3a-a7a0130e68amr100596866b.51.1721216466784;
        Wed, 17 Jul 2024 04:41:06 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-112.fbsv.net. [2a03:2880:30ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5d2040sm436523566b.84.2024.07.17.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 04:41:06 -0700 (PDT)
Date: Wed, 17 Jul 2024 04:41:04 -0700
From: Breno Leitao <leitao@debian.org>
To: saeedm@nvidia.com, tariqt@nvidia.com
Cc: netdev@vger.kernel.org
Subject: mlx5e warnings on 6.10
Message-ID: <Zpet0KnLyqgoPsJ4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am seeing the following warning in 6.10
(0c3836482481200ead7b416ca80c68a29cfdaabd) in some hosts we have with
6.10.

This kernel was built with some debug options enabled (lockdep, kasamn,
kmemleak, etc) and it is slower than usual.

Sharing in case you find it useful.

	mlx5_core 0000:01:00.0 eth0: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 15535 ms
	mlx5_core 0000:01:00.0 eth0: TX timeout detected
	mlx5_core 0000:01:00.0 eth0: TX timeout on queue: 0, SQ: 0x2e9, CQ: 0xa5, SQ Cons: 0x22ee SQ Prod: 0x3290, usecs since last trans: 15570000
	mlx5_core 0000:01:00.0 eth0: EQ 0x7: Cons = 0x56838, irqn = 0x67
	------------[ cut here ]------------
	WARNING: CPU: 15 PID: 48322 at drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:78 mlx5e_selq_prepare_params (drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:78)
	Modules linked in: sunrpc(E) veth(E) bpf_preload(E) sch_fq(E) squashfs(E) tls(E) act_gact(E) cls_bpf(E) tcp_diag(E) inet_diag(E) kvm_amd(E) kvm(E) mlx5_ib(E) ib_uverbs(E) acpi_cpufreq(E) ccp(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) evdev(E) button(E) sch_fq_codel(E) vhost_net(E) tun(E) vhost(E) vhost_iotlb(E) tap(E) mpls_gso(E) mpls_iptunnel(E) mpls_router(E) fou(E) amd_hsmp(E) loop(E) drm(E) backlight(E) drm_panel_orientation_quirks(E) autofs4(E) efivarfs(E)
	Hardware name: Wiwynn HalfDome/HalfDome MP, BIOS HD404.sign 09/22/2023
	Workqueue: mlx5e mlx5e_tx_timeout_work
	RIP: 0010:mlx5e_selq_prepare_params (drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:78)
	Code: 05 18 ef 4d 03 01 48 c7 c7 c0 52 bb 84 be 54 00 00 00 48 c7 c2 00 53 bb 84 e8 f7 e5 d2 fd e9 34 fe ff ff 0f 0b e9 e0 fd ff ff <0f> 0b e9 b7 fd ff ff 48 c7 c1 cc 3e ba 86 80 e1 07 80 c1 03 38 c1
	All code
	========
	   0:   05 18 ef 4d 03          add    $0x34def18,%eax
	   5:   01 48 c7                add    %ecx,-0x39(%rax)
	   8:   c7 c0 52 bb 84 be       mov    $0xbe84bb52,%eax
	   e:   54                      push   %rsp
	   f:   00 00                   add    %al,(%rax)
	  11:   00 48 c7                add    %cl,-0x39(%rax)
	  14:   c2 00 53                ret    $0x5300
	  17:   bb 84 e8 f7 e5          mov    $0xe5f7e884,%ebx
	  1c:   d2 fd                   sar    %cl,%ch
	  1e:   e9 34 fe ff ff          jmp    0xfffffffffffffe57
	  23:   0f 0b                   ud2
	  25:   e9 e0 fd ff ff          jmp    0xfffffffffffffe0a
	  2a:*  0f 0b                   ud2             <-- trapping instruction
	  2c:   e9 b7 fd ff ff          jmp    0xfffffffffffffde8
	  31:   48 c7 c1 cc 3e ba 86    mov    $0xffffffff86ba3ecc,%rcx
	  38:   80 e1 07                and    $0x7,%cl
	  3b:   80 c1 03                add    $0x3,%cl
	  3e:   38 c1                   cmp    %al,%cl

	Code starting with the faulting instruction
	===========================================
	   0:   0f 0b                   ud2
	   2:   e9 b7 fd ff ff          jmp    0xfffffffffffffdbe
	   7:   48 c7 c1 cc 3e ba 86    mov    $0xffffffff86ba3ecc,%rcx
	   e:   80 e1 07                and    $0x7,%cl
	  11:   80 c1 03                add    $0x3,%cl
	  14:   38 c1                   cmp    %al,%cl
	RSP: 0018:ffff8883d45877b0 EFLAGS: 00010246
	RAX: 0000000000000000 RBX: ffff8882d3050a90 RCX: 0000000000000000
	RDX: 0000000000000160 RSI: ffffffff846c5900 RDI: ffffffff8495f700
	RBP: ffff8882d3050af0 R08: ffff8888c7cc0177 R09: 1ffff11118f9802e
	R10: dffffc0000000000 R11: ffffed1118f9802f R12: dffffc0000000000
	R13: ffff8882d3050a80 R14: ffff8888c7cc0018 R15: ffff8882d3050a80
	FS:  0000000000000000(0000) GS:ffff88bee8780000(0000) knlGS:0000000000000000
	CR2: 00007f33afc33000 CR3: 00000004df52c001 CR4: 0000000000770ef0
	PKRU: 55555554
	Call Trace:
	<TASK>
	? __warn (kernel/panic.c:239 kernel/panic.c:693)
	? mlx5e_selq_prepare_params (drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:78)
	? mlx5e_selq_prepare_params (drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:78)
	? report_bug (lib/bug.c:? lib/bug.c:219)
	? handle_bug (arch/x86/kernel/traps.c:239)
	? exc_invalid_op (arch/x86/kernel/traps.c:260)
	? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
	? mlx5e_selq_prepare_params (drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:78)
	mlx5e_safe_switch_params (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:3275)
	? mark_lock (./arch/x86/include/asm/bitops.h:227 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:4656)
	? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:26 ./arch/x86/include/asm/irqflags.h:67 ./arch/x86/include/asm/irqflags.h:127 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
	? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)
	? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:103 ./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
	? __irq_put_desc_unlock (kernel/irq/irqdesc.c:908)
	? enable_irq (kernel/irq/internals.h:?)
	? mlx5_eq_poll_irq_disabled (drivers/net/ethernet/mellanox/mlx5/core/eq.c:171)
	? mlx5e_health_channel_eq_recover (drivers/net/ethernet/mellanox/mlx5/core/en/health.c:139)
	mlx5e_tx_reporter_timeout_recover (drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:?)
	devlink_health_report (net/devlink/health.c:539 net/devlink/health.c:639)
	mlx5e_reporter_tx_timeout (drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:?)
	? mlx5e_reporter_tx_timeout (drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:132)
	? mlx5e_tx_reporter_timeout_recover (drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:398)
	mlx5e_tx_timeout_work (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:4943)
	? process_scheduled_works (kernel/workqueue.c:3224 kernel/workqueue.c:3329)
	process_scheduled_works (kernel/workqueue.c:? kernel/workqueue.c:3329)
	worker_thread (./include/linux/list.h:373 kernel/workqueue.c:947 kernel/workqueue.c:3410)
	kthread (kernel/kthread.c:390)
	? pr_cont_work (kernel/workqueue.c:3356)
	? kthread_blkcg (kernel/kthread.c:342)
	ret_from_fork (arch/x86/kernel/process.c:153)
	? kthread_blkcg (kernel/kthread.c:342)
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
	</TASK>
	irq event stamp: 843317
	hardirqs last enabled at (843331): console_unlock (./arch/x86/include/asm/irqflags.h:26 ./arch/x86/include/asm/irqflags.h:67 ./arch/x86/include/asm/irqflags.h:127 kernel/printk/printk.c:341 kernel/printk/printk.c:2731 kernel/printk/printk.c:3050)
	hardirqs last disabled at (843346): console_unlock (kernel/printk/printk.c:339 kernel/printk/printk.c:2731 kernel/printk/printk.c:3050)
	softirqs last enabled at (843360): __irq_exit_rcu (kernel/softirq.c:617 kernel/softirq.c:639)
	softirqs last disabled at (843355): __irq_exit_rcu (kernel/softirq.c:617 kernel/softirq.c:639)
	---[ end trace 0000000000000000 ]---

	=============================
	WARNING: suspicious RCU usage
	6.10.0-0_fbk700_debug_rc0_kbuilder_7_gcce2edc9a03a #1 Tainted: G S      W   EL   N
	-----------------------------
	drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:84 suspicious rcu_dereference_protected() usage!

	other info that might help us debug this:


	rcu_scheduler_active = 2, debug_locks = 1
	4 locks held by kworker/u704:0/48322:
	#0: ffff8882d2a6e948 ((wq_completion)mlx5e){+.+.}-{0:0}, at: process_scheduled_works (kernel/workqueue.c:3223 kernel/workqueue.c:3329)
	#1: ffff8883d4587d68 ((work_completion)(&priv->tx_timeout_work)){+.+.}-{0:0}, at: process_scheduled_works (kernel/workqueue.c:3224 kernel/workqueue.c:3329)
	#2: ffffffff86a75e08 (rtnl_mutex){+.+.}-{3:3}, at: mlx5e_tx_timeout_work (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:4926)
	#3: ffff8882d2a61250 (&devlink->lock_key#2){+.+.}-{3:3}, at: devlink_health_report (net/devlink/health.c:?)

	stack backtrace:
	Hardware name: Wiwynn HalfDome/HalfDome MP, BIOS HD404.sign 09/22/2023
	Workqueue: mlx5e mlx5e_tx_timeout_work
	Call Trace:
	<TASK>
	dump_stack_lvl (lib/dump_stack.c:116)
	lockdep_rcu_suspicious (./include/linux/context_tracking.h:122 ./include/linux/context_tracking.h:143 kernel/locking/lockdep.c:6672)
	mlx5e_selq_prepare_params (drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:?)
	mlx5e_safe_switch_params (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:3275)
	? mark_lock (./arch/x86/include/asm/bitops.h:227 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228 kernel/locking/lockdep.c:4656)
	? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:26 ./arch/x86/include/asm/irqflags.h:67 ./arch/x86/include/asm/irqflags.h:127 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
	? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421)
	? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:103 ./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
	? __irq_put_desc_unlock (kernel/irq/irqdesc.c:908)
	? enable_irq (kernel/irq/internals.h:?)
	? mlx5_eq_poll_irq_disabled (drivers/net/ethernet/mellanox/mlx5/core/eq.c:171)
	? mlx5e_health_channel_eq_recover (drivers/net/ethernet/mellanox/mlx5/core/en/health.c:139)
	mlx5e_tx_reporter_timeout_recover (drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:?)
	devlink_health_report (net/devlink/health.c:539 net/devlink/health.c:639)
	mlx5e_reporter_tx_timeout (drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:?)
	? mlx5e_reporter_tx_timeout (drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:132)
	? mlx5e_tx_reporter_timeout_recover (drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:398)
	mlx5e_tx_timeout_work (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:4943)
	? process_scheduled_works (kernel/workqueue.c:3224 kernel/workqueue.c:3329)
	process_scheduled_works (kernel/workqueue.c:? kernel/workqueue.c:3329)
	worker_thread (./include/linux/list.h:373 kernel/workqueue.c:947 kernel/workqueue.c:3410)
	kthread (kernel/kthread.c:390)
	? pr_cont_work (kernel/workqueue.c:3356)
	? kthread_blkcg (kernel/kthread.c:342)
	ret_from_fork (arch/x86/kernel/process.c:153)
	? kthread_blkcg (kernel/kthread.c:342)
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
	</TASK>

