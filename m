Return-Path: <netdev+bounces-241697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C131C87736
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38045353DEC
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66502ED87C;
	Tue, 25 Nov 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Tmkl9DgG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653892C327E;
	Tue, 25 Nov 2025 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112766; cv=none; b=hd+sYs5oFw6YRL9iNLKczboGpGNyzbDU2uqfjDuAAbS3sQ0+uLMipKjSPAzAmA8zGXE1ur194XnT2L7cTN8pEVgBGU857Oyf5wt7tPpN1x7gi7f7ovDQdRjAxL12rUTWBBh7KWn7enOwSpeMJK9gyUr1UCE6e5DV5/bgbUbFi6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112766; c=relaxed/simple;
	bh=oFdOAM6ZwpderCZqBuZ+lnCixgHSDB3mwSe5yeRR/M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7Jk6vSbqAbl4ygFa9Ulxpa6lV2mXFbg/hphHf5wEzvCjdMBRl2HIpIc5iY3DI6AMfCgGqoi02Y20R+OM9i1GMmoyk5xj+v/oyrBqCd+2fGogNs52GM+TX76xzt0fyNpx73Gtes8AuyYcOEdp1OGvD5vwB+GM+vbUQDXlY1Ez9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Tmkl9DgG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ukMBHd2xprh1k/N8cNGlN+MYj/FJerUlkN0OU+0nrSM=; b=Tmkl9DgGtXT1tFoDpAdbmsXLu2
	wPfi67ITjX3MMczRG20rf2PbUhq4ZGCG/KDNkBGrpGO+cN+ZFzUAi1UFWV1q9dAU55D65VFvfK/+v
	CijIMS61dPmELwsL21oN9hO8F057RmwJbKrEu0o9u66hmRyhu7TYQJL4I1Xcyzr9ienz1xQ78akqf
	RquMtihWgU9RyHFTEoJ+Hw2IsjlFXCPXyzGrOLfg2QnvLGfG0eFuUlqnxqH1oCpROSyT/AjVs7xCl
	VuniJyZ9A2qMyXOxayYK+EASCMWoEKAOE3jDp0UaeuKiqTAxpRI140EdlLrjJIwKMqVxAEAdPTBM4
	4wrPwEKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56056)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vO2JU-000000003IU-2m6E;
	Tue, 25 Nov 2025 23:19:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vO2JQ-000000001AF-0Uv7;
	Tue, 25 Nov 2025 23:19:08 +0000
Date: Tue, 25 Nov 2025 23:19:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Fugang Duan <fugang.duan@nxp.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: Fix E2E delay mechanism
Message-ID: <aSY5ayT0X_zFeYFs@shell.armlinux.org.uk>
References: <20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 25, 2025 at 10:50:02PM +0800, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> For E2E delay mechanism, "received DELAY_REQ without timestamp" error
> messages shows up for dwmac v3.70+ and dwxgmac IPs.
> 
> This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
> Agilex5 (dwxgmac). According to the databook, to enable timestamping
> for all events, the SNAPTYPSEL bit in the MAC_Timestamp_Control

bits

> register must be set to 2'b00, and the TSEVNTENA bit must be cleared
> to 0'b0.

Are you sure 3.70 is the appropriate point. According to the 3.74
databook, SNAPTYPSEL changed between 3.5 and 3.6.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

