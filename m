Return-Path: <netdev+bounces-241553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EABCC85C2B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A68134D7D8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D4932826B;
	Tue, 25 Nov 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/r0EFzP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF832824B
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084332; cv=none; b=TLDnU+8Ixxe7lSND1vBXP+8H1ArpjZlut5W5Al1cxmUhMKbHGSvwKAMkbBhqE4dSGpg3Kqd5TcRbvF1BAV1fdza7vLzCh0pOO6VhEGFT22Ja/kyVxlLiEUe5LpP8GJVHs308+77fri6yQkSzZ+9hRa4cJFhBS3D5zHaYNtvnHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084332; c=relaxed/simple;
	bh=nZb9kdmXfhVDW/fSpAkVhuyPkuEa7E77GLMOCB2DKFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QybWMZxtL1orzJN66dFIZHx/nnGwOYMyrnmtl4S6sDn6Nw1MlHn+MbfDzxF98jKuAnMfciHoX89taGx4jhoGuHtd3KQYwalake9Qa+kPDRwOGRDyykr+/Ogd2McxcKPykIZi5KtJdbR2orLLcY1edZ/HfKs4EdqoEpnyOWODNOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/r0EFzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368E3C4CEF1;
	Tue, 25 Nov 2025 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764084332;
	bh=nZb9kdmXfhVDW/fSpAkVhuyPkuEa7E77GLMOCB2DKFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t/r0EFzP3FTQF/0vKrKlOHv4S+ToiA3QW9emAJ0j7DX0szHwNE1i1Mepg9oGsYpnX
	 H6UjZjNMGvWKag4OdJPbfyQKpQ5JrRtsUqwfpZRpUMEqa3ZtdV6IxDJllUvomKhN8G
	 EYEU132YtPaWZK+HP7vBiAVm+p3WGO4OmnydABLtwbJEnH4+rmCDZ45WyFKg9o3Edq
	 bVO8RKQiG80B9lGTNL7mN/II0+TSBXTYhyE4mPUPmJgP/z61PEuF7IDw+sonu1aXZz
	 WErSU/IX7TICq03BnqiGkdgAZqd+Cagr3c2cUpjtODe7GeFX5LpWAyxjq1qfUDaLnf
	 faVD2PGXMHlHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECF380A944;
	Tue, 25 Nov 2025 15:24:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 00/14] net_sched: speedup qdisc dequeue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176408429448.752950.12216092755277643932.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 15:24:54 +0000
References: <20251121083256.674562-1-edumazet@google.com>
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 toke@redhat.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Nov 2025 08:32:42 +0000 you wrote:
> Avoid up to two cache line misses in qdisc dequeue() to fetch
> skb_shinfo(skb)->gso_segs/gso_size while qdisc spinlock is held.
> 
> Idea is to cache gso_segs at enqueue time before spinlock is
> acquired, in the first skb cache line, where we already
> have qdisc_skb_cb(skb)->pkt_len.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,01/14] net_sched: make room for (struct qdisc_skb_cb)->pkt_segs
    https://git.kernel.org/netdev/net-next/c/b2a38f6df9da
  - [v3,net-next,02/14] net: init shinfo->gso_segs from qdisc_pkt_len_init()
    https://git.kernel.org/netdev/net-next/c/be1b70ab21cb
  - [v3,net-next,03/14] net_sched: initialize qdisc_skb_cb(skb)->pkt_segs in qdisc_pkt_len_init()
    https://git.kernel.org/netdev/net-next/c/874c1928d372
  - [v3,net-next,04/14] net: use qdisc_pkt_len_segs_init() in sch_handle_ingress()
    https://git.kernel.org/netdev/net-next/c/f9e00e51e391
  - [v3,net-next,05/14] net_sched: use qdisc_skb_cb(skb)->pkt_segs in bstats_update()
    https://git.kernel.org/netdev/net-next/c/2773cb0b3120
  - [v3,net-next,06/14] net_sched: cake: use qdisc_pkt_segs()
    https://git.kernel.org/netdev/net-next/c/c5d34f4583ea
  - [v3,net-next,07/14] net_sched: add Qdisc_read_mostly and Qdisc_write groups
    https://git.kernel.org/netdev/net-next/c/ad50d5a3fc20
  - [v3,net-next,08/14] net_sched: sch_fq: move qdisc_bstats_update() to fq_dequeue_skb()
    https://git.kernel.org/netdev/net-next/c/3c1100f042c0
  - [v3,net-next,09/14] net_sched: sch_fq: prefetch one skb ahead in dequeue()
    https://git.kernel.org/netdev/net-next/c/2f9babc04d74
  - [v3,net-next,10/14] net: prefech skb->priority in __dev_xmit_skb()
    https://git.kernel.org/netdev/net-next/c/b2e9821cff6c
  - [v3,net-next,11/14] net: annotate a data-race in __dev_xmit_skb()
    https://git.kernel.org/netdev/net-next/c/4792c3a4c147
  - [v3,net-next,12/14] net_sched: add tcf_kfree_skb_list() helper
    https://git.kernel.org/netdev/net-next/c/0170d7f47c8b
  - [v3,net-next,13/14] net_sched: add qdisc_dequeue_drop() helper
    https://git.kernel.org/netdev/net-next/c/191ff13e42a7
  - [v3,net-next,14/14] net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel
    https://git.kernel.org/netdev/net-next/c/a6efc273ab82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



