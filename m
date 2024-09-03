Return-Path: <netdev+bounces-124579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94496A0D2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F661C23A5E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4113DB88;
	Tue,  3 Sep 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JqkczsQG"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8EC13D518
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374350; cv=none; b=ie2JhKURp7TF9IBLkYnPj2t+PeUVea+bIbodljkXCtTn3NzxlJTIg3jodtdE1e9DZCXl8C0OZ/HJbm/F0MwYdjhFCqu2G9OyuCTHREkWZSNCvpFAa/y/1ZZpbwTdvOKe4nPc6TJN+E0edc9J5zgwpD+Kv0d6bYyJqWd1F1051gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374350; c=relaxed/simple;
	bh=44w1IX3u8LuVDi4NIPG1lAuTn2VAjG8l0kWJQFZoye8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoG5Wv2Yk7rcd2VU09zczMhX0jB+GPVgfaF8WAwfp2Iluh5hEgGomaToxe5pIOAwMHWH0bGkRdko0z3vr9s/n9ShHQU4z9NCMAXw1LJE1/1OGR3AJeK9TBRsUtLTkUO/DUY8aH09HYXwpmCdxWLJtiYk8xIrq9xxjeQobXpTlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JqkczsQG; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a1d76ee-e0ad-4cd5-8f8f-0c832f09d8f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725374346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIlr93GdVPxh2X81EK/1tz0S97nhi/B3ebhaysT26oM=;
	b=JqkczsQG7Xj2JAPe9I8r6ZCG7N13w33bessrqrPhMKhjSQesa5Tvo0PnPf52KGS0DrGm0b
	d0AYm1PbDgmC5myhmAe6UxVj7DsPhSG3VAC9quVTCyd1XkRZ3RZxEEUr0ogWWL+erqg/6i
	YiWOSJG3WkfBYs80eKHhQoH1om1R95w=
Date: Tue, 3 Sep 2024 15:39:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: enetc: Replace ifdef with IS_ENABLED
To: Martyn Welch <martyn.welch@collabora.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240903140420.2150707-1-martyn.welch@collabora.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240903140420.2150707-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/09/2024 15:04, Martyn Welch wrote:
> The enetc driver uses ifdefs when checking whether
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
> if the driver is compiled in but fails if the driver is available as a
> kernel module. Replace the instances of ifdef with use of the IS_ENABLED
> macro, that will evaluate as true when this feature is built as a kernel
> module and follows the kernel's coding style.
> 
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
> Changes since v1:
>    - Switched from preprocessor conditionals to normal C conditionals.
> 
>   drivers/net/ethernet/freescale/enetc/enetc.c  | 34 ++++++++---------
>   drivers/net/ethernet/freescale/enetc/enetc.h  |  9 ++---
>   .../ethernet/freescale/enetc/enetc_ethtool.c  | 37 ++++++++++---------
>   3 files changed, 38 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 5c45f42232d3..361464a5b6c4 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -977,10 +977,9 @@ static int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
>   	return j;
>   }
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> -static void enetc_get_rx_tstamp(struct net_device *ndev,
> -				union enetc_rx_bd *rxbd,
> -				struct sk_buff *skb)
> +static void __maybe_unused enetc_get_rx_tstamp(struct net_device *ndev,
> +					       union enetc_rx_bd *rxbd,
> +					       struct sk_buff *skb)
>   {
>   	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
>   	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> @@ -1001,7 +1000,6 @@ static void enetc_get_rx_tstamp(struct net_device *ndev,
>   		shhwtstamps->hwtstamp = ns_to_ktime(tstamp);
>   	}
>   }
> -#endif
>   
>   static void enetc_get_offloads(struct enetc_bdr *rx_ring,
>   			       union enetc_rx_bd *rxbd, struct sk_buff *skb)
> @@ -1041,10 +1039,9 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
>   		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
>   	}
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> -	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
> +	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
> +	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
>   		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
> -#endif
>   }
>   
>   /* This gets called during the non-XDP NAPI poll cycle as well as on XDP_PASS,
> @@ -2882,8 +2879,8 @@ void enetc_set_features(struct net_device *ndev, netdev_features_t features)
>   }
>   EXPORT_SYMBOL_GPL(enetc_set_features);
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> -static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
> +static int __maybe_unused enetc_hwtstamp_set(struct net_device *ndev,
> +					     struct ifreq *ifr)
>   {
>   	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>   	int err, new_offloads = priv->active_offloads;
> @@ -2931,7 +2928,8 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
>   	       -EFAULT : 0;
>   }
>   
> -static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
> +static int __maybe_unused enetc_hwtstamp_get(struct net_device *ndev,
> +					     struct ifreq *ifr)
>   {
>   	struct enetc_ndev_priv *priv = netdev_priv(ndev);
>   	struct hwtstamp_config config;
> @@ -2951,17 +2949,17 @@ static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
>   	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
>   	       -EFAULT : 0;
>   }
> -#endif
>   
>   int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
>   {
>   	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> -	if (cmd == SIOCSHWTSTAMP)
> -		return enetc_hwtstamp_set(ndev, rq);
> -	if (cmd == SIOCGHWTSTAMP)
> -		return enetc_hwtstamp_get(ndev, rq);
> -#endif
> +
> +	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> +		if (cmd == SIOCSHWTSTAMP)
> +			return enetc_hwtstamp_set(ndev, rq);
> +		if (cmd == SIOCGHWTSTAMP)
> +			return enetc_hwtstamp_get(ndev, rq);
> +	}
>   
>   	if (!priv->phylink)
>   		return -EOPNOTSUPP;
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index a9c2ff22431c..97524dfa234c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -184,10 +184,9 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
>   {
>   	int hw_idx = i;
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> -	if (rx_ring->ext_en)
> +	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
>   		hw_idx = 2 * i;
> -#endif
> +
>   	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
>   }
>   
> @@ -199,10 +198,8 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
>   
>   	new_rxbd++;
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> -	if (rx_ring->ext_en)
> +	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
>   		new_rxbd++;
> -#endif
>   
>   	if (unlikely(++new_index == rx_ring->bd_count)) {
>   		new_rxbd = rx_ring->bd_base;
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 5e684b23c5f5..a9402c1907bf 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -853,24 +853,25 @@ static int enetc_get_ts_info(struct net_device *ndev,
>   		info->phc_index = -1;
>   	}
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> -	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> -				SOF_TIMESTAMPING_RX_HARDWARE |
> -				SOF_TIMESTAMPING_RAW_HARDWARE |
> -				SOF_TIMESTAMPING_TX_SOFTWARE |
> -				SOF_TIMESTAMPING_RX_SOFTWARE |
> -				SOF_TIMESTAMPING_SOFTWARE;
> -
> -	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
> -			 (1 << HWTSTAMP_TX_ON) |
> -			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
> -	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
> -			   (1 << HWTSTAMP_FILTER_ALL);
> -#else
> -	info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
> -				SOF_TIMESTAMPING_TX_SOFTWARE |
> -				SOF_TIMESTAMPING_SOFTWARE;
> -#endif
> +	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> +		info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
> +					SOF_TIMESTAMPING_RX_HARDWARE |
> +					SOF_TIMESTAMPING_RAW_HARDWARE |
> +					SOF_TIMESTAMPING_TX_SOFTWARE |
> +					SOF_TIMESTAMPING_RX_SOFTWARE |
> +					SOF_TIMESTAMPING_SOFTWARE;
> +
> +		info->tx_types = (1 << HWTSTAMP_TX_OFF) |
> +				 (1 << HWTSTAMP_TX_ON) |
> +				 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
> +		info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
> +				   (1 << HWTSTAMP_FILTER_ALL);
> +	} else {
> +		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
> +					SOF_TIMESTAMPING_TX_SOFTWARE |
> +					SOF_TIMESTAMPING_SOFTWARE;
> +	}
> +
>   	return 0;
>   }
>   

LGTM! You still need ack/review from driver's maintainers, but:

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

