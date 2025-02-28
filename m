Return-Path: <netdev+bounces-170878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F2AA4A628
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 23:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A29189C441
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339421DED69;
	Fri, 28 Feb 2025 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9tmep1U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26223F372
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783003; cv=none; b=oO4BaqdpSQaxYEScstE5z3vMqQ6pxvA8aNT4EKd3Sz7d1qTxzWRdg4vLU7lcOdJ4oppN/GL61vVu+hpf9qYBQmvv3kySF0yUG8E+a6uGEXLOJNAWFfa62X/7qiquP+H6U28EbKUk4OFC57sMzEup+iSQfbS4Zq0Nv5mkJwu0TmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783003; c=relaxed/simple;
	bh=FHfMikwInKF3SG7LiGSg9qMVaIml/jSNud+OQnv2mfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KE7ADZY371pkWQ/+NxZ3Sturu7EPM6wKnOyCBtGK8EkARh0h/QODIMGeVjWr4rl1IJd1nvZB8i/iZUrzCZ2gQMOC0PrRmvycKrsKiUalBRZq/9rZgZLZdpkWxaRk900/8bOiZhjQWMohlhv7zWGD0t2+BCQizy4rk9sSkMp+Ot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9tmep1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB24CC4CED6;
	Fri, 28 Feb 2025 22:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740783002;
	bh=FHfMikwInKF3SG7LiGSg9qMVaIml/jSNud+OQnv2mfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S9tmep1U+JbX/vc57mCoe9EjVYhsmEV7OtKpgY1lYhBFPUy+gv4cA0hIJXc7a5E2G
	 +mP5HRMsk6zfzYUwyGNmkgjiEOombSAg1vz5g9noZFY6uCrvW9Huuy2AS/DUb+CK17
	 PgeESB/EAjw0uR4scFFso5SfHOkcgqtvaO6FDwOXT+zGQTcCDn/5ZtIbukJjAqUACi
	 Ut4AMJl2RAowqy8+hbcjuWU623GgPTxsjfaFbBnhLb+3bUVTy3h1wKn9YREfSBKoFy
	 jw6Yhtk7VCx6OuvAUV3FFp8vAIV3l8sBGwkoOQlcMQZap72us/LpdXH5sp4EwKZHTK
	 KPjJjrKnoIbYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FC2380CFF1;
	Fri, 28 Feb 2025 22:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] inet: ping: remove extra
 skb_clone()/consume_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174078303499.2301678.16469844740155000633.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 22:50:34 +0000
References: <20250226183437.1457318-1-edumazet@google.com>
In-Reply-To: <20250226183437.1457318-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 18:34:35 +0000 you wrote:
> First patch in the series moves ICMP_EXT_ECHOREPLY handling in icmp_rcv()
> to prepare the second patch.
> 
> The second patch removes one skb_clone()/consume_skb() pair
> when processing ICMP_EXT_REPLY packets. Some people
> use hundreds of "ping -fq ..." to stress hosts :)
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ipv4: icmp: do not process ICMP_EXT_ECHOREPLY for broadcast/multicast addresses
    https://git.kernel.org/netdev/net-next/c/daeb6a8f3b00
  - [net-next,2/2] inet: ping: avoid skb_clone() dance in ping_rcv()
    https://git.kernel.org/netdev/net-next/c/a7e38208fe71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



