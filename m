Return-Path: <netdev+bounces-126030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0177496FA1C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0451F23A23
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75771D6C6C;
	Fri,  6 Sep 2024 17:50:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3D1D6C48
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645004; cv=none; b=X5y+r9yKN4QpKSl0ddnqqgXO3Q+qESnrRrBplVBlJu5uigvVksYlmeNU2IbbDf766CPuFa3TziRM8/nYbefoAhp56O3l4Jo/cmLoL5z7A33CtuNs1ucU9yFH1u4vM2kTQFcGn9dG0L0J3Vqew38VB5OM0QQuD2S8VbRUkxMHBfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645004; c=relaxed/simple;
	bh=l1sVdFOMNtwL1Zmafv0HS4T2YsQXvmgGogTxHOUP2qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olzpE2wWBGGT8nkFWfRxukJu2sGavEwHdrFdvfdduhADBGB847Uh2sTlUA4J9BIagTKcHISJAvsbu96//HGZcP7FJDPLf3T9jD/Vgst2eZ/7oOXTXsnGazVMzElC4DEnqrKUp0nqD5cp+JGvH2AvKHMNnzcwPE/lhbzhcRa47ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1smd5e-0000wt-GF; Fri, 06 Sep 2024 19:49:46 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1smd5c-006047-8d; Fri, 06 Sep 2024 19:49:44 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1smd5c-00ABSk-0U;
	Fri, 06 Sep 2024 19:49:44 +0200
Date: Fri, 6 Sep 2024 19:49:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: net: ethernet-phy: Add
 forced-master/slave properties for SPE PHYs
Message-ID: <ZttAuDTVKKvxm1HB@pengutronix.de>
References: <20240906144905.591508-1-o.rempel@pengutronix.de>
 <c08ac9b7-08e1-4cde-979c-ed66d4a252f1@lunn.ch>
 <20240906175430.389cf208@device-28.home>
 <fde0f28d-3147-4a69-8be5-98e1d578a133@lunn.ch>
 <24097072-1d54-4a24-aaf3-c6b28f31a6cb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24097072-1d54-4a24-aaf3-c6b28f31a6cb@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Sep 06, 2024 at 09:22:29AM -0700, Florian Fainelli wrote:
> On 9/6/24 09:11, Andrew Lunn wrote:
> > > > 10Base-T1 often does not have autoneg, so preferred-master &
> > > > preferred-slave make non sense in this context, but i wounder if
> > > > somebody will want these later. An Ethernet switch is generally
> > > > preferred-master for example, but the client is preferred-slave.
> > > > 
> > > > Maybe make the property a string with supported values 'forced-master'
> > > > and 'forced-slave', leaving it open for the other two to be added
> > > > later.
> > > 
> > > My two cents, don't take it as a nack or any strong disagreement, my
> > > experience with SPE is still limited. I agree that for SPE, it's
> > > required that PHYs get their role assigned as early as possible,
> > > otherwise the link can't establish. I don't see any other place but DT
> > > to put that info, as this would be required for say, booting over the
> > > network. This to me falls under 'HW representation', as we could do the
> > > same with straps.
> > > 
> > > However for preferred-master / preferred-slave, wouldn't we be crossing
> > > the blurry line of "HW description => system configuration in the DT" ?
> > 
> > Yes, we are somewhere near the blurry line. This is why i gave the
> > example of an Ethernet switch, vs a client. Again, it could be done
> > with straps, so following your argument, it could be considered HW
> > representation. But if it is set wrong, it probably does not matter,
> > auto-neg should still work. Except for a very small number of PHYs
> > whos random numbers are not random...
> 
> Having had to deal with an Ethernet PHY that requires operating in slave
> mode "preferably" in order to have a correct RXC duty cycle, if you force
> both sides of the link to "slave", auto-negotiation will fail, however
> thanks to auto-negotiation you can tell that there was a master/slave
> resolution failure. (This reminds me I need to send the patch for that PHY
> errata at some point).
> 
> In the case that Oleksij seems to be after, there is no auto-negotiation (is
> that correct?), so it seems to me that the Device Tree is coming to the
> rescue of an improperly strapped HW, and is used as a way to change the
> default HW configuration so as to have a fighting chance of having a
> functional link. That is not unprecedented, but it is definitively a bit
> blurry...

Yes, there is no auto-negotiation on T1 PHY variants, so the DT property is
to fix broken or not existing for some reason HW straps.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

