Return-Path: <netdev+bounces-215146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FBCB2D325
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608381C2557C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA51A9F83;
	Wed, 20 Aug 2025 04:45:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D201A8412
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665117; cv=none; b=sB9m+P+apeJ8wN6kTlAC6MX6HoJtdIM9jAITpbnLENKyjmKjfP1lssKgIl0N2rn602tQtYYx0l0DTDwYxi+WXvZuFGNGn68/EfUmiX6Xar08tALMq7SwwMkmjFUJEeZr2nDt3azHEu9J9sASIfbYCCmxW2WsdzKQPOWIzNZ/Zmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665117; c=relaxed/simple;
	bh=FjnnWJI1niM6HBzIl/Pa9v+/KqD2U3tukeGd7ncCZ8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV+9iFusqNg188zoudgvVpFPvg/KLkNbEKdKU0Ay5Qw9mIajRIegZ80o4kolu+SprGHdLA406WGxJY7/8ZVM5SWaFfdUryVUzDhVXwYjoE57oCN2ccpukrejU1YOisDx0pi4mVxIU8bKPDgY1TZlx4UBH0gsx9bwuWD10M8M0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uoagY-000120-MU; Wed, 20 Aug 2025 06:44:30 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoagQ-001Bgj-2e;
	Wed, 20 Aug 2025 06:44:22 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoagQ-005pET-2F;
	Wed, 20 Aug 2025 06:44:22 +0200
Date: Wed, 20 Aug 2025 06:44:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v2 1/5] ethtool: introduce core UAPI and driver
 API for PHY MSE diagnostics
Message-ID: <aKVSpmKR0MGZhAD1@pengutronix.de>
References: <20250815063509.743796-1-o.rempel@pengutronix.de>
 <20250815063509.743796-2-o.rempel@pengutronix.de>
 <489b2959-3374-4766-a982-9e7c26077899@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <489b2959-3374-4766-a982-9e7c26077899@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Aug 20, 2025 at 05:03:14AM +0200, Andrew Lunn wrote:
> > Channel-to-pair mapping is normally straightforward, but in some cases
> > (e.g. 100BASE-TX with MDI-X resolution unknown) the mapping is ambiguous.
> > If hardware does not expose MDI-X status, the exact pair cannot be
> > determined. To avoid returning misleading per-channel data in this case,
> > a LINK selector is defined for aggregate MSE measurements.
> 
> This is the same with cable test. The API just labels the pairs using
> 
>         ETHTOOL_A_CABLE_PAIR_A,
>         ETHTOOL_A_CABLE_PAIR_B,
>         ETHTOOL_A_CABLE_PAIR_C,
>         ETHTOOL_A_CABLE_PAIR_D,
> 
> It does not take into account MDI-X or anything.

In the case of the cable test, MDI-X does not affect the reported
results, or if it does, we can actively change the configuration and
re-run the test. For SQI/MSE on this chip, however, the measurement is
purely passive. If the hardware does not expose an MDI-X indicator, we
cannot reliably assign the values to a specific pair, so we need the
LINK selector to avoid returning misleading data.

> > @@ -1174,6 +1246,60 @@ struct phy_driver {
> >  	/** @get_sqi_max: Get the maximum signal quality indication */
> >  	int (*get_sqi_max)(struct phy_device *dev);
> >  
> > +	/**
> > +	 * get_mse_config - Get configuration and scale of MSE measurement
> > +	 * @dev:    PHY device
> > +	 * @config: Output (filled on success)
> > +	 *
> > +	 * Fill @config with the PHY's MSE configuration for the current
> > +	 * link mode: scale limits (max_average_mse, max_peak_mse), update
> > +	 * interval (refresh_rate_ps), sample length (num_symbols) and the
> > +	 * capability bitmask (supported_caps).
> > +	 *
> > +	 * Implementations may defer configuration until hardware has
> > +	 * converged; in that case they should return -EAGAIN and allow the
> > +	 * caller to retry later.
> > +	 *
> > +	 * Return:
> > +	 *  * 0              - success, @config is valid
> > +	 *  * -EOPNOTSUPP    - MSE configuration not implemented by the PHY
> > +	 *		       or not supported in the current link mode
> > +	 *  * -ENETDOWN      - link is down and configuration is not
> > +	 *		       available in that state
> 
> This seems a bit odd. phylib knows the state of the link. If it is
> down, why would it even ask? 

Good point. I'll remove this part of comment.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

