Return-Path: <netdev+bounces-165791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD8A33679
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922773A1888
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD2C204C1D;
	Thu, 13 Feb 2025 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBvGJlYj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38831158524;
	Thu, 13 Feb 2025 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419065; cv=none; b=AxR2574nETRb12tFPGk/et7aHEsv33BGgDsXPmRpmnhDQ2BCyx3iUgdWn8Re6YdZMINwai7GAo3qG5zF5fBTVRG1wntmhhXjElFQRbhD41HpLArZd1E0cO++gNk5cxK5Km/Nj0iYbV70hQyOeBRPF9L5ih3z4u3JT8dn44C5Rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419065; c=relaxed/simple;
	bh=9OfRhLSyee6xXJRT6itbhMkMvNgR1H+t66AsTdJufv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewbEsq7L0AakJcz+VYSmWUtnrooWbWQRgfESEnGzpdexcSCih27Ig4NigNZFXiZps2DtK4go1OPxiSqCNZrY1h1Xr06a1xzseKMRn9uvRDqWc4TKcsiyVZ+FfoCBXZ9V8jXHHxJdWdZv9BgVYl0u9QBYEhLipYYindlLnKp1o1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBvGJlYj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739419064; x=1770955064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9OfRhLSyee6xXJRT6itbhMkMvNgR1H+t66AsTdJufv4=;
  b=HBvGJlYjEU9VrDA0h0PQpUrnMl9fUEv7xj3HSWe38VjUGwBKphv9v55H
   htOutRi0s4g5kAgOLCF8v46c83DWSyh8kU1JBqDtlIdRtza9zxoJvHYiX
   zNq+cLeihDXvSwYlJdXNlCNhLVUherkqu8Ed0Uvd2WXOiROL+dG7Bf6FL
   m1bjF1p+f5etKI7ZgOD1Z9iZeRweIm6KsM/IoCrHkCZYhZz02V1S+2wjx
   oIMooH38k1bAN6+7hvc1/4hM6Qhkvm/0DRv8jCLj3IywrWHUx/z6YCpSm
   tTo13oryREKT2RLvAqEWmUVZYdCYEOxKo9+fOESV8pg2klKnLqBH41osT
   A==;
X-CSE-ConnectionGUID: ZMEC4AWkTiOP9QpNdZOlww==
X-CSE-MsgGUID: DKVFgTRFRxCkh9FOGntYfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="43876054"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="43876054"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 19:57:43 -0800
X-CSE-ConnectionGUID: Uc/NfNGgTuKQUuYApp0BsA==
X-CSE-MsgGUID: yKEEWG2ETzy0A1Y5t++Q9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="113214821"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.167])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 19:57:41 -0800
Date: Wed, 12 Feb 2025 19:57:38 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: alucerop@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 01/26] cxl: make memdev creation type agnostic
Message-ID: <Z61tsoz3_MGrjvjG@aschofie-mobl2.lan>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-2-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-2-alucerop@amd.com>

On Wed, Feb 05, 2025 at 03:19:25PM +0000, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for Type2 support, change memdev creation making
> type based on argument.
> 
> Integrate initialization of dvsec and serial fields in the related
> cxl_dev_state within same function creating the memdev.
> 
> Move the code from mbox file to memdev file.
> 
> Add new header files with type2 required definitions for memdev
> state creation.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/mbox.c   | 20 --------------------
>  drivers/cxl/core/memdev.c | 23 +++++++++++++++++++++++
>  drivers/cxl/cxlmem.h      | 18 +++---------------
>  drivers/cxl/cxlpci.h      | 17 +----------------
>  drivers/cxl/pci.c         | 16 +++++++++-------
>  include/cxl/cxl.h         | 26 ++++++++++++++++++++++++++
>  include/cxl/pci.h         | 23 +++++++++++++++++++++++
>  7 files changed, 85 insertions(+), 58 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4d22bb731177..96155b8af535 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1435,26 +1435,6 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> -{
> -	struct cxl_memdev_state *mds;
> -
> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> -	if (!mds) {
> -		dev_err(dev, "No memory available\n");
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	mutex_init(&mds->event.log_lock);
> -	mds->cxlds.dev = dev;
> -	mds->cxlds.reg_map.host = dev;
> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> -
> -	return mds;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
> -
>  void __init cxl_mbox_init(void)
>  {
>  	struct dentry *mbox_debugfs;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 63c6c681125d..456d505f1bc8 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -632,6 +632,29 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec, enum cxl_devtype type)
> +{
> +	struct cxl_memdev_state *mds;
> +
> +	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +	if (!mds) {
> +		dev_err(dev, "No memory available\n");
> +		return ERR_PTR(-ENOMEM);
> +	}

I know you are only the 'mover' of the above code, but can
you drop the dev_err message. OOM messages from the core are
typically enough.


> +
> +	mutex_init(&mds->event.log_lock);
> +	mds->cxlds.dev = dev;
> +	mds->cxlds.reg_map.host = dev;
> +	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> +	mds->cxlds.cxl_dvsec = dvsec;
> +	mds->cxlds.serial = serial;
> +	mds->cxlds.type = type;
> +
> +	return mds;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 536cbe521d16..62a459078ec3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -7,6 +7,7 @@
>  #include <linux/cdev.h>
>  #include <linux/uuid.h>
>  #include <linux/node.h>
> +#include <cxl/cxl.h>
>  #include <cxl/event.h>
>  #include <cxl/mailbox.h>
>  #include "cxl.h"
> @@ -393,20 +394,6 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> -/*
> - * enum cxl_devtype - delineate type-2 from a generic type-3 device
> - * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> - *			 HDM-DB, no requirement that this device implements a
> - *			 mailbox, or other memory-device-standard manageability
> - *			 flows.
> - * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> - *			   HDM-H and class-mandatory memory device registers
> - */
> -enum cxl_devtype {
> -	CXL_DEVTYPE_DEVMEM,
> -	CXL_DEVTYPE_CLASSMEM,
> -};
> -
>  /**
>   * struct cxl_dpa_perf - DPA performance property entry
>   * @dpa_range: range for DPA address
> @@ -856,7 +843,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec, enum cxl_devtype type);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..9fcf5387e388 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -3,6 +3,7 @@
>  #ifndef __CXL_PCI_H__
>  #define __CXL_PCI_H__
>  #include <linux/pci.h>
> +#include <cxl/pci.h>
>  #include "cxl.h"
>  
>  #define CXL_MEMORY_PROGIF	0x10
> @@ -14,22 +15,6 @@
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  
> -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> -#define CXL_DVSEC_PCIE_DEVICE					0
> -#define   CXL_DVSEC_CAP_OFFSET		0xA
> -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> -#define   CXL_DVSEC_CTRL_OFFSET		0xC
> -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> -
>  #define CXL_DVSEC_RANGE_MAX		2
>  
>  /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b2c943a4de0a..bd69dc07f387 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -911,6 +911,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	int rc, pmu_count;
>  	unsigned int i;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct cxl_regs
> @@ -924,19 +925,20 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return rc;
>  	pci_set_master(pdev);
>  
> -	mds = cxl_memdev_state_create(&pdev->dev);
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		dev_warn(&pdev->dev,
> +			 "Device DVSEC not present, skip CXL.mem init\n");
> +
> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec,
> +				      CXL_DEVTYPE_CLASSMEM);
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  	cxlds = &mds->cxlds;
>  	pci_set_drvdata(pdev, cxlds);
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
> -	cxlds->serial = pci_get_dsn(pdev);
> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> -	if (!cxlds->cxl_dvsec)
> -		dev_warn(&pdev->dev,
> -			 "Device DVSEC not present, skip CXL.mem init\n");
>  
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..722782b868ac
> --- /dev/null
> +++ b/include/cxl/cxl.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2025 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_H
> +#define __CXL_H
> +
> +#include <linux/types.h>
> +/*
> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> + *			 HDM-DB, no requirement that this device implements a
> + *			 mailbox, or other memory-device-standard manageability
> + *			 flows.
> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> + *			   HDM-H and class-mandatory memory device registers
> + */
> +enum cxl_devtype {
> +	CXL_DEVTYPE_DEVMEM,
> +	CXL_DEVTYPE_CLASSMEM,
> +};
> +
> +struct device;
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +					   u16 dvsec, enum cxl_devtype type);
> +
> +#endif
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..ad63560caa2c
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_ACCEL_PCI_H
> +#define __CXL_ACCEL_PCI_H
> +
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
> +#define   CXL_DVSEC_CAP_OFFSET		0xA
> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> +
> +#endif
> -- 
> 2.17.1
> 
> 

