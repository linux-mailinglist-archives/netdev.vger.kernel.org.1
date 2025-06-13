Return-Path: <netdev+bounces-197293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DADAD8056
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5691E7B0962
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99251F417F;
	Fri, 13 Jun 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEP83ZxK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1B1F3FEB;
	Fri, 13 Jun 2025 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778217; cv=none; b=DFCHePymSPNg81CqLEQvdYlJVCEYjD0Ve1TSC8bj3TO54HCSQ7qgS1OU97EghsRWkpgkO1U9cGo20p05MXO66/tPQ4Jya3ZcBX3tRPi0SXHdyMfFN0xYwuR7BK/YOgxdRJjy01qSnCNVYvG1Gpdz/mmPGkXZT4rjNxsBLrThk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778217; c=relaxed/simple;
	bh=dnyl7xXadJ+gA1RxRmxVvePT5MX69p9ijLGsLv2UfoM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FSWYjycAsGe1/P6ubi7s9YbMtTfwMyuHeDlLJfh239Uvw6cHzhIWCzsEImFsjTi3JU0+aJiExJXcyT3lySsgPUFC9RpawO6ez+qD76ZXdvVkw3+eifhnNU0WD9+WGJRu3sxWkhn9dHTf2lu/YS6yZr5VeeEO8NT7to+j/SlvE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEP83ZxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E631C4AF09;
	Fri, 13 Jun 2025 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749778217;
	bh=dnyl7xXadJ+gA1RxRmxVvePT5MX69p9ijLGsLv2UfoM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tEP83ZxKtH4Oa/RdEF7t93/9tX0SHhxr+r6AddkoboSWu6IFS9Yh9914P6vehPG4+
	 ap5hDtDUAi2dWROQrfv/6bCEDCXHIh9xUF8an/uv/SHLyqKvtJ4U+Zk2fFrfxD1X1t
	 9b2XOiii0OJNq3j15VR7xQ0dJDSX/FXBAZsHsipsB33Tq03Nyf1oSbhycYqBPtbhZT
	 AVvuaWSYTV0uPOTMoqVez4sCHUCjCD5mLJJ8t10zpxNWPadkmSoE8UcHxW658+P3HA
	 HlSnOu0eN9As8S7hzdlBuyXJsCnkW5iy7/7j7QVn5aoh11A60CaGRszwF5Jc+KUS1i
	 fcpYUQrzd/Dww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B8639EFFCF;
	Fri, 13 Jun 2025 01:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: extend use of snps,multicast-filter-bins
 property to xgmac
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977824699.179245.5669593462581793038.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 01:30:46 +0000
References: <20250610200411.3751943-1-nikunj.kela@sima.ai>
In-Reply-To: <20250610200411.3751943-1-nikunj.kela@sima.ai>
To: Nikunj Kela <nikunj.kela@sima.ai>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 prabhakar.mahadev-lad.rj@bp.renesas.com, romain.gantois@bootlin.com,
 inochiama@gmail.com, l.rubusch@gmail.com, quentin.schulz@cherry.de,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 13:04:11 -0700 you wrote:
> Hash based multicast filtering is an optional feature. Currently,
> driver overrides the value of multicast_filter_bins based on the hash
> table size. If the feature is not supported, hash table size reads 0
> however the value of multicast_filter_bins remains set to default
> HASH_TABLE_SIZE which is incorrect. Let's extend the use of the property
> snps,multicast-filter-bins to xgmac so it can be set to 0 via devicetree
> to indicate multicast filtering is not supported.
> 
> [...]

Here is the summary with links:
  - net: stmmac: extend use of snps,multicast-filter-bins property to xgmac
    https://git.kernel.org/netdev/net-next/c/94a8e4a8185f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



