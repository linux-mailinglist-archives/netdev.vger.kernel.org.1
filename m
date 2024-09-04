Return-Path: <netdev+bounces-124862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBB396B3E1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEF22811D3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88614F9FD;
	Wed,  4 Sep 2024 08:05:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FE17279E
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437125; cv=none; b=AyQTk6adsPuArhkRaW3bUPg4eC/GaPH4DmfKbY8HDwcKCYPfGnausnjwrPy6pSQj/AGk0JxWrsYsbmPo0POxJN1mGUBG473t3vbF+rzHwyr/eJOM9wuDRg2Z5DCWAy9SaICprG3h7tpzFHs/Spw1BVoVXXt+nWX/pRnrPCnUy/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437125; c=relaxed/simple;
	bh=NH5ZsiHjqo8oc7amq9vmeRZvrZy+8NWtOGafV6fUFfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9Q8AqzGyEZ1xVTk/O3rk5HuetYZbGcEqva7lOMGuA3M6043wxHjugGFVvC21j2FW34qJqOKoS2ljvqNh+C+M9vgawTKFIjCTIie8dRpYMJL7FMMYdB2vKETJimF0F71qiyRgFGNkcjJFM1JOg+Gcjn47OPzDF1MqKw1NJCh1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sll0q-0004fe-0a; Wed, 04 Sep 2024 10:05:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sll0o-005ORw-5x; Wed, 04 Sep 2024 10:05:10 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sll0o-006ETt-0E;
	Wed, 04 Sep 2024 10:05:10 +0200
Date: Wed, 4 Sep 2024 10:05:10 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	Vladimir Oltean <olteanv@gmail.com>, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com
Subject: Re: [RFC net-next 1/2] net: ethtool: plumb PHY stats to PHY drivers
Message-ID: <ZtgUthjSJYgJEMmH@pengutronix.de>
References: <20240829174342.3255168-1-kuba@kernel.org>
 <20240829174342.3255168-2-kuba@kernel.org>
 <20240830101630.52032f20@device-28.home>
 <20240830113047.10dcee79@kernel.org>
 <20240904092024.530c54c3@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904092024.530c54c3@fedora.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi all,

On Wed, Sep 04, 2024 at 09:20:24AM +0200, Maxime Chevallier wrote:
> Hi Jakub,
> 
> On Fri, 30 Aug 2024 11:30:47 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Fri, 30 Aug 2024 10:16:30 +0200 Maxime Chevallier wrote:
> > > > +static void
> > > > +ethtool_get_phydev_stats(struct net_device *dev,
> > > > +			 struct linkstate_reply_data *data)
> > > > +{
> > > > +	struct phy_device *phydev = dev->phydev;    
> > > 
> > > This would be a very nice spot to use the new
> > > ethnl_req_get_phydev(), if there are multiple PHYs on that device.
> > > Being able to access the stats individually can help
> > > troubleshoot HW issues.
> > >   
> > > > +static void
> > > > +ethtool_get_phydev_stats(struct net_device *dev, struct stats_reply_data *data)
> > > > +{
> > > > +	struct phy_device *phydev = dev->phydev;    
> > > 
> > > Here as well, but that's trickier, as the MAC can override the PHY
> > > stats, but it doesn't know which PHY were getting the stats from.
> > > 
> > > Maybe we could make so that when we pass a phy_index in the netlink
> > > command, we don't allow the mac to override the phy stats ? Or better,
> > > don't allow the mac to override these stats and report the MAC-reported
> > > PHY stats alongside the PHY-reported stats ?  
> > 
> > Maybe we can flip the order of querying regardless of the PHY that's
> > targeted? Always query the MAC first and then the PHY, so that the
> > PHY can override. Presumably the PHY can always provide more detailed
> > stats than the MAC (IOW if it does provide stats they will be more
> > accurate).
> 
> I think that could work indeed, good point.
> 
> [...]
> 
> > > I'm all in for getting the PHY stats from netlink though :)  
> > 
> > Great! FWIW I'm not sure what the status of these patches is.
> > I don't know much about PHYs.
> > I wrote them to help Oleksij out with the "netlink parts".
> > I'm not sure how much I convinced Andrew about the applicability.
> > And I don't know if this is enough for Oleksij to take it forward.
> > So in the unlikely even that you have spare cycles and a PHY you can
> > test with, do not hesitate to take these, rework, reset the author 
> > and repost... :)
> 
> I do have some hardware I can test this on, and I'm starting to get
> familiar with netlink :) I can give it a try, however I can't guarantee
> as of right now that I'll be able to send anything before net-next
> closes. I'll ping here if I start moving forward with this :)

I reserved some time for this work. I hope it will be this year.

In case some one else will start working on it, please let me know :)

Regard,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

