Return-Path: <netdev+bounces-154266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE849FC676
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 21:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCDE1882EF3
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A57136C;
	Wed, 25 Dec 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6snIM/8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432419258B;
	Wed, 25 Dec 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735158126; cv=none; b=osXSyzt4NCSJqO1mZwL4PcAYNcTASdbJrQIKEmZ8fm95D+GQwqpjz8gEW1klGtxUzH52y90GUzPH/ycGbpL/sMrEmUj/tBUoT2fXwHRGsHSmRF94YsDOoc/PqYhGsztnBbU8PNqp5XY1XTlBtZIk03kds5/OIX69zfC9fnxe+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735158126; c=relaxed/simple;
	bh=FAhwDFaOLN+9a+xH6yZJXC2FCUU8+PrdVP9u5Ao6KDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSteonfQkl9liOvqTgrjMD7RULCgf/vGVW88/ofAOJ1UKwY88m0l/XvUWIz/TQD6f6XDalHE/dJ6vDm2khsx6UpusmsgXIzt52zrlZM6FT+vJr2HjU7mr6cmPpc/Z3xVuE0nmH243R1sHM33vOhXzmqjgLAaSjnHWXdyArbIY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6snIM/8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735158122; x=1766694122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FAhwDFaOLN+9a+xH6yZJXC2FCUU8+PrdVP9u5Ao6KDc=;
  b=G6snIM/8/gOKUBy3H+baQ3OVqYNVIel7GzM24pG7e3jNl+rV/AmQnS0e
   75KaABHABqlqe2NofH259iELbuwONcvOuND+bc2lVwo0ymtvBXxFcH4W0
   swdaiormpnztb/yTluwN4l145KBiiyJnyVKwjiT0x9uoLvNh+QokDJ+nv
   BXCYr+C5EkwXxqyjcUL6fW3F3QGnspgV7odeCL7yh/N4gO+abijVemYF7
   JsAAIvs0bbUYP0xw8J//d9yxb+Vf9ROVZA9IDuMWzEC0vStiH3+xdGAuU
   fK0xtT0R6UogB6M4SnEDWFJe4CZCcj7lg4uIpYcEDxuPiQpJLmvsBa4G5
   g==;
X-CSE-ConnectionGUID: x8yKXfliSBG2Z0q/I7SNdw==
X-CSE-MsgGUID: 1Rn9kOJKS62N14H3CwslMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="60974601"
X-IronPort-AV: E=Sophos;i="6.12,264,1728975600"; 
   d="scan'208";a="60974601"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 12:22:01 -0800
X-CSE-ConnectionGUID: 33aUnnuJToyKvs5vQvDpXw==
X-CSE-MsgGUID: SwLU9jH3SIioxF89jx3j/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100600011"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 25 Dec 2024 12:21:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQXtD-000282-11;
	Wed, 25 Dec 2024 20:21:55 +0000
Date: Thu, 26 Dec 2024 04:21:30 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v8 16/27] sfc: obtain root decoder with enough HPA free
 space
Message-ID: <202412260415.oH9bfTi0-lkp@intel.com>
References: <20241216161042.42108-17-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216161042.42108-17-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on fac04efc5c793dccbd07e2d59af9f90b7fc0dca4]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20241217-001923
base:   fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
patch link:    https://lore.kernel.org/r/20241216161042.42108-17-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v8 16/27] sfc: obtain root decoder with enough HPA free space
config: x86_64-randconfig-071-20241225 (https://download.01.org/0day-ci/archive/20241226/202412260415.oH9bfTi0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241226/202412260415.oH9bfTi0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412260415.oH9bfTi0-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/net/ethernet/sfc/efx_cxl.o: in function `efx_cxl_init':
>> drivers/net/ethernet/sfc/efx_cxl.c:107: undefined reference to `cxl_get_hpa_freespace'


vim +107 drivers/net/ethernet/sfc/efx_cxl.c

    20	
    21	int efx_cxl_init(struct efx_probe_data *probe_data)
    22	{
    23		struct efx_nic *efx = &probe_data->efx;
    24		DECLARE_BITMAP(expected, CXL_MAX_CAPS);
    25		DECLARE_BITMAP(found, CXL_MAX_CAPS);
    26		resource_size_t max_size;
    27		struct pci_dev *pci_dev;
    28		struct efx_cxl *cxl;
    29		struct resource res;
    30		u16 dvsec;
    31		int rc;
    32	
    33		pci_dev = efx->pci_dev;
    34		probe_data->cxl_pio_initialised = false;
    35	
    36		dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
    37						  CXL_DVSEC_PCIE_DEVICE);
    38		if (!dvsec)
    39			return 0;
    40	
    41		pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
    42	
    43		cxl = kzalloc(sizeof(*cxl), GFP_KERNEL);
    44		if (!cxl)
    45			return -ENOMEM;
    46	
    47		cxl->cxlds = cxl_accel_state_create(&pci_dev->dev);
    48		if (IS_ERR(cxl->cxlds)) {
    49			pci_err(pci_dev, "CXL accel device state failed");
    50			rc = -ENOMEM;
    51			goto err_state;
    52		}
    53	
    54		cxl_set_dvsec(cxl->cxlds, dvsec);
    55		cxl_set_serial(cxl->cxlds, pci_dev->dev.id);
    56	
    57		res = DEFINE_RES_MEM(0, EFX_CTPIO_BUFFER_SIZE);
    58		if (cxl_set_resource(cxl->cxlds, res, CXL_RES_DPA)) {
    59			pci_err(pci_dev, "cxl_set_resource DPA failed\n");
    60			rc = -EINVAL;
    61			goto err_resource_set;
    62		}
    63	
    64		res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
    65		if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
    66			pci_err(pci_dev, "cxl_set_resource RAM failed\n");
    67			rc = -EINVAL;
    68			goto err_resource_set;
    69		}
    70	
    71		rc = cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds);
    72		if (rc) {
    73			pci_err(pci_dev, "CXL accel setup regs failed");
    74			goto err_resource_set;
    75		}
    76	
    77		bitmap_clear(expected, 0, CXL_MAX_CAPS);
    78		bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
    79		bitmap_set(expected, CXL_DEV_CAP_RAS, 1);
    80	
    81		if (!cxl_pci_check_caps(cxl->cxlds, expected, found)) {
    82			pci_err(pci_dev,
    83				"CXL device capabilities found(%08lx) not as expected(%08lx)",
    84				*found, *expected);
    85			rc = -EIO;
    86			goto err_resource_set;
    87		}
    88	
    89		rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
    90		if (rc) {
    91			pci_err(pci_dev, "CXL request resource failed");
    92			goto err_resource_set;
    93		}
    94	
    95		/* We do not have the register about media status. Hardware design
    96		 * implies it is ready.
    97		 */
    98		cxl_set_media_ready(cxl->cxlds);
    99	
   100		cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
   101		if (IS_ERR(cxl->cxlmd)) {
   102			pci_err(pci_dev, "CXL accel memdev creation failed");
   103			rc = PTR_ERR(cxl->cxlmd);
   104			goto err_memdev;
   105		}
   106	
 > 107		cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
   108						   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
   109						   &max_size);
   110	
   111		if (IS_ERR(cxl->cxlrd)) {
   112			pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
   113			rc = PTR_ERR(cxl->cxlrd);
   114			goto err_memdev;
   115		}
   116	
   117		if (max_size < EFX_CTPIO_BUFFER_SIZE) {
   118			pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
   119				__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
   120			rc = -ENOSPC;
   121			goto err_memdev;
   122		}
   123	
   124		probe_data->cxl = cxl;
   125	
   126		return 0;
   127	
   128	err_memdev:
   129		cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
   130	err_resource_set:
   131		kfree(cxl->cxlds);
   132	err_state:
   133		kfree(cxl);
   134		return rc;
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

