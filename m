Return-Path: <netdev+bounces-75048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C77B867EA8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C317F1F27F8F
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916112F370;
	Mon, 26 Feb 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUH0NZmX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FAD12B166
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968826; cv=none; b=J8dfiVE5/mqQyo39w98MNh9LRXqDOhRuaKLluppomgCdtKG/qDWJiC+6r7zY7TtbpXNX+jBMr/V2ITPacVuHHErkjE2+6uAsofZS6oICBYLO39daIO16KAWivmasKELxOq6tY3YNHzW3en84qkgNE7e8uV6C1ZJ31zqlf4/3Y/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968826; c=relaxed/simple;
	bh=qOUf56nkYtl86RnmbZaa01I46To4o8PzejS9/EKb/4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUj9zYHCNblYwEMmuopZrtDwrgT+xJV4X8ErupFegMCxbNafVu6HecXCBdlZ759U47m7mc+8thIG/Yd8LwSlKTi3WBtsuowRB/Sf50pyyqhibEFrFTzU+o3by7V5SjJVYk75EqRbDah7+rCxibpRrNPQVPIz0/yvm/VxsE104R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUH0NZmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7941FC433C7;
	Mon, 26 Feb 2024 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708968826;
	bh=qOUf56nkYtl86RnmbZaa01I46To4o8PzejS9/EKb/4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lUH0NZmXf0ApJ2fOlwWmbfhIq3ZCS3AzUWLcKi2jDUc7Wzj5fNq4o5uKaINQZv1jV
	 w7g6gHJWDvArv6iGb3VnCXJGY1aMaYKJEw3DDJYKQ5XteEXZhNCq/1rWREPH5eI7gh
	 TNfsyH2jl8t2OvDiGpjDpMzDr5C5WymISnKaFnvtqmbsPCX4qia7EXq1VDBe5JiaK/
	 cVpWhjBL/jmvGI9c+wwHcrJZxaamKB7PfQDHGzXglJ21a8yZjV0lRQ0zrux8enfsFx
	 gK7Wh8vp6I64N/iWVDiR+uirRHARGgByreht4rK0JO3lPV4yl9VBavMtblU9OyUjDT
	 eY1Xe9UcC/1vA==
Message-ID: <0105d616-8e38-471b-a114-f125c16bdef4@kernel.org>
Date: Mon, 26 Feb 2024 19:33:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 09/10] net: ti: icssg-prueth: Modify common
 functions for SR1.0
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, dan.carpenter@linaro.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-10-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240221152421.112324-10-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/02/2024 17:24, Diogo Ivo wrote:
> Some parts of the logic differ only slightly between Silicon Revisions.
> In these cases add the bits that differ to a common function that
> executes those bits conditionally based on the Silicon Revision.
> 
> Based on the work of Roger Quadros, Vignesh Raghavendra and
> Grygorii Strashko in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 46 +++++++++++++++-----
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c |  4 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +-
>  3 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 99f27ecc9352..d4488cf5d7da 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -152,6 +152,13 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  						     desc_dma);
>  		swdata = cppi5_hdesc_get_swdata(desc_tx);
>  
> +		/* was this command's TX complete? */
> +		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
> +			prueth_xmit_free(tx_chn, desc_tx);
> +			budget++;       /* not a data packet */
> +			continue;
> +		}
> +
>  		skb = *(swdata);
>  		prueth_xmit_free(tx_chn, desc_tx);
>  
> @@ -327,6 +334,7 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  	struct net_device *ndev = emac->ndev;
>  	u32 fdqring_id, hdesc_size;
>  	int i, ret = 0, slice;
> +	int flow_id_base;
>  
>  	slice = prueth_emac_slice(emac);
>  	if (slice < 0)
> @@ -367,8 +375,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  		goto fail;
>  	}
>  
> -	emac->rx_flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
> -	netdev_dbg(ndev, "flow id base = %d\n", emac->rx_flow_id_base);
> +	flow_id_base = k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
> +	if (!strcmp(name, "rxmgm")) {

if (emac->is_sr1 && !strcmp(name, "rxmgm")) ?

> +		emac->rx_mgm_flow_id_base = flow_id_base;
> +		netdev_dbg(ndev, "mgm flow id base = %d\n", flow_id_base);
> +	} else {
> +		emac->rx_flow_id_base = flow_id_base;
> +		netdev_dbg(ndev, "flow id base = %d\n", flow_id_base);
> +	}
>  
>  	fdqring_id = K3_RINGACC_RING_ID_ANY;
>  	for (i = 0; i < rx_cfg.flow_id_num; i++) {
> @@ -477,10 +491,14 @@ void emac_rx_timestamp(struct prueth_emac *emac,
>  	struct skb_shared_hwtstamps *ssh;
>  	u64 ns;
>  
> -	u32 hi_sw = readl(emac->prueth->shram.va +
> -			  TIMESYNC_FW_WC_COUNT_HI_SW_OFFSET_OFFSET);
> -	ns = icssg_ts_to_ns(hi_sw, psdata[1], psdata[0],
> -			    IEP_DEFAULT_CYCLE_TIME_NS);
> +	if (emac->is_sr1) {
> +		ns = (u64)psdata[1] << 32 | psdata[0];
> +	} else {
> +		u32 hi_sw = readl(emac->prueth->shram.va +
> +				  TIMESYNC_FW_WC_COUNT_HI_SW_OFFSET_OFFSET);
> +		ns = icssg_ts_to_ns(hi_sw, psdata[1], psdata[0],
> +				    IEP_DEFAULT_CYCLE_TIME_NS);
> +	}
>  
>  	ssh = skb_hwtstamps(skb);
>  	memset(ssh, 0, sizeof(*ssh));
> @@ -809,7 +827,8 @@ void prueth_emac_stop(struct prueth_emac *emac)
>  	}
>  
>  	emac->fw_running = 0;
> -	rproc_shutdown(prueth->txpru[slice]);
> +	if (!emac->is_sr1)
> +		rproc_shutdown(prueth->txpru[slice]);
>  	rproc_shutdown(prueth->rtu[slice]);
>  	rproc_shutdown(prueth->pru[slice]);
>  }
> @@ -829,8 +848,10 @@ void prueth_cleanup_tx_ts(struct prueth_emac *emac)
>  int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>  {
>  	struct prueth_emac *emac = prueth_napi_to_emac(napi_rx);
> -	int rx_flow = PRUETH_RX_FLOW_DATA;
> -	int flow = PRUETH_MAX_RX_FLOWS;
> +	int rx_flow = emac->is_sr1 ?
> +		PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
> +	int flow = emac->is_sr1 ?
> +		PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
>  	int num_rx = 0;
>  	int cur_budget;
>  	int ret;
> @@ -1082,7 +1103,7 @@ void prueth_netdev_exit(struct prueth *prueth,
>  	prueth->emac[mac] = NULL;
>  }
>  
> -int prueth_get_cores(struct prueth *prueth, int slice)
> +int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1)
>  {
>  	struct device *dev = prueth->dev;
>  	enum pruss_pru_id pruss_id;
> @@ -1096,7 +1117,7 @@ int prueth_get_cores(struct prueth *prueth, int slice)
>  		idx = 0;
>  		break;
>  	case ICSS_SLICE1:
> -		idx = 3;
> +		idx = is_sr1 ? 2 : 3;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1118,6 +1139,9 @@ int prueth_get_cores(struct prueth *prueth, int slice)
>  		return dev_err_probe(dev, ret, "unable to get RTU%d\n", slice);
>  	}
>  
> +	if (is_sr1)
> +		return 0;
> +
>  	idx++;
>  	prueth->txpru[slice] = pru_rproc_get(np, idx, NULL);
>  	if (IS_ERR(prueth->txpru[slice])) {
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 7d9db9683e18..5eab0657494c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -907,13 +907,13 @@ static int prueth_probe(struct platform_device *pdev)
>  	}
>  
>  	if (eth0_node) {
> -		ret = prueth_get_cores(prueth, ICSS_SLICE0);
> +		ret = prueth_get_cores(prueth, ICSS_SLICE0, true);

Isn't this SR2.0 device driver? so is_sr1 parameter should be false?

>  		if (ret)
>  			goto put_cores;
>  	}
>  
>  	if (eth1_node) {
> -		ret = prueth_get_cores(prueth, ICSS_SLICE1);
> +		ret = prueth_get_cores(prueth, ICSS_SLICE1, true);

here too?

>  		if (ret)
>  			goto put_cores;
>  	}
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index faefd9351c39..d706460f2ca3 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -354,7 +354,7 @@ int prueth_node_port(struct device_node *eth_node);
>  int prueth_node_mac(struct device_node *eth_node);
>  void prueth_netdev_exit(struct prueth *prueth,
>  			struct device_node *eth_node);
> -int prueth_get_cores(struct prueth *prueth, int slice);
> +int prueth_get_cores(struct prueth *prueth, int slice, bool is_sr1);
>  void prueth_put_cores(struct prueth *prueth, int slice);
>  
>  /* Revision specific helper */

-- 
cheers,
-roger

