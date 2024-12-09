Return-Path: <netdev+bounces-150281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F67C9E9C77
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638C428455A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB958153BFC;
	Mon,  9 Dec 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rYrzeoRq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307461537B9;
	Mon,  9 Dec 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763803; cv=none; b=R4UFYm3PUGQNvzNFYJCejHowhrRgOUUDAdze+xVOB2NKxi5xYPwqQ8pc15sKrHvqAVbRcnOq67Spq9870rpmDiQKrH2VYBlTTFKqI7jRh3/wZUWFIKefyiUMYOzXlehyYrP/imfgqnsOFlcKrX/qZwRvH561geboDv+OOihDRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763803; c=relaxed/simple;
	bh=NOSr4+5BUZ72Jj/2YRGMgfANkt36kkIYjBGErGVwvoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIIcKPDkrQPwNXvbmSTKf6os5mt4tA6+zXgAYfzvWLzgnbyBUFNiQMMJOUGtoUvQxyYn0sKBcR/upg4SVm36UOn8Xmen8ZAA//m8c3gGnDUG5nAiWSI3wnc59c66B8tMVElqDdk2PKW/7vh7K7RFWHcNEO8CfpRs3BTqrFNanG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rYrzeoRq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=53s+BWddUyquwr7+OqqxmkOH96OlD2vYtPAViOZMbfs=; b=rYrzeoRqgDFP+EMKfKHuz6CNX/
	gDt+5ac0XSP0Mdv/3RY8/OvNj5rNWsbZzwx5iUNBpBVJCUSBZ52ca2nfdQzFSibmdBkzX5AJFRG2o
	8fzS8m9YD5uO35hZWbsK0lajWF0kwaETBpPOZhuOgfLfM6vMEFzJ4q0cODv04HWLGlCE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKhA5-00FhDv-Mx; Mon, 09 Dec 2024 18:03:09 +0100
Date: Mon, 9 Dec 2024 18:03:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tarun Alle <Tarun.Alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: microchip_t1: Autonegotiaion
 support for LAN887x T1 phy
Message-ID: <20d00e72-f342-4dac-ba4c-1a66c8b25ef6@lunn.ch>
References: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
 <20241209161427.3580256-3-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209161427.3580256-3-Tarun.Alle@microchip.com>

> -	if (phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_FORCE ||
> -	    phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_PREFERRED){
> -		static const struct lan887x_regwr_map phy_cfg[] = {
> -			{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x00b8},
> -			{MDIO_MMD_PMAPMD, LAN887X_TX_AMPLT_1000T1_REG, 0x0038},
> -			{MDIO_MMD_VEND1,  LAN887X_INIT_COEFF_DFE1_100, 0x000f},
> -		};
> -
> -		ret = lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
> +	if (phydev->autoneg == AUTONEG_DISABLE) {
> +		if (phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_FORCE ||
> +		    phydev->master_slave_set ==
> +		    MASTER_SLAVE_CFG_MASTER_PREFERRED) {
> +			ret = lan887x_phy_config(phydev, phy_comm_cfg,
> +						 ARRAY_SIZE(phy_comm_cfg));
> +		} else {
> +			static const struct lan887x_regwr_map phy_cfg[] = {
> +				{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4,
> +				 0x0038},
> +				{MDIO_MMD_VEND1, LAN887X_INIT_COEFF_DFE1_100,
> +				 0x0014},
> +			};
> +
> +			ret = lan887x_phy_config(phydev, phy_cfg,
> +						 ARRAY_SIZE(phy_cfg));
> +		}

It might be better to pull this apart into two helper functions? That
would avoid most of the not so nice wrapping.

	Andrew

