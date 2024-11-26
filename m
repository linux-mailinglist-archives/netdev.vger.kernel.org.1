Return-Path: <netdev+bounces-147327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E7A9D919A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 06:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9008CB22110
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 05:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C938831;
	Tue, 26 Nov 2024 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQf6M9gp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A6539A;
	Tue, 26 Nov 2024 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732600749; cv=none; b=MnJC0NtfkoVD+e3W5Mn7Ek5oSyPQI3d6fo2lJo0wD09pzxlH+25cepeoFNcl5cDFVm/3k6yDKT05Z9TCDlURg4cE7KpBPv5PuUKMTcLI9bin4/y3o73XFHs4zDsJkHWas+GMb33M4lnvgu4s6Tadq3IMw3rdHO2F4s/7r2CbhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732600749; c=relaxed/simple;
	bh=KGf38JKYJGTkJuNOFhaBarproy+X63hRBRDIXsFfFUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeIiRS0KwZuF9Qw2uh+PHlCYMNOvqpFZoMFe9hcvv9QRDL/CbJGyliU/nkvNny1KJj2lao5sExgcsEs0z4XFdpTtenBjA1bZuO25OlPgf1XxEMy9Jdfys9DAY20Kkhibs620KnwJ01DsTghgPAgUGJzl0nH3VaQUjwRi78yfY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQf6M9gp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732600747; x=1764136747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KGf38JKYJGTkJuNOFhaBarproy+X63hRBRDIXsFfFUM=;
  b=MQf6M9gporRU9Wdki/lR9MoLEjj8JmCyxIHfgUSnK67/SM9gY7WB5QSQ
   sc94C4Xi3zQilga7SviyUWPy6qpudsHIufnEaD/ObQNK7qEXsEcZxiej3
   gnyaZGdgVTzU/KpUJj78inJkrOopBMInfmyeHIM58NEmDSEWui5ax1+C8
   T5EsQNXt4ahgftI7h1acGqsvLCMRhpiYJlkErIJ2DIPzMtGA5qjXZTNXJ
   wgjtYtvtNuV/LIeoil76s2vtRHypK21IYjwMn9lVHX+qEqPrCbuLPGr5q
   QsiA96nGQYzg4rkorGmXWueOWVX7yrYGFR6ThSgA+S7zY34NHnFhrFl9+
   Q==;
X-CSE-ConnectionGUID: PQb87HqPS06zkdUWOXkr8w==
X-CSE-MsgGUID: rcLFtHPnSwqaeG3oKyjKow==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="50269389"
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="50269389"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 21:59:06 -0800
X-CSE-ConnectionGUID: ySWiuBGpREaLN3v/wndu8Q==
X-CSE-MsgGUID: fhI2KUFwTYq3/wbzb4DNDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,185,1728975600"; 
   d="scan'208";a="91970862"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 21:59:06 -0800
Date: Mon, 25 Nov 2024 21:59:03 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v5 01/27] cxl: add type2 device basic support
Message-ID: <Z0Vjp3ndPODUSUYM@aschofie-mobl2.lan>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
 <Z0AKKKdMh9Q06X7e@aschofie-mobl2.lan>
 <6c039777-3455-eacc-8d7a-a248f7437c95@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c039777-3455-eacc-8d7a-a248f7437c95@amd.com>

On Fri, Nov 22, 2024 at 09:27:34AM +0000, Alejandro Lucero Palau wrote:
> 
> On 11/22/24 04:35, Alison Schofield wrote:
> > On Mon, Nov 18, 2024 at 04:44:08PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Differentiate Type3, aka memory expanders, from Type2, aka device
> > > accelerators, with a new function for initializing cxl_dev_state.
> > > 
> > > Create accessors to cxl_dev_state to be used by accel drivers.
> > > 
> > > Based on previous work by Dan Williams [1]
> > > 
> > > Link: [1] https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >   drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
> > >   drivers/cxl/core/pci.c    |  1 +
> > >   drivers/cxl/cxlpci.h      | 16 ------------
> > >   drivers/cxl/pci.c         | 13 +++++++---
> > >   include/cxl/cxl.h         | 21 ++++++++++++++++
> > As I mentioned in the cover letter, beginning w the first patch
> > I have depmod issues building with the cxl-test module.  I didn't
> > get very far figuring it out, other than a work-around of moving
> > the contents of include/cxl/cxl.h down into drivers/cxl/cxlmem.h.
> > That band-aid got me a bit further. In fact I wasn't so concerned
> > with breaking sfx as I was with regression testing the changes to
> > drivers/cxl/.
> > 
> > Please see if you can get the cxl-test module working again.
> 
> 
> Hi Allison,
> 
> 
> I have no problems building tools/testing/cxl and I can see cxl_test.ko in
> tools/testing/cxl/test
>

Yes that's the one. It builds it just won't load because of the
circular dependency.  Sorry I haven't been able to dig into it
further. I use run_qemu.sh [1] which uses mkosi to build the image.
It fails at the depmod step and I haven't been able to dig further.

depmod: ERROR: Cycle detected: cxl_mock -> cxl_core -> cxl_mock
depmod: ERROR: Found 2 modules in dependency cycles!

So, I'd expect it would fail at make modules_intall for you.

BTW - this happens occasionally, but usually on a smaller scale,
ie we know exactly what just changed. I suspect it happens with
only Patch 1 applied - but even limiting it to that I could not
nail it down.

--Alison


[1] https://github.com/pmem/run_qemu

> 
> I did try with the full patchset applied over 6.12-rc7 tag, and also with
> only the first patch since I was not sure if you meant the build after each
> patch is tried, but both worked once I modified the config for the checks
> inside config_check.c not to fail.
> 
> 
> I guess you meant this cxl test and not the one related to  "git clone
> https://github.com/moking/cxl-test-tool.git" what I have no experience with.
no



> 
> 
> Could someone else try this as well?
> 
> 
> > 
> > >   include/cxl/pci.h         | 23 ++++++++++++++++++
> > >   6 files changed, 105 insertions(+), 20 deletions(-)
> > >   create mode 100644 include/cxl/cxl.h
> > >   create mode 100644 include/cxl/pci.h
> > > 
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index 84fefb76dafa..d083fd13a6dd 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -1,6 +1,7 @@
> > >   // SPDX-License-Identifier: GPL-2.0-only
> > >   /* Copyright(c) 2020 Intel Corporation. */
> > > +#include <cxl/cxl.h>
> > >   #include <linux/io-64-nonatomic-lo-hi.h>
> > >   #include <linux/firmware.h>
> > >   #include <linux/device.h>
> > > @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct *work)
> > >   static struct lock_class_key cxl_memdev_key;
> > > +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
> > > +{
> > > +	struct cxl_dev_state *cxlds;
> > > +
> > > +	cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
> > > +	if (!cxlds)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	cxlds->dev = dev;
> > > +	cxlds->type = CXL_DEVTYPE_DEVMEM;
> > > +
> > > +	cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
> > > +	cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
> > > +	cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
> > > +
> > > +	return cxlds;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
> > > +
> > >   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
> > >   					   const struct file_operations *fops)
> > >   {
> > > @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, struct file *file)
> > >   	return 0;
> > >   }
> > > +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> > > +{
> > > +	cxlds->cxl_dvsec = dvsec;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, CXL);
> > > +
> > > +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
> > > +{
> > > +	cxlds->serial = serial;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, CXL);
> > > +
> > > +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> > > +		     enum cxl_resource type)
> > > +{
> > > +	switch (type) {
> > > +	case CXL_RES_DPA:
> > > +		cxlds->dpa_res = res;
> > > +		return 0;
> > > +	case CXL_RES_RAM:
> > > +		cxlds->ram_res = res;
> > > +		return 0;
> > > +	case CXL_RES_PMEM:
> > > +		cxlds->pmem_res = res;
> > > +		return 0;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
> > > +
> > >   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
> > >   {
> > >   	struct cxl_memdev *cxlmd =
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index 420e4be85a1f..ff266e91ea71 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -1,5 +1,6 @@
> > >   // SPDX-License-Identifier: GPL-2.0-only
> > >   /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > > +#include <cxl/pci.h>
> > >   #include <linux/units.h>
> > >   #include <linux/io-64-nonatomic-lo-hi.h>
> > >   #include <linux/device.h>
> > > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > > index 4da07727ab9c..eb59019fe5f3 100644
> > > --- a/drivers/cxl/cxlpci.h
> > > +++ b/drivers/cxl/cxlpci.h
> > > @@ -14,22 +14,6 @@
> > >    */
> > >   #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
> > > -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> > > -#define CXL_DVSEC_PCIE_DEVICE					0
> > > -#define   CXL_DVSEC_CAP_OFFSET		0xA
> > > -#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> > > -#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> > > -#define   CXL_DVSEC_CTRL_OFFSET		0xC
> > > -#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> > > -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
> > > -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
> > > -#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> > > -#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> > > -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> > > -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + (i * 0x10))
> > > -#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
> > > -#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> > > -
> > >   #define CXL_DVSEC_RANGE_MAX		2
> > >   /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 188412d45e0d..0b910ef52db7 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -1,5 +1,7 @@
> > >   // SPDX-License-Identifier: GPL-2.0-only
> > >   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > > +#include <cxl/cxl.h>
> > > +#include <cxl/pci.h>
> > >   #include <linux/unaligned.h>
> > >   #include <linux/io-64-nonatomic-lo-hi.h>
> > >   #include <linux/moduleparam.h>
> > > @@ -816,6 +818,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >   	struct cxl_memdev *cxlmd;
> > >   	int i, rc, pmu_count;
> > >   	bool irq_avail;
> > > +	u16 dvsec;
> > >   	/*
> > >   	 * Double check the anonymous union trickery in struct cxl_regs
> > > @@ -836,13 +839,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >   	pci_set_drvdata(pdev, cxlds);
> > >   	cxlds->rcd = is_cxl_restricted(pdev);
> > > -	cxlds->serial = pci_get_dsn(pdev);
> > > -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> > > -		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> > > -	if (!cxlds->cxl_dvsec)
> > > +	cxl_set_serial(cxlds, pci_get_dsn(pdev));
> > > +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > > +					  CXL_DVSEC_PCIE_DEVICE);
> > > +	if (!dvsec)
> > >   		dev_warn(&pdev->dev,
> > >   			 "Device DVSEC not present, skip CXL.mem init\n");
> > > +	cxl_set_dvsec(cxlds, dvsec);
> > > +
> > >   	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> > >   	if (rc)
> > >   		return rc;
> > > diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> > > new file mode 100644
> > > index 000000000000..19e5d883557a
> > > --- /dev/null
> > > +++ b/include/cxl/cxl.h
> > > @@ -0,0 +1,21 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
> > > +
> > > +#ifndef __CXL_H
> > > +#define __CXL_H
> > > +
> > > +#include <linux/ioport.h>
> > > +
> > > +enum cxl_resource {
> > > +	CXL_RES_DPA,
> > > +	CXL_RES_RAM,
> > > +	CXL_RES_PMEM,
> > > +};
> > > +
> > > +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
> > > +
> > > +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
> > > +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
> > > +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> > > +		     enum cxl_resource);
> > > +#endif
> > > diff --git a/include/cxl/pci.h b/include/cxl/pci.h
> > > new file mode 100644
> > > index 000000000000..ad63560caa2c
> > > --- /dev/null
> > > +++ b/include/cxl/pci.h
> > > @@ -0,0 +1,23 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > > +
> > > +#ifndef __CXL_ACCEL_PCI_H
> > > +#define __CXL_ACCEL_PCI_H
> > > +
> > > +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> > > +#define CXL_DVSEC_PCIE_DEVICE					0
> > > +#define   CXL_DVSEC_CAP_OFFSET		0xA
> > > +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
> > > +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
> > > +#define   CXL_DVSEC_CTRL_OFFSET		0xC
> > > +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
> > > +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
> > > +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
> > > +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
> > > +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
> > > +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
> > > +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
> > > +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
> > > +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
> > > +
> > > +#endif
> > > -- 
> > > 2.17.1
> > > 
> > > 

