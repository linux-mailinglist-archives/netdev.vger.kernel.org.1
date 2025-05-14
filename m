Return-Path: <netdev+bounces-190551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811FAB77F1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 23:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650A48C0D8F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8822C296730;
	Wed, 14 May 2025 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nf7kaj9h"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8629672C
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747258071; cv=none; b=rVAYnDYpEag3XkWUoLHdgoLTdFZtSUOo8xmSyon5aTa3nZl+LxGsOupW8BpHE8B2SN94UGj+dypcleWOlemtxZ2xgfU5ixhQ3BP6qP8KCBzLRXuxqdvsGml0GFUCBnlGxtfR1F/ed1xgZrZ8o51UwGCd15zXPzTSERuMiUmWi+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747258071; c=relaxed/simple;
	bh=B9ChNiVWhSbXwMRhQRWesptb26gGcShoINsG7retb/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbktWR601X+9N7TLsS5zIastiTIZOUzndD7IhwFAyeO9hvVByOa5MvOzwRKSpRASwLk16BLOAv3YEiGaBTamuVO0EO2cufe9ahPqKrHD7fK1hFw0L9lBplS3WDfmtsYxpJX+ISQRxa1OggBns1/tpwqsMtr9P3mIYbd9esypkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nf7kaj9h; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7af0e1e-7ba2-48d0-9a0f-4903dbe97421@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747258067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Jy0DYHy2WLjjfMWoqqUpHcXeSEmZ+GUyw52TRuTn4=;
	b=nf7kaj9hrX9pi/Rz7GxOi8xEymsA21jTycRj0Plgv7FAcl3L4FoaxAKWsSyI1uWnLFRLr2
	ovwqSZsFeZ7QbaJOUFOR67mkYJzWUZPjevhSr7Ll0eyV4gT8YSUydN7S9kT3aQeQcRa4yc
	hZGpzbPMAgQAylAIXVmuA+0ZELrHQSg=
Date: Wed, 14 May 2025 22:27:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] net: lan743x: implement ndo_hwtstamp_get()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
 Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
 <20250514151931.1988047-2-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250514151931.1988047-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/05/2025 16:19, Vladimir Oltean wrote:
> Permit programs such as "hwtstamp_ctl -i eth0" to retrieve the current
> timestamping configuration of the NIC, rather than returning "Device
> driver does not have support for non-destructive SIOCGHWTSTAMP."
> 
> The driver configures all channels with the same timestamping settings.
> On TX, retrieve the settings of the first channel, those should be
> representative for the entire NIC. On RX, save the filter settings in a
> new adapter field.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   drivers/net/ethernet/microchip/lan743x_main.c |  2 ++
>   drivers/net/ethernet/microchip/lan743x_main.h |  1 +
>   drivers/net/ethernet/microchip/lan743x_ptp.c  | 18 ++++++++++++++++++
>   drivers/net/ethernet/microchip/lan743x_ptp.h  |  3 ++-
>   4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index b01695bf4f55..880681085df2 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1729,6 +1729,7 @@ int lan743x_rx_set_tstamp_mode(struct lan743x_adapter *adapter,
>   	default:
>   			return -ERANGE;
>   	}
> +	adapter->rx_tstamp_filter = rx_filter;
>   	return 0;
>   }
>   
> @@ -3445,6 +3446,7 @@ static const struct net_device_ops lan743x_netdev_ops = {
>   	.ndo_change_mtu		= lan743x_netdev_change_mtu,
>   	.ndo_get_stats64	= lan743x_netdev_get_stats64,
>   	.ndo_set_mac_address	= lan743x_netdev_set_mac_address,
> +	.ndo_hwtstamp_get	= lan743x_ptp_hwtstamp_get,
>   	.ndo_hwtstamp_set	= lan743x_ptp_hwtstamp_set,
>   };
>   
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
> index db5fc73e41cc..02a28b709163 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -1087,6 +1087,7 @@ struct lan743x_adapter {
>   	phy_interface_t		phy_interface;
>   	struct phylink		*phylink;
>   	struct phylink_config	phylink_config;
> +	int			rx_tstamp_filter;
>   };
>   
>   #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
> index 026d1660fd74..a3b48388b3fd 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ptp.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
> @@ -1736,6 +1736,24 @@ void lan743x_ptp_tx_timestamp_skb(struct lan743x_adapter *adapter,
>   	lan743x_ptp_tx_ts_complete(adapter);
>   }
>   
> +int lan743x_ptp_hwtstamp_get(struct net_device *netdev,
> +			     struct kernel_hwtstamp_config *config)
> +{
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	struct lan743x_tx *tx = &adapter->tx[0];
> +
> +	if (tx->ts_flags & TX_TS_FLAG_ONE_STEP_SYNC)
> +		config->tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
> +	else if (tx->ts_flags & TX_TS_FLAG_TIMESTAMPING_ENABLED)
> +		config->tx_type = HWTSTAMP_TX_ON;
> +	else
> +		config->tx_type = HWTSTAMP_TX_OFF;
> +
> +	config->rx_filter = adapter->rx_tstamp_filter;
> +
> +	return 0;
> +}
> +
>   int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
>   			     struct kernel_hwtstamp_config *config,
>   			     struct netlink_ext_ack *extack)
> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
> index 9581a7992ff6..e8d073bfa2ca 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ptp.h
> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
> @@ -51,7 +51,8 @@ int lan743x_ptp_open(struct lan743x_adapter *adapter);
>   void lan743x_ptp_close(struct lan743x_adapter *adapter);
>   void lan743x_ptp_update_latency(struct lan743x_adapter *adapter,
>   				u32 link_speed);
> -
> +int lan743x_ptp_hwtstamp_get(struct net_device *netdev,
> +			     struct kernel_hwtstamp_config *config);
>   int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
>   			     struct kernel_hwtstamp_config *config,
>   			     struct netlink_ext_ack *extack);

Thanks for making this improvement. Looks like the pattern of not having
"get" callbacks got into this from phy drivers.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

