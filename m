Return-Path: <netdev+bounces-184036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B73A92FC3
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC0F1B63033
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC12673B2;
	Fri, 18 Apr 2025 02:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdY7ayAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D36267399
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942201; cv=none; b=e80El9p0ZHVZTiMFCflEzR5uc0BL8Sv7thb6TIuNfxuH1wA98A41R87A33bTPDp0MxREl4sYLc9OaN/B+lU9ILUYwSwug0KPjQgiFdD5V1QhdGhvyAV3EsH2R/sVs/fOxLLVXtv61LbzBOiNFE8fzvOPyVGpOsdmcK75SuGC8QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942201; c=relaxed/simple;
	bh=DojIOl1pVFu1mQqpy1zqyKE8kukp8trKGpMnSq9nMOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jhGdb2nABKJ1rTjFNNYPMyH+W9VizzNN/US8hd0D3Ajnc5IoBBHWIrIZq69B4u4d6HiAcEZQFxI55zRP8MHMLwGtheOA4BGn0CBDt/7qxZJksvsIHoHso6pTeoownjCKIkLkvz0IcsxWmsW4nlkFosOKc8gLJCHHhVyYYhHHJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdY7ayAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6481FC4CEE4;
	Fri, 18 Apr 2025 02:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942200;
	bh=DojIOl1pVFu1mQqpy1zqyKE8kukp8trKGpMnSq9nMOI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cdY7ayAd0nLdploAuNKyMPQR1mPvfrv2vaw+zphf9w5KDt4cM8xoDrhYr6N7Ch6QI
	 ltqKkEr0FJCfjomWwQyRp629dAyrEq81h2JWM/xiRdTEohZmF9fnB8AYDJr5CUB8mZ
	 OdkGLTrgkQW500tyK7uJDdKebeERTpHjRBuRA759cfC5DmNQgelrn66b6oUe9OfG+s
	 A1TDjMScB6bQY6Hao9jPN5QTf/bo8KzkZxy6QWwSJdaG/eqq65wSWEVe614NWWcFou
	 4h9Dpg0wLom6ddUUyfLXFLyEixtA0kOE7MLjcXtx7aj+zeeEdMZRhwulA2KRapQ0j+
	 pn2PfFIKNJIDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF0380AAEB;
	Fri, 18 Apr 2025 02:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: use PHY clock-stop capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494223824.79616.1586155052116698470.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 02:10:38 +0000
References: <E1u4zi1-000xHh-57@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u4zi1-000xHh-57@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, treding@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 11:09:33 +0100 you wrote:
> Use the PHY clock-stop capability when programming the MAC LPI mode,
> which allows the transmit clock to the PHY to be gated. Tested on the
> Jetson Xavier NX platform.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: stmmac: dwc-qos: use PHY clock-stop capability
    https://git.kernel.org/netdev/net-next/c/7c6cd70ffd0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



