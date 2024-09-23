Return-Path: <netdev+bounces-129232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A697E61F
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 08:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9826D1F212C4
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 06:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7112E5B;
	Mon, 23 Sep 2024 06:42:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664A1FDA
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073751; cv=none; b=QmKrc2wAFdsJCQlc1B78KMr6niqz9XCuvyEO90uYTv6zhwDwp8Ceh9RODPN7Gn4GRdEuZ1O1+/9RpmUYigyOfLauD1qlbCl4VglfwX/DqAaXJHKQBaFbOfr/fCFXORfW5E1U0Bg/W5ixeZAh5fotv3ZhhNsqvAZFVqiTXyxoKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073751; c=relaxed/simple;
	bh=9TfQP7r8bFExRQSoNyVHySCgA9kQi3rUtJopcrGcRik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH6OZMbkz8sJ5WNCOrDX+yoEAoZgYAC0qHQ5xe4LT5vebm4N0IMxquPuT49jUcYOiZvc6vfmXaHUxI04ppwhO9OsEAX4q/bmRYhwZB0dyXbM/9wylh4UVv6byYsVlfqFIYYzQTX4X/67g+ZghzfnLiMuQnHwSeGJEF+baeMRPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sscm7-0007Yc-8S; Mon, 23 Sep 2024 08:42:23 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sscm5-000tYj-Jf; Mon, 23 Sep 2024 08:42:21 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sscm5-007Q5K-1e;
	Mon, 23 Sep 2024 08:42:21 +0200
Date: Mon, 23 Sep 2024 08:42:21 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, spatton@ti.com, r-kommineni@ti.com,
	e-mayhew@ti.com, praneeth@ti.com, p-varis@ti.com, d-qiu@ti.com
Subject: Re: [PATCH 3/5] net: phy: dp83tg720: Extending support to DP83TG721
 PHY
Message-ID: <ZvENzUBT7ni32-Lh@pengutronix.de>
References: <cover.1726263095.git.a-reyes1@ti.com>
 <d75b772038e37452f262b6c2d87796966f92a18e.1726263095.git.a-reyes1@ti.com>
 <0092fd9d-22e4-458a-8227-618fc56f5459@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0092fd9d-22e4-458a-8227-618fc56f5459@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Sep 19, 2024 at 11:26:49PM +0200, Andrew Lunn wrote:
> On Thu, Sep 19, 2024 at 02:01:17PM -0700, Alvaro (Al-vuh-roe) Reyes wrote:
> > The DP83TG721 is the next revision of the DP83TG720 and will share the
> > same driver. Added PHY_ID and probe funtion to check which version is
> > being loaded.=20
>=20
> Please don't mix whitespace changes with real code changes. It makes
> it harder to see the real changes which need reviewing.
>=20
> > +enum DP83TG720_chip_type {
> > +	DP83TG720_CS1_1,
> > +	DP83TG721_CS1,
> > +};
> > +
> > +struct DP83TG720_private {
> > +	int chip;
>=20
> I _think_ this should be enum DP83TG720_chip_type chip;
>=20
> > +	bool is_master;
>=20
> I think this can be removed and replaced with
> phydev->master_slave_set. You probably want to mirror it into
> phydev->master_slave_get.
>=20
> phydev->master_slave_state normally contains the result of auto-neg,
> but i expect this PHY forces it, so again, you probably want to mirror
> it here as well. Test it out with ethtool and make sure it reports
> what you expect.

And we will have device-tree based overwrites for the timing role soon,
so there is no reason to store this values in the priv.

Same for RGMII and SGMII modes, DT is already overwriting it with the
phy-mode property.

> > +	struct DP83TG720_private *DP83TG720;
>=20
> Upper case is very unusual in mainline. It is generally only used for
> CPP macros.
>=20
> > +static struct phy_driver dp83tg720_driver[] =3D {
> > +    DP83TG720_PHY_DRIVER(DP83TG720_CS_1_1_PHY_ID, "TI DP83TG720CS1.1"),
> > +	DP83TG720_PHY_DRIVER(DP83TG721_CS_1_0_PHY_ID, "TI DP83TG721CS1.0"),
> > +};

I would prefer not to have DP83TG720_PHY_DRIVER() macros. This devices
are not identical. For example: DP83TG721 have HW time stamping,
DP83TG720 don't. As soon as some one will start implementing it, this
macro will be obsolete.

About names: TI DP83TG720CS1.1 and TI DP83TG721CS1.0 are not known
anywhere outside of TI. If you really won't to use this names, please
add comment describing which final products use core variants

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

