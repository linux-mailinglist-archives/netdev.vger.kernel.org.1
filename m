Return-Path: <netdev+bounces-74307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF8F860D4C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE1D286CA2
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EB41B5B2;
	Fri, 23 Feb 2024 08:54:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1F18E2E
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678465; cv=none; b=lHoCSV3/MHz3HD3oTBvMMcGCSgodZvSO5e8zVLw0SDdlXHQO4eVSCsgANZQcrmAIRw3Mc8GYj6bbcPl71kFzVbGkvxsSkDiniQaQo9Nx4ZYihqmjTAyTl5oHRDkxn9VbSaQUxzhFL2T3PdHBMjWVyW9PC85yY4KXBb9TI1TVgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678465; c=relaxed/simple;
	bh=LDZLhdmLJuLOyKoQoccELLdHvbxLoXzSeqTWkyO71zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAZ6RuBmhiWj+vHRTCQpWowWYYInGjVRuJQk3WgXiuK9j2VKA6/c+w/46WFhFl4yKI1/6oV/TZihtR9UHKVXZFWUAIN5n4fl17yyDiV9jfsCoVVohnHv6GixH26z0F07IjLAbEhDBXCFUVq3/BwymwsJo4sPS1pY7qvxzTI2w5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rdRJt-0001Jm-1E; Fri, 23 Feb 2024 09:54:13 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rdRJq-002OHE-IO; Fri, 23 Feb 2024 09:54:10 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rdRJq-004DHH-1X;
	Fri, 23 Feb 2024 09:54:10 +0100
Date: Fri, 23 Feb 2024 09:54:10 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v5 3/8] net: phy: Add helper to set EEE Clock
 stop enable bit
Message-ID: <ZdhdMl-EWXTGzx1p@pengutronix.de>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-4-o.rempel@pengutronix.de>
 <572300ab-3475-4ea6-b6c9-9206f237171f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <572300ab-3475-4ea6-b6c9-9206f237171f@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Feb 22, 2024 at 08:47:58PM -0800, Florian Fainelli wrote:
> 
> 
> On 2/20/2024 10:21 PM, Oleksij Rempel wrote:
> > From: Andrew Lunn <andrew@lunn.ch>
> > 
> > The MAC driver can request that the PHY stops the clock during EEE
> > LPI. This has normally been does as part of phy_init_eee(), however
> > that function is overly complex and often wrongly used. Add a
> > standalone helper, to aid removing phy_init_eee().
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> It would be useful to also read whether the PHY is capable of stopping its
> clock, this has IMHO always been missing. Clause 45 IEEE PCS Status 1
> Register (3.1) bit 6 reflects whether the PHY is capable of stopping its
> clock.

Agreed, there is a extra set of challenges with this functionality. For
example stmmac will fail to reset DMA engine if PHY disabled clock. It will be
good to handle it in a separate patch set.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

