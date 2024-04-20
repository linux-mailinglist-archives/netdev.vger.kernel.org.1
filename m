Return-Path: <netdev+bounces-89772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B062F8AB874
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 03:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F7ACB21263
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 01:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B51A205E1A;
	Sat, 20 Apr 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdPjGBGF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6510F7
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577679; cv=none; b=lDnJyZTqBTSRr9gzAqI2Do3PKs3zpbgMwdbIg+DDA2hLpBWjKYvrd/Fy8o60N9FvH+DRFxvVyFvtBnbPHwTdTgjsimX+FKIq7fUpO5pjG8lW9F4Uwp9CFEmoNRoiRtY783WD+xgYiwgspoBEA3fakjVrc74Vfylo3BgTia9aHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577679; c=relaxed/simple;
	bh=HnaeXZM0piccadM7oI0SfgUkq8FxRKdP841703Dwfnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFSDStypmKbEFWRSLtrstoxWFYEdDh3YRoAHxE96xrZXzUmV7hm3P99Dt+oW6r/8Qo+Vv/t45cBNc/nMg0AyAh41IsPnHKVrD11tBnAZLqJrm9MkyRCLv57VIVl5SO7PKh1waCiexeUtcKEH32ZiX6+fDW60STJN4AwCtNl4l40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdPjGBGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0148CC072AA;
	Sat, 20 Apr 2024 01:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713577679;
	bh=HnaeXZM0piccadM7oI0SfgUkq8FxRKdP841703Dwfnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qdPjGBGFmQt8aVs7rJM4vcWjPAl0lbuwkBiUAIq0DWFN/SF4qVbRfqjh2qTM6rPFO
	 jnXV+iK1sY7OVJKA8K2CzcU037BpO/53D3Sm89UREla2ckMeY9HQhIl1VgplJgVZzC
	 mse9UwS8sTKbzLwuSE7fRUUCYZhJD92in3as8f1W8VPs35Sdl4GxsZKIrZ3c87xM1r
	 SfIrI2ZG8/ZlOdra8/7U83Ezry+kHt5RMUvDCAe2dh3xHEkvpKCW6mjvkIKrOgLPcE
	 7HfVxsHcWMjEZga+ZslvUPfoAXp9cazf7Kz5T57kzjqXmtETTPDfKlteEk8iWq14Bu
	 Amc7bowhyp7ew==
Date: Fri, 19 Apr 2024 18:47:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 0/2] netdevsim: add NAPI support
Message-ID: <20240419184757.6d4334cf@kernel.org>
In-Reply-To: <20240419220857.2065615-1-dw@davidwei.uk>
References: <20240419220857.2065615-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Apr 2024 15:08:55 -0700 David Wei wrote:
> Add NAPI support to netdevsim and register its Rx queues with NAPI
> instances. Then add a selftest using the new netdev Python selftest
> infra to exercise the existing Netdev Netlink API, specifically the
> queue-get API.

I haven't looked at the code but this makes the devlink test crash 
the kernel:

[ 1130.858677][T11010] KASAN: null-ptr-deref in range [0x0000000000000190-0x0000000000000197]
[ 1130.859158][T11010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[1130.859478][T11010] RIP: 0010:skb_queue_purge_reason (./include/linux/skbuff.h:1846 net/core/skbuff.c:3821) 
[ 1130.859672][T11010] Code: f1 f1 f1 f1 c7 40 0c 00 00 00 f3 c7 40 10 f3 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 d8 00 00 00 48 89 f8 48 c1 e8 03 <80> 3c 10 00 0f 85 bb 02 00 00 48 8b 03 48 39 c3 0f 84 ed 01 00 00
All code
========
   0:	f1                   	int1
   1:	f1                   	int1
   2:	f1                   	int1
   3:	f1                   	int1
   4:	c7 40 0c 00 00 00 f3 	movl   $0xf3000000,0xc(%rax)
   b:	c7 40 10 f3 f3 f3 f3 	movl   $0xf3f3f3f3,0x10(%rax)
  12:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
  19:	00 00 
  1b:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
  22:	00 
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)		<-- trapping instruction
  2e:	0f 85 bb 02 00 00    	jne    0x2ef
  34:	48 8b 03             	mov    (%rbx),%rax
  37:	48 39 c3             	cmp    %rax,%rbx
  3a:	0f 84 ed 01 00 00    	je     0x22d

Code starting with the faulting instruction
===========================================
   0:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)
   4:	0f 85 bb 02 00 00    	jne    0x2c5
   a:	48 8b 03             	mov    (%rbx),%rax
   d:	48 39 c3             	cmp    %rax,%rbx
  10:	0f 84 ed 01 00 00    	je     0x203
[ 1130.860181][T11010] RSP: 0018:ffffc900044ff8e0 EFLAGS: 00010202
[ 1130.860367][T11010] RAX: 0000000000000032 RBX: 0000000000000190 RCX: 0000000000000001
[ 1130.860580][T11010] RDX: dffffc0000000000 RSI: 0000000000000055 RDI: 0000000000000190
[ 1130.860821][T11010] RBP: ffffc900044ff9f0 R08: 0000000000000001 R09: fffffbfff10468b4
[ 1130.861067][T11010] R10: 0000000000000003 R11: ffffffff84800130 R12: ffffed10010f7584
[ 1130.861312][T11010] R13: 0000000000000001 R14: 0000000000000055 R15: 1ffff9200089ff20
[ 1130.861543][T11010] FS:  00007f691c6ba740(0000) GS:ffff888036180000(0000) knlGS:0000000000000000
[ 1130.861801][T11010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1130.861983][T11010] CR2: 000055d41b377ff0 CR3: 000000000988a003 CR4: 0000000000770ef0
[ 1130.862199][T11010] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1130.862408][T11010] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1130.862630][T11010] PKRU: 55555554
[ 1130.862745][T11010] Call Trace:
[ 1130.862876][T11010]  <TASK>
[1130.862954][T11010] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:460) 
[1130.863080][T11010] ? exc_general_protection (arch/x86/kernel/traps.c:702 arch/x86/kernel/traps.c:644) 
[1130.863256][T11010] ? asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:617) 
[1130.863401][T11010] ? entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[1130.863599][T11010] ? skb_queue_purge_reason (./include/linux/skbuff.h:1846 net/core/skbuff.c:3821) 
[1130.863755][T11010] ? __pfx_skb_queue_purge_reason (net/core/skbuff.c:3817) 
[1130.863954][T11010] ? unregister_netdevice_queue (net/core/dev.c:11123) 
[1130.864129][T11010] ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:114) 
[1130.864291][T11010] ? __pfx_unregister_netdevice_queue (net/core/dev.c:11112) 
[1130.864469][T11010] nsim_destroy (drivers/net/netdevsim/netdev.c:653 drivers/net/netdevsim/netdev.c:784) netdevsim
[1130.864651][T11010] __nsim_dev_port_del (drivers/net/netdevsim/dev.c:426 drivers/net/netdevsim/dev.c:1426) netdevsim
[1130.864889][T11010] nsim_dev_reload_destroy (drivers/net/netdevsim/dev.c:591 drivers/net/netdevsim/dev.c:1655) netdevsim
[1130.865081][T11010] nsim_drv_remove (drivers/net/netdevsim/dev.c:1675) netdevsim
[1130.865250][T11010] device_release_driver_internal (drivers/base/dd.c:1272 drivers/base/dd.c:1293) 
-- 
pw-bot: cr

