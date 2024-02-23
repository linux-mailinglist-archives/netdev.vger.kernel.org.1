Return-Path: <netdev+bounces-74265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324AA860A69
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 06:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5D46B24769
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 05:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F160F11CAD;
	Fri, 23 Feb 2024 05:48:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18712E5E
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 05:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667288; cv=none; b=GfFzBg6QvdC3g6EysV4hbfJv8xBW4GyZ2rTIZ2UHQV8UzWCJdkBlj43h7aNnfPPWqd5ccqUsWfXRhSZEj+M7fZ5ZkX/1BlbsWefm6lOzV2mrkCQccm0/UjrVWXD5zisXKpm1t1qYUFKQk4Ii73RDR03DlwdoiC2/Tyz48knv1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667288; c=relaxed/simple;
	bh=3lgspPdovin39r1dgbggC/l2D36BlmeTw4hkWatherg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8GpvraVOpwjEATnXv/fUwgA2JxQUBjjhpy5k2lsYEq0dRIy4ldIpj86aC7GrKbtDBzecAZIfsjB9wgnEciz4hZbYnm2Z0RYn7OebSKxOn82aYi0wOwJ9JASChwJBBtiMLH6mWXtWJE5B6e/FBu822QiypO4HEtXRA+/sqHAxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rdOPX-0001VK-U7; Fri, 23 Feb 2024 06:47:51 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rdOPV-002Mi2-CC; Fri, 23 Feb 2024 06:47:49 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rdOPV-004Aqu-0s;
	Fri, 23 Feb 2024 06:47:49 +0100
Date: Fri, 23 Feb 2024 06:47:49 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v5 6/8] net: phy: Add phy_support_eee()
 indicating MAC support EEE
Message-ID: <ZdgxhVuT6d-N0M5T@pengutronix.de>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-7-o.rempel@pengutronix.de>
 <9e37a9e9-7722-407c-a2a5-b8c04b68f594@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e37a9e9-7722-407c-a2a5-b8c04b68f594@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Feb 22, 2024 at 08:52:25PM -0800, Florian Fainelli wrote:
> 
> 
> On 2/20/2024 10:21 PM, Oleksij Rempel wrote:
> > From: Andrew Lunn <andrew@lunn.ch>
> > 
> > In order for EEE to operate, both the MAC and the PHY need to support
> > it, similar to how pause works.
> 
> Kinda, a number of PHYs have added support for SmartEEE or AutoGrEEEn in
> order to provide some EEE-like power savings with non-EEE capable MACs.

Will reword it.

> Oleksij  did not you have a patch series at some point that introduced a
> smarteee field in the phy_device structure to reflect that? I thought that
> had been accepted, but maybe not.

Ack. They are pending at the end of EEE refactoring queue :)

> > Copy the pause concept and add the
> > call phy_support_eee() which the MAC makes after connecting the PHY to
> > indicate it supports EEE. phylib will then advertise EEE when auto-neg
> > is performed.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >   drivers/net/phy/phy_device.c | 18 ++++++++++++++++++
> >   include/linux/phy.h          |  3 ++-
> >   2 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 2eefee970851..269d3c7f0849 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -2910,6 +2910,24 @@ void phy_advertise_eee_all(struct phy_device *phydev)
> >   }
> >   EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
> > +/**
> > + * phy_support_eee - Enable support of EEE
> > + * @phydev: target phy_device struct
> > + *
> > + * Description: Called by the MAC to indicate is supports Energy
> > + * Efficient Ethernet. This should be called before phy_start() in
> > + * order that EEE is negotiated when the link comes up as part of
> > + * phy_start(). EEE is enabled by default when the hardware supports
> > + * it.
> 
> That comment is a bit confusing without mentioning how the hardware default
> state wrt. EEE is being factored in, can we have some details here?

If I see it correctly, this function set initial EEE policy for the PHY.
It should be called only once at PHY registration by the MAC and/or by
the PHY in case of SmartEEE or AutoGrEEEn PHY.

The advertisement configuration will be based on already filtered set of
supported modes.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

