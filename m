Return-Path: <netdev+bounces-297330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v74GFaaRKGp1GQMAu9opvQ
	(envelope-from <netdev+bounces-297330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:20:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49666482D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:20:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="EouUsVm/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297330-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297330-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 206793017C11
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79543361DD0;
	Tue,  9 Jun 2026 22:18:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623915C14F;
	Tue,  9 Jun 2026 22:18:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043522; cv=none; b=hBf8xhy7nqQ3coSEB+VrB1cL8nPURZ2ZZDgnQW3GYdrL58NOi00oKb/0fwyBezmssqasG9mcsJ7g47jQuRO1SRF2ALNz0IJK9YzAYeJOdJghYvES+2T7LG9djdYDoffO4UF+3TsCmtUfkDtZSs0RMv45b4+sJ7BQzBQAMTqaLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043522; c=relaxed/simple;
	bh=ortTKqy2yA0lUmSdtfiwwMkPNmA2pjpSBDd8MwESzvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAZdTshgxsOfHwKM6CyfAOWqkhXqNnSGMqIO5R4WQYsv//Uv1BxP2lsYwnOFRJBloStlKdai77ChOoKZTsHsu5gfEGHaEO+8JChEouX2MfXehtSmWJl4pbBme1GKBU4WLg9v8E6rtEgevLU6kx7VOshSb8ypTtyksWP0DMFyUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EouUsVm/; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781043521; x=1812579521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ortTKqy2yA0lUmSdtfiwwMkPNmA2pjpSBDd8MwESzvg=;
  b=EouUsVm/IMcICcEIBDu7ww9JRqS7s5ki7oyVZTenIbzH/xNdjKBDUDGb
   57jl5xECk+AeUanxZiz0wZC3dCXPBfeyrU9EzTFf8lTIL9oy39RE8/7Q7
   7XPv7McCJ8/RMuWzVzoWabTieQdJa/FLTt8IowDUSnPd3ecUuKHtMCiv+
   syVHyBmZlSdkfDgkFYr3DePvkt2Nyj1eGt6Uyf/3ExzEpzwNOc4TwfY+E
   kDaQmGLrZ1/mw5cY+t+EaWb6su2hHdTkA3zEXtcaFJU8oNrUU1wTSymUZ
   8Uz0xfh6q0H+QgugrUsDKufvs/P7j4c+CSOlFIQH0iID9DW0BoryJGzv2
   w==;
X-CSE-ConnectionGUID: GZg8GF1xS5WGYB/TjSQrwA==
X-CSE-MsgGUID: hoY7O10+QvekMcI7h0ruDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="80957031"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="80957031"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 15:18:40 -0700
X-CSE-ConnectionGUID: MaEguQVlQomWeMf0KWjTJA==
X-CSE-MsgGUID: mLNVlwYBTKenmEFbcxidAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="246017808"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.206]) ([10.125.109.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 15:18:38 -0700
Message-ID: <5f3911d5-da9a-4ad7-a42d-765b27f3dfa0@intel.com>
Date: Tue, 9 Jun 2026 15:18:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v27 5/5] sfc: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260609215755.8685-1-alejandro.lucero-palau@amd.com>
 <20260609215755.8685-6-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260609215755.8685-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297330-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A49666482D



On 6/9/26 2:57 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A PIO buffer is a region of device memory to which the driver can write a
> packet for TX, with the device handling the transmit doorbell without
> requiring a DMA for getting the packet data, which helps reducing latency
> in certain exchanges. With CXL mem protocol this latency can be lowered
> further.
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Add the disabling of those CXL-based PIO buffers if the callback for
> potential cxl endpoint removal by the CXL core happens.

^ This seems to be missing?


> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/ef10.c       | 43 ++++++++++++++++++++++-----
>  drivers/net/ethernet/sfc/efx.h        |  1 -
>  drivers/net/ethernet/sfc/net_driver.h |  2 ++
>  drivers/net/ethernet/sfc/nic.h        |  3 ++
>  4 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 7e04f115bbaa..b747411ffdd3 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
> @@ -24,6 +24,7 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <net/udp_tunnel.h>
> +#include "efx_cxl.h"
>  
>  /* Hardware control for EF10 architecture including 'Huntington'. */
>  
> @@ -106,7 +107,7 @@ static int efx_ef10_get_vf_index(struct efx_nic *efx)
>  
>  static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>  {
> -	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
> +	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V7_OUT_LEN);
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>  	size_t outlen;
>  	int rc;
> @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>  			  efx->num_mac_stats);
>  	}
>  
> +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
> +		nic_data->datapath_caps3 = 0;
> +	else
> +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
> +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
> +
>  	return 0;
>  }
>  
> @@ -1140,6 +1147,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	unsigned int channel_vis, pio_write_vi_base, max_vis;
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>  	unsigned int uc_mem_map_size, wc_mem_map_size;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_probe_data *probe_data;
> +#endif
>  	void __iomem *membase;
>  	int rc;
>  
> @@ -1263,8 +1273,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	iounmap(efx->membase);
>  	efx->membase = membase;
>  
> -	/* Set up the WC mapping if needed */
> -	if (wc_mem_map_size) {
> +	if (!wc_mem_map_size)
> +		goto skip_pio;
> +
> +	/* Set up the WC mapping */
> +
> +#ifdef CONFIG_SFC_CXL
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	if ((nic_data->datapath_caps3 &
> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
> +	    probe_data->cxl_pio_initialised) {
> +		/* Using PIO through CXL mapping */
> +		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl;
> +		nic_data->pio_write_vi_base = pio_write_vi_base;
> +
> +		probe_data->cxl_pio_in_use = true;

Don't think this is used anywhere.

DJ

> +	} else
> +#endif
> +	{
> +		/* Using legacy PIO BAR mapping */
>  		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
>  						  uc_mem_map_size,
>  						  wc_mem_map_size);
> @@ -1279,12 +1306,14 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  			nic_data->wc_membase +
>  			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
>  			 uc_mem_map_size);
> -
> -		rc = efx_ef10_link_piobufs(efx);
> -		if (rc)
> -			efx_ef10_free_piobufs(efx);
>  	}
>  
> +	rc = efx_ef10_link_piobufs(efx);
> +	if (rc)
> +		efx_ef10_free_piobufs(efx);
> +
> +skip_pio:
> +
>  	netif_dbg(efx, probe, efx->net_dev,
>  		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
>  		  &efx->membase_phys, efx->membase, uc_mem_map_size,
> diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
> index 45e191686625..057d30090894 100644
> --- a/drivers/net/ethernet/sfc/efx.h
> +++ b/drivers/net/ethernet/sfc/efx.h
> @@ -236,5 +236,4 @@ static inline bool efx_rwsem_assert_write_locked(struct rw_semaphore *sem)
>  
>  int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
>  		       bool flush);
> -
>  #endif /* EFX_EFX_H */
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index 3964b2c56609..bea4eecdf842 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1207,6 +1207,7 @@ struct efx_cxl;
>   * @efx: Efx NIC details
>   * @cxl: details of related cxl objects
>   * @cxl_pio_initialised: cxl initialization outcome.
> + * @cxl_pio_in_use: PIO using CXL mapping
>   */
>  struct efx_probe_data {
>  	struct pci_dev *pci_dev;
> @@ -1214,6 +1215,7 @@ struct efx_probe_data {
>  #ifdef CONFIG_SFC_CXL
>  	struct efx_cxl *cxl;
>  	bool cxl_pio_initialised;
> +	bool cxl_pio_in_use;
>  #endif
>  };
>  
> diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
> index ec3b2df43b68..7480f9995dfb 100644
> --- a/drivers/net/ethernet/sfc/nic.h
> +++ b/drivers/net/ethernet/sfc/nic.h
> @@ -152,6 +152,8 @@ enum {
>   *	%MC_CMD_GET_CAPABILITIES response)
>   * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
>   * %MC_CMD_GET_CAPABILITIES response)
> + * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
> + * %MC_CMD_GET_CAPABILITIES response)
>   * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
>   * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
>   * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
> @@ -187,6 +189,7 @@ struct efx_ef10_nic_data {
>  	bool must_check_datapath_caps;
>  	u32 datapath_caps;
>  	u32 datapath_caps2;
> +	u32 datapath_caps3;
>  	unsigned int rx_dpcpu_fw_id;
>  	unsigned int tx_dpcpu_fw_id;
>  	bool must_probe_vswitching;


