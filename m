Return-Path: <netdev+bounces-234136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E914C1D00C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0029400359
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C48358D0B;
	Wed, 29 Oct 2025 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="er6dy6F0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EACB2E5B1D;
	Wed, 29 Oct 2025 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766151; cv=none; b=lJSpHTANw5A0zRwJBEL5asU/PhpJ6pSs9zGgloEzkZid1YbSxFRbMo6CVVQbGTSrYsBnNoF4v+7k/aUZLKaDaJCNM9y7JS6HuoZA3+CDYQWRHEp15mKwsfa8ArvTkoRHBFakp1+7gXFjw4iPWuD/HCCDiJxYGslu4l5S3juQqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766151; c=relaxed/simple;
	bh=cn6+LSWhqCb3Iyby4JKZcVRtc6O/oEK/B7/tN5XpHJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unEN11CpVyXUSq3vOXeYfbTp1Yjcd8ojF8TRGX/X3wRQHjVe5GZJj7Qn1CZMfMNx7LLpTT28Iu2TTGJgucLf82dgSubsVjLZmVOTsK11ZbX6QjO4N+qvaSJ0vqnA5HhXA7SX/tuKb/jZbX/+Hja7JIZ2oSl0DtN5fVgXNozhGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=er6dy6F0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C746E1A1748;
	Wed, 29 Oct 2025 19:29:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 89565606E8;
	Wed, 29 Oct 2025 19:29:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7CC4117FD242;
	Wed, 29 Oct 2025 20:28:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761766144; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ScvcTy8ozlqmT8s8gsLtsWpW/tRbjYKzmG+MWRwqsow=;
	b=er6dy6F0AkewbZOEtLIUH1uP7pet6Cc/msERkGQj89coxq5gPxp79ydF7hrtmMaQwPae2e
	uKdCy801xdNppwVzk/dnqIlmlEooSk/olx+i977JcRUAOAZsVebEvZLagVUJ0GR5gFCoYj
	1wG5ZcCJvB5MbkqzdG+DEVfkE9enbz3rcHSu3T8DRrGQ5IEFBbaXpBi2/WIWrY/8uFjC58
	uDQ6O6z2aTI7krrSv6/9WHoGrx8Gg1HrDd7uxWjdQuLgdxX5Gm0kERnj+x6t7h14gCgG5w
	xU5A0dKajRosGpPsX+Autsu+EYwon2yf2lb9QOA6VLsOi9U/q565lvcFW9s9fQ==
Message-ID: <45ebd2eb-9b09-43fa-a451-29299b33f06a@bootlin.com>
Date: Wed, 29 Oct 2025 20:28:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] net: phy: Add helper for fixing RGMII PHY mode
 based on internal mac delay
To: Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>,
 Icenowy Zheng <uwu@icenowy.me>, Vivian Wang <wangruikang@iscas.ac.cn>,
 Yao Zi <ziyao@disroot.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20251028003858.267040-1-inochiama@gmail.com>
 <20251028003858.267040-3-inochiama@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251028003858.267040-3-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 28/10/2025 01:38, Inochi Amaoto wrote:
> The "phy-mode" property of devicetree indicates whether the PCB has
> delay now, which means the mac needs to modify the PHY mode based
> on whether there is an internal delay in the mac.
> 
> This modification is similar for many ethernet drivers. To simplify
> code, define the helper phy_fix_phy_mode_for_mac_delays(speed, mac_txid,
> mac_rxid) to fix PHY mode based on whether mac adds internal delay.
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Name may be a bit long, but I'm not the best at naming stuff :)

I agree with the logic of that helper,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/phy/phy-core.c | 43 ++++++++++++++++++++++++++++++++++++++
>  include/linux/phy.h        |  3 +++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
> index 605ca20ae192..4f258fb409da 100644
> --- a/drivers/net/phy/phy-core.c
> +++ b/drivers/net/phy/phy-core.c
> @@ -101,6 +101,49 @@ const char *phy_rate_matching_to_str(int rate_matching)
>  }
>  EXPORT_SYMBOL_GPL(phy_rate_matching_to_str);
>  
> +/**
> + * phy_fix_phy_mode_for_mac_delays - Convenience function for fixing PHY
> + * mode based on whether mac adds internal delay
> + *
> + * @interface: The current interface mode of the port
> + * @mac_txid: True if the mac adds internal tx delay
> + * @mac_rxid: True if the mac adds internal rx delay
> + *
> + * Return fixed PHY mode, or PHY_INTERFACE_MODE_NA if the interface can
> + * not apply the internal delay
> + */
> +phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
> +						bool mac_txid, bool mac_rxid)
> +{
> +	if (!phy_interface_mode_is_rgmii(interface))
> +		return interface;
> +
> +	if (mac_txid && mac_rxid) {
> +		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
> +			return PHY_INTERFACE_MODE_RGMII;
> +		return PHY_INTERFACE_MODE_NA;
> +	}
> +
> +	if (mac_txid) {
> +		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
> +			return PHY_INTERFACE_MODE_RGMII_RXID;
> +		if (interface == PHY_INTERFACE_MODE_RGMII_TXID)
> +			return PHY_INTERFACE_MODE_RGMII;
> +		return PHY_INTERFACE_MODE_NA;
> +	}
> +
> +	if (mac_rxid) {
> +		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
> +			return PHY_INTERFACE_MODE_RGMII_TXID;
> +		if (interface == PHY_INTERFACE_MODE_RGMII_RXID)
> +			return PHY_INTERFACE_MODE_RGMII;
> +		return PHY_INTERFACE_MODE_NA;
> +	}
> +
> +	return interface;
> +}
> +EXPORT_SYMBOL_GPL(phy_fix_phy_mode_for_mac_delays);
> +
>  /**
>   * phy_interface_num_ports - Return the number of links that can be carried by
>   *			     a given MAC-PHY physical link. Returns 0 if this is
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3c7634482356..0bc00a4cceb2 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1813,6 +1813,9 @@ static inline bool phy_is_pseudo_fixed_link(struct phy_device *phydev)
>  	return phydev->is_pseudo_fixed_link;
>  }
>  
> +phy_interface_t phy_fix_phy_mode_for_mac_delays(phy_interface_t interface,
> +						bool mac_txid, bool mac_rxid);
> +
>  int phy_save_page(struct phy_device *phydev);
>  int phy_select_page(struct phy_device *phydev, int page);
>  int phy_restore_page(struct phy_device *phydev, int oldpage, int ret);


