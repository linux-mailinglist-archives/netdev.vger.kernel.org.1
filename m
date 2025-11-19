Return-Path: <netdev+bounces-240071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75632C7014B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 327C32FA14
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAD1393DF3;
	Wed, 19 Nov 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT0M/WXX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520836B052;
	Wed, 19 Nov 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569168; cv=none; b=MbomFMJBat3RT8nEUL4lZpDi494wIw31cmiIbrmPavg94i+Euk1RQYDS5S0fnAsTOTFL6BN2TSTIs3drGF+38W+y+7WeBKXil8XGu6FZqZjpT2yC7x/GJRnWi5pLd8920vDqB7RyPOUlEJP/KFAMmHvuTvI+cDIGbqEl48X7bXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569168; c=relaxed/simple;
	bh=BPzTK2gEFsViZFmyOno1UxdtkaYyPLFM9cgU3Gme0aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCCA/dHxMVXpBJa7G+f+n4sO55EVWgYFyuWcYPtk2NQoFcqRiYshwIiYsVlY8VQ5XAznnZW9ct4HtxIiEaA8LLtxciN9P0YBNa7IYdNDpSScbvTIBjRgk1eFP10Up/vxkP1SGkhQawdkCMzcUu17FoKeJ1pUKjG+SRYQiM8iTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT0M/WXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E806EC116B1;
	Wed, 19 Nov 2025 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763569168;
	bh=BPzTK2gEFsViZFmyOno1UxdtkaYyPLFM9cgU3Gme0aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qT0M/WXX2B9Kv1nVbIu43kmraVe20viEsQAOxsj+uCaOZTXTFtX5KOnOvI5cfNmZm
	 1fSlTx54W2q3AxaOoKrmQ5pzDOPg+pJvj3VKLpbGobNGSgppaNPXtlUIWhPBR50WJh
	 Sybx5lTWfm5yXaL76r02PUgOwjW90/L9Zjl0USXTbFCERWWrMzx+17YRsqTwijis8Q
	 u0JdTIiPOpqWZjC3uWRDxBEVjq+u+lKKpHddPkhK8sBHV0LoczsBu6274ZzhzcU0FC
	 Sm151mMoH8kI9mCj1Er9C34XhLeKg+50DT2lamDVDt3hO8+WOpEkC5xAdI5oU845dQ
	 ooQgLNOwT7Uaw==
Date: Thu, 20 Nov 2025 00:01:36 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 resend] net: stmmac: add support for dwmac 5.20
Message-ID: <aR3p4NBK-AnCGK6a@xhacker>
References: <20251119153526.13780-1-jszhang@kernel.org>
 <aR3snSb1YUFh9Dwp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aR3snSb1YUFh9Dwp@shell.armlinux.org.uk>

On Wed, Nov 19, 2025 at 04:13:17PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 19, 2025 at 11:35:26PM +0800, Jisheng Zhang wrote:
> > The dwmac 5.20 IP can be found on some synaptics SoCs. 
> > 
> > The binding doc has been already upstreamed by
> > commit 13f9351180aa ("dt-bindings: net: snps,dwmac: Add dwmac-5.20
> > version")
> > 
> > So we just need to add a compatibility flag in dwmac generic driver.
> 
> Do we _need_ to add it to the generic driver? Do the platforms that are
> using this really not need any additional code to support them?
> 
> Looking at all the DT that mention dwmac-5.20 in their compatible
> strings, that is always after other compatibles that point to other
> platform specific drivers.
> 
> So, can you point to a platform that doesn't have its own platform
> glue, and would be functional when using the dwmac-generic driver?

Synatpics platforms use the dwmac-generic driver, it's enough now.
But we haven't upstreamed related platforms, but will do soon.
> 
> For reference, the dts that refer to dwmac-5.20 are:
> 
> arch/arm64/boot/dts/renesas/r9a09g047.dtsi
> arch/arm64/boot/dts/renesas/r9a09g056.dtsi
> arch/arm64/boot/dts/renesas/r9a09g057.dtsi
> arch/arm64/boot/dts/st/stm32mp251.dtsi
> arch/arm64/boot/dts/st/stm32mp253.dtsi
> arch/arm64/boot/dts/st/stm32mp233.dtsi
> arch/arm64/boot/dts/st/stm32mp231.dtsi
> arch/riscv/boot/dts/starfive/jh7110.dtsi
> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

