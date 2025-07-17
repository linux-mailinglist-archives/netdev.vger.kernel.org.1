Return-Path: <netdev+bounces-207659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B113B08156
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710A71C23562
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6381799F;
	Thu, 17 Jul 2025 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEFYVeKP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1815E97
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 00:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752711516; cv=none; b=s9g6CaG9DE6O37lMx6OQAKldeRKWKkjGvammKbW/Zhtqp1yYTPS2kosHkEyVdE0kXEZ5ufV582tWmKj06lL3WbPs7+fVslLQqD+zW07+rQv7Hl7ArRO0bSYVZRlNqG4ceKI2FWxLcNb5NlJThEqBU6Ce0GyTslumtz6Gf1gBXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752711516; c=relaxed/simple;
	bh=gncHtZmad8gVpL2RJTf+esDAvqgP46tSzub5K0GKFnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmPqLSRUHheTwyMcFeaXn6AM/rJWlQIQ/DLq6t0iHez0Kre15Ly61/jHxg0VQp6cXBxlWiaQjXmVxaVLbk1RVFCzCrn2Cmr30MiY2l549IaA7gyjsGZXC7mpLCiTWN9+kD978zTr9BREwtDg3Ylxl3RwvXZE0XX7HraZjGymUKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEFYVeKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF20C4CEE7;
	Thu, 17 Jul 2025 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752711516;
	bh=gncHtZmad8gVpL2RJTf+esDAvqgP46tSzub5K0GKFnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LEFYVeKPdv+77Wwihytzk/68Su9yU6KfznkxFrYKPrEiYB80k05j5fQ2kc+8X2JQm
	 oHJfC8TN6gLU5T5xCZv+oDzCpfJr31FITp2Wbs2TatnJ4R3+zToz1JtWf5MGnHhST9
	 bXjSEWGzF1KbQuPTL4dsFjQg6aRN8GrGxZmpKdeW4LWG3+4Tql+sFp43XICO1YV6+P
	 PyMFnXjb2r1Uj6egD2NWXBlECf7TqJkU39f59cQ2XEisQtbv9iNhlowLyht/86wsHM
	 uRJQyL6Y2Je2DBJncSFZb+1s1vWIx0nzZW2V2UG2F0ZOU3XZcsZmPeMFNoRhjP2+p2
	 S/KLtWu2MaWZw==
Date: Wed, 16 Jul 2025 17:18:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next] net: wangxun: complete ethtool coalesce
 options
Message-ID: <20250716171834.0a9b430b@kernel.org>
In-Reply-To: <3D9FB44035A7556E+20250714092811.51244-1-jiawenwu@trustnetic.com>
References: <3D9FB44035A7556E+20250714092811.51244-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 17:28:11 +0800 Jiawen Wu wrote:
> Support to use adaptive RX coalescing. Change the default RX coalesce
> usecs and limit the range of parameters for various types of devices,
> according to their hardware design.

Really seems like this should be split into multiple commits with
proper commit messages.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index d9de600e685a..cf7fc412a273 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -303,6 +303,9 @@ int wx_get_coalesce(struct net_device *netdev,
>  	else
>  		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
>  
> +	if (wx->rx_itr_setting == 1)
> +		ec->use_adaptive_rx_coalesce = 1;

I don't understand the adaptive coalescing changes. You changed the
get/set functions but there seems to be no datapath code added actually
tuning the settings in this patch.

>  	/* if in mixed tx/rx queues per vector mode, report only rx settings */
>  	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
>  		return 0;
> @@ -334,19 +337,28 @@ int wx_set_coalesce(struct net_device *netdev,
>  			return -EOPNOTSUPP;
>  	}
>  
> -	if (ec->tx_max_coalesced_frames_irq)
> -		wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
> +	if (ec->tx_max_coalesced_frames_irq > WX_MAX_TX_WORK ||
> +	    !ec->tx_max_coalesced_frames_irq)
> +		return -EINVAL;

Looks unrelated to the adaptive settings

> +	wx->tx_work_limit = ec->tx_max_coalesced_frames_irq;
>  
>  	switch (wx->mac.type) {
>  	case wx_mac_sp:
>  		max_eitr = WX_SP_MAX_EITR;
> +		rx_itr_param = WX_20K_ITR;
> +		tx_itr_param = WX_12K_ITR;
>  		break;
>  	case wx_mac_aml:
>  	case wx_mac_aml40:
>  		max_eitr = WX_AML_MAX_EITR;
> +		rx_itr_param = WX_20K_ITR;
> +		tx_itr_param = WX_12K_ITR;
>  		break;
>  	default:
>  		max_eitr = WX_EM_MAX_EITR;
> +		rx_itr_param = WX_7K_ITR;
> +		tx_itr_param = WX_7K_ITR;
>  		break;
>  	}
>  
> @@ -354,14 +366,26 @@ int wx_set_coalesce(struct net_device *netdev,
>  	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
>  		return -EINVAL;
>  
> +	if (ec->use_adaptive_rx_coalesce) {
> +		wx->rx_itr_setting = 1;
> +		return 0;
> +	}
> +
> +	/* restore to default rx-usecs value when adaptive itr turn off */
> +	/* user shall turn off adaptive itr and set user-defined rx usecs value
> +	 * in two cmds separately.

But why? Why do you have to overwrite the usec value that user passed
in from the user?

> +	if (wx->rx_itr_setting == 1) {
> +		wx->rx_itr_setting = rx_itr_param;
> +		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
> +	}
> +
>  	if (ec->rx_coalesce_usecs > 1)
>  		wx->rx_itr_setting = ec->rx_coalesce_usecs << 2;
>  	else
>  		wx->rx_itr_setting = ec->rx_coalesce_usecs;
>  
> -	if (wx->rx_itr_setting == 1)
> -		rx_itr_param = WX_20K_ITR;
> -	else
> +	if (wx->rx_itr_setting != 1)
>  		rx_itr_param = wx->rx_itr_setting;
>  
>  	if (ec->tx_coalesce_usecs > 1)
> @@ -369,20 +393,8 @@ int wx_set_coalesce(struct net_device *netdev,
>  	else
>  		wx->tx_itr_setting = ec->tx_coalesce_usecs;
>  
> -	if (wx->tx_itr_setting == 1) {
> -		switch (wx->mac.type) {
> -		case wx_mac_sp:
> -		case wx_mac_aml:
> -		case wx_mac_aml40:
> -			tx_itr_param = WX_12K_ITR;
> -			break;
> -		default:
> -			tx_itr_param = WX_20K_ITR;
> -			break;
> -		}
> -	} else {
> +	if (wx->tx_itr_setting != 1)
>  		tx_itr_param = wx->tx_itr_setting;
> -	}
>  
>  	/* mixed Rx/Tx */
>  	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index c363379126c0..b632e5f80ad5 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -411,6 +411,8 @@ enum WX_MSCA_CMD_value {
>  #define WX_7K_ITR                    595
>  #define WX_12K_ITR                   336
>  #define WX_20K_ITR                   200
> +#define WX_70K_ITR                   57
> +#define WX_MAX_TX_WORK               65535
>  #define WX_SP_MAX_EITR               0x00000FF8U
>  #define WX_AML_MAX_EITR              0x00000FFFU
>  #define WX_EM_MAX_EITR               0x00007FFCU
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> index 7e2d9ec38a30..2ca127a7aa77 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
> @@ -115,7 +115,8 @@ static int ngbe_set_channels(struct net_device *dev,
>  
>  static const struct ethtool_ops ngbe_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
> -				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
> +				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
> +				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
>  	.get_drvinfo		= wx_get_drvinfo,
>  	.get_link		= ethtool_op_get_link,
>  	.get_link_ksettings	= wx_get_link_ksettings,
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index e0fc897b0a58..cb1b24a9ac6e 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> @@ -120,8 +120,8 @@ static int ngbe_sw_init(struct wx *wx)
>  	wx->rss_enabled = true;
>  
>  	/* enable itr by default in dynamic mode */
> -	wx->rx_itr_setting = 1;
> -	wx->tx_itr_setting = 1;
> +	wx->rx_itr_setting = WX_7K_ITR;
> +	wx->tx_itr_setting = WX_7K_ITR;

Is the comment above these 2 lines stale now? 
  
>  	/* set default ring sizes */
>  	wx->tx_ring_count = NGBE_DEFAULT_TXD;
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> index a4753402660e..86f3c106f1ed 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
> @@ -538,7 +538,8 @@ static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
>  
>  static const struct ethtool_ops txgbe_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
> -				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
> +				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
> +				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
>  	.get_drvinfo		= wx_get_drvinfo,
>  	.nway_reset		= wx_nway_reset,
>  	.get_link		= ethtool_op_get_link,
-- 
pw-bot: cr

