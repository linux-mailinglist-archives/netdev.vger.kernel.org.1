Return-Path: <netdev+bounces-216272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068FDB32E21
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DB21641F8
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C30B25782F;
	Sun, 24 Aug 2025 08:11:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A615DBC1
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756023105; cv=none; b=DlYzwKv+71oqAhMEUwgRyTCFaf9sSLiWw6FuEuXfK0BsRsoFZbHcwlYt3LHLHm15eL7IfbxVeQkGyHupAD8H8iUw+hfR36p0JTFYKPO37tIx/A8RE1ddn6DUkeIfmfrgHxZQ8JOI6kjQ9A4FZlR67P75YgIy0mQ1+aEtX+anavg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756023105; c=relaxed/simple;
	bh=ul0IsjUDFsISjShCNiRq6tbem1Qonz9NW/U6PGV3QOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfHSmspJu98HQKzf+AnLne6htnZ8o689452KA4sv3KztJYOYUScj+G6/OQ8EPeTdrNLqG9131iCimaFUY+vVAHAcfVByK1Rxz42haetn5fskV03MYAK5PRZ+cANORalvWk5lR9mu0XobPl0WC3/cXyZs33tj4gy7mzkGxs5ylSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uq5oT-0006qR-Nx; Sun, 24 Aug 2025 10:10:53 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uq5oJ-001sF8-2g;
	Sun, 24 Aug 2025 10:10:43 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uq5oJ-00EEAb-2D;
	Sun, 24 Aug 2025 10:10:43 +0200
Date: Sun, 24 Aug 2025 10:10:43 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v3 2/3] net: ynl: add generated kdoc to UAPI
 headers
Message-ID: <aKrJAzMdgGcNiRUC@pengutronix.de>
References: <20250820131023.855661-1-o.rempel@pengutronix.de>
 <20250820131023.855661-3-o.rempel@pengutronix.de>
 <7e948eb9-2704-433e-9b51-fd83716e37d1@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e948eb9-2704-433e-9b51-fd83716e37d1@oracle.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Aug 22, 2025 at 07:41:39PM +0530, ALOK TIWARI wrote:
> 
> 
> On 8/20/2025 6:40 PM, Oleksij Rempel wrote:
> > Run the ynl regeneration script to apply the kdoc generation
> > support added in the previous commit.
> > 
> > This updates the generated UAPI headers for dpll, ethtool, team,
> > net_shaper, netdev, and ovpn with documentation parsed from their
> > respective YAML specifications.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >   include/uapi/linux/dpll.h                     |  30 ++++
> >   .../uapi/linux/ethtool_netlink_generated.h    |  29 +++
> >   include/uapi/linux/if_team.h                  |  11 ++
> >   include/uapi/linux/net_shaper.h               |  50 ++++++
> >   include/uapi/linux/netdev.h                   | 165 ++++++++++++++++++
> >   include/uapi/linux/ovpn.h                     |  62 +++++++
> >   tools/include/uapi/linux/netdev.h             | 165 ++++++++++++++++++
> >   7 files changed, 512 insertions(+)
> > 
> > diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
> > index 37b438ce8efc..23a4e3598650 100644
> > --- a/include/uapi/linux/dpll.h
> > +++ b/include/uapi/linux/dpll.h
> > @@ -203,6 +203,18 @@ enum dpll_feature_state {
> >   	DPLL_FEATURE_STATE_ENABLE,
> >   };
> > +/**
> > + * enum dpll_dpll
> > + * @DPLL_A_CLOCK_QUALITY_LEVEL: Level of quality of a clock device. This mainly
> > + *   applies when the dpll lock-status is DPLL_LOCK_STATUS_HOLDOVER. This could
> > + *   be put to message multiple times to indicate possible parallel quality
> > + *   levels (e.g. one specified by ITU option 1 and another one specified by
> > + *   option 2).
> > + * @DPLL_A_PHASE_OFFSET_MONITOR: Receive or request state of phase offset
> > + *   monitor feature. If enabled, dpll device shall monitor and notify all
> > + *   currently available inputs for changes of their phase offset against the
> > + *   dpll device.
> > + */
> >   enum dpll_a {
> >   	DPLL_A_ID = 1,
> >   	DPLL_A_MODULE_NAME,
> > @@ -221,6 +233,24 @@ enum dpll_a {
> >   	DPLL_A_MAX = (__DPLL_A_MAX - 1)
> >   };
> > +/**
> > + * enum dpll_pin
> > + * @DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET: The FFO (Fractional Frequency
> > + *   Offset) between the RX and TX symbol rate on the media associated with the
> > + *   pin: (rx_frequency-tx_frequency)/rx_frequency Value is in PPM (parts per
> 
> spacing for clarity (rx_frequency - tx_frequency) / rx_frequency

Thank you for the review. The comments you refer to are autogenerated
from the YAML specs. Extending my patch to adjust or clean up those
generated comments would mean adding side-quests outside the scope of
the actual change. I’d rather keep this series focused, otherwise I risk
not being able to complete it.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

