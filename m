Return-Path: <netdev+bounces-215978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFEAB31362
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8DD5C1F06
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA392F83DF;
	Fri, 22 Aug 2025 09:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DBC2F657C
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854953; cv=none; b=pOVcBr2kBvvT3yw+EwWDcPTU7uEwLPpP9wQt38mvnB59JU0aBmXuBEkIpL3ZhNDsjmFk8wWBPPZIrlvCBUKQJZuBpszEYxnBTee6RMNZaOUP5iYpr1D373GSNtHGTcMkosxv6tGYfDRI3p70BiyVd43X5wK2i01f2V8qOXbR0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854953; c=relaxed/simple;
	bh=qy1eb80X2+M43XeBimEia04iu3UlKhbOel9Og0vmxV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZy3+OIMjOen5khENFQ2qIby5RE3WGUGZG0Tn8ll6/mvjcphqJwPAKsh4xnptG5EozIWWrouYD7bdFxmpwzy+pM8dUbuHnziCcGq/ZihoCHnJwo3pJHJEZl6Ck5a5kSgjZIo9C+NccxgCd9svMb2gkvQcbTS0RRIzyEP89LUskc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1upO50-0005bC-AD; Fri, 22 Aug 2025 11:29:02 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upO50-001YQR-0H;
	Fri, 22 Aug 2025 11:29:02 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upO4z-00A50K-34;
	Fri, 22 Aug 2025 11:29:01 +0200
Date: Fri, 22 Aug 2025 11:29:01 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: phy: Clear link-specific data on
 link down
Message-ID: <aKg4XcM0vAIS4C-8@pengutronix.de>
References: <20250822090947.2870441-1-o.rempel@pengutronix.de>
 <aKg2HHIBAR8t2CQW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKg2HHIBAR8t2CQW@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Aug 22, 2025 at 10:19:24AM +0100, Russell King (Oracle) wrote:
> On Fri, Aug 22, 2025 at 11:09:47AM +0200, Oleksij Rempel wrote:
> > When a network interface is brought down, the associated PHY is stopped.
> > However, several link-specific parameters within the phy_device struct
> > are not cleared. This leads to userspace tools like ethtool reporting
> > stale information from the last active connection, which is misleading
> > as the link is no longer active.
> 
> This is not a good idea. Consider the case where the PHY has been
> configured with autoneg disabled, and phydev->speed etc specifies
> the desired speed.
> 
> When the link goes down, all that state gets cleared, and we lose
> the user's settings.
> 
> So no, I don't think this is appropriate.
> 
> I think it is appropriate to clear some of the state, but anything that
> the user can configure (such as ->speed and ->duplex) must not be
> cleared.

Hm... should it be cleared conditionally? If autoneg is used, clear the
speed and duplex?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

