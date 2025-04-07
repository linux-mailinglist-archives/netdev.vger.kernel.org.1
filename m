Return-Path: <netdev+bounces-179761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA31A7E79A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5744E1897FC5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056FB214805;
	Mon,  7 Apr 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NB7T7fYy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E772147F4;
	Mon,  7 Apr 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044925; cv=none; b=uwN8UnVQdmdOH7j18mivNPi4MoNINi3hV4/ZgKH+OQn/RS/PJ3FUEFPvxZsrWzGzYB/D8Y+Pjho+Y0ezNT/ATvoMvW3SJj27qdmmfRKFSUfZ+Qrg0h8m0bqOm7u3aZQOHPuefM0ttdzBMWzsuKxRtvOelOeKP7OA/HpW9V6qfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044925; c=relaxed/simple;
	bh=GJDze0ARErtYvMTRb2cdw6c6Hdt58T0bQ10azfquOTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMgmNOkyYdfUJbA0SptpTPO+Ia+OUQGbX/kkrh33bPbsSXiwotPuD9ZxQNHcAtjlm5wj2r+5B/em8mC36g7ToPocZtNxLcfENsI83Xdr64ctjcx02qw5yN4VrgymtDPqrSXtiakihOwkgPBVCbf8vkgKi3VVMH9SRmHq4SShD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NB7T7fYy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744044923; x=1775580923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GJDze0ARErtYvMTRb2cdw6c6Hdt58T0bQ10azfquOTM=;
  b=NB7T7fYyOgLVRTslvOHn/ls61CzoMGZSf0yJh06FjLJHL1NNCQbyWkWH
   LEEUoZjU8PCtTB5sL82maUDvVLg8WdIP8CSx0rQ5KwEbK728WZgIwTavU
   jv0gyf/bCa25DMNW84sX+Dg0o/3knJmdhwVs5EOGUxa7ov+zBjr5eW1ck
   z2KwCGMwF9hGo886DLQVG9CC0YolEahwqU5uaxfiTucscgyl9OKfHLCGt
   gT87Ah92XSxtBjSThWFIxhQRRIW+Ov5P3RGNbVG3HRnkETAIAZw+z9pAl
   BvrMU6UcYAwJqmGwqU1Kx2QA4sRJdMSCitwbR2A5Vg2368yW7lv8nZWNg
   A==;
X-CSE-ConnectionGUID: ANWKO3EVRiOabjzPEWt1gQ==
X-CSE-MsgGUID: rmniMpiSSAm+RE1PBZwXSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70819214"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="70819214"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 09:55:22 -0700
X-CSE-ConnectionGUID: mrIppgl6RkG+kS3dDEkgZw==
X-CSE-MsgGUID: PAvi2OVOQ567yg8hV0p5Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128541495"
Received: from unknown (HELO [10.241.240.142]) ([10.241.240.142])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 09:55:22 -0700
Message-ID: <a4254948-b274-4c29-a03c-cb8c8e104075@intel.com>
Date: Mon, 7 Apr 2025 09:55:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/23] cxl: add type2 device basic support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250331144555.1947819-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/31/25 7:45 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/mbox.c      |  11 +-
>  drivers/cxl/core/memdev.c    |  32 ++++++
>  drivers/cxl/core/pci.c       |   1 +
>  drivers/cxl/core/regs.c      |   1 +
>  drivers/cxl/cxl.h            |  97 +---------------
>  drivers/cxl/cxlmem.h         |  88 +--------------
>  drivers/cxl/cxlpci.h         |  25 +----
>  drivers/cxl/pci.c            |  17 +--
>  include/cxl/cxl.h            | 209 +++++++++++++++++++++++++++++++++++
>  include/cxl/pci.h            |  23 ++++
>  tools/testing/cxl/test/mem.c |   2 +-
>  11 files changed, 290 insertions(+), 216 deletions(-)
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d72764056ce6..ab994d459f46 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1484,23 +1484,20 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec)
>  {
>  	struct cxl_memdev_state *mds;
>  	int rc;
>  
> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +	mds = cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial, dvsec,
> +				   struct cxl_memdev_state, cxlds, true);
>  	if (!mds) {
>  		dev_err(dev, "No memory available\n");
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	mutex_init(&mds->event.log_lock);
> -	mds->cxlds.dev = dev;
> -	mds->cxlds.reg_map.host = dev;
> -	mds->cxlds.cxl_mbox.host = dev;
> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  
>  	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
>  	if (rc == -EOPNOTSUPP)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a16a5886d40a..6cc732aeb9de 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -633,6 +633,38 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
> +			enum cxl_devtype type, u64 serial, u16 dvsec,
> +			bool has_mbox)
> +{
> +	*cxlds = (struct cxl_dev_state) {
> +		.dev = dev,
> +		.type = type,
> +		.serial = serial,
> +		.cxl_dvsec = dvsec,
> +		.reg_map.host = dev,
> +		.reg_map.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	if (has_mbox)
> +		cxlds->cxl_mbox.host = dev;
> +}
> +
> +struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
> +					    enum cxl_devtype type, u64 serial,
> +					    u16 dvsec, size_t size,
> +					    bool has_mbox)
> +{
> +	struct cxl_dev_state *cxlds __free(kfree) = kzalloc(size, GFP_KERNEL);
> +
> +	if (!cxlds)
> +		return NULL;
> +
> +	cxl_dev_state_init(cxlds, dev, type, serial, dvsec, has_mbox);
> +	return_ptr(cxlds);
> +}
> +EXPORT_SYMBOL_NS_GPL(_cxl_dev_state_create, "CXL");
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 96fecb799cbc..2e9af4898914 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -7,6 +7,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <cxl/pci.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 117c2e94c761..58a942a4946c 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -4,6 +4,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> +#include <cxl/pci.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <pmu.h>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index be8a7dc77719..fd7e2f3811a2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -11,6 +11,7 @@
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> +#include <cxl/cxl.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> @@ -200,97 +201,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> -/*
> - * Using struct_group() allows for per register-block-type helper routines,
> - * without requiring block-type agnostic code to include the prefix.
> - */
> -struct cxl_regs {
> -	/*
> -	 * Common set of CXL Component register block base pointers
> -	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
> -	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> -	 */
> -	struct_group_tagged(cxl_component_regs, component,
> -		void __iomem *hdm_decoder;
> -		void __iomem *ras;
> -	);
> -	/*
> -	 * Common set of CXL Device register block base pointers
> -	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
> -	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> -	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
> -	 */
> -	struct_group_tagged(cxl_device_regs, device_regs,
> -		void __iomem *status, *mbox, *memdev;
> -	);
> -
> -	struct_group_tagged(cxl_pmu_regs, pmu_regs,
> -		void __iomem *pmu;
> -	);
> -
> -	/*
> -	 * RCH downstream port specific RAS register
> -	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> -	 */
> -	struct_group_tagged(cxl_rch_regs, rch_regs,
> -		void __iomem *dport_aer;
> -	);
> -
> -	/*
> -	 * RCD upstream port specific PCIe cap register
> -	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> -	 */
> -	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> -		void __iomem *rcd_pcie_cap;
> -	);
> -};
> -
> -struct cxl_reg_map {
> -	bool valid;
> -	int id;
> -	unsigned long offset;
> -	unsigned long size;
> -};
> -
> -struct cxl_component_reg_map {
> -	struct cxl_reg_map hdm_decoder;
> -	struct cxl_reg_map ras;
> -};
> -
> -struct cxl_device_reg_map {
> -	struct cxl_reg_map status;
> -	struct cxl_reg_map mbox;
> -	struct cxl_reg_map memdev;
> -};
> -
> -struct cxl_pmu_reg_map {
> -	struct cxl_reg_map pmu;
> -};
> -
> -/**
> - * struct cxl_register_map - DVSEC harvested register block mapping parameters
> - * @host: device for devm operations and logging
> - * @base: virtual base of the register-block-BAR + @block_offset
> - * @resource: physical resource base of the register block
> - * @max_size: maximum mapping size to perform register search
> - * @reg_type: see enum cxl_regloc_type
> - * @component_map: cxl_reg_map for component registers
> - * @device_map: cxl_reg_maps for device registers
> - * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> - */
> -struct cxl_register_map {
> -	struct device *host;
> -	void __iomem *base;
> -	resource_size_t resource;
> -	resource_size_t max_size;
> -	u8 reg_type;
> -	union {
> -		struct cxl_component_reg_map component_map;
> -		struct cxl_device_reg_map device_map;
> -		struct cxl_pmu_reg_map pmu_map;
> -	};
> -};
> -
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> @@ -482,11 +392,6 @@ struct cxl_region_params {
>  	resource_size_t cache_size;
>  };
>  
> -enum cxl_partition_mode {
> -	CXL_PARTMODE_RAM,
> -	CXL_PARTMODE_PMEM,
> -};
> -
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 3ec6b906371b..e7cd31b9f107 100644
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
> @@ -357,87 +358,6 @@ struct cxl_security_state {
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
> -/**
> - * struct cxl_dpa_perf - DPA performance property entry
> - * @dpa_range: range for DPA address
> - * @coord: QoS performance data (i.e. latency, bandwidth)
> - * @cdat_coord: raw QoS performance data from CDAT
> - * @qos_class: QoS Class cookies
> - */
> -struct cxl_dpa_perf {
> -	struct range dpa_range;
> -	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> -	int qos_class;
> -};
> -
> -/**
> - * struct cxl_dpa_partition - DPA partition descriptor
> - * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> - * @perf: performance attributes of the partition from CDAT
> - * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> - */
> -struct cxl_dpa_partition {
> -	struct resource res;
> -	struct cxl_dpa_perf perf;
> -	enum cxl_partition_mode mode;
> -};
> -
> -/**
> - * struct cxl_dev_state - The driver device state
> - *
> - * cxl_dev_state represents the CXL driver/device state.  It provides an
> - * interface to mailbox commands as well as some cached data about the device.
> - * Currently only memory devices are represented.
> - *
> - * @dev: The device associated with this CXL state
> - * @cxlmd: The device representing the CXL.mem capabilities of @dev
> - * @reg_map: component and ras register mapping parameters
> - * @regs: Parsed register blocks
> - * @cxl_dvsec: Offset to the PCIe device DVSEC
> - * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> - * @media_ready: Indicate whether the device media is usable
> - * @dpa_res: Overall DPA resource tree for the device
> - * @part: DPA partition array
> - * @nr_partitions: Number of DPA partitions
> - * @serial: PCIe Device Serial Number
> - * @type: Generic Memory Class device or Vendor Specific Memory device
> - * @cxl_mbox: CXL mailbox context
> - * @cxlfs: CXL features context
> - */
> -struct cxl_dev_state {
> -	struct device *dev;
> -	struct cxl_memdev *cxlmd;
> -	struct cxl_register_map reg_map;
> -	struct cxl_regs regs;
> -	int cxl_dvsec;
> -	bool rcd;
> -	bool media_ready;
> -	struct resource dpa_res;
> -	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> -	unsigned int nr_partitions;
> -	u64 serial;
> -	enum cxl_devtype type;
> -	struct cxl_mailbox cxl_mbox;
> -#ifdef CONFIG_CXL_FEATURES
> -	struct cxl_features_state *cxlfs;
> -#endif
> -};
> -
>  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  {
>  	/*
> @@ -833,7 +753,11 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec);
> +void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
> +			enum cxl_devtype type, u64 serial, u16 dvsec,
> +			bool has_mbox);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..f7f6c2222cc0 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -1,35 +1,14 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> -#ifndef __CXL_PCI_H__
> -#define __CXL_PCI_H__
> +#ifndef __CXLPCI_H__
> +#define __CXLPCI_H__
>  #include <linux/pci.h>
>  #include "cxl.h"
>  
>  #define CXL_MEMORY_PROGIF	0x10
>  
> -/*
> - * See section 8.1 Configuration Space Registers in the CXL 2.0
> - * Specification. Names are taken straight from the specification with "CXL" and
> - * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
> - */
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
> index 4288f4814cc5..769db8edf608 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -11,6 +11,8 @@
>  #include <linux/pci.h>
>  #include <linux/aer.h>
>  #include <linux/io.h>
> +#include <cxl/cxl.h>
> +#include <cxl/pci.h>
>  #include <cxl/mailbox.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
> @@ -911,6 +913,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	int rc, pmu_count;
>  	unsigned int i;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct cxl_regs
> @@ -924,19 +927,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
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
> index 000000000000..1383fd724cf6
> --- /dev/null
> +++ b/include/cxl/cxl.h
> @@ -0,0 +1,209 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2025 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_H
> +#define __CXL_H
> +
> +#include <linux/cdev.h>
> +#include <linux/node.h>
> +#include <linux/ioport.h>
> +#include <cxl/mailbox.h>
> +
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
> +
> +/*
> + * Using struct_group() allows for per register-block-type helper routines,
> + * without requiring block-type agnostic code to include the prefix.
> + */
> +struct cxl_regs {
> +	/*
> +	 * Common set of CXL Component register block base pointers
> +	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
> +	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> +	 */
> +	struct_group_tagged(cxl_component_regs, component,
> +		void __iomem *hdm_decoder;
> +		void __iomem *ras;
> +	);
> +	/*
> +	 * Common set of CXL Device register block base pointers
> +	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
> +	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> +	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
> +	 */
> +	struct_group_tagged(cxl_device_regs, device_regs,
> +		void __iomem *status, *mbox, *memdev;
> +	);
> +
> +	struct_group_tagged(cxl_pmu_regs, pmu_regs,
> +		void __iomem *pmu;
> +	);
> +
> +	/*
> +	 * RCH downstream port specific RAS register
> +	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rch_regs, rch_regs,
> +		void __iomem *dport_aer;
> +	);
> +
> +	/*
> +	 * RCD upstream port specific PCIe cap register
> +	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> +		void __iomem *rcd_pcie_cap;
> +	);
> +};
> +
> +struct cxl_reg_map {
> +	bool valid;
> +	int id;
> +	unsigned long offset;
> +	unsigned long size;
> +};
> +
> +struct cxl_component_reg_map {
> +	struct cxl_reg_map hdm_decoder;
> +	struct cxl_reg_map ras;
> +};
> +
> +struct cxl_device_reg_map {
> +	struct cxl_reg_map status;
> +	struct cxl_reg_map mbox;
> +	struct cxl_reg_map memdev;
> +};
> +
> +struct cxl_pmu_reg_map {
> +	struct cxl_reg_map pmu;
> +};
> +
> +/**
> + * struct cxl_register_map - DVSEC harvested register block mapping parameters
> + * @host: device for devm operations and logging
> + * @base: virtual base of the register-block-BAR + @block_offset
> + * @resource: physical resource base of the register block
> + * @max_size: maximum mapping size to perform register search
> + * @reg_type: see enum cxl_regloc_type
> + * @component_map: cxl_reg_map for component registers
> + * @device_map: cxl_reg_maps for device registers
> + * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> + */
> +struct cxl_register_map {
> +	struct device *host;
> +	void __iomem *base;
> +	resource_size_t resource;
> +	resource_size_t max_size;
> +	u8 reg_type;
> +	union {
> +		struct cxl_component_reg_map component_map;
> +		struct cxl_device_reg_map device_map;
> +		struct cxl_pmu_reg_map pmu_map;
> +	};
> +};
> +
> +/**
> + * struct cxl_dpa_perf - DPA performance property entry
> + * @dpa_range: range for DPA address
> + * @coord: QoS performance data (i.e. latency, bandwidth)
> + * @cdat_coord: raw QoS performance data from CDAT
> + * @qos_class: QoS Class cookies
> + */
> +struct cxl_dpa_perf {
> +	struct range dpa_range;
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> +	int qos_class;
> +};
> +
> +enum cxl_partition_mode {
> +	CXL_PARTMODE_RAM,
> +	CXL_PARTMODE_PMEM,
> +};
> +
> +/**
> + * struct cxl_dpa_partition - DPA partition descriptor
> + * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> + * @perf: performance attributes of the partition from CDAT
> + * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> + */
> +struct cxl_dpa_partition {
> +	struct resource res;
> +	struct cxl_dpa_perf perf;
> +	enum cxl_partition_mode mode;
> +};
> +
> +#define CXL_NR_PARTITIONS_MAX 2
> +
> +/**
> + * struct cxl_dev_state - The driver device state
> + *
> + * cxl_dev_state represents the CXL driver/device state.  It provides an
> + * interface to mailbox commands as well as some cached data about the device.
> + * Currently only memory devices are represented.
> + *
> + * @dev: The device associated with this CXL state
> + * @cxlmd: The device representing the CXL.mem capabilities of @dev
> + * @reg_map: component and ras register mapping parameters
> + * @regs: Parsed register blocks
> + * @cxl_dvsec: Offset to the PCIe device DVSEC
> + * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @media_ready: Indicate whether the device media is usable
> + * @dpa_res: Overall DPA resource tree for the device
> + * @part: DPA partition array
> + * @nr_partitions: Number of DPA partitions
> + * @serial: PCIe Device Serial Number
> + * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @cxl_mbox: CXL mailbox context
> + * @cxlfs: CXL features context
> + */
> +struct cxl_dev_state {
> +	/* public for Type2 drivers */
> +	struct device *dev;
> +	struct cxl_memdev *cxlmd;
> +
> +	/* private for Type2 drivers */
> +	struct cxl_register_map reg_map;
> +	struct cxl_regs regs;
> +	int cxl_dvsec;
> +	bool rcd;
> +	bool media_ready;
> +	struct resource dpa_res;
> +	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> +	unsigned int nr_partitions;
> +	u64 serial;
> +	enum cxl_devtype type;
> +	struct cxl_mailbox cxl_mbox;
> +#ifdef CONFIG_CXL_FEATURES
> +	struct cxl_features_state *cxlfs;
> +#endif
> +};
> +
> +struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
> +					    enum cxl_devtype type, u64 serial,
> +					    u16 dvsec, size_t size,
> +					    bool has_mbox);
> +
> +#define cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
> +	({										\
> +		static_assert(__same_type(struct cxl_dev_state,				\
> +			      ((drv_struct *)NULL)->member));				\
> +		static_assert(offsetof(drv_struct, member) == 0);			\
> +		(drv_struct *)_cxl_dev_state_create(parent, type, serial, dvsec,	\
> +						      sizeof(drv_struct), mbox);	\
> +	})
> +#endif
> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> new file mode 100644
> index 000000000000..c5a3ecad7ebf
> --- /dev/null
> +++ b/include/cxl/pci.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_PCI_H
> +#define __CXL_PCI_H
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
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 0ceba8aa6eec..6e9b3141035b 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1611,6 +1611,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	mds = cxl_memdev_state_create(dev, pdev->id + 1, NULL);
>  	mds = cxl_memdev_state_create(dev);
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
> @@ -1627,7 +1628,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>  
> -	cxlds->serial = pdev->id + 1;
>  	if (is_rcd(pdev))
>  		cxlds->rcd = true;
>  


