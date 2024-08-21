Return-Path: <netdev+bounces-120480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E7195985A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF4FB22F1E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798121BF303;
	Wed, 21 Aug 2024 09:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0A1C0DD2
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230938; cv=none; b=iQBmDnlXCYYnSYerh85i2YHlHTCLrZi1DePkJ6No223hHV0djh+d6WuZd11SZdD/eUZb55TJ0VSwv8srjzHD1FWsk7YOUyOnzv222rImTZpf+8epANtsqgVc37LdEv4hXlLaYUAPTFpGG48uMaN2J5GtLDUgslRz5kTbw2aPL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230938; c=relaxed/simple;
	bh=U5HwwMjqfGtuk58O3Rrtok5IsvBrZgvKvLcBo0uJmzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkWsFOQNRLXixPqA5Iu4F21u1ti0oTCQ8ez1J6AgALedCP2mIrgNsgBcg6aUKz3+2e6lyWT3InuAN4pp8O3lm1DCVVTnHpJfDdyMZMlpE8VZJ3Yrs9+nO2nHKDF2uH3+8asHCpgbJMggyjo9iFI2sbCwEYPvkEZotzvup8Cau9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sghE1-00051f-0M; Wed, 21 Aug 2024 11:01:53 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sghDy-001yKm-B8; Wed, 21 Aug 2024 11:01:50 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sghDy-00FTBt-0j;
	Wed, 21 Aug 2024 11:01:50 +0200
Date: Wed, 21 Aug 2024 11:01:50 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] phy: dp83tg720: Add statistics support
Message-ID: <ZsWs_qM-Y6GGLRwA@pengutronix.de>
References: <20240820122914.1958664-1-o.rempel@pengutronix.de>
 <20240820122914.1958664-4-o.rempel@pengutronix.de>
 <20240821101622.3ef23d29@fedora-3.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240821101622.3ef23d29@fedora-3.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Maxime,

On Wed, Aug 21, 2024 at 10:16:22AM +0200, Maxime Chevallier wrote:
> Hello Oleksij,
> 
> On Tue, 20 Aug 2024 14:29:14 +0200
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Introduce statistics support for the DP83TG720 PHY driver, enabling
> > detailed monitoring and reporting of link quality and packet-related
> > metrics.
> > 
> > To avoid double reading of certain registers, the implementation caches
> > all relevant register values in a single operation. This approach
> > ensures accurate and consistent data retrieval, particularly for
> > registers that clear upon reading or require special handling.
> > 
> > Some of the statistics, such as link training times, do not increment
> > and therefore require special handling during the extraction process.
> 
> This all looks good to me, I do have one small nit bellow :
> 
> > +/**
> > + * dp83tg720_get_stats - Get the statistics values.
> > + * @phydev: Pointer to the phy_device structure.
> > + * @stats: Pointer to the ethtool_stats structure.
> > + * @data: Pointer to the buffer where the statistics values will be stored.
> > + *
> > + * Fills the buffer with the statistics values, filtering out those that are
> > + * not applicable based on the PHY's operating mode (e.g., RGMII).
> 
> I don't see how this filtering is actually implemented, is this comment
> correct ?

You are right, it is outdated. My previous implementation had rgmii-fail
status flags.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

