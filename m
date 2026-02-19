Return-Path: <netdev+bounces-259608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHfWG16dl2nU2wIAu9opvQ
	(envelope-from <netdev+bounces-259608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:31:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB416389D
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2BA3026177
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5F2D0C94;
	Thu, 19 Feb 2026 23:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8xaEcLT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810832E6CAB;
	Thu, 19 Feb 2026 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771543894; cv=none; b=D9p6t7lLxG5iYAZlapT6800rWFkp9Ays8WUKO4MnmA6guYI9GSJh0JlU7t1l30iAVUaKyXqp91C1uWYDE+mzhwUAEdPFXA+zAODQWc7NhBTCAqNtU7fGWysYrv/CPyW1h82jD005PeXuH9RTXGnfqU35caHlFSTa9d3tIbCOtKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771543894; c=relaxed/simple;
	bh=APB1wgNHiZm2zeetuzEUNgdc+71Sm5mfd0RgRrB0mbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7QrVO3wWRLk7s4ki28coNf1qD5x97PjleGyTIHMGEV2b+BjK5uVtfKuVEJNadLmMDr6/+kycyeCB7HQquQDDljKVsenY8Qm7ovUQ9cnScGP2ZkijzUWW9tTxEEUTEZofXmA56FTWRQvYa5lgZG5pFP+ihhHqsvCHG8e5ItGE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8xaEcLT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771543893; x=1803079893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=APB1wgNHiZm2zeetuzEUNgdc+71Sm5mfd0RgRrB0mbA=;
  b=m8xaEcLTAKGLXxG7roqfVFlBfw23Gz5e0YsfMjXFX8pqFQz1CRn+g4d7
   vxCujjAOMFcJDaQlIhXFls8lkuKyHXCM30QSXkuXW/s92ZNRs7D5HDEev
   AvKdGkWo5A+4ftwBoxp8IfsqEuum73Wc7xJfS+rQxJDJIrhWisQCR5DM4
   J2yhV99X51GsRuXJvi5VEPrYvY3BKPcMfZFQpkyAvd17Y/HcSt44A26bq
   KdglhimmimSpRQWb4eHSTcEDmRBsw0QD/6WNCThDovAQzVGhndMU08KiV
   n6tDp0daHaOTV6O7gblPghJnhEfEoDu9e8d2cj2u2P19QolvQkUNvlGbo
   w==;
X-CSE-ConnectionGUID: VLJDNJQ4TiKrCgcWgKSrdg==
X-CSE-MsgGUID: 0+VSVjZ8Rb22v4UNHCfvqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76507283"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76507283"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 15:31:32 -0800
X-CSE-ConnectionGUID: Gs0nNgoqSUarlIT/3nJMcw==
X-CSE-MsgGUID: eQHNuTrzRjSjS5Q24OzwlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218836281"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.20]) ([10.125.110.20])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 15:31:32 -0800
Message-ID: <817fca78-2416-44d9-9e1a-301e2a42e88c@intel.com>
Date: Thu, 19 Feb 2026 16:31:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 11/22] sfc: obtain decoder and region if committed by
 firmware
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259608-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 91BB416389D
X-Rspamd-Action: no action



On 2/1/26 8:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Check if device HDM is already committed during firmware/BIOS
> initialization.
> 
> A CXL region should exist if so after memdev allocation/initialization.
> Get HPA from region and map it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index a77ef4783fcb..3536eccf1b2a 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -90,13 +91,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> -	probe_data->cxl = cxl;
> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
> +	if (cxl->cxled) {

if (!cxl->cxled)
	return 0;

Should save you a level of indent.

DJ

> +		if (!cxl->efx_region) {
> +			pci_err(pci_dev, "CXL found committed decoder without a region");
> +			return -ENODEV;
> +		}
> +		rc = cxl_get_region_range(cxl->efx_region, &range);
> +		if (rc) {
> +			pci_err(pci_dev,
> +				"CXL getting regions params from a committed decoder failed");
> +			return rc;
> +		}
> +
> +		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);
> +		if (!cxl->ctpio_cxl) {
> +			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
> +			return -ENOMEM;
> +		}
> +
> +		probe_data->cxl = cxl;
> +	}
>  
>  	return 0;
>  }
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	if (!probe_data->cxl)
> +		return;
> +
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +	cxl_unregister_region(probe_data->cxl->efx_region);
>  }
>  
>  MODULE_IMPORT_NS("CXL");


