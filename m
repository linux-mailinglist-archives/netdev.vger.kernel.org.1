Return-Path: <netdev+bounces-154686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7749FF725
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F02188267F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E1199943;
	Thu,  2 Jan 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="P0nQ7ipf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674EB195B33
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735808386; cv=none; b=aebxtHzH6C6PCpaJG6gZ2G/T14XpTwMeblGLS8HSuv5Lc/9/rKfrj7haVNXdU2UaoHFj9aAiCYd5im8hkudLygUqd6+RY3K56LxtRFr4x37jx58Q71KlOHIqbbOkdO2H5eNQKyVZaWjtrIWc6BtP8TYPOjJ+a0cUACvZnJfurmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735808386; c=relaxed/simple;
	bh=yyJ1QkSqNcWPaO5sD86IZ3t+LL/Ipip2xsDD5a/uUjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu0Y6+ykTmtVtaU/lkxz1+J3mpAckMhfRDZC/H5/t24FV92XTQO49Akqk42wcUag6ecRzVv6VtXttMYwXUjiQr0Mjz5T77SrSvhzC2CagyFsmmzdq8550hoHdKBAk0/YFVYsQuiHI8CZj+IyialoJrwvU4N+z/bQeOv0Pqvf9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=P0nQ7ipf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GuzBbqkS/z0WnT3EUTrIONeKqkaT9Dd7A20R0CmxM10=; b=P0nQ7ipfrJ/GVTcuxDFmXS9x4S
	NBziIaeO76goIc6IjWfvMTA5jwbO59Xi916Wrp5EbRpRsILdkQuZzaEvtPsfDYAHt+Qx4q5dqhAyw
	YWhytYMHO7hFzmrw2wn+U4dF9HTI3JZ6HKMUyvmQ30iLEyRLXfBJgfBOQHHQMwTso6s4XTMMbpioR
	etfcpbA3ZEBEcSWxVgmh10/7ctaAGTg9QTJtmFikElQ4WoloRsZ8vhQZp+iY7OvNQCU+rcct2KWSp
	uj39x8c0rGcw3MDvaNOLgOMNfL4S5k5wRIia7forqgx9wRSDNk4KI95dIV8jaiyR+PdPVkzaknN7x
	Uzod0GLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40590)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTH30-0001mb-24;
	Thu, 02 Jan 2025 08:59:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTH2v-00008E-0w;
	Thu, 02 Jan 2025 08:59:13 +0000
Date: Thu, 2 Jan 2025 08:59:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/3] net: pcs: pcs-mtk-lynxi: implement
 pcs_inband_caps() method
Message-ID: <Z3ZVYeT0vD85Srsd@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk>
 <e1e271e3-b684-46d2-879d-e3481d25a712@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e271e3-b684-46d2-879d-e3481d25a712@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 17, 2024 at 08:49:58AM +0100, Eric Woudstra wrote:
> On 12/5/24 10:42 AM, Russell King (Oracle) wrote:
> > Report the PCS in-band capabilities to phylink for the LynxI PCS.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> > index 4f63abe638c4..7de804535229 100644
> > --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> > +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> > @@ -88,6 +88,21 @@ static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
> >  	return container_of(pcs, struct mtk_pcs_lynxi, pcs);
> >  }
> >  
> > +static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
> > +					      phy_interface_t interface)
> > +{
> > +	switch (interface) {
> > +	case PHY_INTERFACE_MODE_1000BASEX:
> > +	case PHY_INTERFACE_MODE_2500BASEX:
> 
> Isn't this the place now where to report to phylink, that this PCS does
> not support in-band at 2500base-x?

No - look at the arguments to this function. What arguments would this
function make a decision whether in-band is supported in any interface
mode?

The correct place is the .pcs_inband_caps(), which from reading the
code, I understood that in-band can be used at 2500base-X with this
PCS. See
https://patch.msgid.link/E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk
which was merged at the beginning of December, and if you are correct,
the patch was wrong.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

