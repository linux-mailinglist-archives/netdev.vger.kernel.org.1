Return-Path: <netdev+bounces-249969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D3D21BA2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC96302C210
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90734105F;
	Wed, 14 Jan 2026 23:16:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C2264A9D;
	Wed, 14 Jan 2026 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432561; cv=none; b=BsuGdBYT4+bTStXsxGea8YtWicNM5r4otDxzh1X3Y40x6Kh3wMuZsZB+vVRroEz5EZYKu3uz2H4fH1s6Bd+BKPTWCSKJqYmg2cA9WkOReC4FUiZWEznlrSEkho23AD6mbKpRBJtRfqC8dAFB3/2kRrFLAC8/PHmtWiNcB4wrNIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432561; c=relaxed/simple;
	bh=OGaMxOeTXn1pcqctpASMy5+LhqsiC8UuEMurex7JKGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIzQvzleLZVOwV/8PWE+/fQTcoqnV5kRaf6vN+vf+1CZ5fT6ci9c88HfIL9Ly/w/+8BAWD8jjeRa9wx5sfc5iNfMOkEMi+FzpD22e65hM1pcYok9LVusGm2VxaoEH9XRbbV18/7ORw5bZKtqQBJXdoMyvDH/N2FTCXMWTHu5rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgA5Y-000000001lr-0fbU;
	Wed, 14 Jan 2026 23:15:44 +0000
Date: Wed, 14 Jan 2026 23:15:40 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v5 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aWgjnJEAV4M3WrcP@makrotopia.org>
References: <cover.1768225363.git.daniel@makrotopia.org>
 <cover.1768225363.git.daniel@makrotopia.org>
 <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>
 <169e8a64d3f4db3139f2c85ac5164c52ca861156.1768225363.git.daniel@makrotopia.org>
 <20260114225736.c7w3tpfol7bdc4so@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114225736.c7w3tpfol7bdc4so@skbuf>

On Thu, Jan 15, 2026 at 12:57:36AM +0200, Vladimir Oltean wrote:
> On Mon, Jan 12, 2026 at 01:52:52PM +0000, Daniel Golle wrote:
> > Add very basic DSA driver for MaxLinear's MxL862xx switches.
> > 
> > In contrast to previous MaxLinear switches the MxL862xx has a built-in
> > processor that runs a sophisticated firmware based on Zephyr RTOS.
> > Interaction between the host and the switch hence is organized using a
> > software API of that firmware rather than accessing hardware registers
> > directly.
> > 
> > Add descriptions of the most basic firmware API calls to access the
> > built-in MDIO bus hosting the 2.5GE PHYs, basic port control as well as
> > setting up the CPU port.
> > 
> > Implement a very basic DSA driver using that API which is sufficient to
> > get packets flowing between the user ports and the CPU port.
> > 
> > The firmware offers all features one would expect from a modern switch
> > hardware, they will be added one by one in follow-up patch series.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v5:
> >  * output warning in .setup regarding unknown pre-configuration
> >  * add comment explaining why CFGGET is used in reset function
> > 
> > RFC v4:
> >  * poll switch readiness after reset
> >  * implement driver shutdown
> >  * added port_fast_aging API call and driver op
> >  * unified port setup in new .port_setup op
> >  * improve comment explaining special handlign for unaligned API read
> >  * various typos
> > 
> > RFC v3:
> >  * fix return value being uninitialized on error in mxl862xx_api_wrap()
> >  * add missing descrition in kerneldoc comment of
> >    struct mxl862xx_ss_sp_tag
> > 
> > RFC v2:
> >  * make use of struct mdio_device
> >  * add phylink_mac_ops stubs
> >  * drop leftover nonsense from mxl862xx_phylink_get_caps()
> >  * use __le32 instead of enum types in over-the-wire structs
> >  * use existing MDIO_* macros whenever possible
> >  * simplify API constants to be more readable
> >  * use readx_poll_timeout instead of open-coding poll timeout loop
> >  * add mxl862xx_reg_read() and mxl862xx_reg_write() helpers
> >  * demystify error codes returned by the firmware
> >  * add #defines for mxl862xx_ss_sp_tag member values
> >  * move reset to dedicated function, clarify magic number being the
> >    reset command ID
> > 
> >  MAINTAINERS                              |   1 +
> >  drivers/net/dsa/Kconfig                  |   2 +
> >  drivers/net/dsa/Makefile                 |   1 +
> >  drivers/net/dsa/mxl862xx/Kconfig         |  12 +
> >  drivers/net/dsa/mxl862xx/Makefile        |   3 +
> >  drivers/net/dsa/mxl862xx/mxl862xx-api.h  | 177 +++++++++
> >  drivers/net/dsa/mxl862xx/mxl862xx-cmd.h  |  32 ++
> >  drivers/net/dsa/mxl862xx/mxl862xx-host.c | 230 ++++++++++++
> >  drivers/net/dsa/mxl862xx/mxl862xx-host.h |   5 +
> >  drivers/net/dsa/mxl862xx/mxl862xx.c      | 433 +++++++++++++++++++++++
> >  drivers/net/dsa/mxl862xx/mxl862xx.h      |  24 ++
> >  11 files changed, 920 insertions(+)
> >  create mode 100644 drivers/net/dsa/mxl862xx/Kconfig
> >  create mode 100644 drivers/net/dsa/mxl862xx/Makefile
> >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-api.h
> >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
> >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.c
> >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.h
> >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.c
> >  create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.h
> > 
> > +static int mxl862xx_setup(struct dsa_switch *ds)
> > +{
> > +	struct mxl862xx_priv *priv = ds->priv;
> > +	int ret;
> > +
> > +	ret = mxl862xx_reset(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mxl862xx_wait_ready(ds);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = mxl862xx_setup_mdio(ds);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_warn(ds->dev, "Unknown switch pre-configuration, ports may be bridged!\n");
> 
> Nack. User space needs to be in control of the forwarding domain of the
> ports, and isolating user ports is the bare minimum requirement,
> otherwise you cannot even connect the ports of this device to a switch
> without creating L2 loops.
> 
> It seems that it is too early for this switch to be supported by
> mainline. Maybe in staging...

In order to avoid the detour via staging, from my perspective there are two
ways to go from here:

a) Keep nagging MaxLinear to provide a switch firmware with an additional
firmware command which flushes the pre-configuration and puts the switch
in a well-defined state (all ports isolated, learning disabled) for DSA.

b) Extend the patch to cover all the API calls needed to do this
manually (more than double of LoC).

Obviously a) would be better for me and you, but MaxLinear indicated they
prefer not to release an new firmware adding that feature at this point.

b) would allow me to proceed right away, but it would burden reviewers
with a rather huge patch for initial support for this switch.
For the sake of making review more easy I'd prefer to still keep this
in a series of not terribly huge patches rather than a single patch
which immediately brings in everything (ie. have bridge and bridgeport
configuration in one patch, FDB access in the next, ...). Would a
series adding everything needed to end up with isolated ports be
acceptable?

Please let me know what you think.

