Return-Path: <netdev+bounces-255974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCFDOhvpgGleCAMAu9opvQ
	(envelope-from <netdev+bounces-255974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:12:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D89CFFAE
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15EC302294E
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AAC38946E;
	Mon,  2 Feb 2026 18:09:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1112248A8;
	Mon,  2 Feb 2026 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055772; cv=none; b=K7hJF9W333zVTE69vg85eQGzoKxgBg7gRocaHNXkkc1AZLUCDdT0mv3lTRcA7bGx1tIYnee1vabRnR40xbPeOe9U4H8TmoX4M+rSUfb4/QlhLpL1+EegMoryzXShey2uXdAJQ2udqUtC4B1nDlg3eDu9STAtHUnKFh4QrX/vu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055772; c=relaxed/simple;
	bh=viPzO1OIsG8xBjLEk/McdydKjkbMWxBClZM+2L19Uds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kijVwspYY1owe/Wrlh2KmLqDXR6Bgf+3juleRMqdYxWlIM4Bjym+rQuSxo3dDV3hGO4j7nc44PsuTBQKWSb+BjmxbOCy6M/7pCmQKvvkJ3jV8UeaVyI0dyX/i0jHQhCIiSeeLX65NHarpSOobTgaBUBHXCa1pKqiBdXIsLaWvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vmyMU-000000001P7-1Dmt;
	Mon, 02 Feb 2026 18:09:22 +0000
Date: Mon, 2 Feb 2026 18:09:17 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v12 4/4] net: dsa: add basic initial driver for MxL862xx
 switches
Message-ID: <aYDoTSySNt7vXazL@makrotopia.org>
References: <cover.1769908155.git.daniel@makrotopia.org>
 <c5895811389aed7f426ed9c9461e8ac0e8017da1.1769908155.git.daniel@makrotopia.org>
 <20260202102326.vz5qhg6wzzje553v@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202102326.vz5qhg6wzzje553v@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-255974-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: 51D89CFFAE
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 12:23:26PM +0200, Vladimir Oltean wrote:
> On Sun, Feb 01, 2026 at 02:25:13AM +0000, Daniel Golle wrote:
> > +static int mxl862xx_setup_mdio(struct dsa_switch *ds)
> > +{
> > +	struct mxl862xx_priv *priv = ds->priv;
> > +	struct device *dev = ds->dev;
> > +	struct device_node *mdio_np;
> > +	struct mii_bus *bus;
> > +	int ret;
> > +
> > +	bus = devm_mdiobus_alloc(dev);
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	bus->priv = priv;
> > +	ds->user_mii_bus = bus;
> > +	bus->name = KBUILD_MODNAME "-mii";
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mii", dev_name(dev));
> > +	bus->read_c45 = mxl862xx_phy_read_c45_mii_bus;
> > +	bus->write_c45 = mxl862xx_phy_write_c45_mii_bus;
> > +	bus->read = mxl862xx_phy_read_mii_bus;
> > +	bus->write = mxl862xx_phy_write_mii_bus;
> > +	bus->parent = dev;
> > +	bus->phy_mask = ~ds->phys_mii_mask;
> > +
> > +	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
> > +	if (!mdio_np)
> > +		return -ENODEV;
> 
> As per the dt-bindings patch, the "mdio" child node is not required.
> But here it is.

Now that ports are counted from 0, and 0 being the microcontroller, the
port number no longer matches the PHY ID, so I suppose I got to change
the dt-bindigns as that kinda makes the mdio node mandatory for anything
to work.

> 
> All user ports are given a valid non-NULL dp->cpu_dp pointer. I strongly
> oppose introducing FUD in the code. If there are valid reasons behind
> this I'm all ears, but there aren't.
> 

Looking at other drivers I thought that, and regret not having challenged the
AI commenting on this...

