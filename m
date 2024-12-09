Return-Path: <netdev+bounces-150162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33099E9478
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE48284060
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A506E226EF2;
	Mon,  9 Dec 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBK1Cijz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB092248BF;
	Mon,  9 Dec 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747965; cv=none; b=d3R302tv1/V3O3QGKmHIGhLAIrKODph5ZxN0CG6Y4rX142TucGZM6OkeVq6h6WY3s0pE+VexCc/BGDGO0H3VZKB0TuDWOpalaB3BJd7f6vYBC8joj9Tym6HGUqpuaeosm3vvaJhuE6C9yfjxDDZ6zgecGA2mN8fyb+MhZH9XxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747965; c=relaxed/simple;
	bh=CMfN1xPy9PKkRLxt0ND0V2nv1Cxh6z61nlM2pGOtKhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2DQtr2nBA/Q2F9WmVarmOu/6FbBgY+bD16w+zKm+oj36XBAvn+Ro5NXKQTtnSRXSlHE58fjHaG8DLHu3ldufB/ANDlumHaNaK4p8wCcrZUqflJ6LsZPbZ1Yu/fllehz9U8d2gN4QRif3f2mp+hPwCCj+rRHXWFbFpuD7BeUcPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBK1Cijz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D82C4CED1;
	Mon,  9 Dec 2024 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733747965;
	bh=CMfN1xPy9PKkRLxt0ND0V2nv1Cxh6z61nlM2pGOtKhE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TBK1Cijz1qPzM7dnm61A/IXRgiMa04GWGCxI1QY7g3iFqw8b2en0awewSnOYBQY/l
	 Yj1Pr4WxHKOxQbdjy7LKeUHR4wG2sut/f7F73VrgMar+yrWXtFUJOuXbt1vh/NNktL
	 QqZnbOHiZ1tiOzOf9jmikwTr+6J24xwKQ+4PLGjxxrWxq+oUK7Lii4QKvOAxvJI3AZ
	 JQvBSVfJ8RqeEnajUpVsvOStXq8sYM23aE036HhDH1VlsFaUAeSNVD/qFMkVDr1Jnl
	 32y+nrUBHdaidGBlmZq1VWlbSuH44GygVfRh5mt3rXFkkk/fDBgz792fQLuycvx8/1
	 vJ4HnQn8YNdyg==
Message-ID: <badf6d7c-85a5-42a4-b834-f5cdbd8ff81f@kernel.org>
Date: Mon, 9 Dec 2024 14:39:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: ti: icssg-prueth: Fix firmware load
 sequence.
To: Meghana Malladi <m-malladi@ti.com>, vigneshr@ti.com,
 jan.kiszka@siemens.com, javier.carrasco.cruz@gmail.com,
 diogo.ivo@siemens.com, jacob.e.keller@intel.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, danishanwar@ti.com
References: <20241205082831.777868-1-m-malladi@ti.com>
 <20241205082831.777868-2-m-malladi@ti.com>
 <a86bc0b1-8bb4-477e-b7e1-13921bf47b53@kernel.org>
 <64621290-2488-474d-b2ed-597a1f4ac85f@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <64621290-2488-474d-b2ed-597a1f4ac85f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/12/2024 12:34, Meghana Malladi wrote:
> 
> 
> On 05/12/24 18:38, Roger Quadros wrote:
>> Hi,
>>
>> On 05/12/2024 10:28, Meghana Malladi wrote:
>>> From: MD Danish Anwar <danishanwar@ti.com>
>>>
>>> Timesync related operations are ran in PRU0 cores for both ICSSG SLICE0
>>> and SLICE1. Currently whenever any ICSSG interface comes up we load the
>>> respective firmwares to PRU cores and whenever interface goes down, we
>>> stop the resective cores. Due to this, when SLICE0 goes down while
>>> SLICE1 is still active, PRU0 firmwares are unloaded and PRU0 core is
>>> stopped. This results in clock jump for SLICE1 interface as the timesync
>>> related operations are no longer running.
>>>
>>> As there are interdependencies between SLICE0 and SLICE1 firmwares,
>>> fix this by running both PRU0 and PRU1 firmwares as long as at least 1
>>> ICSSG interface is up. Add new flag in prueth struct to check if all
>>> firmwares are running.
>>>
>>> Use emacs_initialized as reference count to load the firmwares for the
>>> first and last interface up/down. Moving init_emac_mode and fw_offload_mode
>>> API outside of icssg_config to icssg_common_start API as they need
>>> to be called only once per firmware boot.
>>>
>>> Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>>> ---
>>>
>>> Hi all,
>>>
>>> This patch is based on net-next tagged next-20241128.
>>> v2:https://lore.kernel.org/all/20241128122931.2494446-2-m-malladi@ti.com/
>>>
>>> * Changes since v2 (v3-v2):
>>> - error handling in caller function of prueth_emac_common_start()
>>> - Use prus_running flag check before stopping the firmwares
>>> Both suggested by Roger Quadros <rogerq@kernel.org>
>>>
>>>   drivers/net/ethernet/ti/icssg/icssg_config.c |  45 ++++--
>>>   drivers/net/ethernet/ti/icssg/icssg_config.h |   1 +
>>>   drivers/net/ethernet/ti/icssg/icssg_prueth.c | 157 ++++++++++++-------
>>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h |   5 +
>>>   4 files changed, 140 insertions(+), 68 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> index 5d2491c2943a..342150756cf7 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
>>> @@ -397,7 +397,7 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)
>>>       return 0;
>>>   }
>>>
> [ ... ]
> 
>>> +static int prueth_emac_common_start(struct prueth *prueth)
>>> +{
>>> +    struct prueth_emac *emac;
>>> +    int ret = 0;
>>> +    int slice;
>>> +
>>> +    if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
>>> +        return -EINVAL;
>>> +
>>> +    /* clear SMEM and MSMC settings for all slices */
>>> +    memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
>>> +    memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUETH_NUM_MACS);
>>> +
>>> +    icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
>>> +    icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
>>> +
>>> +    if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
>>> +        icssg_init_fw_offload_mode(prueth);
>>> +    else
>>> +        icssg_init_emac_mode(prueth);
>>> +
>>> +    for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
>>> +        emac = prueth->emac[slice];
>>> +        if (emac) {
>>> +            ret |= icssg_config(prueth, emac, slice);
>>> +            if (ret)
>>> +                return ret;
>>> +        }
>>> +        ret |= prueth_emac_start(prueth, slice);
>>> +    }
>>
>> need newline?
>>
> 
> Yes I will add it.
> 
>>> +    if (!ret)
>>> +        prueth->prus_running = 1;
>>> +    else
>>> +        return ret;
>>> +
>>> +    emac = prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
>>> +           prueth->emac[ICSS_SLICE1];
>>> +    ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
>>> +                emac, IEP_DEFAULT_CYCLE_TIME_NS);
>>> +    if (ret) {
>>> +        dev_err(prueth->dev, "Failed to initialize IEP module\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int prueth_emac_common_stop(struct prueth *prueth)
>>> +{
>>> +    struct prueth_emac *emac;
>>> +    int slice;
>>> +
>>> +    if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
>>> +        return -EINVAL;
>>> +
>>> +    icssg_class_disable(prueth->miig_rt, ICSS_SLICE0);
>>> +    icssg_class_disable(prueth->miig_rt, ICSS_SLICE1);
>>> +
>>> +    for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
>>> +        if (prueth->prus_running) {
>>> +            rproc_shutdown(prueth->txpru[slice]);
>>> +            rproc_shutdown(prueth->rtu[slice]);
>>> +            rproc_shutdown(prueth->pru[slice]);
>>> +        }
>>> +    }
>>> +    prueth->prus_running = 0;
>>> +
>>> +    emac = prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
>>> +           prueth->emac[ICSS_SLICE1];
>>> +    icss_iep_exit(emac->iep);
>>
>> if icss_iep_init() failed at prueth_emac_common_start(), we should not be
>> calling icss_iep_exit(). Maybe you need another flag for iep_init status?
>>
> 
> Yes I have thought of it as well. In icss_iep_init() does lot of iep register configuration and in the end it enables iep by setting IEP_CNT_ENABLE bit and ptp_clock_register(). Whereas in icss_iep_exit() it checks for ptp_clock and pps/perout. And calls icss_iep_disable() which again clears IEP_CNT_ENABLE.
> 
> So I see no harm in calling icss_iep_exit() even if icss_iep_init() as it overwrites the existing configuration only. But if you think this doesn't look good I can definitely add new flag for iep as well. But IMO I think this flag would be redundant, please correct me if I am wrong. So which one sounds better?

But isn't icss_iep_exit() also calling ptp_clock_unregister()?
If it is safe to do that even in error condition then it doesn't matter.

> 
>> Is it better to call icss_iep_exit() at the top before icssg_class_disable()?
>>
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   /* called back by PHY layer if there is change in link state of hw port*/
>>>   static void emac_adjust_link(struct net_device *ndev)
>>>   {
>>> @@ -369,12 +432,13 @@ static void prueth_iep_settime(void *clockops_data, u64 ns)
>>>   {
>>>       struct icssg_setclock_desc __iomem *sc_descp;
>>>       struct prueth_emac *emac = clockops_data;
>>> +    struct prueth *prueth = emac->prueth;
>>>       struct icssg_setclock_desc sc_desc;
>>>       u64 cyclecount;
>>>       u32 cycletime;
>>>       int timeout;
>>>   -    if (!emac->fw_running)
>>> +    if (!prueth->prus_running)
>>>           return;
>>>         sc_descp = emac->prueth->shram.va + TIMESYNC_FW_WC_SETCLOCK_DESC_OFFSET;
>>> @@ -543,23 +607,17 @@ static int emac_ndo_open(struct net_device *ndev)
>>>   {
>>>       struct prueth_emac *emac = netdev_priv(ndev);
>>>       int ret, i, num_data_chn = emac->tx_ch_num;
>>> +    struct icssg_flow_cfg __iomem *flow_cfg;
>>>       struct prueth *prueth = emac->prueth;
>>>       int slice = prueth_emac_slice(emac);
>>>       struct device *dev = prueth->dev;
>>>       int max_rx_flows;
>>>       int rx_flow;
>>>   -    /* clear SMEM and MSMC settings for all slices */
>>> -    if (!prueth->emacs_initialized) {
>>> -        memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
>>> -        memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUETH_NUM_MACS);
>>> -    }
>>> -
>>>       /* set h/w MAC as user might have re-configured */
>>>       ether_addr_copy(emac->mac_addr, ndev->dev_addr);
>>>         icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>> -    icssg_class_default(prueth->miig_rt, slice, 0, false);
>>>       icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>>>         /* Notify the stack of the actual queue counts. */
>>> @@ -597,18 +655,23 @@ static int emac_ndo_open(struct net_device *ndev)
>>>           goto cleanup_napi;
>>>       }
>>>   -    /* reset and start PRU firmware */
>>> -    ret = prueth_emac_start(prueth, emac);
>>> -    if (ret)
>>> -        goto free_rx_irq;
>>> +    if (!prueth->emacs_initialized) {
>>> +        ret = prueth_emac_common_start(prueth);
>>> +        if (ret)
>>> +            goto stop;
>>> +    }
>>>   -    icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
>>> +    flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
>>> +    writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);
>>> +    ret = emac_fdb_flow_id_updated(emac);
>>>   -    if (!prueth->emacs_initialized) {
>>> -        ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
>>> -                    emac, IEP_DEFAULT_CYCLE_TIME_NS);
>>> +    if (ret) {
>>> +        netdev_err(ndev, "Failed to update Rx Flow ID %d", ret);
>>> +        goto stop;
>>>       }
>>>   +    icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
>>> +
>>>       ret = request_threaded_irq(emac->tx_ts_irq, NULL, prueth_tx_ts_irq,
>>>                      IRQF_ONESHOT, dev_name(dev), emac);
>>>       if (ret)
>>> @@ -653,8 +716,7 @@ static int emac_ndo_open(struct net_device *ndev)
>>>   free_tx_ts_irq:
>>>       free_irq(emac->tx_ts_irq, emac);
>>>   stop:
>>> -    prueth_emac_stop(emac);
>>> -free_rx_irq:
>>> +    prueth_emac_common_stop(prueth);
>>>       free_irq(emac->rx_chns.irq[rx_flow], emac);
>>>   cleanup_napi:
>>>       prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
>>> @@ -689,8 +751,6 @@ static int emac_ndo_stop(struct net_device *ndev)
>>>       if (ndev->phydev)
>>>           phy_stop(ndev->phydev);
>>>   -    icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
>>> -
>>>       if (emac->prueth->is_hsr_offload_mode)
>>>           __dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
>>>       else
>>> @@ -728,11 +788,9 @@ static int emac_ndo_stop(struct net_device *ndev)
>>>       /* Destroying the queued work in ndo_stop() */
>>>       cancel_delayed_work_sync(&emac->stats_work);
>>>   -    if (prueth->emacs_initialized == 1)
>>> -        icss_iep_exit(emac->iep);
>>> -
>>>       /* stop PRUs */
>>> -    prueth_emac_stop(emac);
>>> +    if (prueth->emacs_initialized == 1)
>>> +        prueth_emac_common_stop(prueth);
>>>         free_irq(emac->tx_ts_irq, emac);
>>>   @@ -1069,16 +1127,10 @@ static void prueth_emac_restart(struct prueth *prueth)
>>>       icssg_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
>>>         /* Stop both pru cores for both PRUeth ports*/
>>> -    prueth_emac_stop(emac0);
>>> -    prueth->emacs_initialized--;
>>> -    prueth_emac_stop(emac1);
>>> -    prueth->emacs_initialized--;
>>> +    prueth_emac_common_stop(prueth);
>>>         /* Start both pru cores for both PRUeth ports */
>>> -    prueth_emac_start(prueth, emac0);
>>> -    prueth->emacs_initialized++;
>>> -    prueth_emac_start(prueth, emac1);
>>> -    prueth->emacs_initialized++;
>>> +    prueth_emac_common_start(prueth);
>>
>> But this can fail? You need to deal with failure condition appropriately.
>>
> 
> I haven't added failure conditions for two reasons:
> - Existing code also didn't have any error checks
> - This func simply reloads a new firmware, given everything is already working with the old one.
> 
> I can still handle error cases by changing this func to return int (currently it is void) and caller of the functions should print error and immediately return. Thoughts on this?

At least an error message somewhere will help to debug later.

> 
>>>         /* Enable forwarding for both PRUeth ports */
>>>       icssg_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
>>> @@ -1413,13 +1465,10 @@ static int prueth_probe(struct platform_device *pdev)
>>>           prueth->pa_stats = NULL;
>>>       }
>>>   -    if (eth0_node) {
>>> +    if (eth0_node || eth1_node) {
>>>           ret = prueth_get_cores(prueth, ICSS_SLICE0, false);
>>>           if (ret)
>>>               goto put_cores;
>>> -    }
>>> -
>>> -    if (eth1_node) {
>>>           ret = prueth_get_cores(prueth, ICSS_SLICE1, false);
>>>           if (ret)
>>>               goto put_cores;
>>> @@ -1618,14 +1667,12 @@ static int prueth_probe(struct platform_device *pdev)
>>>       pruss_put(prueth->pruss);
>>>     put_cores:
>>> -    if (eth1_node) {
>>> -        prueth_put_cores(prueth, ICSS_SLICE1);
>>> -        of_node_put(eth1_node);
>>> -    }
>>> -
>>> -    if (eth0_node) {
>>> +    if (eth0_node || eth1_node) {
>>>           prueth_put_cores(prueth, ICSS_SLICE0);
>>>           of_node_put(eth0_node);
>>> +
>>> +        prueth_put_cores(prueth, ICSS_SLICE1);
>>> +        of_node_put(eth1_node);
>>>       }
>>>         return ret;
>>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> index f5c1d473e9f9..b30f2e9a73d8 100644
>>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>>> @@ -257,6 +257,7 @@ struct icssg_firmwares {
>>>    * @is_switchmode_supported: indicates platform support for switch mode
>>>    * @switch_id: ID for mapping switch ports to bridge
>>>    * @default_vlan: Default VLAN for host
>>> + * @prus_running: flag to indicate if all pru cores are running
>>>    */
>>>   struct prueth {
>>>       struct device *dev;
>>> @@ -298,6 +299,7 @@ struct prueth {
>>>       int default_vlan;
>>>       /** @vtbl_lock: Lock for vtbl in shared memory */
>>>       spinlock_t vtbl_lock;
>>> +    bool prus_running;
>>
>> I think you don't need fw_running flag anymore. Could you please remove it
>> from struct prueth_emac?
>>
> 
> This flag is still being used by SR1, for which this patch doesn't apply. So I prefer not touching this flag for the sake of SR1.

ok let's leave it there then.

> 
>>>   };
>>>     struct emac_tx_ts_response {
>>> @@ -361,6 +363,8 @@ int icssg_set_port_state(struct prueth_emac *emac,
>>>                enum icssg_port_state_cmd state);
>>>   void icssg_config_set_speed(struct prueth_emac *emac);
>>>   void icssg_config_half_duplex(struct prueth_emac *emac);
>>> +void icssg_init_emac_mode(struct prueth *prueth);
>>> +void icssg_init_fw_offload_mode(struct prueth *prueth);
>>>     /* Buffer queue helpers */
>>>   int icssg_queue_pop(struct prueth *prueth, u8 queue);
>>> @@ -377,6 +381,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
>>>                  u8 untag_mask, bool add);
>>>   u16 icssg_get_pvid(struct prueth_emac *emac);
>>>   void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
>>> +int emac_fdb_flow_id_updated(struct prueth_emac *emac);
>>>   #define prueth_napi_to_tx_chn(pnapi) \
>>>       container_of(pnapi, struct prueth_tx_chn, napi_tx)
>>>   
>>

-- 
cheers,
-roger


