Return-Path: <netdev+bounces-224926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF43B8BA46
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4C75A6B6C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66429B237;
	Fri, 19 Sep 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDT3FaoZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9623E32B;
	Fri, 19 Sep 2025 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758325809; cv=none; b=CNwl9aBLsGkNcPGjPmCZj6D2huFL9eB4mYASJFf7rwnro5ar3OxTBrq4ZPo4aHgDlZRb38EM7CAe4zmYzH5hpP5XUSHyXmTPc0uE8fCrJh7V2VZ9391vm7w0O4m8Vfz6XrfISZX9GM/VvjV3xvDwrukJTzKKh9vSbKpBSf0Tm2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758325809; c=relaxed/simple;
	bh=8QigjOlBaS7m08E2WSkvhV9bqBra/GagKgAD4hthaiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jjAKU2bU+XkNPUaiQBJbWD2qpF6Z8fQiJTIlfiZIEv+luF3WhiXPaBAw5y/NKqPrUd1MuivtMbIYkahcR+LO+HG8q6up2r/Nt9133HyjyGnASoBTWI/m5SBMFQLXC4tAikcfUNOFyMa8wFZgfRYuH7n/g4o3to7GAsRdqGjsLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDT3FaoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744D8C4CEF0;
	Fri, 19 Sep 2025 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758325808;
	bh=8QigjOlBaS7m08E2WSkvhV9bqBra/GagKgAD4hthaiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rDT3FaoZZmUwR4hwYh7mBLaXPlE21Sthax3fGLuyUVYiuzF/Uy1AwMm1H/GIWsnOr
	 T9Dd+zdFmtwZgany4lC9DK7uCmJp21mI3cLyRNZrR+EvQXSWuEymzoXxzx5xnuMlW0
	 gSHZQtkTQJ4cFNJeBgm1Jmlj4HCyS1uc4QArlCA1uzAY2YLd6lI8BDydZP44IMzbpN
	 X9LjuF2dhtMeynWgiAWCKjMMsNgJFnAwvkBnd9hbH9g8h1iAXBMe1Q9N4+vzf5a3J8
	 6srgRVn6W8gsRtiOBJsnNUrBP3/gF06jEolGgX7YiRbo0qISAH9CLRytr7boZU6d79
	 BlPOwpEUGHiEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01E39D0C20;
	Fri, 19 Sep 2025 23:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: tun: Update napi->skb after XDP process
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175832580775.3740319.12992235637381238613.git-patchwork-notify@kernel.org>
Date: Fri, 19 Sep 2025 23:50:07 +0000
References: <20250917113919.3991267-1-wangliang74@huawei.com>
In-Reply-To: <20250917113919.3991267-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 lorenzo@kernel.org, toke@redhat.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 19:39:19 +0800 you wrote:
> The syzbot report a UAF issue:
> 
>   BUG: KASAN: slab-use-after-free in skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
>   BUG: KASAN: slab-use-after-free in napi_frags_skb net/core/gro.c:723 [inline]
>   BUG: KASAN: slab-use-after-free in napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
>   Read of size 8 at addr ffff88802ef22c18 by task syz.0.17/6079
>   CPU: 0 UID: 0 PID: 6079 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>    print_address_description mm/kasan/report.c:378 [inline]
>    print_report+0xca/0x240 mm/kasan/report.c:482
>    kasan_report+0x118/0x150 mm/kasan/report.c:595
>    skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
>    napi_frags_skb net/core/gro.c:723 [inline]
>    napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
>    tun_get_user+0x28cb/0x3e20 drivers/net/tun.c:1920
>    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>    new_sync_write fs/read_write.c:593 [inline]
>    vfs_write+0x5c9/0xb30 fs/read_write.c:686
>    ksys_write+0x145/0x250 fs/read_write.c:738
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
> [...]

Here is the summary with links:
  - [net] net: tun: Update napi->skb after XDP process
    https://git.kernel.org/netdev/net/c/1091860a16a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



