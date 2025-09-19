Return-Path: <netdev+bounces-224894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38C5B8B4EF
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C35E7BB13C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D3A35942;
	Fri, 19 Sep 2025 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLvVR17O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E235F29BDAD;
	Fri, 19 Sep 2025 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316609; cv=none; b=f7Csve47lE/Sgnuf9OJG4ALfvGZu2Z+bCf8olD8QTIJ8frEbrXkrbqPnp3O1twUhVoCuwg57j2ZtdjSECUFZ3WDv7kg+xxV6v6uzWjt8MVxUIAL8oanTrxzt2OBXWi420eMvS+agHcngwe3HfyEj8zDDyJuTQIs66Y0axMjc/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316609; c=relaxed/simple;
	bh=wfxAEXzxYSVB6JGbbLrjBWCv+3t+tDPd3Mud0rEiZ9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMn0z5HR6SctKEQSXDl6duXf8nRYMDYgt/kMyAy3scoF363Tm2GjyIkDqwHBd7G1LCzhJqRW6PZv073+1CQIwpbo7FqqOx09u1fE0QcMVX8fftvLKktlReETt1CtLgTNiyWnI2f4cRrBqag/viza2AWdlXD/VpfH06vZ1P2Kqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLvVR17O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758316607; x=1789852607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wfxAEXzxYSVB6JGbbLrjBWCv+3t+tDPd3Mud0rEiZ9k=;
  b=MLvVR17Olhu5v2/imKFLsrRqUdD+vib5Meg3Dp8SbN6f/6PTlrpcBAh2
   n1ossrcidEguqRbmGXa/Q7XjIShAk+JDnMqU/1OSL4L/gpFoyiFLf34ei
   NQgDOlgUi7NEemmHla8I+/yq17o2i1cSbuHfgvv9wfoWMqreZYt22W6Ly
   IbZqFhPU1V+d0Knj9qi8Ciq2Z2w33IVgZ48vcsyf79bJs+WVESxvQ8CKz
   hQ63rgWUOEdq7mWsID31VOru5DfKDc3NsBFCTDUCWtG3Iq5LRCuYoTgEE
   7Ku5cG/dLmQ0uYxvWbcPotW/gM3lsUJeZVm2wwP06SmbgGfrVUfMO4xbQ
   A==;
X-CSE-ConnectionGUID: f8HlL5kPQ9ijHKRtqgD43Q==
X-CSE-MsgGUID: hDvSiBrXS3+PxQGbyZg8cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60729664"
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="60729664"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 14:16:46 -0700
X-CSE-ConnectionGUID: ynLwOApYQ6mbTLuwinQ3QA==
X-CSE-MsgGUID: mTPbd37dTNmacQvDocUAeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,279,1751266800"; 
   d="scan'208";a="213080912"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.58]) ([10.125.108.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 14:16:45 -0700
Message-ID: <437d1457-8d75-4797-8cba-9489bf97cc5d@intel.com>
Date: Fri, 19 Sep 2025 14:16:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 17/20] cxl: Avoid dax creation for accelerators
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <daves@stgolabs.net>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-18-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918091746.2034285-18-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 20bd0c82806c..e39f272dd445 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3922,6 +3922,13 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
> +	 * Skip device-dax registration.
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM)
> +		return 0;
> +
>  	switch (cxlr->mode) {
>  	case CXL_PARTMODE_PMEM:
>  		rc = devm_cxl_region_edac_register(cxlr);


