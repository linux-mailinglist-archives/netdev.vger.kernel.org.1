Return-Path: <netdev+bounces-212041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D3B1D6E4
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 13:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BA118973D2
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 11:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0C20B7F9;
	Thu,  7 Aug 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SOQ/bEIE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73731AAE17;
	Thu,  7 Aug 2025 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567235; cv=none; b=odB88PBZCrtzyz1/a3b1o2EYYaH1BzFinFV0pc/rFc0sk5LBRhm9GmZPYsu2WUMFjgP4OtwGy5xeGJqyKBIZJPnmKmDRn/jNJeIYJIIcTin2gO9nqMVDL5yor8yEd2zcekX5hY4xCDpzyrVLz25VXVkuVbY8NwctWQ96QnMy/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567235; c=relaxed/simple;
	bh=CaekhXMweGEbATse0Ot72S3jQtMglVWzZIiE6Ss2x3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KokRyLJ1o/fvFVBTGowBpMGoJZo/k9eFdSyvUecfMTTcvHCu4SOZSBJMttlSuzgLJNdDcMHftEffXSFTV5YkLbUkh5gIdppdR9yc7z40k46lOeDyprI1yIiYynZoKAVkDaGZBjMkpfE02Xp1jSm27D+LSzRFxoiL2A1OPolT3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SOQ/bEIE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F55w2O7FP54zLnSv0RQaIMc8o0k83eet7kxdJLTSrDQ=; b=SOQ/bEIERLfEtrsw8VCWsMERFC
	HG0U/2splUQG/TUua8sz+wxDsDVSNHxEDlUVj1HgSAosKi2DyPSD895afUXx0hI+bVarIdR8piwJF
	Mc+SSd0Kkz0WElFQHLMj50fS6LwCALLUGWVQeds5QEjTMM5OlP60ZBvS3JPtgvDJ3j9DJuS9cNDfJ
	j39TEHKHUzeda1tY3FXPnTLBlh5n7vWTcBvyCDsWviU25jmWfqCu9GaFDdXVetVatE7/LYFSHKlXP
	v74zXGnPp6BiQda04ImRtVHwkTEzwOq04dWJsB8AmNnjbtlTyvBTqCy9ZfrByVGy2EPZoz5vLbpeQ
	+SAJpBvQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34792)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ujz5O-00061v-11;
	Thu, 07 Aug 2025 12:47:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ujz5K-00085X-32;
	Thu, 07 Aug 2025 12:47:03 +0100
Date: Thu, 7 Aug 2025 12:47:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com,
	o.rempel@pengutronix.de, pabeni@redhat.com, netdev@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <aJSSNg4aZNfoqqZh@shell.armlinux.org.uk>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
 <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
 <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
 <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 07, 2025 at 07:21:46PM +0800, Xu Yang wrote:
> Hi Russell and Andrew,
> 
> With more debug on why asix_devices.c driver is creating so many mdio devices,
> I found the mdio->phy_mask setting may be missing.

mdio->phy_mask is really only a workaround/optimisation to prevent
the automatic scanning of the MDIO bus.

If we know for certain that we're only interested in a PHY at a
certain set of addresses, then it's appropriate to tell the MDIO/phylib
layer not to bother scanning the other addresses, but this will mean
if the driver uses e.g. phy_find_first(), it will find the first PHY
amongst those that phy_mask allows to be scanned, rather than the first
on the bus.

In other words... it's dependent on the driver.

> diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> index 9b0318fb50b5..9fba1cb17134 100644
> --- a/drivers/net/usb/asix_devices.c
> +++ b/drivers/net/usb/asix_devices.c
> @@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
>         priv->mdio->read = &asix_mdio_bus_read;
>         priv->mdio->write = &asix_mdio_bus_write;
>         priv->mdio->name = "Asix MDIO Bus";
> +       priv->mdio->phy_mask = ~BIT(priv->phy_addr);
>         /* mii bus name is usb-<usb bus number>-<usb device number> */
>         snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
>                  dev->udev->bus->busnum, dev->udev->devnum);
> 
> Is this the right thing to do?

If we're only expecting a MDIO device at priv->phy_addr, then I
guess it's fine. Looking at the driver, I don't understand the
mixture of dev->mii.* and priv->mdio->*, and sadly I don't have
time to look in depth at this driver to work that out.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

