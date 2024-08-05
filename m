Return-Path: <netdev+bounces-115752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF0B947A86
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C801C20AE0
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696CB1537C9;
	Mon,  5 Aug 2024 11:42:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D09C18AED
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858133; cv=none; b=nqjzMh7CwbbANsVCcFrnj4PHDD4bH3htyiMYtNDorAhouHbtHgCqL6YzRq7FWqx8RdHWMn91Hm5XqOYey8eNbK8iXCJcMIotcDiiZcvOnPWQKpUaqOVtdhOqPqBPnLb17cFIkoxFgmlYEijHAFkJc9bEY1R6S0qg7xE3cAtNMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858133; c=relaxed/simple;
	bh=PGiCep6V+sFCRa1rc+dkrjkdbGH05i1/LLYI8QXrBl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZxkmGUBhOBpGHtocibvTc8066OHyM0dwh8+RkQ9uBoZIP+VcIMQUvx/wDTjIR7mrTC8/o9tpr966eXP7z1nzqXKWJm9dXtmIFV744h57Nj+FvoFLnavfu8BvWFGww/SLVLxv7VAp+Gffh2p7a7FnWYUKkNwMZyJcYZQeOZYEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efa9500e0so12153608e87.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 04:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722858129; x=1723462929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLdCDEohVCTmVu71TC00pwOHanBUFkHWw4nauVdKFr4=;
        b=fw5ecm0QxhRfgnBs6kZp49dIsyNVx8xfcCmhPKizmIZc94xPyAhmu3pcEG2NxRJaU4
         678C63kWDuaKcKZaR54gJozNm/SvUVizogp8eiBxyw3/vdSziR1Y7bdbvaJD4NT2KdKY
         9SWfYl/zEaiI+EuKSr9xTDIfbEWeD4ws0jUNoAxgC5rGVJIL4jg+p8aKLGwlm2yf0HD1
         IOQjDWlnU3ylPcvcQKYpRcy/br9ZoBlojWMHbyyVOQh5t3Glx5W9tW1t10Uuh74mAfM3
         g5UR9KJiQ0RdsddKO5NsD0PzJek8MIMSOsUJYc/uZMRVK7vkJDHFTKc08BQo/F3pFWnf
         S+4g==
X-Forwarded-Encrypted: i=1; AJvYcCWreHiH7Ikwkd7ImHXvIWlJ1elyk2YHM8bf5sxA771q4cZyZV/UqVPFUNj1iiLbyo96XiiHqquCoMMZhi7Qzb5qFDS16fSV
X-Gm-Message-State: AOJu0YzKJau06mJbYD/k58jT1v/DmRXdyOtuzqjz2H5wAZsTf7H7kkOD
	GaBwhsC1xXrD3zovSl9fayK0MWHc97WSR4OZVvQVk17VRpLGP5i4
X-Google-Smtp-Source: AGHT+IENjpFJY4ba5Q6qJgUzvWi8Eq1UcnnvHmNUJwUnaKahwXczoqTgdKgw6QpLYoQrQKNov1MH2g==
X-Received: by 2002:a05:6512:6d0:b0:52e:933c:5a18 with SMTP id 2adb3069b0e04-530bb3b1871mr7699484e87.56.1722858128962;
        Mon, 05 Aug 2024 04:42:08 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c61785sm442845466b.91.2024.08.05.04.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:42:08 -0700 (PDT)
Date: Mon, 5 Aug 2024 04:42:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net] bnxt: fix crashes when reducing ring count with
 active RSS contexts
Message-ID: <ZrC6jpghA3PWVWSB@gmail.com>
References: <20240705020005.681746-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705020005.681746-1-kuba@kernel.org>

Hello,

On Thu, Jul 04, 2024 at 07:00:05PM -0700, Jakub Kicinski wrote:
> bnxt doesn't check if a ring is used by RSS contexts when reducing
> ring count. Core performs a similar check for the drivers for
> the main context, but core doesn't know about additional contexts,
> so it can't validate them. bnxt_fill_hw_rss_tbl_p5() uses ring
> id to index bp->rx_ring, which without the check may end up
> being out of bounds.
> 
>   BUG: KASAN: slab-out-of-bounds in __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
>   Read of size 2 at addr ffff8881c5809618 by task ethtool/31525
>   Call Trace:
>   __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
>    bnxt_hwrm_vnic_rss_cfg_p5+0xf7/0x460
>    __bnxt_setup_vnic_p5+0x12e/0x270
>    __bnxt_open_nic+0x2262/0x2f30
>    bnxt_open_nic+0x5d/0xf0
>    ethnl_set_channels+0x5d4/0xb30
>    ethnl_default_set_doit+0x2f1/0x620

I have this patch applied to my tree, and I am still finding a very
similar KASAN report in the last net-next/main tree - commit
3608d6aca5e793958462e6e01a8cdb6c6e8088d0 ("Merge branch 'dsa-en7581'
into main")

Skimmer over the code, In bnxt_fill_hw_rss_tbl(), bp->rss_indir_tbl[i]
returns 8, but, vnic->fw_grp_id size is 8, thus, it tries to access over
the last element (7).

Somehow bp->rss_indir_tbl[i] goes beynd rx_nr_rings.

--breno


	 ==================================================================
	 BUG: KASAN: slab-out-of-bounds in __bnxt_hwrm_vnic_set_rss (drivers/net/ethernet/broadcom/bnxt/bnxt.c:6307 drivers/net/ethernet/broadcom/bnxt/bnxt.c:6347)
	 Read of size 2 at addr ffff88812c518f90 by task (udev-worker)/794

	 Call Trace:
	  <TASK>
	 dump_stack_lvl (lib/dump_stack.c:122)
	 print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
	 ? __virt_addr_valid (./arch/x86/include/asm/preempt.h:103 ./include/linux/rcupdate.h:953 ./include/linux/mmzone.h:2034 arch/x86/mm/physaddr.c:65)
	 ? __bnxt_hwrm_vnic_set_rss (drivers/net/ethernet/broadcom/bnxt/bnxt.c:6307 drivers/net/ethernet/broadcom/bnxt/bnxt.c:6347)
	 kasan_report (mm/kasan/report.c:603)
	 ? __bnxt_hwrm_vnic_set_rss (drivers/net/ethernet/broadcom/bnxt/bnxt.c:6307 drivers/net/ethernet/broadcom/bnxt/bnxt.c:6347)
	 __bnxt_hwrm_vnic_set_rss (drivers/net/ethernet/broadcom/bnxt/bnxt.c:6307 drivers/net/ethernet/broadcom/bnxt/bnxt.c:6347)
	 ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
	 bnxt_hwrm_vnic_set_rss.part.0 (drivers/net/ethernet/broadcom/bnxt/bnxt.c:6379)
	 ? __bnxt_hwrm_vnic_set_rss (drivers/net/ethernet/broadcom/bnxt/bnxt.c:6364)
	 ? __bnxt_setup_vnic (drivers/net/ethernet/broadcom/bnxt/bnxt.c:6624)
	 __bnxt_setup_vnic (drivers/net/ethernet/broadcom/bnxt/bnxt.c:10073)
	 bnxt_init_nic (drivers/net/ethernet/broadcom/bnxt/bnxt.c:10144 drivers/net/ethernet/broadcom/bnxt/bnxt.c:10336 drivers/net/ethernet/broadcom/bnxt/bnxt.c:10432)
	 ? bnxt_alloc_and_setup_vnic (drivers/net/ethernet/broadcom/bnxt/bnxt.c:10425)
	 ? __irq_apply_affinity_hint (kernel/irq/manage.c:471 kernel/irq/manage.c:516)
	 ? irq_set_affinity_locked (kernel/irq/manage.c:507)
	 ? alloc_cpumask_var_node (lib/cpumask.c:62)
	 __bnxt_open_nic (drivers/net/ethernet/broadcom/bnxt/bnxt.c:12103)
	 ? __netdev_update_features (net/core/dev.c:10116)
	 ? bnxt_init_one (drivers/net/ethernet/broadcom/bnxt/bnxt.c:12064)
	 ? __bnxt_close_nic.constprop.0 (drivers/net/ethernet/broadcom/bnxt/bnxt.c:10918 drivers/net/ethernet/broadcom/bnxt/bnxt.c:12323)
	 ? bnxt_set_channels (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/netdevice.h:3588 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c:1003)
	 bnxt_open_nic (drivers/net/ethernet/broadcom/bnxt/bnxt.c:12179)
	 ethtool_set_channels (net/ethtool/ioctl.c:2117)
	 ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4995)
	 ? ethtool_set_settings (net/ethtool/ioctl.c:2065)
	 ? security_capable (security/security.c:1036 (discriminator 13))
	 __dev_ethtool (net/ethtool/ioctl.c:3275)
	 ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:673)
	 ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24)
	 ? ethtool_get_module_info_call (net/ethtool/ioctl.c:3044)
	 ? __lock_acquire (./arch/x86/include/asm/bitops.h:227 ./arch/x86/include/asm/bitops.h:239 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:227 kernel/locking/lockdep.c:3780 kernel/locking/lockdep.c:3836 kernel/locking/lockdep.c:5142)
	 ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4995)
	 ? stack_trace_save (kernel/stacktrace.c:123)
	 ? lock_acquire (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:5761 kernel/locking/lockdep.c:5724)
	 ? lock_sync (kernel/locking/lockdep.c:5727)
	 ? __kasan_kmalloc (mm/kasan/common.c:391)
	 ? dev_ethtool (net/ethtool/ioctl.c:3351)
	 ? dev_ioctl (net/core/dev_ioctl.c:721)
	 ? sock_ioctl (net/socket.c:1344)
	 ? rcu_is_watching (./include/linux/context_tracking.h:122 kernel/rcu/tree.c:726)
	 ? trace_contention_end (./include/trace/events/lock.h:122 (discriminator 52))
	 ? __mutex_lock (./arch/x86/include/asm/preempt.h:103 kernel/locking/mutex.c:618 kernel/locking/mutex.c:752)
	 ? lock_downgrade (kernel/locking/lockdep.c:5767)
	 ? dev_ethtool (net/ethtool/ioctl.c:3365)
	 ? sock_do_ioctl (net/socket.c:1237)
	 ? mutex_lock_io_nested (kernel/locking/mutex.c:751)
	 ? _raw_spin_unlock_irqrestore (./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
	 ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:103 ./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
	 ? rcu_is_watching (./include/linux/context_tracking.h:122 kernel/rcu/tree.c:726)
	 ? trace_kmalloc (./include/trace/events/kmem.h:54 (discriminator 52))
	 ? __kmalloc_cache_noprof (./include/linux/kasan.h:211 mm/slub.c:4189)
	 dev_ethtool (net/ethtool/ioctl.c:3365)
	 ? __dev_ethtool (net/ethtool/ioctl.c:3342)
	 dev_ioctl (net/core/dev_ioctl.c:721)
	 sock_do_ioctl (net/socket.c:1237)
	 ? put_user_ifreq (net/socket.c:1214)
	 ? find_held_lock (kernel/locking/lockdep.c:5249)
	 sock_ioctl (net/socket.c:1344)
	 ? br_ioctl_call (net/socket.c:1250)
	 ? seccomp_notify_ioctl (kernel/seccomp.c:1218)
	 ? ktime_get_coarse_real_ts64 (./include/linux/seqlock.h:74 kernel/time/timekeeping.c:2390)
	 ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4420)
	 __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:907 fs/ioctl.c:893 fs/ioctl.c:893)
	 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
	 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
	 RIP: 0033:0x7fab3150357b
	 Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 68 0f 00 f7 d8 64 89 01 48
	All code
	========
	   0:   ff                      (bad)
	   1:   ff                      (bad)
	   2:   ff 85 c0 79 9b 49       incl   0x499b79c0(%rbp)
	   8:   c7 c4 ff ff ff ff       mov    $0xffffffff,%esp
	   e:   5b                      pop    %rbx
	   f:   5d                      pop    %rbp
	  10:   4c 89 e0                mov    %r12,%rax
	  13:   41 5c                   pop    %r12
	  15:   c3                      ret
	  16:   66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
	  1d:   00 00
	  1f:   f3 0f 1e fa             endbr64
	  23:   b8 10 00 00 00          mov    $0x10,%eax
	  28:   0f 05                   syscall
	  2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <-- trapping instruction
	  30:   73 01                   jae    0x33
	  32:   c3                      ret
	  33:   48 8b 0d 75 68 0f 00    mov    0xf6875(%rip),%rcx        # 0xf68af
	  3a:   f7 d8                   neg    %eax
	  3c:   64 89 01                mov    %eax,%fs:(%rcx)
	  3f:   48                      rex.W

	Code starting with the faulting instruction
	===========================================
	   0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
	   6:   73 01                   jae    0x9
	   8:   c3                      ret
	   9:   48 8b 0d 75 68 0f 00    mov    0xf6875(%rip),%rcx        # 0xf6885
	  10:   f7 d8                   neg    %eax
	  12:   64 89 01                mov    %eax,%fs:(%rcx)
	  15:   48                      rex.W
	 RSP: 002b:00007ffe53677a28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	 RAX: ffffffffffffffda RBX: 000055b5a1868cd8 RCX: 00007fab3150357b
	 RDX: 00007ffe53677a60 RSI: 0000000000008946 RDI: 000000000000001f
	 RBP: 00007ffe53677ab0 R08: 0000000000000000 R09: 0000000000000000
	 R10: 000055b5a18c9110 R11: 0000000000000246 R12: 000055b5a18c0ca0
	 R13: 000055b5a1866d18 R14: 00007ffe53677a60 R15: 000055b5a18becb0
	  </TASK>

	 Allocated by task 794:
	 kasan_save_stack (mm/kasan/common.c:48)
	 kasan_save_track (./arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69)
	 __kasan_kmalloc (mm/kasan/common.c:391)
	 __kmalloc_noprof (mm/slub.c:4159 mm/slub.c:4170)
	 bnxt_alloc_mem (drivers/net/ethernet/broadcom/bnxt/bnxt.c:4696 drivers/net/ethernet/broadcom/bnxt/bnxt.c:5323)
	 __bnxt_open_nic (drivers/net/ethernet/broadcom/bnxt/bnxt.c:12088)
	 bnxt_open_nic (drivers/net/ethernet/broadcom/bnxt/bnxt.c:12179)
	 ethtool_set_channels (net/ethtool/ioctl.c:2117)
	 __dev_ethtool (net/ethtool/ioctl.c:3275)
	 dev_ethtool (net/ethtool/ioctl.c:3365)
	 dev_ioctl (net/core/dev_ioctl.c:721)
	 sock_do_ioctl (net/socket.c:1237)
	 sock_ioctl (net/socket.c:1344)
	 __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:907 fs/ioctl.c:893 fs/ioctl.c:893)
	 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
	 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

	 The buggy address belongs to the object at ffff88812c518f80
	which belongs to the cache kmalloc-16 of size 16
	 The buggy address is located 0 bytes to the right of
	allocated 16-byte region [ffff88812c518f80, ffff88812c518f90)

	 The buggy address belongs to the physical page:
	 page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12c518
	 anon flags: 0x5ffff0000000000(node=0|zone=2|lastcpupid=0x1ffff)
	 page_type: 0xfdffffff(slab)
	 raw: 05ffff0000000000 ffff88810004c640 0000000000000000 0000000000000001
	 raw: 0000000000000000 0000000080800080 00000001fdffffff 0000000000000000
	 page dumped because: kasan: bad access detected

	 Memory state around the buggy address:
	  ffff88812c518e80: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
	  ffff88812c518f00: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
	 >ffff88812c518f80: 00 00 fc fc 00 00 fc fc 00 01 fc fc fa fb fc fc
				  ^
	  ffff88812c519000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	  ffff88812c519080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	 ==================================================================


