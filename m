Return-Path: <netdev+bounces-91978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F167A8B4A99
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 10:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D42F1F21082
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6692251C3E;
	Sun, 28 Apr 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w3CANs5t"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1002F25
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714291386; cv=none; b=EFYuy5GpZGpNDzj+ltvzwL6S/bm3HQR27jaCoHCoXmi6e2ukXMKf259Oihu+1Ja8MDYqSbC+WON5GH1O3RgZwKatdksaI/t9nn8O+rpoONnmzWJiNFM6n2+M3sdOBdqsUpdmWU7ukUaLhs94Ij0Wn9b9izZJKE9yv966rtEtaMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714291386; c=relaxed/simple;
	bh=QGAF4qq/tEin8kIAejZ00BKtRw6wQuWKwNBaHDFoSXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJXnYPadOVJxOfxIlV1Z+gmBRhSvn0OBD7QwUZbKM3bTvP9+ohlx6occiqQASf3kXc1CFdSPef90yHCDKOKhZHMV13GnZGidwHW7I7KkInWiqrOdeNUU2PKbF1xTLRNDHqSuq2vjB5r2GjQuAL2W/VrdRCJ4+LAu1oR2xSu+qCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w3CANs5t; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KGDQo0t759s95QOorryyCACjSQ98VsTdO8SJgtTjyf4=; b=w3CANs5tuEoruo6wb8lkyxl8M3
	ywyfk7YOFE1xCb71qo0E9tRp8Nj45LQL1Zmd0KpOJuw9uURr2tB6s9PAyEZ//pOS1tQCobFpgISOZ
	iv7k4i3aCEGamBBlDgQ3/51npJ7QRkF3QvkEbmsowDEv3zMkpcVSXwOS7u82zmBXUAWi0BRIz3Wcl
	NPcozBhLN/rQFAWwZxfCpd0GTX3heXKrtvKQfMMIfwhQxOF4qSaS0h7H2nTsl6A31M8hr8fc81DL2
	x2cmC/ynMPJ3UJobJ+fsVOC5VL2BJXb3v+0ixKja3Q4fS4o2V1DrG45H7se1k4EJlGaMxF2bbxVZG
	ABm8G8iQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48534)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s0zUi-0001zx-2L;
	Sun, 28 Apr 2024 09:02:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s0zUh-0008CX-RI; Sun, 28 Apr 2024 09:02:43 +0100
Date: Sun, 28 Apr 2024 09:02:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>,
	'Paolo Abeni' <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: txgbe: use phylink_pcs_change() to report
 PCS link change events
Message-ID: <Zi4Co2TEqmeATTgy@shell.armlinux.org.uk>
References: <E1s0OH2-009hgx-Qw@rmk-PC.armlinux.org.uk>
 <064b01da9940$baa36cc0$2fea4640$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064b01da9940$baa36cc0$2fea4640$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Apr 28, 2024 at 03:50:24PM +0800, Jiawen Wu wrote:
> On Sat, April 27, 2024 12:18 AM, Russell King <rmk@armlinux.org.uk> wrote:
> > Use phylink_pcs_change() when reporting changes in PCS link state to
> > phylink as the interrupts are informing us about changes to the PCS
> > state.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> > index 93295916b1d2..5f502265f0a6 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> > @@ -302,7 +302,7 @@ irqreturn_t txgbe_link_irq_handler(int irq, void *data)
> >  	status = rd32(wx, TXGBE_CFG_PORT_ST);
> >  	up = !!(status & TXGBE_CFG_PORT_ST_LINK_UP);
> > 
> > -	phylink_mac_change(wx->phylink, up);
> > +	phylink_pcs_change(&txgbe->xpcs->pcs, up);
> > 
> >  	return IRQ_HANDLED;
> >  }
> 
> Does this only affect the log of phylink_dbg()?

It means that phylink won't react unless the PCS is being used. The link
status should be coming from the PCS block since MII itself doesn't have
the notion of link status.

I'm trying to get rid of phylink_mac_change(), which was fine back in
the days when it was invented (when phylink didn't distinguish between
the MAC and PCS) but it now does.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

