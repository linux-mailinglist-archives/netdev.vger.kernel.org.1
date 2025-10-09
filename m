Return-Path: <netdev+bounces-228445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 886C1BCB22C
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 00:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A411A63A4C
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7BE286D62;
	Thu,  9 Oct 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="P2JfNg1O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC81FF7C8
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049913; cv=none; b=QH0L4lIRRy2NQu4vgwT0uZ0xkzzHJj6Jamx4YgqUGnaTTGECOCQCy8pwKaaEEfXf4PtL7Lk3LeWqYGoF0PI/TyKjgDX5EArkTkkR6KdAKykCf5HkfXBfFzk8/WOm9w9SKJHAED2TYEy+zQmIYh+Oj10S1GdeOAKDgkU8bk0+mMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049913; c=relaxed/simple;
	bh=Aq2Xs7YGwBGgcKF/ErcY2LtIolVR5udULocRBat5XrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE9DfWDVcvGyy/9QjKqZsLpeHTEzJyhc3p1FIRVjn31LYmqRsk7wXePWKaeeRNGDq0K/T3kgqkK9af4RSK2lz5S0lHPLPMmuyyihruBQ83fdbHVjfoXUaLztXGTSQ45GA4/qlQt8eufSuvcjSbDvB9VtpsYj3KKd/BaiNZvihHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=P2JfNg1O; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1760049906;
	bh=Mk2YX9Ld0xv4v2koq/Tok6dKf+NvpZKL+/k0QCxNny8=;
	h=From:Subject:Date:Message-ID;
	b=P2JfNg1OmYsYdbX2wlQCpSAw4iSGyd4OPhqPh86BORZFlmaKn4F8Z4akRBOxeCyyk
	 gzF1gmPrArjNoE1aeCszsy+uEsS4dlX7quPq7ylqTfBoXTl41k5/LVyp82+L/SsmQo
	 87cKcR2RXJOpi/OSk9dNjVXc/Ux7caK+fH8wfWtY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68E83AE700000E31; Thu, 10 Oct 2025 06:44:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2389004456659
X-SMAIL-UIID: 314E8BD2736C4394B68195D848352F2C-20251010-064457-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev
Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from invalid context in __set_page_owner
Date: Fri, 10 Oct 2025 06:44:46 +0800
Message-ID: <20251009224447.8479-1-hdanton@sina.com>
In-Reply-To: <68e7e6e3.050a0220.1186a4.0001.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 09 Oct 2025 09:46:27 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ec714e371f22 Merge tag 'perf-tools-for-v6.18-1-2025-10-08'..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=174a4b34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c80a8900dca57
> dashboard link: https://syzkaller.appspot.com/bug?extid=665739f456b28f32b23d
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e0dcd980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1581452f980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6d5cce2bcf5d/disk-ec714e37.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/60dff1e3a58f/vmlinux-ec714e37.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6a1823720b55/bzImage-ec714e37.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6069, name: syz.0.17
> preempt_count: 1, expected: 0
> RCU nest depth: 2, expected: 2
> 5 locks held by syz.0.17/6069:
>  #0: ffff888035808350 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
>  #0: ffff888035808350 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connect+0x152/0xe20 net/vmw_vsock/af_vsock.c:1546
>  #1: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #1: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
>  #1: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2074 [inline]
>  #1: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run9+0x1ec/0x500 kernel/trace/bpf_trace.c:2123
>  #2: ffff8880b8832c88 ((stream_local_lock)){+.+.}-{3:3}, at: bpf_stream_page_local_lock kernel/bpf/stream.c:46 [inline]
>  #2: ffff8880b8832c88 ((stream_local_lock)){+.+.}-{3:3}, at: bpf_stream_elem_alloc kernel/bpf/stream.c:175 [inline]
>  #2: ffff8880b8832c88 ((stream_local_lock)){+.+.}-{3:3}, at: __bpf_stream_push_str+0x211/0xbe0 kernel/bpf/stream.c:190
>  #3: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #3: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
>  #3: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: __rt_spin_trylock kernel/locking/spinlock_rt.c:110 [inline]
>  #3: ffffffff8d7aa500 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x10d/0x2b0 kernel/locking/spinlock_rt.c:118
>  #4: ffff8880b883f6e8 (&s->lock_key#5){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
>  #4: ffff8880b883f6e8 (&s->lock_key#5){+.+.}-{3:3}, at: ___slab_alloc+0x12f/0x1470 mm/slub.c:4492
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 0 UID: 0 PID: 6069 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  __might_resched+0x44b/0x5d0 kernel/sched/core.c:8925
>  __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
>  rt_spin_lock+0xc7/0x3e0 kernel/locking/spinlock_rt.c:57
>  spin_lock include/linux/spinlock_rt.h:44 [inline]

Given atomic context enforced by bpf [1], this is another case that bpf makes
trouble.

[1] cant_sleep() in __bpf_trace_run()
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/bpf_trace.c#n2065

>  ___slab_alloc+0x12f/0x1470 mm/slub.c:4492
>  __slab_alloc+0xc6/0x1f0 mm/slub.c:4746
>  __slab_alloc_node mm/slub.c:4822 [inline]
>  slab_alloc_node mm/slub.c:5233 [inline]
>  __kmalloc_cache_noprof+0xec/0x6c0 mm/slub.c:5719
>  kmalloc_noprof include/linux/slab.h:957 [inline]
>  add_stack_record_to_list mm/page_owner.c:172 [inline]
>  inc_stack_record_count mm/page_owner.c:214 [inline]
>  __set_page_owner+0x25c/0x490 mm/page_owner.c:333
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
>  prep_new_page mm/page_alloc.c:1858 [inline]
>  get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3884
>  alloc_frozen_pages_nolock_noprof+0xbc/0x150 mm/page_alloc.c:7595
>  alloc_pages_nolock_noprof+0xa/0x30 mm/page_alloc.c:7628
>  bpf_stream_page_replace+0x19/0x1e0 kernel/bpf/stream.c:86
>  bpf_stream_page_reserve_elem kernel/bpf/stream.c:142 [inline]
>  bpf_stream_elem_alloc kernel/bpf/stream.c:177 [inline]
>  __bpf_stream_push_str+0x35c/0xbe0 kernel/bpf/stream.c:190
>  bpf_stream_stage_printk+0x14e/0x1c0 kernel/bpf/stream.c:448
>  bpf_prog_report_may_goto_violation+0xc4/0x190 kernel/bpf/core.c:3181
>  bpf_check_timed_may_goto+0xaa/0xb0 kernel/bpf/core.c:3199
>  arch_bpf_timed_may_goto+0x21/0x40 arch/x86/net/bpf_timed_may_goto.S:40
>  bpf_prog_6fd842a53d323cc5+0x53/0x5f
>  bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
>  __bpf_prog_run include/linux/filter.h:721 [inline]
>  bpf_prog_run include/linux/filter.h:728 [inline]
>  __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
>  bpf_trace_run9+0x2db/0x500 kernel/trace/bpf_trace.c:2123
>  __bpf_trace_virtio_transport_alloc_pkt+0x2d7/0x340 include/trace/events/vsock_virtio_transport_common.h:39
>  __do_trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
>  trace_virtio_transport_alloc_pkt include/trace/events/vsock_virtio_transport_common.h:39 [inline]
>  virtio_transport_alloc_skb+0x10cc/0x1130 net/vmw_vsock/virtio_transport_common.c:311
>  virtio_transport_send_pkt_info+0x6be/0x1100 net/vmw_vsock/virtio_transport_common.c:390
>  virtio_transport_connect+0xa7/0x100 net/vmw_vsock/virtio_transport_common.c:1072
>  vsock_connect+0xb8b/0xe20 net/vmw_vsock/af_vsock.c:1611
>  __sys_connect_file net/socket.c:2102 [inline]
>  __sys_connect+0x323/0x450 net/socket.c:2121
>  __do_sys_connect net/socket.c:2127 [inline]
>  __se_sys_connect net/socket.c:2124 [inline]
>  __x64_sys_connect+0x7a/0x90 net/socket.c:2124
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

