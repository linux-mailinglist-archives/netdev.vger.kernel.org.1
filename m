Return-Path: <netdev+bounces-127973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE69774B1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 01:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21118B22292
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0918891D;
	Thu, 12 Sep 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjFCp2ua"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD41C3F01;
	Thu, 12 Sep 2024 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182565; cv=none; b=OjGuVtehVWrjKuSiyvM+Yx+Cs7ZjPyLmfYVF0C969t3jocCeMMjaupbPmHsk9L9KtPNLINWGqd0DSpgF1bBgiy9BEaEw3oYZZ4oDHI2UMx0w2dXXS0AWl99thK+0e+Pl37x3lW+uaYdqKrx9XnJVMKVOjKlvRiIM5Uoq/vqhFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182565; c=relaxed/simple;
	bh=2mHtsjcOj2Hi4VOvaO4Dgx2l+8i/7H0YRDMb+4rryAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGipFcffA9pyxYt/y3MOxrwWJS0iP2ITL/B+ytJHDgLmutubpSUgaP5HbfhFymNJQrzSojaWFLlAZq54eklfMZC2dtzVVynylO+EgN9I08zwkrkx3glPf/FxLWPRepwfTtS2zr+Vuxr3zKFxNKd/FKH7FfqiLBtIHZffEjvzaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjFCp2ua; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726182564; x=1757718564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2mHtsjcOj2Hi4VOvaO4Dgx2l+8i/7H0YRDMb+4rryAA=;
  b=UjFCp2uabtHfLX3TTjLrpHEdwievsJKZzWz+Z9TlgEWO2TO2wiPALTqa
   qVBwhHwljEXvSg2rVoUkFRy14rs7fQNuVKWZHhcmVbPeYW0wQw1O+YQAx
   yA9+Dl6528uC/+aBvL7EtmK7oXVtQF9nh7+zD5kiAqIhNfOZN1SaiADLz
   u/hLIJN3vf6tufIIYnFGVCqZJHWZMXi8vkOjGQ26oFjkZNFRtuJvjHr4m
   cxcHfoK53Sq6+19bTPMZ7azrBZgojZ9ZLpM6NRpMd/ogPUGrJg8QG210C
   UK99Rv8imCwkdec+I+Hm6PrgrI4jMawnPkm1Z3OaEHu+s/ztUGagcHeNn
   A==;
X-CSE-ConnectionGUID: 4xXyByziT7+N4dpuNjLS/g==
X-CSE-MsgGUID: NQ3sDzs7THCey6YcrVWBPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="47584120"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="47584120"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 16:09:23 -0700
X-CSE-ConnectionGUID: byFTvP+6TC6yGpz1c09SDg==
X-CSE-MsgGUID: 4pweTmf4SmiRH3mxFBshpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="71974104"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO [10.125.108.93]) ([10.125.108.93])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 16:09:22 -0700
Message-ID: <339d40b0-95f7-4174-9d0e-a954dc23c164@intel.com>
Date: Thu, 12 Sep 2024 16:09:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/20] efx: use acquire_endpoint when looking for free
 HPA
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-13-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240907081836.5801-13-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Asking for availbale HPA space is the previous step to try to obtain
> an HPA range suitable to accel driver purposes.
> 
> Add this call to efx cxl initialization and use acquire_endpoint for
> avoiding potential races with cxl port creation.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx.c     |  8 +++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c | 32 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 3a7406aa950c..08a2f527df16 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -1117,10 +1117,16 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>  	 * used for PIO buffers. If there is no CXL support, or initialization
>  	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
>  	 * defined at specific PCI BAR regions will be used.
> +	 *
> +	 * The only error to handle is -EPROBE_DEFER happening if the root port
> +	 * is not there yet.
>  	 */
>  	rc = efx_cxl_init(efx);
> -	if (rc)
> +	if (rc) {
> +		if (rc == -EPROBE_DEFER)
> +			goto fail2;
>  		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
> +	}
>  
>  	rc = efx_pci_probe_post_io(efx);
>  	if (rc) {
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 899bc823a212..826759caa552 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -23,6 +23,7 @@ int efx_cxl_init(struct efx_nic *efx)
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> +	resource_size_t max;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -90,7 +91,38 @@ int efx_cxl_init(struct efx_nic *efx)
>  		goto err;
>  	}
>  
> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
> +	if (IS_ERR(cxl->endpoint)) {
> +		rc = PTR_ERR(cxl->endpoint);
> +		if (rc != -EPROBE_DEFER) {
> +			pci_err(pci_dev, "CXL accel acquire endpoint failed");
> +			goto err;
> +		}

What happens if (rc == -EPROBE_DEFER)? Here it drops down but you don't have a valid cxl->endpoint when cxl_get_hpa_freespace() is called.

DJ
 
> +	}
> +
> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->endpoint,
> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> +					   &max);
> +
> +	if (IS_ERR(cxl->cxlrd)) {
> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
> +		rc = PTR_ERR(cxl->cxlrd);
> +		goto err_release;
> +	}
> +
> +	if (max < EFX_CTPIO_BUFFER_SIZE) {
> +		pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
> +			__func__, max, EFX_CTPIO_BUFFER_SIZE);
> +		rc = -ENOSPC;
> +		goto err;
> +	}
> +
> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
> +
>  	return 0;
> +
> +err_release:
> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  err:
>  	kfree(cxl->cxlds);
>  	kfree(cxl);

