Return-Path: <netdev+bounces-209206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D4B0EA16
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89747546B5C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 05:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC832203710;
	Wed, 23 Jul 2025 05:34:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841B523A
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753248867; cv=none; b=Pf8+GkykiXua8VwYCCx23eKWoC09HN0u0TmyRAv+YxHbrrpCjXWbQzY72pNYD4OLIoKSbxv09ZJQqEN4UoYPB/+IztLDpEzxwbw+Ihf/wAY8117xpyTO7YepWD7u97xjhddUhxHh2+mDntLADnlj2bbWj/F7wr5CpxIPetgugHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753248867; c=relaxed/simple;
	bh=bTCn5TRl5J08PooK6OE8P7xNUFYo706S2swsxGwP45M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGPY/5MCZ7Jg1bRB3QYaFS3kjI/Rw/vi+vvFMRoDbo/3+cE0zni0tqKEKYDiF1MyLnXzdjgVw/B4FzUWf+uNmu5Pua33cbg6SK9H/65WpMvxZQZF6wCsXrtYCpVWpBLBBI8zrMd9EmCKdDp/rj0/gu7KycGmccbBQUx8d9FxG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ueS7L-0000ta-9F; Wed, 23 Jul 2025 07:34:15 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ueS7K-009q16-03;
	Wed, 23 Jul 2025 07:34:14 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ueS7J-0010b6-2w;
	Wed, 23 Jul 2025 07:34:13 +0200
Date: Wed, 23 Jul 2025 07:34:13 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan8842
Message-ID: <aIB0VYLqcBKVtAmU@pengutronix.de>
References: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Horatiu,

On Mon, Jul 21, 2025 at 09:14:05AM +0200, Horatiu Vultur wrote:

> +static int lan8842_config_init(struct phy_device *phydev)
> +{
> +	int val;
> +	int ret;
> +
> +	/* Reset the PHY */
> +	val = lanphy_read_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET);

It would be good to use defines for MMD pages.

> +	if (val < 0)
> +		return val;
> +	val |= LAN8814_QSGMII_SOFT_RESET_BIT;
> +	lanphy_write_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET, val);

Please, do not ignore return values.

> +
> +	/* Disable ANEG with QSGMII PCS Host side
> +	 * It has the same address as lan8814
> +	 */
> +	val = lanphy_read_page_reg(phydev, 5, LAN8814_QSGMII_PCS1G_ANEG_CONFIG);
> +	if (val < 0)
> +		return val;
> +	val &= ~LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA;
> +	ret = lanphy_write_page_reg(phydev, 5, LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
> +				    val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Disable also the SGMII_AUTO_ANEG_ENA, this will determine what is the
> +	 * PHY autoneg with the other end and then will update the host side
> +	 */
> +	lanphy_write_page_reg(phydev, 4, LAN8842_SGMII_AUTO_ANEG_ENA, 0);
> +
> +	/* To allow the PHY to control the LEDs the GPIOs of the PHY should have
> +	 * a function mode and not the GPIO. Apparently by default the value is
> +	 * GPIO and not function even though the datasheet it says that it is
> +	 * function. Therefore set this value.
> +	 */
> +	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN2, 0);
> +
> +	/* Enable the Fast link failure, at the top level, at the bottom level
> +	 * it would be set/cleared inside lan8842_config_intr
> +	 */
> +	val = lanphy_read_page_reg(phydev, 0, LAN8842_FLF);
> +	if (val < 0)
> +		return val;
> +	val |= LAN8842_FLF_ENA | LAN8842_FLF_ENA_LINK_DOWN;

If I see it correctly, FLF support will make link fail after ~1ms, while
IEEE 802.3 recommends 750ms. Since a link recovery of a PHY with autoneg
support usually takes multiple seconds, I see the benefit for FLF
support only mostly for SyncE environment at same time it seems to be
a disadvantage for other environments.

I would prefer to have IEEE 802.3 recommended link behavior by default
and have separate Netlink configuration interface for FLF.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

