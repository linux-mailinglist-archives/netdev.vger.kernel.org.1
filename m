Return-Path: <netdev+bounces-143764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A179C40D3
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 15:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2691F22D2F
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1727919F421;
	Mon, 11 Nov 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgTsHOKf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006A19F40B;
	Mon, 11 Nov 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335144; cv=none; b=cvxTIGNQsKo5wLA3MpuRQ739jnswlPNI+UZ/qYPztVdGAmvIOOeB220JKjfXaPA7rlho29q4MliJyR+XwFoOe//01SueQ2TfnF8MC+jlcXk2BFALgdC8x6fggI+hr0wbolluY7gqYggurfVC3PMYp5TRKUl2Rt9O4UOw0ZMTm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335144; c=relaxed/simple;
	bh=B5mvklzayk4b+hck6sULwSMWLCrackunp+m5MmTi7so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpnZxE/DUsX78cq8KzmOgzV17vJy2atcsvRz1YyuLtkM3Lf1q5T04jJaFxgdWA1oV9bbS17T80B0WB6BrP2GUDgYx69IayC+wzdm2wWFgKPwYutl3GRYMWsrOqb+KlG8CQlhRLPrK3z6ykXTc1j5y95+9CioCrKc92FnG/Wegmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgTsHOKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F58CC4CECF;
	Mon, 11 Nov 2024 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731335143;
	bh=B5mvklzayk4b+hck6sULwSMWLCrackunp+m5MmTi7so=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kgTsHOKfdZpcV2/HYVIcDBjB7YGGMBCi1y8Ul5VMBPyZsYiCmNtTj6y0SHp/k2yKc
	 ACaBiqE8RgvRDxi1RLE7XnyKQq33y6DE4NCxqr1fAzJlDfBUT3Q4faaqson4YMQ9qe
	 YoKCSIgYhkfHkrFna6a/D8mWXkfjP/KmR5spTJ5PnAzoVVWkrkaVA6IuWE7NMG3vpX
	 uB+vB8XQoibxZgw9rJrSEA3mfxSsKyM0sDnwbPqDIYo9oJ4qcL2SbMRmZebeVp2xWJ
	 7/FzHNGs+cEtAfKzr82uJxteomiv3Tf+CpR5f0nUIydTLXrpcJtUQZJqtQW3OLtRbH
	 +dFACBWioW7EQ==
Message-ID: <17390fbf-7505-4e0a-8496-a6a4b22a261b@kernel.org>
Date: Mon, 11 Nov 2024 16:25:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ti: icssg-prueth: Fix firmware load
 sequence.
To: "Anwar, Md Danish" <a0501179@ti.com>, Meghana Malladi <m-malladi@ti.com>,
 vigneshr@ti.com, m-karicheri2@ti.com, jan.kiszka@siemens.com,
 javier.carrasco.cruz@gmail.com, jacob.e.keller@intel.com, horms@kernel.org,
 diogo.ivo@siemens.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, danishanwar@ti.com
References: <20241106074040.3361730-1-m-malladi@ti.com>
 <20241106074040.3361730-2-m-malladi@ti.com>
 <ad2afaa3-7e76-47e8-943b-7bea0c02c9c0@kernel.org>
 <0c6a3091-3b3d-4f41-83df-2183171200c8@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <0c6a3091-3b3d-4f41-83df-2183171200c8@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/2024 15:35, Anwar, Md Danish wrote:
> 
> 
> On 11/11/2024 6:33 PM, Roger Quadros wrote:
>> Hi,
>>
>> On 06/11/2024 09:40, Meghana Malladi wrote:
>>> From: MD Danish Anwar <danishanwar@ti.com>
>>>
>>> Timesync related operations are ran in PRU0 cores for both ICSSG SLICE0
>>> and SLICE1. Currently whenever any ICSSG interface comes up we load the
>>> respective firmwares to PRU cores and whenever interface goes down, we
>>> stop the respective cores. Due to this, when SLICE0 goes down while
>>> SLICE1 is still active, PRU0 firmwares are unloaded and PRU0 core is
>>> stopped. This results in clock jump for SLICE1 interface as the timesync
>>> related operations are no longer running.
>>>
>>> Fix this by running both PRU0 and PRU1 firmwares as long as at least 1
>>> ICSSG interface is up.
>>>
>>> rx_flow_id is updated before firmware is loaded. Once firmware is loaded,
>>> it reads the flow_id and uses it for rx. emac_fdb_flow_id_updated() is
>>> used to let firmware know that the flow_id has been updated and to use the
>>> latest rx_flow_id.
>>
>> is rx_flow_id releated to timesync releated issue that this patch is fixing?
>> If not please split it into separate patch and mention what functionality
>> it is fixing.
>>
> 
> Roger, rx_flow_id is not related to timesync. However loading both
> SLICE0 and SLICE1 firmware together results in wrong rx_flow_id used by
> firmware for the interface that is brought later.
> 
> When eth0 (SLICE0) is brought up, it's flow_id is obtained from dma and
> written to SMEM. Slice0 and Slice1 both firmwares are loaded. Firmware
> reads the flow_id from SMEM and uses it for RX.
> 
> Second interface eth1 (SLICE1) comes up, it's flow id is obtained from
> dma and written to SMEM. However firmware doesn't read the flow ID
> again. It only reads it once when loaded and uses that through out. The
> flow id for this interface remains 0 and that results in RX being broken.
> 
> To fix this, emac_fdb_flow_id_updated() is added which will let firmware
> know that we have updated the flow_id and use the latest one.
> 
> This not related to timesync instead related to the fix of timesync
> issue. Breaking this into separate patch will result in RX (ICSSG) being
> broken at the former patch.
> 
> In order to avoid feature breakage at the former patch, the change
> related to flow_id update is kept in the same patch.

But setting the Flow ID should be taken care by icssg_config() which is
done in prueth_emac_start()?

is it really OK to provide wrong flow id to the Firmware or even start
the second PRU core without DMA/IRQ resources allocated to it?

I will suggest to introduce emac_ndo_common_open() and emac_ndo_common_stop()
and move the common code there i.e. allocating/freeing resources for both
cores and starting/stopping both cores.

> 
> If you think having the feature broken is OK, the patch can be splitted.
> However IMO, these chanegs should be together in one patch.
> 
>>>
>>> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>>> ---
>>>  drivers/net/ethernet/ti/icssg/icssg_config.c | 28 ++++++++++
>>>  drivers/net/ethernet/ti/icssg/icssg_config.h |  1 +
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 58 ++++++++++++++++----
>>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
>>>  4 files changed, 77 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> index 5d2491c2943a..f1f0c8659e2d 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> @@ -786,3 +786,31 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
>>>  		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET);
>>>  }
>>>  EXPORT_SYMBOL_GPL(icssg_set_pvid);
>>> +
>>> +int emac_fdb_flow_id_updated(struct prueth_emac *emac)
>>> +{
>>> +	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
>>> +	int slice = prueth_emac_slice(emac);
>>> +	struct mgmt_cmd fdb_cmd = { 0 };
>>> +	int ret = 0;
>>> +
>>> +	fdb_cmd.header = ICSSG_FW_MGMT_CMD_HEADER;
>>> +	fdb_cmd.type   = ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW;
>>> +	fdb_cmd.seqnum = ++(emac->prueth->icssg_hwcmdseq);
>>> +	fdb_cmd.param  = 0;
>>> +
>>> +	fdb_cmd.param |= (slice << 4);
>>> +	fdb_cmd.cmd_args[0] = 0;
>>> +
>>> +	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
>>> +
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
>>> +	if (fdb_cmd_rsp.status == 1)
>>> +		return 0;
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +EXPORT_SYMBOL_GPL(emac_fdb_flow_id_updated);
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>> index 92c2deaa3068..c884e9fa099e 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
>>> @@ -55,6 +55,7 @@ struct icssg_rxq_ctx {
>>>  #define ICSSG_FW_MGMT_FDB_CMD_TYPE	0x03
>>>  #define ICSSG_FW_MGMT_CMD_TYPE		0x04
>>>  #define ICSSG_FW_MGMT_PKT		0x80000000
>>> +#define ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW	0x05
>>>  
>>>  struct icssg_r30_cmd {
>>>  	u32 cmd[4];
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> index 0556910938fa..9df67539285b 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>>> @@ -534,6 +534,7 @@ static int emac_ndo_open(struct net_device *ndev)
>>>  {
>>>  	struct prueth_emac *emac = netdev_priv(ndev);
>>>  	int ret, i, num_data_chn = emac->tx_ch_num;
>>> +	struct icssg_flow_cfg __iomem *flow_cfg;
>>>  	struct prueth *prueth = emac->prueth;
>>>  	int slice = prueth_emac_slice(emac);
>>>  	struct device *dev = prueth->dev;
>>> @@ -549,8 +550,12 @@ static int emac_ndo_open(struct net_device *ndev)
>>>  	/* set h/w MAC as user might have re-configured */
>>>  	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
>>>  
>>> +	if (!prueth->emacs_initialized) {
>>> +		icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
>>> +		icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
>>> +	}
>>> +
>>>  	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>> -	icssg_class_default(prueth->miig_rt, slice, 0, false);
>>>  	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>>  
>>>  	/* Notify the stack of the actual queue counts. */
>>> @@ -588,10 +593,31 @@ static int emac_ndo_open(struct net_device *ndev)
>>>  		goto cleanup_napi;
>>>  	}
>>>  
>>> -	/* reset and start PRU firmware */
>>> -	ret = prueth_emac_start(prueth, emac);
>>> -	if (ret)
>>> -		goto free_rx_irq;
>>> +	if (!prueth->emacs_initialized) {
>>> +		if (prueth->emac[ICSS_SLICE0]) {
>>> +			ret = prueth_emac_start(prueth, prueth->emac[ICSS_SLICE0]);
>>> +			if (ret) {
>>> +				netdev_err(ndev, "unable to start fw for slice %d", ICSS_SLICE0);
>>> +				goto free_rx_irq;
>>> +			}
>>> +		}
>>> +		if (prueth->emac[ICSS_SLICE1]) {
>>> +			ret = prueth_emac_start(prueth, prueth->emac[ICSS_SLICE1]);
>>> +			if (ret) {
>>> +				netdev_err(ndev, "unable to start fw for slice %d", ICSS_SLICE1);
>>> +				goto halt_slice0_prus;
>>> +			}
>>
>> Did I understand right: SLICE0 needs to be always running if any of the
>> interface is up but SLICE0 doesn't need to be running if only SLICE0
> 
> I think you meant `but SLICE1 doesn't need to be running if only SLICE0`
> 
>> interface is running.
>>
>> If yes then you need to update the patch so SLICE1 is not always running.
>>
> 
> For Timesync - YES. Only slice0 is needed to be always running. However
> these both firmwares have some more inter dependencies, timesync is just
> one of them. As a result, firmware team has recommended to keep both
> Slice0 and Slice1 firmware running as long as at least one ICSSG
> interface is up. Stop both firmware only if no ICSSG interface is up.
> 
> I think the commit message can be modified to state that the dependecy
> is not only SLICE0 but on SLICE1 as well and they both need to be running.
> 

OK Please mention this in commit log.

>>> +		}
>>> +	}
>>> +
>>> +	flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
>>> +	writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);
>>> +	ret = emac_fdb_flow_id_updated(emac);
>>> +
>>> +	if (ret) {
>>> +		netdev_err(ndev, "Failed to update Rx Flow ID %d", ret);
>>> +		goto stop;
>>> +	}
>>>  
>>>  	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
>>>  
>>> @@ -644,7 +670,11 @@ static int emac_ndo_open(struct net_device *ndev)
>>>  free_tx_ts_irq:
>>>  	free_irq(emac->tx_ts_irq, emac);
>>>  stop:
>>> -	prueth_emac_stop(emac);
>>> +	if (prueth->emac[ICSS_SLICE1])
>>> +		prueth_emac_stop(prueth->emac[ICSS_SLICE1]);
>>> +halt_slice0_prus:
>>> +	if (prueth->emac[ICSS_SLICE0])
>>> +		prueth_emac_stop(prueth->emac[ICSS_SLICE0]);
>>>  free_rx_irq:
>>>  	free_irq(emac->rx_chns.irq[rx_flow], emac);
>>>  cleanup_napi:
>>> @@ -680,7 +710,10 @@ static int emac_ndo_stop(struct net_device *ndev)
>>>  	if (ndev->phydev)
>>>  		phy_stop(ndev->phydev);
>>>  
>>> -	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
>>> +	if (prueth->emacs_initialized == 1) {
>>> +		icssg_class_disable(prueth->miig_rt, ICSS_SLICE0);
>>> +		icssg_class_disable(prueth->miig_rt, ICSS_SLICE1);
>>> +	}
>>>  
>>>  	if (emac->prueth->is_hsr_offload_mode)
>>>  		__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
>>> @@ -719,11 +752,14 @@ static int emac_ndo_stop(struct net_device *ndev)
>>>  	/* Destroying the queued work in ndo_stop() */
>>>  	cancel_delayed_work_sync(&emac->stats_work);
>>>  
>>> -	if (prueth->emacs_initialized == 1)
>>> +	if (prueth->emacs_initialized == 1) {
>>>  		icss_iep_exit(emac->iep);
>>> -
>>> -	/* stop PRUs */
>>> -	prueth_emac_stop(emac);
>>> +		/* stop PRUs */
>>> +		if (prueth->emac[ICSS_SLICE0])
>>> +			prueth_emac_stop(prueth->emac[ICSS_SLICE0]);
>>> +		if (prueth->emac[ICSS_SLICE1])
>>> +			prueth_emac_stop(prueth->emac[ICSS_SLICE1]);
>>> +	}
>>>  
>>>  	free_irq(emac->tx_ts_irq, emac);
>>>  
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> index 8722bb4a268a..c4f5f0349ae7 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> @@ -365,6 +365,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
>>>  		       u8 untag_mask, bool add);
>>>  u16 icssg_get_pvid(struct prueth_emac *emac);
>>>  void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
>>> +int emac_fdb_flow_id_updated(struct prueth_emac *emac);
>>>  #define prueth_napi_to_tx_chn(pnapi) \
>>>  	container_of(pnapi, struct prueth_tx_chn, napi_tx)
>>>  
>>
> 

-- 
cheers,
-roger

