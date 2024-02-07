Return-Path: <netdev+bounces-69906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3515B84CF70
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AAA1F28CD0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219D382D8C;
	Wed,  7 Feb 2024 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hotxVQdK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EFB823C3
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325830; cv=none; b=uRRqaTd/6VspTGWpKtkmtt592boziMKyG8phTS+Wf+WUKvhZQpYfzw/Wz5uAN0h4l17DQ/0yc1VWKT2ftzJGTG74qLUjf2D9aTSyF+i2wnGTtd5qId7tZxaOQJPOo/AAd/uLcoKkuyrd2e6pMf4E+5qe0pTTYLF+kS14VoC+Ssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325830; c=relaxed/simple;
	bh=rbi1Mri1Q1kvWYtXQKDMaRM+0y0i4iW40rVJZRr8moY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rqmvY3cwM8OkDivC5M/QfP7HQAVBihHPNvB4IVRmmaXfUum2HBDxDjElniJvg6rUbzendoq7jXTUchoVHIMStR2zNkAfhgdPmhV3kA5Lt7glZbakL5gqj3DQ0nkCY8dAbK8LDTq8JwYxcyHR2R6BKRsa9bb4aJvdfqwx/u0oWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hotxVQdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71F2DC433C7;
	Wed,  7 Feb 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707325829;
	bh=rbi1Mri1Q1kvWYtXQKDMaRM+0y0i4iW40rVJZRr8moY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hotxVQdK3akuF6Gr/P+sQHz7c6hKc7k5miFraUa6qHP4gtcEPFyWsKN8IQkV6CbN9
	 YMrBD/wuMWyRVV2eeezjo4NTL54l4LZbKcTLhbDtIaHkbJDYy9U9tEz8MAoeiXTf9x
	 GS5RFMVclnOHSlQDpFL1czceakX2yrBNRQEiehJhUjM4cly8q3GUTjSL2zBwqXha8/
	 pWKDPWAg01s97Exa2AI4XGVw7H2mpbi4MrV7aVLyYxj/Vt9F9nqutRdCm7YZlS6iBE
	 SzesYfAM1/k0AN5CjFADIYKLmQcCIi2+hFSsHrmBH9ghu9zBGTohY2bX/iKA1J8wuf
	 REsSktiajCIbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57FC9E2F2F1;
	Wed,  7 Feb 2024 17:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] net: eee network driver cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170732582935.14396.12248558616645018742.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 17:10:29 +0000
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
In-Reply-To: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 bcm-kernel-feedback-list@broadcom.com, bh74.an@samsung.com,
 xiaoning.wang@nxp.com, davem@davemloft.net, opendmb@gmail.com,
 edumazet@google.com, florian.fainelli@broadcom.com, kuba@kernel.org,
 joabreu@synopsys.com, justin.chen@broadcom.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, linux-imx@nxp.com, pabeni@redhat.com,
 shenwei.wang@nxp.com, olteanv@gmail.com, wei.fang@nxp.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 4 Feb 2024 12:12:43 +0000 you wrote:
> Hi,
> 
> Since commit d1420bb99515 ("net: phy: improve generic EEE ethtool
> functions") changed phylib to set eee->eee_active and eee->eee_enabled,
> overriding anything that drivers have set these to prior to calling
> phy_ethtool_get_eee().
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] net: stmmac: remove eee_enabled/eee_active in stmmac_ethtool_op_get_eee()
    https://git.kernel.org/netdev/net-next/c/0cb6daf549f9
  - [net-next,v2,2/6] net: sxgbe: remove eee_enabled/eee_active in sxgbe_get_eee()
    https://git.kernel.org/netdev/net-next/c/d0d8c548789d
  - [net-next,v2,3/6] net: fec: remove eee_enabled/eee_active in fec_enet_get_eee()
    https://git.kernel.org/netdev/net-next/c/b573cb0a5586
  - [net-next,v2,4/6] net: bcmgenet: remove eee_enabled/eee_active in bcmgenet_get_eee()
    https://git.kernel.org/netdev/net-next/c/409359c1c2ef
  - [net-next,v2,5/6] net: bcmasp: remove eee_enabled/eee_active in bcmasp_get_eee()
    https://git.kernel.org/netdev/net-next/c/0cbfdfe3fb80
  - [net-next,v2,6/6] net: dsa: b53: remove eee_enabled/eee_active in b53_get_mac_eee()
    https://git.kernel.org/netdev/net-next/c/3465df5533af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



