Return-Path: <netdev+bounces-230984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F17BF2DB6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 20:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 629973431B8
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5628D2C0F9A;
	Mon, 20 Oct 2025 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="NqPflI/R"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B01223EAA3
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983585; cv=none; b=XRLJD3a2EfR5q91oSzl9B/YOOxUXAersS9Uh01aLZKPdKiHs4QaB7yKdLrXWSQZKC6cHNfOv44rhOgPwhWDp28iw0c5UvllrGkNMW5Iy98MFh0itsZgD0l1mfnPkwp4O+0ErPcQ2Fe0ehVA9O0T90/TWnw8VTCzS+8pgu1oMSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983585; c=relaxed/simple;
	bh=WAlMIgrQ7t80hoyRpcsbnfZLZg438On56BgfzKPGOaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFTfye3miWykrKrOj57tYA3KvyOIchAL+8uLTra/MzdMB636Ah9UEnTvQw4C28hFw3lbuKbiYEy6J3A4y55d0WL8NYn/25eXS93ka/g168txgeoDEdbu/4HWC07JMGlKh39MgLMzh2mzXKlFUTwIBlbfh/z4k3MuciPo1PXRMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=NqPflI/R; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VdvoJ+VQpvGn4l9EKA6cn39ZuSmZrHLUMjICO3n7SGI=; b=NqPflI/RW+XWcPm21WIyYfCnmw
	fLQ2cvJbnOrQ78v9woYGxRTjahyg7jICqJxDC6q/+vOdxzmhIiWg/sxOuBr7lr2PnCs0vEuH1EtqV
	L18uyiFoZaRX7np30hDtaY6+5kkcznXCaOP2QcOmby5ukqCa2mGk7Z+1dZ0rQ2GKgH8g=;
Received: from [178.191.104.35] (helo=[10.0.0.160])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vAu35-000000004l5-1Yzg;
	Mon, 20 Oct 2025 19:51:59 +0200
Message-ID: <375eed92-0f76-4df1-9837-2c29208417fa@engleder-embedded.com>
Date: Mon, 20 Oct 2025 19:51:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 6/7] tsnep: convert to ndo_hwtstatmp API
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
 <20251016152515.3510991-7-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20251016152515.3510991-7-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 16.10.25 17:25, Vadim Fedorenko wrote:
> Convert to .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> After conversions the rest of tsnep_netdev_ioctl() becomes pure
> phy_do_ioctl_running(), so remove tsnep_netdev_ioctl() and replace
> it with phy_do_ioctl_running() in .ndo_eth_ioctl.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>   drivers/net/ethernet/engleder/tsnep.h      |  8 +-
>   drivers/net/ethernet/engleder/tsnep_main.c | 14 +---
>   drivers/net/ethernet/engleder/tsnep_ptp.c  | 88 +++++++++++-----------
>   3 files changed, 51 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ethernet/engleder/tsnep.h
> index f188fba021a6..03e19aea9ea4 100644
> --- a/drivers/net/ethernet/engleder/tsnep.h
> +++ b/drivers/net/ethernet/engleder/tsnep.h
> @@ -176,7 +176,7 @@ struct tsnep_adapter {
>   	struct tsnep_gcl gcl[2];
>   	int next_gcl;
>   
> -	struct hwtstamp_config hwtstamp_config;
> +	struct kernel_hwtstamp_config hwtstamp_config;
>   	struct ptp_clock *ptp_clock;
>   	struct ptp_clock_info ptp_clock_info;
>   	/* ptp clock lock */
> @@ -203,7 +203,11 @@ extern const struct ethtool_ops tsnep_ethtool_ops;
>   
>   int tsnep_ptp_init(struct tsnep_adapter *adapter);
>   void tsnep_ptp_cleanup(struct tsnep_adapter *adapter);
> -int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
> +int tsnep_ptp_hwtstamp_get(struct net_device *netdev,
> +			   struct kernel_hwtstamp_config *config);
> +int tsnep_ptp_hwtstamp_set(struct net_device *netdev,
> +			   struct kernel_hwtstamp_config *config,
> +			   struct netlink_ext_ack *extack);
>   
>   int tsnep_tc_init(struct tsnep_adapter *adapter);
>   void tsnep_tc_cleanup(struct tsnep_adapter *adapter);
> diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
> index eba73246f986..b118407c30e8 100644
> --- a/drivers/net/ethernet/engleder/tsnep_main.c
> +++ b/drivers/net/ethernet/engleder/tsnep_main.c
> @@ -2168,16 +2168,6 @@ static netdev_tx_t tsnep_netdev_xmit_frame(struct sk_buff *skb,
>   	return tsnep_xmit_frame_ring(skb, &adapter->tx[queue_mapping]);
>   }
>   
> -static int tsnep_netdev_ioctl(struct net_device *netdev, struct ifreq *ifr,
> -			      int cmd)
> -{
> -	if (!netif_running(netdev))
> -		return -EINVAL;
> -	if (cmd == SIOCSHWTSTAMP || cmd == SIOCGHWTSTAMP)
> -		return tsnep_ptp_ioctl(netdev, ifr, cmd);
> -	return phy_mii_ioctl(netdev->phydev, ifr, cmd);
> -}
> -
>   static void tsnep_netdev_set_multicast(struct net_device *netdev)
>   {
>   	struct tsnep_adapter *adapter = netdev_priv(netdev);
> @@ -2384,7 +2374,7 @@ static const struct net_device_ops tsnep_netdev_ops = {
>   	.ndo_open = tsnep_netdev_open,
>   	.ndo_stop = tsnep_netdev_close,
>   	.ndo_start_xmit = tsnep_netdev_xmit_frame,
> -	.ndo_eth_ioctl = tsnep_netdev_ioctl,
> +	.ndo_eth_ioctl = phy_do_ioctl_running,
>   	.ndo_set_rx_mode = tsnep_netdev_set_multicast,
>   	.ndo_get_stats64 = tsnep_netdev_get_stats64,
>   	.ndo_set_mac_address = tsnep_netdev_set_mac_address,
> @@ -2394,6 +2384,8 @@ static const struct net_device_ops tsnep_netdev_ops = {
>   	.ndo_bpf = tsnep_netdev_bpf,
>   	.ndo_xdp_xmit = tsnep_netdev_xdp_xmit,
>   	.ndo_xsk_wakeup = tsnep_netdev_xsk_wakeup,
> +	.ndo_hwtstamp_get = tsnep_ptp_hwtstamp_get,
> +	.ndo_hwtstamp_set = tsnep_ptp_hwtstamp_set,
>   };
>   
>   static int tsnep_mac_init(struct tsnep_adapter *adapter)
> diff --git a/drivers/net/ethernet/engleder/tsnep_ptp.c b/drivers/net/ethernet/engleder/tsnep_ptp.c
> index 54fbf0126815..ae1308eb813d 100644
> --- a/drivers/net/ethernet/engleder/tsnep_ptp.c
> +++ b/drivers/net/ethernet/engleder/tsnep_ptp.c
> @@ -19,57 +19,53 @@ void tsnep_get_system_time(struct tsnep_adapter *adapter, u64 *time)
>   	*time = (((u64)high) << 32) | ((u64)low);
>   }
>   
> -int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
> +int tsnep_ptp_hwtstamp_get(struct net_device *netdev,
> +			   struct kernel_hwtstamp_config *config)
>   {
>   	struct tsnep_adapter *adapter = netdev_priv(netdev);
> -	struct hwtstamp_config config;
> -
> -	if (!ifr)
> -		return -EINVAL;
> -
> -	if (cmd == SIOCSHWTSTAMP) {
> -		if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
> -			return -EFAULT;
> -
> -		switch (config.tx_type) {
> -		case HWTSTAMP_TX_OFF:
> -		case HWTSTAMP_TX_ON:
> -			break;
> -		default:
> -			return -ERANGE;
> -		}
> -
> -		switch (config.rx_filter) {
> -		case HWTSTAMP_FILTER_NONE:
> -			break;
> -		case HWTSTAMP_FILTER_ALL:
> -		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> -		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> -		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> -		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> -		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> -		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> -		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> -		case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> -		case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> -		case HWTSTAMP_FILTER_PTP_V2_EVENT:
> -		case HWTSTAMP_FILTER_PTP_V2_SYNC:
> -		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> -		case HWTSTAMP_FILTER_NTP_ALL:
> -			config.rx_filter = HWTSTAMP_FILTER_ALL;
> -			break;
> -		default:
> -			return -ERANGE;
> -		}
> -
> -		memcpy(&adapter->hwtstamp_config, &config,
> -		       sizeof(adapter->hwtstamp_config));
> +
> +	*config = adapter->hwtstamp_config;
> +	return 0;
> +}
> +
> +int tsnep_ptp_hwtstamp_set(struct net_device *netdev,
> +			   struct kernel_hwtstamp_config *config,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct tsnep_adapter *adapter = netdev_priv(netdev);
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +	case HWTSTAMP_TX_ON:
> +		break;
> +	default:
> +		return -ERANGE;
>   	}
>   
> -	if (copy_to_user(ifr->ifr_data, &adapter->hwtstamp_config,
> -			 sizeof(adapter->hwtstamp_config)))
> -		return -EFAULT;
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		break;
> +	case HWTSTAMP_FILTER_ALL:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +		config->rx_filter = HWTSTAMP_FILTER_ALL;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
>   
> +	adapter->hwtstamp_config = *config;
>   	return 0;
>   }

As you were first, I skip my patch.

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

