Return-Path: <netdev+bounces-126255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF49703EE
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 21:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367361C2159A
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 19:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC6E166F10;
	Sat,  7 Sep 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdzJmyPT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F1165EE9;
	Sat,  7 Sep 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725737671; cv=none; b=LVdSzyU2mHP4s4B0FOR0wnDylQzGxbCHvMnpZVzSmUAaLVzgAlW+z0KmtPDetM/pQi45V2LKjI03mpop4pshaaDZKEJUbuUDaR2n9v9K5dyYHh05MFtw8+Ia/FPSBR5TGoPoV7IeqY9nPUbDv7m7gje3oef+3UPrg7Z0dujElYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725737671; c=relaxed/simple;
	bh=1ukAVay/w9SQA1YlJeeTqxisC//QG8terdPsqJW9txw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJz927XnuiLHpNC5V+T22D7xO2RJ8Cr1kk3r6PGjbrnQx3+KH4ucXC0t4GjDI7ksgI1HTTq0wd0XbEqc3HMRt8MJmK7X/vZZ8NrsYFgJXLnUo/JmGslKEIDDivpWMZ8ESKIxK/lNUvxqNGtt4XzuiQyhaLe62eHZEq+4q4lP4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdzJmyPT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725737670; x=1757273670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ukAVay/w9SQA1YlJeeTqxisC//QG8terdPsqJW9txw=;
  b=KdzJmyPTRF4WcugAocQbOqu7tIQPIHM7jB9UZrHw27OUX7zjkXMshg0f
   mwWmlbLwe/snrkQw3mpP51bbUXr3CfewGL15kJ5+Vl8A1VyeLPA8nAZ8Y
   BUWv+OU8xcSSKv8+CxqX1fGXbkTInwvtn5YWDGfc7Km2jv+KgdZGdtfyr
   w5mENRXkuYc/XOrqOhhK9HODiUbmsp1jq0md8Dr2wFePQY6loUfrFzOao
   /LA7eakuUziDZO2VBD0rBJAmCyO2hsY2g8x6woYVLMXIIhGGAg7m8RBu4
   4HWMBwkhtIjtCnDPFpM/21CYl+ZH31KlFhEgXKC0zEyxUzKz8OmvFOV8G
   Q==;
X-CSE-ConnectionGUID: L17O598WRP+hivun3wz22w==
X-CSE-MsgGUID: xNfnD4srSoCJEJmHn7fm0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24616317"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24616317"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 12:34:29 -0700
X-CSE-ConnectionGUID: SsFyz58YRrOA5Yd2fuu7bA==
X-CSE-MsgGUID: uqQG3mB2Qlm8M3vWIxFYWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="71044176"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Sep 2024 12:34:27 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn1CS-000CuO-0S;
	Sat, 07 Sep 2024 19:34:24 +0000
Date: Sun, 8 Sep 2024 03:33:29 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v3 12/20] efx: use acquire_endpoint when looking for free
 HPA
Message-ID: <202409080317.xjZq1ABN-lkp@intel.com>
References: <20240907081836.5801-13-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907081836.5801-13-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cxl/next]
[also build test WARNING on linus/master v6.11-rc6 next-20240906]
[cannot apply to cxl/pending horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20240907-162231
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20240907081836.5801-13-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v3 12/20] efx: use acquire_endpoint when looking for free HPA
config: powerpc-ppc6xx_defconfig (https://download.01.org/0day-ci/archive/20240908/202409080317.xjZq1ABN-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080317.xjZq1ABN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080317.xjZq1ABN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/cxl/cxl.h:7,
                    from drivers/net/ethernet/sfc/efx_cxl.c:12:
   drivers/net/ethernet/sfc/efx_cxl.c: In function 'efx_cxl_init':
>> drivers/net/ethernet/sfc/efx_cxl.c:114:34: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     114 |                 pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:154:56: note: in expansion of macro 'dev_fmt'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   include/linux/pci.h:2679:41: note: in expansion of macro 'dev_err'
    2679 | #define pci_err(pdev, fmt, arg...)      dev_err(&(pdev)->dev, fmt, ##arg)
         |                                         ^~~~~~~
   drivers/net/ethernet/sfc/efx_cxl.c:114:17: note: in expansion of macro 'pci_err'
     114 |                 pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
         |                 ^~~~~~~
   drivers/net/ethernet/sfc/efx_cxl.c:114:67: note: format string is defined here
     114 |                 pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
         |                                                                ~~~^
         |                                                                   |
         |                                                                   long long unsigned int
         |                                                                %u


vim +114 drivers/net/ethernet/sfc/efx_cxl.c

  > 12	#include <linux/cxl/cxl.h>
    13	#include <linux/cxl/pci.h>
    14	#include <linux/pci.h>
    15	
    16	#include "net_driver.h"
    17	#include "efx_cxl.h"
    18	
    19	#define EFX_CTPIO_BUFFER_SIZE	(1024 * 1024 * 256)
    20	
    21	int efx_cxl_init(struct efx_nic *efx)
    22	{
    23		struct pci_dev *pci_dev = efx->pci_dev;
    24		struct efx_cxl *cxl;
    25		struct resource res;
    26		resource_size_t max;
    27		u16 dvsec;
    28		int rc;
    29	
    30		efx->efx_cxl_pio_initialised = false;
    31	
    32		dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
    33						  CXL_DVSEC_PCIE_DEVICE);
    34	
    35		if (!dvsec)
    36			return 0;
    37	
    38		pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
    39	
    40		efx->cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
    41		if (!efx->cxl)
    42			return -ENOMEM;
    43	
    44		cxl = efx->cxl;
    45	
    46		cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
    47		if (IS_ERR(cxl->cxlds)) {
    48			pci_err(pci_dev, "CXL accel device state failed");
    49			kfree(efx->cxl);
    50			return -ENOMEM;
    51		}
    52	
    53		cxl_set_dvsec(cxl->cxlds, dvsec);
    54		cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
    55	
    56		res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
    57		if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_DPA)) {
    58			pci_err(pci_dev, "cxl_set_resource DPA failed\n");
    59			rc = -EINVAL;
    60			goto err;
    61		}
    62	
    63		res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
    64		if (cxl_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM)) {
    65			pci_err(pci_dev, "cxl_set_resource RAM failed\n");
    66			rc = -EINVAL;
    67			goto err;
    68		}
    69	
    70		rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
    71		if (rc) {
    72			pci_err(pci_dev, "CXL accel setup regs failed");
    73			goto err;
    74		}
    75	
    76		rc = cxl_request_resource(cxl->cxlds, CXL_ACCEL_RES_RAM);
    77		if (rc) {
    78			pci_err(pci_dev, "CXL request resource failed");
    79			goto err;
    80		}
    81	
    82		/* We do not have the register about media status. Hardware design
    83		 * implies it is ready.
    84		 */
    85		cxl_set_media_ready(cxl->cxlds);
    86	
    87		cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
    88		if (IS_ERR(cxl->cxlmd)) {
    89			pci_err(pci_dev, "CXL accel memdev creation failed");
    90			rc = PTR_ERR(cxl->cxlmd);
    91			goto err;
    92		}
    93	
    94		cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
    95		if (IS_ERR(cxl->endpoint)) {
    96			rc = PTR_ERR(cxl->endpoint);
    97			if (rc != -EPROBE_DEFER) {
    98				pci_err(pci_dev, "CXL accel acquire endpoint failed");
    99				goto err;
   100			}
   101		}
   102	
   103		cxl->cxlrd = cxl_get_hpa_freespace(cxl->endpoint,
   104						   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
   105						   &max);
   106	
   107		if (IS_ERR(cxl->cxlrd)) {
   108			pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
   109			rc = PTR_ERR(cxl->cxlrd);
   110			goto err_release;
   111		}
   112	
   113		if (max < EFX_CTPIO_BUFFER_SIZE) {
 > 114			pci_err(pci_dev, "%s: no enough free HPA space %llu < %u\n",
   115				__func__, max, EFX_CTPIO_BUFFER_SIZE);
   116			rc = -ENOSPC;
   117			goto err;
   118		}
   119	
   120		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
   121	
   122		return 0;
   123	
   124	err_release:
   125		cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
   126	err:
   127		kfree(cxl->cxlds);
   128		kfree(cxl);
   129		efx->cxl = NULL;
   130	
   131		return rc;
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

