Return-Path: <netdev+bounces-170766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB27A49DB5
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474EC189A18E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9822C18CC1D;
	Fri, 28 Feb 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wh8fVZpJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18454187859;
	Fri, 28 Feb 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757302; cv=none; b=siIk8JOU67xT/4bWeeHnM7m0dSOHpOFWDF5owdDzmQRWZl3SxpHtS0W51EpZl6fHmd3HGQA3r9YuOLbyP2fxYuzmEXKgtuTSe1JOYAewDdE2TiRkPT6duyG2Hk+PmEGwYfQgrfHmQtxIS35bHSSyRsGs2VjX/qrjX1SLVouUuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757302; c=relaxed/simple;
	bh=aY2kO9WANmtJtKhEUiqOw09UEMtnTKNz+8dyRnvMzzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alYK3edT9jCfViBYwwFw26VvQaD8zgIPcb+3xAYeCNpN5XCNqUmC7qDJS5p+gXsgFnR2xzsLzqYu87nGFsUB+rE4rwEdJz2Da8XP1NDtQJNBrC9ox38p1EvGzrnXMc7EhQbr21EjU0Z6hbK3MmY3IT9vX5Q84oUg1BgE9uasM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wh8fVZpJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OPyxcz+qZruqJAbTurcqgZiEIfW6EaIvOQmjH5Rvfb8=; b=wh8fVZpJ8GicT8IR9RR6P6QQUY
	pV8hFf0nIYTO8jUHitVhT5EGH2nKkcq9n3H+v9SmJmfQ62okX6NOC0cUj5J6BfcPfEv5MhD4u6pt6
	8x1wArrm1y8uNoazZOCihetjkrcaXtmJUAau7FEmXtNFz1A5jQKw1CWbgFY097OAaps8dt/KcVzXR
	jDwuVzHSdT5TfJywPZGveTQbawu4rQNNfVu2HCIYMbpAx/1IsJ/ogAqX7P5JZIk7EYA1AzyKbdotn
	oiCfbS1e8wSatw88zTsMjLkOhH9aq3+k+EtTvwMQf3LvLqTAVd0Wu3IEjZzU94kmiA869UwCfhJXq
	2zo0xSKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57018)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1to2UV-0002H9-2g;
	Fri, 28 Feb 2025 15:41:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1to2UR-0000rP-01;
	Fri, 28 Feb 2025 15:41:27 +0000
Date: Fri, 28 Feb 2025 15:41:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v3 02/13] net: phy: Use an internal, searchable
 storage for the linkmodes
Message-ID: <Z8HZJo9GE23uq5ew@shell.armlinux.org.uk>
References: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
 <20250228145540.2209551-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228145540.2209551-3-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 28, 2025 at 03:55:27PM +0100, Maxime Chevallier wrote:
> The canonical definition for all the link modes is in linux/ethtool.h,
> which is complemented by the link_mode_params array stored in
> net/ethtool/common.h . That array contains all the metadata about each
> of these modes, including the Speed and Duplex information.
> 
> Phylib and phylink needs that information as well for internal
> management of the link, which was done by duplicating that information
> in locally-stored arrays and lookup functions. This makes it easy for
> developpers adding new modes to forget modifying phylib and phylink
> accordingly.
> 
> However, the link_mode_params array in net/ethtool/common.c is fairly
> inefficient to search through, as it isn't sorted in any manner. Phylib
> and phylink perform a lot of lookup operations, mostly to filter modes
> by speed and/or duplex.
> 
> We therefore introduce the link_caps private array in phy_caps.c, that
> indexes linkmodes in a more efficient manner. Each element associated a
> tuple <speed, duplex> to a bitfield of all the linkmodes runs at these
> speed/duplex.
> 
> We end-up with an array that's fairly short, easily addressable and that
> it optimised for the typical use-cases of phylib/phylink.
> 
> That array is initialized at the same time as phylib. As the
> link_mode_params array is part of the net stack, which phylink depends
> on, it should always be accessible from phylib.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/Makefile     |  2 +-
>  drivers/net/phy/phy-caps.h   | 44 ++++++++++++++++++++
>  drivers/net/phy/phy_caps.c   | 78 ++++++++++++++++++++++++++++++++++++
>  drivers/net/phy/phy_device.c |  2 +
>  4 files changed, 125 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/phy/phy-caps.h
>  create mode 100644 drivers/net/phy/phy_caps.c
> 
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index c8dac6e92278..7e800619162b 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Linux PHY drivers
>  
>  libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
> -				   linkmode.o phy_link_topology.o
> +				   linkmode.o phy_link_topology.o phy_caps.o
>  mdio-bus-y			+= mdio_bus.o mdio_device.o
>  
>  ifdef CONFIG_MDIO_DEVICE
> diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
> new file mode 100644
> index 000000000000..846d483269f6
> --- /dev/null
> +++ b/drivers/net/phy/phy-caps.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * link caps internal header, for link modes <-> capabilities <-> interfaces
> + * conversions.
> + */
> +
> +#ifndef __PHY_CAPS_H
> +#define __PHY_CAPS_H
> +
> +#include <linux/ethtool.h>
> +
> +enum {
> +	LINK_CAPA_10HD = 0,
> +	LINK_CAPA_10FD,
> +	LINK_CAPA_100HD,
> +	LINK_CAPA_100FD,
> +	LINK_CAPA_1000HD,
> +	LINK_CAPA_1000FD,
> +	LINK_CAPA_2500FD,
> +	LINK_CAPA_5000FD,
> +	LINK_CAPA_10000FD,
> +	LINK_CAPA_20000FD,
> +	LINK_CAPA_25000FD,
> +	LINK_CAPA_40000FD,
> +	LINK_CAPA_50000FD,
> +	LINK_CAPA_56000FD,
> +	LINK_CAPA_100000FD,
> +	LINK_CAPA_200000FD,
> +	LINK_CAPA_400000FD,
> +	LINK_CAPA_800000FD,
> +
> +	__LINK_CAPA_LAST = LINK_CAPA_800000FD,
> +	__LINK_CAPA_MAX,
> +};
> +
> +struct link_capabilities {
> +	int speed;
> +	unsigned int duplex;
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(linkmodes);
> +};
> +
> +void phy_caps_init(void);
> +
> +#endif /* __PHY_CAPS_H */
> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> new file mode 100644
> index 000000000000..367ca7110ddc
> --- /dev/null
> +++ b/drivers/net/phy/phy_caps.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/ethtool.h>
> +#include <linux/linkmode.h>
> +#include <linux/phy.h>
> +
> +#include "phy-caps.h"
> +
> +static struct link_capabilities link_caps[__LINK_CAPA_MAX] __ro_after_init = {
> +	{ SPEED_10, DUPLEX_HALF, {0} }, /* LINK_CAPA_10HD */
> +	{ SPEED_10, DUPLEX_FULL, {0} }, /* LINK_CAPA_10FD */
> +	{ SPEED_100, DUPLEX_HALF, {0} }, /* LINK_CAPA_100HD */
> +	{ SPEED_100, DUPLEX_FULL, {0} }, /* LINK_CAPA_100FD */
> +	{ SPEED_1000, DUPLEX_HALF, {0} }, /* LINK_CAPA_1000HD */
> +	{ SPEED_1000, DUPLEX_FULL, {0} }, /* LINK_CAPA_1000FD */
> +	{ SPEED_2500, DUPLEX_FULL, {0} }, /* LINK_CAPA_2500FD */
> +	{ SPEED_5000, DUPLEX_FULL, {0} }, /* LINK_CAPA_5000FD */
> +	{ SPEED_10000, DUPLEX_FULL, {0} }, /* LINK_CAPA_10000FD */
> +	{ SPEED_20000, DUPLEX_FULL, {0} }, /* LINK_CAPA_20000FD */
> +	{ SPEED_25000, DUPLEX_FULL, {0} }, /* LINK_CAPA_25000FD */
> +	{ SPEED_40000, DUPLEX_FULL, {0} }, /* LINK_CAPA_40000FD */
> +	{ SPEED_50000, DUPLEX_FULL, {0} }, /* LINK_CAPA_50000FD */
> +	{ SPEED_56000, DUPLEX_FULL, {0} }, /* LINK_CAPA_56000FD */
> +	{ SPEED_100000, DUPLEX_FULL, {0} }, /* LINK_CAPA_100000FD */
> +	{ SPEED_200000, DUPLEX_FULL, {0} }, /* LINK_CAPA_200000FD */
> +	{ SPEED_400000, DUPLEX_FULL, {0} }, /* LINK_CAPA_400000FD */
> +	{ SPEED_800000, DUPLEX_FULL, {0} }, /* LINK_CAPA_800000FD */
> +};
> +
> +static int speed_duplex_to_capa(int speed, unsigned int duplex)
> +{
> +	if (duplex == DUPLEX_UNKNOWN ||
> +	    (speed > SPEED_1000 && duplex != DUPLEX_FULL))
> +		return -EINVAL;
> +
> +	switch (speed) {
> +	case SPEED_10: return duplex == DUPLEX_FULL ?
> +			      LINK_CAPA_10FD : LINK_CAPA_10HD;
> +	case SPEED_100: return duplex == DUPLEX_FULL ?
> +			       LINK_CAPA_100FD : LINK_CAPA_100HD;
> +	case SPEED_1000: return duplex == DUPLEX_FULL ?
> +				LINK_CAPA_1000FD : LINK_CAPA_1000HD;
> +	case SPEED_2500: return LINK_CAPA_2500FD;
> +	case SPEED_5000: return LINK_CAPA_5000FD;
> +	case SPEED_10000: return LINK_CAPA_10000FD;
> +	case SPEED_20000: return LINK_CAPA_20000FD;
> +	case SPEED_25000: return LINK_CAPA_25000FD;
> +	case SPEED_40000: return LINK_CAPA_40000FD;
> +	case SPEED_50000: return LINK_CAPA_50000FD;
> +	case SPEED_56000: return LINK_CAPA_56000FD;
> +	case SPEED_100000: return LINK_CAPA_100000FD;
> +	case SPEED_200000: return LINK_CAPA_200000FD;
> +	case SPEED_400000: return LINK_CAPA_400000FD;
> +	case SPEED_800000: return LINK_CAPA_800000FD;

I think one of the issues you mentioned is about the need to update
several places as new linkmodes are added.

One of the side effects of adding new linkmodes is that they generally
come with faster speeds, so this is a place that needs to be updated
along with the table above.

I'm not sure whether this makes that problem better or worse - if a
new linkmode is added with a SPEED_*, the author of such a change has
to be on the ball to update these, and I'm not sure that'll happen.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

