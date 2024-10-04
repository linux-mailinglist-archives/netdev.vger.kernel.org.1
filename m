Return-Path: <netdev+bounces-132026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FF099028D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E53D1F2110C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90115A85A;
	Fri,  4 Oct 2024 11:52:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481E15CD58
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042743; cv=none; b=fq1z4guvzCj81s070ZNcjOVdf/ItvLn+QM9+slvnpYsOvlVvq5xIT6Rlviz3RNzxig+A7BgVPr20vS9yehBYaIBNsTn3xkVtTruxrmu2sUBwloV25T4De1EvMSJNndCi7TAet1IAabiHoh0SVSHlAg8dIWtDc8E0/976TIh1uLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042743; c=relaxed/simple;
	bh=a/b8KhS76Lypgn0Qhi6M+ScxkMKXG55iD2Gk38iXy54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2Ln/Wx3mAPelc9JgdTUsa15eAAPsC/L0teUs//eTLSNAwysMQ4KDeGw1GwvRT+Fozj4k/glkr5Q15xWYM0c6tJib+A9Po9ZJefGIsTeZ1Um20qwpTIAdFP318HUYc0kxipDp4gc//aCKmu3NNttdAkzPCxKRx1H87Qz4jLX/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1swgqt-0006vI-Ca; Fri, 04 Oct 2024 13:52:07 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1swgqr-003Yt5-Ku; Fri, 04 Oct 2024 13:52:05 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1swgqr-00AgEW-1i;
	Fri, 04 Oct 2024 13:52:05 +0200
Date: Fri, 4 Oct 2024 13:52:05 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: add Twisted
 Pair Ethernet diagnostics at OSI Layer 1
Message-ID: <Zv_W5VDlTahegOZc@pengutronix.de>
References: <20241003060602.1008593-1-o.rempel@pengutronix.de>
 <20241003095321.5a3c4e26@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003095321.5a3c4e26@fedora.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Maxime,

On Thu, Oct 03, 2024 at 09:53:21AM +0200, Maxime Chevallier wrote:
...
> > +  - **Wake-on**: Displays whether Wake-on-LAN is enabled (e.g., **Wake-on: d**
> > +    for disabled). Not used for layer 1 diagnostic.
> 
> (sorry for the long scroll down there) This whole section is more of a
> documentation on what ethtool reports rather than a troubleshooting
> guide. I'm all in for getting proper doc for this, but maybe we could
> move this in a dedicated page, that we would cross-link from that guide
> ?

Ack, I was not sure where to put it. I'll try to come up with ethtool
manual patches and drop for now everything no directly related with the
diagnostic.

> > +This list will evolve with future kernel versions, reflecting new features or
> > +refinements. Below are the current suggestions:
> 
> I'm not sure this TODO list has its place in this troubleshooting
> guide. I agree with the points you list, but this looks more like a
> roadmap for PHY stuff to improve. I don't really know where this list
> could go and if it's common to maintain this kind of "TODO list" in the
> kernel doc though. Maybe Andrew has an idea ?

Yea,  may be it will be enough to send it as separate mail for
discussion.

> Thanks for coming-up with such a detailed guide. I also have some "PHY
> bringup 101" ideas on the common errors faced by developers, and this is
> document would be the ideal place to maintain this crucial information.

Good idea. It will be good to have a list or guide on what options are expected
form from PHY driver and how to test them.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

