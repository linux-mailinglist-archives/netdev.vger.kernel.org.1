Return-Path: <netdev+bounces-200335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904FFAE4980
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5A31884752
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F7277028;
	Mon, 23 Jun 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a71SVngq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3325F99B;
	Mon, 23 Jun 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694191; cv=none; b=gfBfxDead/7b1NPvrTrsC2LO5CvcIVK3LI1vUEE5uVRFxLu+nHB674kLOkd8qK+nF+xa+0uHyFUZgH714pxnqhfDn9+jMPWC1Zmsnw0cyzE3QPglo9j9F1zFys4tMdIQDQOQzLmt7UDBMkdcOys6MMy176BM11AQZfp4So2Se5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694191; c=relaxed/simple;
	bh=HLdwjx0VaTkw/NleBqU5pxtyJMC9TFdxwlMghBZW62o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWC1T7l1OnWhebFax2/WeZwFYiA/49d9e8g+NK4Ts8XdNOnwvpaJhtCuHN5kC97CLdOHB6fijGip7lhLovtkQWPsV9cYxYNQesQ/giX/JGlynVbeaA24K2p8ZnVKCjRc6qL0pGRQIvLKdKLb263fsYdCh1bdVpPF5ZG/taDqjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a71SVngq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zfhcm9KlPIYDUkR3XlxjvUFC1kNzPKwSMU7Z/fKZocY=; b=a71SVngqApbDm+fv8PIk+j3lkW
	i53ScPlnHM+UDC32YOCHBTGBm96BRMnj+mzn58OGnJT/GmIFCewp3S8IfrR666i9KQdzLlYh158xP
	AAN9zzkpAf2JFbTNAOP/8w5OHHvLGfQo4DQpvEpsHPGFxgy5iS9EYhvfpGBnuE+PQg2ouK+xv8fEn
	6/wE7xccEmj9lFLam1a9QXrS655FnlbMyLkI33Gd0z0VHinf5MeYbD8pZwTfAbk/fGHguA/jkkyQi
	iwUbwy8k/FuKM8T8URWKdWrXDH9rpWrxC/u1Jss6+IrlePAclwtoUK+R7Z7PfY8hEKq9phKpgYR9U
	FX/w8pAQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48284)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uTjWn-0004NI-0v;
	Mon, 23 Jun 2025 16:56:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uTjWi-0003Zg-1y;
	Mon, 23 Jun 2025 16:56:08 +0100
Date: Mon, 23 Jun 2025 16:56:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: phy: bcm54811: Fix the PHY
 initialization
Message-ID: <aFl5GJqBDeoK4fTd@shell.armlinux.org.uk>
References: <20250623151048.2391730-1-kamilh@axis.com>
 <20250623151048.2391730-3-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623151048.2391730-3-kamilh@axis.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 23, 2025 at 05:10:47PM +0200, Kamil Horák - 2N wrote:
>  	/* With BCM54811, BroadR-Reach implies no autoneg */
> -	if (priv->brr_mode)
> +	if (priv->brr_mode) {
>  		phydev->autoneg = 0;

This, to me, looks extremely buggy. Setting phydev->autoneg to zero does
not prevent userspace enabling autoneg later. It also doesn't report to
userspace that autoneg is disabled. Not your problem, but a latent bug
in this driver.

> +		/* Disable Long Distance Signaling, the BRR mode autoneg */
> +		err = phy_modify(phydev, MII_BCM54XX_LRECR, LRECR_LDSEN, 0);
> +		if (err < 0)
> +			return err;
> +	}
>  
> -	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
> +	if (!phy_interface_is_rgmii(phydev) ||
> +	    phydev->interface == PHY_INTERFACE_MODE_MII) {

Not sure this condition actually reflects what you're trying to
achieve, because if we're using PHY_INTERFACE_MODE_MII, then
!phy_interface_is_rgmii(phydev) will be true because phydev->interface
isn't one of the RGMII modes. So, I think this can be reduced to simply

	if (!phy_interface_is_rgmii(phydev)) {

> +		/* Misc Control: GMII/MII Mode (not RGMII) */
> +		err = bcm54xx_auxctl_write(phydev,
> +					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC,
> +					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN |
> +					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD
> +		);

I don't think this addition is described in the commit message.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

