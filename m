Return-Path: <netdev+bounces-154720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4491B9FF95A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE6E7A019B
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AEB171E49;
	Thu,  2 Jan 2025 12:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8472944E
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735821156; cv=none; b=kxOC2tEz73/w3N4i3prrPYy0jBlBm6WZHOgfVwgy3Xn3fVR+G9/odnK3yF3ZBFEE3D/68w5TpH3wi4NNHqwAipynvIaAlGiCsVuqD+OeaXOWmWimV3Oy99Af/du8dMPEPpXomcoZBGUpigGKbHfAO6hJvjVd4E1kOPIUv7UF5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735821156; c=relaxed/simple;
	bh=MzV4F5nhygRTD4nOv9UuNlnNuLi+wVJpdUo2sM6rDLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv+mIQeJCYFVjcyLqi6nnEYeoGVf1hkd5RRGuSKtW6zTIIaR70l3hFWkYlfBY/Wv6p5V9JntxoVftYENR4r4KzvocPXw1AztmQ5NP4cNrXePXSSE+JGOf57XHO5fwcv37O0RxX7meEbaW/jTiYXL+BrzdvmvlS5ufzmn3kuBgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tTKNI-000000007GL-0FWk;
	Thu, 02 Jan 2025 12:32:28 +0000
Date: Thu, 2 Jan 2025 12:32:17 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Eric Woudstra <ericwouds@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <Z3aHUYOxCEGf9S_H@pidgin.makrotopia.org>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk>
 <e1e271e3-b684-46d2-879d-e3481d25a712@gmail.com>
 <Z3ZVYeT0vD85Srsd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3ZVYeT0vD85Srsd@shell.armlinux.org.uk>

On Thu, Jan 02, 2025 at 08:59:13AM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 17, 2024 at 08:49:58AM +0100, Eric Woudstra wrote:
> > On 12/5/24 10:42 AM, Russell King (Oracle) wrote:
> > > Report the PCS in-band capabilities to phylink for the LynxI PCS.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> > > index 4f63abe638c4..7de804535229 100644
> > > --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> > > +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> > > @@ -88,6 +88,21 @@ static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
> > >  	return container_of(pcs, struct mtk_pcs_lynxi, pcs);
> > >  }
> > >  
> > > +static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
> > > +					      phy_interface_t interface)
> > > +{
> > > +	switch (interface) {
> > > +	case PHY_INTERFACE_MODE_1000BASEX:
> > > +	case PHY_INTERFACE_MODE_2500BASEX:
> > 
> > Isn't this the place now where to report to phylink, that this PCS does
> > not support in-band at 2500base-x?
> 
> No - look at the arguments to this function. What arguments would this
> function make a decision whether in-band is supported in any interface
> mode?
> 
> The correct place is the .pcs_inband_caps(), which from reading the
> code, I understood that in-band can be used at 2500base-X with this
> PCS. See
> https://patch.msgid.link/E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk
> which was merged at the beginning of December, and if you are correct,
> the patch was wrong.

Yes, that patch was wrong. Neither is QSGMII supported at all by the
LynxI hardware, nor can in-band-status be used in 2500Base-X mode.
I will send a patch to fix that.


