Return-Path: <netdev+bounces-189794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87999AB3CB0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19D13ADAEC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AC423909F;
	Mon, 12 May 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jky+qgtE"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B0B66E
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065047; cv=none; b=Zj9mGNV1rOT4oNQuQP8jqOJdRsXD8MaUxYXP6EmFe2f3p4s0oI898YkKj76prmAzbR7+tY93cYQEg9nJCNibacuvasK1qYm8oWx4IPhaymXql5Yn0DuRP/ez6t5BQx1Mmibghyw0977HQqbMCuDiBbPU1RD1alBxGs8qvPt+KV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065047; c=relaxed/simple;
	bh=Y6TkNyu3mtMNzRn8iFTRi4QFPcfBCrtYps+ap36MTC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noMUQB5SUc/5c8RzlOdGnyyu8p/0a+6wIGlxAEn3azbHc7pilampfXHKXM83mprywMEh6C6swuq45xKlbJlJQDehZcNH/g0R6ziyYbu3Vw1erdiEe2XH4q0q+erA0Rk72h2g1miOg7PmeZnoSIqSzRtHghr3qgRExy4ZpSoRWqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jky+qgtE; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ca5f592-74d3-41ff-8282-4359cb5ec171@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747065042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T6MXrnT3gf4UCix4NRHlqZt6S+pEnfTMsanMdKfJUb8=;
	b=jky+qgtETsFb0biTW/1lR9LNg39rCYhPgORR6TnNYv4JuW/iyHLT3hSsmBwFCXNEYk+YPH
	wQ6Ense3mid4zlO4UAPyAPWAU6XKuNVFxljw6h5ZZTx5zj+HOHaSMWR+7l0Q1nN43lUoZr
	rthZf0zrQvIMq1CkLxUeovin6kWcx+k=
Date: Mon, 12 May 2025 16:50:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: stmmac: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Furong Xu <0x1207@gmail.com>
References: <20250512143607.595490-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250512143607.595490-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/05/2025 15:36, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the stmmac driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.

The conversion to the new API looks good, but stmmac_ioctl() isn't
removed keeping ndo_eth_ioctl() path in place. Did I miss something in
the patch?

> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +-
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 80 +++++++++----------
>   2 files changed, 37 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 1686e559f66e..cda09cf5dcca 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -301,7 +301,7 @@ struct stmmac_priv {
>   	unsigned int mode;
>   	unsigned int chain_mode;
>   	int extend_desc;
> -	struct hwtstamp_config tstamp_config;
> +	struct kernel_hwtstamp_config tstamp_config;
>   	struct ptp_clock *ptp_clock;
>   	struct ptp_clock_info ptp_clock_ops;
>   	unsigned int default_addend;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a19b6f940bf3..c090247d2a29 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -568,18 +568,19 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
>   /**
>    *  stmmac_hwtstamp_set - control hardware timestamping.
>    *  @dev: device pointer.
> - *  @ifr: An IOCTL specific structure, that can contain a pointer to
> - *  a proprietary structure used to pass information to the driver.
> + *  @config: the timestamping configuration.
> + *  @extack: netlink extended ack structure for error reporting.
>    *  Description:
>    *  This function configures the MAC to enable/disable both outgoing(TX)
>    *  and incoming(RX) packets time stamping based on user input.
>    *  Return Value:
>    *  0 on success and an appropriate -ve integer on failure.
>    */
> -static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
> +static int stmmac_hwtstamp_set(struct net_device *dev,
> +			       struct kernel_hwtstamp_config *config,
> +			       struct netlink_ext_ack *extack)
>   {
>   	struct stmmac_priv *priv = netdev_priv(dev);
> -	struct hwtstamp_config config;
>   	u32 ptp_v2 = 0;
>   	u32 tstamp_all = 0;
>   	u32 ptp_over_ipv4_udp = 0;
> @@ -590,34 +591,30 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   	u32 ts_event_en = 0;
>   
>   	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
> -		netdev_alert(priv->dev, "No support for HW time stamping\n");
> +		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping\n");
>   		priv->hwts_tx_en = 0;
>   		priv->hwts_rx_en = 0;
>   
>   		return -EOPNOTSUPP;
>   	}
>   
> -	if (copy_from_user(&config, ifr->ifr_data,
> -			   sizeof(config)))
> -		return -EFAULT;
> -
>   	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
> -		   __func__, config.flags, config.tx_type, config.rx_filter);
> +		   __func__, config->flags, config->tx_type, config->rx_filter);
>   
> -	if (config.tx_type != HWTSTAMP_TX_OFF &&
> -	    config.tx_type != HWTSTAMP_TX_ON)
> +	if (config->tx_type != HWTSTAMP_TX_OFF &&
> +	    config->tx_type != HWTSTAMP_TX_ON)
>   		return -ERANGE;
>   
>   	if (priv->adv_ts) {
> -		switch (config.rx_filter) {
> +		switch (config->rx_filter) {
>   		case HWTSTAMP_FILTER_NONE:
>   			/* time stamp no incoming packet at all */
> -			config.rx_filter = HWTSTAMP_FILTER_NONE;
> +			config->rx_filter = HWTSTAMP_FILTER_NONE;
>   			break;
>   
>   		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>   			/* PTP v1, UDP, any kind of event packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>   			/* 'xmac' hardware can support Sync, Pdelay_Req and
>   			 * Pdelay_resp by setting bit14 and bits17/16 to 01
>   			 * This leaves Delay_Req timestamps out.
> @@ -631,7 +628,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   
>   		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>   			/* PTP v1, UDP, Sync packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
>   			/* take time stamp for SYNC messages only */
>   			ts_event_en = PTP_TCR_TSEVNTENA;
>   
> @@ -641,7 +638,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   
>   		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>   			/* PTP v1, UDP, Delay_req packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
>   			/* take time stamp for Delay_Req messages only */
>   			ts_master_en = PTP_TCR_TSMSTRENA;
>   			ts_event_en = PTP_TCR_TSEVNTENA;
> @@ -652,7 +649,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   
>   		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>   			/* PTP v2, UDP, any kind of event packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
>   			ptp_v2 = PTP_TCR_TSVER2ENA;
>   			/* take time stamp for all event messages */
>   			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
> @@ -663,7 +660,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   
>   		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>   			/* PTP v2, UDP, Sync packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
>   			ptp_v2 = PTP_TCR_TSVER2ENA;
>   			/* take time stamp for SYNC messages only */
>   			ts_event_en = PTP_TCR_TSEVNTENA;
> @@ -674,7 +671,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   
>   		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>   			/* PTP v2, UDP, Delay_req packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
>   			ptp_v2 = PTP_TCR_TSVER2ENA;
>   			/* take time stamp for Delay_Req messages only */
>   			ts_master_en = PTP_TCR_TSMSTRENA;
> @@ -686,7 +683,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   
>   		case HWTSTAMP_FILTER_PTP_V2_EVENT:
>   			/* PTP v2/802.AS1 any layer, any kind of event packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>   			ptp_v2 = PTP_TCR_TSVER2ENA;
>   			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
>   			if (priv->synopsys_id < DWMAC_CORE_4_10)
> @@ -698,7 +695,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   
>   		case HWTSTAMP_FILTER_PTP_V2_SYNC:
>   			/* PTP v2/802.AS1, any layer, Sync packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
>   			ptp_v2 = PTP_TCR_TSVER2ENA;
>   			/* take time stamp for SYNC messages only */
>   			ts_event_en = PTP_TCR_TSEVNTENA;
> @@ -710,7 +707,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   
>   		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>   			/* PTP v2/802.AS1, any layer, Delay_req packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
>   			ptp_v2 = PTP_TCR_TSVER2ENA;
>   			/* take time stamp for Delay_Req messages only */
>   			ts_master_en = PTP_TCR_TSMSTRENA;
> @@ -724,7 +721,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   		case HWTSTAMP_FILTER_NTP_ALL:
>   		case HWTSTAMP_FILTER_ALL:
>   			/* time stamp any incoming packet */
> -			config.rx_filter = HWTSTAMP_FILTER_ALL;
> +			config->rx_filter = HWTSTAMP_FILTER_ALL;
>   			tstamp_all = PTP_TCR_TSENALL;
>   			break;
>   
> @@ -732,18 +729,18 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   			return -ERANGE;
>   		}
>   	} else {
> -		switch (config.rx_filter) {
> +		switch (config->rx_filter) {
>   		case HWTSTAMP_FILTER_NONE:
> -			config.rx_filter = HWTSTAMP_FILTER_NONE;
> +			config->rx_filter = HWTSTAMP_FILTER_NONE;
>   			break;
>   		default:
>   			/* PTP v1, UDP, any kind of event packet */
> -			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
> +			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>   			break;
>   		}
>   	}
> -	priv->hwts_rx_en = ((config.rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
> -	priv->hwts_tx_en = config.tx_type == HWTSTAMP_TX_ON;
> +	priv->hwts_rx_en = config->rx_filter != HWTSTAMP_FILTER_NONE;
> +	priv->hwts_tx_en = config->tx_type == HWTSTAMP_TX_ON;
>   
>   	priv->systime_flags = STMMAC_HWTS_ACTIVE;
>   
> @@ -756,31 +753,30 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>   
>   	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
>   
> -	memcpy(&priv->tstamp_config, &config, sizeof(config));
> +	priv->tstamp_config = *config;
>   
> -	return copy_to_user(ifr->ifr_data, &config,
> -			    sizeof(config)) ? -EFAULT : 0;
> +	return 0;
>   }
>   
>   /**
>    *  stmmac_hwtstamp_get - read hardware timestamping.
>    *  @dev: device pointer.
> - *  @ifr: An IOCTL specific structure, that can contain a pointer to
> - *  a proprietary structure used to pass information to the driver.
> + *  @config: the timestamping configuration.
>    *  Description:
>    *  This function obtain the current hardware timestamping settings
>    *  as requested.
>    */
> -static int stmmac_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
> +static int stmmac_hwtstamp_get(struct net_device *dev,
> +			       struct kernel_hwtstamp_config *config)
>   {
>   	struct stmmac_priv *priv = netdev_priv(dev);
> -	struct hwtstamp_config *config = &priv->tstamp_config;
>   
>   	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
>   		return -EOPNOTSUPP;
>   
> -	return copy_to_user(ifr->ifr_data, config,
> -			    sizeof(*config)) ? -EFAULT : 0;
> +	*config = priv->tstamp_config;
> +
> +	return 0;
>   }
>   
>   /**
> @@ -6228,12 +6224,6 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>   	case SIOCSMIIREG:
>   		ret = phylink_mii_ioctl(priv->phylink, rq, cmd);
>   		break;
> -	case SIOCSHWTSTAMP:
> -		ret = stmmac_hwtstamp_set(dev, rq);
> -		break;
> -	case SIOCGHWTSTAMP:
> -		ret = stmmac_hwtstamp_get(dev, rq);
> -		break;
>   	default:
>   		break;
>   	}
> @@ -7172,6 +7162,8 @@ static const struct net_device_ops stmmac_netdev_ops = {
>   	.ndo_bpf = stmmac_bpf,
>   	.ndo_xdp_xmit = stmmac_xdp_xmit,
>   	.ndo_xsk_wakeup = stmmac_xsk_wakeup,
> +	.ndo_hwtstamp_get = stmmac_hwtstamp_get,
> +	.ndo_hwtstamp_set = stmmac_hwtstamp_set,
>   };
>   
>   static void stmmac_reset_subtask(struct stmmac_priv *priv)


