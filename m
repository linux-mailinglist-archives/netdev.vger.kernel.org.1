Return-Path: <netdev+bounces-193981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D490DAC6BB5
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40BE189EB95
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F8288C1F;
	Wed, 28 May 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0g0dZYmb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF8548EE;
	Wed, 28 May 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442762; cv=none; b=WCedmAtR84Y7ZhNRJnvuKaiqnLYWYwE8+dNgzcvct/Gmaggq+Onk7eUrwwEkplL6KWshIqvzkji81KB823BxA4/qFgSWtwGzau3tzhOCVPhoNq62siSnGo6rkOTWlg98MbCwkNsMuuVcoM2kpNkqNgB3xBuIMHEn36mKeGv1uyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442762; c=relaxed/simple;
	bh=1vSCO5vTiinfXc1wGmDJEIBv6Q5jDE79VgZ6H2zNW6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cz/13QY+huomBUoVAINd9RIn4Ep+nG5bQpXf4ZBj9kwnbe9RhYCDDaQNuJEe/MhpgN1+UYfExxm/Ch2aaVGrwaILBfn6lJ3BhmKZQ1heAMNGPLeTxRrtDzPK0PYFDQnGlWBfUwI4RLOE29Rlv3N5Ch0vaybY2RQ0fIUPw1mZyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0g0dZYmb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U+FDShjpx6kGEUB2/dQKTjU6xdyCNeX5trpYm619UV4=; b=0g0dZYmb7qFGfQ6Gt46nLap1SM
	L54LEYGcitbtYKGtm9Fz/qwyr1CXW4N6f2R0fuO8qrUfCyopQMDIvPocpm79WXDEZ6nYQVga+Dxli
	tsnaCIBD9NDb0B3YXnWZ5FFmDWioIi3kERl1fFLstxdirVcevQWSL3slMVX/xcjm6J5fzLvljyKX6
	DuK4Lq/+Zgs3yg0vnTiIurv7ny7d2x+Y9Ynr+4A6DwvY/9aZcbAAWJkLUC6TfjccvbKpNqTSjRuog
	bu18UN9MXxuWyUJKrjjFyQjmJRpewfpkHUvev73LP6t2aRCste0h1QQmVmxs7Gwy0RQL8nQ5uYkcl
	GCfODJSw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38612)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uKHpN-0000Ns-0k;
	Wed, 28 May 2025 15:32:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uKHpF-0002UB-2v;
	Wed, 28 May 2025 15:32:13 +0100
Date: Wed, 28 May 2025 15:32:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	vladimir.oltean@nxp.com, yong.liang.choong@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	0x1207@gmail.com, boon.khai.ng@altera.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v2 2/2] =?iso-8859-1?Q?ethernet?=
 =?iso-8859-1?B?OqBlc3dpbjqgQWRkoGVpYzc3MDCgZXRoZXJuZXSgZHJpdmVy?=
Message-ID: <aDcebRguDnM7sqVk@shell.armlinux.org.uk>
References: <20250528041455.878-1-weishangjuan@eswincomputing.com>
 <20250528041634.912-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528041634.912-1-weishangjuan@eswincomputing.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 28, 2025 at 12:16:25PM +0800, weishangjuan@eswincomputing.com wrote:
> +static struct clk *dwc_eth_find_clk(struct plat_stmmacenet_data *plat_dat,
> +				    const char *name)
> +{
> +	for (int i = 0; i < plat_dat->num_clks; i++)
> +		if (strcmp(plat_dat->clks[i].id, name) == 0)
> +			return plat_dat->clks[i].clk;
> +
> +	return NULL;
> +}

Okay, I think this driver is mindless copying of dwmac-dwc-qos-eth.c
between 24th February and 9th April 2025. I can say this because I added
this function to that driver and later removed it.

Looking at the rest of the code, I doubt this even does anything useful
(hence "mindless copying") as you're not fetching any clocks into this
array, and plat_dat->num_clks will be zero here. Thus, this will return
NULL. Therefore, you haven't thought about whether you need this or not,
but have just copied dwmac-dwc-qos-eth.c and then modified it until it
works for you.

You haven't acknowledged where you derived this code from - you've cut
the header of your source file out, and basically are claiming it to be
all your own work. I know this is rubbish for the reason I've stated
above. This is quite simply plagiarism. I am not impressed.

Thus I will end the review here, and simply state that this is not
acceptable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

