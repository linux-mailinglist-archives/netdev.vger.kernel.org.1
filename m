Return-Path: <netdev+bounces-170922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CCDA4AB0D
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 14:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D053B9E55
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862D1DA314;
	Sat,  1 Mar 2025 13:01:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE611C5D67
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740834073; cv=none; b=hWC5NmkJqOn1+KEgdPJWL9PA7o3KJ5JyFyaQAV7VgBBL83LHwgVL2+UsI/VwqUmMDL8mbOYuc55cPdTH/1aHWlIiMJxRVH22pddsgww0iMhacSepMpXw7as7gQ+XhNF0pc797L+WWeXPTzzCE4suAD527bYkYdViHGUE29zBNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740834073; c=relaxed/simple;
	bh=mKLPjyiZUnld6i3DaHnwwGaNNhqCVD5Nat+a58bVjWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr6FnvcYGuQ/qR8rr2rSfhx1niXohKuTMrA5vHdeOeG4rVXm+0T6UdcYvv1fEX7nZD5jZZJma9iKWWCOi/rEAv5mOKbz4+dHNBMYnjm8VlLe47CPcazWZHzV3iCDaCeCpgsgn5V8xOMGJgba4Qv2NRUKBpWK0T+5WHcrWfHShzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1toMSU-0003w3-PV; Sat, 01 Mar 2025 14:00:46 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1toMSR-003Sv8-2F;
	Sat, 01 Mar 2025 14:00:43 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1toMSR-007APN-1n;
	Sat, 01 Mar 2025 14:00:43 +0100
Date: Sat, 1 Mar 2025 14:00:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <Z8ME-90Xg46-pNhA@pengutronix.de>
References: <20250224134522.1cc36aa3@kernel.org>
 <20250225102558.2cf3d8a5@kmaincent-XPS-13-7390>
 <20250225174752.5dbf65e2@kernel.org>
 <Z76t0VotFL7ji41M@pengutronix.de>
 <Z76vfyv5XoMKmyH_@pengutronix.de>
 <20250226184257.7d2187aa@kernel.org>
 <Z8AW6S2xmzGZ0y9B@pengutronix.de>
 <20250227155727.7bdc069f@kmaincent-XPS-13-7390>
 <Z8CVimyMj261wc7w@pengutronix.de>
 <20250227192640.20df155d@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227192640.20df155d@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Feb 27, 2025 at 07:26:40PM +0100, Kory Maincent wrote:
> On Thu, 27 Feb 2025 17:40:42 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Thu, Feb 27, 2025 at 03:57:27PM +0100, Kory Maincent wrote:
> > > On Thu, 27 Feb 2025 08:40:25 +0100
> > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >   
> > > > On Wed, Feb 26, 2025 at 06:42:57PM -0800, Jakub Kicinski wrote:  
> >  [...]  
> >  [...]  
> >  [...]  
> > > > 
> > > > Ok, I see. @Köry, can you please provide regulator_summary with some
> > > > inlined comments to regulators related to the PSE components and PSE
> > > > related outputs of ethtool (or what ever tool you are using).
> > > > 
> > > > I wont to use this examples to answer.  
> > > 
> > > On my side, I am not close to using sysfs. As we do all configurations
> > > through ethtool I have assumed we should continue with ethtool.  
> > 
> > Yes, I agree. But it won't be possible to do it for all components.
> > 
> > > I think we should set the port priority through ethtool.  
> > 
> > ack
> > 
> > > but indeed the PSE  power domain method get and set could be moved to
> > > sysfs as it is not something  relative to the port but to a group of
> > > ports.  
> > 
> > I would prefer to have it in the for of devlink or use regulator netlink
> > interface. But, we do not need to do this discussion right now.
> 
> If we want to report the method we should discuss it now. We shouldn't add
> BUDGET_EVAL_STRAT uAPI to ethtool if we use another way to get and set the
> method later.

Ok, I assume we are talking about different things. I mean - not port
specific configurations and diagnostic, will have different interface.

BUDGET_EVAL_STRAT is port specific. HP and Cisco implement it as port
specific. PD692x0 Protocol manual describe it as port specific too:
3.3.6 Set BT Port Parameters
 Bits [3..0]—BT port PM mode
  0x0: The port power that is used for power management purposes is
       dynamic (Iport x Vmain).
  0x1: The port power that is used for power management purposes is port
       TPPL_BT.
  0x2: The port power that is used for power management purposes is
       dynamic for non LLDP/CDP/Autoclass ports and TPPL_BT for LLDP/CDP/Autoclass ports.
  0xF: Do not change settings.

> We could also not report the method for now and assume the user knows it for
> the two controllers currently supported.

On one side: it is not just status, but also active configuration. By
implementing the interface we may break default configuration and user
expectations.

On other side: PD692x0 seems to need more then just setting prios to
manage them correctly. For example power bank limits should be set,
otherwise internal firmware won't be able to perform budget calculations.

So, I assume, critical components are missing anyway.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

