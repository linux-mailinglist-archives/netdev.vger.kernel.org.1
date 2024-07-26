Return-Path: <netdev+bounces-113182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ACF93D135
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2DF2827B0
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EBC176AD3;
	Fri, 26 Jul 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e84eKCcP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C970148FED
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989832; cv=none; b=PqqY3N3u5UUL5zQyIKNQfiqchZbJhvI6GaXOFmErhhvYah/M6yOWjq3T9+5y6akZMAoRCscXdHkhFFlXr7DxQwVD+qUPLaF1njkoRZ2u/yt5cwB82LjIHB933PKdXNI47jChkhidRq4kx/hp2Lv0kiUjar/qML1mlnWuvvDwxPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989832; c=relaxed/simple;
	bh=sE98uPqOgt3S5WhU9DOGpnglt35BuJqbHQCbvTKnEn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FkmvOLpeq9ap5wiQucvqtb0sPhXL2RUJPtxn0No7IBaI14mldcB8H6jPgDYyXIen/G+G03uvHRO0Kl824FFGz6claQtCezd90Uzgtqy7xa5dWLL4yRbGjNK+oo8hOH5IWtrw+uwPb1nHs8qmPbW/rWZLdpofp9Fv87jJVU05+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e84eKCcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCED1C4AF07;
	Fri, 26 Jul 2024 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721989831;
	bh=sE98uPqOgt3S5WhU9DOGpnglt35BuJqbHQCbvTKnEn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e84eKCcPVFYPMS5qjq7I/UEEO+cne48BwsYsgBUrt9f8RrJGS0Zuh0fCe0pG5Pm2o
	 Rv5QaWKZj1ChPn5mjREk7TyDnC/Gmo3KEvKhjvQEhC6QLKVtauZ45PjPH9lkRW9EKI
	 kz/7pRdjiG4iy5IyjoKRV8Z91nI9O3/ZxkuSjNWwop9PeBYB4aoEzMsrr7KeTF6NKg
	 Pcabqvl+2BrOn0UBqSFXv3HwJD42Il7uFcQLmMHOX8Ur65K/nMZ6txDnJ6LyW46yxX
	 vjIsMpxNi6Lcy9uCAsN0QJExFdr7QwsY9AjzjYuBN0Sc4hoft9RyZtHQjPKOmzMu60
	 85GScRYqL5U5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8E30C433E9;
	Fri, 26 Jul 2024 10:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sched: act_ct: take care of padding in struct
 zones_ht_key
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172198983175.12062.15325834676725922640.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jul 2024 10:30:31 +0000
References: <20240725092745.1760161-1-edumazet@google.com>
In-Reply-To: <20240725092745.1760161-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+1b5e4e187cc586d05ea0@syzkaller.appspotmail.com, lucien.xin@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jul 2024 09:27:45 +0000 you wrote:
> Blamed commit increased lookup key size from 2 bytes to 16 bytes,
> because zones_ht_key got a struct net pointer.
> 
> Make sure rhashtable_lookup() is not using the padding bytes
> which are not initialized.
> 
>  BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
>  BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
>  BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h:646 [inline]
>  BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
>  BUG: KMSAN: uninit-value in tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
>   rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
>   __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
>   rhashtable_lookup include/linux/rhashtable.h:646 [inline]
>   rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
>   tcf_ct_flow_table_get+0x611/0x2260 net/sched/act_ct.c:329
>   tcf_ct_init+0xa67/0x2890 net/sched/act_ct.c:1408
>   tcf_action_init_1+0x6cc/0xb30 net/sched/act_api.c:1425
>   tcf_action_init+0x458/0xf00 net/sched/act_api.c:1488
>   tcf_action_add net/sched/act_api.c:2061 [inline]
>   tc_ctl_action+0x4be/0x19d0 net/sched/act_api.c:2118
>   rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6647
>   netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2550
>   rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6665
>   netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>   netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
>   netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:745
>   ____sys_sendmsg+0x877/0xb60 net/socket.c:2597
>   ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2651
>   __sys_sendmsg net/socket.c:2680 [inline]
>   __do_sys_sendmsg net/socket.c:2689 [inline]
>   __se_sys_sendmsg net/socket.c:2687 [inline]
>   __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2687
>   x64_sys_call+0x2dd6/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:47
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [net] sched: act_ct: take care of padding in struct zones_ht_key
    https://git.kernel.org/netdev/net/c/2191a54f6322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



