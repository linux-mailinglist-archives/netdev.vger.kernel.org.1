Return-Path: <netdev+bounces-117387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C058694DB1F
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 08:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC3A282B19
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 06:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B814AD17;
	Sat, 10 Aug 2024 06:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBE34409
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723272114; cv=none; b=fXUOeIqFNr7aHOh4qmtVqD0biAY9FIgJRxznSsTjrhPivFOWDs1X7YuBjwZQhokWCLpoYeuKNWVCrEEKjxiwBJQInfD6faRktcIHhvW56rPHJQV7JIZLkqVsEkKxhopBySpIRoNpNJYrY76qypY3VKK8Y608vkpuDiMeQrSFJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723272114; c=relaxed/simple;
	bh=ApztVBERhT7zYHqLmBC+/SFrH40TQCtTmaX3IuZ4IMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cc8BGAI7pn4qLeF6VDzAWpQzn3X8MxrhsPNTWWyQu9aBUgM0myAqzfOtQocjXdTKZC+jEECJLq+j3y48UukjZFPoVp6fGB+qh7da2W2UXQs2fQL/x4ulME5uA/69YV4kCcV/RGLMeX55Dsd1YLRSIle44iLr7wGXjeTYGVHklX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1scfnK-0005se-KH; Sat, 10 Aug 2024 08:41:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1scfnJ-005qCM-Hj; Sat, 10 Aug 2024 08:41:41 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1scfnJ-00Cc1W-1O;
	Sat, 10 Aug 2024 08:41:41 +0200
Date: Sat, 10 Aug 2024 08:41:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] phy: Add Open Alliance helpers for the
 PHY framework
Message-ID: <ZrcLpXS5dd_rZq6F@pengutronix.de>
References: <20240808130833.2083875-1-o.rempel@pengutronix.de>
 <20240808130833.2083875-2-o.rempel@pengutronix.de>
 <eab136c5-ef49-4d4e-860c-c56840747199@lunn.ch>
 <ZrWmfqtYICzaj-HY@pengutronix.de>
 <5d62cf99-c025-42f1-99db-f1f872d1650a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d62cf99-c025-42f1-99db-f1f872d1650a@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Aug 09, 2024 at 04:00:53PM +0200, Andrew Lunn wrote:
> On Fri, Aug 09, 2024 at 07:17:50AM +0200, Oleksij Rempel wrote:
> > On Thu, Aug 08, 2024 at 03:54:06PM +0200, Andrew Lunn wrote:
> > 
> > > Please could you give a reference to the exact standard. I think this
> > > is "Advanced diagnostic features for 1000BASE-T1 automotive Ethernet
> > > PHYs TC12 - advanced PHY features" ?
> > > 
> > > The standard seem open, so you could include a URL:
> > > 
> > > https://opensig.org/wp-content/uploads/2024/03/Advanced_PHY_features_for_automotive_Ethernet_v2.0_fin.pdf
> > 
> > I already started to implement other diagnostic features supported by the
> > TI DP83TG720 PHY. For example following can be implemented too:
> > 6.3 Link quality – start-up time and link losses (LQ)
> > 6.3.1 Link training time (LTT)
> > 6.3.2 Local receiver time (LRT)
> > 6.3.3 Remote receiver time (RRT)
> 
> These three are the time it takes for some action. Not really a
> statistic in the normal netdev sense, since it does not count up. But
> they are kind of statistics, so it is probably not abusing statistics
> too much, so maybe O.K.
> 
> > 6.3.4 Link Failures and Losses (LFL)
> 
> This is a count, so does fit statistics. 
> 
> > 6.3.5 Communication ready status (COM)
> 
> Similar to the BMSR link bit. Do it add anything useful?

Probably. I can leave it for now

> > 6.4 Polarity Detection and Correction (POL)
> > 6.4.1 Polarity Detection (DET)
> > 6.4.2 Polarity Correction (COR)
> 
> Could these be mapped to ETH_TP_MDI* ? 

Yes, but it will look confusing in the user space. To make better
representation in ethtool we will probably need a new port type. For
example instead of PORT_TP it will be PORT_STP (single twiste pair) or
PORT_SPE (single pair ethernet). What do you think?

Beside, there are some not standard specific fail indicators. It can show RGMII
and SGMII specific errors. For example R/S_GMII FIFO full/empty errors. If
i see it correctly, it will not drop MDI link, so I won't be able to
return a link fail reason for this case.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

