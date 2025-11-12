Return-Path: <netdev+bounces-237797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C51C5048E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BCAC34CC31
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0618B29D289;
	Wed, 12 Nov 2025 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HokDcZyb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63BB29CB4C
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912853; cv=none; b=YV2q4Ae3j7ox27I1IhvedGcIxOhS91+I+WM/y1O66wBMMfNJbHqPI9X34cMevHH0AXwmTDIPv1dE4Fv0QZ7lye0ARaWmW9X8KlR0l8Mf6EnQ/1ncrHfPkx7qKkeVS9vOJ58rZl4MWGDWJdv7HQCI5hxU6DQH8sq7O1o3djjsXi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912853; c=relaxed/simple;
	bh=Juz6pLF7SAhgmhKL45ZMU0F5tm2E81SzTf1c2RwwZA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=skhgRmts1I5uNwS6c3QgfboGXKYaUBD+b3PvrSQn9+N1o0PXcVJLDWIjV0y/WMn+VV7OYMQv3xzwLmEFwix2NU1cLG73ZZmMTGhp5IoLhyAQG93hVxPKDHFac+c3Nz/HxLVL4IaIOAKnpoVcv6eknjPD5sJQ3weGEkq2GkCmmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HokDcZyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A715EC4CEFB;
	Wed, 12 Nov 2025 02:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762912853;
	bh=Juz6pLF7SAhgmhKL45ZMU0F5tm2E81SzTf1c2RwwZA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HokDcZybggXfHF3SNp/0uNcSapDRBFf1O6vQpLIU2pojcO61vWpR9HJibg4Jz1e+0
	 e5+Ku76PdB46WqZ3+F5yNqCQM9hzqrgxbhYCYxFD3YKCirmK/4doMpl7B8nxNq0292
	 dhM22tKgktPPd0poKBVbgQQqVepMjJlT8dDtrkaPO4vdaiEy24+QpkXoWIhQxsxXJC
	 suVvdv+GEjcBErCTq5sgx09mK0LhrHvx5K0xHlai1nc87B7x/S1gHQQ1z3n9FTnuc1
	 piFo0/axYSBrVrAdE0ExxJ7FwpaLCiVOYg3SWBd5wdX+fK1iMCqwUC33+xIGFm4dTU
	 Reyi7X//KPopw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB14A380DBCD;
	Wed, 12 Nov 2025 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: stmmac: convert meson8b to use
 stmmac_get_phy_intf_sel()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176291282374.3632748.15831065649442897979.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 02:00:23 +0000
References: <aRH50uVDX4_9O5ZU@shell.armlinux.org.uk>
In-Reply-To: <aRH50uVDX4_9O5ZU@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, jbrunet@baylibre.com, khilman@baylibre.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, martin.blumenstingl@googlemail.com,
 mcoquelin.stm32@gmail.com, neil.armstrong@linaro.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Nov 2025 14:42:26 +0000 you wrote:
> This series splits out meson8b from the previous 16 patch series
> as that now has r-b tags.
> 
> This series converts meson8b to use stmmac_get_phy_intf_sel(). This
> driver is not converted to the set_phy_intf_sel() method as it is
> unclear whether there are ordering dependencies that would prevent
> it. I would appreciate the driver author looking in to whether this
> conversion is possible.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: stmmac: meson8b: use PHY_INTF_SEL_x
    https://git.kernel.org/netdev/net-next/c/12f42597ab14
  - [net-next,v2,2/3] net: stmmac: meson8b: use phy_intf_sel directly
    https://git.kernel.org/netdev/net-next/c/52d639da6fee
  - [net-next,v2,3/3] net: stmmac: meson8b: use stmmac_get_phy_intf_sel()
    https://git.kernel.org/netdev/net-next/c/da3d1501235d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



