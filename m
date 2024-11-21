Return-Path: <netdev+bounces-146692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581E9D508C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 17:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275C3282A18
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D83C47B;
	Thu, 21 Nov 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3OdoTvc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F25819A;
	Thu, 21 Nov 2024 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205766; cv=none; b=ptDXoPZ2EGRswZ2ZkXN5hICYGjGrzEUgACJhRxA+tENwr/Y/dGlXcV/D4/R2IaMObJzWPN/onDqhkGWn+16qw7TfMkKOvvCO+m1AruhRlEhl70qERZhIxz5pf/OkR6M1FOJXA+/YZtaOxCVexkN5GqJuSe7estjneZ8N3X8Bgz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205766; c=relaxed/simple;
	bh=OiIC0qHEaChCniCOc5MXZ/hJqShD3zHdr3zeQ7gIsrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHn3/r5vrL9VmgtdXpJCcEVHDx1CcaI8CAYBii5gx3JQs9BXVcnI+YvcbpMAUaLXC6mWloWBaXFvoIfKdPtNO1U0rJ0Pq5fYaxB7/ziCvbQKrDxOBAaqXJ9gfokQD0j2R0w9RMUjrIZCmDBk+nD1xQOoTy0T0LOcO8I7eKfvUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3OdoTvc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732205763; x=1763741763;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OiIC0qHEaChCniCOc5MXZ/hJqShD3zHdr3zeQ7gIsrs=;
  b=g3OdoTvc0XP1z6qxBTDB3Two3EVO/gFKEfPuv45ccTu5gU8pzLV4iitX
   Kzg7DOkSrtQbAlQvInZGqBGeu38EJl3/jVwFZD9lu/uH4ZqWMkg7CLsqV
   uypcDDoSRZHuhbXrJwdj5s/KC0HXoIEWD//ykIwp24F6ihiQDW/ErotrV
   ai7mIl/DXBjoZExe2aGpUm0SFgn/sZTmisaX605zMGuCSR2w5E469snAN
   aPwA6M1McE8vh+GrJTIr++RnMmZxm087rSW/MNGujEH6tWO3sMvKXuDqy
   KSf4XKwci268Mq78pRpkfdnP3XP6JeSacwTgHxbD5lxvGjbFSpfqKyL90
   w==;
X-CSE-ConnectionGUID: tqZuMXh2RU2VUL0t1KCU0Q==
X-CSE-MsgGUID: +xdiz9bOT7uvz2KX4hqfhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32446582"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32446582"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:16:02 -0800
X-CSE-ConnectionGUID: dvkAQR2xTuSL8PWEQ0GeOA==
X-CSE-MsgGUID: BUjM+sRdRNaurjcdrHKfmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90420764"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.245]) ([10.125.109.245])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 08:16:02 -0800
Message-ID: <e51f5a71-4c18-41f5-9c6e-1848a985383c@intel.com>
Date: Thu, 21 Nov 2024 09:16:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/27] cxl: make region type based on endpoint type
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-20-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-20-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
> Support for Type2 implies region type needs to be based on the endpoint
> type instead.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d107cc1b4350..8e2dbd15cfc0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2654,7 +2654,8 @@ static ssize_t create_ram_region_show(struct device *dev,
>  }
>  
>  static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> -					  enum cxl_decoder_mode mode, int id)
> +					  enum cxl_decoder_mode mode, int id,
> +					  enum cxl_decoder_type target_type)
>  {
>  	int rc;
>  
> @@ -2676,7 +2677,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
> +	return devm_cxl_add_region(cxlrd, id, mode, target_type);
>  }
>  
>  static ssize_t create_pmem_region_store(struct device *dev,
> @@ -2691,7 +2692,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
> +	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
> +			       CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -2711,7 +2713,8 @@ static ssize_t create_ram_region_store(struct device *dev,
>  	if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
> +	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
> +			       CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -3372,7 +3375,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> -				       atomic_read(&cxlrd->region_id));
> +				       atomic_read(&cxlrd->region_id),
> +				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {


