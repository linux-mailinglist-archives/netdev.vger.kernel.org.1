Return-Path: <netdev+bounces-177249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B4BA6E696
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507E4174E20
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A501EF0B9;
	Mon, 24 Mar 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5f10N1w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D91EF0AE
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855399; cv=none; b=iQMocbQbrh9g/kNDcb49rzvujvTpjLjjMF2BRnI6up1JyGueUgTrwYK4G1veS/YLSt9SZXDnECHCZ7WrTKRyaLzEBRgrZKhZQau29Ini9ZK0Eczing2VLRv0L+/zjH5Thyjl66bIOpaGtpDf2ddWXY/5w58Tak39OAVpqPsFd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855399; c=relaxed/simple;
	bh=lJ1fgM9rroKCKn1FiLEUFFJi5Bo8sNLJZYtWWe10vUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M3YLCqOczjk5cdp/NVrFyi/DFigtXOnt0D62MHSAI/t+C9lP0shxDx5vC/WZKRprW14lc5RIEZeA+nrv1Kx0vrIoFbeHsb3Qu2u40H9magW1ealD/UlqcnNPUYwtidbVeL2olWSgmwaR9KYUamm/dlAwDUq6y2y8ZFEc3dE8fdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5f10N1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9C9C4CEE4;
	Mon, 24 Mar 2025 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742855398;
	bh=lJ1fgM9rroKCKn1FiLEUFFJi5Bo8sNLJZYtWWe10vUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a5f10N1wbK2LRU4iFmyflwCDLtVib4QGOZLY2r5VrJpc7iHyGmGXU3WxjSBCiwtc5
	 iOfoqQ+GjmzjincrGmDV1J69JVk4Y3yKk6PGOV6azyCO7kiNu/4K5SEjuamrnP6WDZ
	 yyMnfOGnuHHtuc02Spr9FbgMMotk8SWBYq9QFvUJbWpGJMjmE/hEICcx7/hPmeDTg1
	 RwAVpob+fZWSwXcrB69Wq9lwmGvWv2QlrjUm8l6olUM3XynPu7NmKku/WHH5pJhohf
	 TyOybB8g3hN2W+WTJo99iS7OO9WyR5MEKP6UcyWFgfzGKTXVWz9iPftnrRmlMqKvtq
	 MOmIgKdXJFSkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFCB380664F;
	Mon, 24 Mar 2025 22:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] sja1105 driver fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285543452.6006.7821995943652796349.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 22:30:34 +0000
References: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250318115716.2124395-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, f.fainelli@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Mar 2025 13:57:13 +0200 you wrote:
> Hello,
> 
> This is a collection of 3 fixes for the sja1105 DSA driver:
> - 1/3: "ethtool -S" shows a bogus counter with no name, and doesn't show
>   a valid counter because of it (either "n_not_reach" or "n_rx_bcast").
> - 2/3: RX timestamping filters other than L2 PTP event messages don't work,
>   but are not rejected, either.
> - 3/3: there is a KASAN out-of-bounds warning in sja1105_table_delete_entry()
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: dsa: sja1105: fix displaced ethtool statistics counters
    https://git.kernel.org/netdev/net/c/00eb88752f48
  - [net,2/3] net: dsa: sja1105: reject other RX filters than HWTSTAMP_FILTER_PTP_V2_L2_EVENT
    https://git.kernel.org/netdev/net/c/b6a177b55971
  - [net,3/3] net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()
    https://git.kernel.org/netdev/net/c/5f2b28b79d2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



