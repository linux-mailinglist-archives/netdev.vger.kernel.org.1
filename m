Return-Path: <netdev+bounces-243471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAEFCA1ED4
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 00:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CB83004191
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 23:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0182DC79D;
	Wed,  3 Dec 2025 23:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E582E8B9D;
	Wed,  3 Dec 2025 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764804214; cv=none; b=n067qL4t+FThaox4kFqr1ncP7U5qNpLYehteNPtRjFk0uNEKO8P1k0JFTQntH5W+JzUcxXuhHpxlVBjO8lJGjU3lG9mGzpZRhoCWxuKSFO4pQbGDsDRMbLMFwc2JJbUufVm3/NIfbrZvmf9ajk5onF9uzfWKNmpd8dBWxqbJBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764804214; c=relaxed/simple;
	bh=Q6GH1DVCaOxzLLUrc7SKqX0H6OYZH68ewF4tDfSel5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX4skpoW/CzddN+pGkWS1llIejb4+epOSvfAiBIMoKHlvOIKUHf+qhDVhhEfrASMQbQGw8DcO7Y/uGkeNT2cWDD/7zzlLsok53UP0Cxw6us+r4KIGbf2yLB2S4pOVmVF99dTFVopMd4SRhG40JTvU1212uNHJYN2/RDnbH3DAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vQwBn-000000003mf-1iSP;
	Wed, 03 Dec 2025 23:23:15 +0000
Date: Wed, 3 Dec 2025 23:23:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 0/3] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <aTDGX5sUjaXzqRRn@makrotopia.org>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <20251203202605.t4bwihwscc4vkdzz@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203202605.t4bwihwscc4vkdzz@skbuf>

On Wed, Dec 03, 2025 at 10:26:05PM +0200, Vladimir Oltean wrote:
> Hi Daniel,
> 
> On Tue, Dec 02, 2025 at 11:37:13PM +0000, Daniel Golle wrote:
> > Hi,
> > 
> > This series adds very basic DSA support for the MaxLinear MxL86252
> > (5 PHY ports) and MxL86282 (8 PHY ports) switches. The intent is to
> > validate and get feedback on the overall approach and driver structure,
> > especially the firmware-mediated host interface.
> > 
> > MxL862xx integrates a firmware running on an embedded processor (Zephyr
> > RTOS). Host interaction uses a simple API transported over MDIO/MMD.
> > This series includes only what's needed to pass traffic between user
> > ports and the CPU port: relayed MDIO to internal PHYs, basic port
> > enable/disable, and CPU-port special tagging.
> > 
> > Thanks for taking a look.
> 
> I see no phylink_mac_ops in your patches.


> 
> How does this switch architecture deal with SFP cages? I see the I2C
> controllers aren't accessible through the MDIO relay protocol
> implemented by the microcontroller. So I guess using the sfp-bus code
> isn't going to be possible. The firmware manages the SFP cage and you
> "just" have to read the USXGMII Status Register (reg 30.19) from the
> host? How does that work out in practice?

In practise the I2C bus provided by the switch IC isn't used to connect
an SFP cage when using the chip with DSA. Vendors (Adtran,
BananaPi/Sinovoip) rather use an I2C bus of the SoC for that.
I suppose it is useful when using the chip as standalone switch.

The firmware does provide some kind of limited access to the PCS, ie.
status can be polled, interface mode can be set, autonegotiation can be
enabled or disabled, and so on (but not as nice as we would like it to
be). In that way, most SFP modules and external PHYs can be supported.

See

https://github.com/frank-w/BPI-Router-Linux/commit/c5f7a68e82fe20b9b37a60afd033b2364a8763d8

In general I don't get why all those layers of abstraction are actually
needed when using a full-featured OS on the host -- it'd be much better
to just have direct access to the register space of the switch than
having to deal with that firmware API (the firmware can also provide a
full web UI, SNMP, a CLI interface, ... -- imho more of an obstacle than
a desirable feature when using this thing with DSA).

