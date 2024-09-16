Return-Path: <netdev+bounces-128472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55701979AC6
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 07:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0D028297B
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 05:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9955D27452;
	Mon, 16 Sep 2024 05:30:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5F134BD
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464652; cv=none; b=ZBf1eMtQAB79XK7sW+U1T3LqAzr7U6rLxKSErdW91Gc8uPu4r83aIitmMX8xASXq0Vbb1VilIcDxB3sfWUsG1yiZZNotpv1at/H5ctic07LcUdOKrMM5qg47NU4BfvqKbSE4mCqIpVrv3tREGgg7xYNApw8PV2gsvWyE4/H1Ow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464652; c=relaxed/simple;
	bh=ch5tnLlVOe9cJNNMVr9zmrrMS31Yk6rMJ3g/sUPSTZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWG2XpHJit8W2qt/8qC4nGw3ev/xyEmN3eahMMEylFAHgsYIK4oND5JvggoJvF5C7ZlhFYiIrqjQWKbRTqAnqpt0Gkve+GcSolADhlvJuRWLri2T7mTHDDvl+WXyqPtkEBgX7gE/P3gdLWmjdAUg0XdYMAFL4h9edAAqAe8HjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sq4JS-00015p-7r; Mon, 16 Sep 2024 07:30:14 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sq4JQ-008F5v-8m; Mon, 16 Sep 2024 07:30:12 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sq4JQ-00BH2R-0T;
	Mon, 16 Sep 2024 07:30:12 +0200
Date: Mon, 16 Sep 2024 07:30:12 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: phy: Support master-slave config
 via device tree
Message-ID: <ZufCZAfXB_KFIKmI@pengutronix.de>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
 <20240915180630.613433aa@kernel.org>
 <5befa01e-f52d-44de-b356-bc7e1946777a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5befa01e-f52d-44de-b356-bc7e1946777a@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sun, Sep 15, 2024 at 08:41:42PM +0200, Andrew Lunn wrote:
> On Sun, Sep 15, 2024 at 06:06:30PM +0200, Jakub Kicinski wrote:
> > On Fri, 13 Sep 2024 10:40:20 +0200 Oleksij Rempel wrote:
> > > This patch series adds support for configuring the master/slave role of
> > > PHYs via the device tree. A new `master-slave` property is introduced in
> > > the device tree bindings, allowing PHYs to be forced into either master
> > > or slave mode. This is particularly necessary for Single Pair Ethernet
> > > (SPE) PHYs (1000/100/10Base-T1), where hardware strap pins may not be
> > > available or correctly configured, but it is applicable to all PHY
> > > types.
> > 
> > I was hoping we'd see some acks here in time, but now Linus cut the 6.11
> > final so the 6.12 game is over now:
> 
> The device tree binding is not decided on yet. So deferred is correct.

No problem. See you on LPC, my flight starting right now.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

