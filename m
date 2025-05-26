Return-Path: <netdev+bounces-193505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA0CAC4426
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F9B1787E0
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476E1DF739;
	Mon, 26 May 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu+IVvFh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9502CCDE;
	Mon, 26 May 2025 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748288994; cv=none; b=HlXlSrXms8TkD+RbAraAMHuQRGeKpNYS5zQSHLBBf7ZbGCS395KbSx4apewI8NLPujz/f0GNWDf4JdMZYTEl9PnUBHCtmlsUBzKj69hp4BNCn8piVR7Dqv1fB9GHvoYhamVtCKnb8x/JtNQca/h3cdW0D7TeSOB3CUaCQyKIZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748288994; c=relaxed/simple;
	bh=Ga+2N+JbxfGIi55YTKG5xpDsUC3+mtfi/Wldi3SdsO4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o3qX+3cHeodpaAj2QhxABYSe45uojTW5u6dW76gQhj8GgV7gAox3eLCQgXm/w2j07HDPY9akNqzqdSCqFOdyYnGOaq91mB/WiYIwgap6i3NAA5cePN0fLwj6iSlQks00p0Vbpa32rveaQZGM63deO9EgRXuAqhTbEBgDyKtVJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tu+IVvFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2193C4CEEE;
	Mon, 26 May 2025 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748288993;
	bh=Ga+2N+JbxfGIi55YTKG5xpDsUC3+mtfi/Wldi3SdsO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tu+IVvFhAKkr9oiXM6WvKZtF+eS0u+j77ca4wPaR2RmK0jHDaeaJkwU5ge/lPLnNA
	 ClIcgYs95pgwf7duY+gdkL1Zm3hLP8cYwbYgyweVWfmQR53YU1Rz6iZV29TkUMAaOc
	 aQKfQP07KwOOMsTZdwvbA1szRjSKMWdI4oelTGNtCTaYaFKFG0kNDx2rozSAjDqO4B
	 D8qCAipOkc8TlPreJ9vmHxeeaABXNqMrg6eg2K2LyfeQkHARJds883jC0nQ0rX4Roj
	 +I8ED8PPw3/1SrNHl27bpFJ9JZnIIdxZG05c5CxsuNDitWnA6RBH284Sp8rIMB1y29
	 SNe0ESNB95h2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712793805D8E;
	Mon, 26 May 2025 19:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lan966x: Fix 1-step timestamping over ipv4 or ipv6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174828902825.1028237.3579220220361870619.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 19:50:28 +0000
References: <20250521124159.2713525-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250521124159.2713525-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 14:41:59 +0200 you wrote:
> When enabling 1-step timestamping for ptp frames that are over udpv4 or
> udpv6 then the inserted timestamp is added at the wrong offset in the
> frame, meaning that will modify the frame at the wrong place, so the
> frame will be malformed.
> To fix this, the HW needs to know which kind of frame it is to know
> where to insert the timestamp. For that there is a field in the IFH that
> says the PDU_TYPE, which can be NONE  which is the default value,
> IPV4 or IPV6. Therefore make sure to set the PDU_TYPE so the HW knows
> where to insert the timestamp.
> Like I mention before the issue is not seen with L2 frames because by
> default the PDU_TYPE has a value of 0, which represents the L2 frames.
> 
> [...]

Here is the summary with links:
  - [net] net: lan966x: Fix 1-step timestamping over ipv4 or ipv6
    https://git.kernel.org/netdev/net/c/57ee9584fd86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



