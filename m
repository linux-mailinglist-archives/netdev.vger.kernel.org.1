Return-Path: <netdev+bounces-156824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2775A07EBE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C000188D336
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B818C93C;
	Thu,  9 Jan 2025 17:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912BE18C910
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443677; cv=none; b=rutSXJyVInYTExoWXLN8eP3mcFlQldg5GUjnj66N/uY0iq0QJzXvS+aCY49iTy3IoDObv9EwNpmdFFEmszPW6gdevyRZPzAFcKReDKHzN0PuBD8K1xjNEoXqZAECnaBlBEX2vFqPOdY8hcqNkhYfBsLoC83VJeBGT4xCvKYZrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443677; c=relaxed/simple;
	bh=VvuOKDECwtpuV8SMHLUcer4yP+FEKBgFtFrjoiBWSGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKc3pE1PjCPP3/2GYKrH5pUIlenCbTxXDOxI0g5dV/p4r5CwcTzO9JKXu6/PMYYpRwuLWDVu3UhtjFGExrNU+aO0yO0VA01cX5tYozniCTLFh9sm5au1vSBPgX5VKG/gNIYQcavLubt02EGw49utiFt3DIL33+CcDvBaAV9WNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVwJt-0005ON-NA; Thu, 09 Jan 2025 18:27:45 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVwJs-0001Dm-2P;
	Thu, 09 Jan 2025 18:27:44 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVwJs-0002mp-22;
	Thu, 09 Jan 2025 18:27:44 +0100
Date: Thu, 9 Jan 2025 18:27:44 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <Z4AHEEX1c0gcGEV6@pengutronix.de>
References: <20250109094457.97466-1-o.rempel@pengutronix.de>
 <20250109094457.97466-3-o.rempel@pengutronix.de>
 <20250109080758.608e6e1a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109080758.608e6e1a@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Jan 09, 2025 at 08:07:58AM -0800, Jakub Kicinski wrote:
> On Thu,  9 Jan 2025 10:44:52 +0100 Oleksij Rempel wrote:
> > +static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
> > +					struct ethtool_eth_phy_stats *phy_stats,
> > +					struct ethtool_phy_stats *phydev_stats)
> > +{
> > +	ASSERT_RTNL();
> > +
> > +	if (!phylib_stubs)
> > +		return;
> > +
> > +	phylib_stubs->get_phy_stats(phydev, phy_stats, phydev_stats);
> > +}
> > +
> > +static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
> > +				    struct ethtool_link_ext_stats *link_stats)
> > +{
> > +	ASSERT_RTNL();
> > +
> > +	if (!phylib_stubs)
> > +		return;
> > +
> > +	phylib_stubs->get_link_ext_stats(phydev, link_stats);
> > +}
> 
> So we traded on set of static inlines for another?
> What's wrong with adding a C source which is always built in?
> Like drivers/net/phy/stubs.c, maybe call it drivers/net/phy/accessors.c
> or drivers/net/phy/helpers.c

I chose the current stubs approach based on existing examples like
hw_timestamps. Any implementation, including the current one, will have
zero kernel size impact because each function is only used once. While
moving them to a C source file is an option, it doesn't seem necessary
given the current usage pattern. Do we really want to spend more time on
this for something that won’t impact functionality or size? :)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

