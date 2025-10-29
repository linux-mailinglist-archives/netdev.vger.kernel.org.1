Return-Path: <netdev+bounces-234063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BBEC1C503
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A631D6E55C3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F01B325737;
	Wed, 29 Oct 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EMxl0AuB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F56334C10;
	Wed, 29 Oct 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754506; cv=none; b=MCcHemmFY0slz9QTyBfVp4IcAr/wCRsbt07dOD02Y+gmLME2araEwBNtf3xO5zWiJ7PWOOA/Xi/ePy4fvR0B9IMpQUjdFVVqS/lhAu/AieDuTxxWx6hqYsI8D/No+igXoQ1NTe/K793kihDpwH4Zwbp33TcAjASIrOWWYGhgBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754506; c=relaxed/simple;
	bh=LBomVPTeyBl1Pycs2O5KKxLcBIfHhZ3qnDqA5zcS7rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx/Twfs4FDOlNxgExQc+qN5Rvq4s7/UWXS4IkVmqHdTkk5HsZ2nKsSftD/8xL3R47H3P2TIG6JnTu3v621ty3IbWNweW3hUHCxzajMXBA/oNdkNkTsHKQBEh8VWUhZmLpdx5MBUkKNQDoUHXjaTDf88xNE0N9gUQLCKeuhM96fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EMxl0AuB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W1uta8p/W5QNqzGp1HZ4zz99/QdMe5/qSC/Dn+nw3nE=; b=EMxl0AuB+F5NhLkZJJB1QEOz6d
	izBrPIejNaEZTbx1kB9++36hpSVq4VrbjowPsYx+wxYn1n6hWtIB2p5LFEgSEk/losPNx3B0CY8ye
	sCxHCGOBRk+cYdYfJk9L4R3/NETijwSnOr9s4M4h5TtLy+Q3wdwNr7yeJrRKRN49SHAvUE3t2UPDS
	2/uJDN6FCVpX5sQz5b799RklPXywAZOGOzW9PGUHHsIavoD61BRVcRTFi4dwPW6ed0PjSnx/V2gXm
	rQMmufWZRvlV+4WEHLOYcFA5nixNaF4W/UirLbd+QGwTPGcino/bth4BxE6Ag7pzYPwpD0ZV5ryvT
	ZeBJ7pZw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56504)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vE8ow-000000004ci-1h3W;
	Wed, 29 Oct 2025 16:14:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vE8os-000000007eD-12kw;
	Wed, 29 Oct 2025 16:14:42 +0000
Date: Wed, 29 Oct 2025 16:14:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: rohan.g.thomas@altera.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: stmmac: socfpga: Agilex5 EMAC platform
 configuration
Message-ID: <aQI9ckiHEybp3c_y@shell.armlinux.org.uk>
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
 <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 29, 2025 at 04:06:13PM +0800, Rohan G Thomas via B4 Relay wrote:
> +static void socfpga_common_plat_dat(struct socfpga_dwmac *dwmac)
> +{
> +	struct plat_stmmacenet_data *plat_dat = dwmac->plat_dat;
> +
> +	plat_dat->bsp_priv = dwmac;

Surely this is something which is always done? What's the point in
moving this to a function that always needs to be called from the
implementation specific setup_plat_dat() method?

> +	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
> +	plat_dat->init = socfpga_dwmac_init;
> +	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
> +	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
> +	plat_dat->select_pcs = socfpga_dwmac_select_pcs;

From what I can see in your patch series, these are never changed.
So, I question the value of having this "common_plat_dat"
initialisation function. Why not leave this code in
socfpga_dwmac_probe(), and just move the initialisation of
plat_dat->core_type and plat_dat->riwt_off ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

