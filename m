Return-Path: <netdev+bounces-221611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74668B51347
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 11:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F363AB334
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6DB2571D8;
	Wed, 10 Sep 2025 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xTqxp6Ow"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCA31D368;
	Wed, 10 Sep 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498069; cv=none; b=UtW9hENQdXbBKeTIrIPS7TfmnvRBwc9EZAmdht244c2eAuNBXxRAdPcwKqq2O9TP0jhOYREI9K0guYMHUNe+ZZeLbPcMJ5iHSvG1ewGgruRy9knbKyjzyUvki32F+HEsRjRmejgDajDAPKLCpz/gquvHIHqVoJiZHGkqi6C2CQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498069; c=relaxed/simple;
	bh=RPu7WsZ5NmBmE6ci+vyI3oNBk7WRxIuT+Ot6ieeYCx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+F+kAnuLBEND6F04xjT8yXhWQ4JRTF+TbezFSGxgSLDAnzZPRGzjkI+H2nU3fDn0KUwACBz/CuOVGSjHqz2yKk/ufPTe9jSGyWef4stGhl4X4rzhr/yA1kOvDLuTAnJMQNngTZrjdbwDAhc2YT+cyctpLyAW2lr/d8CfOjmnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xTqxp6Ow; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CbOznHuhs5/ugJSEwIjdNH3VAb730l41QuxA3+q9mXU=; b=xTqxp6Ow9cgpUV/PeEhDmB33mP
	/LCtfSn+ZjDf+o7B7LkXc367ytAiP2ndAY91dp3Xv1t4Hg4SD3YHIoY98bCyzGP5OpyWI5BiSfaR5
	OsDGMBfFdIJ1rYpeogw+JTsKTXOYlAKpRjdMX+BUpGFvMOoC5k8QL/Q9y5pyCUOChYC3Y4zWf1J26
	A6bLilJn/8W/4lkwoiFr/Sd5VLg6bPMY8utdZn22KyQoeXOOhoAFevFLAiKKXBnOwVFXrvCWdk82H
	BVWzgx9+acsgfO9S8jDI46HMA1UcgfjbEZAUC1GxXf3LBcLRkZuJUaTEEVuV53ULU8q6W3U72WV/I
	MMV/qmvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57354)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwHWk-000000001TB-2ep1;
	Wed, 10 Sep 2025 10:54:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwHWf-000000001IX-2ewf;
	Wed, 10 Sep 2025 10:54:05 +0100
Date: Wed, 10 Sep 2025 10:54:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: yicongsrfy@163.com
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY
 during resume
Message-ID: <aMFKvS-Dm0hhJVnO@shell.armlinux.org.uk>
References: <aMEzv50VmUb2eUMQ@shell.armlinux.org.uk>
 <20250910091703.3575924-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910091703.3575924-1-yicongsrfy@163.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 10, 2025 at 05:17:03PM +0800, yicongsrfy@163.com wrote:
> Then, because `phydev->interface != PHY_INTERFACE_MODE_SGMII`, it attempts
> to enter `ytphy_rgmii_clk_delay_config` to configure the RGMII tx/rx delay.
> However, since this PHY device is not associated with any GMAC and is not
> connected via an RGMII interface, the function returns `-EOPNOTSUPP`.

It seems the problem is this code:

        /* set rgmii delay mode */
        if (phydev->interface != PHY_INTERFACE_MODE_SGMII) {
                ret = ytphy_rgmii_clk_delay_config(phydev);

which assumes that phydev->interface will be either SGMII or one of
the RGMII modes. This is not the case with a PHY that has been
freshly probed unless phydev->interface is set in the probe function.

I see the probe function decodes the PHYs operating mode and
configures stuff based on that. Maybe, as it only supports RGMII
and SGMII, it should also initialise phydev->interface to the initial
operating condition of the PHY if other code in the driver relies
upon this being set to either SGMII or one of the RGMII types.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

