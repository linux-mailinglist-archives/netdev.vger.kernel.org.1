Return-Path: <netdev+bounces-239649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D770C6AF0F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7F334F89D6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94A31ED6A;
	Tue, 18 Nov 2025 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oo3H7YWA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141331ED69;
	Tue, 18 Nov 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486086; cv=none; b=UUgimhcvpGrvf8jF4oCAz/NkCfjdmIC0/L7isoeobjFTGz7/MuKII6eMp3hzswJfXgJFq49ValGIgBtLBgs+L0AhclVTpmSPUSwuXMypgAZV3+eDvMn3B5GGZppqjOKpepv+PMFFmyr5vHSZ/ivcAC5h3+aAA4F+SsdTc2ECD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486086; c=relaxed/simple;
	bh=xfsD+LlKqTaJfHcxKw6CkYmBVdQSbkrAih+rqEc2mUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/qflhQ/riiUn0OScp3hAExqDjZg31VdQFHOazdVSnrj8UN9Hc/Go65lkUG9F26nwk2Xp8GhkjjhLmljAvyNFV9ApzPcLsh1szqiJva3pdneQQBWJ9Vogzfzktg3JkI+lTmOzJASh/7FXME374RLgbBE6s4Ka4CZtK/MR9KrZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oo3H7YWA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ix3qrQo4JTxUkNTnS7E6e3XShNCoCiRudEoAtypBRpU=; b=oo3H7YWA+QMQ7erolFEZGTdwDM
	3czWcf7ljYhymkaI7QbzlkQjYtD9nXQj/d/6sv8b0ZLU/FOGMFxgPOxAs4Uypl6K3T+1GEdQ6YuOl
	npYlXMn2ZKTyKb8C4IAJvJgr7s6QRMrdlX7kZXFrmyd2jG7YRt1fJ8gq02FOEduEIPDgfEAgjzz4u
	QxlxVc/KRGsIN5HGNBpzgo2iUAXqvwCu69IGzdZjC9iAUzGdq0VbRqA9ehqmDNFLwYUWpFs0oyldW
	AlnXKjG4GNJHMX4xp9fXiZZ0zhVfcxGDVqdXXAV9mpoV8tJG0czgIcO6/UO9IYT4nZoHpzzIfbe5e
	MEpV4xcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54398)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vLPHY-000000003Vz-1zpn;
	Tue, 18 Nov 2025 17:14:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vLPHS-000000002cb-0W9K;
	Tue, 18 Nov 2025 17:14:14 +0000
Date: Tue, 18 Nov 2025 17:14:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Rayagond Kokatanur <rayagond@vayavyalabs.com>,
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net v2] net: stmmac: add clk_prepare_enable() error
 handling
Message-ID: <aRypZZ88K8tnh9Ha@shell.armlinux.org.uk>
References: <20251114142351.2189106-1-Pavel.Zhigulin@kaspersky.com>
 <4a3a8ba2-2535-461d-a0a5-e29873f538a4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a3a8ba2-2535-461d-a0a5-e29873f538a4@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 18, 2025 at 03:30:09PM +0100, Paolo Abeni wrote:
> On 11/14/25 3:23 PM, Pavel Zhigulin wrote:
> > The driver previously ignored the return value of 'clk_prepare_enable()'
> > for both the CSR clock and the PCLK in 'stmmac_probe_config_dt()' function.
> > 
> > Add 'clk_prepare_enable()' return value checks.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: bfab27a146ed ("stmmac: add the experimental PCI support")
> > Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> > ---
> > v2: Fix 'ret' value initialization after build bot notification.
> > v1: https://lore.kernel.org/all/20251113134009.79440-1-Pavel.Zhigulin@kaspersky.com/
> > 
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 27bcaae07a7f..8f9eb9683d2b 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -632,7 +632,9 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
> >  			dev_warn(&pdev->dev, "Cannot get CSR clock\n");
> >  			plat->stmmac_clk = NULL;
> >  		}
> > -		clk_prepare_enable(plat->stmmac_clk);
> > +		rc = clk_prepare_enable(plat->stmmac_clk);
> > +		if (rc < 0)
> > +			dev_warn(&pdev->dev, "Cannot enable CSR clock: %d\n", rc);
> >  	}
> > 
> >  	plat->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
> > @@ -640,7 +642,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
> >  		ret = plat->pclk;
> >  		goto error_pclk_get;
> >  	}
> > -	clk_prepare_enable(plat->pclk);
> > +	rc = clk_prepare_enable(plat->pclk);
> > +	if (rc < 0) {
> > +		ret = ERR_PTR(rc);
> > +		dev_err(&pdev->dev, "Cannot enable pclk: %d\n", rc);
> > +		goto error_pclk_get;
> > +	}
> 
> It looks like the driver is supposed to handle the
> IS_ERR_OR_NULL(plat->pclk) condition. This check could cause regression
> on existing setup currently failing to initialize the (optional) clock
> and still being functional.
> 
> I *think* we are better off without the added checks.

Note that the clk API permits NULL as valid. CCF checks for this
in clk_prepare() and avoids returning an error:

        if (!clk)
                return 0;

Same check in clk_enable(). So if plat->pclk is NULL, then no error
will be returned.

Places that set plat->pclk:

stmmac_probe_config_dt() - checks for error-pointers and fails. This
will cause driver probe failure.

dwc_qos_probe() - uses stmmac_pltfr_find_clk() which returns the
clk from the bulk-get or NULL. These clocks will have been obtained
using devm_clk_bulk_get_all_enabled(), which I think will return an
error if any fail, which fails the driver probe.

So, I don't think plat->pclk can be an error-pointer here.

Therefore, I don't think there's any concern with error pointers
or NULL in plat->pclk.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

