Return-Path: <netdev+bounces-113431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5593F93E3F0
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81911F21958
	for <lists+netdev@lfdr.de>; Sun, 28 Jul 2024 07:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C4B665;
	Sun, 28 Jul 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts2ZuPXp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2E2F28;
	Sun, 28 Jul 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722152170; cv=none; b=samLuKY07BmqyH5f5AZYOpyA/w/BoEiprdEJg85Fr/X45eWxwkHTWwGHbznpure7T7RPMlP5BrdgwFa4tOsg+JK432RE+ATwMAH5qqU7csjDHDojTXnK/rd52hRXwkxpE7Q7D06YX9dSAGNF7GDX66Eq7Bs1GaiTttCAWHeJ8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722152170; c=relaxed/simple;
	bh=mezLq94yiIGydGI/R4ADQ45+zD7di9Kk9mVKoDn9tPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F58qDHnvEQfrJFv+UEh2iiipj4pi2uxK3AOO6EcyidogOMZ2UZHBHDuAYozE/wtQE9azP1gT8QxLvjOesOwWGvkLtVwAu9MXnPewmXnulYv4BmYA7VYcgOJs6/scushv6Ixu+2eofoZtFGOpvFN/m87OwsQ9cyjSJm/NclDeQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts2ZuPXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924D1C116B1;
	Sun, 28 Jul 2024 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722152169;
	bh=mezLq94yiIGydGI/R4ADQ45+zD7di9Kk9mVKoDn9tPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ts2ZuPXpqLTwm34zq+xkgNdk+eDJfR+NTo58ryYw/rAH87a5Xs63fK7uNYAuQ+f4l
	 +EdBbuQmlLeNACcgLnP1sL0EwzYcAq0/fuzzQty+5RoKB7f4binVt1a0wKZpGGmw7w
	 ur6/ipyO9xK9ckidNYrCtuaY+xieKDsHIYhgVeJpZZuHyj2v0mF0ihlSHEjqcEuKzF
	 tQSYxkhLzmaSkxkieK4/gQMKUA5whJm6HaR1k0cLN6idXipj6PM9Y/nFKLHhUm5jm4
	 eCusO3OFnu4OtSw9NgNVmAu7ro79kcTtDU+oHZM8y/SIhP9MmIVOw3dJku6dhIAdhj
	 +fOGOGCwX0tUg==
Date: Sun, 28 Jul 2024 08:36:01 +0100
From: Simon Horman <horms@kernel.org>
To: "Frank.Sae" <Frank.Sae@motor-comm.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH 2/2] net: phy: Add driver for Motorcomm yt8821 2.5G
 ethernet phy
Message-ID: <20240728073601.GD1625564@kernel.org>
References: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727092031.1108690-1-Frank.Sae@motor-comm.com>

On Sat, Jul 27, 2024 at 02:20:31AM -0700, Frank.Sae wrote:
>  Add a driver for the motorcomm yt8821 2.5G ethernet phy.
>  Verified the driver on
>  BPI-R3(with MediaTek MT7986(Filogic 830) SoC) development board,
>  which is developed by Guangdong Bipai Technology Co., Ltd..
>  On the board, yt8821 2.5G ethernet phy works in
>  AUTO_BX2500_SGMII or FORCE_BX2500 interface,
>  supports 2.5G/1000M/100M/10M speeds, and wol(magic package).
>  Since some functions of yt8821 are similar to YT8521
>  so some functions for yt8821 can be reused.
> 
> Signed-off-by: Frank.Sae <Frank.Sae@motor-comm.com>

Hi Frank,

This is not a full review. And setting up expectations,
as per the form letter below, net-next is currently closed.
But nonetheless I've provided some minor review below.

## Form letter - net-next-closed

(Adapted from text by Jakub)

The merge window for v6.11 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after 29th July.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

pw-bot: defer

> ---
>  drivers/net/phy/motorcomm.c | 639 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 636 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c

...

> +/**
> + * yt8821_probe() - read dts to get chip mode
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * returns 0 or negative errno code
> + */

nit: please document return values using a "Return:" or "Returns:" section.

Flagged by W=1 allmodconfig builds and ./scripts/kernel-doc -none -Warn

...

> +/**
> + * yt8821_config_init() - phy initializatioin
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * returns 0 or negative errno code
> + */
> +static int yt8821_config_init(struct phy_device *phydev)
> +{
> +	struct yt8821_priv *priv = phydev->priv;
> +	int ret, val;
> +
> +	phydev->irq = PHY_POLL;
> +
> +	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);

val is set here but otherwise unused.
Should val be checked for an error here?

Flagged by W=1 builds.

> +	if (priv->chip_mode == YT8821_CHIP_MODE_AUTO_BX2500_SGMII) {
> +		ret = ytphy_modify_ext_with_lock(phydev,
> +						 YT8521_CHIP_CONFIG_REG,
> +						 YT8521_CCR_MODE_SEL_MASK,
> +						 FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, 0));
> +		if (ret < 0)
> +			return ret;
> +
> +		__assign_bit(PHY_INTERFACE_MODE_2500BASEX,
> +			     phydev->possible_interfaces,
> +			     true);
> +		__assign_bit(PHY_INTERFACE_MODE_SGMII,
> +			     phydev->possible_interfaces,
> +			     true);
> +
> +		phydev->rate_matching = RATE_MATCH_NONE;
> +	} else if (priv->chip_mode == YT8821_CHIP_MODE_FORCE_BX2500) {
> +		ret = ytphy_modify_ext_with_lock(phydev,
> +						 YT8521_CHIP_CONFIG_REG,
> +						 YT8521_CCR_MODE_SEL_MASK,
> +						 FIELD_PREP(YT8521_CCR_MODE_SEL_MASK, 1));
> +		if (ret < 0)
> +			return ret;
> +
> +		phydev->rate_matching = RATE_MATCH_PAUSE;
> +	}
> +
> +	ret = yt8821gen_init(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* disable auto sleep */
> +	ret = yt8821_auto_sleep_config(phydev, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* soft reset */
> +	yt8821_soft_reset(phydev);
> +
> +	return ret;
> +}
> +
> +/**
> + * yt8821_adjust_status() - update speed and duplex to phydev
> + * @phydev: a pointer to a &struct phy_device
> + * @val: read from YTPHY_SPECIFIC_STATUS_REG
> + */
> +static void yt8821_adjust_status(struct phy_device *phydev, int val)
> +{
> +	int speed_mode, duplex;
> +	int speed_mode_low, speed_mode_high;
> +	int speed = SPEED_UNKNOWN;

nit: Please consider arranging local variables in reverse xmas tree order -
     longest line to shortest.

     This can be helpful: https://github.com/ecree-solarflare/xmastree

> +
> +	duplex = FIELD_GET(YTPHY_SSR_DUPLEX, val);
> +
> +	speed_mode_low = FIELD_GET(GENMASK(15, 14), val);
> +	speed_mode_high = FIELD_GET(BIT(9), val);
> +	speed_mode = FIELD_PREP(BIT(2), speed_mode_high) |
> +			FIELD_PREP(GENMASK(1, 0), speed_mode_low);
> +	switch (speed_mode) {
> +	case YTPHY_SSR_SPEED_10M:
> +		speed = SPEED_10;
> +		break;
> +	case YTPHY_SSR_SPEED_100M:
> +		speed = SPEED_100;
> +		break;
> +	case YTPHY_SSR_SPEED_1000M:
> +		speed = SPEED_1000;
> +		break;
> +	case YT8821_SSR_SPEED_2500M:
> +		speed = SPEED_2500;
> +		break;
> +	default:
> +		speed = SPEED_UNKNOWN;
> +		break;
> +	}
> +
> +	phydev->speed = speed;
> +	phydev->duplex = duplex;
> +}

...

