Return-Path: <netdev+bounces-238528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BEFC5A767
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD74E3433
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 23:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2317083C;
	Thu, 13 Nov 2025 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVDcnuTY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAE535CBAF;
	Thu, 13 Nov 2025 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763074941; cv=none; b=dK+pQlLYU0+ovRrQvYEtf2iZJfHmdIG01RRku+O90XiuhPbJs3KuD3UxVs7PD305GoI6GKx6HmjahvIRX27BErNjQd5CtrBqAm3STfl49gm6PvFt9JsKs0dczJwwhjyGwiq8p4vg45Ze5GtFI4LRcABn23n7tYNst0TlBTvMH40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763074941; c=relaxed/simple;
	bh=DyWYsaZEz7t0c8HZfsNXp25ayOL9loJAgdVRhz6czc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rLnTC3utVNZwvmFPplH9taM/idhWABL+VAMDq9GEqaj47yowRkfjZJStxRSH68iVxb/e88EghkQwHs05LugCJOZXP5y6sDTO+GkflnDbQYGvyhbbShAi5DLgGyjF+NBe/wFufzltzIzxtTpz7nELBU6acplBpt8WSIBAfNHB5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVDcnuTY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763074939; x=1794610939;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DyWYsaZEz7t0c8HZfsNXp25ayOL9loJAgdVRhz6czc8=;
  b=gVDcnuTY6jD13+MRpGSkwPdJ2dw82Y4mlUDdid0Nh/gtsRQbiHtJ8wpn
   n4+ZtJFsMk2oOufaByvJh2un0k6mKwhYJrFciovlbSZTMAQAS7rs5Eu8M
   4ro4lpXY4e/GLY3oOH7kybEUf04EBhtWe9S1z5MhBGSTrBR0Mb3szb/oO
   Wxqi/tWrW7qxEhSOwNKGeY+iv8PJFCzjbhl2FfzgdxwYMqRsTN+aO34CN
   eny28e6stRBxqkbifNTx6YY9kebpICPamstlAcw0k4+GQFpJvxym14w64
   N1WeYMjUmW6nQzzITVxEpfqju9E67VAk7WnuWg/RvWS313D7Zk9gz7j5T
   w==;
X-CSE-ConnectionGUID: kBwRq5mVQqiIhkrrEktSgw==
X-CSE-MsgGUID: q1lNYOUaSzibi0Q1FHsEmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="64877424"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="64877424"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 15:02:18 -0800
X-CSE-ConnectionGUID: 8evlDhm1Saq1pCC/vIxSTg==
X-CSE-MsgGUID: 2+QPXnK6R3CwKPIDX8qcVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="226953374"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 15:02:18 -0800
Message-ID: <00fd29f9-ff62-4581-8e8d-5980fb22bf7c@intel.com>
Date: Thu, 13 Nov 2025 16:02:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 03/22] cxl/mem: Introduce a memdev creation ->probe()
 operation
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-4-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251110153657.2706192-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/25 8:36 AM, alejandro.lucero-palau@amd.com wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Allow for a driver to pass a routine to be called in cxl_mem_probe()
> context. This ability mirrors the semantics of faux_device_create() and
> allows for the caller to run CXL-topology-attach dependent logic on behalf
> of the caller.
> 
> This capability is needed for CXL accelerator device drivers that need to
> make decisions about enabling CXL dependent functionality in the device, or
> falling back to PCIe-only operation.
> 
> The probe callback runs after the port topology is successfully attached
> for the given memdev.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

With your sign off tag added,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/memdev.c    |  5 ++++-
>  drivers/cxl/core/pci_drv.c   |  2 +-
>  drivers/cxl/cxlmem.h         |  9 ++++++++-
>  drivers/cxl/mem.c            | 27 +++++++++++++++++++++++++--
>  drivers/cxl/private.h        |  3 ++-
>  tools/testing/cxl/test/mem.c |  2 +-
>  6 files changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 14b4601faf66..45b5714651d0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1035,7 +1035,8 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> -struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> +				    const struct cxl_memdev_ops *ops)
>  {
>  	struct cxl_memdev *cxlmd __free(kfree) =
>  		kzalloc(sizeof(*cxlmd), GFP_KERNEL);
> @@ -1052,6 +1053,8 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds)
>  		return ERR_PTR(rc);
>  	cxlmd->id = rc;
>  	cxlmd->depth = -1;
> +	cxlmd->ops = ops;
> +	cxlmd->endpoint = ERR_PTR(-ENXIO);
>  	cxlmd->cxlds = cxlds;
>  	cxlds->cxlmd = cxlmd;
>  
> diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
> index bc3c959f7eb6..f43590062efd 100644
> --- a/drivers/cxl/core/pci_drv.c
> +++ b/drivers/cxl/core/pci_drv.c
> @@ -1007,7 +1007,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
>  
> -	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds, NULL);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 434031a0c1f7..e55f52a5598d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -34,6 +34,10 @@
>  	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
>  	 CXLMDEV_RESET_NEEDED_NOT)
>  
> +struct cxl_memdev_ops {
> +	int (*probe)(struct cxl_memdev *cxlmd);
> +};
> +
>  /**
>   * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
>   * @dev: driver core device object
> @@ -43,6 +47,7 @@
>   * @cxl_nvb: coordinate removal of @cxl_nvd if present
>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>   * @endpoint: connection to the CXL port topology for this memory device
> + * @ops: incremental caller specific probe routine
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
>   * @scrub_cycle: current scrub cycle set for this device
> @@ -59,6 +64,7 @@ struct cxl_memdev {
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_nvdimm *cxl_nvd;
>  	struct cxl_port *endpoint;
> +	const struct cxl_memdev_ops *ops;
>  	int id;
>  	int depth;
>  	u8 scrub_cycle;
> @@ -96,7 +102,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  }
>  
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds);
> +				       struct cxl_dev_state *cxlds,
> +				       const struct cxl_memdev_ops *ops);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,
>  				     struct cxl_memdev *cxlmd);
>  struct cxl_memdev_state;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 01a8e808196e..ebe17fb6bb82 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -144,6 +144,12 @@ static int cxl_mem_probe(struct device *dev)
>  			return rc;
>  	}
>  
> +	if (cxlmd->ops) {
> +		rc = cxlmd->ops->probe(cxlmd);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc = devm_cxl_memdev_edac_register(cxlmd);
>  	if (rc)
>  		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
> @@ -178,15 +184,17 @@ DEFINE_FREE(cxlmd_free, struct cxl_memdev *, __cxlmd_free(_T))
>   * devm_cxl_add_memdev - Add a CXL memory device
>   * @host: devres alloc/release context and parent for the memdev
>   * @cxlds: CXL device state to associate with the memdev
> + * @ops: optional operations to run in cxl_mem::{probe,remove}() context
>   *
>   * Upon return the device will have had a chance to attach to the
>   * cxl_mem driver, but may fail if the CXL topology is not ready
>   * (hardware CXL link down, or software platform CXL root not attached)
>   */
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds)
> +				       struct cxl_dev_state *cxlds,
> +				       const struct cxl_memdev_ops *ops)
>  {
> -	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds);
> +	struct cxl_memdev *cxlmd __free(cxlmd_free) = cxl_memdev_alloc(cxlds, ops);
>  	int rc;
>  
>  	if (IS_ERR(cxlmd))
> @@ -200,6 +208,21 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	/*
> +	 * If ops is provided fail if the driver is not attached upon
> +	 * return. The ->endpoint ERR_PTR may have a more precise error
> +	 * code to convey. Note that failure here could be the result of
> +	 * a race to teardown the CXL port topology. I.e.
> +	 * cxl_mem_probe() could have succeeded and then cxl_mem unbound
> +	 * before the lock is acquired.
> +	 */
> +	guard(device)(&cxlmd->dev);
> +	if (ops && !cxlmd->dev.driver) {
> +		if (IS_ERR(cxlmd->endpoint))
> +			return ERR_CAST(cxlmd->endpoint);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
>  	return no_free_ptr(cxlmd);
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
> diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
> index f8d1ff64f534..7c04797a3a28 100644
> --- a/drivers/cxl/private.h
> +++ b/drivers/cxl/private.h
> @@ -8,7 +8,8 @@
>  
>  #ifndef __CXL_PRIVATE_H__
>  #define __CXL_PRIVATE_H__
> -struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> +				    const struct cxl_memdev_ops *ops);
>  int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd);
>  int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  			  struct cxl_dport *parent_dport);
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index d533481672b7..33d06ec5a4b9 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1768,7 +1768,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  
>  	cxl_mock_add_event_logs(&mdata->mes);
>  
> -	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds, NULL);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  


