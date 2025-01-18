Return-Path: <netdev+bounces-159556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9B2A15C47
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 11:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE241888998
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1A3185B6B;
	Sat, 18 Jan 2025 10:03:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EC2156220
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737194615; cv=none; b=Hj0f7wLsrsVlGpGC/9gsMKkVu9sZxvw5ryFhbwjB/cR36cTxGuCsoi2pn2au37/6spmPPK6augqZxBj7ToMCLmGqTOHHHzcAim6FUsSYLHAJWAV6b1ivxJ61Pl2QOJKkOW0aA0s6rAiFLwX0Us6uYXcpn8yLrKDkWPH8mYJeDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737194615; c=relaxed/simple;
	bh=VjxS+tkRRBdGcilKmYeTeSV+ivpcSnodgJylTpSiGRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/VJkvK8mSUCAfL6lRhqj2H82DruLE0e8QOWIHJd7R20Hm95AjwMshG+gdf13EAUfqm/CYdDNVNwLj6vOQidq9d12BcAbOnDXRUcfhfiHKpefMh6hEkfH39YaMGfOn2moLghxH7Uu2S/rLXWuM6LiyWo3sb7qOrDMZzMP97aME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tZ5fp-0007Lz-Gj; Sat, 18 Jan 2025 11:03:25 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tZ5fp-000a0N-0v;
	Sat, 18 Jan 2025 11:03:25 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tZ5fp-0002Ds-0Z;
	Sat, 18 Jan 2025 11:03:25 +0100
Date: Sat, 18 Jan 2025 11:03:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4t8bTNQAy5wMipw@pengutronix.de>
References: <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
 <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
 <Z4UKHp0RopBT5gpI@pengutronix.de>
 <Z4UVQRHqk8ND984c@shell.armlinux.org.uk>
 <38ad9a25-a5b9-48ab-b92d-4c9d9f4c7d62@lunn.ch>
 <Z4qEGIRYvSuVR9AK@shell.armlinux.org.uk>
 <Z4tWpxvwDG9u4MwJ@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4tWpxvwDG9u4MwJ@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Jan 18, 2025 at 08:22:15AM +0100, Oleksij Rempel wrote:
> On Fri, Jan 17, 2025 at 04:23:52PM +0000, Russell King (Oracle) wrote:
> > qca8k_set_mac_eee() sets the LPI enabled based off eee->eee_enabled.
> > It doesn't seem to change the register on link up/down, so I wonder
> > how the autoneg resolution is handled. Maybe it isn't, so maybe it's
> > buggy.
> 
> The QCA8K_REG_EEE_CTRL_LPI_EN() bit is supported only for ports with
> integrated PHYs. There seems to be no validation for this case.


> Other problem with the code, lpi_en bit can be removed only one time.
> Executing tx_lpi off and tx_lpi on in a sequence will not work.

Please ignore this lat part, I'm wrong here.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

