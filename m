Return-Path: <netdev+bounces-214485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ECAB29D99
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351DC2A316D
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C33730DEB0;
	Mon, 18 Aug 2025 09:21:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926C2C3246
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508881; cv=none; b=loOVHCLEGfIq7XrVJxFDCDxbOJ6Nb5ANsN60DZL3uYcVHf+j5rJF14xT2j4bM4GcekDx4CruoN5UG1YZ9lQW9n1enhYwRtpamVnkhTtlbZ/J6ipmaUqGcGbZcRI8rucZdEdo8/7ENPbN5reGImAepCmitHLnSH6YiynAk8f9BBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508881; c=relaxed/simple;
	bh=02EAHmb0JV+wP0FR+YB9py05X+SwMTPsln/83688kh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYjG40nmHf5BwESJRfTE78ic1OkSkgicVB0jnDLtitg0SwjLDqDVh/uBlXWhpFVgPdTYO9XRGcyw6wfEOKQ8TKfHpNtpLMQTkIP6U6Iawjj7vuXISGhvlaoM9FEktTTJySRRpve1FizJ6eUjQnFIB2XN4h2xE81RvGnzL32hxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1unw2x-0005q1-Sd; Mon, 18 Aug 2025 11:20:55 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unw2w-000sUD-13;
	Mon, 18 Aug 2025 11:20:54 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unw2w-001hUG-0d;
	Mon, 18 Aug 2025 11:20:54 +0200
Date: Mon, 18 Aug 2025 11:20:54 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v2 5/5] net: phy: dp83td510: add MSE interface
 support for 10BASE-T1L
Message-ID: <aKLwdrqn-_9KqMaA@pengutronix.de>
References: <20250815063509.743796-1-o.rempel@pengutronix.de>
 <20250815063509.743796-6-o.rempel@pengutronix.de>
 <1df-68a2e100-1-20bf1840@149731379>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1df-68a2e100-1-20bf1840@149731379>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Maxime,

On Mon, Aug 18, 2025 at 10:15:56AM +0200, Maxime Chevallier wrote:
> Hi Oleksij,
> 
> On Friday, August 15, 2025 08:35 CEST, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Implement get_mse_config() and get_mse_snapshot() for the DP83TD510E
> > to expose its Mean Square Error (MSE) register via the new PHY MSE
> > UAPI.
> > 
> > The DP83TD510E does not document any peak MSE values; it only exposes
> > a single average MSE register used internally to derive SQI. This
> > implementation therefore advertises only PHY_MSE_CAP_AVG, along with
> > LINK and channel-A selectors. Scaling is fixed to 0xFFFF, and the
> > refresh interval/number of symbols are estimated from 10BASE-T1L
> > symbol rate (7.5 MBd) and typical diagnostic intervals (~1 ms).
> > 
> > For 10BASE-T1L deployments, SQI is a reliable indicator of link
> > modulation quality once the link is established, but it does not
> > indicate whether autonegotiation pulses will be correctly received
> > in marginal conditions. MSE provides a direct measurement of slicer
> > error rate that can be used to evaluate if autonegotiation is likely
> > to succeed under a given cable length and condition. In practice,
> > testing such scenarios often requires forcing a fixed-link setup to
> > isolate MSE behaviour from the autonegotiation process.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> [...]
> 
> > +static int dp83td510_get_mse_snapshot(struct phy_device *phydev, u32 channel,
> > +				      struct phy_mse_snapshot *snapshot)
> > +{
> > +	int ret;
> > +
> > +	if (channel != PHY_MSE_CHANNEL_LINK &&
> > +	    channel != PHY_MSE_CHANNEL_A)
> > +		return -EOPNOTSUPP;
> 
> The doc in patch 1 says :
> 
>   > + * Link-wide mode:
>   > + *  - Some PHYs only expose a link-wide aggregate MSE, or cannot map their
>   > + *    measurement to a specific channel/pair (e.g. 100BASE-TX when MDI/MDI-X
>   > + *    resolution is unknown). In that case, callers must use the LINK selector.
> 
> The way I understand that is that PHYs will report either channel-specific values or
> link-wide values. Is that correct or are both valid ? In BaseT1 this is the same thing,
> but maybe for consistency, we should report either channel values or link-wide values ?

for 100Base-T1 the LINK and channel-A selectors are effectively the
same, since the PHY only has a single channel. In this case both are
valid, and the driver will return the same answer for either request.

I decided to expose both for consistency:
- on one side, the driver already reports pair_A information for the
  cable test, so it makes sense to allow channel-A here as well;
- on the other side, if a caller such as a generic link-status/health
  request asks for LINK, we can also provide that without special
  casing.

So the driver just answers what it can. For this PHY, LINK and
channel-A map to the same hardware register, and all other selectors
return -EOPNOTSUPP.

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

