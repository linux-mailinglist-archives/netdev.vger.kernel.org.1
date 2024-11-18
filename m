Return-Path: <netdev+bounces-146019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798019D1B41
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 23:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACDB282961
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614581E7C29;
	Mon, 18 Nov 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bSARxqM5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441B1A08BC;
	Mon, 18 Nov 2024 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970366; cv=none; b=E42U64mT4dn1/MLlLI+1H6LchYTAG/xlHWyah20foUNipq2Kl8foVRgOnxWv4YmdnMKlYK7T6JRndEs7fPPb2GJUdytchMeBX5PVj+nODR1+4Dy+AoCPLvJ4g7fdBgYUuQdT4KXcmAPjRhhUiX6Zq6rMfThnjqn+89IuugQ2F8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970366; c=relaxed/simple;
	bh=vwrKABwjGP+N9Wb/5VvQlDcP+AUM6xu9YBuM3Er2tzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoqP3VSGVWbA00uDWSle4eHzlGCEt4253kKVzJunj0P4AHezBWhZC9eWxq7tFytxiZJZ4VodVzRSKNMA/44ZKazG3qGI+ZgJhfvi4h7Ba0admhaLmdFbXHJigEUXWmgTppz9uWz2mL3/v+VRVkCoZ9NKnXc5J+ZJjdDp84JijCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bSARxqM5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731970364; x=1763506364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vwrKABwjGP+N9Wb/5VvQlDcP+AUM6xu9YBuM3Er2tzI=;
  b=bSARxqM5zGdYB/EhuX8JbMfo1bm8bU0RxOQqDWFxwS4zsCtykVLQRBLV
   C3ZC2Neivjs+8BNwx/vuIrf7PAa8yjU7Ig6UIfAto7LTzGAbZa5qJtwjH
   oF/n+YOZrcNRlobTPrJU7nnUZLZ8WxrF0WIAU6yndqOosfE/uTJ6DBgnP
   V+Da1lZPqTdL8phM7dM9IQlVR/Bve2hcYT+FyhM1FAijjaAdijtX5lg5h
   EbyZ4r+2g11jcQ4lFlhoXfh0EskWSgVKJnOz0UUcviNfwMSdEamGc6cDD
   9/1pkqT7ZTmmI7uuFnAEE/PKWSRPhiCBA4UY6nbPW3tumloVBKNbAALWU
   Q==;
X-CSE-ConnectionGUID: +jbJhIdeS8aiSClfoxPn4A==
X-CSE-MsgGUID: qQTRbfL0T7iAcV6nH/eaoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="32185291"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="32185291"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 14:52:43 -0800
X-CSE-ConnectionGUID: b0CZB74ST9KL2ABcEVk4rA==
X-CSE-MsgGUID: Yc5r5ZlwRQGlL01lar4PIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="112673449"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.108.254]) ([10.125.108.254])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 14:52:42 -0800
Message-ID: <0ca7d9ba-2d01-4678-b109-ca49091266f4@intel.com>
Date: Mon, 18 Nov 2024 15:52:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/27] cxl: add capabilities field to cxl_dev_state and
 cxl_port
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-4-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241118164434.7551-4-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type2 devices have some Type3 functionalities as optional like an mbox
> or an hdm decoder, and CXL core needs a way to know what an CXL accelerator
> implements.
> 
> Add a new field to cxl_dev_state for keeping device capabilities as discovered
> during initialization. Add same field to cxl_port as registers discovery
> is also used during port initialization.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/port.c | 11 +++++++----
>  drivers/cxl/core/regs.c | 21 ++++++++++++++-------
>  drivers/cxl/cxl.h       |  9 ++++++---
>  drivers/cxl/cxlmem.h    |  2 ++
>  drivers/cxl/pci.c       | 10 ++++++----
>  include/cxl/cxl.h       | 30 ++++++++++++++++++++++++++++++
>  6 files changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index af92c67bc954..5bc8490a199c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -749,7 +749,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  }
>  
>  static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
> -			       resource_size_t component_reg_phys)
> +			       resource_size_t component_reg_phys, unsigned long *caps)
>  {
>  	*map = (struct cxl_register_map) {
>  		.host = host,
> @@ -763,7 +763,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>  	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>  	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  
>  static int cxl_port_setup_regs(struct cxl_port *port,
> @@ -772,7 +772,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>  	if (dev_is_platform(port->uport_dev))
>  		return 0;
>  	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
> -				   component_reg_phys);
> +				   component_reg_phys, port->capabilities);
>  }
>  
>  static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
> @@ -789,7 +789,8 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  	 * NULL.
>  	 */
>  	rc = cxl_setup_comp_regs(dport->dport_dev, &dport->reg_map,
> -				 component_reg_phys);
> +				 component_reg_phys,
> +				 dport->port->capabilities);
>  	dport->reg_map.host = host;
>  	return rc;
>  }
> @@ -851,6 +852,8 @@ static int cxl_port_add(struct cxl_port *port,
>  		port->reg_map = cxlds->reg_map;
>  		port->reg_map.host = &port->dev;
>  		cxlmd->endpoint = port;
> +		bitmap_copy(port->capabilities, cxlds->capabilities,
> +			    CXL_MAX_CAPS);
>  	} else if (parent_dport) {
>  		rc = dev_set_name(dev, "port%d", port->id);
>  		if (rc)
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e1082e749c69..8287ec45b018 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <cxl/cxl.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <pmu.h>
> @@ -36,7 +37,8 @@
>   * Probe for component register information and return it in map object.
>   */
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map)
> +			      struct cxl_component_reg_map *map,
> +			      unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u32 cap_array;
> @@ -84,6 +86,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			decoder_cnt = cxl_hdm_decoder_count(hdr);
>  			length = 0x20 * decoder_cnt + 0x10;
>  			rmap = &map->hdm_decoder;
> +			*caps |= BIT(CXL_DEV_CAP_HDM);
>  			break;
>  		}
>  		case CXL_CM_CAP_CAP_ID_RAS:
> @@ -91,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  				offset);
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
> +			*caps |= BIT(CXL_DEV_CAP_RAS);
>  			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
> @@ -117,7 +121,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
>   * Probe for device register information and return it in map object.
>   */
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map)
> +			   struct cxl_device_reg_map *map, unsigned long *caps)
>  {
>  	int cap, cap_count;
>  	u64 cap_array;
> @@ -146,10 +150,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
>  			rmap = &map->status;
> +			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
>  			rmap = &map->mbox;
> +			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> @@ -157,6 +163,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
>  			rmap = &map->memdev;
> +			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
>  			break;
>  		default:
>  			if (cap_id >= 0x8000)
> @@ -421,7 +428,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>  	map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> @@ -431,12 +438,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	switch (map->reg_type) {
>  	case CXL_REGLOC_RBI_COMPONENT:
>  		comp_map = &map->component_map;
> -		cxl_probe_component_regs(host, base, comp_map);
> +		cxl_probe_component_regs(host, base, comp_map, caps);
>  		dev_dbg(host, "Set up component registers\n");
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
> -		cxl_probe_device_regs(host, base, dev_map);
> +		cxl_probe_device_regs(host, base, dev_map, caps);
>  		if (!dev_map->status.valid || !dev_map->mbox.valid ||
>  		    !dev_map->memdev.valid) {
>  			dev_err(host, "registers not found: %s%s%s\n",
> @@ -455,7 +462,7 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	return 0;
>  }
>  
> -int cxl_setup_regs(struct cxl_register_map *map)
> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -463,7 +470,7 @@ int cxl_setup_regs(struct cxl_register_map *map)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_probe_regs(map);
> +	rc = cxl_probe_regs(map, caps);
>  	cxl_unmap_regblock(map);
>  
>  	return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a2be05fd7aa2..e5f918be6fe4 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -4,6 +4,7 @@
>  #ifndef __CXL_H__
>  #define __CXL_H__
>  
> +#include <cxl/cxl.h>
>  #include <linux/libnvdimm.h>
>  #include <linux/bitfield.h>
>  #include <linux/notifier.h>
> @@ -284,9 +285,9 @@ struct cxl_register_map {
>  };
>  
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
> -			      struct cxl_component_reg_map *map);
> +			      struct cxl_component_reg_map *map, unsigned long *caps);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> -			   struct cxl_device_reg_map *map);
> +			   struct cxl_device_reg_map *map, unsigned long *caps);
>  int cxl_map_component_regs(const struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> @@ -300,7 +301,7 @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			       struct cxl_register_map *map, int index);
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		      struct cxl_register_map *map);
> -int cxl_setup_regs(struct cxl_register_map *map);
> +int cxl_setup_regs(struct cxl_register_map *map, unsigned long *caps);
>  struct cxl_dport;
>  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>  					   struct cxl_dport *dport);
> @@ -600,6 +601,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -623,6 +625,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..4c1c53c29544 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -428,6 +428,7 @@ struct cxl_dpa_perf {
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
>   * @cxl_mbox: CXL mailbox context
> + * @capabilities: those capabilities as defined in device mapped registers
>   */
>  struct cxl_dev_state {
>  	struct device *dev;
> @@ -443,6 +444,7 @@ struct cxl_dev_state {
>  	u64 serial;
>  	enum cxl_devtype type;
>  	struct cxl_mailbox cxl_mbox;
> +	DECLARE_BITMAP(capabilities, CXL_MAX_CAPS);
>  };
>  
>  static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0b910ef52db7..528d4ca79fd1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -504,7 +504,8 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>  }
>  
>  static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> -			      struct cxl_register_map *map)
> +			      struct cxl_register_map *map,
> +			      unsigned long *caps)
>  {
>  	int rc;
>  
> @@ -521,7 +522,7 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	if (rc)
>  		return rc;
>  
> -	return cxl_setup_regs(map);
> +	return cxl_setup_regs(map, caps);
>  }
>  
>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> @@ -848,7 +849,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxl_set_dvsec(cxlds, dvsec);
>  
> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map,
> +				cxlds->capabilities);
>  	if (rc)
>  		return rc;
>  
> @@ -861,7 +863,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	 * still be useful for management functions so don't return an error.
>  	 */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> -				&cxlds->reg_map);
> +				&cxlds->reg_map, cxlds->capabilities);
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  	else if (!cxlds->reg_map.component_map.ras.valid)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 19e5d883557a..dcc9ec8a0aec 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -12,6 +12,36 @@ enum cxl_resource {
>  	CXL_RES_PMEM,
>  };
>  
> +/* Capabilities as defined for:
> + *
> + *	Component Registers (Table 8-22 CXL 3.1 specification)
> + *	Device Registers (8.2.8.2.1 CXL 3.1 specification)
> + */
> +
> +enum cxl_dev_cap {
> +	/* capabilities from Component Registers */
> +	CXL_DEV_CAP_RAS,
> +	CXL_DEV_CAP_SEC,

There are a few caps that does not seem to be used yet. Should we not bother defining them until they are being used?

> +	CXL_DEV_CAP_LINK,
> +	CXL_DEV_CAP_HDM,
> +	CXL_DEV_CAP_SEC_EXT,
> +	CXL_DEV_CAP_IDE,
> +	CXL_DEV_CAP_SNOOP_FILTER,
> +	CXL_DEV_CAP_TIMEOUT_AND_ISOLATION,
> +	CXL_DEV_CAP_CACHEMEM_EXT,
> +	CXL_DEV_CAP_BI_ROUTE_TABLE,
> +	CXL_DEV_CAP_BI_DECODER,
> +	CXL_DEV_CAP_CACHEID_ROUTE_TABLE,
> +	CXL_DEV_CAP_CACHEID_DECODER,
> +	CXL_DEV_CAP_HDM_EXT,
> +	CXL_DEV_CAP_METADATA_EXT,
> +	/* capabilities from Device Registers */
> +	CXL_DEV_CAP_DEV_STATUS,
> +	CXL_DEV_CAP_MAILBOX_PRIMARY,
> +	CXL_DEV_CAP_MEMDEV,
> +	CXL_MAX_CAPS = 32

This is changed to 64 in the next patch. Should it just be set to 64 here? I assume you just wanted a bitmap that's u64 long?

DJ 

> +};
> +
>  struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>  
>  void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);


