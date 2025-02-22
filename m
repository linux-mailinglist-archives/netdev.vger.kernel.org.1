Return-Path: <netdev+bounces-168725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AFBA40465
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 01:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDBB703773
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9855584D29;
	Sat, 22 Feb 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW4BIFDp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCFF80034
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740185400; cv=none; b=aGA/p2ixGDKmJ4YRP+kY1Ddc9/sfJTej9Pq7lCAr6v+M6YvlMpYFod3hezuD0srvaUlOdTuQ5nEi9SvLvRft+s1sI4mAwMOEZi78+L2BcuDEBvFp8N80VJgSXBbKH8PD5MNrOqP3LRROTZzKUzQaW98Vj7o0v5tOFKmv0W8o0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740185400; c=relaxed/simple;
	bh=2lngdTypAJbTHmGZ8LcOeEehFsX2yW7oQTXCvMhrusE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I92zVudHAfX1aelih0Civ08QCkKe7Qu06agttnSluI6sljTxQK8OyxdAjwHyBGHfxBeWXw9xoq02MQ2WIVnham29DLO8cdGKkDYoUYIr0neX1V9Q8AoW3B6SaiEmQpsguxBon72emffBRiXuwmu3fIASw8CagDv7hVc546Il9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW4BIFDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE33C4CED6;
	Sat, 22 Feb 2025 00:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740185400;
	bh=2lngdTypAJbTHmGZ8LcOeEehFsX2yW7oQTXCvMhrusE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hW4BIFDpov6ihvR4Y79gRTjP71EFubpG6KbhM7jgDWkCk04yfyiXfmvGMdTkYUQv6
	 jpDPInJFwm2Nw6IeEMWX9iweiqSI7cZGDFkBH/KyVdxi4K1OQj/BVcn0m2EUuK4TUL
	 R+S19tThnhU9AFe32QhNqP1ZRU0GueWe5m7D6ZRWHDIsTUKGK2w2xFbuuTk0IbDRk8
	 gALA4grMN6m3UvMT7gHUjZEkh9Z+qFpS+jLTgRI57NWhRzoq9EsnpP4XuHArgdivw7
	 4TKbpw5/Q5bE7OQo/fdOzx4ROA16rzf4Vl6meu1UWlhXSC5MVDgP9byEj1+WsRhm7x
	 0GOzWGDEU+wlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7D380CEF6;
	Sat, 22 Feb 2025 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipvlan: ensure network headers are in skb linear part
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018543099.2255625.1524796120252903315.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:50:30 +0000
References: <20250220155336.61884-1-edumazet@google.com>
In-Reply-To: <20250220155336.61884-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+93ab4a777bafb9d9f960@syzkaller.appspotmail.com, maheshb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Feb 2025 15:53:36 +0000 you wrote:
> syzbot found that ipvlan_process_v6_outbound() was assuming
> the IPv6 network header isis present in skb->head [1]
> 
> Add the needed pskb_network_may_pull() calls for both
> IPv4 and IPv6 handlers.
> 
> [1]
> BUG: KMSAN: uninit-value in __ipv6_addr_type+0xa2/0x490 net/ipv6/addrconf_core.c:47
>   __ipv6_addr_type+0xa2/0x490 net/ipv6/addrconf_core.c:47
>   ipv6_addr_type include/net/ipv6.h:555 [inline]
>   ip6_route_output_flags_noref net/ipv6/route.c:2616 [inline]
>   ip6_route_output_flags+0x51/0x720 net/ipv6/route.c:2651
>   ip6_route_output include/net/ip6_route.h:93 [inline]
>   ipvlan_route_v6_outbound+0x24e/0x520 drivers/net/ipvlan/ipvlan_core.c:476
>   ipvlan_process_v6_outbound drivers/net/ipvlan/ipvlan_core.c:491 [inline]
>   ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:541 [inline]
>   ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:605 [inline]
>   ipvlan_queue_xmit+0xd72/0x1780 drivers/net/ipvlan/ipvlan_core.c:671
>   ipvlan_start_xmit+0x5b/0x210 drivers/net/ipvlan/ipvlan_main.c:223
>   __netdev_start_xmit include/linux/netdevice.h:5150 [inline]
>   netdev_start_xmit include/linux/netdevice.h:5159 [inline]
>   xmit_one net/core/dev.c:3735 [inline]
>   dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3751
>   sch_direct_xmit+0x399/0xd40 net/sched/sch_generic.c:343
>   qdisc_restart net/sched/sch_generic.c:408 [inline]
>   __qdisc_run+0x14da/0x35d0 net/sched/sch_generic.c:416
>   qdisc_run+0x141/0x4d0 include/net/pkt_sched.h:127
>   net_tx_action+0x78b/0x940 net/core/dev.c:5484
>   handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
>   __do_softirq+0x14/0x1a kernel/softirq.c:595
>   do_softirq+0x9a/0x100 kernel/softirq.c:462
>   __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:389
>   local_bh_enable include/linux/bottom_half.h:33 [inline]
>   rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
>   __dev_queue_xmit+0x2758/0x57d0 net/core/dev.c:4611
>   dev_queue_xmit include/linux/netdevice.h:3311 [inline]
>   packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
>   packet_snd net/packet/af_packet.c:3132 [inline]
>   packet_sendmsg+0x93e0/0xa7e0 net/packet/af_packet.c:3164
>   sock_sendmsg_nosec net/socket.c:718 [inline]
> 
> [...]

Here is the summary with links:
  - [net] ipvlan: ensure network headers are in skb linear part
    https://git.kernel.org/netdev/net/c/27843ce6ba3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



