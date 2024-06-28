Return-Path: <netdev+bounces-107566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43DB91B7DD
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2DE286B9A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316B713EFEE;
	Fri, 28 Jun 2024 07:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC152262B
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558617; cv=none; b=a5ZnfTJ5K/EwnJ0qDtVgaDxb2a+3h8zE+vMej1Dhxw29k6bdm/J78xJVhAGnJ1KEKLfA9LNM82uu21hIDkSZ3BavfG30szUrQDH7Qg2jofo1Xu/MpqYU+h2MZqBSOgSYA380nmg1XA/CLocsH2rrfzXh+jL1uNVdWnO+eCrBAbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558617; c=relaxed/simple;
	bh=nf5rb/48jsspwKFlqnW2lDafPBBOtGlJGSJpAH2LFDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwFW55OkLQ3prjzje8/IeB/UHt22P/YTCU0WNSKFemDm8MMnXS+Vk70qRBBEnUQvXkYcQoyZ0MzmFcFLWHAJkrSkHdK8XoD++EzOyFkEOyyS6sNRyZa6FnUIn7UuotD32SCzjJLaeo5YKZtxqxfJO5U8RiI0C20NqlXg4pUnQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sN5kB-00056V-62; Fri, 28 Jun 2024 09:10:03 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sN5k9-005Y2z-B2; Fri, 28 Jun 2024 09:10:01 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sN5k9-002N6S-0l;
	Fri, 28 Jun 2024 09:10:01 +0200
Date: Fri, 28 Jun 2024 09:10:01 +0200
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
Subject: Re: [PATCH net-next v1 2/3] net: dsa: microchip: lan937x: force
 RGMII interface into PHY mode
Message-ID: <Zn5hyR1AKV81nulo@pengutronix.de>
References: <20240627123911.227480-1-o.rempel@pengutronix.de>
 <20240627123911.227480-3-o.rempel@pengutronix.de>
 <20240627222543.rcx3i5o43toopwcm@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627222543.rcx3i5o43toopwcm@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jun 28, 2024 at 01:25:43AM +0300, Vladimir Oltean wrote:
> On Thu, Jun 27, 2024 at 02:39:10PM +0200, Oleksij Rempel wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> > 
> > The register manual and datasheet documentation for the LAN937x series
> > disagree about the polarity of the MII mode strap. As a consequence
> > there are hardware designs that have the RGMII interface strapped into
> > MAC mode, which is a invalid configuration and will prevent the internal
> > clock from being fed into the port TX interface.
> > 
> > Force the MII mode to PHY for RGMII interfaces where this is the only
> > valid mode, to override the inproper strapping.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> 
> What's the difference between MAC mode and PHY mode with RGMII for this switch?

Let's take a step back. I'll describe first my initial findings, the symptoms,
and my new findings from today, so my argumentation and the patch itself should
be updated.

Initially, we identified that the RGMIIx_MODE[1,0] strap pins select between
RGMII, RMII, and MII. The MIIx_PHY_MODE pin configures PHY mode for MII or
clock direction in RMII but should have no effect in RGMII mode. However, if
MIIx_PHY_MODE = 1, RGMII exhibits the following symptoms:

- No signal on RGMII TXD[]
- No TX counters increase on the related MAC port.
- RX interface works, and data from the CPU through the switch is properly
  accounted for.

Due to the absence of TX counters even for broadcast traffic, we interpreted
this as a disabled MAC TX functionality or disabled TX clock for the MAC. This
issue was resolved by unsetting Bit 2 on register 0x301, which is undocumented
for RGMII.

Now, comparing LAN937x documentation with publicly available documentation for
other switches, for example KSZ9893R, may give some clue on the undocumented
part in the LAN937x datasheet:
RGMII Interface:
 1 = In-Band Status (IBS) enabled (requires IBS-capable PHY)
 0 = IBS disabled

The issue likely stems from active IBS mode, confirmed by an article
recommending IBS disablement via register 0x302.
https://microchip.my.site.com/s/article/LAN937X-The-required-configuration-for-the-external-MAC-port-to-operate-at-RGMII-to-RGMII-1Gbps-link-speed

The same effect seems to be achieved by toggling the undocumented 0x301 bit 2.
The ksz_set_xmii() function contains existing code to handle this:
	case PHY_INTERFACE_MODE_RGMII_RXID:
	    data8 |= bitval[P_RGMII_SEL];
	    /* On KSZ9893, disable RGMII in-band status support */
	    if (dev->chip_id == KSZ9893_CHIP_ID ||
		dev->chip_id == KSZ8563_CHIP_ID ||
		dev->chip_id == KSZ9563_CHIP_ID)
		data8 &= ~P_MII_MAC_MODE;
	    break;
	default:

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

