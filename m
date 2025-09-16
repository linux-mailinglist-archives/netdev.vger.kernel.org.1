Return-Path: <netdev+bounces-223360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE62B58DA9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA62A1891FDE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 04:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3A253359;
	Tue, 16 Sep 2025 04:56:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A112356D2
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998608; cv=none; b=cdMLhJS8sU3f8q3S5ju+BMqwMRzPibLqHVzShOrBxzZn8A0kD/CBfliXswrjILvBtwvIbCrkET5aKmpeKpheXzAukUH8e73cVi2fnBiPiBH9DuRHeg+DGrxu4CoJFFyulcTZ7kXW9Zz48I6lwEritwKdn2elDLlkEeo/RPvO3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998608; c=relaxed/simple;
	bh=cEellUF89w42MfPZvNg0Pwo5l35x4ka2ztq8ivbFbok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7P/KkwuweyFXsugVo8N02VnjXFkkTLhW++zoBhctI+5yzmZe48JFlEfI4ClL7rc8/Dc3Gd5YEqAh20Q5zmrZkChk1LKnQxHYaQIUHUQsGWPHlP7MbNgIbkuJEsTOBD6RAEC6VbyB7XK7U0r3XG7luSg54btCCDOVKMMAONZjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyNju-00054e-FR; Tue, 16 Sep 2025 06:56:26 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyNjr-001Wy3-0D;
	Tue, 16 Sep 2025 06:56:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyNjq-00BRnc-2p;
	Tue, 16 Sep 2025 06:56:22 +0200
Date: Tue, 16 Sep 2025 06:56:22 +0200
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
Message-ID: <aMjt9iVcNWYf0opD@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
 <20250908124610.2937939-3-o.rempel@pengutronix.de>
 <20250911193440.1db7c6b4@kernel.org>
 <aMPw7kUddvGPJCzx@pengutronix.de>
 <20250912170053.24348da3@kernel.org>
 <aMfczCuRf0bm2GgQ@pengutronix.de>
 <20250915080720.17646515@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915080720.17646515@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Sep 15, 2025 at 08:07:20AM -0700, Jakub Kicinski wrote:
> On Mon, 15 Sep 2025 11:30:52 +0200 Oleksij Rempel wrote:
> > On Fri, Sep 12, 2025 at 05:00:53PM -0700, Jakub Kicinski wrote:
> > > On Fri, 12 Sep 2025 12:07:42 +0200 Oleksij Rempel wrote:  
> > > > I would prefer to keep u64 for refresh-rate-ps and num-symbols.
> > > > 
> > > > My reasoning comes from comparing the design decisions of today's industrial
> > > > hardware to the projected needs of upcoming standards like 800 Gbit/s. This
> > > > analysis shows that future PHYs will require values that exceed the limits of a
> > > > u32.  
> > > 
> > > but u64 may or may not also have some alignment expectations, which uint
> > > explicitly excludes  
> > 
> > just to confirm - if we declare an attribute as type: uint in the YAML
> > spec, the kernel side can still use nla_put_u64() to send a 64-bit
> > value, correct? My understanding is that uint is a flexible integer
> > type, so userspace decoders will accept both 4-byte and 8-byte encodings
> > transparently.
> 
> Theoretically, and yes. But why would you use put_u64 and not
> put_uint() ?

rater.. rater.. rater.. (sound of rusty gears slowly moving)

Right, I was thinking of uint as u32. But in NLA, NLA_UINT is handled
like NLA_U64, so the max is U64_MAX. That clears it up, thanks!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

