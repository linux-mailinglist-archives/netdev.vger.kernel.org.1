Return-Path: <netdev+bounces-166364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D576A35B36
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFECC16CC75
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66FC2566C9;
	Fri, 14 Feb 2025 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="posUjUHd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECCA2505C2;
	Fri, 14 Feb 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527708; cv=none; b=MCOzmwy7MhZhivyuDFaNE+/CFiYuhl5KZv2mVAWXSS8Vc0F72cRl+z4Gm630AYhT4p+dKA5HUi7mI/1WBUbv2bUDrmVRlicSib52soQf1cIXeTNc2FlTZBPWSkM6wO1b93A4qALUGkj+nRwOOFJk23LGeJ2XKReUQoj/+RyrQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527708; c=relaxed/simple;
	bh=53LNLk41GeT251Ki6wN1YyHGewResJx5xfKx2eJrWbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TezsL4mOodfNZcp0SS20FpBnXt53LqAPNdva60O91/8UAr61BxSf8TBRYg/xVm0u93hDsmmGQcdAx3Son9hW6wTA1tBPeeW6XOnLCb4dYAWg99Rp5zsaCeKONP/6ny1dPvRDegTqIZGNFWonS2JwrCz0orbULVljrRbvTjj1eJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=posUjUHd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tdPlHVt3ni4s0SZff+yz9+0nplN2iDRWLKiUyFb0Hp4=; b=posUjUHddym7uqvMHwCOokPRUL
	hIhvizeJkvzKLNBVD20Ub1HVM+rJbzaQh/LiBHzcI3efIe8gbOqdy6KWANyxjPYtiMqtcDZoHZuhs
	7u/MJabTtIXJzKanWX9orGcAeKMq/zyqH/C3x6cNoOqcdNnFfKSSFiiiUY2O5NRMC6NURE3G9o2rA
	0Uc0WEcD6FNPLNjU8qs/hwVWo6VKTjYfRM6d+B5WT+JoU8xOWoB9Nf29MZ13ipmu/Di8t/D9SjGMw
	LNfcmO9l4h/KZvm61YLqV5t5ECDoDoxlX1gw2WCKPpcbynrtZy2+31vzwjuLMlTSu95qzV561/k+M
	Q2w17mCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43330)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tiscM-0004cw-1V;
	Fri, 14 Feb 2025 10:08:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tiscG-00033r-1e;
	Fri, 14 Feb 2025 10:08:12 +0000
Date: Fri, 14 Feb 2025 10:08:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: net: phy: Elaborate on RGMII
 delay handling
Message-ID: <Z68WDG_OzTDOBGY-@shell.armlinux.org.uk>
References: <20250214094414.1418174-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214094414.1418174-1-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 14, 2025 at 10:44:13AM +0100, Maxime Chevallier wrote:
> @@ -73,8 +73,16 @@ The Reduced Gigabit Medium Independent Interface (RGMII) is a 12-pin
>  electrical signal interface using a synchronous 125Mhz clock signal and several
>  data lines. Due to this design decision, a 1.5ns to 2ns delay must be added
>  between the clock line (RXC or TXC) and the data lines to let the PHY (clock
> -sink) have a large enough setup and hold time to sample the data lines correctly. The
> -PHY library offers different types of PHY_INTERFACE_MODE_RGMII* values to let
> +sink) have a large enough setup and hold time to sample the data lines correctly.
> +
> +The device tree property phy-mode describes the hardware. When used

Please don't make this document device-tree centric - it isn't
currently, and in fact phylink can be used with other implementations
even statically defined. Nothing about the phy mode is device-tree
centric.

> +with RGMII, its value indicates if the hardware, i.e. the PCB,
> +provides the 2ns delay required for RGMII. A phy-mode of 'rgmii'
> +indicates the PCB is adding the 2ns delay. For other values, the
> +MAC/PHY pair must insert the needed 2ns delay, with the strong
> +preference the PHY adds the delay.

This gets confusing. The documentation already lists each RGMII mode
describing each in detail in terms of the PHY. I'm not sure we need to
turn it on its head and start talking about "it's the PCB property".

> +
> +The PHY library offers different types of PHY_INTERFACE_MODE_RGMII* values to let
>  the PHY driver and optionally the MAC driver, implement the required delay. The
>  values of phy_interface_t must be understood from the perspective of the PHY
>  device itself, leading to the following:
> @@ -106,14 +114,22 @@ Whenever possible, use the PHY side RGMII delay for these reasons:
>    configure correctly a specified delay enables more designs with similar delay
>    requirements to be operated correctly
>  
> -For cases where the PHY is not capable of providing this delay, but the
> -Ethernet MAC driver is capable of doing so, the correct phy_interface_t value
> -should be PHY_INTERFACE_MODE_RGMII, and the Ethernet MAC driver should be
> -configured correctly in order to provide the required transmit and/or receive
> -side delay from the perspective of the PHY device. Conversely, if the Ethernet
> -MAC driver looks at the phy_interface_t value, for any other mode but
> -PHY_INTERFACE_MODE_RGMII, it should make sure that the MAC-level delays are
> -disabled.
> +The MAC driver may fine tune the delays. This can be configured
> +based on firmware "rx-internal-delay-ps" and "tx-internal-delay-ps"
> +properties. These values are expected to be small, not the full 2ns
> +delay.
> +
> +A MAC driver inserting these fine tuning delays should always do so
> +when these properties are present and non-zero, regardless of the
> +RGMII mode specified.
> +
> +For cases where the PHY is not capable of providing the 2ns delay,
> +the MAC must provide it,

No, this is inaccurate. One may have a PHY that is not capable of
providing the delay, but the PCB does. 

It also brings up the question "how does the MAC know that the PHY
isn't capable of providing the delay" and "how does the MAC know that
the PCB is not providing the delay". This is a can of worms...

> if the phy-mode indicates the PCB is not
> +providing the delays. The MAC driver must adjust the
> +PHY_INTERFACE_MODE_RGMII_* mode it passes to the connected PHY
> +device (through :c:func:`phy_connect <phy_connect>` for example) to
> +account for MAC-side delay insertion, so that the PHY device
> +does not add additional delays.

The intention of the paragraph you're trying to clarify (but I'm not
sure it is any clearer) is:

- If the MAC driver is providing the delays, it should pass
  PHY_INTERFACE_MODE_RGMII to phylib. It should interpret the
  individual RGMII modes for its own delay setting.

- If the MAC driver is not providing the delays, it should pass
  the appropriate PHY_INTERFACE_MODE_RGMII* to phylib so the PHY
  can add the appropriate delays (which will depend on the PCB and
  other design parameters.) The MAC driver must *not* interpret the
  individual RGMII modes for its own delay setting.

In both cases, the MAC can fine-tune the delays using whatever mechanism
it sees fit.

Whether the PHY is capable of providing the delay or not is up to the
board designer and up to the author providing the RGMII configuration
(e.g. board firmware (DT / ACPI) to sort out.) There is no mechanism
in the kernel that the MAC can discover whether the PHY its going to
connect to supports any particular RGMII delay setting.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

