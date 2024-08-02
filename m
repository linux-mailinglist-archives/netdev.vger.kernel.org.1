Return-Path: <netdev+bounces-115240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C30A94596D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16092817D2
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF52E3FBAD;
	Fri,  2 Aug 2024 08:02:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D01EB4B6
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585758; cv=none; b=cSL6ava/gIydg7PxVSbmNHRBd5kKk0XIcACyM+XpnVxDnHUA2kVv3yrqFYjd8TciY3I1rZXDmVTM3bVYM0Lb3Ylg4N2WkHJA3qf8x1JmHfI0oA2maRT/A/DPcL5NcnhQgBYhRCD7mxpNGibCvjk5HsOuWwPklG/AIGCjWrrg/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585758; c=relaxed/simple;
	bh=z9N3Dy6AarxlyC46M67moVWtSSN25BIaPNxJJFfBe1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI5A2d9fWWcbA3tEOMwq1MTJY5UlCQiJrUdTWrZcjDQMF3G9S4MCLABXfotBLLnv84LQZqdzY7vc8ED/6nYv/NrC9EYzsm0LPOKF+9Z1STubG1tCJ8YbVOGdz6RkxyBCJAZQKmCe9pwzrC+iXIf7EiU8lA0pL2+OpdW9m4SujCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sZnFC-0007PM-BI; Fri, 02 Aug 2024 10:02:34 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sZnFA-003xQm-PS; Fri, 02 Aug 2024 10:02:32 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sZnFA-00Eqbs-25;
	Fri, 02 Aug 2024 10:02:32 +0200
Date: Fri, 2 Aug 2024 10:02:32 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, Yuiko Oshino <yuiko.oshino@microchip.com>,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Eric Dumazet <edumazet@google.com>,
	Michal Kubiak <michal.kubiak@intel.com>, kernel@pengutronix.de,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v2 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Message-ID: <ZqySmKF_C6t_YTXy@pengutronix.de>
References: <20240705085550.86678-1-o.rempel@pengutronix.de>
 <ZqdPd/ieyLgVmX8v@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqdPd/ieyLgVmX8v@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Jul 29, 2024 at 09:14:47AM +0100, Russell King (Oracle) wrote:
> On Fri, Jul 05, 2024 at 10:55:50AM +0200, Oleksij Rempel wrote:
> > +static int lan937x_tx_config_aneg(struct phy_device *phydev)
> > +{
> > +	int ret;
> > +
> > +	ret = genphy_config_aneg(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return lan937x_tx_config_mdix(phydev, phydev->mdix_ctrl);
> 
> Should the MDIX configuration be changed _after_ aneg has possibly
> been restarted (by genphy_config_aneg()) or should the MDIX config
> be done before?

Hm, good question. I'm sure it was working, but now i'm starting to
doubt. I'll retest it as soon I'll continue to work on this HW.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

