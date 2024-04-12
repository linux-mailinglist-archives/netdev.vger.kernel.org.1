Return-Path: <netdev+bounces-87257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C852C8A2558
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8000E2866A4
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31761BA33;
	Fri, 12 Apr 2024 04:52:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D118E3F
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 04:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897578; cv=none; b=PbTHvYGXu/4/L+G4yPqMEgpAbcJcov7cnU9aS5XgZX/1va3uxYgDqYVOWavV+ILzmDgpYp2wuBOp93wgh+Bo/YT8Kv9nkR+KEq4hJFvGypFGKwE5mxdVKT5iCc1SMD7R04lVqx1mlVeGDVVCnwyofKvEmZ/Ikc1oL9BSJBiS1vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897578; c=relaxed/simple;
	bh=QBg3VRVbBbLV/P8T0DAsIXewmp97ZZ7PXofaEfhTyUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoFe63EkF/g8Oa0iwGsG/99WH7+pBrPu1o9ot343LVjbdzdi4PeTrDDxk/DeunXtOOgxmBQHAFT3OM+ab3KbxB/U4JtwOA7gWhMWftJG9afE2IQXxK/2Whe0MhU6xjHjiiC91QG18AlALfnbejEw6S9ZSILLUbFGXxHO24ntRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rv8u5-00065e-ST; Fri, 12 Apr 2024 06:52:45 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rv8u3-00BoRQ-PG; Fri, 12 Apr 2024 06:52:43 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rv8u3-009G1u-2F;
	Fri, 12 Apr 2024 06:52:43 +0200
Date: Fri, 12 Apr 2024 06:52:43 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: genet: Fixup EEE
Message-ID: <Zhi-Gwem_Ru9xBl_@pengutronix.de>
References: <20240408-stmmac-eee-v1-1-3d65d671c06b@lunn.ch>
 <4826747e-0dd5-4ab9-af02-9d17a1ab7358@broadcom.com>
 <67c0777f-f66e-4293-af8b-08e0c4ab0acc@lunn.ch>
 <c2a16e3c-374c-4fd1-9ca7-bf0aeb5ed941@broadcom.com>
 <ZhdycHAooDITV1a3@pengutronix.de>
 <843316df-162f-4551-97ec-8e30dc054b41@lunn.ch>
 <cb4695ba-8107-4810-b859-da102dd2bfba@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb4695ba-8107-4810-b859-da102dd2bfba@broadcom.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Apr 11, 2024 at 10:04:13AM -0700, Florian Fainelli wrote:
> On 4/11/24 07:35, Andrew Lunn wrote:
> > On Thu, Apr 11, 2024 at 07:17:36AM +0200, Oleksij Rempel wrote:
> > > Hi Florian,
> > > 
> > > On Wed, Apr 10, 2024 at 10:48:26AM -0700, Florian Fainelli wrote:
> > > 
> > > > I am seeing a functional difference with and without your patch however, and
> > > > also, there appears to be something wrong within the bcmgenet driver after
> > > > PHYLIB having absorbed the EEE configuration. Both cases we start on boot
> > > > with:
> > > > 
> > > > # ethtool --show-eee eth0
> > > > EEE settings for eth0:
> > > >          EEE status: disabled
> > > >          Tx LPI: disabled
> > > >          Supported EEE link modes:  100baseT/Full
> > > >                                     1000baseT/Full
> > > >          Advertised EEE link modes:  100baseT/Full
> > > >                                      1000baseT/Full
> > > >          Link partner advertised EEE link modes:  100baseT/Full
> > > >                                                   1000baseT/Full
> > > > 
> > > > I would expect the EEE status to be enabled, that's how I remember it
> > > > before.
> > > 
> > > Yes, current default kernel implementation is to use EEE if available.
> > 
> > We do however seem to be inconsistent in this example. EEE seems to be
> > disabled, yet it is advertising? Or is it showing what we would
> > advertise, when EEE is enabled?
> 
> What I consider to be the "canonical" behavior is the following on boot:
> 
> # ethtool --show-eee eth0
> EEE settings for eth0:
>         EEE status: enabled - active
>         Tx LPI: disabled
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full
> 
> whereby we advertise EEE, the link partner does too, and the adjust_link
> callback determined that we could EEE as a result via phy_init_eee(). This
> is seen on 6.8.
> 
> Starting with 6.9-rc and Andrew's series to rework EEE, I have the behavior
> provided before:
> 
> # ethtool --show-eee eth0
> EEE settings for eth0:
>         EEE status: disabled
>         Tx LPI: disabled
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full
> 
> whereby we need user intervention to opt-in and have EEE enabled with:
> 
> ethtool --set-eee eth0 eee on
> 
> This presents users with a difference in behavior which we might get
> regression reports for.


The phy_support_eee() is missing. This should be added on phy attach if
EEE is supported by MAC.

> > 
> > > > Now, with your patch, once I turn on EEE with:
> > > > 
> > > > # ethtool --set-eee eth0 eee on
> > > > # ethtool --show-eee eth0
> > > > EEE settings for eth0:
> > > >          EEE status: enabled - active
> > > >          Tx LPI: disabled
> > > >          Supported EEE link modes:  100baseT/Full
> > > >                                     1000baseT/Full
> > > >          Advertised EEE link modes:  100baseT/Full
> > > >                                      1000baseT/Full
> > > >          Link partner advertised EEE link modes:  100baseT/Full
> > > >                                                   1000baseT/Full
> > > > #
> > > > 
> > > > there is no change to the EEE_CTRL register to set the EEE_EN, this only
> > > > happens when doing:
> > > > 
> > > > # ethtool --set-eee eth0 eee on tx-lpi on
> > > > 
> > > > which is consistent with the patch, but I don't think this is quite correct
> > > > as I remembered that "eee on" meant enable EEE for the RX path, and "tx-lpi
> > > > on" meant enable EEE for the TX path?
> > > 
> > > Yes. More precisely, with "eee on" we allow the PHY to advertise EEE
> > > link modes. On link_up, if both sides are agreed to use EEE, MAC is
> > > configured to process LPI opcodes from the PHY and send LPI opcodes to
> > > the PHY if "tx-lpi on" was configured too. tx-lpi will not be enabled in
> > > case of "eee off".
> > 
> > Florian seems to be suggesting the RX and TX path could have different
> > configurations? RX EEE could be enabled but TX EEE disabled? That i
> > don't understand, in terms of auto-neg. auto-neg is for the link as a
> > whole, it does not appear to allow different results for each
> > direction. Does tx-lpi only make sense when EEE is forced, not
> > auto-neg'ed?
> 
> To me the 'tx-lpi' parameter allows for an additional level of local control
> of whether TX path should sent LPI or not, irrespective of forced versus
> auto-negotiated EEE capability.

Hm.. many of combined devices like MACs with integrated PHYs or PHYs with
integrated EEE-LPI support (SmartEEE...) do hardware EEE with autoneg.
configuring tx-lpi without "eee on" would not bring much.

> I am not sure why the API was defined like it was in the first place and
> what was the rationale for offering a separate 'tx-lpi', this might have
> been based upon a real or hypothetical use case.
> 
> If we are to honor the separate controls, we would have to agree on their
> meaning and we had discussed this before with Oleksij.

I can imagine, this can be used to optimize for some traffic use cases.
"tx-lpi off" is in general equal to "tx-timer 0" or tx-timer some big
number.

May be, it was a workaround, since recommended initial tx-timer value
depend on the linkspeed. At least some of microchip devices have special
recommendations about it.

> EEE_EN means that the Ethernet MAC (called UNIMAC in this block) enables
> clock gating signaling from the PHY up to DMA interface, this is how the
> power savings are actually realized on the digital logic side.

Hm.. so, on this MAC, at leas partial LPI mode will still work without
EEE_EN?

Beside, I see there is UMAC_EEE_WAKE_TIMER, which is not configured.
This one is very important, the wake time depend on the link speed, the
PHY and potentially link partner. If not properly configure, EEE may
fail.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

