Return-Path: <netdev+bounces-238535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AECCC5AB42
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0C8E351C4E
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746472940D;
	Fri, 14 Nov 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSR5/kmo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82645A927;
	Fri, 14 Nov 2025 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763078620; cv=none; b=AUWfwhJTyHxSP8SKBOYpRskSH9Ru18kFWLjKV0KS5PskoQ3Thx0kimx3A+O6AY9Yk3SOWRQl9MQql7ebd4n6CzshzWXVL2XNWcJ7R3JGvroiL7yEgn0Gaa3wCnj+K9A+Ig/OYY+7uHcCxu74egL2PDOdBuCLwkQjXdqWTroHCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763078620; c=relaxed/simple;
	bh=LwzntjbhpIVkcMx0OqXacybxBO+2jVBM6tJVyIlwxmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smfOCoNV13umUKPa39vbzzf+XHKW9pxUASZoR+nernvrBMlzWFAoprIjWMFL+3RJSGikmbEeG7MuFHJBFtVNyatQSml/s0QWB4QLRJXgMaJAxTaBNsdgATIbBGaM7HYC1qG2q33PSySF3QnsTqhcV56TGF8CL0oi85DeWzEJaBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSR5/kmo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763078618; x=1794614618;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LwzntjbhpIVkcMx0OqXacybxBO+2jVBM6tJVyIlwxmQ=;
  b=gSR5/kmo9WcjBB3hT+yQKMp2OfubNpJu84xt49Nv/cf+A43+Z97Qtgr3
   epCYJbVEvR/Uicza1dfwe51QyMVl5KWLbusuUDyp/iC+9RYMwaDRUA1eb
   4V8xN8+/0IuWCmrGbiw+FavFKbv7KnAFamDrVniMwEPSYw+tp/J8FjCDY
   LMbkJXoihqJzhSoyeIZ/z8zWArndxo2ocAh7sywG1ifvvUaJwBR3xb/ha
   xNae9f+6Gz855S25tgHPwC42z3K4xgXeMZWqYBCwqXrQRF1h4lq/zqK0C
   vX6J4b0j3IsypkfvoP9wX36hLIzwMXdwLE8GiaLo1OuwxD+EOKVirMrVe
   g==;
X-CSE-ConnectionGUID: MYY+4vH1SLuxv6wcSpMGyQ==
X-CSE-MsgGUID: FJ4tnofaSZiQVVXFH5n3zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65210629"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65210629"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 16:03:37 -0800
X-CSE-ConnectionGUID: OvPLqogDSNi1q1ldC+0ngA==
X-CSE-MsgGUID: ETcZEeGBSQqA9m+/Jwb5iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="189639641"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 16:03:36 -0800
Message-ID: <7e8d561c-a19c-4547-80be-c7ca457c7881@intel.com>
Date: Thu, 13 Nov 2025 17:03:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 22/22] sfc: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-23-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251110153657.2706192-23-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 8:36 AM, alejandro.lucero-palau@amd.com wrote:
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
> potential cxl endpoint removal by the CXL code happens.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/net/ethernet/sfc/ef10.c       | 50 +++++++++++++++++++++++----
>  drivers/net/ethernet/sfc/efx_cxl.c    | 31 ++++++++++++++---
>  drivers/net/ethernet/sfc/net_driver.h |  2 ++
>  drivers/net/ethernet/sfc/nic.h        |  3 ++
>  4 files changed, 75 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index fcec81f862ec..2bb6d3136c7c 100644
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
> @@ -919,6 +926,9 @@ static void efx_ef10_forget_old_piobufs(struct efx_nic *efx)
>  static void efx_ef10_remove(struct efx_nic *efx)
>  {
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_probe_data *probe_data;
> +#endif
>  	int rc;
>  
>  #ifdef CONFIG_SFC_SRIOV
> @@ -949,7 +959,12 @@ static void efx_ef10_remove(struct efx_nic *efx)
>  
>  	efx_mcdi_rx_free_indir_table(efx);
>  
> +#ifdef CONFIG_SFC_CXL
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	if (nic_data->wc_membase && !probe_data->cxl_pio_in_use)
> +#else
>  	if (nic_data->wc_membase)
> +#endif
>  		iounmap(nic_data->wc_membase);
>  
>  	rc = efx_mcdi_free_vis(efx);
> @@ -1140,6 +1155,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	unsigned int channel_vis, pio_write_vi_base, max_vis;
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>  	unsigned int uc_mem_map_size, wc_mem_map_size;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_probe_data *probe_data;
> +#endif
>  	void __iomem *membase;
>  	int rc;
>  
> @@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
> +		/* Using PIO through CXL mapping? */
> +		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl +
> +					   (pio_write_vi_base * efx->vi_stride +
> +					    ER_DZ_TX_PIOBUF - uc_mem_map_size);
> +		probe_data->cxl_pio_in_use = true;
> +	} else
> +#endif
> +	{
> +		/* Using legacy PIO BAR mapping */
>  		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
>  						  uc_mem_map_size,
>  						  wc_mem_map_size);
> @@ -1279,12 +1314,13 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
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
>  	netif_dbg(efx, probe, efx->net_dev,
>  		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
>  		  &efx->membase_phys, efx->membase, uc_mem_map_size,
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 79fe99d83f9f..a84ce45398c1 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -11,6 +11,7 @@
>  #include <cxl/pci.h>
>  #include "net_driver.h"
>  #include "efx_cxl.h"
> +#include "efx.h"
>  
>  #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>  
> @@ -20,6 +21,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	resource_size_t max_size;
>  	struct efx_cxl *cxl;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -119,19 +121,40 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
>  	if (IS_ERR(cxl->efx_region)) {
>  		pci_err(pci_dev, "CXL accel create region failed");
> -		cxl_put_root_decoder(cxl->cxlrd);
> -		cxl_dpa_free(cxl->cxled);
> -		return PTR_ERR(cxl->efx_region);
> +		rc = PTR_ERR(cxl->efx_region);
> +		goto err_dpa;
> +	}
> +
> +	rc = cxl_get_region_range(cxl->efx_region, &range);
> +	if (rc) {
> +		pci_err(pci_dev, "CXL getting regions params failed");
> +		goto err_detach;
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
> +		rc = -ENOMEM;
> +		goto err_detach;
>  	}
>  
>  	probe_data->cxl = cxl;
> +	probe_data->cxl_pio_initialised = true;
>  
>  	return 0;
> +
> +err_detach:
> +	cxl_decoder_detach(NULL, cxl->cxled, 0, DETACH_INVALIDATE);
> +err_dpa:
> +	cxl_put_root_decoder(cxl->cxlrd);
> +	cxl_dpa_free(cxl->cxled);
> +	return rc;
>  }
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> -	if (probe_data->cxl) {
> +	if (probe_data->cxl_pio_initialised) {
> +		iounmap(probe_data->cxl->ctpio_cxl);
>  		cxl_decoder_detach(NULL, probe_data->cxl->cxled, 0,
>  				   DETACH_INVALIDATE);
>  		cxl_dpa_free(probe_data->cxl->cxled);
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
> index 9fa5c4c713ab..c87cc9214690 100644
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
> @@ -186,6 +188,7 @@ struct efx_ef10_nic_data {
>  	bool must_check_datapath_caps;
>  	u32 datapath_caps;
>  	u32 datapath_caps2;
> +	u32 datapath_caps3;
>  	unsigned int rx_dpcpu_fw_id;
>  	unsigned int tx_dpcpu_fw_id;
>  	bool must_probe_vswitching;


