Return-Path: <netdev+bounces-76845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0669E86F1F1
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 19:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116671C21378
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B949374E6;
	Sat,  2 Mar 2024 18:45:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F16374C5
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709405131; cv=none; b=FvU5eS9RTNLyAoUxDJy21R5R1oqua/39B+brlsyaDTpNjs10r9HMvF+PA4L8epRM0deOkHvevHhKni6SdKLoVTdP6BcDGSeeGKMSH7MEMuRrzCwd5XKJXL1JTCuSi6gcZCELKv8/rHsiE2rpeuYccDWYglohFHYMd8JUveBVDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709405131; c=relaxed/simple;
	bh=5s1g4Jved+7SnF/29jsQY4ThWE/ls/MJluqj4TvUtjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROKAsMeRPuCKF4jYeY+Mo3IfQEQLq8UsF1GrkQe8EEK3Ta7cyB17Jp6RLATEs2JNnwoeWb3Rer2f3+65IQkb1QA7zvIj8NnTJXk3uThm805iqXKspRD4wY496SWuI2aSXTl/UUafr5HrJkI6BUWtCo9spwHUdHgF92oFi5ML2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rgULt-0001vY-SG; Sat, 02 Mar 2024 19:44:53 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rgULr-0041Im-8B; Sat, 02 Mar 2024 19:44:51 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rgULr-00GdbV-0U;
	Sat, 02 Mar 2024 19:44:51 +0100
Date: Sat, 2 Mar 2024 19:44:51 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v8 3/8] net: phy: Add helper to set EEE Clock
 stop enable bit
Message-ID: <ZeNzo9kXn-Y7ZF8q@pengutronix.de>
References: <20240301100153.927743-1-o.rempel@pengutronix.de>
 <20240301100153.927743-4-o.rempel@pengutronix.de>
 <d550b591-cd83-4ac6-8fd5-f5e0e2ad71d9@gmail.com>
 <ZeNhGURTEfzwhikL@shell.armlinux.org.uk>
 <b8fab5f0-5918-47e6-b17d-5ca0514467cc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8fab5f0-5918-47e6-b17d-5ca0514467cc@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Mar 02, 2024 at 07:38:17PM +0100, Andrew Lunn wrote:
> > That depends who is going to do that work. If it's individual driver
> > maintainers, then I think we want this to go in along with this series
> > so that we don't end up with individual driver maintainers having to
> > carry this patch, and submissions ending up with multiple copies of
> > this patch or depending on other maintainers submissions.
> > 
> > On the other hand, if someone is going to go through all the network
> > drivers and update them as one series, then it probably makes more
> > sense to move this to that series.
> 
> When i did this work, i did convert all drivers to the new API, and
> then dropped the old API. There are too many patches for a single
> series, so it makes sense to put the API in place along with one
> driver conversion to show how it works, then a second series
> converting all the remaining drivers, and then a cleanup series.

In this series we have no driver converted to the new API. I'll move it
to separate patch series.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

