Return-Path: <netdev+bounces-240416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73179C749DB
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6ED952B6F1
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6229D26C;
	Thu, 20 Nov 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoTIhCy6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6E279DA2;
	Thu, 20 Nov 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763649652; cv=none; b=PAYjpcDZjhVD/HZ9k96OicwIJveEz6zr+yGVQEZGNbDnqPOPtiS1bKG/eCyS23aTuU21J0xI0CgOP/RhhFz5SV9qTFZmUqdj4uKx2Nx8lGOBvENL8YsMsyYi1dY9ZvdlrNO+sKqmdP1+fi3KdAcRUlhDVC/TXJrN6Oicsy3pplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763649652; c=relaxed/simple;
	bh=PSx9xciQ/tFowvICGE6/QmWnUIvM3qh/xcYf4f3SeW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY+EuRYSQvgkAqa+5sTjQTvSjvA4M2qSQoc9aP0F3NvNfaAJo9aPhmDvI5bgxSqdjbN3Nq1Wz8XyAQJ8e740Sm+MTQYqjyZ0ispbnepxbZOVbDTfLJ8KBp5T4qIAh9/HtRYNcSW156VAUHXU94QNnVAAkCWoVA96Ej6Nk5u6bWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoTIhCy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCD2C4CEF1;
	Thu, 20 Nov 2025 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763649652;
	bh=PSx9xciQ/tFowvICGE6/QmWnUIvM3qh/xcYf4f3SeW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hoTIhCy6WhOk69mGV1KV2q/fhx2c/4INB1bEKARDUQzEb3Lcrs+76WuWNgmwrfQC8
	 +q9wBjZy1k9HM45DaYoJUlCKjzPtvf1H+EAIb4abfl6GZeBVfVVbF+m50OvU1U/316
	 /ggZkQgOTKchSjz6SWBgdWCPPe2U9JIBKRtV0C2JxIAwuzLbhONx2sxSc0678bttyz
	 un62QRKS1yfjJN9N8ckkveCXeDtvBl0n3NpWa1Is2c+ua3aYkTt5sg5lrfRaTUcqTL
	 2KZZZ2LdLO29v9dp1ii0IJsJJ/ZHWLI6cMy8aEP63p1Rh770xZ/bEGMvwXw1rElHNG
	 mwFywiqtcMPeQ==
Date: Thu, 20 Nov 2025 14:40:46 +0000
From: Lee Jones <lee@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/15] net: dsa: sja1105: transition OF-based
 MDIO drivers to standalone
Message-ID: <20251120144046.GE661940@google.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-9-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118190530.580267-9-vladimir.oltean@nxp.com>

On Tue, 18 Nov 2025, Vladimir Oltean wrote:

> Delete the duplicated drivers for 100base-T1 and 100base-TX from the DSA
> driver, and use devm_mfd_add_devices() to platform devices which probe
> on the dedicated drivers from drivers/net/mdio/. This makes the switch
> act as a sort of bus driver for devices in the "mdios" subnode.
> 
> We can use mfd because the switch driver interacts with the PHYs from
> these MDIO buses exclusively using phylink, which follows "phy-handle"
> fwnode references to them.
> 
> Cc: Lee Jones <lee@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/sja1105/Kconfig        |   1 +
>  drivers/net/dsa/sja1105/Makefile       |   1 +
>  drivers/net/dsa/sja1105/sja1105.h      |   4 -
>  drivers/net/dsa/sja1105/sja1105_main.c |  13 ++
>  drivers/net/dsa/sja1105/sja1105_mdio.c | 270 +------------------------
>  drivers/net/dsa/sja1105/sja1105_mfd.c  |  69 +++++++
>  drivers/net/dsa/sja1105/sja1105_mfd.h  |   9 +
>  drivers/net/dsa/sja1105/sja1105_spi.c  |   6 -
>  8 files changed, 94 insertions(+), 279 deletions(-)
>  create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.c
>  create mode 100644 drivers/net/dsa/sja1105/sja1105_mfd.h
> 
> diff --git a/drivers/net/dsa/sja1105/Kconfig b/drivers/net/dsa/sja1105/Kconfig
> index 1291bba3f3b6..932bca545d69 100644
> --- a/drivers/net/dsa/sja1105/Kconfig
> +++ b/drivers/net/dsa/sja1105/Kconfig
> @@ -7,6 +7,7 @@ tristate "NXP SJA1105 Ethernet switch family support"
>  	select PCS_XPCS
>  	select PACKING
>  	select CRC32
> +	select MFD_CORE
>  	help
>  	  This is the driver for the NXP SJA1105 (5-port) and SJA1110 (10-port)
>  	  automotive Ethernet switch family. These are managed over an SPI
> diff --git a/drivers/net/dsa/sja1105/Makefile b/drivers/net/dsa/sja1105/Makefile
> index 40d69e6c0bae..3ac2d77dbe6c 100644
> --- a/drivers/net/dsa/sja1105/Makefile
> +++ b/drivers/net/dsa/sja1105/Makefile
> @@ -5,6 +5,7 @@ sja1105-objs := \
>      sja1105_spi.o \
>      sja1105_main.o \
>      sja1105_mdio.o \
> +    sja1105_mfd.o \
>      sja1105_flower.o \
>      sja1105_ethtool.o \
>      sja1105_devlink.o \
> diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
> index 4fd6121bd07f..ff6b69663851 100644
> --- a/drivers/net/dsa/sja1105/sja1105.h
> +++ b/drivers/net/dsa/sja1105/sja1105.h
> @@ -91,8 +91,6 @@ struct sja1105_regs {
>  	u64 rmii_ref_clk[SJA1105_MAX_NUM_PORTS];
>  	u64 rmii_ext_tx_clk[SJA1105_MAX_NUM_PORTS];
>  	u64 stats[__MAX_SJA1105_STATS_AREA][SJA1105_MAX_NUM_PORTS];
> -	u64 mdio_100base_tx;
> -	u64 mdio_100base_t1;
>  	u64 pcs_base[SJA1105_MAX_NUM_PORTS];
>  };
>  
> @@ -279,8 +277,6 @@ struct sja1105_private {
>  	struct regmap *regmap;
>  	struct devlink_region **regions;
>  	struct sja1105_cbs_entry *cbs;
> -	struct mii_bus *mdio_base_t1;
> -	struct mii_bus *mdio_base_tx;
>  	struct mii_bus *mdio_pcs;
>  	struct phylink_pcs *pcs[SJA1105_MAX_NUM_PORTS];
>  	struct sja1105_ptp_data ptp_data;
> diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
> index 622264c13fdb..6da5c655dae7 100644
> --- a/drivers/net/dsa/sja1105/sja1105_main.c
> +++ b/drivers/net/dsa/sja1105/sja1105_main.c
> @@ -23,6 +23,7 @@
>  #include <linux/units.h>
>  
>  #include "sja1105.h"
> +#include "sja1105_mfd.h"
>  #include "sja1105_tas.h"
>  
>  #define SJA1105_UNKNOWN_MULTICAST	0x010000000000ull
> @@ -3316,6 +3317,11 @@ static int sja1105_probe(struct spi_device *spi)
>  	if (priv->max_xfer_len > max_msg - SJA1105_SIZE_SPI_MSG_HEADER)
>  		priv->max_xfer_len = max_msg - SJA1105_SIZE_SPI_MSG_HEADER;
>  
> +	/* Explicitly advertise "no DMA" support, to suppress
> +	 * "DMA mask not set" warning in MFD children
> +	 */
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
>  	priv->info = of_device_get_match_data(dev);
>  
>  	rc = sja1105_create_regmap(priv);
> @@ -3356,6 +3362,13 @@ static int sja1105_probe(struct spi_device *spi)
>  		return rc;
>  	}
>  
> +	rc = sja1105_mfd_add_devices(ds);
> +	if (rc) {
> +		dev_err(ds->dev, "Failed to create child devices: %pe\n",
> +			ERR_PTR(rc));
> +		return rc;
> +	}
> +
>  	if (IS_ENABLED(CONFIG_NET_SCH_CBS)) {
>  		priv->cbs = devm_kcalloc(dev, priv->info->num_cbs_shapers,
>  					 sizeof(struct sja1105_cbs_entry),
> diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
> index 8d535c033cef..b803ce71f5cc 100644
> --- a/drivers/net/dsa/sja1105/sja1105_mdio.c
> +++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
> @@ -133,238 +133,6 @@ int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
>  				&tmp, NULL);

[...]

> diff --git a/drivers/net/dsa/sja1105/sja1105_mfd.c b/drivers/net/dsa/sja1105/sja1105_mfd.c
> new file mode 100644
> index 000000000000..9e60cd3b5d01
> --- /dev/null
> +++ b/drivers/net/dsa/sja1105/sja1105_mfd.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2025 NXP
> + */
> +#include <linux/ioport.h>
> +#include <linux/mfd/core.h>

The MFD API is not to be {ab}used out side of drivers/mfd.

Maybe of_platform_populate() will scratch your itch instead.

[...]

-- 
Lee Jones [李琼斯]

