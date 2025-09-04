Return-Path: <netdev+bounces-219766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEE0B42E6A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBFE546DE5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1354739;
	Thu,  4 Sep 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqIdmYBH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B814A9B;
	Thu,  4 Sep 2025 00:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947004; cv=none; b=NvpGv5abMjzCeWrzLIcdjrt/kRyhdgey6SMesC51DrFZzoFchFXG5TC89EfDTcyTQdUfszTAhmPdjx5n0vE3w7GppiOWZVPtLKF2aMM86PoaDtntgczKI5C171b0tpeOkQ5/6J2kHXvCoFtF3NejMPkWC32zs0chCqZtIjTivrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947004; c=relaxed/simple;
	bh=TPLZYYHX2O7FjFy/jnJH3LGfdUJyPpsJBdOwaOmHBig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p75/CHj8Mk08mbOSbzyTUHS2hC5kWh9ruYZZef3zeMsaghR6xjGtBUW7hdhPah0ERWSaf2wiA4qyTRwD/bIGWSa4I6AAauZ0srcHod4Br/s+7AGNnSdxwvaQaw9p0/IqnafgrlnkggcgiseCDEnoNfAJWoH+xE2bLonjUDvPNSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqIdmYBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D86C4CEE7;
	Thu,  4 Sep 2025 00:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756947004;
	bh=TPLZYYHX2O7FjFy/jnJH3LGfdUJyPpsJBdOwaOmHBig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DqIdmYBHJjUtO2pK2L53kc2sG56LW7Abv/M7iAbQp6Po5kAM55fazoxXfZSme3SL+
	 yAzRI2np4n3YVyqdvoZWJtwOKFHUfEs4La5FzxcaKu3LiBDeu3BoPIchKt+fDwtw0g
	 Y+UFrDeNmJHS3O60kcyYbh68mfz839E7lm7bFH5tXoq3TzdyK7oc9YF5p1luIIkSl6
	 KDc7QYhV3eWGbm8xqQ+3/DCYkvzNkWud8cXdS49rR5ahkP1Z3b52pZcURVmrQ/+Byh
	 FVRGpKlO9VaVwKVpzaRISu2ZhXArbfQt8RLB0Djq045jvajN0W9owo/xQYTS8yI7Ox
	 3p4pDKu+Xnu2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B84383C259;
	Thu,  4 Sep 2025 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] net: phy: micrel: Add PTP support for
 lan8842
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694700901.1251694.3717331290989416543.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 00:50:09 +0000
References: <20250902121832.3258544-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250902121832.3258544-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, Parthiban.Veerasooran@microchip.com,
 kory.maincent@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Sep 2025 14:18:30 +0200 you wrote:
> The PTP block in lan8842 is the same as lan8814 so reuse all these
> functions.  The first patch of the series just does cosmetic changes such
> that lan8842 can reuse the function lan8814_ptp_probe. There should not be
> any functional changes here. While the second patch adds the PTP support
> to lan8842.
> 
> v6->v7:
> - the v6 was not sent by mistake to mailing lists, so this version just
>   sends also to the mailing list
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] net: phy: micrel: Introduce function __lan8814_ptp_probe_once
    https://git.kernel.org/netdev/net-next/c/b9e0c62057a8
  - [net-next,v7,2/2] net: phy: micrel: Add PTP support for lan8842
    https://git.kernel.org/netdev/net-next/c/13d8f54d92a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



