Return-Path: <netdev+bounces-150276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EAF9E9C0F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35396163A62
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCB145B1B;
	Mon,  9 Dec 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vpXCE7yt"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9705733A;
	Mon,  9 Dec 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762951; cv=none; b=A6FOqLf2EJ9dl8hQoMDdj8QDWaTwcwI2PkqgF2AMsJYRUlTrhM90sGjuN0DtqEtnff9SdagDtmbvN0TLsEy+X754+2ibaRVDw6iVDoUireiSd0lbXlyo8LEWGnPgcmehgZCyFX1IbTaCmL5GfA9TyR75EaXCUw/YCsHApT3f/7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762951; c=relaxed/simple;
	bh=AEoCc0FGdAAv/ttIoFhtZoNTqMNm4iuYAF9jpsbYTZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVLwCZB72MZmmvfqLjgKdKRiW836xhEYldC8tUEKhqsScdyc3bGWoDYYcLq/bM4uga/avlYRIN6lc2biKvnGXd4FH5/kzGvLChbPvzk3m/uYTMKU1QJincSaERdxUYZHMhHq7A0WA4OnLhVIAwZ9kYjaurtyyVJ9LbxFCLSLhwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vpXCE7yt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ICjbN6n13jj70mZQsHkAtSrd6RK+WgbUII0X9qS62uc=; b=vpXCE7ytz7SHl6yYm1GizxVhLz
	uPVtw/1PZ8z0SodKiUPTR08B6ATDcnTv13R9DjU/KJdVyiecHLZmND54jWRF3i29Cvn7mFcyEqxGz
	W+dmpcVwpnkf7DGKOOazWG8tPr3lnRlRZjVk1wEsK4nsd+C2sRL9Nn4D3ol7E5MUcnfiCfYmKCTTC
	RXmD/GXMqVXAMKmVRI1/6A8GVA0dT0Wd+YP4CyCk52TOhm/fmEPM2m04+iaU6obFJbQyegyeYnfVl
	xxtNj5axuRyIxelOKkolwm/s7T6ipQ/imVZuQ4SQa6htCkhfLPEw63LVB/iqNgcetGaSMsv7jaTmS
	GCEtkXOg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52748)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tKgwO-00018I-0O;
	Mon, 09 Dec 2024 16:49:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tKgwM-00027t-0k;
	Mon, 09 Dec 2024 16:48:58 +0000
Date: Mon, 9 Dec 2024 16:48:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tarun Alle <Tarun.Alle@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: phy-c45: Auto-negotiaion changes
 for T1 phy in phy library
Message-ID: <Z1cfepBZXlGoz0ue@shell.armlinux.org.uk>
References: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
 <20241209161427.3580256-2-Tarun.Alle@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209161427.3580256-2-Tarun.Alle@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 09, 2024 at 09:44:26PM +0530, Tarun Alle wrote:
> Below auto-negotiation library changes required for T1 phys:
> - Lower byte advertisement register need to read after higher byte as
>   per 802.3-2022 : Section 45.2.7.22.

In my copy of 802.3, this refers to the link partner base page
ability register, which is not the same as the advertisement
register.

The advertisement registers are covered by the preceeding section,
45.2.7.21. This says:

"The Base Page value is transferred to mr_adv_ability when register
7.514 is written. Therefore, registers 7.515 and 7.516 should be
written before 7.514."

which I think is what's pertinent to your commit.

> - Link status need to be get from control T1 registers for T1 phys.

This statement appears to be inaccurate - more below against the
actual code change.

> 
> Signed-off-by: Tarun Alle <Tarun.Alle@microchip.com>
> ---
>  drivers/net/phy/phy-c45.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index 0dac08e85304..85d8a9b9c3f6 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -234,15 +234,11 @@ static int genphy_c45_baset1_an_config_aneg(struct phy_device *phydev)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	adv_l |= linkmode_adv_to_mii_t1_adv_l_t(phydev->advertising);
> -
> -	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_L,
> -				     adv_l_mask, adv_l);
> -	if (ret < 0)
> -		return ret;
> -	if (ret > 0)
> -		changed = 1;
> -
> +	/* Ref. 802.3-2022 : Section 45.2.7.22
> +	 * The Base Page value is transferred to mr_adv_ability when register
> +	 * 7.514 is written.
> +	 * Therefore, registers 7.515 and 7.516 should be written before 7.514.
> +	 */
>  	adv_m |= linkmode_adv_to_mii_t1_adv_m_t(phydev->advertising);
>  
>  	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_M,
> @@ -252,6 +248,23 @@ static int genphy_c45_baset1_an_config_aneg(struct phy_device *phydev)
>  	if (ret > 0)
>  		changed = 1;
>  
> +	adv_l |= linkmode_adv_to_mii_t1_adv_l_t(phydev->advertising);
> +
> +	if (changed) {
> +		ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_ADV_L,
> +				    adv_l);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
> +					     MDIO_AN_T1_ADV_L,
> +					     adv_l_mask, adv_l);

Why do you write the complete register if changed is true, but only
modify bits 12, 11 and 10 if changed is false?

>  int genphy_c45_read_link(struct phy_device *phydev)
>  {
>  	u32 mmd_mask = MDIO_DEVS_PMAPMD;
> +	u16 reg = MDIO_CTRL1;
>  	int val, devad;
>  	bool link = true;
>  
>  	if (phydev->c45_ids.mmds_present & MDIO_DEVS_AN) {
> -		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_CTRL1);
> +		if (genphy_c45_baset1_able(phydev))
> +			reg = MDIO_AN_T1_CTRL;
> +		val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
>  		if (val < 0)
>  			return val;

This is not checking link status as you mention in your commit
message, it is checking whether the PHY is in the process of
restarting autoneg.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

