Return-Path: <netdev+bounces-123692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762B9662E3
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9331C20B91
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CDF199952;
	Fri, 30 Aug 2024 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sofcrngj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462913635B;
	Fri, 30 Aug 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024461; cv=none; b=nmooxBNGZMGOank7rRhCyNOejg5Opn9obJPDWYfPNJxrBvs/x+DGgsN6gQqMD5zXgsZ3bLAcDcLITepc9wN1untoPNFSpztjxklXk3NBI2q3XJSxuB4FfwI1JV0H2si0i0osqmyPtnHr9udySuYEeyhKbBWI68A1VBX2eq9orT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024461; c=relaxed/simple;
	bh=DGZNGMFLHP6vjgZeuMR4RCQfBG3+P+ZlvrWWEyhK/aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODCjiY2GgAt1Wvwggf/F5BuMbcyOr+dHIGjjs+/2lAJjqkBldIvkyYqPhKHXXieIHqd8y3G+6F+1WXWA+YzV2ZxOJK2I189An3YhlOeai1AL9qsO7Vx9kd8Wtj/+ScaSJdjTLdep+h1F3q+2RMYb4YNOyuFwMXVrX2uzH3sP5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sofcrngj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93B8C4CEC7;
	Fri, 30 Aug 2024 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024460;
	bh=DGZNGMFLHP6vjgZeuMR4RCQfBG3+P+ZlvrWWEyhK/aY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sofcrngj6QEaNb2lZJ/nv8zgP7qZ9HAMrM8If8lGjmG7yRn8oQ3+dDz1jT+YF5S4G
	 r8eDrn6oUecP6ltqTQDpV/BvONKYHdmdPTM3C2YD1hRbFjWj3rsUO3zYMMYQeizDfy
	 Vpajsg6mewYoQ09IkmCQKpf1878Fenbv6DP9NnIXunBUXukxg2zkSFIsXIbNgz+BzF
	 Tak0uMTjw3ViD71Q61uPCqblgcbs8z4H/SrvYaThbgOjKbRtYdJNqxdihWqFBguhag
	 x0R5stAs95byOODLqBNGnxU0nNnhVbMIq9ywz82yBYPleGjWidD+Je+hkDZb8Vbfmq
	 k2N2IfN00olwQ==
Message-ID: <22f5442b-62e6-42d0-8bf8-163d2c4ea4bd@kernel.org>
Date: Fri, 30 Aug 2024 16:27:34 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/6] net: ti: icssg-prueth: Add support for
 HSR frame forward offload
To: MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
 <20240828091901.3120935-4-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240828091901.3120935-4-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/08/2024 12:18, MD Danish Anwar wrote:
> Add support for offloading HSR port-to-port frame forward to hardware.
> When the slave interfaces are added to the HSR interface, the PRU cores
> will be stopped and ICSSG HSR firmwares will be loaded to them.
> 
> Similarly, when HSR interface is deleted, the PRU cores will be stopped
> and dual EMAC firmware will be loaded to them.

And what happens if we first started with switch mode and then switched to HSR mode?
Is this case possible and if yes should it revert to the last used mode
instead of forcing to dual EMAC mode?

> 
> This commit also renames some APIs that are common between switch and
> hsr mode with '_fw_offload' suffix.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
>  drivers/net/ethernet/ti/icssg/icssg_config.c  |  18 +--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 117 +++++++++++++++++-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +
>  4 files changed, 130 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> index 9ec504d976d6..833ca86d0b71 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
> @@ -290,6 +290,7 @@ void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac)
>  		     mac[2] << 16 | mac[3] << 24));
>  	regmap_write(miig_rt, MAC_INTERFACE_1, (u32)(mac[4] | mac[5] << 8));
>  }
> +EXPORT_SYMBOL_GPL(icssg_class_set_host_mac_addr);
>  
>  void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
>  {
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index dae52a83a378..7b2e6c192ff3 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -107,7 +107,7 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
>  	},
>  };
>  
> -static void icssg_config_mii_init_switch(struct prueth_emac *emac)
> +static void icssg_config_mii_init_fw_offload(struct prueth_emac *emac)
>  {
>  	struct prueth *prueth = emac->prueth;
>  	int mii = prueth_emac_slice(emac);
> @@ -278,7 +278,7 @@ static int emac_r30_is_done(struct prueth_emac *emac)
>  	return 1;
>  }
>  
> -static int prueth_switch_buffer_setup(struct prueth_emac *emac)
> +static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)
>  {
>  	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
>  	struct icssg_rxq_ctx __iomem *rxq_ctx;
> @@ -424,7 +424,7 @@ static void icssg_init_emac_mode(struct prueth *prueth)
>  	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
>  }
>  
> -static void icssg_init_switch_mode(struct prueth *prueth)
> +static void icssg_init_fw_offload_mode(struct prueth *prueth)
>  {
>  	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
>  	int i;
> @@ -455,8 +455,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>  	struct icssg_flow_cfg __iomem *flow_cfg;
>  	int ret;
>  
> -	if (prueth->is_switch_mode)
> -		icssg_init_switch_mode(prueth);
> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> +		icssg_init_fw_offload_mode(prueth);
>  	else
>  		icssg_init_emac_mode(prueth);
>  
> @@ -472,8 +472,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>  	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
>  			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
>  	icssg_miig_set_interface_mode(prueth->miig_rt, slice, emac->phy_if);
> -	if (prueth->is_switch_mode)
> -		icssg_config_mii_init_switch(emac);
> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> +		icssg_config_mii_init_fw_offload(emac);
>  	else
>  		icssg_config_mii_init(emac);
>  	icssg_config_ipg(emac);
> @@ -498,8 +498,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>  	writeb(0, config + SPL_PKT_DEFAULT_PRIORITY);
>  	writeb(0, config + QUEUE_NUM_UNTAGGED);
>  
> -	if (prueth->is_switch_mode)
> -		ret = prueth_switch_buffer_setup(emac);
> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> +		ret = prueth_fw_offload_buffer_setup(emac);
>  	else
>  		ret = prueth_emac_buffer_setup(emac);
>  	if (ret)
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 641e54849762..f4fd346fe6f5 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -13,6 +13,7 @@
>  #include <linux/dma/ti-cppi5.h>
>  #include <linux/etherdevice.h>
>  #include <linux/genalloc.h>
> +#include <linux/if_hsr.h>
>  #include <linux/if_vlan.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -40,6 +41,8 @@
>  #define DEFAULT_PORT_MASK	1
>  #define DEFAULT_UNTAG_MASK	1
>  
> +#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	NETIF_F_HW_HSR_FWD
> +
>  /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
>  #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
>  
> @@ -118,6 +121,19 @@ static irqreturn_t prueth_tx_ts_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static struct icssg_firmwares icssg_hsr_firmwares[] = {
> +	{
> +		.pru = "ti-pruss/am65x-sr2-pru0-pruhsr-fw.elf",
> +		.rtu = "ti-pruss/am65x-sr2-rtu0-pruhsr-fw.elf",
> +		.txpru = "ti-pruss/am65x-sr2-txpru0-pruhsr-fw.elf",
> +	},
> +	{
> +		.pru = "ti-pruss/am65x-sr2-pru1-pruhsr-fw.elf",
> +		.rtu = "ti-pruss/am65x-sr2-rtu1-pruhsr-fw.elf",
> +		.txpru = "ti-pruss/am65x-sr2-txpru1-pruhsr-fw.elf",
> +	}
> +};
> +
>  static struct icssg_firmwares icssg_switch_firmwares[] = {
>  	{
>  		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
> @@ -152,6 +168,8 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>  
>  	if (prueth->is_switch_mode)
>  		firmwares = icssg_switch_firmwares;
> +	else if (prueth->is_hsr_offload_mode)
> +		firmwares = icssg_hsr_firmwares;
>  	else
>  		firmwares = icssg_emac_firmwares;
>  
> @@ -726,6 +744,19 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
>  	queue_work(emac->cmd_wq, &emac->rx_mode_work);
>  }
>  
> +static int emac_ndo_set_features(struct net_device *ndev,
> +				 netdev_features_t features)
> +{
> +	netdev_features_t hsr_feature_present = ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
> +	netdev_features_t hsr_feature_wanted = features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
> +	bool hsr_change_request = ((hsr_feature_wanted ^ hsr_feature_present) != 0);

This is quite hard to read for me.
why not just do this instead?

	netdev_features_t changed = netdev->features ^ feattures;

Then check and ack on individual features that you want to act upon.

	if (changed & NETIF_F_HW_HSR_FWD) {
		if (features & NETIF_F_HW_HSR_FWD)
			/* enable HSR FWD feature */
		else
			/* disable HSR FWD feature */
	}

	if (changed) {
		ndev->features = features;
		return 1;
	}

From include/linux/netdevice.h

 * int (*ndo_set_features)(struct net_device *dev, netdev_features_t features);
 *	Called to update device configuration to new features. Passed
 *	feature set might be less than what was returned by ndo_fix_features()).
 *	Must return >0 or -errno if it changed dev->features itself.

Can you please check that if we are not in dual emac mode then we should
error out if any HSR feature is requested to be set.

> +
> +	if (hsr_change_request)
> +		ndev->features = features;
> +
> +	return 0;


You may also want to check out

 * netdev_features_t (*ndo_fix_features)(struct net_device *dev,
 *		netdev_features_t features);
 *	Adjusts the requested feature flags according to device-specific
 *	constraints, and returns the resulting flags. Must not modify
 *	the device state.

As you mentioned there are some contstraints on what HSR features can be
enabled individually.
"2) Inorder to enable hsr-tag-ins-offload, hsr-dup-offload
   must also be enabled as these are tightly coupled in
   the firmware implementation."
You could do this check there by setting/clearing both features in tandem
if either one was set/cleared.

> +}
> +
>  static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_open = emac_ndo_open,
>  	.ndo_stop = emac_ndo_stop,
> @@ -737,6 +768,7 @@ static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_eth_ioctl = icssg_ndo_ioctl,
>  	.ndo_get_stats64 = icssg_ndo_get_stats64,
>  	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
> +	.ndo_set_features = emac_ndo_set_features,
>  };
>  
>  static int prueth_netdev_init(struct prueth *prueth,
> @@ -865,6 +897,7 @@ static int prueth_netdev_init(struct prueth *prueth,
>  	ndev->ethtool_ops = &icssg_ethtool_ops;
>  	ndev->hw_features = NETIF_F_SG;
>  	ndev->features = ndev->hw_features;
> +	ndev->hw_features |= NETIF_F_HW_HSR_FWD;
>  
>  	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
>  	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
> @@ -953,7 +986,7 @@ static void prueth_emac_restart(struct prueth *prueth)
>  	netif_device_attach(emac1->ndev);
>  }
>  
> -static void icssg_enable_switch_mode(struct prueth *prueth)
> +static void icssg_change_mode(struct prueth *prueth)
>  {
>  	struct prueth_emac *emac;
>  	int mac;
> @@ -973,8 +1006,12 @@ static void icssg_enable_switch_mode(struct prueth *prueth)
>  					  BIT(emac->port_id) | DEFAULT_PORT_MASK,
>  					  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
>  					  true);
> +			if (prueth->is_hsr_offload_mode)
> +				icssg_vtbl_modify(emac, DEFAULT_VID, DEFAULT_PORT_MASK,
> +						  DEFAULT_UNTAG_MASK, true);
>  			icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
> -			icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
> +			if (prueth->is_switch_mode)
> +				icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
>  		}
>  	}
>  }
> @@ -1012,7 +1049,7 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
>  			prueth->is_switch_mode = true;
>  			prueth->default_vlan = 1;
>  			emac->port_vlan = prueth->default_vlan;
> -			icssg_enable_switch_mode(prueth);
> +			icssg_change_mode(prueth);
>  		}
>  	}
>  
> @@ -1040,6 +1077,59 @@ static void prueth_netdevice_port_unlink(struct net_device *ndev)
>  		prueth->hw_bridge_dev = NULL;
>  }
>  
> +static int prueth_hsr_port_link(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	struct prueth_emac *emac0;
> +	struct prueth_emac *emac1;
> +
> +	emac0 = prueth->emac[PRUETH_MAC0];
> +	emac1 = prueth->emac[PRUETH_MAC1];
> +
> +	if (prueth->is_switch_mode)
> +		return -EOPNOTSUPP;
> +
> +	prueth->hsr_members |= BIT(emac->port_id);
> +	if (!prueth->is_switch_mode && !prueth->is_hsr_offload_mode) {

you already checked that is_switch_mode is not set earlier. No need to check again.

> +		if (prueth->hsr_members & BIT(PRUETH_PORT_MII0) &&
> +		    prueth->hsr_members & BIT(PRUETH_PORT_MII1)) {
> +			if (!(emac0->ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES) &&
> +			    !(emac1->ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES))
> +				return -EOPNOTSUPP;
> +			prueth->is_hsr_offload_mode = true;
> +			prueth->default_vlan = 1;
> +			emac0->port_vlan = prueth->default_vlan;
> +			emac1->port_vlan = prueth->default_vlan;
> +			icssg_change_mode(prueth);
> +			dev_dbg(prueth->dev, "Enabling HSR offload mode\n");
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void prueth_hsr_port_unlink(struct net_device *ndev)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
> +	struct prueth_emac *emac0;
> +	struct prueth_emac *emac1;
> +
> +	emac0 = prueth->emac[PRUETH_MAC0];
> +	emac1 = prueth->emac[PRUETH_MAC1];
> +
> +	prueth->hsr_members &= ~BIT(emac->port_id);
> +	if (prueth->is_hsr_offload_mode) {
> +		prueth->is_hsr_offload_mode = false;
> +		emac0->port_vlan = 0;
> +		emac1->port_vlan = 0;
> +		prueth->hsr_dev = NULL;
> +		prueth_emac_restart(prueth);
> +		dev_dbg(prueth->dev, "Enabling Dual EMAC mode\n");
> +	}
> +}
> +
>  /* netdev notifier */
>  static int prueth_netdevice_event(struct notifier_block *unused,
>  				  unsigned long event, void *ptr)
> @@ -1047,6 +1137,8 @@ static int prueth_netdevice_event(struct notifier_block *unused,
>  	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
>  	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
>  	struct netdev_notifier_changeupper_info *info;
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +	struct prueth *prueth = emac->prueth;
>  	int ret = NOTIFY_DONE;
>  
>  	if (ndev->netdev_ops != &emac_netdev_ops)
> @@ -1056,6 +1148,25 @@ static int prueth_netdevice_event(struct notifier_block *unused,
>  	case NETDEV_CHANGEUPPER:
>  		info = ptr;
>  
> +		if ((ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES) &&
> +		    is_hsr_master(info->upper_dev)) {
> +			if (info->linking) {
> +				if (!prueth->hsr_dev) {
> +					prueth->hsr_dev = info->upper_dev;
> +					icssg_class_set_host_mac_addr(prueth->miig_rt,
> +								      prueth->hsr_dev->dev_addr);
> +				} else {
> +					if (prueth->hsr_dev != info->upper_dev) {
> +						dev_dbg(prueth->dev, "Both interfaces must be linked to same upper device\n");
> +						return -EOPNOTSUPP;
> +					}
> +				}
> +				prueth_hsr_port_link(ndev);
> +			} else {
> +				prueth_hsr_port_unlink(ndev);
> +			}
> +		}
> +
>  		if (netif_is_bridge_master(info->upper_dev)) {
>  			if (info->linking)
>  				ret = prueth_netdevice_port_link(ndev, info->upper_dev, extack);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 786bd1ba34ab..a4b025fae797 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -243,11 +243,14 @@ struct icssg_firmwares {
>   * @iep1: pointer to IEP1 device
>   * @vlan_tbl: VLAN-FID table pointer
>   * @hw_bridge_dev: pointer to HW bridge net device
> + * @hsr_dev: pointer to the HSR net device
>   * @br_members: bitmask of bridge member ports
> + * @hsr_members: bitmask of hsr member ports
>   * @prueth_netdevice_nb: netdevice notifier block
>   * @prueth_switchdev_nb: switchdev notifier block
>   * @prueth_switchdev_bl_nb: switchdev blocking notifier block
>   * @is_switch_mode: flag to indicate if device is in Switch mode
> + * @is_hsr_offload_mode: flag to indicate if device is in hsr offload mode
>   * @is_switchmode_supported: indicates platform support for switch mode
>   * @switch_id: ID for mapping switch ports to bridge
>   * @default_vlan: Default VLAN for host
> @@ -279,11 +282,14 @@ struct prueth {
>  	struct prueth_vlan_tbl *vlan_tbl;
>  
>  	struct net_device *hw_bridge_dev;
> +	struct net_device *hsr_dev;
>  	u8 br_members;
> +	u8 hsr_members;
>  	struct notifier_block prueth_netdevice_nb;
>  	struct notifier_block prueth_switchdev_nb;
>  	struct notifier_block prueth_switchdev_bl_nb;
>  	bool is_switch_mode;
> +	bool is_hsr_offload_mode;
>  	bool is_switchmode_supported;
>  	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
>  	int default_vlan;

-- 
cheers,
-roger

