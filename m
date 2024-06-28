Return-Path: <netdev+bounces-107534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2615D91B61A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 07:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B17AB21A83
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 05:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5984207D;
	Fri, 28 Jun 2024 05:27:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EB2D05E
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 05:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719552458; cv=none; b=BufE7YyUGnPhYrlRb/nQe0wJErTch2MVZJICRaLbIt1mzztgGUd67izhoJmA7IloiX42mp/wq1jxl9qKKFhCnl+LY+2mx/IH4tgIyRsRoewiO5JD2KsTk3mY7nhiEYK9hjTwqgK7T07wtwbYOe7qgDffXWV0KgwEEMVPSS2CUQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719552458; c=relaxed/simple;
	bh=rEtKcHsRKMNM6e4ZnAOOaFTv0WO2cefG1VXO9tK31yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dopemXt4wz4TX8OxuJ13GtjY05F+6QXHSWdPbBZpHV1fmqAdm5ujI5f0hc/J7FFdinjp7xMivBzFy+QLtneqlTfO2n6UyI3UpkLU25AloOwKGD4ElLim5PTRI8iH3Y4Mha7f320jn5un0fvswH+g+DzrTdCO1FcFrLT81IwF/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sN48p-0001CP-5B; Fri, 28 Jun 2024 07:27:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sN48n-005X5p-HB; Fri, 28 Jun 2024 07:27:21 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sN48n-002LYW-1O;
	Fri, 28 Jun 2024 07:27:21 +0200
Date: Fri, 28 Jun 2024 07:27:21 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Lucas Stach <l.stach@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: lan937x: disable
 VPHY output
Message-ID: <Zn5JufMOcQQYiyH5@pengutronix.de>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
 <20240627123911.227480-4-o.rempel@pengutronix.de>
 <20240627223818.655p2c34dp6ynxnq@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627223818.655p2c34dp6ynxnq@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jun 28, 2024 at 01:38:18AM +0300, Vladimir Oltean wrote:
> On Thu, Jun 27, 2024 at 02:39:11PM +0200, Oleksij Rempel wrote:
> > The VPHY is a compatibility functionality to be able to attach network
> > drivers without fixed-link support to the switch, which generally
> > should not be needed with linux network drivers.
> 
> Sorry, I don't have much to base my judgement upon. I did search for the
> "VPHY" string and found it to be accessed in the dev_ops->r_phy() and
> dev_ops->w_phy() implementations, suggesting that it is more than just
> that? These methods are used for accessing the registers of the embedded
> PHYs for user ports. I don't see what is the connection with RGMII on
> the CPU port.

My understanding of the VPHY concept in the LAN937x switches is as
follows:

The VPHY in the LAN937x series provides an emulated MII management
interface (MDIO) per IEEE 802.3, allowing a MAC with an unmodified
driver to interact with the switch as if it is attached to a single port
PHY. This emulation includes a full bank of registers that comply with
IEEE 802.3 and supports auto-negotiation to configure link parameters.
At the same time, this functionality seems to be used to handle clock
crossings for integrated PHYs. To avoid a degradation of SPI_CLK, an
indirect mechanism has been added to the VPHY for accessing the PHY
registers.

However, when VPHY mode is enabled, it defaults to a 100Mbit link speed
during auto-negotiation, particularly affecting RGMII links. This
behavior overrides the MAC configuration set via the P_XMII_CTRL_1
register, which should allow for choosing between 10, 100, and 1000Mbit
speeds, as done similarly in the KSZ9477 variants.

The problem arises because, with VPHY enabled, the MAC configuration on
the CPU port is ignored, and the system is stuck at the default 100Mbit
speed. Disabling the VPHY output ensures that the MAC configuration set
via the P_XMII_CTRL_1 register is respected, allowing the CPU port to
operate at the desired speed (10, 100, or 1000Mbit).

I tried to configure the CPU MAC by using the VPHY interface but had no
luck with it (maybe I handled it wrong). This change was tested on my
system, and I do not see a visible degradation in the functionality of
the integrated PHYs. This might still work because the SPI clock on my
board is limited to 5MHz.

The following article seems to confirm the behavior I observed and
supports the proposed solution:
https://microchip.my.site.com/s/article/LAN937X-The-required-configuration-for-the-external-MAC-port-to-operate-at-RGMII-to-RGMII-1Gbps-link-speed

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

