Return-Path: <netdev+bounces-196723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA94AD611A
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4A1166F5D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B0F248F45;
	Wed, 11 Jun 2025 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjmNqOsl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA06248897
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676806; cv=none; b=J3RUccD1l8XP9vF4Z4fr3BSO93Ib/lhOcP4BIGKOXSu0fs3YH+t2RNvQsuB3HVVGC5YFEqMQ4RFiOu5S5yJzr7Ldah13An1k7AqGALrBKl64OxxcxOPilyU8bcntjIeVzeEhdpzXB4rrL1TCIQFbrnbn+gMiSkglxHBLK2uLjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676806; c=relaxed/simple;
	bh=ZpBouim92b1JV/ubRO0M3IVHr6qRA0/X8IJe2bYlVnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KIKHX3QSC7x+WrXV8RkO4xoyiuxpbQUjOhRn2wbwuRBWOWimcJEXV70paq3vK6dcxcU43Wmu7auFIk2G5zgy2VQEgqAExhCIXpttBcee2BjHqI24te9w7ao97WlLXhCq0pSsKjKMzarJqZkJ5RS45AhygrtpT3NpJ/fffkFmsRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjmNqOsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFE1C4CEE3;
	Wed, 11 Jun 2025 21:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749676806;
	bh=ZpBouim92b1JV/ubRO0M3IVHr6qRA0/X8IJe2bYlVnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HjmNqOsln8v8w8rttZRgGboXfF91UxWRnO/+L6KXYFsnlP4e/j1xKfD70X9YHgiPc
	 C6V7KMbFl5Pkc1wj4vMlidlzIqZblme/qSmMoQWLv7ZNkqtMcy3jR+cFu26hi2GM4A
	 tklnde3oGCFYzWWr2NMINPuSdGgpuHRQjgwKpfspJo+0jqqPZgAT55NxC5KDdTSAnm
	 VaC+OJtxcPb6F8ecK9ceWrNku9HGbKlmrFUXT9AfWIintW3Qxul9pKLTmD3Se0N8SA
	 fH8YUlkRczSZu9/xEbDSLfE+OqwG4sfMMVZ/5A6BWCW384sxoWsKPoEWpLcAsmzzkC
	 oJTwREUzr8JUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF6380DBE9;
	Wed, 11 Jun 2025 21:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: enable EEE at 5Gbps on RTL8126
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967683599.3488937.12562811663150539441.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 21:20:35 +0000
References: <18ce0996-0182-4a11-a93a-df14b0e6876c@gmail.com>
In-Reply-To: <18ce0996-0182-4a11-a93a-df14b0e6876c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 07:43:38 +0200 you wrote:
> According to Realtek [0] it's safe to enable EEE at 5Gbps on RTL8126.
> 
> [0] https://www.spinics.net/lists/netdev/msg1091873.html
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] r8169: enable EEE at 5Gbps on RTL8126
    https://git.kernel.org/netdev/net-next/c/5089cdc1540c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



