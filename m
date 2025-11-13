Return-Path: <netdev+bounces-238527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2D0C5A764
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4274B4E7878
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240367083C;
	Thu, 13 Nov 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRhkS6NI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3712DFA46;
	Thu, 13 Nov 2025 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074899; cv=none; b=sSXFUt+EGDgRivhyAJSeofS79mnkmGBIMWFTIoA0JVyEJwQ2ZDEof+13R0PnZaGeqDDVlwYqQoKHRkgJAiuiLa9hqRokhn+Obt2GEwYM0N2t/BNf8AtRkfWj8u2On+DMiR9t2z/6WtWziXF0RDzJLiB4uVKsaJLO9D+AnCRxWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074899; c=relaxed/simple;
	bh=PsuKt3wPDV946EgyadbfW2RnQHs/Wyg2s4jq1WTuux4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JVGqqX966o8vAcUQMbwrZj5Agtr5hmhXFT+8BY+D/zjRv3Xxt8E63yjUUDG0eurRMBXJkum7qXy7aDqyxfXoeNgF+vOHzjGVEAM2jEuSwdGffxluFMjmz3QqbS9RLar6A3PbQnpH2MG5VaCf3EtzwJKJtXKjgLHvuQX/GwTmzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRhkS6NI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763074897; x=1794610897;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PsuKt3wPDV946EgyadbfW2RnQHs/Wyg2s4jq1WTuux4=;
  b=GRhkS6NIvQYob1cTckOXY8Mb/wielSjd6FAB3jVlnjJlDCee75UjGQwy
   qrgVQKivVymkRtd/Mm04/yOOxClbKBtOZ8qelP+wM5fCE5WStRwlnN62+
   /CwFwbCwAtrAk6tB4qZn1XVTOl1Itdns9Ivet06uvE8QuFVBsA4QXj0if
   B+6eiU80X7GruzlLsEDcTWtec77jevOGVoj7TdH3IBSFTKocLTqAXYZQB
   jMKzEbgSH6+W6UNEycdH7+GhRvsj3jBiAWwLKFFkfIS0b1iig534mHRtr
   RfgjOdkTrVCft4ybkyG3bWDQFYrcKFAzgHpRVBqDwgX2Ji9LClz1Nq33r
   g==;
X-CSE-ConnectionGUID: 6WvPxfBZTNu7gO0tf3nuTA==
X-CSE-MsgGUID: YdEnOB/vTwm0s2Ly1ZQvkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="64877253"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="64877253"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 15:01:36 -0800
X-CSE-ConnectionGUID: FsaW+SOcRVGu9B6MzJbCPg==
X-CSE-MsgGUID: AaHbLa01SyW2oMtCQFfnJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="226953241"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 15:01:36 -0800
Message-ID: <451b8f43-e03d-44d1-826e-ffabb770f873@intel.com>
Date: Thu, 13 Nov 2025 16:01:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/22] cxl/port: Arrange for always synchronous
 endpoint attach
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-3-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251110153657.2706192-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 8:36 AM, alejandro.lucero-palau@amd.com wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Make it so that upon return from devm_cxl_add_endpoint() that
> cxl_mem_probe() can assume that the endpoint has had a chance to complete
> cxl_port_probe().
> 
> I.e. cxl_port module loading has completed prior to device registration.
> 
> MODULE_SOFTDEP() is not sufficient for this purpose, but a hard link-time
> dependency is reliable.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

With your sign off tag added,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/mem.c     | 38 --------------------------------------
>  drivers/cxl/port.c    | 41 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/private.h |  7 ++++++-
>  3 files changed, 47 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fa5d901ee817..01a8e808196e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -46,44 +46,6 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>  	return 0;
>  }
>  
> -static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> -				 struct cxl_dport *parent_dport)
> -{
> -	struct cxl_port *parent_port = parent_dport->port;
> -	struct cxl_port *endpoint, *iter, *down;
> -	int rc;
> -
> -	/*
> -	 * Now that the path to the root is established record all the
> -	 * intervening ports in the chain.
> -	 */
> -	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
> -	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
> -		struct cxl_ep *ep;
> -
> -		ep = cxl_ep_load(iter, cxlmd);
> -		ep->next = down;
> -	}
> -
> -	/* Note: endpoint port component registers are derived from @cxlds */
> -	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
> -				     parent_dport);
> -	if (IS_ERR(endpoint))
> -		return PTR_ERR(endpoint);
> -
> -	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
> -	if (rc)
> -		return rc;
> -
> -	if (!endpoint->dev.driver) {
> -		dev_err(&cxlmd->dev, "%s failed probe\n",
> -			dev_name(&endpoint->dev));
> -		return -ENXIO;
> -	}
> -
> -	return 0;
> -}
> -
>  static int cxl_debugfs_poison_inject(void *data, u64 dpa)
>  {
>  	struct cxl_memdev *cxlmd = data;
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 51c8f2f84717..ef65d983e1c8 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -6,6 +6,7 @@
>  
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> +#include "private.h"
>  
>  /**
>   * DOC: cxl port
> @@ -156,10 +157,50 @@ static struct cxl_driver cxl_port_driver = {
>  	.probe = cxl_port_probe,
>  	.id = CXL_DEVICE_PORT,
>  	.drv = {
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  		.dev_groups = cxl_port_attribute_groups,
>  	},
>  };
>  
> +int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> +				 struct cxl_dport *parent_dport)
> +{
> +	struct cxl_port *parent_port = parent_dport->port;
> +	struct cxl_port *endpoint, *iter, *down;
> +	int rc;
> +
> +	/*
> +	 * Now that the path to the root is established record all the
> +	 * intervening ports in the chain.
> +	 */
> +	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
> +	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
> +		struct cxl_ep *ep;
> +
> +		ep = cxl_ep_load(iter, cxlmd);
> +		ep->next = down;
> +	}
> +
> +	/* Note: endpoint port component registers are derived from @cxlds */
> +	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
> +				     parent_dport);
> +	if (IS_ERR(endpoint))
> +		return PTR_ERR(endpoint);
> +
> +	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
> +	if (rc)
> +		return rc;
> +
> +	if (!endpoint->dev.driver) {
> +		dev_err(&cxlmd->dev, "%s failed probe\n",
> +			dev_name(&endpoint->dev));
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_endpoint, "CXL");
> +
>  static int __init cxl_port_init(void)
>  {
>  	return cxl_driver_register(&cxl_port_driver);
> diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
> index 50c2ac57afb5..f8d1ff64f534 100644
> --- a/drivers/cxl/private.h
> +++ b/drivers/cxl/private.h
> @@ -1,10 +1,15 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Copyright(c) 2025 Intel Corporation. */
>  
> -/* Private interfaces betwen common drivers ("cxl_mem") and the cxl_core */
> +/*
> + * Private interfaces betwen common drivers ("cxl_mem", "cxl_port") and
> + * the cxl_core.
> + */
>  
>  #ifndef __CXL_PRIVATE_H__
>  #define __CXL_PRIVATE_H__
>  struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
>  int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd);
> +int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> +			  struct cxl_dport *parent_dport);
>  #endif /* __CXL_PRIVATE_H__ */



