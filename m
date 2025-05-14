Return-Path: <netdev+bounces-190525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335EEAB74E6
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 21:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81C34A721F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 19:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4491F4634;
	Wed, 14 May 2025 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="ie6ND2Fk"
X-Original-To: netdev@vger.kernel.org
Received: from mx03lb.world4you.com (mx03lb.world4you.com [81.19.149.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E21FCFF3
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249235; cv=none; b=FhfGmd0PAA56pd4lXZLGQ5vGg4t/57Fz/acgoOnLPBDNArWnW3j3lh0N9oCM23msiqlvAobNWFPfczVro/iydiCxOnsZI52q8SiY4yJxhsUcBSDiA56jLWcbq7PziWdl2orEyJYPlB/hOPWcW4vyARdwbqn8/TZx8QywkejZyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249235; c=relaxed/simple;
	bh=jayoMvpFmY+V/6FYdWPshVom5X5zq0HGac5czDpOBB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1QOge9cT6KnFGPRBF8RK8Gn4TkaKn/KP0//Yc0Rl7tHWIUXiN+wZyguBTGx2//e/9oFeLRseeaeZmrzTEraP3rKLsi2DMsm7/tv1/3JlVEeBh1/HMUiOjKKWcVVS3ZZCd/QHwsJUhadBR0TpPWcMyyTFJzeSM9OsXV59VckL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=ie6ND2Fk; arc=none smtp.client-ip=81.19.149.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JTN8vpCrxAyFl2EndvUMI8MWlG7TmKzwctciFXYx7HM=; b=ie6ND2FkVpX4HRLJx3sgGNFzLI
	wokHH9V2wuntos9GUXqIB2GIT/6nistpVpXzkoXuI7Yi79RzjADcIpzdqcIYGVB3rxdh/eSHQMdPH
	T4axOwGt06ATQh0ILHy+Y8/qAEQKU9WJI453Z3dreeGC6sh8QiQ3cdNI5o6uHKvvw1Bs=;
Received: from [188.22.4.212] (helo=[10.0.0.160])
	by mx03lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1uFHLB-000000004Zx-2ol1;
	Wed, 14 May 2025 21:00:30 +0200
Message-ID: <9fa06ba4-2052-460d-a9bd-8be7c06da6ad@engleder-embedded.com>
Date: Wed, 14 May 2025 21:00:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: lan743x: implement ndo_hwtstamp_get()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
 Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Richard Cochran <richardcochran@gmail.com>
References: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
 <20250514151931.1988047-2-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250514151931.1988047-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 14.05.25 17:19, Vladimir Oltean wrote:
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

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

