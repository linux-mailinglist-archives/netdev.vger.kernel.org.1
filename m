Return-Path: <netdev+bounces-117238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D894D36F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE3F1C20EFC
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0D4197A9E;
	Fri,  9 Aug 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMOHsbDb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA220197A93
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217153; cv=none; b=ZUfh/1LGMjCcjbu+BSwp6wElP5S/AiJFwrdSqNh00jlZP2lRPKz6MVMv5e2oXshbxbtDoGoK6zfJLTppM8zVKmEOUspfP1n7vyfaHMg/F/Qrt+cwEtweyV9OZzDW5sVkHC/fiM7h13nXEauuPNBUZIBLEuN3lUeeOmr3QV6AdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217153; c=relaxed/simple;
	bh=22mMSvyDc2IiU19uY1pfTN1tmmxYIKM2YfhxIAI0xs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPSIzjzJtMTaRZGuH9NCvEZVsV6NeYDwb+jYljvejBupT0eWqrvAp5ls9urEh5JbmCWkINORf04gqjwTYRKL795BGWgCSeU6NztbBIqXCIvnKI8vdghKtvregjbi3ddpLaWUvUMlM+gNN1K26ndfmlTh8bgsSeaome7sWRjhDlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMOHsbDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110ACC32782;
	Fri,  9 Aug 2024 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723217153;
	bh=22mMSvyDc2IiU19uY1pfTN1tmmxYIKM2YfhxIAI0xs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMOHsbDbtBMC3+JWlhg3yK8lxRPpneMtrmfqHTqzTkrQqXC964vJWQ9juko4Ba5uc
	 Mxd9Tp9Hv/Y155rWxLYJIdJnjWraDnslhV0CmvP0SIUriaq9yHlr8RbK1wa4KkFec0
	 SV7mRgZyASRRdMu1I5Hbr7LwPDgxg8Sc9GCEkHFtxTdrsaAY1MHh9d5o4douB89oqy
	 i8We6ZS5THERx72QWmuxj7d6FlUtwNj2UxdWxCRGivH3lktq9tjse0NQRPNoPqBMQw
	 TD9MFB5uOV4Mh9ivznTXFI5I66VO5tawCmwi++SOSBU+iwlYMMeirUYSDWztqU/Its
	 6zaV84gPpEZXQ==
Date: Fri, 9 Aug 2024 16:25:49 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next v1] i40e: Add Energy Efficient Ethernet ability
 for X710 Base-T/KR/KX cards
Message-ID: <20240809152549.GB1951@kernel.org>
References: <20240808112217.3560733-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808112217.3560733-1-aleksandr.loktionov@intel.com>

On Thu, Aug 08, 2024 at 01:22:17PM +0200, Aleksandr Loktionov wrote:

...

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 1d0d2e5..cd7509f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -5641,50 +5641,77 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static void i40e_eee_capability_to_kedata_supported(__le16  eee_capability_,
> +						    unsigned long *supported)
> +{
> +	const int eee_capability = le16_to_cpu(eee_capability_);

Hi Aleksandr,

Maybe u16 would be an appropriate type for eee_capability.
Also, using const seems excessive here.

> +	static const int lut[] = {
> +		ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +		ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +		ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +		ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> +		ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
> +		ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> +		ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
> +	};
> +
> +	linkmode_zero(supported);
> +	for (unsigned int i = ARRAY_SIZE(lut); i--; )
> +		if (eee_capability & (1 << (i + 1)))

Perhaps:

		if (eee_capability & BIT(i + 1))

> +			linkmode_set_bit(lut[i], supported);
> +}
> +
>  static int i40e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
>  {
>  	struct i40e_netdev_priv *np = netdev_priv(netdev);
>  	struct i40e_aq_get_phy_abilities_resp phy_cfg;
>  	struct i40e_vsi *vsi = np->vsi;
>  	struct i40e_pf *pf = vsi->back;
>  	struct i40e_hw *hw = &pf->hw;
> -	int status = 0;
> +	int status;

This change seems unrelated to the subject of this patch.
If so, please remove.

>  
>  	/* Get initial PHY capabilities */
>  	status = i40e_aq_get_phy_capabilities(hw, false, true, &phy_cfg, NULL);
>  	if (status)
>  		return -EAGAIN;
>  
>  	/* Check whether NIC configuration is compatible with Energy Efficient
>  	 * Ethernet (EEE) mode.
>  	 */
>  	if (phy_cfg.eee_capability == 0)
>  		return -EOPNOTSUPP;
>  
> +	i40e_eee_capability_to_kedata_supported(phy_cfg.eee_capability, edata->supported);

Please line-wrap: Networking still prefers code to be 80 columns wide or less.

> +	linkmode_copy(edata->lp_advertised, edata->supported);
> +
>  	/* Get current configuration */
>  	status = i40e_aq_get_phy_capabilities(hw, false, false, &phy_cfg, NULL);
>  	if (status)
>  		return -EAGAIN;
>  
> +	linkmode_zero(edata->advertised);
> +	if (phy_cfg.eee_capability)
> +		linkmode_copy(edata->advertised, edata->supported);
>  	edata->eee_enabled = !!phy_cfg.eee_capability;
>  	edata->tx_lpi_enabled = pf->stats.tx_lpi_status;
>  
>  	edata->eee_active = pf->stats.tx_lpi_status && pf->stats.rx_lpi_status;
>  
>  	return 0;
>  }
>  
>  static int i40e_is_eee_param_supported(struct net_device *netdev,
>  				       struct ethtool_keee *edata)
>  {
>  	struct i40e_netdev_priv *np = netdev_priv(netdev);
>  	struct i40e_vsi *vsi = np->vsi;
>  	struct i40e_pf *pf = vsi->back;
>  	struct i40e_ethtool_not_used {
> -		u32 value;
> +		int value;

It is unclear to me that this type change is really related to the
subject of this patch. If not, please drop it. But if so, it
seems to me that bool would be the appropriate type.

>  		const char *name;
>  	} param[] = {
> -		{edata->tx_lpi_timer, "tx-timer"},
> +		{!!(edata->advertised[0] & ~edata->supported[0]), "advertise"},
> +		{!!edata->tx_lpi_timer, "tx-timer"},
>  		{edata->tx_lpi_enabled != pf->stats.tx_lpi_status, "tx-lpi"}
>  	};
>  	int i;
> @@ -5710,7 +5737,7 @@ static int i40e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
>  	struct i40e_pf *pf = vsi->back;
>  	struct i40e_hw *hw = &pf->hw;
>  	__le16 eee_capability;
> -	int status = 0;
> +	int status;

This change seems unrelated to the subject of this patch.
If so, please remove.

>  
>  	/* Deny parameters we don't support */
>  	if (i40e_is_eee_param_supported(netdev, edata))
> @@ -5754,7 +5781,7 @@ static int i40e_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
>  		config.eeer |= cpu_to_le32(I40E_PRTPM_EEER_TX_LPI_EN_MASK);
>  	} else {
>  		config.eee_capability = 0;
> -		config.eeer &= cpu_to_le32(~I40E_PRTPM_EEER_TX_LPI_EN_MASK);
> +		config.eeer &= ~cpu_to_le32(I40E_PRTPM_EEER_TX_LPI_EN_MASK);

Ditto.

>  	}
>  
>  	/* Apply modified PHY configuration */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index cbcfada..55bbf0f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -7263,6 +7263,22 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
>  	return err;
>  }
>  #endif /* CONFIG_I40E_DCB */
> +static void i40e_print_link_message_eee(struct i40e_vsi *vsi, struct ethtool_keee *kedata,
> +			    const char *speed, const char *fc)
> +{
> +	if (vsi->netdev->ethtool_ops->get_eee)
> +		vsi->netdev->ethtool_ops->get_eee(vsi->netdev, kedata);
> +
> +	if (!linkmode_empty(kedata->supported))
> +		netdev_info(vsi->netdev,
> +			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s, EEE: %s\n",
> +			    speed, fc,
> +			    kedata->eee_enabled ? "Enabled" : "Disabled");
> +	else
> +		netdev_info(vsi->netdev,
> +			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s\n",
> +			    speed, fc);
> +}
>  
>  /**
>   * i40e_print_link_message - print link up or down
> @@ -7395,9 +7411,12 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
>  			    "NIC Link is Up, %sbps Full Duplex, Requested FEC: %s, Negotiated FEC: %s, Autoneg: %s, Flow Control: %s\n",
>  			    speed, req_fec, fec, an, fc);
>  	} else {
> -		netdev_info(vsi->netdev,
> -			    "NIC Link is Up, %sbps Full Duplex, Flow Control: %s\n",
> -			    speed, fc);
> +		struct ethtool_keee kedata;
> +
> +		linkmode_zero(kedata.supported);
> +		kedata.eee_enabled = false;

Can the declaration of ethtool_keee be moved into
i40e_print_link_message_eee()? I suspect that would lead to
a cleaner implementation.

> +
> +		i40e_print_link_message_eee(vsi, &kedata, speed, fc);
>  	}
>  
>  }

