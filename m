Return-Path: <netdev+bounces-207638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EACB080B3
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF811896DBD
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ADC2EE966;
	Wed, 16 Jul 2025 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsnahU3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D8194A65;
	Wed, 16 Jul 2025 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706336; cv=none; b=Y26dYCcX9PnLpBbTCWIO6uBjN0YHsHP1xZhmx3T/SOlAezR6mcdUaWFVBYhhaqO6fFZ7O/JC2gGpsT1OLe55bUC0Gx6vRa2ucsBm+H6+txZnPiBGhOhT7qJ7TMlk0rXWJ/oXYbT7B4L64+ncfyA6/FZsgFv0ibDs74QUi8Cy77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706336; c=relaxed/simple;
	bh=2uwhbsvGFETcdpUqnjKaZc/H/gOzRQsVm/jpht4Wzwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErrAr2GjEpFntUER0XxMdFh8rKcdDYSxVIyOtDLBFbqoPFimiiNt3vVBCMTqjSS85O/cTcjxE4MXx6q4Gc4oIambL9g9MObhDzpqo60u+fcjqVh1y9eOkeqxU+tNr1Q/Y7T7g7JVH2C7zvcj66gFQfkbY+IrjwPPG1KW0HGaUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsnahU3Q; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752706334; x=1784242334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2uwhbsvGFETcdpUqnjKaZc/H/gOzRQsVm/jpht4Wzwo=;
  b=NsnahU3Q1h3sQYdqIdLh9CgGWqkQb90yIBytCMZGLaorlgkQaHgPP3Ey
   RySn/rACJxZ+BljaeVbx2ZYtY04m1wwxXyrkSTYZNqbnoF0219PNVoDON
   p47jkpAGOgfHN297PXmU3aTyVCfOeDKRzK8TcBYOqII6bS+ebc/ELs4Tb
   8dntB1D/rjHVhPPpHsFmzIONUMit1C1i+NOHjXuJNdOlqDX/rO9xjYVxK
   6Uv+nMEK87aMm7duiw3BLxnYEQFHSIrhfJiduGCWmlIn5xL7hN/w6Yy+L
   AJ4Den6cNnkRe46GWzfkhXeuIpMZFwkQI7NvFkittVdw/y2ucPLsdARdw
   A==;
X-CSE-ConnectionGUID: PtwgkpGsTWCBs50vlwQ+2g==
X-CSE-MsgGUID: NX51/kQuR4qUAf64PAZf4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55059203"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="55059203"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 15:52:13 -0700
X-CSE-ConnectionGUID: BrbkwENoSH+nREL15mlPbg==
X-CSE-MsgGUID: S9TmOYLAR0utBq17nPnwqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157032345"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.193]) ([10.125.111.193])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 15:52:13 -0700
Message-ID: <d439e0c2-837f-4d0e-967c-3e41e5788bf8@intel.com>
Date: Wed, 16 Jul 2025 15:52:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 10/22] cx/memdev: Indicate probe deferral
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250624141355.269056-11-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/25 7:13 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> The first step for a CXL accelerator driver that wants to establish new
> CXL.mem regions is to register a 'struct cxl_memdev'. That kicks off
> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
> topology up to the root.
> 
> If the port driver has not attached yet the expectation is that the
> driver waits until that link is established. The common cxl_pci driver
> has reason to keep the 'struct cxl_memdev' device attached to the bus
> until the root driver attaches. An accelerator may want to instead defer
> probing until CXL resources can be acquired.
> 
> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when a
> accelerator driver probing should be deferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Just noticed this. The subject needs a fix

s/cx/cxl/

DJ

> ---
>  drivers/cxl/core/memdev.c | 42 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c   |  2 +-
>  drivers/cxl/mem.c         |  7 +++++--
>  include/cxl/cxl.h         |  2 ++
>  4 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f43d2aa2928e..e2c6b5b532db 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1124,6 +1124,48 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited
> + * a probe deferral awaiting the arrival of the CXL root driver.
> + */
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);
> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		goto err_endpoint;
> +
> +	return endpoint;
> +
> +err_endpoint:
> +	device_unlock(&endpoint->dev);
> +err:
> +	device_unlock(&cxlmd->dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_acquire_endpoint, "CXL");
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_endpoint, "CXL");
> +
>  static void sanitize_teardown_notifier(void *data)
>  {
>  	struct cxl_memdev_state *mds = data;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 9acf8c7afb6b..fa10a1643e4c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1563,7 +1563,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		 */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 7f39790d9d98..cda0b2ff73ce 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -148,14 +148,17 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	if (rc) {
> +		cxlmd->endpoint = ERR_PTR(rc);
>  		return rc;
> +	}
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
>  		cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
> -		return -ENXIO;
> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
> +		return -EPROBE_DEFER;
>  	}
>  
>  	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index fcdf98231ffb..2928e16a62e2 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -234,4 +234,6 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  void cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlmds);
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  #endif /* __CXL_CXL_H__ */


