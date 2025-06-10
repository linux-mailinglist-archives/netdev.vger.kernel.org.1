Return-Path: <netdev+bounces-196079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23670AD375E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222EB17B702
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385F2BEC5E;
	Tue, 10 Jun 2025 12:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46990299A88
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559580; cv=none; b=hgM6uhWiCpn3lnVA+KjN9f3jTlFJJCWfoouTcQd5DW2vZB1j8+VLxcExE8z3qO3Rgbe8yuR00xhl0YMYKZWvDlEcYzoQEZXF+SeAbYniZy/VipwIyZiFCdUOquVlxCwYXSjmlPN0NcFVGH8+OWPBjsydKcLsmmspc4GdJnOxu8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559580; c=relaxed/simple;
	bh=unA5W+ItyflOyuJHHOVR/vJuGZskAiqVajFb4X+nV24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU5GJ3JybRFTeOrn2QWNSht53fzEZlaceTm+IVqatE/N1duPiK8SB4xEjj7z+6XXQLJS6M2P6UaJ0ElzCZmyxu9XYRcMQh13IsCQWm7jPQegRDgOmLtq0wgxoNfg1f/QtKwijEmZ848Ci1B8lt6gYz55KrqOJiAMi7d/mfbPjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uOyMl-0001ub-Gg; Tue, 10 Jun 2025 14:46:11 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOyMl-002mGS-0U;
	Tue, 10 Jun 2025 14:46:11 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOyMl-004pya-06;
	Tue, 10 Jun 2025 14:46:11 +0200
Date: Tue, 10 Jun 2025 14:46:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/3] net: phy: micrel: add MDI/MDI-X control
 support for KSZ9477 switch-integrated PHYs
Message-ID: <aEgpE7dZNT_GqhSV@pengutronix.de>
References: <20250610091354.4060454-1-o.rempel@pengutronix.de>
 <20250610091354.4060454-2-o.rempel@pengutronix.de>
 <6597c2fd-077a-4eac-945f-97b43c130418@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6597c2fd-077a-4eac-945f-97b43c130418@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jun 10, 2025 at 02:31:45PM +0200, Andrew Lunn wrote:
> On Tue, Jun 10, 2025 at 11:13:52AM +0200, Oleksij Rempel wrote:
> > Add MDI/MDI-X configuration support for PHYs integrated in the KSZ9477
> > family of Ethernet switches.
> > 
> > All MDI/MDI-X configuration modes are supported:
> >   - Automatic MDI/MDI-X (ETH_TP_MDI_AUTO)
> >   - Forced MDI (ETH_TP_MDI)
> >   - Forced MDI-X (ETH_TP_MDI_X)
> > 
> > However, when operating in automatic mode, the PHY does not expose the
> > resolved crossover status (i.e., whether MDI or MDI-X is active).
> > Therefore, in auto mode, the driver reports ETH_TP_MDI_INVALID as
> > the current status.
> 
> I assume you also considered returning ETH_TP_MDI_AUTO? What makes
> INVALID better than AUTO?

The phydev->mdix_ctrl returns configuration state, which cant be set to
ETH_TP_MDI_AUTO.
The phydev->mdix should return actual crossover state, which is
ETH_TP_MDI or ETH_TP_MDI_X. Setting it to ETH_TP_MDI_AUTO, would not
provide any usable information.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

