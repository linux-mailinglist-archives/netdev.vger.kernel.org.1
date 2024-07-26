Return-Path: <netdev+bounces-113256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34BC93D583
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47280283B09
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EA218E1E;
	Fri, 26 Jul 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/WdCJLL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5FC7494;
	Fri, 26 Jul 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006127; cv=none; b=geyLo97fXmLqFS+RE31Utw1NRT0dMi3me/sBaxG6dGo/deUOzx3ezGHx4buPQpJsKNpBKlBwNxOUCVxJwP0UUyDO6Key6fObnosPMl5i3vsl9vnkZocTM+UQsEvSr1Ov674fAHbvbzir7H28/d+KyCWGSNBhUVWg4hureyy2wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006127; c=relaxed/simple;
	bh=nVwWTgdTUodovh/iqkzdCNEo1Majgzgo+6kXKdU3h7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8zXfz67Y8c3WSekXf7Un5uVdEJjTDT2qG3BYiGbqChm2zqUiPRtTCd98cAf7d4Cb63srqoCfBJRpGwxJdep+doxK9SOcJoPyUy6QzYn5Vd57GMi5vWSTCj6qN3dKiEpwUJCjrUQ1wKK97D+7sXyRJJvvvDCZrH7QrVaydglzuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/WdCJLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7E8C32786;
	Fri, 26 Jul 2024 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722006126;
	bh=nVwWTgdTUodovh/iqkzdCNEo1Majgzgo+6kXKdU3h7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I/WdCJLLxqzmfyvQnQEfyewqeZdzswsEYRNfxRlINW2IhlKLAslVpSGu6i1NMs2d6
	 ZwI/sUt6H4mg9IhWfDhSqW+OzsvGwbA5IX8MrXoSexWfvzP1KyNRrJB0mWNAENRG/s
	 jDiUnRr3U8AZuVEfOxQ3/+xAC2wp+l2OahinaAL5PR6UH4kIyLAeztPQwbE/56Ub9U
	 AnPt8pHdWIRJx5ZJvixWNDp6e68NYbB8dshsQG6ojOy915j/t2ik3RV5Vf3fot5B7m
	 8GcotEEHQaE15bhljCKAynGjVSM1K2nEiGzBDIs9uOr4yHVNqPXqWU6W1s/qE5ePh1
	 y3efdvC9Sk+Tg==
Date: Fri, 26 Jul 2024 08:02:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: syzbot <syzbot+6acef9e0a4d1f46c83d4@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in
 net_generic
Message-ID: <20240726080205.33661f4e@kernel.org>
In-Reply-To: <000000000000f9eeec061e0ffa03@google.com>
References: <000000000000f9eeec061e0ffa03@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

CC: James [L2TP]

On Thu, 25 Jul 2024 03:37:24 -0700 syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c912bf709078 Merge remote-tracking branches 'origin/arm64-..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1625a15e980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79a49b0b9ffd6585
> dashboard link: https://syzkaller.appspot.com/bug?extid=6acef9e0a4d1f46c83d4
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fea69a9d153c/disk-c912bf70.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/be06762a72ef/vmlinux-c912bf70.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6c8e58b4215d/Image-c912bf70.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6acef9e0a4d1f46c83d4@syzkaller.appspotmail.com
> 
> Unable to handle kernel paging request at virtual address dfff800000000257
> KASAN: probably user-memory-access in range [0x00000000000012b8-0x00000000000012bf]
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [dfff800000000257] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 6969 Comm: syz.2.105 Not tainted 6.10.0-rc7-syzkaller-gc912bf709078 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : net_generic+0xd0/0x250 include/net/netns/generic.h:46
> lr : rcu_read_lock include/linux/rcupdate.h:782 [inline]
> lr : net_generic+0x54/0x250 include/net/netns/generic.h:45
> sp : ffff8000a6c86c10
> x29: ffff8000a6c86c10 x28: dfff800000000000 x27: 0000000000000802
> x26: 0000000000000002 x25: 1ffff00014d90d88 x24: dfff800000000000
> x23: ffff0000ca3fbd70 x22: ffff8000a6c86c40 x21: dfff800000000000
> x20: 00000000000012b8 x19: 000000000000004e x18: 1ffff00014d90cfe
> x17: 000000000003099a x16: ffff80008054bde8 x15: 0000000000000001
> x14: ffff80008f100568 x13: dfff800000000000 x12: 00000000af8628cd
> x11: 0000000068a0e22d x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : 0000000000000257 x7 : ffff80008a4326a8 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
> x2 : 0000000000000008 x1 : ffff80008b681f20 x0 : 0000000000000001
> Call trace:
>  net_generic+0xd0/0x250 include/net/netns/generic.h:46
>  l2tp_pernet net/l2tp/l2tp_core.c:125 [inline]
>  l2tp_tunnel_get+0x90/0x464 net/l2tp/l2tp_core.c:207
>  l2tp_udp_recv_core net/l2tp/l2tp_core.c:852 [inline]
>  l2tp_udp_encap_recv+0x314/0xb3c net/l2tp/l2tp_core.c:933
>  udpv6_queue_rcv_one_skb+0x1870/0x1ad4 net/ipv6/udp.c:727
>  udpv6_queue_rcv_skb+0x3bc/0x574 net/ipv6/udp.c:789
>  udp6_unicast_rcv_skb+0x1cc/0x320 net/ipv6/udp.c:929
>  __udp6_lib_rcv+0xbcc/0x1330 net/ipv6/udp.c:1018
>  udpv6_rcv+0x88/0x9c net/ipv6/udp.c:1133
>  ip6_protocol_deliver_rcu+0x988/0x12a4 net/ipv6/ip6_input.c:438
>  ip6_input_finish+0x164/0x298 net/ipv6/ip6_input.c:483
>  NF_HOOK+0x328/0x3d4 include/linux/netfilter.h:314
>  ip6_input+0x90/0xa8 net/ipv6/ip6_input.c:492
>  dst_input include/net/dst.h:460 [inline]
>  ip6_rcv_finish+0x1f0/0x21c net/ipv6/ip6_input.c:79
>  NF_HOOK+0x328/0x3d4 include/linux/netfilter.h:314
>  ipv6_rcv+0x9c/0xbc net/ipv6/ip6_input.c:310
>  __netif_receive_skb_one_core net/core/dev.c:5625 [inline]
>  __netif_receive_skb+0x18c/0x3c8 net/core/dev.c:5739
>  netif_receive_skb_internal net/core/dev.c:5825 [inline]
>  netif_receive_skb+0x1f0/0x93c net/core/dev.c:5885
>  tun_rx_batched+0x568/0x6e4
>  tun_get_user+0x260c/0x3978 drivers/net/tun.c:2002
>  tun_chr_write_iter+0xfc/0x204 drivers/net/tun.c:2048
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0x8f8/0xc38 fs/read_write.c:590
>  ksys_write+0x15c/0x26c fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __arm64_sys_write+0x7c/0x90 fs/read_write.c:652
>  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:131
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:150
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> Code: d2d00015 f2fbfff5 8b080294 d343fe88 (38756908) 
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:	d2d00015 	mov	x21, #0x800000000000        	// #140737488355328
>    4:	f2fbfff5 	movk	x21, #0xdfff, lsl #48
>    8:	8b080294 	add	x20, x20, x8
>    c:	d343fe88 	lsr	x8, x20, #3
> * 10:	38756908 	ldrb	w8, [x8, x21] <-- trapping instruction
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


