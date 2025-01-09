Return-Path: <netdev+bounces-156819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D47A07E88
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B803A6FFD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9503F18F2D8;
	Thu,  9 Jan 2025 17:16:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557018BC26
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442992; cv=none; b=seOsv5dO3YbeVD98tOUU4UUt7IJR3A86dPlYzMccyB7taNJ48jvo9FfBj10vUycyqLrXGR3n9jViXliayOVfphK0YE7vmg6WkfiD+eFMb03rvca5Kr1wcwj+WA975WPTLpf2l5TFe6C5bXlkZ9h06hHBHOv8rNMj8MZmZtvW02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442992; c=relaxed/simple;
	bh=fxIjWL5dye//UM7o23CJHjfk0JMYszjlpt2i+u8prkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQtvyR5jt8VMxEfCOH9jlc68DSm61hOvWSS9WsvoIEcq1Zk0iuqKAcSbUyaq3KQ/6fsc1DxaopqntX3+fG11s/M4i9qZ1fztf+JnRzpGjeqgRxFp3sLpxPjmAoDE3WKKD190a3Cg4odfkeebsIHcqaPGo35yeqMfriQLoq4eN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVw8p-0004m8-HC; Thu, 09 Jan 2025 18:16:19 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVw8p-0001Cy-0c;
	Thu, 09 Jan 2025 18:16:19 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVw8p-00027O-0F;
	Thu, 09 Jan 2025 18:16:19 +0100
Date: Thu, 9 Jan 2025 18:16:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: Re: [PATCH net-next v2 11/15] net: pse-pd: Add support for PSE
 device index
Message-ID: <Z4AEY5cBv02YXepS@pengutronix.de>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
 <20250109-b4-feature_poe_arrange-v2-11-55ded947b510@bootlin.com>
 <20250109075926.52a699de@kernel.org>
 <20250109170957.1a4bad9c@kmaincent-XPS-13-7390>
 <Z3_415FoqTn_sV87@pengutronix.de>
 <20250109174942.391cbe6a@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109174942.391cbe6a@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Jan 09, 2025 at 05:49:42PM +0100, Kory Maincent wrote:
> On Thu, 9 Jan 2025 17:27:03 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Thu, Jan 09, 2025 at 05:09:57PM +0100, Kory Maincent wrote:
> > > On Thu, 9 Jan 2025 07:59:26 -0800
> > > Jakub Kicinski <kuba@kernel.org> wrote:
> > >   
> > > > On Thu, 09 Jan 2025 11:18:05 +0100 Kory Maincent wrote:  
> >  [...]  
> > > > 
> > > > This index is not used in the series, I see later on you'll add power
> > > > evaluation strategy but that also seems to be within a domain not
> > > > device?
> > > > 
> > > > Doesn't it make sense to move patches 11-14 to the next series?
> > > > The other 11 patches seem to my untrained eye to reshuffle existing
> > > > stuff, so they would make sense as a cohesive series. 
> 
> I think I should only drop patch 11 and 12 from this series which add something
> new while the rest is reshuffle or fix code.
> 
> > > Indeed PSE index is used only as user information but there is nothing
> > > correlated. You are right maybe we can add PSE index when we have something
> > > usable for it.  
> > 
> > No user, means, it is not exposed to the user space, it is not about
> > actual user space users.
> 
> I may have understood incorrectly but still. Not sure the PSE device index is
> interesting for now even in the budget evaluation strategy series. It is
> related to PSE power domains therefore PSE power domain index solely should be
> sufficient.

Oh.. You can drop it for now. :)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

