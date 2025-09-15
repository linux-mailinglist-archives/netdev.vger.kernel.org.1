Return-Path: <netdev+bounces-222967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 869E9B574F4
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27877A50AC
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6642D2488;
	Mon, 15 Sep 2025 09:31:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17272F8BFF
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928700; cv=none; b=TBEr/Rz3OMMu58AL3bpiZDHxoVMK6Qmyti95T9G9WDu8puiYG7lvc9i75ZCtlf1msNC3AT0DhHKx+0kJ6vLbYGMCLguVmXziW81Z+PlExbyDysfE6m1odh/dCLb+J8tJM+PwKHNYONDnW5a3dXrw9nOLQ7KKaCr2vWcS5RaaWOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928700; c=relaxed/simple;
	bh=OGXyjUvYK5vmnEp5jqa+n3SQ1w1v/lwJlIt5A/daJNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEr6oPRnOBVzq5alz57p8XOsTKcwvg8PVrJCjrca+xhiUqxo4/xebDgAXaKW00Bp5tokc5kTgtHqCGOxdrrIu67wzwd4i4W8Vb12vaB9u9q15IKh2ZaMKBXVKAJ6bhgFZCsZQ5qXS3vcHbZbhwrHcvV0zbKV51aVvWx0yhzpFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uy5Xz-0000Vh-8o; Mon, 15 Sep 2025 11:30:55 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uy5Xw-001Och-13;
	Mon, 15 Sep 2025 11:30:52 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uy5Xw-009L6r-0X;
	Mon, 15 Sep 2025 11:30:52 +0200
Date: Mon, 15 Sep 2025 11:30:52 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH net-next v5 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <aMfczCuRf0bm2GgQ@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
 <20250908124610.2937939-3-o.rempel@pengutronix.de>
 <20250911193440.1db7c6b4@kernel.org>
 <aMPw7kUddvGPJCzx@pengutronix.de>
 <20250912170053.24348da3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250912170053.24348da3@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Sep 12, 2025 at 05:00:53PM -0700, Jakub Kicinski wrote:
> On Fri, 12 Sep 2025 12:07:42 +0200 Oleksij Rempel wrote:
> > > > +      -
> > > > +        name: max-average-mse
> > > > +        type: u32
> > > > +      -
> > > > +        name: max-peak-mse
> > > > +        type: u32
> > > > +      -
> > > > +        name: refresh-rate-ps
> > > > +        type: u64
> > > > +      -
> > > > +        name: num-symbols
> > > > +        type: u64  
> > > 
> > > type: uint for all these?  
> > 
> > I would prefer to keep u64 for refresh-rate-ps and num-symbols.
> > 
> > My reasoning comes from comparing the design decisions of today's industrial
> > hardware to the projected needs of upcoming standards like 800 Gbit/s. This
> > analysis shows that future PHYs will require values that exceed the limits of a
> > u32.
> 
> but u64 may or may not also have some alignment expectations, which uint
> explicitly excludes

just to confirm - if we declare an attribute as type: uint in the YAML
spec, the kernel side can still use nla_put_u64() to send a 64-bit
value, correct? My understanding is that uint is a flexible integer
type, so userspace decoders will accept both 4-byte and 8-byte encodings
transparently.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

