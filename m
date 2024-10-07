Return-Path: <netdev+bounces-132703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54C992DB4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36111F2153B
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C31D433B;
	Mon,  7 Oct 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fWotVD8O"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE81BB6B8;
	Mon,  7 Oct 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308930; cv=none; b=FfCsMmnPSGAgEGSAWUpzFKULIHemjIDMI6cvb+xsX0UTgyWswMt9flsF28KVwm+vMQ87Jk9iqBYNqKDm6jwlsynlv9rzY88Bl/8P0cqdv3fohqezLDZMJuZ44bNytvGpMNfYSUsym1UZ44DaBDaHCck7IJ9TjbZLqphVYoQUrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308930; c=relaxed/simple;
	bh=aZONHblDLOY8a/SXia5FmXg/1mJCZXX1QQMv3hMv52c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rx37j9JOahq1/weO5T75cQuYx76vjzOLFxp9kN/Bj0FlsxyOcCzgtYXuPq4h9MFMAvpcYMw5/6Qv+a8EdZnNUTuk5wAohqZ1vAE5Y9XSaQt16/tenvNhTvePwVHCwOfCJGuuMpGWdGMqFLevGkLsvmG8AhnMGbfKBXwNjKVLTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fWotVD8O; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1188B20004;
	Mon,  7 Oct 2024 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728308923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DhKBFeZGHSyyHDSTFhWo3W2+i/2nHGpX6rDWz/1Zozs=;
	b=fWotVD8OTKFI8SebqJJNxcR4CgvHyhpV3IuVjgCGRg/S1eCRSG/8NwXtwLKH90r7y1X0QO
	iCk/KOwGBBoOFh1WKSRjY1hK8npcjwfuPNjbDyzL1G/CWK8RyqXhgxYPVdQQfMYC/ke8ST
	eSMrPn+43ptiHFgRJNMVjYdZMF72wZHNzP2HQOKL4VOFW9/qUa4uPFxh7DekDx9Rnk6K+V
	anH49L80z5x5+7dAwPMA9rhJWbyHjLGR3lLSfLcDuj+sjSO4MZOPpgcIfySbqzCOz+MkE8
	qVyIcU+HA+z6rbEuglXSa2HH3R9foMBwAI7+1s+pqnXpdxwVOXLtj0Zv43CdNA==
Date: Mon, 7 Oct 2024 15:48:39 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to
 get and set phy configuration
Message-ID: <20241007154839.4b9c6a02@device-21.home>
In-Reply-To: <6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
	<20241004161601.2932901-8-maxime.chevallier@bootlin.com>
	<4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
	<ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
	<20241007123751.3df87430@device-21.home>
	<6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Andrew,

On Mon, 7 Oct 2024 15:01:50 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > It seems I am missing details in my cover and the overall work I'm
> > trying to achieve.
> > 
> > This series focuses on isolating the PHY in the case where only one
> > PHY is attached to the MAC.  
> 
> I can understand implementing building blocks, but this patchset seems
> to be more than that, it seems to be a use case of its own. But is
> isolating a single PHY a useful use case? Do we want a kAPI for this?

That's a legit point. I mentioned in the cover for V1 that this in
itself doesn't really bring anything useful. The only point being that
it makes it easy to test if a PHY has a working isolation mode, but
given that we'll assume that it doesn't by default, that whole point
is moot.

I would therefore understand if you consider that having a kAPI for
that isn't very interesting and that I shall include this work as part
of the multi-PHY support.

> > I have followup work to support multi-PHY
> > interfaces. I will do my best to send the RFC this week so that you can
> > take a look. I'm definitely not saying the current code supports that.
> > 
> > To tell you some details, it indeed works as Russell says, I
> > detach/re-attach the PHYs, ndev->phydev is the "currently active" PHY.
> > 
> > I'm using a new dedicated "struct phy_mux" for that, which has :
> > 
> >  - Parent ops (that would be filled either by the MAC, or by phylink,
> > in the same spirit as phylink can be an sfp_upstream), which manages
> > PHY attach / detach to the netdev, but also the state-machine or the
> > currently inactive PHY.
> > 
> >  - multiplexer ops, that implement the switching logic, if any (drive a
> > GPIO, write a register, this is in the case of real multiplexers like
> > we have on some of the Turris Omnia boards, which the phy_mux framework
> > would support)
> > 
> >  - child ops, that would be hooks to activate/deactivate a PHY itself
> > (isoalte/unisolate, power-up/power-down).  
> 
> Does the kAPI for a single PHY get used, and extended, in this setup?

For isolation, no.

> 
> > I'll send the RFC ASAP, I still have a few rough edges that I will
> > mention in the cover.
> >   
> > > However, I still want to hear whether multiple PHYs can be on the same
> > > MII bus from a functional electrical perspective.  
> > 
> > Yup, I have that hardware.  
> 
> Can you talk a bit more about that hardware? What PHYs do you have?
> What interface modes are they using?

Sure thing. There are multiple devices out-there that may have multiple
PHYs accessible from the MAC, through muxers (I'm trying to be generic
enough to address all cases, gpio muxers, mmio-controlled muxers, etc.),
but let me describe the HW I'm working on that's a bit more problematic.

The first such platform I have has an fs_enet MAC, a pair of LXT973
PHYs for which the isolate mode doesn't work, and no on-board circuitry to
perform the isolation. Here, we have to power one PHY down when unused :

                /--- LXT973
fs_enet -- MII--|
                \--- LXT973


The second board has a fs_enet MAC and a pair of KSZ8041 PHYs connected
in MII.

The third one has a pair of KSZ8041 PHYs connected to a
ucc_geth MAC in RMII.

On both these boards, we isolate the PHYs when unused, and we also
drive a GPIO to toggle some on-board circuitry to disconnect the MII
lines as well for the unused PHY. I'd have to run some tests to see if
this circuitry could be enough, without relying at all on PHY
isolation :

                   /--- KSZ8041
                   |
      MAC ------ MUX
                 | | 
  to SoC <-gpio--/ \--- KSZ8041


One point is, if you look at the first case (no mux), we need to know
if the PHYs are able to isolate or not in order to use the proper
switching strategy (isolate or power-down).

I hope this clarifies the approach a little bit ?

Thanks,

Maxime 

