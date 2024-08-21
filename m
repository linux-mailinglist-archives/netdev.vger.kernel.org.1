Return-Path: <netdev+bounces-120553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 366AF959BE4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D2D1F215AD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA751169AE3;
	Wed, 21 Aug 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7WyhCRf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4DA1D12E1;
	Wed, 21 Aug 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243722; cv=none; b=WsO1BAN1cSxTS7hoswXgD5BBCFzuLsutW6B/Nh16wIYe6lNExyqAVxMhhOtiNM4GzUTpz22zbRJIwv6BhKgXael+BbhjTKdOQl8Ov98KIrsxf+OSDaJghvVDm4mrResEicpxtzvl0YitIS/1e5t/MDgS0BU6+i/B9aYGZrvgHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243722; c=relaxed/simple;
	bh=miv0rvFftW/AS9f1C/rBSx/gdO7CHhCC72/bDUY8++4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hU14cfG4hMbf6B1rdkncnY1g84e6OXGDoQoOkyU7b19o8gi+sdXbqLX/wZHW9GSYwb8/oICEscLgkZpoVDWIF3c594RMzzAFgritlxTExnEYO7oceRL+DE8mXJWk81lIhZaSQxIYHjV4pf7mHL2Qx+HihTczXxc1EU7XS5QoNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7WyhCRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3A3C32782;
	Wed, 21 Aug 2024 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724243722;
	bh=miv0rvFftW/AS9f1C/rBSx/gdO7CHhCC72/bDUY8++4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S7WyhCRfxCYSk5Wpi+qwpeZSUv7abt/E6Bgw8S8AeED2asGNEDlOkolg2KKsH3YNP
	 kidEPGwg2sKEy2nIKtdgiLq4a2YXO5puvuaZujadfp+w3UgKcJxz+2P/mREFg/Qfor
	 b8qC2PuBsnPruA2xFXM2I0ceZx+YE42xGggWvNEqBwIKxzSgYt2XgvY44PV/ny5svf
	 qV9BfLN9Tm6lgjgK+yDyKSoHM8DqRp4buk9Ij5P/4d8fSu4udKDDF36972yJ0Q0lhO
	 YYyIv6QcLjtPsffz5UO4D0rjNl/HZ4Ai33CjVMZRtqSdeRHzd5X4JSOk1vnFjzpus2
	 yI2erJDFNTtQA==
Message-ID: <03172556-8661-4804-8a3b-0252d91fdf46@kernel.org>
Date: Wed, 21 Aug 2024 15:35:14 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] net: ti: icssg-prueth: Add support for PA
 Stats
To: MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
 Sai Krishna <saikrishnag@marvell.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Diogo Ivo <diogo.ivo@siemens.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240820091657.4068304-1-danishanwar@ti.com>
 <20240820091657.4068304-3-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240820091657.4068304-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/08/2024 12:16, MD Danish Anwar wrote:
> Add support for dumping PA stats registers via ethtool.
> Firmware maintained stats are stored at PA Stats registers.
> Also modify emac_get_strings() API to use ethtool_puts().
> 
> This commit also renames the array icssg_all_stats to icssg_mii_g_rt_stats
> and creates a new array named icssg_all_pa_stats for PA Stats.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 19 ++++++-----
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 ++++
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  9 +++--
>  drivers/net/ethernet/ti/icssg/icssg_stats.c   | 31 ++++++++++++-----
>  drivers/net/ethernet/ti/icssg/icssg_stats.h   | 34 ++++++++++++++++++-
>  5 files changed, 78 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index 5688f054cec5..25832dcbada2 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -83,13 +83,11 @@ static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
>  
>  	switch (stringset) {
>  	case ETH_SS_STATS:
> -		for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
> -			if (!icssg_all_stats[i].standard_stats) {
> -				memcpy(p, icssg_all_stats[i].name,
> -				       ETH_GSTRING_LEN);
> -				p += ETH_GSTRING_LEN;
> -			}
> -		}
> +		for (i = 0; i < ARRAY_SIZE(icssg_mii_g_rt_stats); i++)
> +			if (!icssg_mii_g_rt_stats[i].standard_stats)
> +				ethtool_puts(&p, icssg_mii_g_rt_stats[i].name);
> +		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
> +			ethtool_puts(&p, icssg_all_pa_stats[i].name);
>  		break;
>  	default:
>  		break;
> @@ -104,9 +102,12 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
>  
>  	emac_update_hardware_stats(emac);
>  
> -	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++)
> -		if (!icssg_all_stats[i].standard_stats)
> +	for (i = 0; i < ARRAY_SIZE(icssg_mii_g_rt_stats); i++)
> +		if (!icssg_mii_g_rt_stats[i].standard_stats)
>  			*(data++) = emac->stats[i];
> +
> +	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
> +		*(data++) = emac->pa_stats[i];
>  }
>  
>  static int emac_get_ts_info(struct net_device *ndev,
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 53a3e44b99a2..f623a0f603fc 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1182,6 +1182,12 @@ static int prueth_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");
> +	if (IS_ERR(prueth->pa_stats)) {
> +		dev_err(dev, "couldn't get ti,pa-stats syscon regmap\n");
> +		return -ENODEV;
> +	}
> +
>  	if (eth0_node) {
>  		ret = prueth_get_cores(prueth, ICSS_SLICE0, false);
>  		if (ret)
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index f678d656a3ed..996f6f8a194c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -50,8 +50,10 @@
>  
>  #define ICSSG_MAX_RFLOWS	8	/* per slice */
>  
> +#define ICSSG_NUM_PA_STATS 4
> +#define ICSSG_NUM_MII_G_RT_STATS 60
>  /* Number of ICSSG related stats */
> -#define ICSSG_NUM_STATS 60
> +#define ICSSG_NUM_STATS (ICSSG_NUM_MII_G_RT_STATS + ICSSG_NUM_PA_STATS)
>  #define ICSSG_NUM_STANDARD_STATS 31
>  #define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS)
>  
> @@ -190,7 +192,8 @@ struct prueth_emac {
>  	int port_vlan;
>  
>  	struct delayed_work stats_work;
> -	u64 stats[ICSSG_NUM_STATS];
> +	u64 stats[ICSSG_NUM_MII_G_RT_STATS];
> +	u64 pa_stats[ICSSG_NUM_PA_STATS];
>  
>  	/* RX IRQ Coalescing Related */
>  	struct hrtimer rx_hrtimer;
> @@ -230,6 +233,7 @@ struct icssg_firmwares {
>   * @registered_netdevs: list of registered netdevs
>   * @miig_rt: regmap to mii_g_rt block
>   * @mii_rt: regmap to mii_rt block
> + * @pa_stats: regmap to pa_stats block
>   * @pru_id: ID for each of the PRUs
>   * @pdev: pointer to ICSSG platform device
>   * @pdata: pointer to platform data for ICSSG driver
> @@ -263,6 +267,7 @@ struct prueth {
>  	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
>  	struct regmap *miig_rt;
>  	struct regmap *mii_rt;
> +	struct regmap *pa_stats;
>  
>  	enum pruss_pru_id pru_id[PRUSS_NUM_PRUS];
>  	struct platform_device *pdev;
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> index 2fb150c13078..857bb956e935 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> @@ -11,6 +11,7 @@
>  
>  #define ICSSG_TX_PACKET_OFFSET	0xA0
>  #define ICSSG_TX_BYTE_OFFSET	0xEC
> +#define ICSSG_FW_STATS_BASE	0x0248
>  
>  static u32 stats_base[] = {	0x54c,	/* Slice 0 stats start */
>  				0xb18,	/* Slice 1 stats start */
> @@ -22,24 +23,31 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>  	int slice = prueth_emac_slice(emac);
>  	u32 base = stats_base[slice];
>  	u32 tx_pkt_cnt = 0;
> -	u32 val;
> +	u32 val, reg;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
> +	for (i = 0; i < ARRAY_SIZE(icssg_mii_g_rt_stats); i++) {
>  		regmap_read(prueth->miig_rt,
> -			    base + icssg_all_stats[i].offset,
> +			    base + icssg_mii_g_rt_stats[i].offset,
>  			    &val);
>  		regmap_write(prueth->miig_rt,
> -			     base + icssg_all_stats[i].offset,
> +			     base + icssg_mii_g_rt_stats[i].offset,
>  			     val);
>  
> -		if (icssg_all_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
> +		if (icssg_mii_g_rt_stats[i].offset == ICSSG_TX_PACKET_OFFSET)
>  			tx_pkt_cnt = val;
>  
>  		emac->stats[i] += val;
> -		if (icssg_all_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
> +		if (icssg_mii_g_rt_stats[i].offset == ICSSG_TX_BYTE_OFFSET)
>  			emac->stats[i] -= tx_pkt_cnt * 8;
>  	}
> +
> +	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
> +		reg = ICSSG_FW_STATS_BASE + icssg_all_pa_stats[i].offset *
> +		      PRUETH_NUM_MACS + slice * sizeof(u32);
> +		regmap_read(prueth->pa_stats, reg, &val);
> +		emac->pa_stats[i] += val;
> +	}
>  }
>  
>  void icssg_stats_work_handler(struct work_struct *work)
> @@ -57,9 +65,14 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(icssg_all_stats); i++) {
> -		if (!strcmp(icssg_all_stats[i].name, stat_name))
> -			return emac->stats[icssg_all_stats[i].offset / sizeof(u32)];
> +	for (i = 0; i < ARRAY_SIZE(icssg_mii_g_rt_stats); i++) {
> +		if (!strcmp(icssg_mii_g_rt_stats[i].name, stat_name))
> +			return emac->stats[icssg_mii_g_rt_stats[i].offset / sizeof(u32)];
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
> +		if (!strcmp(icssg_all_pa_stats[i].name, stat_name))
> +			return emac->pa_stats[icssg_all_pa_stats[i].offset / sizeof(u32)];
>  	}
>  
>  	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> index 999a4a91276c..2a1edbc55214 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> @@ -77,6 +77,20 @@ struct miig_stats_regs {
>  	u32 tx_bytes;
>  };
>  
> +/**
> + * struct pa_stats_regs - ICSSG Firmware maintained PA Stats register
> + * @fw_rx_cnt: Number of valid packets sent by Rx PRU to Host on PSI
> + * @fw_tx_cnt: Number of valid packets copied by RTU0 to Tx queues
> + * @fw_tx_pre_overflow: Host Egress Q (Pre-emptible) Overflow Counter
> + * @fw_tx_exp_overflow: Host Egress Q (Express) Overflow Counter
> + */
> +struct pa_stats_regs {
> +	u32 fw_rx_cnt;
> +	u32 fw_tx_cnt;
> +	u32 fw_tx_pre_overflow;
> +	u32 fw_tx_exp_overflow;
> +};
> +
>  #define ICSSG_STATS(field, stats_type)			\
>  {							\
>  	#field,						\
> @@ -84,13 +98,24 @@ struct miig_stats_regs {
>  	stats_type					\
>  }
>  
> +#define ICSSG_PA_STATS(field)			\
> +{						\
> +	#field,					\
> +	offsetof(struct pa_stats_regs, field),	\
> +}
> +
>  struct icssg_stats {

icssg_mii_stats?

>  	char name[ETH_GSTRING_LEN];
>  	u32 offset;
>  	bool standard_stats;
>  };
>  
> -static const struct icssg_stats icssg_all_stats[] = {
> +struct icssg_pa_stats {
> +	char name[ETH_GSTRING_LEN];
> +	u32 offset;
> +};
> +
> +static const struct icssg_stats icssg_mii_g_rt_stats[] = {

icssg_all_mii_stats? to be consistend with the newly added
icssg_pa_stats and icssg_all_pa_stats.

Could you please group all mii_stats data strucutres and arrays together
followed by pa_stats data structures and arrays?

>  	/* Rx */
>  	ICSSG_STATS(rx_packets, true),
>  	ICSSG_STATS(rx_broadcast_frames, false),
> @@ -155,4 +180,11 @@ static const struct icssg_stats icssg_all_stats[] = {
>  	ICSSG_STATS(tx_bytes, true),t
>  };
>  
> +static const struct icssg_pa_stats icssg_all_pa_stats[] = > +	ICSSG_PA_STATS(fw_rx_cnt),
> +	ICSSG_PA_STATS(fw_tx_cnt),
> +	ICSSG_PA_STATS(fw_tx_pre_overflow),
> +	ICSSG_PA_STATS(fw_tx_exp_overflow),
> +};
> +
>  #endif /* __NET_TI_ICSSG_STATS_H */

-- 
cheers,
-roger

