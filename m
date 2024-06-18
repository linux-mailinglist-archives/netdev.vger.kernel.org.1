Return-Path: <netdev+bounces-104434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D848790C7D1
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82861C22D03
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F331C9EAD;
	Tue, 18 Jun 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNXm7Dzk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3CB1C9EA9;
	Tue, 18 Jun 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702429; cv=none; b=jiy0a1IYKfprc7itY14JIfvcUwghr5h2KZC0q3ioaR0itKwaHgmg0bZP2PIy+NfzZ49iT6Lv40+ZMilNHl/J+7F3DH+yRMN0+RJRY5+xtVFZY6Ut6si1cS6zxZN+CalKWzqP8ojtGkemc2YwzWrIBbtNOIIXLXcj6NnyjRJpU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702429; c=relaxed/simple;
	bh=FiBK8BhydwXweraMDU8D+UrNScrsx6uojqAGwGP0Cbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=chC2f4pmlR5CZYKhOOr1aGcFr7GWImn6QiIpgQIoSnU6+/QGS2X/GB8jhzJoGVTj7FIc7pxp1/GbTdBdXgq4Q5iZ57uM4gQAvJxGrEOdW7OR4Odm9wDopxptHJ40HkwYLCk+j85aUcNukWYdA7LY8re+KR77rvbQETplrGLmbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNXm7Dzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58541C4AF51;
	Tue, 18 Jun 2024 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718702429;
	bh=FiBK8BhydwXweraMDU8D+UrNScrsx6uojqAGwGP0Cbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qNXm7Dzkp7NIib+F9pt9XUU8zd/Sj106lKhKuBSIVPm8tO/jT5WuIvhZ3eFMSRYZt
	 bpUAUPKCDbjrdu+Eaa0YE3cT33Y65st2ciItrVkEs9fT4osQ1Z9ljR+mZik7w9Nu4L
	 WFyV6Ymee2fdQHwhLnHBUHOufgzFn+tXkaSTxhk3honh13JIUAptID0smJ8ZKw8g5S
	 2c1mKdpo0SZNseHqYx6xgLDwktmVMcE7zF0hAXAap3+lMMLFPi/yMyazYRiYhCs9ak
	 ySIFOQ8mnkK8JBI+OW12aep4jSmk+AjBadMwh+aVd3kAa4N29P+cm5IlSTcSCpVU97
	 2GcKP8tb9q3Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43925C32768;
	Tue, 18 Jun 2024 09:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netns: Make get_net_ns() handle zero refcount net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171870242926.21013.3743600964363163093.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 09:20:29 +0000
References: <20240614131302.2698509-1-yuehaibing@huawei.com>
In-Reply-To: <20240614131302.2698509-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, tkhai@ya.ru, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Jun 2024 21:13:02 +0800 you wrote:
> Syzkaller hit a warning:
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 3 PID: 7890 at lib/refcount.c:25 refcount_warn_saturate+0xdf/0x1d0
> Modules linked in:
> CPU: 3 PID: 7890 Comm: tun Not tainted 6.10.0-rc3-00100-gcaa4f9578aba-dirty #310
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:refcount_warn_saturate+0xdf/0x1d0
> Code: 41 49 04 31 ff 89 de e8 9f 1e cd fe 84 db 75 9c e8 76 26 cd fe c6 05 b6 41 49 04 01 90 48 c7 c7 b8 8e 25 86 e8 d2 05 b5 fe 90 <0f> 0b 90 90 e9 79 ff ff ff e8 53 26 cd fe 0f b6 1
> RSP: 0018:ffff8881067b7da0 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff811c72ac
> RDX: ffff8881026a2140 RSI: ffffffff811c72b5 RDI: 0000000000000001
> RBP: ffff8881067b7db0 R08: 0000000000000000 R09: 205b5d3730353139
> R10: 0000000000000000 R11: 205d303938375420 R12: ffff8881086500c4
> R13: ffff8881086500c4 R14: ffff8881086500b0 R15: ffff888108650040
> FS:  00007f5b2961a4c0(0000) GS:ffff88823bd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055d7ed36fd18 CR3: 00000001482f6000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? show_regs+0xa3/0xc0
>  ? __warn+0xa5/0x1c0
>  ? refcount_warn_saturate+0xdf/0x1d0
>  ? report_bug+0x1fc/0x2d0
>  ? refcount_warn_saturate+0xdf/0x1d0
>  ? handle_bug+0xa1/0x110
>  ? exc_invalid_op+0x3c/0xb0
>  ? asm_exc_invalid_op+0x1f/0x30
>  ? __warn_printk+0xcc/0x140
>  ? __warn_printk+0xd5/0x140
>  ? refcount_warn_saturate+0xdf/0x1d0
>  get_net_ns+0xa4/0xc0
>  ? __pfx_get_net_ns+0x10/0x10
>  open_related_ns+0x5a/0x130
>  __tun_chr_ioctl+0x1616/0x2370
>  ? __sanitizer_cov_trace_switch+0x58/0xa0
>  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
>  ? __pfx_tun_chr_ioctl+0x10/0x10
>  tun_chr_ioctl+0x2f/0x40
>  __x64_sys_ioctl+0x11b/0x160
>  x64_sys_call+0x1211/0x20d0
>  do_syscall_64+0x9e/0x1d0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5b28f165d7
> Code: b3 66 90 48 8b 05 b1 48 2d 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 48 2d 00 8
> RSP: 002b:00007ffc2b59c5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5b28f165d7
> RDX: 0000000000000000 RSI: 00000000000054e3 RDI: 0000000000000003
> RBP: 00007ffc2b59c650 R08: 00007f5b291ed8c0 R09: 00007f5b2961a4c0
> R10: 0000000029690010 R11: 0000000000000246 R12: 0000000000400730
> R13: 00007ffc2b59cf40 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> Kernel panic - not syncing: kernel: panic_on_warn set ...
> 
> [...]

Here is the summary with links:
  - netns: Make get_net_ns() handle zero refcount net
    https://git.kernel.org/netdev/net/c/ff960f9d3edb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



