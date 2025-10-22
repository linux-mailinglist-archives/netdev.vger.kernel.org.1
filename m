Return-Path: <netdev+bounces-231674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 196EBBFC635
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2CC540364
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA5634B408;
	Wed, 22 Oct 2025 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uhgD8tnX"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CD34B407
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141973; cv=none; b=iEyLexF892aXOvHxSJ/+Mp0fz03V0XGUn9YaQnjCrBfoy8PBBG7nmyw5sKY7uoD2ID5gzEnjjnfNbpTG1Hw8X4Ty38e4rQUGM+9uq/Se+leP3hEsk7INk8XqqELJ4ClKAFnjt6ZKp0pBQeNjFlw4GwBO/iYoCA9BgEHZl4vInsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141973; c=relaxed/simple;
	bh=8h7xzMQdouJ+vvChD8KymF5JzE/l0OpWC+99OogR0bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAtB7jqDp+62KoSwF9ll5PtaUbEWco5ttldgoTVC+3gtWRwRSOOSLf+lIkFbesiHV6liuN7AeNVjMIdHd1ifvTW+mG0MYEbNV1DgkhxcqKWjdyv/SK7Js68zHD4WuuwqfcZLwB5qnIW6xAktonJyBp1kJyAhS+M1Vs45bzxZNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uhgD8tnX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EC41F1A15D2;
	Wed, 22 Oct 2025 14:06:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0FC1606DC;
	Wed, 22 Oct 2025 14:06:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87CC2102F2432;
	Wed, 22 Oct 2025 16:06:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761141966; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Ga2wjic9T8VzJuXCWKH+Uj/T9PGjvabNwcCK7WxQpK0=;
	b=uhgD8tnXycbKWWz5/zQAf9epeYRRcbjwqUoYWkhSy+Q7x5JzjSwiDg4V1UBIqksCE44Q/A
	hweWz1G8s6OwRRYaQFO25S/OcoQjoL7mdqn7RQXBY2tlc1fC+ONVDuEdwwe7bsO2F3h9lo
	H5PzwXHW8NeYz3TVLMrpmGK855qDx7pf5wCqJ/Bftal8BNMjLD8iOzOrh+jQQBtxF27td3
	ASxenBJlVqMtIyleCBai2rQPTb16hBit41QDcxU8ja5nWvQvHUCry9UGBrhKabn3Ixy5ln
	w5EzkMIAHgrO86PS2sp3SbM10IjWv8rlZmnir+b08i3EbNptabQ62SVpIm71MQ==
Message-ID: <6bff48d0-dd19-48d4-91e6-0d991365b8f9@bootlin.com>
Date: Wed, 22 Oct 2025 16:06:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: phylink: add phylink managed MAC
 Wake-on-Lan support
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCT-0000000B2Ob-1yo3@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1v9jCT-0000000B2Ob-1yo3@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 17/10/2025 14:04, Russell King (Oracle) wrote:
> Add core phylink managed Wake-on-Lan support, which is enabled when the
> MAC driver fills in the new .mac_wol_set() method that this commit
> creates.
> 
> When this feature is disabled, phylink acts as it has in the past,
> merely passing the ethtool WoL calls to phylib whenever a PHY exists.
> No other new functionality provided by this commit is enabled.
> 
> When this feature is enabled, a more inteligent approach is used.
> Phylink will first pass WoL options to the PHY, read them back, and
> attempt to set any options that were not set at the PHY at the MAC.
> 
> Since we have PHY drivers that report they support WoL, and accept WoL
> configuration even though they aren't wired up to be capable of waking
> the system, we need a way to differentiate between PHYs that think
> they support WoL and those which actually do. As PHY drivers do not
> make use of the driver model's wake-up infrastructure, but could, we
> use this to determine whether PHY drivers can participate. This gives
> a path forward where, as MAC drivers are converted to this, it
> encourages PHY drivers to also be converted.
> 
> Phylink will also ignore the mac_wol argument to phylink_suspend() as
> it now knows the WoL state at the MAC.
> 
> MAC drivers are expected to record/configure the Wake-on-Lan state in
> their .mac_set_wol() method, and deal appropriately with it in their
> suspend/resume methods. The driver model provides assistance to set the
> IRQ wake support which may assist driver authors in achieving the
> necessary configuration.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 80 +++++++++++++++++++++++++++++++++++++--
>  include/linux/phylink.h   | 26 +++++++++++++
>  2 files changed, 102 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 9d7799ea1c17..939438a6d6f5 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -93,6 +93,9 @@ struct phylink {
>  	u8 sfp_port;
>  
>  	struct eee_config eee_cfg;
> +
> +	u32 wolopts_mac;
> +	u8 wol_sopass[SOPASS_MAX];
>  };
>  
>  #define phylink_printk(level, pl, fmt, ...) \
> @@ -2562,6 +2565,17 @@ void phylink_rx_clk_stop_unblock(struct phylink *pl)
>  }
>  EXPORT_SYMBOL_GPL(phylink_rx_clk_stop_unblock);
>  
> +static bool phylink_mac_supports_wol(struct phylink *pl)
> +{
> +	return !!pl->mac_ops->mac_wol_set;
> +}
> +
> +static bool phylink_phy_supports_wol(struct phylink *pl,
> +				     struct phy_device *phydev)
> +{
> +	return phydev && (pl->config->wol_phy_legacy || phy_can_wakeup(phydev));
> +}
> +
>  /**
>   * phylink_suspend() - handle a network device suspend event
>   * @pl: a pointer to a &struct phylink returned from phylink_create()
> @@ -2575,11 +2589,17 @@ EXPORT_SYMBOL_GPL(phylink_rx_clk_stop_unblock);
>   *   can also bring down the link between the MAC and PHY.
>   * - If Wake-on-Lan is active, but being handled by the MAC, the MAC
>   *   still needs to receive packets, so we can not bring the link down.
> + *
> + * Note: when phylink managed Wake-on-Lan is in use, @mac_wol is ignored.
> + * (struct phylink_mac_ops.mac_set_wol populated.)
>   */
>  void phylink_suspend(struct phylink *pl, bool mac_wol)
>  {
>  	ASSERT_RTNL();
>  
> +	if (phylink_mac_supports_wol(pl))
> +		mac_wol = !!pl->wolopts_mac;
> +
>  	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
>  		/* Wake-on-Lan enabled, MAC handling */
>  		mutex_lock(&pl->state_mutex);
> @@ -2689,8 +2709,24 @@ void phylink_ethtool_get_wol(struct phylink *pl, struct ethtool_wolinfo *wol)
>  	wol->supported = 0;
>  	wol->wolopts = 0;
>  
> -	if (pl->phydev)
> -		phy_ethtool_get_wol(pl->phydev, wol);
> +	if (phylink_mac_supports_wol(pl)) {
> +		if (phylink_phy_supports_wol(pl, pl->phydev))
> +			phy_ethtool_get_wol(pl->phydev, wol);
> +
> +		/* Where the MAC augments the WoL support, merge its support and
> +		 * current configuration.
> +		 */
> +		if (~wol->wolopts & pl->wolopts_mac & WAKE_MAGICSECURE)
> +			memcpy(wol->sopass, pl->wol_sopass,
> +			       sizeof(wol->sopass));
> +
> +		wol->supported |= pl->config->wol_mac_support;
> +		wol->wolopts |= pl->wolopts_mac;
> +	} else {
> +		/* Legacy */
> +		if (pl->phydev)
> +			phy_ethtool_get_wol(pl->phydev, wol);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(phylink_ethtool_get_wol);
>  
> @@ -2707,12 +2743,48 @@ EXPORT_SYMBOL_GPL(phylink_ethtool_get_wol);
>   */
>  int phylink_ethtool_set_wol(struct phylink *pl, struct ethtool_wolinfo *wol)
>  {
> +	struct ethtool_wolinfo w;
>  	int ret = -EOPNOTSUPP;
> +	bool changed;
> +	u32 wolopts;
>  
>  	ASSERT_RTNL();
>  
> -	if (pl->phydev)
> -		ret = phy_ethtool_set_wol(pl->phydev, wol);
> +	if (phylink_mac_supports_wol(pl)) {
> +		wolopts = wol->wolopts;
> +
> +		if (phylink_phy_supports_wol(pl, pl->phydev)) {
> +			ret = phy_ethtool_set_wol(pl->phydev, wol);
> +			if (ret != 0 && ret != -EOPNOTSUPP)
> +				return ret;
> +
> +			phy_ethtool_get_wol(pl->phydev, &w);
> +
> +			/* Any Wake-on-Lan modes which the PHY is handling
> +			 * should not be passed on to the MAC.
> +			 */
> +			wolopts &= ~w.wolopts;

When PHY drivers gets converted to the new model, we'll have to look at
how the .get_wol() behave WRT how they fill-in their wolopts.

The Broadcom driver for example may not set w.wolopts to 0 :

  https://elixir.bootlin.com/linux/v6.17.4/source/drivers/net/phy/broadcom.c#L1121

You'd probably end-up with garbage here then. But not blocking for your series.

> +		}
> +
> +		wolopts &= pl->config->wol_mac_support;
> +		changed = pl->wolopts_mac != wolopts;
> +		if (wolopts & WAKE_MAGICSECURE)
> +			changed |= !!memcmp(wol->sopass, pl->wol_sopass,
> +					    sizeof(wol->sopass));
> +		memcpy(pl->wol_sopass, wol->sopass, sizeof(pl->wol_sopass));
> +
> +		if (changed) {
> +			ret = pl->mac_ops->mac_wol_set(pl->config, wolopts,
> +						       wol->sopass);
> +			if (!ret)
> +				pl->wolopts_mac = wolopts;
> +		} else {
> +			ret = 0;
> +		}
> +	} else {
> +		if (pl->phydev)
> +			ret = phy_ethtool_set_wol(pl->phydev, wol);
> +	}
>  
>  	return ret;
>  }
> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 9af0411761d7..59cb58b29d1d 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -156,6 +156,8 @@ enum phylink_op_type {
>   * @lpi_capabilities: MAC speeds which can support LPI signalling
>   * @lpi_timer_default: Default EEE LPI timer setting.
>   * @eee_enabled_default: If set, EEE will be enabled by phylink at creation time
> + * @wol_phy_legacy: Use Wake-on-Lan with PHY even if phy_can_wakeup() is false
> + * @wol_mac_support: Bitmask of MAC supported %WAKE_* options
>   */
>  struct phylink_config {
>  	struct device *dev;
> @@ -173,6 +175,10 @@ struct phylink_config {
>  	unsigned long lpi_capabilities;
>  	u32 lpi_timer_default;
>  	bool eee_enabled_default;
> +
> +	/* Wake-on-Lan support */
> +	bool wol_phy_legacy;
> +	u32 wol_mac_support;
>  };
>  
>  void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
> @@ -188,6 +194,7 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
>   * @mac_link_up: allow the link to come up.
>   * @mac_disable_tx_lpi: disable LPI.
>   * @mac_enable_tx_lpi: enable and configure LPI.
> + * @mac_wol_set: configure Wake-on-Lan settings at the MAC.
>   *
>   * The individual methods are described more fully below.
>   */
> @@ -211,6 +218,9 @@ struct phylink_mac_ops {
>  	void (*mac_disable_tx_lpi)(struct phylink_config *config);
>  	int (*mac_enable_tx_lpi)(struct phylink_config *config, u32 timer,
>  				 bool tx_clk_stop);
> +
> +	int (*mac_wol_set)(struct phylink_config *config, u32 wolopts,
> +			   const u8 *sopass);
>  };
>  
>  #if 0 /* For kernel-doc purposes only. */
> @@ -440,6 +450,22 @@ void mac_disable_tx_lpi(struct phylink_config *config);
>   */
>  int mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
>  		      bool tx_clk_stop);
> +
> +/**
> + * mac_wol_set() - configure the Wake-on-Lan parameters
> + * @config: a pointer to a &struct phylink_config.
> + * @wolopts: Bitmask of %WAKE_* flags for enabled Wake-On-Lan modes.
> + * @sopass: SecureOn(tm) password; meaningful only for %WAKE_MAGICSECURE
> + *
> + * Enable the specified Wake-on-Lan options at the MAC. Options that the
> + * PHY can handle will have been removed from @wolopts.
> + *
> + * The presence of this method enables phylink-managed WoL support.
> + *
> + * Returns: 0 on success.
> + */
> +int (*mac_wol_set)(struct phylink_config *config, u32 wolopts,
> +		   const u8 *sopass);
>  #endif
>  
>  struct phylink_pcs_ops;

As far as my current WoL knowedge goes, this looks good to me.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


