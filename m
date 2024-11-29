Return-Path: <netdev+bounces-147850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E96C9DE6BA
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 13:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D97B282198
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 12:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAEC19D898;
	Fri, 29 Nov 2024 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGhDdhOB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F719D07B;
	Fri, 29 Nov 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885006; cv=none; b=aj6JMe7KTHGxoNhby7LiDhEHUzKLCxmm/flmBa0W7pCaKDwgI67cXG1m9K+Ue9EqT77PddkkU8F0J8Xk3fBb6UxuayYtFFuEFP/glGF7T+ZjKiR8BhPVyWJ5cmr4RT1CT3fpZJc8gFa6RkRvD5FceIbLZkul6Ufd68Oi/i/OADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885006; c=relaxed/simple;
	bh=sb645liDOsPFve3SGjSrOk2gr9iXBXwbXk/8ieeKKCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knFb3zjaXaOZVgKkv4WmaMqhLKbrmdmH/jopT2IYr+qznVZ97JqRnkVq+qZJzjaxfUOoSuTMg981LgZqVCh86971+8J/mPWlJ8k/1c6v+uG7ypdqkrKdoqK95ovss6YxBZRGSSMTR8Q3jK3cjAphB9o1xcwXL7lmYRE0LfiMKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGhDdhOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5453C4CECF;
	Fri, 29 Nov 2024 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732885005;
	bh=sb645liDOsPFve3SGjSrOk2gr9iXBXwbXk/8ieeKKCM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jGhDdhOBpE0i8hkdCUm5+mItkO5NzH7RV4jEHqaLj3RxlVo2obRL+1ynT/pCPUuaY
	 RJ6V1uxsroAEUe0e4QbxQDwHSsMcC529rg5NkuAdQq3VyBzykxXpVa7ABaPk8wcLuG
	 FvQpHPMGivIL9dfu26oqTZDQjt+RiFsOYQtfBzLipfOR12NDu3sCB94QRLfI5BKwyC
	 pqUCtpvKKozC/riMV/CmcT5pmEp6qarUgOzIYKnHvY72TzMvyzk5z4oAyBy2Memenh
	 MDvkMsG685MQmAbnljYYw4zFS8Et+Oxt+iwZ+dLoO6x2IgNHQYey340+t3xMM8TYHC
	 Rsv+1zIeV1hmw==
Message-ID: <a4071a1c-8c27-4464-9054-df9b3e317eab@kernel.org>
Date: Fri, 29 Nov 2024 14:56:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] net: ti: icssg-prueth: Fix firmware load
 sequence.
To: Meghana Malladi <m-malladi@ti.com>, lokeshvutla@ti.com, vigneshr@ti.com,
 javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com,
 jacob.e.keller@intel.com, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, danishanwar@ti.com
References: <20241128122931.2494446-1-m-malladi@ti.com>
 <20241128122931.2494446-2-m-malladi@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241128122931.2494446-2-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 28/11/2024 14:29, Meghana Malladi wrote:
> From: MD Danish Anwar <danishanwar@ti.com>
> 
> Timesync related operations are ran in PRU0 cores for both ICSSG SLICE0
> and SLICE1. Currently whenever any ICSSG interface comes up we load the
> respective firmwares to PRU cores and whenever interface goes down, we
> stop the resective cores. Due to this, when SLICE0 goes down while
> SLICE1 is still active, PRU0 firmwares are unloaded and PRU0 core is
> stopped. This results in clock jump for SLICE1 interface as the timesync
> related operations are no longer running.
> 
> As there are interdependencies between SLICE0 and SLICE1 firmwares,
> fix this by running both PRU0 and PRU1 firmwares as long as at least 1
> ICSSG interface is up.
> 
> Use emacs_initialized as reference count to load the firmwares for the
> first and last interface up/down. Moving init_emac_mode and fw_offload_mode
> API outside of icssg_config to icssg_common_start API as they need
> to be called only once per firmware boot.
> 
> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> 
> Hi all,
> 
> This patch is based on net-next tagged next-2024110.
> v1:https://lore.kernel.org/all/20241106074040.3361730-2-m-malladi@ti.com
> 
> Changes since v1 (v2-v1):
> - Moving the NULL check inside the function as suggested by
> Simon Horman <horms@kernel.org>
> - Introduce prueth_emac_common_start() and prueth_emac_common_stop()
> and move common code there as suggested by Roger Quadros <rogerq@kernel.org>
> - Moving init_emac_mode and fw_offload_mode API outside of icssg_config
> to icssg_common_start API as they need to be called only once per
> firmware boot
> 
>  drivers/net/ethernet/ti/icssg/icssg_config.c |  45 ++++--
>  drivers/net/ethernet/ti/icssg/icssg_config.h |   1 +
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 150 ++++++++++++-------
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |   3 +
>  4 files changed, 133 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
> index 5d2491c2943a..342150756cf7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
> @@ -397,7 +397,7 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)
>  	return 0;
>  }
>  
> -static void icssg_init_emac_mode(struct prueth *prueth)
> +void icssg_init_emac_mode(struct prueth *prueth)
>  {
>  	/* When the device is configured as a bridge and it is being brought
>  	 * back to the emac mode, the host mac address has to be set as 0.
> @@ -406,9 +406,6 @@ static void icssg_init_emac_mode(struct prueth *prueth)
>  	int i;
>  	u8 mac[ETH_ALEN] = { 0 };
>  
> -	if (prueth->emacs_initialized)
> -		return;
> -
>  	/* Set VLAN TABLE address base */
>  	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
>  			   addr <<  SMEM_VLAN_OFFSET);
> @@ -423,15 +420,13 @@ static void icssg_init_emac_mode(struct prueth *prueth)
>  	/* Clear host MAC address */
>  	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
>  }
> +EXPORT_SYMBOL_GPL(icssg_init_emac_mode);
>  
> -static void icssg_init_fw_offload_mode(struct prueth *prueth)
> +void icssg_init_fw_offload_mode(struct prueth *prueth)
>  {
>  	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
>  	int i;
>  
> -	if (prueth->emacs_initialized)
> -		return;
> -
>  	/* Set VLAN TABLE address base */
>  	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
>  			   addr <<  SMEM_VLAN_OFFSET);
> @@ -448,6 +443,7 @@ static void icssg_init_fw_offload_mode(struct prueth *prueth)
>  		icssg_class_set_host_mac_addr(prueth->miig_rt, prueth->hw_bridge_dev->dev_addr);
>  	icssg_set_pvid(prueth, prueth->default_vlan, PRUETH_PORT_HOST);
>  }
> +EXPORT_SYMBOL_GPL(icssg_init_fw_offload_mode);
>  
>  int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>  {
> @@ -455,11 +451,6 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
>  	struct icssg_flow_cfg __iomem *flow_cfg;
>  	int ret;
>  
> -	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> -		icssg_init_fw_offload_mode(prueth);
> -	else
> -		icssg_init_emac_mode(prueth);
> -
>  	memset_io(config, 0, TAS_GATE_MASK_LIST0);
>  	icssg_miig_queues_init(prueth, slice);
>  
> @@ -786,3 +777,31 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
>  		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET);
>  }
>  EXPORT_SYMBOL_GPL(icssg_set_pvid);
> +
> +int emac_fdb_flow_id_updated(struct prueth_emac *emac)
> +{
> +	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
> +	int slice = prueth_emac_slice(emac);
> +	struct mgmt_cmd fdb_cmd = { 0 };
> +	int ret = 0;
> +
> +	fdb_cmd.header = ICSSG_FW_MGMT_CMD_HEADER;
> +	fdb_cmd.type   = ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW;
> +	fdb_cmd.seqnum = ++(emac->prueth->icssg_hwcmdseq);
> +	fdb_cmd.param  = 0;
> +
> +	fdb_cmd.param |= (slice << 4);
> +	fdb_cmd.cmd_args[0] = 0;
> +
> +	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
> +
> +	if (ret)
> +		return ret;
> +
> +	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
> +	if (fdb_cmd_rsp.status == 1)
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(emac_fdb_flow_id_updated);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
> index 92c2deaa3068..c884e9fa099e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
> @@ -55,6 +55,7 @@ struct icssg_rxq_ctx {
>  #define ICSSG_FW_MGMT_FDB_CMD_TYPE	0x03
>  #define ICSSG_FW_MGMT_CMD_TYPE		0x04
>  #define ICSSG_FW_MGMT_PKT		0x80000000
> +#define ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW	0x05
>  
>  struct icssg_r30_cmd {
>  	u32 cmd[4];
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index c568c84a032b..3a495b5d010c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -164,11 +164,11 @@ static struct icssg_firmwares icssg_emac_firmwares[] = {
>  	}
>  };
>  
> -static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
> +static int prueth_emac_start(struct prueth *prueth, int slice)
>  {
>  	struct icssg_firmwares *firmwares;
>  	struct device *dev = prueth->dev;
> -	int slice, ret;
> +	int ret;
>  
>  	if (prueth->is_switch_mode)
>  		firmwares = icssg_switch_firmwares;
> @@ -177,16 +177,6 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>  	else
>  		firmwares = icssg_emac_firmwares;
>  
> -	slice = prueth_emac_slice(emac);
> -	if (slice < 0) {
> -		netdev_err(emac->ndev, "invalid port\n");
> -		return -EINVAL;
> -	}
> -
> -	ret = icssg_config(prueth, emac, slice);
> -	if (ret)
> -		return ret;
> -
>  	ret = rproc_set_firmware(prueth->pru[slice], firmwares[slice].pru);
>  	ret = rproc_boot(prueth->pru[slice]);
>  	if (ret) {
> @@ -208,7 +198,6 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>  		goto halt_rtu;
>  	}
>  
> -	emac->fw_running = 1;
>  	return 0;
>  
>  halt_rtu:
> @@ -220,6 +209,77 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>  	return ret;
>  }
>  
> +static int prueth_emac_common_start(struct prueth *prueth)
> +{
> +	struct prueth_emac *emac;
> +	int slice, ret;
> +
> +	if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
> +		return -EINVAL;
> +
> +	/* clear SMEM and MSMC settings for all slices */
> +	memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
> +	memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUETH_NUM_MACS);
> +
> +	icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
> +	icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
> +
> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> +		icssg_init_fw_offload_mode(prueth);
> +	else
> +		icssg_init_emac_mode(prueth);
> +
> +	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
> +		emac = prueth->emac[slice];
> +		if (emac) {
> +			ret = icssg_config(prueth, emac, slice);
> +			if (ret)
> +				return ret;
> +		}
> +		ret = prueth_emac_start(prueth, slice);

if (ret)
	return ret;

> +		if (!ret && emac)

Then no need to check for !ret

> +			emac->fw_running = 1;
> +	}
> +
> +	emac = prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
> +	       prueth->emac[ICSS_SLICE1];
> +	ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
> +			    emac, IEP_DEFAULT_CYCLE_TIME_NS);
> +	if (ret) {
> +		dev_err(prueth->dev, "Failed to initialize IEP module\n");
> +		return ret;
> +	}

If we return error anywhere in this function will the caller take
care of cleaning up?
i.e. icssg_class_disable(), stopping any started cores, icss_iep_exit?

You can't rely on prueth_emac_common_stop() as all cores might not
have started and iep_init may not have been called.
But you can if you check and call only if required.
e.g. fw_running flag can be used to track if cores were started.

> +

Shouldn't we be setting emacs->initialized here and get rid of doing that
in emac_ndo_open()?

then you can track it to call icss_iep_exit().

> +	return 0;
> +}
> +
> +static int prueth_emac_common_stop(struct prueth *prueth)
> +{
> +	struct prueth_emac *emac;
> +	int slice;
> +
> +	if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
> +		return -EINVAL;
> +
> +	icssg_class_disable(prueth->miig_rt, ICSS_SLICE0);
> +	icssg_class_disable(prueth->miig_rt, ICSS_SLICE1);
> +
> +	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
> +		emac = prueth->emac[slice];
> +		rproc_shutdown(prueth->txpru[slice]);
> +		rproc_shutdown(prueth->rtu[slice]);
> +		rproc_shutdown(prueth->pru[slice]);
> +		if (emac)
> +			emac->fw_running = 0;
> +	}
> +
> +	emac = prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
> +	       prueth->emac[ICSS_SLICE1];
> +	icss_iep_exit(emac->iep);
> +

emacs->initialized = 0;

> +	return 0;
> +}
> +
>  /* called back by PHY layer if there is change in link state of hw port*/
>  static void emac_adjust_link(struct net_device *ndev)
>  {
> @@ -543,23 +603,17 @@ static int emac_ndo_open(struct net_device *ndev)
>  {
>  	struct prueth_emac *emac = netdev_priv(ndev);
>  	int ret, i, num_data_chn = emac->tx_ch_num;
> +	struct icssg_flow_cfg __iomem *flow_cfg;
>  	struct prueth *prueth = emac->prueth;
>  	int slice = prueth_emac_slice(emac);
>  	struct device *dev = prueth->dev;
>  	int max_rx_flows;
>  	int rx_flow;
>  
> -	/* clear SMEM and MSMC settings for all slices */
> -	if (!prueth->emacs_initialized) {
> -		memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
> -		memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUETH_NUM_MACS);
> -	}
> -
>  	/* set h/w MAC as user might have re-configured */
>  	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
>  
>  	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
> -	icssg_class_default(prueth->miig_rt, slice, 0, false);

This is changing existing behaviour.
If network device is stopped and started we expect all classifiers to be set to defaults?

>  	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>  
>  	/* Notify the stack of the actual queue counts. */
> @@ -597,18 +651,23 @@ static int emac_ndo_open(struct net_device *ndev)
>  		goto cleanup_napi;
>  	}
>  
> -	/* reset and start PRU firmware */
> -	ret = prueth_emac_start(prueth, emac);
> -	if (ret)
> -		goto free_rx_irq;
> +	if (!prueth->emacs_initialized) {
> +		ret = prueth_emac_common_start(prueth);
> +		if (ret)
> +			goto free_rx_irq;

goto stop;

so you can use pruet_emac_common_stop() to do the necessary cleanup.

> +	}
>  
> -	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
> +	flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
> +	writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);
> +	ret = emac_fdb_flow_id_updated(emac);
>  
> -	if (!prueth->emacs_initialized) {
> -		ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
> -				    emac, IEP_DEFAULT_CYCLE_TIME_NS);
> +	if (ret) {
> +		netdev_err(ndev, "Failed to update Rx Flow ID %d", ret);
> +		goto stop;
>  	}
>  
> +	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
> +
>  	ret = request_threaded_irq(emac->tx_ts_irq, NULL, prueth_tx_ts_irq,
>  				   IRQF_ONESHOT, dev_name(dev), emac);
>  	if (ret)
> @@ -653,7 +712,7 @@ static int emac_ndo_open(struct net_device *ndev)
>  free_tx_ts_irq:
>  	free_irq(emac->tx_ts_irq, emac);
>  stop:
> -	prueth_emac_stop(emac);
> +	prueth_emac_common_stop(prueth);
>  free_rx_irq:
>  	free_irq(emac->rx_chns.irq[rx_flow], emac);
>  cleanup_napi:
> @@ -689,8 +748,6 @@ static int emac_ndo_stop(struct net_device *ndev)
>  	if (ndev->phydev)
>  		phy_stop(ndev->phydev);
>  
> -	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
> -
>  	if (emac->prueth->is_hsr_offload_mode)
>  		__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
>  	else
> @@ -729,10 +786,8 @@ static int emac_ndo_stop(struct net_device *ndev)
>  	cancel_delayed_work_sync(&emac->stats_work);
>  
>  	if (prueth->emacs_initialized == 1)
> -		icss_iep_exit(emac->iep);
> -
> -	/* stop PRUs */
> -	prueth_emac_stop(emac);
> +		/* stop PRUs */
> +		prueth_emac_common_stop(prueth);

You don't need this anymore as we will rely on stop: label to call
prueth_emac_common_stop();

>  
>  	free_irq(emac->tx_ts_irq, emac);
>  
> @@ -1069,16 +1124,10 @@ static void prueth_emac_restart(struct prueth *prueth)
>  	icssg_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
>  
>  	/* Stop both pru cores for both PRUeth ports*/
> -	prueth_emac_stop(emac0);
> -	prueth->emacs_initialized--;
> -	prueth_emac_stop(emac1);
> -	prueth->emacs_initialized--;
> +	prueth_emac_common_stop(prueth);
>  
>  	/* Start both pru cores for both PRUeth ports */
> -	prueth_emac_start(prueth, emac0);
> -	prueth->emacs_initialized++;
> -	prueth_emac_start(prueth, emac1);
> -	prueth->emacs_initialized++;
> +	prueth_emac_common_start(prueth);
>  
>  	/* Enable forwarding for both PRUeth ports */
>  	icssg_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
> @@ -1413,13 +1462,10 @@ static int prueth_probe(struct platform_device *pdev)
>  		prueth->pa_stats = NULL;
>  	}
>  
> -	if (eth0_node) {
> +	if (eth0_node || eth1_node) {
>  		ret = prueth_get_cores(prueth, ICSS_SLICE0, false);
>  		if (ret)
>  			goto put_cores;
> -	}
> -
> -	if (eth1_node) {
>  		ret = prueth_get_cores(prueth, ICSS_SLICE1, false);
>  		if (ret)
>  			goto put_cores;
> @@ -1618,14 +1664,12 @@ static int prueth_probe(struct platform_device *pdev)
>  	pruss_put(prueth->pruss);
>  
>  put_cores:
> -	if (eth1_node) {
> -		prueth_put_cores(prueth, ICSS_SLICE1);
> -		of_node_put(eth1_node);
> -	}
> -
> -	if (eth0_node) {
> +	if (eth0_node || eth1_node) {
>  		prueth_put_cores(prueth, ICSS_SLICE0);
>  		of_node_put(eth0_node);
> +
> +		prueth_put_cores(prueth, ICSS_SLICE1);
> +		of_node_put(eth1_node);
>  	}
>  
>  	return ret;
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index f5c1d473e9f9..9fc72614d990 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -361,6 +361,8 @@ int icssg_set_port_state(struct prueth_emac *emac,
>  			 enum icssg_port_state_cmd state);
>  void icssg_config_set_speed(struct prueth_emac *emac);
>  void icssg_config_half_duplex(struct prueth_emac *emac);
> +void icssg_init_emac_mode(struct prueth *prueth);
> +void icssg_init_fw_offload_mode(struct prueth *prueth);
>  
>  /* Buffer queue helpers */
>  int icssg_queue_pop(struct prueth *prueth, u8 queue);
> @@ -377,6 +379,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
>  		       u8 untag_mask, bool add);
>  u16 icssg_get_pvid(struct prueth_emac *emac);
>  void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
> +int emac_fdb_flow_id_updated(struct prueth_emac *emac);
>  #define prueth_napi_to_tx_chn(pnapi) \
>  	container_of(pnapi, struct prueth_tx_chn, napi_tx)
>  

-- 
cheers,
-roger


