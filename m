Return-Path: <netdev+bounces-238556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14172C5AF30
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 718DE4E43E4
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D969260565;
	Fri, 14 Nov 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha5jreJ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D43A1D2;
	Fri, 14 Nov 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763085042; cv=none; b=T7ORpyRZrSN2IcfClxj5enhTTAUcEpBcvYVG+EthLXYCiarInBnPi5W/sSEfRRwhhKt4nppW7MaP6rWNyS23Waf62/dPUhgjh37dFfVVLusZliSBCE9CB6gHl0dvTa+P3znwl1HrvACpz1vgVyezTTJVVgY7qSfWzAJEzo+SmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763085042; c=relaxed/simple;
	bh=6EOo91b1didglfRFVY+ZQ1OnMD92ChJmw4ywkp14Bl0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ftL2ng/TtuLbVYGoXb868JZaUn7GKPO6RQ5fZIV7LCG/UEAzDwwWkfmEweGK3TG6d2zP4c+F00cjiFEq/lZgk61RB5Xhg+m6P+QdKRzoL+kgtfaVIqcmtLaAlK7BJklTJzLuUbtN3hMc/Aj3hXGg/icDs+8ne2No6SH1couMb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha5jreJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62E2C4CEFB;
	Fri, 14 Nov 2025 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763085041;
	bh=6EOo91b1didglfRFVY+ZQ1OnMD92ChJmw4ywkp14Bl0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ha5jreJ7rQj7tRe43ONCZWWKZHn5Doz6TEnRQepRYdoOKwW4BJYmg4HMHWdnYiznM
	 Yb4zqcgtoMa9/AniZH32KD6cn0ZPUK2cmcIMuhfZJ4Gi49NHJDTmRz8aUPQ2V3FIHp
	 LUL+sO3DeXRyqX/g4JV0nz7uu660scVrWHGqf06yGKr/7k90N7LuPCi0bwJj2/aqIG
	 +2wB/eKD7FHd06IYOWATYH0Tt8RDQMPMaUk8t/s20BsetjD0xhQdLAlVsncycT30DI
	 YDinX2DtqHnHWbb88zXAa/CirNSf96DpKYPG3Fhsxi1PTZFQuM4WVdWpn2pXSMVzAo
	 gTnFL45frcnbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD813A55F84;
	Fri, 14 Nov 2025 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: pcs: xpcs-plat: fix MODULE_AUTHOR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308501050.1080966.2140094364033187126.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 01:50:10 +0000
References: <20251112211118.700875-1-vladimir.oltean@nxp.com>
In-Reply-To: <20251112211118.700875-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, fancer.lancer@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 23:11:18 +0200 you wrote:
> This field needs to hold just Serge's name.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/pcs/pcs-xpcs-plat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: pcs: xpcs-plat: fix MODULE_AUTHOR
    https://git.kernel.org/netdev/net-next/c/55f943c6af6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



