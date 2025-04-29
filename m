Return-Path: <netdev+bounces-186661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3818AA03BD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02347A4851
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 06:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B09275869;
	Tue, 29 Apr 2025 06:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB526B080
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909485; cv=none; b=giazmCmoybLdSZS0jMXxAF+K70cZSpaWfM27mDQHG5C2S4sJXH7Doh6PHmdfBiBHh9stXTYtZFlaYC6l6jqvqUDVM83DzxTGjgWJ8zQCi1Lqx7SVdyftN6mFeyKKFybVEupyAMgpV5ZTA5VfbDNPvjAGSsTzNo109/gDTEmEqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909485; c=relaxed/simple;
	bh=ng4cdubXRoHSOfNaikV2yHk9smMLtTiFP7fxNeNmUIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moxX4U4FtH9kkoIJEmKAib0FCCaj8wj9m9OCyACktva+MYrjRXBfwhS1JAIlVHfMSamO98Ygk2glAPBeSakz5FDPyXxkXtLRQdbWq63PT1H4fG3O8PMGougFjM4HNvskmk+L4WJ8abGRCvuzyrjSYkuYnhGWOrvqc7IjZwGc4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9eo6-0000oM-Lq; Tue, 29 Apr 2025 08:51:06 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9eo4-000DdC-2u;
	Tue, 29 Apr 2025 08:51:04 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9eo4-00An2G-2X;
	Tue, 29 Apr 2025 08:51:04 +0200
Date: Tue, 29 Apr 2025 08:51:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v1 1/2] net: dsa: microchip: let phylink manage PHY
 EEE configuration on KSZ switches
Message-ID: <aBB22NnNE4p6isiC@pengutronix.de>
References: <20250428125119.3414046-1-o.rempel@pengutronix.de>
 <20250428125119.3414046-2-o.rempel@pengutronix.de>
 <4d8a3e79-f454-4e2f-9362-c842354b123a@lunn.ch>
 <aA_DyKw8AVPdmu-Y@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aA_DyKw8AVPdmu-Y@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Mon, Apr 28, 2025 at 08:07:04PM +0200, Oleksij Rempel wrote:
> On Mon, Apr 28, 2025 at 06:51:19PM +0200, Andrew Lunn wrote:
> > > +/**
> > > + * ksz_phylink_mac_disable_tx_lpi() - Dummy handler to disable TX LPI
> > > + * @config: phylink config structure
> > > + *
> > > + * For ports with integrated PHYs, LPI is managed internally by hardware.
> > 
> > Could you expand that.
> > 
> > Does it mean the hardware will look at the results of the autoneg and
> > disable/enable LPI depending on those results?
> 
> Yes.
> 
> > I also assume this means it is not possible to force LPI on/off, independent
> > of autoneg?
> 
> Correct. set_eee call in this driver is filtering (tx_lpi == false) to
> reflect HW functionality.

I'll update this patch to include this information.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

