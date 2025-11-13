Return-Path: <netdev+bounces-238531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 749BDC5AB11
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E59C34660B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DAF328B7A;
	Thu, 13 Nov 2025 23:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCIzOrXy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5E324B3A;
	Thu, 13 Nov 2025 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763077955; cv=none; b=SzDEysIVL+JQUsjekDl+TCsJg+3GRLGgvKc+9E12ZQhKwoUMJQ4cfZGsV85bVsY9C4D3cjMkouyQ+CaakyUGG/R9/LANnPAkZDm0GWf6AvHohSQ1b/DPV3jD5QXHpnpXY/wWBg96R+LTauRgKEQevYXldPFaAaEX42Y2YRGC+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763077955; c=relaxed/simple;
	bh=fMcJvzM+qDRJb5w+5+34G9+TfEhOvGHJYHhCDuOrGo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRvGTx/lNSskyoJXZ0mYD/C0jJ5uowd3UJj4kBjp82dE6vq6zZX4X3nQOB+i3+8H2iCLZdFBwGt3nGBfCCRMXCamdbVY+Wd5u1HOkWduBXPaJhozX6BT8RdRxLkybTygOf4qaqf1siid5TBcDrN0J1kl+NtiAMPR5W257b7iGbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCIzOrXy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763077955; x=1794613955;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fMcJvzM+qDRJb5w+5+34G9+TfEhOvGHJYHhCDuOrGo4=;
  b=aCIzOrXy3DTFjAARM9vO8TA/Fr/gfbubB0OjX3R+ZTQdlntGasYPTFS/
   yVcuxE9jT5wXXBSJI1prWEYFFiv6vkUeoNVlk6Sp1qZBAMXAO5jSFCg6j
   OyzCJiASjG2Hoey4/ZjeFiHFC8NeoaeR6YNtidHRdyHIbZGuQlqWNGPWS
   M8lxfo4ztLcZvQ6nxreb/lb2Jn+48ZP9PPg806g6b/u9nLqSf6kWr6wwZ
   7770OhCq1dYHgBP4DZ9YXh/Si139SYEJcWpVwmuEJi3yhdFxZK5WTj7gO
   mE7EUZUw1Jai+8WeJ1wtIqgx53oYRuC4AweFi/RVDwvTorJqa7sBa6Fb3
   w==;
X-CSE-ConnectionGUID: 0XtskbkzQeCGhVISABgdFg==
X-CSE-MsgGUID: //KVsE8GTVeqBpJCKC7zpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="87816678"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="87816678"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 15:52:34 -0800
X-CSE-ConnectionGUID: hp4zkYR+SR+m5PeIB7MsLg==
X-CSE-MsgGUID: +jSrfp67T26qwyWJ7FUE9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="189268207"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 15:52:32 -0800
Message-ID: <90b57a4c-77db-47b4-b0fb-bc6598187f7d@intel.com>
Date: Thu, 13 Nov 2025 16:52:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 14/22] sfc: get endpoint decoder
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-15-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251110153657.2706192-15-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 8:36 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index d7c34c978434..1a50bb2c0913 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENOSPC;
>  	}
>  
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR(cxl->cxled)) {
> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		cxl_put_root_decoder(cxl->cxlrd);
> +		return PTR_ERR(cxl->cxled);
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -115,8 +123,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> -	if (probe_data->cxl)
> +	if (probe_data->cxl) {
> +		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);
> +	}
>  }
>  
>  MODULE_IMPORT_NS("CXL");


