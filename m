Return-Path: <netdev+bounces-224225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642CB827BC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 03:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC52A600C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EA91DB127;
	Thu, 18 Sep 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuQmHleN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC65E573
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758158414; cv=none; b=GzM9UkRwbHEAb4tRjVYag+7Q5qLbD2Q9PPll5FCzpGuZ3FghcwtEMY5wJi3YtL940AWjjPfQrG1FnNHzOASfKtiqo/Z/hWFa36dCINylOK8akZFulghqFsl3C/RUOjTIXwiPBpN4SzYuWazOcGtAQA1AlKYn6O9BT2Xd0ABAFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758158414; c=relaxed/simple;
	bh=fqVtwUQWrSXU4/9Tl7088N10vfqz3hxQ80DKVCDy5kc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sxNLJW/H0JvRU2AaKh5xeBV2XYlrC2+xzTY1faicycqHq7Ude8w3A61VrwW9P5KwxtiXXgEvj8dJh5aTaXl6XQYef0Ojsd3finVxrWns33MYZds+Sye5gHAHiyVd7RG3YCEPybW74F0l1zMv70qKcZW4VGg09XDvyzNKInz+NEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuQmHleN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA92C4CEE7;
	Thu, 18 Sep 2025 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758158414;
	bh=fqVtwUQWrSXU4/9Tl7088N10vfqz3hxQ80DKVCDy5kc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GuQmHleNeXQEi+Eo3VEFdXCcgL3vwTtVcl09FqijNCatEl6KdEj+qWssCNHoKlLQY
	 v2qH2fVX+Yb2pmiqkBs9SR5zEpS3HgnbF7F7Im+5oBEnb3nbH7avmmzLGPqNAfEPcz
	 JkLRFsyRHelYgcmXJ6Zpn71lI1l/VPEAomlug6nLf28feYX73R88vTZ2+QUcgpHfMn
	 NLqLPnAp/fRxUGY+KzNspEstBZOEvV0sOpmoNrWYDv5Olc7se7nC1gSjUwDU67Oj3t
	 o6N3WoYiWP9bjS0De7Dy1kj+h+Cx+ReOGwgII1SrxU5hKpi2F9acU6MP+5NW3orZgk
	 Z8uqPZm4/Lz1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE45B39D0C28;
	Thu, 18 Sep 2025 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/7] net: Fix UAF of sk_dst_get(sk)->dev.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175815841450.2212241.6888504606172283921.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 01:20:14 +0000
References: <20250916214758.650211-1-kuniyu@google.com>
In-Reply-To: <20250916214758.650211-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Sep 2025 21:47:18 +0000 you wrote:
> syzbot caught use-after-free of sk_dst_get(sk)->dev,
> which was not fetched under RCU nor RTNL. [0]
> 
> Patch 1 ~ 5, 7 fix UAF in smc, tcp, ktls, mptcp
> Patch 6 fixes dst ref leak in mptcp
> 
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/7] smc: Fix use-after-free in __pnet_find_base_ndev().
    https://git.kernel.org/netdev/net-next/c/3d3466878afd
  - [v2,net-next,2/7] smc: Use __sk_dst_get() and dst_dev_rcu() in in smc_clc_prfx_set().
    https://git.kernel.org/netdev/net-next/c/935d783e5de9
  - [v2,net-next,3/7] smc: Use __sk_dst_get() and dst_dev_rcu() in smc_clc_prfx_match().
    https://git.kernel.org/netdev/net-next/c/235f81045c00
  - [v2,net-next,4/7] smc: Use __sk_dst_get() and dst_dev_rcu() in smc_vlan_by_tcpsk().
    https://git.kernel.org/netdev/net-next/c/0b0e4d51c655
  - [v2,net-next,5/7] tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().
    https://git.kernel.org/netdev/net-next/c/c65f27b9c3be
  - [v2,net-next,6/7] mptcp: Call dst_release() in mptcp_active_enable().
    https://git.kernel.org/netdev/net-next/c/108a86c71c93
  - [v2,net-next,7/7] mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().
    https://git.kernel.org/netdev/net-next/c/893c49a78d9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



