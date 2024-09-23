Return-Path: <netdev+bounces-129227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9804197E59C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 07:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E3D1C204E8
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 05:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40FD10A1E;
	Mon, 23 Sep 2024 05:22:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D4FC0A
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727068938; cv=none; b=lIW2gHv6ETCs1fyp8ZJwdiIN88Zh0t5l4okc1wc+2HL4pRFO0VrtHczibv/kcAl24Dbm5EhrTM/QQ2oBLsRMbeZVL5aPnMF6+yfXhtqWutqroP+4Ej4BKoNKwkJQhM2B1eG4//s4N6UEXhgIk7gjfaImUu88QQGwWWvnlo7lhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727068938; c=relaxed/simple;
	bh=ymX6F2J5hY6BZg88iqo/o31qcTuFFnKZ3ZTzzMr60Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoEJJW6dC6hqhlaGcDrop3NbGyDmB5jB0XAzeAGSE6BDtWOX/+6wBF/iFxmmG8sJNxeYGxgvPM98RpZK52DjNMq+1/svU9UufuUlFMS8dH6KTYhahCESJUGNgSTtlYtnWa1EjFa95BnJjSLr/K8i7mNTOUUhuIxFImGxOqctUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ssbWP-0005MB-Rj; Mon, 23 Sep 2024 07:22:05 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ssbWO-000spA-3W; Mon, 23 Sep 2024 07:22:04 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ssbWO-007PIF-03;
	Mon, 23 Sep 2024 07:22:04 +0200
Date: Mon, 23 Sep 2024 07:22:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, spatton@ti.com, r-kommineni@ti.com,
	e-mayhew@ti.com, praneeth@ti.com, p-varis@ti.com, d-qiu@ti.com,
	nm@ti.com
Subject: Re: [PATCH 4/5] net: phy: dp83tg720: Added OA script
Message-ID: <ZvD6_GJEsNq6yiB-@pengutronix.de>
References: <cover.1726263095.git.a-reyes1@ti.com>
 <c41bc533471bab570be58bca3eae057554a56389.1726263095.git.a-reyes1@ti.com>
 <741f9487-e7f4-4c6e-b933-18cc2761c2f1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <741f9487-e7f4-4c6e-b933-18cc2761c2f1@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Sep 19, 2024 at 11:44:49PM +0200, Andrew Lunn wrote:
> Also 0x834 is BASE-T1 PMA/PMD control. Which is MDIO_PMA_PMD_BT1_CTRL
> 
> We also have:
> #define MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000 0x0001 /* Select 1000BASE-T1 */
> #define MDIO_PMA_PMD_BT1_CTRL_CFG_MST		0x4000 /* MASTER-SLAVE config value */
> 
> 802.3 says bit 15 is read only, so you don't need to set it.
> 
> The rest might be magic which nobody outside of TI will understand,
> but you can fully document this.

Yes, this values will affect products of our customers. It is important
for us to know what and why is changed.

> > +static int dp83tg720_reset(struct phy_device *phydev, bool hw_reset)
> > +{
> > +	int ret;
> > +
> > +	if (hw_reset)
> > +		ret = phy_write_mmd(phydev, MMD1F, DP83TG720_PHY_RESET_CTRL,
> > +				DP83TG720_HW_RESET);
> > +	else
> > +		ret = phy_write_mmd(phydev, MMD1F, DP83TG720_PHY_RESET_CTRL,
> > +				DP83TG720_SW_RESET);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mdelay(100);
> 
> Does the bit not self clear when it has completed? That would be
> common for a reset bit.

Not sure about status bit, but the time seems to be incorrect.
In case of HW reset, about 1ms delay is documented. This time should not
be needed for the SW reset. If it is really needed, please add comment
on where it is described.

With 100ms delay, this chip will be able to establish the link within
10ms (depending on the strap configuration) and then we will disable it again.

Even worse, this script includes already soft reset and power management
state changes. Im strongly against this script in that form.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

