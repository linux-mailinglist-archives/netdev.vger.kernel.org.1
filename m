Return-Path: <netdev+bounces-80719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D31A880A0D
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 04:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361E81C22206
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 03:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA610A29;
	Wed, 20 Mar 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxj21Wb7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458810795
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710904229; cv=none; b=P6QGT8h8RvNCia8ygaM5m/VMMDsiUx19dHTRNjxQYE9eBrDnPLIUHOQoUX8OfOPUTVe4lY7rvB5+oXwJQrrAVo2jDTmfrBv9HYBxyPQ0+ZIj8OidMfe91p2HNid/ifrCTXc/J1/+qGBJObpeCfoBAXeHjFcjj8tghcyD+/rxXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710904229; c=relaxed/simple;
	bh=SFU14kdfrheC1YOXnaYyg5miygtsWYZQhMkJ78mGx1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GCd0jJzQDcfuxalVpS71PVNOFaoFlHcca+b312WsvMWyM/JO9PlCVuMt/a1L9CnVe0mULv2eKIPNzvyvI4p5g1FvqB68MuAbIZotVspuSPf5YkFIkvRagWKVu5zUi8HfWi2PIApgZqdDemVwRzthT1xWFv8EYvRNtFOlZxODiwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxj21Wb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9BE9C43390;
	Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710904228;
	bh=SFU14kdfrheC1YOXnaYyg5miygtsWYZQhMkJ78mGx1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wxj21Wb7iAVdBm/lzbRm7Lxak0HHNqoeJa2XPbuUniuWcqxDXrj3OwqavHCv37q2P
	 zzMsaEjBxd/6LU0bp70dzFlrRLawYLsMHrWR4FHM65dzUKwDldRyrS8z1ErnfLMait
	 PnYsLuEwbLQJMkh0B2LLdEPoA3KyEPXfhjqu975sjLrs8nVQVBOIu6SJMIt5k7wMC0
	 oHuTOrBuq+IkDCtGsdBW49ZIuWo2p1R/4CTtWMuMtHaFRRbDjpz/AYlrlxU3k6VFNI
	 bc2fIThU+ZjN9ZidPH3nujZGA4CDniHA2kxBsUxXTxku60jFu2dO9UYiDhU4qhW9kX
	 ryRDDfRIJM8Eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B6D8D982E4;
	Wed, 20 Mar 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] tcp: Clear req->syncookie in reqsk_alloc().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171090422863.19504.10675426381205720327.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 03:10:28 +0000
References: <20240315224710.55209-1-kuniyu@amazon.com>
In-Reply-To: <20240315224710.55209-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, martin.lau@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Mar 2024 15:47:10 -0700 you wrote:
> syzkaller reported a read of uninit req->syncookie. [0]
> 
> Originally, req->syncookie was used only in tcp_conn_request()
> to indicate if we need to encode SYN cookie in SYN+ACK, so the
> field remains uninitialised in other places.
> 
> The commit 695751e31a63 ("bpf: tcp: Handle BPF SYN Cookie in
> cookie_v[46]_check().") added another meaning in ACK path;
> req->syncookie is set true if SYN cookie is validated by BPF
> kfunc.
> 
> [...]

Here is the summary with links:
  - [v1,net] tcp: Clear req->syncookie in reqsk_alloc().
    https://git.kernel.org/netdev/net/c/956c0d619107

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



