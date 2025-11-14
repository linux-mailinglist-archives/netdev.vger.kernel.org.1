Return-Path: <netdev+bounces-238631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F5C5C460
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 228E235B522
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B299E306B08;
	Fri, 14 Nov 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W2smP7M0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F29302156
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112076; cv=none; b=tul1H8NlH0EA65/9beZYKtN8eG5yUOQ9lEqcsw8ft1kslU27L2YRltUQcP71D5tPCVzg37vljgeRekissYM25EotE1qqN1sAjkfiBVrPa/vLL5DmvuVrsuio9ZVVOqjgrSx53q2HpwXiResrMtsrB+UZW2wrHoie3bLIE4jrjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112076; c=relaxed/simple;
	bh=mUVik74o9jy+8Y+xA2s4xcAcG+16S7SVvZa5x7wl+kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXKwvOUOj5p6ODqg7+O7ZsjQ22h5Ux8c89U2L/cOdCo9Y/HpSRSvo5KsbnPu90W4zizG/CCFK1jrvpRmVccvMbgfEteHMSSjU37lFO29MVyzJv/fNM7Q7TNefCv5OeFmGXuUQDBsHVgrmQ1cBd7V/EWxloioV1mJiO3YODtKGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W2smP7M0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B18C94E416AC;
	Fri, 14 Nov 2025 09:21:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F89B6060E;
	Fri, 14 Nov 2025 09:21:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F798102F2ACF;
	Fri, 14 Nov 2025 10:21:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763112070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=OpP97fd3BfIXkj52BbkyHJbWoxC/AryyR4JJSZrRQHU=;
	b=W2smP7M0kJSFcpchTgBqXwcgQZQ1JGNVh5Ft11FqLX6O/ZrFRxVj7hgVemqSaymfKF0SJV
	iii2JauaxgiQ2bN4sS5uve31/xdyvtMRtGFzoIgfghGGN0oNpgHrZpqx2Niw9D/WCDZPe2
	SoBhGNTZs7UPvcDG+GyqZYX03q58RGtcButBvR7CSCmzkzbCJbYiH6tUiyD9ueLbitofVP
	mIrLVTfXXOZRYHIbHB2RCtGNd+cgKmdOtqzXFja70vXsXERxlIFTCG5YotJljZozA5d4ka
	4LX78U4Q9IVG9ZtwJX9z0uMXeyuEKynuxGLib8Vxz9sEgSbm2Zt8kgOmRxCCGg==
Message-ID: <b74e7d46-630a-412b-a92c-374d1495758b@bootlin.com>
Date: Fri, 14 Nov 2025 10:21:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: micrel: lan8814: Enable in-band
 auto-negotiation
To: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251114084224.3268928-1-horatiu.vultur@microchip.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251114084224.3268928-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Horatiu,

On 14/11/2025 09:42, Horatiu Vultur wrote:
> The lan8814 supports two interfaces towards the host (QSGMII and QUSGMII).
> Currently the lan8814 disables the auto-negotiation towards the host
> side. So, extend this to allow to configure to use in-band
> auto-negotiation.
> I have tested this only with the QSGMII interface.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/micrel.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 57ea947369fed..5d90ccc20df75 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -2988,6 +2988,8 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
>  #define LAN_EXT_PAGE_ACCESS_ADDRESS_DATA		0x17
>  #define LAN_EXT_PAGE_ACCESS_CTRL_EP_FUNC		0x4000
>  
> +#define LAN8814_QSGMII_TX_CONFIG			0x35
> +#define LAN8814_QSGMII_TX_CONFIG_QSGMII			BIT(3)
>  #define LAN8814_QSGMII_SOFT_RESET			0x43
>  #define LAN8814_QSGMII_SOFT_RESET_BIT			BIT(0)
>  #define LAN8814_QSGMII_PCS1G_ANEG_CONFIG		0x13
> @@ -4501,12 +4503,24 @@ static void lan8814_setup_led(struct phy_device *phydev, int val)
>  static int lan8814_config_init(struct phy_device *phydev)
>  {
>  	struct kszphy_priv *lan8814 = phydev->priv;
> +	int ret;
>  
> -	/* Disable ANEG with QSGMII PCS Host side */
> -	lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
> -			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
> -			       LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
> -			       0);
> +	/* Based on the interface type select how the advertise ability is
> +	 * encoded, to set as SGMII or as USGMII.
> +	 */
> +	if (phydev->interface == PHY_INTERFACE_MODE_QSGMII)
> +		ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> +					     LAN8814_QSGMII_TX_CONFIG,
> +					     LAN8814_QSGMII_TX_CONFIG_QSGMII,
> +					     LAN8814_QSGMII_TX_CONFIG_QSGMII);
> +	else
> +		ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> +					     LAN8814_QSGMII_TX_CONFIG,
> +					     LAN8814_QSGMII_TX_CONFIG_QSGMII,
> +					     0);
> +
> +	if (ret < 0)
> +		return ret;
>  
>  	/* MDI-X setting for swap A,B transmit */
>  	lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS_DIGITAL, LAN8814_ALIGN_SWAP,
> @@ -6640,6 +6654,8 @@ static struct phy_driver ksphy_driver[] = {
>  	.suspend	= genphy_suspend,
>  	.resume		= kszphy_resume,
>  	.config_intr	= lan8814_config_intr,
> +	.inband_caps	= lan8842_inband_caps,
> +	.config_inband	= lan8842_config_inband,
>  	.handle_interrupt = lan8814_handle_interrupt,
>  	.cable_test_start	= lan8814_cable_test_start,
>  	.cable_test_get_status	= ksz886x_cable_test_get_status,


