Return-Path: <netdev+bounces-142016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F769BCF64
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 15:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFBE2854B3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF51D9580;
	Tue,  5 Nov 2024 14:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C51D5AD7
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817156; cv=none; b=H6A02FoG0kRChv2TvJJvFj+eI3dSv3VSkDSh7lZULZoEoOjTnFH2ZXvMCSSUC4HiFUq9OdjodCfLdrLqlbJcVUxOfsoNQj40RIdMCcoJYxkmc7o4VqThVamIn406GjaZB84Cpdp7vhQiGSZSkNTCOSoqyaTP4ogZBhmcqwtMxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817156; c=relaxed/simple;
	bh=frQxkDxOlabdHzuh0NP3qfAHRwCrzOqfjKrCItIFrBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHie8KWGfDFozFjpvuYBunPrQIqzX1Eomx8EefGvZEkBVixmX/5ICoOiTRonRlFxkvG3Fgh9Mncs9xXiJG3vdrZWGuhoBJtVpKVbpbnD2ktuo3jffxFNn2+rRfcNoN4lqW1rTa1yEBJat0WxFzQAtsHJQE0Tdip0YEmsVECBU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t8KbK-0007mY-SW; Tue, 05 Nov 2024 15:32:10 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8KbJ-0029or-0W;
	Tue, 05 Nov 2024 15:32:09 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8KbJ-00FPHS-07;
	Tue, 05 Nov 2024 15:32:09 +0100
Date: Tue, 5 Nov 2024 15:32:09 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH net-next v3 6/6] net: dsa: microchip: parse PHY config
 from device tree
Message-ID: <ZyosafnNkdqt4JMb@pengutronix.de>
References: <20241105090944.671379-1-o.rempel@pengutronix.de>
 <20241105090944.671379-7-o.rempel@pengutronix.de>
 <20241105152805.25f8b065@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105152805.25f8b065@fedora.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Maxime,

On Tue, Nov 05, 2024 at 03:28:05PM +0100, Maxime Chevallier wrote:
> > +	dsa_switch_for_each_user_port(dp, dev->ds) {
> > +		if (!dev->info->internal_phy[dp->index])
> > +			continue;
> > +
> > +		phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
> > +		if (!phy_node) {
> > +			dev_err(dev->dev, "failed to parse phy-handle for port %d.\n",
> > +				dp->index);
> > +			phys_are_valid = false;
> > +			continue;
> > +		}
> > +
> > +		phy_parent_node = of_get_parent(phy_node);
> > +		if (!phy_parent_node) {
> > +			dev_err(dev->dev, "failed to get PHY-parent node for port %d\n",
> > +				dp->index);
> > +			phys_are_valid = false;
> > +		} else if (dev->info->internal_phy[dp->index] &&
> > +			   phy_parent_node != mdio_np) {
> 
> There's a check a few lines above that guarantees that at this point
> dev->info->internal_phy[dp->index] will always evaluate as true,
> so you could simplify that condition a bit :)

good point :)

> > +			dev_err(dev->dev, "PHY-parent node mismatch for port %d, expected %pOF, got %pOF\n",
> > +				dp->index, mdio_np, phy_parent_node);
> > +			phys_are_valid = false;
> > +		} else {
> > +			ret = of_property_read_u32(phy_node, "reg", &phy_id);
> > +			if (ret < 0) {
> > +				dev_err(dev->dev, "failed to read PHY ID for port %d. Error %d\n",
> > +					dp->index, ret);
> > +				phys_are_valid = false;
> > +			} else if (phy_id != dev->phy_addr_map[dp->index]) {
> > +				dev_err(dev->dev, "PHY ID mismatch for port %d, expected 0x%x, got 0x%x\n",
> > +					dp->index, dev->phy_addr_map[dp->index],
> > +					phy_id);
> 
> In this context, PHY ID might be a bit misleading, as PHY ID usually
> refers to the identifier (OUI + model id used at probe to select the
> driver). May I suggest phy_addr instead ?

ack, will rework it.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

