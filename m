Return-Path: <netdev+bounces-207651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FABB0811C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7CB1C2472A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63A289E16;
	Wed, 16 Jul 2025 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObFhaIu7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E56323E;
	Wed, 16 Jul 2025 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709730; cv=none; b=NBbcSWbkof1mDBfKRmuF69tJyN+3ZZAANdTANV5/hAWS0AU0O5ZtPYBLEpuFKZ/qvdXn9moMzGwAXgzEogt8WCP7rXrV5lV++7Nwp/VkiZFGHbTpr/J6YL9nfxFG+vK2w9M8qjuEoT5N9VgSFMqHa2GIaYRj0G7285QaPx2DpDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709730; c=relaxed/simple;
	bh=C+E6cEMFmE73z1xmVEJizqXJiuTHx26PyTKCRGFEUkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAM8yOjyS20TqzsdpogkTnHOqs1V07yotYZ0gvv+zimsd4E1OrTnBMpp38aL5ZZFBp5ycAs5YhBpnbdJkpM04uqGN3mRZc9JGmwWoD1oM0txOHMq5yqKQN9AAwJY//dhuQouiJcVXm6x5ySvyn6NVX13kRqujBOfwi/Rkj6JGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObFhaIu7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752709730; x=1784245730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C+E6cEMFmE73z1xmVEJizqXJiuTHx26PyTKCRGFEUkc=;
  b=ObFhaIu7NVlWv+TdPsLRrIJcaIG2q1pfhVgSxb/J2ZtNa35WYc4uj8Yz
   xu0nWtv94yYmjtdDk71EjrHuuSHWI9oQ5euEmkUD8vIGKpONUK1m+XWv2
   JC6KdhY8leqJJkN4OUQamPKTTdmcErAglRj1rvBN8nBHhdEOFXZNvx7jO
   o7TAEOrEH2/6WOAByZX/cNf/FBlzJX8PRRS67OiEgihHPPse1uoNBLktp
   NhqO2Xbn+9BSIb/Qb8l20MrFCeW2trG/3+4qFCnHAt3HpnsD9Orm5TNCE
   a0cp8tODwVCUTmgZZxqMlGLy2YewBYKkvnFVfrB719ZBzB+UKcKTo04Lu
   g==;
X-CSE-ConnectionGUID: eKlnUk2CR4OsG+Komhz8Eg==
X-CSE-MsgGUID: lOeW7uUXRXmVUCcjr/WsgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54846484"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="54846484"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 16:48:49 -0700
X-CSE-ConnectionGUID: /lBiErpCRyuShtCSPz/qlg==
X-CSE-MsgGUID: G3+9ot3rQ+y8EDVBnChywg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="158109502"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.193]) ([10.125.111.193])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 16:48:47 -0700
Message-ID: <34455187-6d0f-4050-8d98-6e23fe06eb96@intel.com>
Date: Wed, 16 Jul 2025 16:48:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 14/22] sfc: get endpoint decoder
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-15-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250624141355.269056-15-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/25 7:13 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

12/22 and 14/22 have the exact same subject line. Maybe modify one or both to avoid confusion. 

DJ

> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index c0adfd99cc78..ffbf0e706330 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -108,6 +108,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto put_root_decoder;
>  	}
>  
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (IS_ERR(cxl->cxled)) {
> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		rc = PTR_ERR(cxl->cxled);
> +		goto put_root_decoder;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	goto endpoint_release;
> @@ -121,8 +129,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
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


