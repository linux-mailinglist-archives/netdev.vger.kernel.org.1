Return-Path: <netdev+bounces-159544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1DA15BBB
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 08:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9063A922C
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6D15FA7B;
	Sat, 18 Jan 2025 07:22:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912039FD9
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737184976; cv=none; b=G08bRJh4ae/mv0zyWGBn4+QwwXaLuqiUd/2MysJMPvvwkOeePOhIgDQgvP34UZW24fOTFa4Q47DaAbt446sAza0U7yVFm+UAucxLrnDwRBj0QgrhwiPLvjwN3hFbY4okkA53jY5yCDLBy3OSE3eeMgfpWCKIDqK0hBYvneU3C08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737184976; c=relaxed/simple;
	bh=mna2MRyMieEu0PR9aya6Yt14jVA8DePmpaMQ5cEw51U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8gAwhAl47R95iYyKRe98UGI4cQqBMZUMjy/WEQNPL4UWs3Tje0RqyEDTraPzQHm5aDuZwpnwe9nM+FNhyA/eZ7/k7F83GNOjqV9xf/KEO82pVnvw/Wq0jj/e5jxCAWtNm0HJ99TOV78c8RIa0AaLvUUj6OSrV4hDUg7yUEry9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tZ39t-0002j0-Qg; Sat, 18 Jan 2025 08:22:17 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tZ39r-000YqS-32;
	Sat, 18 Jan 2025 08:22:15 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tZ39r-0000be-2e;
	Sat, 18 Jan 2025 08:22:15 +0100
Date: Sat, 18 Jan 2025 08:22:15 +0100
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
Message-ID: <Z4tWpxvwDG9u4MwJ@pengutronix.de>
References: <Z36WqNGpWWkHTjUE@shell.armlinux.org.uk>
 <Z4ADpj0DlqBRUEK-@pengutronix.de>
 <Z4AG7zvIvQDv3GTn@shell.armlinux.org.uk>
 <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
 <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
 <Z4UKHp0RopBT5gpI@pengutronix.de>
 <Z4UVQRHqk8ND984c@shell.armlinux.org.uk>
 <38ad9a25-a5b9-48ab-b92d-4c9d9f4c7d62@lunn.ch>
 <Z4qEGIRYvSuVR9AK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4qEGIRYvSuVR9AK@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jan 17, 2025 at 04:23:52PM +0000, Russell King (Oracle) wrote:
> I'm unsure about many DSA drivers. mt753x:
> 
>         u32 set, mask = LPI_THRESH_MASK | LPI_MODE_EN;
> 
>         if (e->tx_lpi_timer > 0xFFF)
>                 return -EINVAL;
> 
>         set = LPI_THRESH_SET(e->tx_lpi_timer);
>         if (!e->tx_lpi_enabled)
>                 /* Force LPI Mode without a delay */
>                 set |= LPI_MODE_EN;
>         mt7530_rmw(priv, MT753X_PMEEECR_P(port), mask, set);
> 
> Why force LPI *without* a delay if tx_lpi_enabled is false? This
> seems to go against the documented API:
> 
>  * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
>  *      that eee was negotiated.

According to MT7531 manual, I would say, the code is not correct:
https://repo.librerouter.org/misc/lr2/MT7531_switch_Reference_Manual_for_Development_Board.pdf

The LPI_MODE_EN_Px bit has following meaning:

When there is no packet to be transmitted, and the idle time is greater
than P2_LPI_THRESHOLD, the TXMAC will automatically enter LPI (Low
Power Idle) mode and send EEE LPI frame to the link partner.
0: LPI mode depends on the P2_LPI_THRESHOLD.
1: Let the system enter the LPI mode immediately and send EEE LPI frame
   to the link partner.

This chip seems to not have support for tx_lpi_enabled != eee_enabled
configuration.

> qca8k_set_mac_eee() sets the LPI enabled based off eee->eee_enabled.
> It doesn't seem to change the register on link up/down, so I wonder
> how the autoneg resolution is handled. Maybe it isn't, so maybe it's
> buggy.

The QCA8K_REG_EEE_CTRL_LPI_EN() bit is supported only for ports with
integrated PHYs. There seems to be no validation for this case.
Other problem with the code, lpi_en bit can be removed only one time.
Executing tx_lpi off and tx_lpi on in a sequence will not work.

My chip documentation do not provide any information about LPI_EN bit
functionality. I can't say for sure how it works.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

