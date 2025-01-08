Return-Path: <netdev+bounces-156391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CA1A06432
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F9A97A26AE
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE420103D;
	Wed,  8 Jan 2025 18:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46156183CD9
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360269; cv=none; b=ShJrwipSdwDCr5zN0h/k3B6196Wlk2M0JOxzKpwtf9JUMbmrARY9GpkLergA+iVYKEuKuS88NGu0+XVGAHF72Co4FvtN1eJX4T+JmFhUC9hqgk6rW1C566nuKayQMWXAkveCOpQmOElMFO5Ac3NbEqpnSclfJuNsC0rTGtJsmHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360269; c=relaxed/simple;
	bh=/DP6qXa8MJGO3By8U30HdxZN1bltT/+/6lqG29HW7KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fztkSAkv8kpoie2UjeCBtwRXQvygmJx/zcd17pd64YFfnZ+sQh+qAbLfmXKGxLI0kj4rYbZWf+fES7MtHZMzbDey6QMKolu3Ik1fED+uf4mafWGFybzm0HgyLNzKjyGudxo2oOKT4qZg0kbpFrlOE3fwCJAs7qjQUwxmC3eY9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVacV-0000V1-D4; Wed, 08 Jan 2025 19:17:31 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVacR-007Z4x-1Q;
	Wed, 08 Jan 2025 19:17:28 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVacS-00BauR-0H;
	Wed, 08 Jan 2025 19:17:28 +0100
Date: Wed, 8 Jan 2025 19:17:28 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 11/14] net: pse-pd: Add support for PSE device
 index
Message-ID: <Z37BONVrIY0tadzz@pengutronix.de>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
 <20250104-b4-feature_poe_arrange-v1-11-92f804bd74ed@bootlin.com>
 <20250107171834.6e688a6b@kernel.org>
 <Z34RXjqUKBdDqAGF@pengutronix.de>
 <20250108094201.63463180@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250108094201.63463180@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Jan 08, 2025 at 09:42:01AM -0800, Jakub Kicinski wrote:
> On Wed, 8 Jan 2025 06:47:10 +0100 Oleksij Rempel wrote:
> > On Tue, Jan 07, 2025 at 05:18:34PM -0800, Jakub Kicinski wrote:
> > > On Sat, 04 Jan 2025 23:27:36 +0100 Kory Maincent wrote:  
> > > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > > > 
> > > > Add support for a PSE device index to report the PSE controller index to
> > > > the user through ethtool. This will be useful for future support of power
> > > > domains and port priority management.  
> > > 
> > > Can you say more? How do the PSE controllers relate to netdevs?
> > > ethtool is primarily driven by netdev / ifindex.
> > > If you're starting to build your own object hierarchy you may be
> > > better off with a separate genl family.  
> >             
> > I hope this schema may help to explain the topology:
> > 
> > 	                              +--- netdev / ifindex 0
> > 	    +--- PSE power domain 0 --+--- netdev / ifindex 1
> >             |                         +--- netdev / ifindex 2
> > PSE ctrl 0 -+
> >             |                         +--- netdev / ifindex 3
> >             +--- PSE power domain 1 --+--- netdev / ifindex 4
> > 	                              +--- netdev / ifindex 5
> > 
> > 	                              +--- netdev / ifindex 6
> > 	    +--- PSE power domain 2 --+--- netdev / ifindex 7
> >             |                         +--- netdev / ifindex 8
> > PSE ctrl 1 -+
> >             |                         +--- netdev / ifindex 9
> >             +--- PSE power domain 3 --+--- netdev / ifindex 10
> > 	                              +--- netdev / ifindex 11
> > 
> > PSE device index is needed to find actually PSE controller related to
> > specific netdev / ifindex.
> 
> Makes sense. So how does it end up looking in terms of APIs 
> and attributes? Will we need much more than power limits at
> the domain and ctrl level?

The PSE power domains are based on regulator framework. So, we will get
some diagnostic and may be control API on this side.

The PSE controller will need some configuration and diagnostic
interfaces. For example:
- not port specific configurations
- not port specific diagnostics

Every thing port related can be passed to the netdev

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

