Return-Path: <netdev+bounces-131644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9DF98F1E0
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01F2B22F16
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248C1A073C;
	Thu,  3 Oct 2024 14:51:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C21A073F;
	Thu,  3 Oct 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967088; cv=none; b=iUQ0qW+E2zsxyL+l2E7G9MUxo5dFrW6Kpm3Twf89P+fKf4ft0q7gRZxpRGSOmlfJ+x8JXnGIFx4oqdPdBT8HKwn3x6uRvDrrh8KBpJ1LWABdiH9xCuUs34wBDd5mZKfsTZseDw0oZG+F4KjXs8i6YO8Sn8yj5sSoRFsvIn3RLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967088; c=relaxed/simple;
	bh=mMWHqEzI5RUqImiCiL71OAj2kbPtTR/pYxBwLQaCjM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j4TAAvpoH5cSeSlcKG63ouQDE9UlNmJGBUHGyIAJYEOQWtxsJwzn9YKjOc82lAqtOfxUXkSRoczkLeY645MVeIrhlgAJi49lvp9moajQnL5seAUhUXwvp6IptVDrzELskL8cnydUIrTHIq3utFkSljur1N6ApygvXvA9SDPGRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso84698866b.3;
        Thu, 03 Oct 2024 07:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967085; x=1728571885;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyjUgRSedfTXQK+ZkiMxukYWk3FkDdsMSbIXtv+nlds=;
        b=n/4xiY7xl7bokCZpOK2KT8dFwx4exHBBRRxaqFq/aRsRo24K9wsvRCOFvVv4tGaG8p
         rqAPdyKSquyaxe2+kOOSv8oqBjd6JABeHuKvj8yF2wWooNf43hSDwCn2L05nIGSbrKhe
         8Cr3Xp3haU4NPRlJ2N9BHdpD/iGj0lIoJdKdDiFM8sGc5sPcJTtRCkwzRbkFt/ZmK0Be
         lb6EtLmt8VSJ+bvhX9tsa0Q6VAq+sa1JRa7fZYljqDaW6zl2ZgX2tInlhr4Gm4eWn3ff
         jrX8Z40GwWraGRh0SdHeRV/r4NvB2SFMzEbwqK/oxBI9XQxovFw6o4PN2zabETAAgbDq
         Bysg==
X-Forwarded-Encrypted: i=1; AJvYcCVt+S6rXX6g9ppT8YXePDvLvRRS3fglc8LaHwBXViHJrwQ78j71+rzNohwHJLL+LxCR2KPCM1B6cLzb+cc=@vger.kernel.org, AJvYcCX6P4esttaVsfqu0VBypUvrxEKr00QF0PxYEHEa3w0/lPSlQ+WF23nxAKeSEqRVhFbtLgU4WQkZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzItyz6iJeO+Tsn26Ub3s7djDXXEceVNXztRxrLhctiOmTSMj8A
	8nPA/EaYGzUtn4NhBNtydBv0AFn277vhehM4UJzL/5F/Le6t523L
X-Google-Smtp-Source: AGHT+IEQVfTClPZL1c1oxe0N9X5Tm3XZVs8X5lqvQXhRkvimjjgZBuSFzwXvsoEb4D3Trv7bmEGpWA==
X-Received: by 2002:a05:6402:26d6:b0:5c4:2d14:c725 with SMTP id 4fb4d7f45d1cf-5c8b18b8cfamr7522586a12.2.1727967084486;
        Thu, 03 Oct 2024 07:51:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca3fc877sm787470a12.53.2024.10.03.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 07:51:24 -0700 (PDT)
Date: Thu, 3 Oct 2024 07:51:20 -0700
From: Breno Leitao <leitao@debian.org>
To: peterz@infradead.org, gregkh@linuxfoundation.org, pmladek@suse.com,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	kuba@kernel.org
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vschneid@redhat.com, axboe@kernel.dk
Subject: 6.12-rc1: Lockdep regression bissected (virtio-net/console/scheduler)
Message-ID: <20241003-savvy-efficient-locust-ae7bbc@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Upstream kernel (6.12-rc1) has a new lockdep splat, that I am sharing to
get more visibility:

	WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected

This is happening because the HARDIRQ-irq-unsafe "_xmit_ETHER#2" lock is
acquired in virtnet_poll_tx() while holding the HARDIRQ-irq-safe, and
lockdep doesn't like it much.

I've bisected the problem, and weirdly enough, this problem started to
show up after a unrelated(?) change in the scheduler:

	52e11f6df293e816a ("sched/fair: Implement delayed dequeue")

At this time, I have the impression that the commit above exposed the
problem that was there already.

Here is the full log, based on commit 7ec462100ef91 ("Merge tag
'pull-work.unaligned' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs")

	=====================================================
	WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
	6.12.0-rc1-kbuilder-00046-g7ec462100ef9-dirty #19 Not tainted
	-----------------------------------------------------
	swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
	ffff88810497c318 (_xmit_ETHER#2){+.-.}-{3:3}, at: virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 

	and this task is already holding:
	ffffffff82a83a88 (console_owner){-...}-{0:0}, at: console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	which would create a new lock dependency:
	 (console_owner){-...}-{0:0} -> (_xmit_ETHER#2){+.-.}-{3:3}

	but this new dependency connects a HARDIRQ-irq-safe lock:
	 (console_owner){-...}-{0:0}

	... which became HARDIRQ-irq-safe at:
	lock_acquire (kernel/locking/lockdep.c:5825) 
	console_flush_all (kernel/printk/printk.c:1905 kernel/printk/printk.c:3086 kernel/printk/printk.c:3180) 
	console_unlock (kernel/printk/printk.c:3239 kernel/printk/printk.c:3279) 
	wake_up_klogd_work_func (kernel/printk/printk.c:4466) 
	irq_work_run_list (kernel/irq_work.c:222 kernel/irq_work.c:252) 
	update_process_times (kernel/time/timer.c:2524) 
	tick_handle_periodic (kernel/time/tick-common.c:120) 
	__sysvec_apic_timer_interrupt (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1044) 
	sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1037 arch/x86/kernel/apic/apic.c:1037) 
	asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
	clear_page_erms (arch/x86/lib/clear_page_64.S:50) 
	alloc_pages_bulk_noprof (mm/page_alloc.c:? mm/page_alloc.c:4660) 
	__vmalloc_node_range_noprof (mm/vmalloc.c:? mm/vmalloc.c:3646 mm/vmalloc.c:3828) 
	dup_task_struct (kernel/fork.c:314 kernel/fork.c:1115) 
	copy_process (kernel/fork.c:2207) 
	kernel_clone (kernel/fork.c:2787) 
	kernel_thread (kernel/fork.c:2849) 
	kthreadd (kernel/kthread.c:414 kernel/kthread.c:765) 
	ret_from_fork (arch/x86/kernel/process.c:153) 
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 

	to a HARDIRQ-irq-unsafe lock:
	 (_xmit_ETHER#2){+.-.}-{3:3}

	... which became HARDIRQ-irq-unsafe at:
	...
	lock_acquire (kernel/locking/lockdep.c:5825) 
	_raw_spin_trylock (./include/linux/spinlock_api_smp.h:90 kernel/locking/spinlock.c:138) 
	virtnet_poll (./include/linux/spinlock.h:? ./include/linux/netdevice.h:4384 drivers/net/virtio_net.c:2768 drivers/net/virtio_net.c:2821) 
	__napi_poll (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/napi.h:14 net/core/dev.c:6772) 
	net_rx_action (net/core/dev.c:6842 net/core/dev.c:6962) 
	handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555) 
	do_softirq (kernel/softirq.c:455) 
	__local_bh_enable_ip (kernel/softirq.c:?) 
	virtnet_open (drivers/net/virtio_net.c:2877 drivers/net/virtio_net.c:2925) 
	__dev_open (net/core/dev.c:1476) 
	dev_open (net/core/dev.c:1513) 
	netpoll_setup (net/core/netpoll.c:701) 
	init_netconsole (drivers/net/netconsole.c:1261 drivers/net/netconsole.c:1312) 
	do_one_initcall (init/main.c:1269) 
	do_initcall_level (init/main.c:1330) 
	do_initcalls (init/main.c:1344) 
	kernel_init_freeable (init/main.c:1584) 
	kernel_init (init/main.c:1471) 
	ret_from_fork (arch/x86/kernel/process.c:153) 
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 

	other info that might help us debug this:

	 Possible interrupt unsafe locking scenario:

	       CPU0                    CPU1
	       ----                    ----
	  lock(_xmit_ETHER#2);
				       local_irq_disable();
				       lock(console_owner);
				       lock(_xmit_ETHER#2);
	  <Interrupt>
	    lock(console_owner);

	 *** DEADLOCK ***

	5 locks held by swapper/0/1:
	#0: ffffffff82a836b8 (console_mutex){+.+.}-{4:4}, at: register_console (kernel/printk/printk.c:113 kernel/printk/printk.c:3933) 
	#1: ffffffff82a83ab0 (console_lock){+.+.}-{0:0}, at: _printk (kernel/printk/printk.c:2435) 
	#2: ffffffff82a836f0 (console_srcu){....}-{0:0}, at: console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	#3: ffffffff82a83a88 (console_owner){-...}-{0:0}, at: console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	#4: ffffffff83183f80 (printk_legacy_map-wait-type-override){....}-{4:4}, at: console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 

	the dependencies between HARDIRQ-irq-safe lock and the holding lock:
	-> (console_owner){-...}-{0:0} ops: 2187 {
	   IN-HARDIRQ-W at:
	lock_acquire (kernel/locking/lockdep.c:5825) 
	console_flush_all (kernel/printk/printk.c:1905 kernel/printk/printk.c:3086 kernel/printk/printk.c:3180) 
	console_unlock (kernel/printk/printk.c:3239 kernel/printk/printk.c:3279) 
	wake_up_klogd_work_func (kernel/printk/printk.c:4466) 
	irq_work_run_list (kernel/irq_work.c:222 kernel/irq_work.c:252) 
	update_process_times (kernel/time/timer.c:2524) 
	tick_handle_periodic (kernel/time/tick-common.c:120) 
	__sysvec_apic_timer_interrupt (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1044) 
	sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1037 arch/x86/kernel/apic/apic.c:1037) 
	asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702) 
	clear_page_erms (arch/x86/lib/clear_page_64.S:50) 
	alloc_pages_bulk_noprof (mm/page_alloc.c:? mm/page_alloc.c:4660) 
	__vmalloc_node_range_noprof (mm/vmalloc.c:? mm/vmalloc.c:3646 mm/vmalloc.c:3828) 
	dup_task_struct (kernel/fork.c:314 kernel/fork.c:1115) 
	copy_process (kernel/fork.c:2207) 
	kernel_clone (kernel/fork.c:2787) 
	kernel_thread (kernel/fork.c:2849) 
	kthreadd (kernel/kthread.c:414 kernel/kthread.c:765) 
	ret_from_fork (arch/x86/kernel/process.c:153) 
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	   INITIAL USE at:
	 }
	... key at: console_owner_dep_map+0x0/0x28 

	the dependencies between the lock to be acquired
	 and HARDIRQ-irq-unsafe lock:
	-> (_xmit_ETHER#2){+.-.}-{3:3} ops: 5 {
	   HARDIRQ-ON-W at:
	lock_acquire (kernel/locking/lockdep.c:5825) 
	_raw_spin_trylock (./include/linux/spinlock_api_smp.h:90 kernel/locking/spinlock.c:138) 
	virtnet_poll (./include/linux/spinlock.h:? ./include/linux/netdevice.h:4384 drivers/net/virtio_net.c:2768 drivers/net/virtio_net.c:2821) 
	__napi_poll (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/napi.h:14 net/core/dev.c:6772) 
	net_rx_action (net/core/dev.c:6842 net/core/dev.c:6962) 
	handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555) 
	do_softirq (kernel/softirq.c:455) 
	__local_bh_enable_ip (kernel/softirq.c:?) 
	virtnet_open (drivers/net/virtio_net.c:2877 drivers/net/virtio_net.c:2925) 
	__dev_open (net/core/dev.c:1476) 
	dev_open (net/core/dev.c:1513) 
	netpoll_setup (net/core/netpoll.c:701) 
	init_netconsole (drivers/net/netconsole.c:1261 drivers/net/netconsole.c:1312) 
	do_one_initcall (init/main.c:1269) 
	do_initcall_level (init/main.c:1330) 
	do_initcalls (init/main.c:1344) 
	kernel_init_freeable (init/main.c:1584) 
	kernel_init (init/main.c:1471) 
	ret_from_fork (arch/x86/kernel/process.c:153) 
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	   IN-SOFTIRQ-W at:
	lock_acquire (kernel/locking/lockdep.c:5825) 
	_raw_spin_lock (./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
	virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	__napi_poll (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/napi.h:14 net/core/dev.c:6772) 
	net_rx_action (net/core/dev.c:6842 net/core/dev.c:6962) 
	handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555) 
	do_softirq (kernel/softirq.c:455) 
	__local_bh_enable_ip (kernel/softirq.c:?) 
	virtnet_open (drivers/net/virtio_net.c:2919) 
	__dev_open (net/core/dev.c:1476) 
	dev_open (net/core/dev.c:1513) 
	netpoll_setup (net/core/netpoll.c:701) 
	init_netconsole (drivers/net/netconsole.c:1261 drivers/net/netconsole.c:1312) 
	do_one_initcall (init/main.c:1269) 
	do_initcall_level (init/main.c:1330) 
	do_initcalls (init/main.c:1344) 
	kernel_init_freeable (init/main.c:1584) 
	kernel_init (init/main.c:1471) 
	ret_from_fork (arch/x86/kernel/process.c:153) 
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	   INITIAL USE at:
	lock_acquire (kernel/locking/lockdep.c:5825) 
	_raw_spin_trylock (./include/linux/spinlock_api_smp.h:90 kernel/locking/spinlock.c:138) 
	virtnet_poll (./include/linux/spinlock.h:? ./include/linux/netdevice.h:4384 drivers/net/virtio_net.c:2768 drivers/net/virtio_net.c:2821) 
	__napi_poll (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/napi.h:14 net/core/dev.c:6772) 
	net_rx_action (net/core/dev.c:6842 net/core/dev.c:6962) 
	handle_softirqs (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:555) 
	do_softirq (kernel/softirq.c:455) 
	__local_bh_enable_ip (kernel/softirq.c:?) 
	virtnet_open (drivers/net/virtio_net.c:2877 drivers/net/virtio_net.c:2925) 
	__dev_open (net/core/dev.c:1476) 
	dev_open (net/core/dev.c:1513) 
	netpoll_setup (net/core/netpoll.c:701) 
	init_netconsole (drivers/net/netconsole.c:1261 drivers/net/netconsole.c:1312) 
	do_one_initcall (init/main.c:1269) 
	do_initcall_level (init/main.c:1330) 
	do_initcalls (init/main.c:1344) 
	kernel_init_freeable (init/main.c:1584) 
	kernel_init (init/main.c:1471) 
	ret_from_fork (arch/x86/kernel/process.c:153) 
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	 }
	... key at: netdev_xmit_lock_key+0x10/0x390 
	 ... acquired at:
	_raw_spin_lock (./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
	virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	netpoll_poll_dev (net/core/netpoll.c:167 net/core/netpoll.c:180 net/core/netpoll.c:210) 
	netpoll_send_skb (net/core/netpoll.c:360 net/core/netpoll.c:386) 
	netpoll_send_udp (net/core/netpoll.c:494) 
	write_ext_msg (drivers/net/netconsole.c:1187) 
	console_flush_all (kernel/printk/printk.c:3009 kernel/printk/printk.c:3093 kernel/printk/printk.c:3180) 
	console_unlock (kernel/printk/printk.c:3239 kernel/printk/printk.c:3279) 
	vprintk_emit (kernel/printk/printk.c:?) 
	_printk (kernel/printk/printk.c:2435) 
	register_console (kernel/printk/printk.c:4070) 
	init_netconsole (drivers/net/netconsole.c:1344) 
	do_one_initcall (init/main.c:1269) 
	do_initcall_level (init/main.c:1330) 
	do_initcalls (init/main.c:1344) 
	kernel_init_freeable (init/main.c:1584) 
	kernel_init (init/main.c:1471) 
	ret_from_fork (arch/x86/kernel/process.c:153) 
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 


	stack backtrace:
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
	Call Trace:
	 <TASK>
	dump_stack_lvl (lib/dump_stack.c:123) 
	__lock_acquire (kernel/locking/lockdep.c:? kernel/locking/lockdep.c:2888 kernel/locking/lockdep.c:3165 kernel/locking/lockdep.c:3280 kernel/locking/lockdep.c:3904 kernel/locking/lockdep.c:5202) 
	? virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	lock_acquire (kernel/locking/lockdep.c:5825) 
	? virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	? lock_acquire (kernel/locking/lockdep.c:5825) 
	? down_trylock (kernel/locking/semaphore.c:?) 
	_raw_spin_lock (./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:154) 
	? virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	virtnet_poll_tx (./include/linux/netdevice.h:4361 drivers/net/virtio_net.c:2969) 
	netpoll_poll_dev (net/core/netpoll.c:167 net/core/netpoll.c:180 net/core/netpoll.c:210) 
	netpoll_send_skb (net/core/netpoll.c:360 net/core/netpoll.c:386) 
	netpoll_send_udp (net/core/netpoll.c:494) 
	? console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	write_ext_msg (drivers/net/netconsole.c:1187) 
	? console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	? console_flush_all (kernel/printk/printk.c:1905 kernel/printk/printk.c:3086 kernel/printk/printk.c:3180) 
	? console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	console_flush_all (kernel/printk/printk.c:3009 kernel/printk/printk.c:3093 kernel/printk/printk.c:3180) 
	? console_flush_all (./include/linux/rcupdate.h:? ./include/linux/srcu.h:267 kernel/printk/printk.c:288 kernel/printk/printk.c:3157) 
	console_unlock (kernel/printk/printk.c:3239 kernel/printk/printk.c:3279) 
	vprintk_emit (kernel/printk/printk.c:?) 
	_printk (kernel/printk/printk.c:2435) 
	register_console (kernel/printk/printk.c:4070) 
	init_netconsole (drivers/net/netconsole.c:1344) 
	? option_setup (drivers/net/netconsole.c:1301) 
	do_one_initcall (init/main.c:1269) 
	? __lock_acquire (kernel/locking/lockdep.c:?) 
	? __lock_acquire (kernel/locking/lockdep.c:?) 
	? stack_depot_save_flags (lib/stackdepot.c:664) 
	? stack_depot_save_flags (lib/stackdepot.c:664) 
	? __create_object (mm/kmemleak.c:763) 
	? lock_acquire (kernel/locking/lockdep.c:5825) 
	? __create_object (mm/kmemleak.c:763) 
	? __create_object (mm/kmemleak.c:766) 
	? parse_args (kernel/params.c:153 kernel/params.c:186) 
	do_initcall_level (init/main.c:1330) 
	? kernel_init (init/main.c:1471) 
	do_initcalls (init/main.c:1344) 
	kernel_init_freeable (init/main.c:1584) 
	? rest_init (init/main.c:1461) 
	kernel_init (init/main.c:1471) 
	ret_from_fork (arch/x86/kernel/process.c:153) 
	? rest_init (init/main.c:1461) 
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
	 </TASK>
	printk: legacy console [netcon0] enabled
	netconsole: network logging started

PS: I've hacked around and removed the target_list_lock lock
completely, and I still see the problem, so, that lock doesn't seem to
be related to the problem.

Thanks,
--breno

