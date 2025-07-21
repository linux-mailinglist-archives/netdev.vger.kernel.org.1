Return-Path: <netdev+bounces-208567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4037AB0C2ED
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E8417B2D7
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B372BCF7C;
	Mon, 21 Jul 2025 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0Dw7LcU4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF829C33C;
	Mon, 21 Jul 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097328; cv=none; b=FN8nlD6Q3uawVAGo3jdR6w3VPFfbNpsTFWV3otnnM5TxqJZEtzk5z8It08yB9o9cuWWZHAA7LAE329nX4nVEs7cJO+O8SqFf8j7gbLZ4VymmPWUHH2H6shaG3oHOO2CyLoaaM3yFth9nWGO8BClwMQr2NDQ0LdXLi05nFFJio44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097328; c=relaxed/simple;
	bh=nKdbUHhSgD5kKZl45LHZlOiMAaqDIMPyH0N+o9UxqQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ/7vHX+5zPirnbvHiivxV/7f1UPlzWRdpYZ3yO8o0ec0t90f2pSqLpVlg4CRd5MvCWkp56G2m2F+Z3IMlogn2MGXsV51JCp5PCNFAiAH5LXT/jtMtKOYFT/GuaUiBKDpuROnWLyPIZJhcz73We3tFu89eGbEuKHLY+jTb8JL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0Dw7LcU4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0ZUgBqx92qBG7YxcgchOSk9zrFJ4dI1nB3VhodBS568=; b=0Dw7LcU4IbmDlG8F3HK/dH3mNC
	kmeTh2bcWVTzXjyJVMqXg3wQ76dFrx/HO3L7pLaA2sJKblmKg0f4P7Bxnp3HSv3Usb8hLtY4eXo9R
	04yA3YHQoqwdYfT4R8gseeR8PYNpoGtiRwDVB0fo5QDED4IGKQz6lgqGAdrzVTGq7VWBgP2hFrvK+
	3leX5BI1MRCdfce+CLH6smel8QBOLGKhFRa9Vz2800x6OP7S0lGSN0qDyRptpSi+v22YP2dO2w3ga
	uix/Z+iEhNHoA7BzmNAiRbuLDeUrmWV7Po1TtNtdNqMAFOjsEJg8Hu5TD6892xi9HOn2CTtaNqBeQ
	c6L+ElgA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51126)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1udoh1-0006cW-0F;
	Mon, 21 Jul 2025 12:28:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1udogu-00067a-2M;
	Mon, 21 Jul 2025 12:28:20 +0100
Date: Mon, 21 Jul 2025 12:28:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: smsc: fix and improve WoL support
Message-ID: <aH4kVBTxd4zRYv2l@shell.armlinux.org.uk>
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-3-89d262812dba@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-wol-smsc-phy-v1-3-89d262812dba@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jul 21, 2025 at 01:14:45PM +0200, Gatien Chevallier wrote:
> +static int smsc_phy_suspend(struct phy_device *phydev)
> +{
> +	if (!phydev->wol_enabled)
> +		return genphy_suspend(phydev);

This should not be necessary. Take a look at phy_suspend(). Notice:

        phydev->wol_enabled = phy_drv_wol_enabled(phydev) ||
                              (netdev && netdev->ethtool->wol_enabled);
        /* If the device has WOL enabled, we cannot suspend the PHY */
        if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
                return -EBUSY;

PHY_ALWAYS_CALL_SUSPEND is not set for this PHY, therefore if
phydev->wol_enabled is set by the above code, phydrv->suspend will
not be called.

> +
> +	return 0;
> +}
> +
> +static int smsc_phy_resume(struct phy_device *phydev)
> +{
> +	int rc;
> +
> +	if (!phydev->wol_enabled)
> +		return genphy_resume(phydev);
> +
> +	rc = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!(rc & MII_LAN874X_PHY_WOL_STATUS_MASK))
> +		return 0;
> +
> +	dev_info(&phydev->mdio.dev, "Woke up from LAN event.\n");
> +	rc = phy_write_mmd(phydev, MDIO_MMD_PCS, MII_LAN874X_PHY_MMD_WOL_WUCSR,
> +			   rc | MII_LAN874X_PHY_WOL_STATUS_MASK);
> +
> +	return rc;

Note that this will be called multiple times, e.g. during attachment of
the PHY to the network device, when the device is opened, etc even
without ->suspend having been called, and before ->wol_enabled has
been set. Make sure your code is safe for this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

