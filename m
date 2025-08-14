Return-Path: <netdev+bounces-213640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A066B260C7
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997423A776A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4A32BE7D7;
	Thu, 14 Aug 2025 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Mp4xZ9hC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C01386DA;
	Thu, 14 Aug 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163282; cv=none; b=olEfEWWhkQkqcMSxrKwF8mZiD1dCNfkooo+XgdxecuzubNcIwqbC722JBqAvnCbZd9h7nc3Fs2sRAI49knzQJfDidYd6LBiWKr1ZDLdqtkH/YbKWt8Z6UVPe2T5mYEXdrE1cGaGjyHOtdeK3vXxvLp1dfF69hwkvVISQnjfu1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163282; c=relaxed/simple;
	bh=3R/dw5qXrowktSVbYlTOFK7sFkw0VRlAOMsLKRQfRTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy0itsvaDqMWTQ7lt1rxUFep2is36k90lQ6SthD4tNhhAQuFl4muNPK+ssGALVQJ6/DgZWlpAqx0nqJw1ToYMSfHgV1zWm4RjErBaJk8f1YQMtrfrOfeV1gnVj+cMi6xvpvndIUSQ1lZbCZHI3g28Lx16PvwPYfSkyv7Ag7hK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Mp4xZ9hC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RXx3VV9QSti0W/X0YcFsojFSs5JTTfqLIZwLDuOeptw=; b=Mp4xZ9hCOBN1hIMFTXTnDLKopm
	tDTBVKxMZSzIKkXstvfEF2hu4JjNUzGZmjEjOrVvqnGNDWiZKOqXXjVZSNfv4HQ7R3wm35LEcVMvE
	Lft2Pm9es/zq07vvIUoM0xJTXMv3mJ5b2RcOi5xPnhVSgfwJU9COIxD6LV/JJoZM8qUU5aY93wsKg
	DK+IKbDqlAsFm5SM9wp6nPAJ7bQljeamgaONX2Ez166CPFV8nz7FQrw1dIrztVt5VFe5ZzSbvli0m
	D8lo0kAOLrmm0DehFiX4adNiLvIIyesb1WewTLMu3kAHSZLevkq33JdkvKU7zCyo/pz71bSdjD5LP
	Ji60zHfQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58024)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1umU8s-00082z-1X;
	Thu, 14 Aug 2025 10:21:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1umU8l-0006gx-31;
	Thu, 14 Aug 2025 10:20:55 +0100
Date: Thu, 14 Aug 2025 10:20:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, o.rempel@pengutronix.de,
	alok.a.tiwari@oracle.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] net: phy: micrel: Add support for lan8842
Message-ID: <aJ2qd9SkUPg5tmYL@shell.armlinux.org.uk>
References: <20250814082624.696952-1-horatiu.vultur@microchip.com>
 <20250814082624.696952-5-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814082624.696952-5-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 14, 2025 at 10:26:24AM +0200, Horatiu Vultur wrote:
> +static int lan8842_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* Reset the PHY */
> +	ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> +				     LAN8814_QSGMII_SOFT_RESET,
> +				     LAN8814_QSGMII_SOFT_RESET_BIT,
> +				     LAN8814_QSGMII_SOFT_RESET_BIT);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Disable ANEG with QSGMII PCS Host side
> +	 * It has the same address as lan8814
> +	 */
> +	ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
> +				     LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
> +				     LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
> +				     0);
> +	if (ret < 0)
> +		return ret;

Could you explain exactly what effect this has please?

> +
> +	/* Disable also the SGMII_AUTO_ANEG_ENA, this will determine what is the
> +	 * PHY autoneg with the other end and then will update the host side
> +	 */
> +	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> +				    LAN8842_SGMII_AUTO_ANEG_ENA, 0);
> +	if (ret < 0)
> +		return ret;

Also please explain this a bit more.

If this changes whether host-side "negotiation" is used, then please
consider implementing the two phy driver inbnad operations as well.

> +static u64 lan8842_get_stat(struct phy_device *phydev, int count, int *regs)
> +{
> +	int val;
i> +	u64 ret = 0;

Please remember... reverse Christmas tree for variable declarations.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

