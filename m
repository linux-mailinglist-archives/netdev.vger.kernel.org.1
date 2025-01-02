Return-Path: <netdev+bounces-154689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 849249FF757
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC907A131F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0211917F9;
	Thu,  2 Jan 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mbx+aB1i"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD21799B;
	Thu,  2 Jan 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735809432; cv=none; b=A1laxhnJMwqDXoQwyWnMsjUlonHDEeO11RoAWuLquDvP2dJJedijOgxDXEvmbrJyhndU0sy+azjk0DvJzi+IAN2KQv8zf7BTv98C09Vwucp7Q0WpDoMCe6QVTobvEBoDA8AFL1asFBt35haoujDxLLzFElYRYop/vWCTtXQg8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735809432; c=relaxed/simple;
	bh=9V1dgEUlNB4VdJKKbhfk4nGItOi+9GmwVdpqrawOE3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV8N1t9avy6VnqLEhdwBWHjddYlqawCLARFm3bzYHIw7xUHqrLT5TkRuaCNrzKyBhonX6YVSymg04PnIL6h2i2gqs98/8neYjruzh5B4V2S0YsnXBN2IjmY91ExPOTStCkP8ekLdxdAMGQLK1uuPi1qSDn14eDDV5aEgqE9Se4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mbx+aB1i; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y0ebg5JYBQo93J+yDyT483SON+/adfVmrWmE2TfO5rU=; b=mbx+aB1irJScO3s1js3RX9QgJi
	sTP1lXV9i4EmdKhwfSYGJtnXZ45gKyckkykk1YzokCgwlfN+x6Msm2JBtU+KeRjVfPFfcfEkuWThz
	9YsfMB1N2AYGUkqUgCOTgFyMRdKpxLq/WS6OqTtGB2h5lyHOI9chM5ucpVkkuQ25wX3JrZVFagkW1
	0PZM13qmuC9xDo+rujrCoOQNTHUgB1C24Zw29R4kwpFfzNh3e5z9/bEJeEQYPdLhJPy2+IYqnItlH
	3WctIYCphARWHzle8H+e2asvYtRaYbpFtk7uO+lNCcoJblpr5Yt4PHW824uRYUNfqQCtPYL7wEvqE
	JoujGgKw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34372)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTHK7-0001nt-1u;
	Thu, 02 Jan 2025 09:16:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTHK4-00009Q-2g;
	Thu, 02 Jan 2025 09:16:56 +0000
Date: Thu, 2 Jan 2025 09:16:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: pcs: mtk-lynxi: fill in PCS
 supported_interfaces
Message-ID: <Z3ZZiCbQb3jFvZMv@shell.armlinux.org.uk>
References: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
 <E1tMBRF-006vae-WC@rmk-PC.armlinux.org.uk>
 <20241217141547.7748b3d3@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217141547.7748b3d3@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 17, 2024 at 02:15:47PM +0100, Maxime Chevallier wrote:
> Hi Russell,
> 
> On Fri, 13 Dec 2024 19:35:01 +0000
> "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Fill in the new PCS supported_interfaces member with the interfaces
> > that the Mediatek LynxI supports.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/pcs/pcs-mtk-lynxi.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> > index 7de804535229..1377fb78eaa1 100644
> > --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> > +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> > @@ -306,6 +306,11 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
> >  	mpcs->pcs.poll = true;
> >  	mpcs->interface = PHY_INTERFACE_MODE_NA;
> >  
> > +	__set_bit(PHY_INTERFACE_MODE_SGMII, mpcs->pcs.supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_QSGMII, mpcs->pcs.supported_interfaces);
> 
> I'm sorry if I missed something, but I don't find where the QSGMII
> support comes from based on the current codebase :/
> 
> I didn't spot that in the inband_caps commit, sorry :(
> 
> > +	__set_bit(PHY_INTERFACE_MODE_1000BASEX, mpcs->pcs.supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_2500BASEX, mpcs->pcs.supported_interfaces);

This list comes from the behaviour of the PCS as it stood before any of
these changes - the PCS code itself never validates the interface it's
passed, except for the call to
phylink_mii_c22_pcs_encode_advertisement() and checking that the
return value is non-negative. This is the only place that the
interfaces will be restricted - and they will be restricted to the
four interfaces I've listed above.

I don't have information on the hardware; so I can only go by the
behaviour of the existing code when making changes - and I take the
approach when adding new stuff of trying to avoid changing the code
behaviour, even if the existing code is doing something wrong.

I think, therefore, that a patch to remove stuff that isn't actually
supported should come after these patches, because that changes the
driver behaviour - otherwise the reason why QSGMII isn't included in
the patch would have needed to be described in each commit adding
extra code dealing with the interface mode.

It would've been nice had the driver implemented .pcs_validate() from
the start, which would've made it obvious which interface modes were
supported!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

