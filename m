Return-Path: <netdev+bounces-63760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D579D82F45B
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 19:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62931C23689
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 18:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8A1BF29;
	Tue, 16 Jan 2024 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT1WFHhE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76C1BC3C
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430178; cv=none; b=k28bPsmtgzwTXjEZzMa7hQVYapgER9BeInBwJY+KXUg0VCoQau5QEaGHbpMjQBGbUfzGddWvg/vuiorGILAJp99IRyinZpUXFVKVX8pKSO/CiAWRP+HQxj9NPTr9Lk+udIKWY7/LQGjWDgF7ukLu+SZ8KOAVN3PS0iGyRirdPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430178; c=relaxed/simple;
	bh=ooil8ZWyQ93p5MRB17llPV6jAMkFUM9KVwBSlKWYNCQ=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Autocrypt:Organization:Cc:Subject:
	 Content-Type:Content-Transfer-Encoding; b=pj9SJyIxR02Mj0H992gBEtgQ8SoOm1/DNzzm1qz3bGfoBVsRsOC1pV/NYbmWyUyC7CYSbcJrHXvGkTuduBTstgUu2DZDvVj2xfqH6mThsr42fuq7u64goOS1YmZC99N+ep0hYxf2qgP3Jm0BxumJRcdQGjyFy1jOgVglSWP9NMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT1WFHhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E7EC433F1;
	Tue, 16 Jan 2024 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705430177;
	bh=ooil8ZWyQ93p5MRB17llPV6jAMkFUM9KVwBSlKWYNCQ=;
	h=Date:To:From:Cc:Subject:From;
	b=IT1WFHhE+DpmHBZT+iwhGFmthRN8JKefq9ZvWmiqnRMft0qaOzbZBnrQKjoRJP/fv
	 5sKjBRiWQlJQJ7NU9b1zdqSlp7il+DyG9t2ERHWpYnj8H7128IzWILjepfFAzDq77m
	 rcpYHgCTDlGqTAyBFfgDadO5iOGm6NL2lNS0NXkWUMn+7dhlsFMNQaJ9hwbpWJeeuA
	 8Wgcu0IdFhhMI5DdMOVJ5kr7aL9K469oXlJoKuFflHbt2GjXWXZGtqJKVCv9348wj7
	 P/UgRFKPe+RyO7Y5BLa53IIw0lgL3KFtxdGrcjCaCslQKh2UgasqrqH51XfXNLfnNT
	 iJdsZmw2EjX4w==
Message-ID: <98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org>
Date: Tue, 16 Jan 2024 19:36:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, fr-BE
To: Netdev <netdev@vger.kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Cc: Eric Dumazet <edumazet@google.com>
Subject: Kernel panic in netif_rx_internal after v6 pings between netns
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Our MPTCP CIs recently hit some kernel panics when validating the -net
tree + 2 pending MPTCP patches. This is on top of e327b2372bc0 ("net:
ravb: Fix dma_addr_t truncation in error case").

It looks like these panics are not related to MPTCP. That's why I'm
sharing that here:

> # INFO: validating network environment with pings
> [   45.505495] int3: 0000 [#1] PREEMPT SMP NOPTI
> [   45.505547] CPU: 1 PID: 1070 Comm: ping Tainted: G                 N 6.7.0-g244ee3389ffe #1
> [   45.505547] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   45.505547] RIP: 0010:netif_rx_internal (arch/x86/include/asm/jump_label.h:27) 
> [ 45.505547] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 55 48 89 fd 48 83 ec 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 e9 <c9> 00 00 00 66 90 66 90 48 8d 54 24 10 48 89 ef 65 8b 35 17 9d 11
> All code
> ========
>    0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>    7:	00 
>    8:	0f 1f 40 00          	nopl   0x0(%rax)
>    c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   11:	55                   	push   %rbp
>   12:	48 89 fd             	mov    %rdi,%rbp
>   15:	48 83 ec 20          	sub    $0x20,%rsp
>   19:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
>   20:	00 00 
>   22:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
>   27:	31 c0                	xor    %eax,%eax
>   29:*	e9 c9 00 00 00       	jmp    0xf7		<-- trapping instruction
>   2e:	66 90                	xchg   %ax,%ax
>   30:	66 90                	xchg   %ax,%ax
>   32:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
>   37:	48 89 ef             	mov    %rbp,%rdi
>   3a:	65                   	gs
>   3b:	8b                   	.byte 0x8b
>   3c:	35                   	.byte 0x35
>   3d:	17                   	(bad)  
>   3e:	9d                   	popf   
>   3f:	11                   	.byte 0x11
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	c9                   	leave  
>    1:	00 00                	add    %al,(%rax)
>    3:	00 66 90             	add    %ah,-0x70(%rsi)
>    6:	66 90                	xchg   %ax,%ax
>    8:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
>    d:	48 89 ef             	mov    %rbp,%rdi
>   10:	65                   	gs
>   11:	8b                   	.byte 0x8b
>   12:	35                   	.byte 0x35
>   13:	17                   	(bad)  
>   14:	9d                   	popf   
>   15:	11                   	.byte 0x11
> [   45.505547] RSP: 0018:ffffb106c00f0af8 EFLAGS: 00000246
> [   45.505547] RAX: 0000000000000000 RBX: ffff99918827b000 RCX: 0000000000000000
> [   45.505547] RDX: 000000000000000a RSI: ffff99918827d000 RDI: ffff9991819e6400
> [   45.505547] RBP: ffff9991819e6400 R08: 0000000000000000 R09: 0000000000000068
> [   45.505547] R10: ffff999181c104c0 R11: 736f6d6570736575 R12: ffff9991819e6400
> [   45.505547] R13: 0000000000000076 R14: 0000000000000000 R15: ffff99918827c000
> [   45.505547] FS:  00007fa1d06ca1c0(0000) GS:ffff9991fdc80000(0000) knlGS:0000000000000000
> [   45.505547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   45.505547] CR2: 0000559b91aac240 CR3: 0000000004986000 CR4: 00000000000006f0
> [   45.505547] Call Trace:
> [   45.505547]  <IRQ>
> [   45.505547] ? die (arch/x86/kernel/dumpstack.c:421) 
> [   45.505547] ? exc_int3 (arch/x86/kernel/traps.c:762) 
> [   45.505547] ? asm_exc_int3 (arch/x86/include/asm/idtentry.h:569) 
> [   45.505547] ? netif_rx_internal (arch/x86/include/asm/jump_label.h:27) 
> [   45.505547] ? netif_rx_internal (arch/x86/include/asm/jump_label.h:27) 
> [   45.505547] __netif_rx (net/core/dev.c:5084) 
> [   45.505547] veth_xmit (drivers/net/veth.c:321) 
> [   45.505547] dev_hard_start_xmit (include/linux/netdevice.h:4989) 
> [   45.505547] __dev_queue_xmit (include/linux/netdevice.h:3367) 
> [   45.505547] ? selinux_ip_postroute_compat (security/selinux/hooks.c:5783) 
> [   45.505547] ? eth_header (net/ethernet/eth.c:85) 
> [   45.505547] ip6_finish_output2 (include/net/neighbour.h:542) 
> [   45.505547] ? ip6_output (include/linux/netfilter.h:301) 
> [   45.505547] ? ip6_mtu (net/ipv6/route.c:3208) 
> [   45.505547] ip6_send_skb (net/ipv6/ip6_output.c:1953) 
> [   45.505547] icmpv6_echo_reply (net/ipv6/icmp.c:812) 
> [   45.505547] ? icmpv6_rcv (net/ipv6/icmp.c:939) 
> [   45.505547] icmpv6_rcv (net/ipv6/icmp.c:939) 
> [   45.505547] ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:440) 
> [   45.505547] ip6_input_finish (include/linux/rcupdate.h:779) 
> [   45.505547] __netif_receive_skb_one_core (net/core/dev.c:5537) 
> [   45.505547] process_backlog (include/linux/rcupdate.h:779) 
> [   45.505547] __napi_poll (net/core/dev.c:6576) 
> [   45.505547] net_rx_action (net/core/dev.c:6647) 
> [   45.505547] __do_softirq (arch/x86/include/asm/jump_label.h:27) 
> [   45.505547] do_softirq (kernel/softirq.c:454) 
> [   45.505547]  </IRQ>
> [   45.505547]  <TASK>
> [   45.505547] __local_bh_enable_ip (kernel/softirq.c:381) 
> [   45.505547] __dev_queue_xmit (net/core/dev.c:4379) 
> [   45.505547] ip6_finish_output2 (include/linux/netdevice.h:3171) 
> [   45.505547] ? ip6_output (include/linux/netfilter.h:301) 
> [   45.505547] ? ip6_mtu (net/ipv6/route.c:3208) 
> [   45.505547] ip6_send_skb (net/ipv6/ip6_output.c:1953) 
> [   45.505547] rawv6_sendmsg (net/ipv6/raw.c:584) 
> [   45.505547] ? netfs_clear_subrequests (include/linux/list.h:373) 
> [   45.505547] ? netfs_alloc_request (fs/netfs/objects.c:42) 
> [   45.505547] ? folio_add_file_rmap_ptes (arch/x86/include/asm/bitops.h:206) 
> [   45.505547] ? set_pte_range (mm/memory.c:4529) 
> [   45.505547] ? next_uptodate_folio (include/linux/xarray.h:1699) 
> [   45.505547] ? __sock_sendmsg (net/socket.c:733) 
> [   45.505547] __sock_sendmsg (net/socket.c:733) 
> [   45.505547] ? move_addr_to_kernel.part.0 (net/socket.c:253) 
> [   45.505547] __sys_sendto (net/socket.c:2191) 
> [   45.505547] ? __hrtimer_run_queues (include/linux/seqlock.h:566) 
> [   45.505547] ? __do_softirq (arch/x86/include/asm/jump_label.h:27) 
> [   45.505547] __x64_sys_sendto (net/socket.c:2203) 
> [   45.505547] do_syscall_64 (arch/x86/entry/common.c:52) 
> [   45.505547] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
> [   45.505547] RIP: 0033:0x7fa1d099ca0a
> [ 45.505547] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
> All code
> ========
>    0:	d8 64 89 02          	fsubs  0x2(%rcx,%rcx,4)
>    4:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
>    b:	eb b8                	jmp    0xffffffffffffffc5
>    d:	0f 1f 00             	nopl   (%rax)
>   10:	f3 0f 1e fa          	endbr64 
>   14:	41 89 ca             	mov    %ecx,%r10d
>   17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
>   1e:	00 
>   1f:	85 c0                	test   %eax,%eax
>   21:	75 15                	jne    0x38
>   23:	b8 2c 00 00 00       	mov    $0x2c,%eax
>   28:	0f 05                	syscall 
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>   30:	77 7e                	ja     0xb0
>   32:	c3                   	ret    
>   33:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   38:	41 54                	push   %r12
>   3a:	48 83 ec 30          	sub    $0x30,%rsp
>   3e:	44                   	rex.R
>   3f:	89                   	.byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	77 7e                	ja     0x86
>    8:	c3                   	ret    
>    9:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    e:	41 54                	push   %r12
>   10:	48 83 ec 30          	sub    $0x30,%rsp
>   14:	44                   	rex.R
>   15:	89                   	.byte 0x89
> [   45.505547] RSP: 002b:00007ffe47710958 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [   45.505547] RAX: ffffffffffffffda RBX: 00007ffe47712090 RCX: 00007fa1d099ca0a
> [   45.505547] RDX: 0000000000000040 RSI: 0000559b91bbd300 RDI: 0000000000000003
> [   45.505547] RBP: 0000559b91bbd300 R08: 00007ffe477142a4 R09: 000000000000001c
> [   45.505547] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe47711c20
> [   45.505547] R13: 0000000000000040 R14: 0000559b91bbf4f4 R15: 00007ffe47712090
> [   45.505547]  </TASK>
> [   45.505547] Modules linked in: mptcp_diag inet_diag mptcp_token_test mptcp_crypto_test kunit
> [   45.505547] ---[ end trace 0000000000000000 ]---
> [   45.505547] RIP: 0010:netif_rx_internal (arch/x86/include/asm/jump_label.h:27) 
> [ 45.505547] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 55 48 89 fd 48 83 ec 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 e9 <c9> 00 00 00 66 90 66 90 48 8d 54 24 10 48 89 ef 65 8b 35 17 9d 11
> All code
> ========
>    0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>    7:	00 
>    8:	0f 1f 40 00          	nopl   0x0(%rax)
>    c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   11:	55                   	push   %rbp
>   12:	48 89 fd             	mov    %rdi,%rbp
>   15:	48 83 ec 20          	sub    $0x20,%rsp
>   19:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
>   20:	00 00 
>   22:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
>   27:	31 c0                	xor    %eax,%eax
>   29:*	e9 c9 00 00 00       	jmp    0xf7		<-- trapping instruction
>   2e:	66 90                	xchg   %ax,%ax
>   30:	66 90                	xchg   %ax,%ax
>   32:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
>   37:	48 89 ef             	mov    %rbp,%rdi
>   3a:	65                   	gs
>   3b:	8b                   	.byte 0x8b
>   3c:	35                   	.byte 0x35
>   3d:	17                   	(bad)  
>   3e:	9d                   	popf   
>   3f:	11                   	.byte 0x11
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	c9                   	leave  
>    1:	00 00                	add    %al,(%rax)
>    3:	00 66 90             	add    %ah,-0x70(%rsi)
>    6:	66 90                	xchg   %ax,%ax
>    8:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
>    d:	48 89 ef             	mov    %rbp,%rdi
>   10:	65                   	gs
>   11:	8b                   	.byte 0x8b
>   12:	35                   	.byte 0x35
>   13:	17                   	(bad)  
>   14:	9d                   	popf   
>   15:	11                   	.byte 0x11
> [   45.505547] RSP: 0018:ffffb106c00f0af8 EFLAGS: 00000246
> [   45.505547] RAX: 0000000000000000 RBX: ffff99918827b000 RCX: 0000000000000000
> [   45.505547] RDX: 000000000000000a RSI: ffff99918827d000 RDI: ffff9991819e6400
> [   45.505547] RBP: ffff9991819e6400 R08: 0000000000000000 R09: 0000000000000068
> [   45.505547] R10: ffff999181c104c0 R11: 736f6d6570736575 R12: ffff9991819e6400
> [   45.505547] R13: 0000000000000076 R14: 0000000000000000 R15: ffff99918827c000
> [   45.505547] FS:  00007fa1d06ca1c0(0000) GS:ffff9991fdc80000(0000) knlGS:0000000000000000
> [   45.505547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   45.505547] CR2: 0000559b91aac240 CR3: 0000000004986000 CR4: 00000000000006f0
> [   45.505547] Kernel panic - not syncing: Fatal exception in interrupt
> [   45.505547] Kernel Offset: 0x37600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


When hitting the panic, the MPTCP selftest was doing some pings -- v6
according to the call trace -- between different netns: client, server,
2 routers in between with some TC config. See [1] for more details. In
other words, that's before creating MPTCP connections.

These panics are not easy to reproduce. In fact, we only saw the issue 2
(maybe 3) times, only when running on Github Actions (without KVM). I
didn't manage to reproduce it locally.

It is only recently that we have started to use Github Actions to do
some validations, so I cannot confirm that it is a very recent issue. I
think the CI hit the same issue a few days ago, on top of bec161add35b
("amt: do not use overwrapped cb area"), but there was another issue and
the debug info have not been stored.

For reference, I originally added info in a Github issue [2]. If the CI
hits the same bug again, I will add stacktrace there. Please tell me if
I should cc someone.

If you have any idea what is causing such panic, please tell me. I can
also add test patches in the MPTCP tree if needed.



[1]
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/tools/testing/selftests/net/mptcp/mptcp_connect.sh?id=e327b2372bc0#n171

[2]
https://github.com/multipath-tcp/mptcp_net-next/issues/471#issuecomment-1894061756


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

