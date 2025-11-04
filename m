Return-Path: <netdev+bounces-235400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E4C2FEBC
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 09:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAED04E21A9
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48730498F;
	Tue,  4 Nov 2025 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DCd+FqUx"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466C236435
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245288; cv=none; b=ZojTUhweq76btjHj1w5T1Noy1A2i/fe4vVuRgHeNhoL2nyY4/fq/tuLaEFEp//8fKHeA8USIPg0YeXvW+HaD0W1AfDvDcoNGIBIKhQErsvE5IIZ+d4KUwLzSHNM/A8PX6If0iWrRN0l10Tw4GizEpirMiXpmwS2XfgFhzbIXv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245288; c=relaxed/simple;
	bh=CHxw+7FmZsoqysMXyJbR5lHvF2gHjVBt5q7NIDGlf+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZLKVOnkHHbi0CXH8+PLqD2hu/63eInzik3gI9O/Mdp8J8BUlwmzBkxKxFO/barMworbNz/X/6A/rw47QQpza6DhHtE5m5np1ZIAkhaDlgybKRrWL+4eM0U7q3lY8rv7s/hdo2JBmi/t+ltvlojCLaqQuTmjiWZgSStYa/Mcl/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DCd+FqUx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 33E361A184C;
	Tue,  4 Nov 2025 08:34:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 046FE606EF;
	Tue,  4 Nov 2025 08:34:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94FB810B50919;
	Tue,  4 Nov 2025 09:34:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762245281; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=R2k3S0JM3GjzlqSiHtx7uGU4oJqackuOaOdMcXWCQD4=;
	b=DCd+FqUxRxIK4KCVyBl2bY1jDIpBnI7OcnY2/p/8CRdl0Idsdm5miT0nvhZL9+PvxW/5g4
	uhT2R3FGkTAnueao/HshktnCuxoAsYmnJz/QIr9rsKpKRWHbD/9lwGb3brlyQyb7aNQJSt
	6YMA05A4UmvBNktmLqQJKBPdxwrZrGQRtExXpstbIvUBv96Huj5Myjkdm3+opAabia8Uf7
	q6GlH55zcK9qoVuUD50tEindxjboWWp7lMVIRDUeZrHEX3xj2vL8O0eLvOCV/rqiffM6KU
	jPOeZdZ6P2OK58ZUes2loyO+XbaQ4HDYIsO8PfB7/dVQd0zJE+R1XEGXcKBQJw==
Message-ID: <db01f926-d5bb-4317-beac-e6dcc0025a80@bootlin.com>
Date: Tue, 4 Nov 2025 09:34:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/11] net: stmmac: add stmmac_get_phy_intf_sel()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Jan Petrous <jan.petrous@oss.nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
 <E1vFt4c-0000000Choe-3SII@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vFt4c-0000000Choe-3SII@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 03/11/2025 12:50, Russell King (Oracle) wrote:
> Provide a function to translate the PHY interface mode to the
> phy_intf_sel pin configuration for dwmac1000 and dwmac4 cores that
> support multiple interfaces. We currently handle MII, GMII, RGMII,
> SGMII, RMII and REVMII, but not TBI, RTBI nor SMII as drivers do not
> appear to use these three and the driver doesn't currently support
> these.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

First, thanks for this work !

[...]

> +int stmmac_get_phy_intf_sel(phy_interface_t interface)
> +{
> +	int phy_intf_sel = -EINVAL;
> +
> +	if (interface == PHY_INTERFACE_MODE_MII ||
> +	    interface == PHY_INTERFACE_MODE_GMII)
> +		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
> +	else if (phy_interface_mode_is_rgmii(interface))
> +		phy_intf_sel = PHY_INTF_SEL_RGMII;
> +	else if (interface == PHY_INTERFACE_MODE_SGMII)
> +		phy_intf_sel = PHY_INTF_SEL_SGMII;
> +	else if (interface == PHY_INTERFACE_MODE_RMII)
> +		phy_intf_sel = PHY_INTF_SEL_RMII;
> +	else if (interface == PHY_INTERFACE_MODE_REVMII)
> +		phy_intf_sel = PHY_INTF_SEL_REVMII;
> +
> +	return phy_intf_sel;
> +}
> +EXPORT_SYMBOL_GPL(stmmac_get_phy_intf_sel);

Nothng wrong with your code, this is out of curiosity.

I'm wondering how we are going to support cases like socfpga (and
probably some other) where the PHY_INTF_SEL_xxx doesn't directly
translate to the phy_interface, i.e.  when you have a PCS or other
IP that serialises the MAC interface ?

for socfpga for example, we need to set the PHY_INTF_SEL to GMII_MII
when we want to use SGMII / 1000BaseX, but we do set it to RGMII when
we need to output RGMII.

Do you have a plan in mind for that ? (maybe a .get_phy_intf_sel() ops ?)

Maxime

