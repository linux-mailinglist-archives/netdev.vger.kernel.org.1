Return-Path: <netdev+bounces-112265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D436937CC9
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 21:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B85B2155D
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 19:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8371474BE;
	Fri, 19 Jul 2024 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXjt3SrC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FB8C06;
	Fri, 19 Jul 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415684; cv=none; b=cmYvzXof64grxolZCX4WuJ3LCiGS/UiYBFgstwevunLMpiTa+Sm9OWwGHE0A7DrdOWqQELk2jTX4qQOTvD9A54FgdtV9AkZzKhkYHpBbwQ1CoyArquAynM5v8XCViwiFSUNN++z90tVA0wW/z1kMy385TpOTCJEnJLx8N6HErt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415684; c=relaxed/simple;
	bh=t8wJxfySrx9yT+L43uDzmQbZIng5UQmL699Jdm9hlDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlIcu2VjQpxwX5MFIHiiRmsQfzjpv+9sXy+sZR1vt4k54ppddmN7vusEb7QRvfG59JkJMw9B6dAdOKHR4i81mOuG/xrA29U4YDVSgZw+3S70w+A+fl1VVabPtUy6oV7xWhbx56r1v3uWstLpOnHoQocnXOWTpqrUhb8aVPj7KtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXjt3SrC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721415682; x=1752951682;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t8wJxfySrx9yT+L43uDzmQbZIng5UQmL699Jdm9hlDs=;
  b=GXjt3SrCJDrYaxpmYplcHw+LCkwXy1afUOErDQZvpy0kyemwM2hls5/E
   FFxu82739P3e7IFvISRj0hrkuoLa+AkT5b1tZhelKrOz58cA+42SBlVXM
   C3pf0oND2GVlo4EMTMgWMHp3vo837ckUMsZgHKNKAwZm/cI6CuLCinH1v
   Qnl8wKSdy2DZGY10NPHR/R3leLzad6IKHU3TK8ZMvwGzWv/wqBRfBxfIV
   MiHGPV7JU3lxilaad6cGwMKiIKdDcIEZTbBTUcmZt+VnBn7qwnBrFhb3r
   Fz9voag7mMKl3MGp3hN19IWfJetbrcWLaWmg5tJWl0UsYw6nCMqck/RNm
   A==;
X-CSE-ConnectionGUID: kg4VJkajRS6x+5n89laq+A==
X-CSE-MsgGUID: dns5tlWfQZ+DDarDMb5QKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="41574091"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="41574091"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 12:01:21 -0700
X-CSE-ConnectionGUID: rCxvpFuyRYCM0C2p0GJP4w==
X-CSE-MsgGUID: wZlS/KHrRiacth6tuS/O9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="56046735"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.46]) ([10.125.109.46])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 12:01:20 -0700
Message-ID: <e3ea1b1a-8439-40c6-99bf-4151ecf4d04f@intel.com>
Date: Fri, 19 Jul 2024 12:01:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240715172835.24757-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/24 10:28 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what a CXL accelerator
> implements.
> 
> Add a new field for keeping device capabilities to be initialised by
> Type2 drivers. Advertise all those capabilities for Type3.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/mbox.c            |  1 +
>  drivers/cxl/core/memdev.c          |  4 +++-
>  drivers/cxl/core/port.c            |  2 +-
>  drivers/cxl/core/regs.c            | 11 ++++++-----
>  drivers/cxl/cxl.h                  |  2 +-
>  drivers/cxl/cxlmem.h               |  4 ++++
>  drivers/cxl/pci.c                  | 15 +++++++++------
>  drivers/net/ethernet/sfc/efx_cxl.c |  3 ++-
>  include/linux/cxl_accel_mem.h      |  5 ++++-
>  9 files changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..2ba7d36e3f38 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1424,6 +1424,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->cxlds.reg_map.host = dev;
>  	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> +	mds->cxlds.capabilities = CXL_DRIVER_CAP_HDM | CXL_DRIVER_CAP_MBOX;
>  	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 04c3a0f8bc2e..b4205ecca365 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -616,7 +616,7 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> -struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev, uint8_t caps)
>  {
>  	struct cxl_dev_state *cxlds;
>  
> @@ -631,6 +631,8 @@ struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>  	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>  	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>  
> +	cxlds->capabilities = caps;
> +
>  	return cxlds;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 887ed6e358fb..d66c6349ed2d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>  	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>  	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, 0);
>  }
>  
>  static int cxl_port_setup_regs(struct cxl_port *port,
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e1082e749c69..9d218ebe180d 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -421,7 +421,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>  	map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map, uint8_t caps)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> @@ -437,11 +437,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> +		if (!dev_map->status.valid ||
> +		    ((caps & CXL_DRIVER_CAP_MBOX) && !dev_map->mbox.valid) ||
>  		    !dev_map->memdev.valid) {
>  			dev_err(host, "registers not found: %s%s%s\n",
>  				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> +				((caps & CXL_DRIVER_CAP_MBOX) && !dev_map->mbox.valid) ? "mbox " : "",

According to the r3.1 8.2.8.2.1, the device status registers and the primary mailbox registers are both mandatory if regloc id=3 block is found. So if the type2 device does not implement a mailbox then it shouldn't be calling cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map) to begin with from the driver init right? If the type2 device defines a regblock with id=3 but without a mailbox, then isn't that a spec violation?

DJ

>  				!dev_map->memdev.valid ? "memdev " : "");
>  			return -ENXIO;
>  		}
> @@ -455,7 +456,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	return 0;
>  }
>  
> -int cxl_setup_regs(struct cxl_register_map *map)
> +int cxl_setup_regs(struct cxl_register_map *map, uint8_t caps)
>  {
>  	int rc;
>  
> @@ -463,7 +464,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_probe_regs(map);
> +	rc = cxl_probe_regs(map, caps);
>  	cxl_unmap_regblock(map);
>  
>  	return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a6613a6f8923..9973430d975f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -300,7 +300,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, int index);
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map, uint8_t caps);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index af8169ccdbc0..8f2a820bd92d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -405,6 +405,9 @@ struct cxl_dpa_perf {
>  	int qos_class;
>  };
>  
> +#define CXL_DRIVER_CAP_HDM	0x1
> +#define CXL_DRIVER_CAP_MBOX	0x2
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -438,6 +441,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	uint8_t capabilities;
>  };
>  
>  /**
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b34d6259faf4..e2a978312281 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -502,7 +502,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  }
>  
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map)
> +			      struct cxl_register_map *map,
> +			      uint8_t cxl_dev_caps)
>  {
>  	int rc;
>  
> @@ -519,7 +520,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	if (rc)
>  		return rc;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, cxl_dev_caps);
>  }
>  
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> @@ -527,7 +528,8 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>  	struct cxl_register_map map;
>  	int rc;
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
>  	if (rc)
>  		return rc;
>  
> @@ -536,7 +538,7 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
>  		return rc;
>  
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +				&cxlds->reg_map, cxlds->capabilities);
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  
> @@ -850,7 +852,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		dev_warn(&pdev->dev,
>  			 "Device DVSEC not present, skip CXL.mem init\n");
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
>  	if (rc)
>  		return rc;
>  
> @@ -863,7 +866,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 * still be useful for management functions so don't return an error.
>  	 */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +				&cxlds->reg_map, cxlds->capabilities);
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  	else if (!cxlds->reg_map.component_map.ras.valid)
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 9cefcaf3caca..37d8bfdef517 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -33,7 +33,8 @@ void efx_cxl_init(struct efx_nic *efx)
>  
>  	pci_info(pci_dev, "CXL CXL_DVSEC_PCIE_DEVICE capability found");
>  
> -	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
> +	cxl->cxlds = cxl_accel_state_create(&pci_dev->dev,
> +					    CXL_ACCEL_DRIVER_CAP_HDM);
>  	if (IS_ERR(cxl->cxlds)) {
>  		pci_info(pci_dev, "CXL accel device state failed");
>  		return;
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index c7b254edc096..0ba2195b919b 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -12,8 +12,11 @@ enum accel_resource{
>  	CXL_ACCEL_RES_PMEM,
>  };
>  
> +#define CXL_ACCEL_DRIVER_CAP_HDM	0x1
> +#define CXL_ACCEL_DRIVER_CAP_MBOX	0x2
> +
>  typedef struct cxl_dev_state cxl_accel_state;
> -cxl_accel_state *cxl_accel_state_create(struct device *dev);
> +cxl_accel_state *cxl_accel_state_create(struct device *dev, uint8_t caps);
>  
>  void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
>  void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);

