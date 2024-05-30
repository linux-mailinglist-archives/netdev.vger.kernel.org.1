Return-Path: <netdev+bounces-99343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A9F8D4949
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA681C21835
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54DF1761AB;
	Thu, 30 May 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTNgVc1C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8418399A;
	Thu, 30 May 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063829; cv=none; b=KTDxrMasa1tE++36YoHU3tOnfEH0WA9eHKR1WAbAnn28PBKh3NOaKFp4H+ECQ5snCCO6vVCCuR7nOpYqiUfoxFA0aTvx3KbE8pHM6YdggmdDtfUF3zr49RID7PDMkIbYll4X0u/Rsp8jXpqgSDXD928Yk/ClGVctW645QNfmKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063829; c=relaxed/simple;
	bh=0YkPHJJ6K449wpbhi1+CxFc/+STh7XNQcY/cT/hnD+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oEY9W5j8uxT8BkQzFo4mWZ5LZ5m4ewzeGgprsdMQGHILTjqmqRdq0Vl3l23IMFg8jUymzRIy/+Lv+3jknQHcBXEm/ySUia0jCAq3cwuBOLyMOulXQBSotVREnDIPdGk66jhQN1GASccsQqGlTmlu07FcjuCRVjM+BZwdaPTOKPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTNgVc1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02167C3277B;
	Thu, 30 May 2024 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717063829;
	bh=0YkPHJJ6K449wpbhi1+CxFc/+STh7XNQcY/cT/hnD+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RTNgVc1CKxZ1Ww5Pmwez5c6dZ4ctr5vJemqyqD97lTlN6sqi7dh6WhlEpiOgwd330
	 mD48TuQjp/mt3HSrbltNYY6wAIsY2Mys8QrXbLeAv+ny0aP9fqbpGPeTCCuBOmZMbc
	 BdnJHcEDSElVSb0X+qcVdPKkGvcKTfm/yrUSnn6u/Ct69w3yJnrmPxJp8cF2N8QbMc
	 gB8RL2VP/a7GkHHezjEwd59Ve8YAjHfJcH4mhlIihS2D0RVCePyVctoEL2lNrdzJJt
	 gRQxUpbgwjrJmeA7wN/GeaqIrtecOhvd7Z+dskz+5900MNIfIniaquXIMf5/P7+jjT
	 5kqZfjMgjKhMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E52B3CF21F2;
	Thu, 30 May 2024 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipvlan: Dont Use skb->sk in
 ipvlan_process_v{4,6}_outbound
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171706382893.341.2212459840285450534.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 10:10:28 +0000
References: <20240529095633.613103-1-yuehaibing@huawei.com>
In-Reply-To: <20240529095633.613103-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, maheshb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 May 2024 17:56:33 +0800 you wrote:
> Raw packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device will
> hit WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path.
> 
> WARNING: CPU: 2 PID: 0 at net/core/sock.c:775 sk_mc_loop+0x2d/0x70
> Modules linked in: sch_netem ipvlan rfkill cirrus drm_shmem_helper sg drm_kms_helper
> CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 6.9.0+ #279
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:sk_mc_loop+0x2d/0x70
> Code: fa 0f 1f 44 00 00 65 0f b7 15 f7 96 a3 4f 31 c0 66 85 d2 75 26 48 85 ff 74 1c
> RSP: 0018:ffffa9584015cd78 EFLAGS: 00010212
> RAX: 0000000000000011 RBX: ffff91e585793e00 RCX: 0000000002c6a001
> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff91e589c0f000
> RBP: ffff91e5855bd100 R08: 0000000000000000 R09: 3d00545216f43d00
> R10: ffff91e584fdcc50 R11: 00000060dd8616f4 R12: ffff91e58132d000
> R13: ffff91e584fdcc68 R14: ffff91e5869ce800 R15: ffff91e589c0f000
> FS:  0000000000000000(0000) GS:ffff91e898100000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f788f7c44c0 CR3: 0000000008e1a000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <IRQ>
>  ? __warn (kernel/panic.c:693)
>  ? sk_mc_loop (net/core/sock.c:760)
>  ? report_bug (lib/bug.c:201 lib/bug.c:219)
>  ? handle_bug (arch/x86/kernel/traps.c:239)
>  ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
>  ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
>  ? sk_mc_loop (net/core/sock.c:760)
>  ip6_finish_output2 (net/ipv6/ip6_output.c:83 (discriminator 1))
>  ? nf_hook_slow (net/netfilter/core.c:626)
>  ip6_finish_output (net/ipv6/ip6_output.c:222)
>  ? __pfx_ip6_finish_output (net/ipv6/ip6_output.c:215)
>  ipvlan_xmit_mode_l3 (drivers/net/ipvlan/ipvlan_core.c:602) ipvlan
>  ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:226) ipvlan
>  dev_hard_start_xmit (net/core/dev.c:3594)
>  sch_direct_xmit (net/sched/sch_generic.c:343)
>  __qdisc_run (net/sched/sch_generic.c:416)
>  net_tx_action (net/core/dev.c:5286)
>  handle_softirqs (kernel/softirq.c:555)
>  __irq_exit_rcu (kernel/softirq.c:589)
>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043)
> 
> [...]

Here is the summary with links:
  - [net,v2] ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound
    https://git.kernel.org/netdev/net/c/b3dc6e8003b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



