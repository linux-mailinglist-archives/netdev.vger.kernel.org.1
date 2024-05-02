Return-Path: <netdev+bounces-92873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE258B9333
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 03:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC972283C74
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4314A8E;
	Thu,  2 May 2024 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7UTN+xO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47912B77
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 01:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714614633; cv=none; b=Cwc3x7vZMmj0eyOCTdeCJQ2dMSYV6QjcPoD8pH7BR9Vwj1a2Fr1zGjcRU4xzV9q8oShz2d3Fl+CDTh6i7xWoIVUFJvYLNez3aR/BbJveHesrZEZbRzHgj90h75rovYB/5t5FR0tfqd0bbQpRZWZ46rt5r7w2IqicpXJdzyLIrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714614633; c=relaxed/simple;
	bh=wqK+mPFax3qX+80rptQvln8wdBzDts7Ert3cuQ4xYJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t3ubxYU+IKuM1/r5MHEbN2L2tMIGdTk7i9Oate+qbXeWrBWrEJFT3ihnRIPMKPRD7ccVfwqLETLcsot6R+RA2Nwby5R3a7QpaCxTWLfRZfsm0aIhCwq4mKO1x+LwXNRorzXkcwGadyypKk3favYgmvgbuTO1rOMDHMZ5/4x3VMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7UTN+xO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58350C4AF14;
	Thu,  2 May 2024 01:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714614633;
	bh=wqK+mPFax3qX+80rptQvln8wdBzDts7Ert3cuQ4xYJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z7UTN+xOBrDyL50ykwUadbV0BITRy1HLKb0hZ2AqC0v6oSL9K8V66VH7A9G7Yrjnb
	 oY1Qmh/q4We/diIMwYnOLh77pEBO98sq8nPi+26VvhyUr56B8rYcVlII+E2sMl1exo
	 u4dKtb/InM8TGgBx7cOVM9sbhLcjXLbCejbiIdzAnkieP+vY9IbNIb5bVGgpeXxAPh
	 twCqLYRfP4xgP5sPpZ21ZOuxTnkGQyJjLtSbkX11JcL8HYlKk+FqalZ17zWdUSCDtk
	 yXJzk+KwTQVrNCvEunKhzth/0qFCJfpCl9o8r2+e6+KDQJLZSczWM4/9K1gMNRE7JS
	 LqKoGhObI20oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45B9AC43444;
	Thu,  2 May 2024 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/7] arp: Random clean up and RCU conversion for
 ioctl(SIOCGARP).
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171461463328.22196.7504103955047263310.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 01:50:33 +0000
References: <20240430015813.71143-1-kuniyu@amazon.com>
In-Reply-To: <20240430015813.71143-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 18:58:06 -0700 you wrote:
> arp_ioctl() holds rtnl_lock() regardless of cmd (SIOCDARP, SIOCSARP,
> and SIOCGARP) to get net_device by __dev_get_by_name() and copy
> dev->name safely.
> 
> In the SIOCGARP path, arp_req_get() calls neigh_lookup(), which looks
> up a neighbour entry under RCU.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/7] arp: Move ATF_COM setting in arp_req_set().
    https://git.kernel.org/netdev/net-next/c/42033d0cfc86
  - [v3,net-next,2/7] arp: Validate netmask earlier for SIOCDARP and SIOCSARP in arp_ioctl().
    https://git.kernel.org/netdev/net-next/c/0592367424bb
  - [v3,net-next,3/7] arp: Factorise ip_route_output() call in arp_req_set() and arp_req_delete().
    https://git.kernel.org/netdev/net-next/c/f8696133f6aa
  - [v3,net-next,4/7] arp: Remove a nest in arp_req_get().
    https://git.kernel.org/netdev/net-next/c/51e9ba48d487
  - [v3,net-next,5/7] arp: Get dev after calling arp_req_(delete|set|get)().
    https://git.kernel.org/netdev/net-next/c/a428bfc77a4d
  - [v3,net-next,6/7] net: Protect dev->name by seqlock.
    https://git.kernel.org/netdev/net-next/c/0840556e5a3a
  - [v3,net-next,7/7] arp: Convert ioctl(SIOCGARP) to RCU.
    https://git.kernel.org/netdev/net-next/c/bf4ea58874df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



