Return-Path: <netdev+bounces-171351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0314A4C9C1
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271FC7ACBD1
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDBE23CEF9;
	Mon,  3 Mar 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZAR7MSwf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D323C8D5;
	Mon,  3 Mar 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022721; cv=none; b=SaOjEA0mElR4ejfOVysXOwSsT3exVWKURL92iek3YfAeWB3WzM8VH48hWGoKAF/lJ2cDLG28ek8sBjye7SOgx/Tnqu8uKBlf28r8DbNZ9Pl4pvhbALH9GVohAdttawqvqTFy+nTfEgNR7Q7F25N82gcpizgI2JOqieWJy0/nnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022721; c=relaxed/simple;
	bh=p3/tymDo4/JvLzlfxYKvIxPaUSvKEVDopzwI6qnnIMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI3QBUYxjF5ESTtGDK9rLLr9OJ4OhK9bQKW/NTGWNaCQvZeUbIhn54KcM5+SelbHhMYY9+Pl8dv7RJhsTMg1rPJrz4aheVR67ja/AK1dqZUbneyiovSyi56V6GKFmuInGezx5PGHmQGIW3xgOUCpOq2BIYGwP2qAajImWIknV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZAR7MSwf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jhgq5PPF3obuw7CCfJ705oQRORKEx0yZzOBNGPhbknw=; b=ZAR7MSwfpoEh2NsT5v6CjyfOwC
	02LuzTTpEFDhXi3F0i4ztLwv6JKDYT0BRTqTdMWkPmbnOIXtj/iVdzLser5KS7SDD3/Ctw24ztkqG
	cuCVjUUJaXafEDbjq/oFlYi8feip6Ad3bFsXzhSJjZFU2cZ7AhuxaOSonHMiTACJO+4vwTt2CvyVY
	lDJX4rdbW5anIrpSXSt5SPoyDlBSYQQ5NHBdyC5R5ApLuOcXa+ubK0VI1bz0a7hJti4IpUN4XxGh+
	eHkhUFyov1sHMOD1OfqdqN+HzATG+kn0Ps9EccIdDvCw4Kz2epfuhlu/Hx76O9Aw2A4oTyQPS24qQ
	LKCfkrBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33702)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tp9XU-00013W-0G;
	Mon, 03 Mar 2025 17:25:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tp9XS-0003xa-0O;
	Mon, 03 Mar 2025 17:25:10 +0000
Date: Mon, 3 Mar 2025 17:25:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: dp83826: Add support for straps reading
Message-ID: <Z8Xl9blPRVXQiOSm@shell.armlinux.org.uk>
References: <20250303-dp83826-fixes-v1-0-6901a04f262d@yoseli.org>
 <20250303-dp83826-fixes-v1-2-6901a04f262d@yoseli.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-dp83826-fixes-v1-2-6901a04f262d@yoseli.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 03, 2025 at 06:05:52PM +0100, Jean-Michel Hautbois wrote:
> +	/* Bit 10: MDIX mode */
> +	if (val & BIT(10))
> +		phydev_dbg(phydev, "MDIX mode enabled\n");
> +
> +	/* Bit 9: auto-MDIX disable */
> +	if (val & BIT(9))
> +		phydev_dbg(phydev, "Auto-MDIX disabled\n");
> +
> +	/* Bit 8: RMII */
> +	if (val & BIT(8)) {
> +		phydev_dbg(phydev, "RMII mode enabled\n");
> +		phydev->interface = PHY_INTERFACE_MODE_RMII;
> +	}

Do all users of this PHY driver support having phydev->interface
changed?

> +
> +	/* Bit 5: Slave mode */
> +	if (val & BIT(5))
> +		phydev_dbg(phydev, "RMII slave mode enabled\n");
> +
> +	/* Bit 0: autoneg disable */
> +	if (val & BIT(0)) {
> +		phydev_dbg(phydev, "Auto-negotiation disabled\n");
> +		phydev->autoneg = AUTONEG_DISABLE;
> +		phydev->speed = SPEED_100;
> +		phydev->duplex = DUPLEX_FULL;
> +	}

This doesn't force phylib to disallow autoneg.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

