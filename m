Return-Path: <netdev+bounces-132980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1769994073
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81285288330
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FD41FB3F6;
	Tue,  8 Oct 2024 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kZ0XPRxJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E11D2F7C;
	Tue,  8 Oct 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371263; cv=none; b=PqJDidt+/1NBUHKVz+m0zpG+BCE5wRizl7Zd1PjyszEa3Qz+5KUoIBZAnHUVtXq/xMvF1+Td8QkluBHE25zbXRORz4v1wI+f33Q4lDx9O1nWswR/JiGQXwsCzamLpXz7YTUrJOsScGnC0WEOjgJoBzI6AF3Ul91RaN97JMUjlMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371263; c=relaxed/simple;
	bh=30/cEViZT/Hi8EnHVhYa2xu53TnHpaJSOqZs9SJ6Fns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joVJ+ZtJWW6+oBhfkCYSYsjW0dW4nAq9s9GsELMpCGO5Bu3cLZwQhi2Zds0a4kzKojvfV/yk/7SR5GeC9lYiUzRdwJVFcDUmS+zyjeTgt21Iu2hRPZ2CzFPF1tBZ6QQsCCNFc0z4hSEoGILMaNL4M+xBo0zKYwxtGjMh8Qa4R7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kZ0XPRxJ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D52F60008;
	Tue,  8 Oct 2024 07:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728371259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbzvM8Iqy/HPhTE298uvLOOoVXhYuvVMDXaMB13C1zo=;
	b=kZ0XPRxJZGJ0y25nCCLv3gdBSWmPkZhq4YHYHKsu4hbgZ9qwyBX/z5ULxTuJ0UPgoJExAF
	7mY4kKX+6CuAdTKKVcp1U9oW3ytpePbw4g149w55C5PE+eATnNRgZz/4vFHlIIF8oDwBN4
	MO+Qp9GQQ4mgYmeWnfGoaykCeSnmw/L+suT8MBlm+ywPX1oLtFAnO8qLRQHff7avjXLHsW
	6CEj0hMbo8kL/En6h7708u174Cn9cSRBZ7bc05dmN5VvI2SsY5mysXq1lSnaXXbUTOKUNf
	VUiEs2qdE8jdedg4IGQ+9sqbRggA8bzIe+rLo8CdV2oKUD/e2toWKIbyH9HtfQ==
Date: Tue, 8 Oct 2024 09:07:37 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
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
Message-ID: <20241008090737.1023cd87@device-21.home>
In-Reply-To: <ZwQIEDkWQZzglbAq@shell.armlinux.org.uk>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
	<20241004161601.2932901-8-maxime.chevallier@bootlin.com>
	<4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
	<ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
	<20241007123751.3df87430@device-21.home>
	<6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
	<20241007154839.4b9c6a02@device-21.home>
	<ZwQIEDkWQZzglbAq@shell.armlinux.org.uk>
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

On Mon, 7 Oct 2024 17:10:56 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Oct 07, 2024 at 03:48:39PM +0200, Maxime Chevallier wrote:
> > Sure thing. There are multiple devices out-there that may have multiple
> > PHYs accessible from the MAC, through muxers (I'm trying to be generic
> > enough to address all cases, gpio muxers, mmio-controlled muxers, etc.),
> > but let me describe the HW I'm working on that's a bit more problematic.
> > 
> > The first such platform I have has an fs_enet MAC, a pair of LXT973
> > PHYs for which the isolate mode doesn't work, and no on-board circuitry to
> > perform the isolation. Here, we have to power one PHY down when unused :
> > 
> >                 /--- LXT973
> > fs_enet -- MII--|
> >                 \--- LXT973
> > 
> > 
> > The second board has a fs_enet MAC and a pair of KSZ8041 PHYs connected
> > in MII.
> > 
> > The third one has a pair of KSZ8041 PHYs connected to a
> > ucc_geth MAC in RMII.
> > 
> > On both these boards, we isolate the PHYs when unused, and we also
> > drive a GPIO to toggle some on-board circuitry to disconnect the MII
> > lines as well for the unused PHY. I'd have to run some tests to see if
> > this circuitry could be enough, without relying at all on PHY
> > isolation :
> > 
> >                    /--- KSZ8041
> >                    |
> >       MAC ------ MUX
> >                  | | 
> >   to SoC <-gpio--/ \--- KSZ8041
> > 
> > 
> > One point is, if you look at the first case (no mux), we need to know
> > if the PHYs are able to isolate or not in order to use the proper
> > switching strategy (isolate or power-down).
> > 
> > I hope this clarifies the approach a little bit ?  
> 
> What I gather from the above is you have these scenarios:
> 
> 1) two LXT973 on a MII bus (not RMII, RGMII etc but the 802.3 defined
>    MII bus with four data lines in each direction, a bunch of control
>    signals, clocked at a maximum of 25MHz). In this case, you need to
>    power down each PHY so it doesn't interfere on the MII bus as the
>    PHY doesn't support isolate mode.

Correct

> 
> 2) two KSZ8041 on a MII bus to a multiplexer who's exact behaviour is
>    not yet known which may require the use of the PHYs isolate bit.

Correct as well

> 
> I would suggest that spending time adding infrastructure for a rare
> scenario, and when it is uncertain whether it needs to be used in
> these scenarios is premature.
> 
> Please validate on the two KSZ8041 setups whether isolate is
> necessary.

I'll do

> Presumably on those two KSZ88041 setups, the idea is to see which PHY
> ends up with media link first, and then switch between the two PHYs?

Indeed. I already have code for that (I was expecting that whole
discussion to happen in the RFC for said code :D )

> Lastly, I'm a little confused why someone would layout a platform
> where there are two identical PHYs connected to one MAC on the same
> board. I can see the use case given in 802.3 - where one plugs in
> the media specific attachment unit depending on the media being
> used - Wikipedia has a photo of the connector on a Sun Ultra 1 -
> but to have two PHYs on the same board doesn't make much sense to
> me. What is trying to be achieved with these two PHYs on the same
> board?

The use-case is redundancy, to switch between the PHYs when the link
goes down on one side. I don't know why bonding isn't used, I suspect
this is because there's not enough MACs on the device to do that. These
are pretty old hardware platforms that have been in use in the field
for quite some time and will continue to be for a while.

I've been trying to decompose support for what is a niche use-case into
something that can benefit other devices :

 - Turris omnia for example uses a MII mux at the serdes level to
switch between a PHY and an SFP bus. We could leverage a phy_mux infra
here to support these related use-cases

 - I've always considered that this is similar enough ( from the
end-user perspective ) to cases like MCBin or other switches that have
2 ports connected to the same MAC. 

In the end, we have 1 netdev, 2 ports, regardless of wether there are 2
PHYs or 1. Of course, the capabilities are not the same, we can't
detect link/power simultaneously in all situations, but I'm keeping
that in mind in the design, and I've talked about this a few weeks ago
at LPC [1].

Thanks,

Maxime

[1] : https://bootlin.com/pub/conferences/2024/lpc/chevallier-phy-port/chevallier-phy-port.pdf

