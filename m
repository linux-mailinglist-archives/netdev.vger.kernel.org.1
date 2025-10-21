Return-Path: <netdev+bounces-231120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845FBF56D6
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6CA54E1525
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285E329C40;
	Tue, 21 Oct 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MgqVeec+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669D1C28E;
	Tue, 21 Oct 2025 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037757; cv=none; b=qi6gsbcgbQazNGD20NFM1rsIXUAPOEShBgwdjVwd2vTSiSjtDarzLSaTO+9qtXsClE3J3jD2rJK2A/NRnr4sDO3drcdDI0Ya9fQDw/2seTBZS4f7QBX6CJrLJiTdSAqzfKpvynMyFdFHJtNAKs+FX9GTRKhAKZ6JR3U2CoGGFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037757; c=relaxed/simple;
	bh=1qa8IqH1f1rVOaC7Q4ppRyUNIPxNsUWunxz04IUsF6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlywDXKWHhWZgH0mYz8LVXcoRln/g3OomRCMw9zYwFfwn2f531l4wQfqpnhNlCPLD/a82T0u6QK2R7RiTBpndLAmq0IXQs0HQzLPMBV3vs2OTADivN1vxtY81lLEdGhGRkLE4gmHFOj5Rh7FI2Yz2ZAYriqN0DiV3SSGtf7Q7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MgqVeec+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DhwzImLO/u5nl7X908+rSli4J14IMQSJXPEjIC7+6rc=; b=MgqVeec+EQNLIs0JJxV83FAEtc
	6t+5yP7Ebq8PKWDrLht/pA00gZHeegHWqNXZCicZ+GF7wXYkEqQHoxKgiKuNRe18TQ9zaSMoD/Pld
	MqbnwcrFFl8pyCNxEWfjlg2YgUyMbCIKWos8h3OaKrv6PJrXKszK09AWnjA1u7w5O8qcYoJYx3ry5
	Hg3NIDHsz2mraFAvfaWJzbAhQWIbuXgw5r5lTZeQf8qAMjEMNqCJWJXyD6ikrB9xzYRGQ/bRKZlmS
	M4tMgJWKI2k94jNRwj3DFkT5sCzK6G4wq3q2KjQdfQVgQUPKoNwgxsRbP23bDw/Q2weuYjKp/brgF
	uxEJugIw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45398)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vB8MZ-000000003VO-3LpQ;
	Tue, 21 Oct 2025 10:09:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vB8MW-0000000084F-1L32;
	Tue, 21 Oct 2025 10:09:00 +0100
Date: Tue, 21 Oct 2025 10:09:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, vladimir.oltean@nxp.com,
	vadim.fedorenko@linux.dev, christophe.jaillet@wanadoo.fr,
	rosenp@gmail.com, steen.hegelund@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] phy: mscc: Use PHY_ID_MATCH_MODEL for
 VSC8584, VSC8582, VSC8575, VSC856X
Message-ID: <aPdNrFe4JfCTNbAM@shell.armlinux.org.uk>
References: <20251017064819.3048793-1-horatiu.vultur@microchip.com>
 <20251017064819.3048793-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017064819.3048793-2-horatiu.vultur@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 17, 2025 at 08:48:18AM +0200, Horatiu Vultur wrote:
> As the PHYs VSC8584, VSC8582, VSC8575 and VSC856X exists only as rev B,
> we can use PHY_ID_MATCH_MODEL to match exactly on revision B of the PHY.

I don't follow this. PHY_ID_MATCH_MODEL() uses a mask of bits 31:4,
omitting the revision field. So that is equivalent to a .phy_id_mask
of 0xfffffff0, which is what the code already uses.

> Because of this change then there is not need the check if it is a
> different revision than rev B in the function vsc8584_probe() as we
> already know that this will never happen.

Since bits 3:0 are masked out, this statement seems to be false.

> @@ -2587,9 +2576,8 @@ static struct phy_driver vsc85xx_driver[] = {
>  	.config_inband  = vsc85xx_config_inband,
>  },
>  {
> -	.phy_id		= PHY_ID_VSC856X,
> +	PHY_ID_MATCH_MODEL(PHY_ID_VSC856X),
>  	.name		= "Microsemi GE VSC856X SyncE",
> -	.phy_id_mask	= 0xfffffff0,
>  	/* PHY_GBIT_FEATURES */
>  	.soft_reset	= &genphy_soft_reset,
>  	.config_init    = &vsc8584_config_init,
> @@ -2667,9 +2655,8 @@ static struct phy_driver vsc85xx_driver[] = {
>  	.config_inband  = vsc85xx_config_inband,
>  },
>  {
> -	.phy_id		= PHY_ID_VSC8575,
> +	PHY_ID_MATCH_MODEL(PHY_ID_VSC8575),
>  	.name		= "Microsemi GE VSC8575 SyncE",
> -	.phy_id_mask	= 0xfffffff0,
>  	/* PHY_GBIT_FEATURES */
>  	.soft_reset	= &genphy_soft_reset,
>  	.config_init    = &vsc8584_config_init,
> @@ -2693,9 +2680,8 @@ static struct phy_driver vsc85xx_driver[] = {
>  	.config_inband  = vsc85xx_config_inband,
>  },
>  {
> -	.phy_id		= PHY_ID_VSC8582,
> +	PHY_ID_MATCH_MODEL(PHY_ID_VSC8582),
>  	.name		= "Microsemi GE VSC8582 SyncE",
> -	.phy_id_mask	= 0xfffffff0,
>  	/* PHY_GBIT_FEATURES */
>  	.soft_reset	= &genphy_soft_reset,
>  	.config_init    = &vsc8584_config_init,
> @@ -2719,9 +2705,8 @@ static struct phy_driver vsc85xx_driver[] = {
>  	.config_inband  = vsc85xx_config_inband,
>  },
>  {
> -	.phy_id		= PHY_ID_VSC8584,
> +	PHY_ID_MATCH_MODEL(PHY_ID_VSC8584),
>  	.name		= "Microsemi GE VSC8584 SyncE",
> -	.phy_id_mask	= 0xfffffff0,
>  	/* PHY_GBIT_FEATURES */
>  	.soft_reset	= &genphy_soft_reset,
>  	.config_init    = &vsc8584_config_init,

Due to what I've said above, the above part of the patch is a cleanup,
and functionally is a no-op.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

