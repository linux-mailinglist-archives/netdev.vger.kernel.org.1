Return-Path: <netdev+bounces-191581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1CABC4C8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C9189F80A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1B284B42;
	Mon, 19 May 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCNnrMTO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A4189906;
	Mon, 19 May 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672826; cv=none; b=Yz+ynMl//dB92YVpIxaMICk2dr9kH39oHKMiA807ze/+G55mL3uA+a15zXZOZMuIKDGcdUFwQathcqvxOkVJeDPDalSC98bLwuDoC0XvnwlKtLDiXq/weiYw6XTdUQSVOZTpTiCZt1YT5IGEtOgXXNJDrXzdwQK01l9mxxpy5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672826; c=relaxed/simple;
	bh=8AekMnk7LJZuUtqQ1X0wseXmvLHDUBX7h+wM+z7I/ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj4Wb3Zig6JgUqcUCK16FpotF1FfTrhJkVsU4IWb9KnA0JYbP/K0xpSGdXTButMUwop+EaarK3OOwhZlPhpoW9BhpfVpoznPwLh+MvxZlvnwEdIR25+4i/QJHrZoDrCR10qOK71/vFSeDOpztAoDjEOUjUmtMEDgEYtZSkdeLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCNnrMTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9354BC4CEE4;
	Mon, 19 May 2025 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747672825;
	bh=8AekMnk7LJZuUtqQ1X0wseXmvLHDUBX7h+wM+z7I/ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCNnrMTOytetYBMrRAwp1W0dzqcMOnVDJ1J2TaqS1eTxFEMoUWCMFlYu7VgKjQWqr
	 t1kqRsaYadf6EaoZq+UF2KwCuhAmcj3tdwk3qi7aV70zYrIXSfZX3s9rPFffWLQcIR
	 9n+M8Bn3W+Wm70mH//h3UqRlaxqsXbDf2e3qIVCa8l031H1iST9bxPMyMObW+CUjrO
	 MDriWmWr0Z9+sQ1niXPjBx/fwpPbDoA508vyKK2YRd3JhkxksDXXko2Q57rtKzBcRe
	 035934n5qtj+C/0H1v/iJqTVwib7zy+0owU9tyvR27vEtWd8k2foPf2zETy0LB7mk6
	 LoGj7Lli8jq5w==
Date: Mon, 19 May 2025 17:40:21 +0100
From: Simon Horman <horms@kernel.org>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: Re: [PATCH net-next v2] net: phy: add driver for MaxLinear MxL86110
 PHY
Message-ID: <20250519164021.GL365796@horms.kernel.org>
References: <20250516164126.234883-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516164126.234883-1-stefano.radaelli21@gmail.com>

On Fri, May 16, 2025 at 06:41:23PM +0200, Stefano Radaelli wrote:
> Add support for the MaxLinear MxL86110 Gigabit Ethernet PHY, a low-power,
> cost-optimized transceiver supporting 10/100/1000 Mbps over twisted-pair
> copper, compliant with IEEE 802.3.
> 
> The driver implements basic features such as:
> - Device initialization
> - RGMII interface timing configuration
> - Wake-on-LAN support
> - LED initialization and control via /sys/class/leds
> 
> This driver has been tested on multiple Variscite boards, including:
> - VAR-SOM-MX93 (i.MX93)
> - VAR-SOM-MX8M-PLUS (i.MX8MP)
> 
> Example boot log showing driver probe:
> [    7.692101] imx-dwmac 428a0000.ethernet eth0:
>         PHY [stmmac-0:00] driver [MXL86110 Gigabit Ethernet] (irq=POLL)
> 
> Changes from v1:
> - Add net-next support
> - Improved locking management and tests using CONFIG_PROVE_LOCKING
> - General cleanup
> 
> Started a new thread
> 
> Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>

Hi Stefano,

Some minor feedback from my side.

...

> diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
> new file mode 100644
> index 000000000000..63f32c49fcc1
> --- /dev/null
> +++ b/drivers/net/phy/mxl-86110.c
> @@ -0,0 +1,570 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PHY driver for Maxlinear MXL86110
> + *
> + * Copyright 2023 MaxLinear Inc.
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/etherdevice.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy.h>
> +
> +/* PHY ID */
> +#define PHY_ID_MXL86110		0xc1335580
> +
> +/* required to access extended registers */
> +#define MXL86110_EXTD_REG_ADDR_OFFSET	0x1E
> +#define MXL86110_EXTD_REG_ADDR_DATA		0x1F
> +#define PHY_IRQ_ENABLE_REG				0x12
> +#define PHY_IRQ_ENABLE_REG_WOL			BIT(6)
> +
> +/* SyncE Configuration Register - COM_EXT SYNCE_CFG */
> +#define MXL86110_EXT_SYNCE_CFG_REG						0xA012

For Networking code, please restrict lines to no more than 80 columns
wide where you can do so without reducing readability (I'd say that is the
case here.

Likewise elsewhere in this patch.

checkpatch.pl --max-line-length=80 can be helpful here.

...

> +/**
> + * mxl86110_write_extended_reg() - write to a PHY's extended register
> + * @phydev: pointer to a &struct phy_device
> + * @regnum: register number to write
> + * @val: value to write to @regnum
> + *
> + * NOTE: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * returns 0 or negative error code
> + */

Tooling expects 'Return:' or 'Returns: ' to document return values.

Likewise elsewhere in this patch.

Flagged by ./scripts/kernel-doc -Wall -none

...

> +static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				       unsigned long *rules)
> +{
> +	u16 val;
> +
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	phy_lock_mdio_bus(phydev);
> +	val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
> +	phy_unlock_mdio_bus(phydev);
> +	if (val < 0)
> +		return val;

val is unsigned. It cannot be less than zero.

Likewise in mxl86110_broadcast_cfg() and mxl86110_enable_led_activity_blink().

Flagged by Smatch.

...

