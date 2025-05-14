Return-Path: <netdev+bounces-190524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5275AB74E1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8BF8C0CEF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096B2741A0;
	Wed, 14 May 2025 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="rkt4IabT"
X-Original-To: netdev@vger.kernel.org
Received: from mx03lb.world4you.com (mx03lb.world4you.com [81.19.149.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160C170A0B
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249068; cv=none; b=kEPyw4Rcm/nsHrScIhpxjlmodpLL2WcCCp+33NoKbnrCJiDgzVaD4BrV0bN5uToUeyaoQsbkpt6nHEGwzakv4/od+5rRaMV8SV6V9Ec00VvEuAg5SQpXf++KQvrEV6xgCarTFNsikdAKtcXMkkIuXJUwNBo4Dr+6oa6DDxFa+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249068; c=relaxed/simple;
	bh=4ZGBgUBMamA6AxzuZHfaWdWtTMot9l1KGjLu2jlOu7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGTio+72IHpqyhlfFSACCmpNeoDSjKC6LPrR6tRChB7dwgD6/0cUJlFkahHdVCbxvSU8mCwhRHQgh1svouUAnuXsZpDTgBwF5sFiWCWj7e9g6XpE7LGystDPV8bjooqn9f4I/Rb+xPodYHhGsTBwCUWzGHY/IeCTqMDjvg2KpP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=rkt4IabT; arc=none smtp.client-ip=81.19.149.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N3AjWrnkG7GKsH/DjxSH3YcuuNmeypPGbzTe5tGoRuI=; b=rkt4IabTuuQPZCKg1E9jf1uWBf
	NzpGB98fnLJwZj31rPKjO6LkKAsN0Ok4dRdisx5minTe7i7W56S5/i37qZGJsE7iy7z0WgZf1k6GL
	bIi4UwDf1B8oH3FJWq25W/MKuXRN/nCAlxyaMAx6tISsIf4jJi32A2+H4vrwUShWWHMI=;
Received: from [188.22.4.212] (helo=[10.0.0.160])
	by mx03lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1uFHIN-0000000044U-1z21;
	Wed, 14 May 2025 20:57:35 +0200
Message-ID: <8cee65f7-32f3-4545-a119-52db44fb8c56@engleder-embedded.com>
Date: Wed, 14 May 2025 20:57:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: lan743x: convert to ndo_hwtstamp_set()
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
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 14.05.25 17:19, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the lan743x driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl()
> path completely.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   drivers/net/ethernet/microchip/lan743x_main.c |  3 +-
>   drivers/net/ethernet/microchip/lan743x_ptp.c  | 32 +++++--------------
>   drivers/net/ethernet/microchip/lan743x_ptp.h  |  4 ++-
>   3 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 73dfc85fa67e..b01695bf4f55 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3351,8 +3351,6 @@ static int lan743x_netdev_ioctl(struct net_device *netdev,
>   
>   	if (!netif_running(netdev))
>   		return -EINVAL;
> -	if (cmd == SIOCSHWTSTAMP)
> -		return lan743x_ptp_ioctl(netdev, ifr, cmd);
>   
>   	return phylink_mii_ioctl(adapter->phylink, ifr, cmd);
>   }
> @@ -3447,6 +3445,7 @@ static const struct net_device_ops lan743x_netdev_ops = {
>   	.ndo_change_mtu		= lan743x_netdev_change_mtu,
>   	.ndo_get_stats64	= lan743x_netdev_get_stats64,
>   	.ndo_set_mac_address	= lan743x_netdev_set_mac_address,
> +	.ndo_hwtstamp_set	= lan743x_ptp_hwtstamp_set,
>   };
>   
>   static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
> index b07f5b099a2b..026d1660fd74 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ptp.c
> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
> @@ -1736,23 +1736,14 @@ void lan743x_ptp_tx_timestamp_skb(struct lan743x_adapter *adapter,
>   	lan743x_ptp_tx_ts_complete(adapter);
>   }
>   
> -int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> +int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
> +			     struct kernel_hwtstamp_config *config,
> +			     struct netlink_ext_ack *extack)
>   {
>   	struct lan743x_adapter *adapter = netdev_priv(netdev);
> -	struct hwtstamp_config config;
> -	int ret = 0;
>   	int index;
>   
> -	if (!ifr) {
> -		netif_err(adapter, drv, adapter->netdev,
> -			  "SIOCSHWTSTAMP, ifr == NULL\n");
> -		return -EINVAL;
> -	}
> -
> -	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
> -		return -EFAULT;
> -
> -	switch (config.tx_type) {
> +	switch (config->tx_type) {
>   	case HWTSTAMP_TX_OFF:
>   		for (index = 0; index < adapter->used_tx_channels;
>   		     index++)
> @@ -1776,19 +1767,12 @@ int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
>   		lan743x_ptp_set_sync_ts_insert(adapter, true);
>   		break;
>   	case HWTSTAMP_TX_ONESTEP_P2P:
> -		ret = -ERANGE;
> -		break;
> +		return -ERANGE;
>   	default:
>   		netif_warn(adapter, drv, adapter->netdev,
> -			   "  tx_type = %d, UNKNOWN\n", config.tx_type);
> -		ret = -EINVAL;
> -		break;
> +			   "  tx_type = %d, UNKNOWN\n", config->tx_type);
> +		return -EINVAL;
>   	}
>   
> -	ret = lan743x_rx_set_tstamp_mode(adapter, config.rx_filter);
> -
> -	if (!ret)
> -		return copy_to_user(ifr->ifr_data, &config,
> -			sizeof(config)) ? -EFAULT : 0;
> -	return ret;
> +	return lan743x_rx_set_tstamp_mode(adapter, config->rx_filter);
>   }
> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
> index 0d29914cd460..9581a7992ff6 100644
> --- a/drivers/net/ethernet/microchip/lan743x_ptp.h
> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
> @@ -52,7 +52,9 @@ void lan743x_ptp_close(struct lan743x_adapter *adapter);
>   void lan743x_ptp_update_latency(struct lan743x_adapter *adapter,
>   				u32 link_speed);
>   
> -int lan743x_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
> +int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
> +			     struct kernel_hwtstamp_config *config,
> +			     struct netlink_ext_ack *extack);
>   
>   #define LAN743X_PTP_NUMBER_OF_TX_TIMESTAMPS (4)

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

