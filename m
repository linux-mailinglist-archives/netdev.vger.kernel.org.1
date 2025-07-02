Return-Path: <netdev+bounces-203527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C4DAF6494
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3721D1C41CA1
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7A9244675;
	Wed,  2 Jul 2025 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uikiPKHD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E9246767
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493604; cv=none; b=pcNY5dYTjJPU0QjoODqD9s4M0kf50qbncSLuJCT3BDVeWhmIEzaAyKgeVmQcpaaQwTx9JvuEIG0Qwn7K8S5wYAGhVde3S2FOBJimZHpsehNGDNq9q6m33e64uIu2Au4YEH4+xRXycdEu22DOzJgUZHB+vsXXGSREp7tHOfG9rhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493604; c=relaxed/simple;
	bh=tta0X1rW1YJ0nba8YTo90i7Kh2H7hcfZ2/rl565mDNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cjGbX30Nx2kam0EcVcA2Woo+bPeGSCb87u8JmyF3/gKiLkZbZaMVR6fGCHg5u4ZsimRAdu+B+Wrc+6zWBRJlR9LuuotySROLiZzmCle3GmT7+WRo7F0EU/cH7CA2D5iDjt5zI6Eu672W3pmWdf0L62L7266Jlzocfz9IOoSEAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uikiPKHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C542BC4CEE7;
	Wed,  2 Jul 2025 22:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751493603;
	bh=tta0X1rW1YJ0nba8YTo90i7Kh2H7hcfZ2/rl565mDNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uikiPKHDhp9gjx0EtVQk3vHEID2Ze7Y6l3Cmc6JkqidEPlsnwK8xAH/HwPNx8EGcu
	 k1fOcSOvpX2cpDsWjGqJAEPBNGWqH/Y4qkfiOmzdRyuowXOjcBh0RBF+MnoneCuw53
	 5wPWcPMTe2AguJc0qi2R0ZjH4nh9mww/NLy/OIQzZBdNh0K9wyIFNN6aGzWSToN7J4
	 MhtfS+AikmSG93YK/3wLADZKqrENzBCnexbA6+HI+0qLT5ly/DaHEEvLqPoxKGOySg
	 Pl/Gp2Mo1UntonZ//+OgRUcBB6mLFMDfodujKqlLID9iV99wvNblWWR1QFZhWHiK1w
	 +97JKJUiblvoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D79383B273;
	Wed,  2 Jul 2025 22:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/10] net: add data-race annotations around
 dst
 fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149362799.877904.11533389098599838126.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:00:27 +0000
References: <20250630121934.3399505-1-edumazet@google.com>
In-Reply-To: <20250630121934.3399505-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 12:19:24 +0000 you wrote:
> Add annotations around various dst fields, which can change under us.
> 
> Add four helpers to prepare better dst->dev protection,
> and start using them. More to come later.
> 
> v2: fix one typo (Reported-by: kernel test robot <lkp@intel.com>)
> v1: https://lore.kernel.org/netdev/20250627112526.3615031-1-edumazet@google.com/
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/10] net: dst: annotate data-races around dst->obsolete
    https://git.kernel.org/netdev/net-next/c/8a402bbe5476
  - [v2,net-next,02/10] net: dst: annotate data-races around dst->expires
    https://git.kernel.org/netdev/net-next/c/36229b2caca2
  - [v2,net-next,03/10] net: dst: annotate data-races around dst->lastuse
    https://git.kernel.org/netdev/net-next/c/8f2b2282d04a
  - [v2,net-next,04/10] net: dst: annotate data-races around dst->input
    https://git.kernel.org/netdev/net-next/c/f1c5fd34891a
  - [v2,net-next,05/10] net: dst: annotate data-races around dst->output
    https://git.kernel.org/netdev/net-next/c/2dce8c52a989
  - [v2,net-next,06/10] net: dst: add four helpers to annotate data-races around dst->dev
    https://git.kernel.org/netdev/net-next/c/88fe14253e18
  - [v2,net-next,07/10] ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]
    https://git.kernel.org/netdev/net-next/c/a74fc62eec15
  - [v2,net-next,08/10] ipv6: adopt dst_dev() helper
    https://git.kernel.org/netdev/net-next/c/1caf27297215
  - [v2,net-next,09/10] ipv6: adopt skb_dst_dev() and skb_dst_dev_net[_rcu]() helpers
    https://git.kernel.org/netdev/net-next/c/93d1cff35adc
  - [v2,net-next,10/10] ipv6: ip6_mc_input() and ip6_mr_input() cleanups
    https://git.kernel.org/netdev/net-next/c/46a94e44b9ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



