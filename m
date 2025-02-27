Return-Path: <netdev+bounces-170367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB8A48568
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC0C3A5969
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BDD1A9B5B;
	Thu, 27 Feb 2025 16:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AB1B21AC
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674483; cv=none; b=obFpc6fYCEdwJizP5ljzQEalovBP35EyXjzkgHf0RFMzr4EX+cE/omBO/AoNGZr+Ib6oZRcqEPP5fmUbGgNoH5ov5G8Z9SZVS8udVi2c8GufrdnUlN+1l51Aok6O1OLh3at1VlN2UrTcst/nT98PeJuIrsqlamEldOfxfRfC32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674483; c=relaxed/simple;
	bh=QRz2GR01hMpu7P7aMvh4cB65ZqdVrSDqQqVZTdvDRCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihDvGk5CeC+lVU+f62NL3zNmZatPeHqEO7lqdsFZtRMeBj4SEqaDOO5uUMPcCvX46twX9HCVKYbktT57p7TK1D/LRLUbswPdOQE3DqYg3OYiefoXLB7w3RNWMmFNcUUPCFCnPRgBOCFzZyjcVSyNOjVdcIBJ9I/FKLs5B55oQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tngwH-0007ld-79; Thu, 27 Feb 2025 17:40:45 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tngwE-0039ik-2j;
	Thu, 27 Feb 2025 17:40:42 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tngwE-003TkQ-2I;
	Thu, 27 Feb 2025 17:40:42 +0100
Date: Thu, 27 Feb 2025 17:40:42 +0100
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
Message-ID: <Z8CVimyMj261wc7w@pengutronix.de>
References: <20250220165129.6f72f51a@kernel.org>
 <20250224141037.1c79122b@kmaincent-XPS-13-7390>
 <20250224134522.1cc36aa3@kernel.org>
 <20250225102558.2cf3d8a5@kmaincent-XPS-13-7390>
 <20250225174752.5dbf65e2@kernel.org>
 <Z76t0VotFL7ji41M@pengutronix.de>
 <Z76vfyv5XoMKmyH_@pengutronix.de>
 <20250226184257.7d2187aa@kernel.org>
 <Z8AW6S2xmzGZ0y9B@pengutronix.de>
 <20250227155727.7bdc069f@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227155727.7bdc069f@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Feb 27, 2025 at 03:57:27PM +0100, Kory Maincent wrote:
> On Thu, 27 Feb 2025 08:40:25 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Wed, Feb 26, 2025 at 06:42:57PM -0800, Jakub Kicinski wrote:
> > > On Wed, 26 Feb 2025 07:06:55 +0100 Oleksij Rempel wrote:  
> > > > Here is one example how it is done by HP switches:
> > > > https://arubanetworking.hpe.com/techdocs/AOS-CX/10.08/HTML/monitoring_6200/Content/Chp_PoE/PoE_cmds/pow-ove-eth-all-by.htm
> > > > 
> > > > switch(config)# interface 1/1/1    <---- per interface
> > > > switch(config-if)# power-over-ethernet allocate-by usage
> > > > switch(config-if)# power-over-ethernet allocate-by class
> > > > 
> > > > Cisco example:
> > > > https://www.cisco.com/c/en/us/td/docs/switches/datacenter/nexus9000/sw/93x/power-over-ethernet/configuration/configuring-power-over-ethernet/m-configuring-power-over-ethernet.html
> > > > 
> > > > switch(config)# interface ethernet1/1   <---- per interface
> > > > switch(config-if)# power inline auto  
> > > 
> > > I don't see any mention of a domain in these docs.
> > > This patchset is creating a concept of "domain" but does 
> > > not expose it as an object.  
> > 
> > Ok, I see. @Köry, can you please provide regulator_summary with some
> > inlined comments to regulators related to the PSE components and PSE
> > related outputs of ethtool (or what ever tool you are using).
> > 
> > I wont to use this examples to answer.
> 
> On my side, I am not close to using sysfs. As we do all configurations
> through ethtool I have assumed we should continue with ethtool.

Yes, I agree. But it won't be possible to do it for all components.

> I think we should set the port priority through ethtool.

ack

> but indeed the PSE  power domain method get and set could be moved to
> sysfs as it is not something  relative to the port but to a group of
> ports.

I would prefer to have it in the for of devlink or use regulator netlink
interface. But, we do not need to do this discussion right now.

> Ethtool should still report the  PSE power domain ID of a port to know
> which domain the port is.

Exactly.

@Jakub, at current implementation stage, user need to know the domain
id, because ports (and priorities) are grouped by the top level
regulators (pse-regX in the regulator_summary), they are our top-level
bottlenecks.

HP and Cisco switch either use different PSE controllers, or just didn't
exposed this nuance to the user. Let's assume, they have only one
global power domain.

So, in current patch set I would expect (not force :) ) implementation for
following fields:
- per port:
  - priority (valid within the power domain)
  - power reservation/allocation methods. First of all, because all
    already supported controllers have different implemented/default
    methods: microchip - dynamic, TI - static, regulator-pse - fixed (no
    classification is supported).
    At same time, in the future, we will need be able switch between
    (static or dynamic) and fixed for LLPD or manual configuration.
    Yes, at this point all ports show the same information and it seems
    to be duplicated.
  - power domain ID.

@Jakub, did I answered you question, or missed the point? :)

> @Oleksij here it is:

Thank you!

I do not expect it to be the primer user interface, but it can provide
additional diagnostic information. I wonted to see how it is aligns
with current ethtool UAPI implementation and if it possible to combine
it for diagnostics.

> # cat /sys/kernel/debug/regulator/regulator_summary
>  regulator                      use open bypass  opmode voltage current     min     max
> ---------------------------------------------------------------------------------------
>  regulator-dummy                  5    4      0 unknown     0mV     0mA     0mV     0mV 
>     d00e0000.sata-target          1                                 0mA     0mV     0mV
>     d00e0000.sata-phy             1                                 0mA     0mV     0mV
>     d00e0000.sata-ahci            1                                 0mA     0mV     0mV
>     spi0.0-vcc                    1                                 0mA     0mV     0mV
>  pse-reg                          1    4      0 unknown     0mV     0mA     0mV     0mV 

pse-regX should be attached to the main supply regulator for better full
picture. And use different name to be better identified as PSE power domains with ID?

>     pse-0-0020_pi0                0    1      0 unknown 53816mV  2369mA     0mV     0mV 
>        0-0020-pse-0-0020_pi0      0                                 0mA     0mV     0mV
>     pse-0-0020_pi2                0    1      0 unknown 53816mV  2369mA     0mV     0mV 
>        0-0020-pse-0-0020_pi2      0                                 0mA     0mV     0mV
>     pse-0-0020_pi7                0    1      0 unknown 53816mV  2369mA     0mV     0mV 
>        0-0020-pse-0-0020_pi7      0                                 0mA     0mV     0mV
>  pse-reg2                         1    2      0 unknown     0mV     0mA     0mV     0mV 
>     pse-0-0020_pi1                0    0      0 unknown 53816mV  4738mA     0mV     0mV 
>  vcc_sd1                          2    1      0 unknown  1800mV     0mA  1800mV  3300mV 
>     d00d0000.mmc-vqmmc            1                                 0mA  1800mV  1950mV
> 
> # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-get --json
>  '{"header":{"dev-name":"wan"}}'
> {'c33-pse-admin-state': 2,
>  'c33-pse-avail-pw-limit': 127500,
>  'c33-pse-pw-d-status': 2,
>  'c33-pse-pw-limit-ranges': [{'max': 99900, 'min': 2000}],
>  'header': {'dev-index': 4, 'dev-name': 'wan'},
>  'pse-budget-eval-strat': 2,
>  'pse-prio': 0,
>  'pse-prio-max': 8,
>  'pse-pw-d-id': 1}
> 
> # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set --json
>  '{"header":{"dev-name":"wan"}, "pse-prio":1}'
> None
> # ./ynl/cli.py --spec netlink/specs/ethtool.yaml --no-schema --do pse-set --json
> '{"header":{"dev-name":"wan"}, "c33-pse-avail-pw-limit":15000}'


Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

