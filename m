Return-Path: <netdev+bounces-273704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIBXDAUCzGljNQYAu9opvQ
	(envelope-from <netdev+bounces-273704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:19:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B84536E792
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF74E3167C57
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF366423A99;
	Tue, 31 Mar 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cR06CJgo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69094423A82;
	Tue, 31 Mar 2026 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975685; cv=none; b=ayqRn5kuA1tISuqm1bSE1LE/lJfPYc++eqVi3ZWXRUU50mZmLUVBpF1lADk8bGJ/vYsQwvNVet3CG0/rzjzFB18j2XQKCFRQjOiaz88767muq5v6cBizKCRIbT8Oxf/4MR9LvGRwCp6i0khZrEnY7BbuJD4ZBSg7uoHr/rSyllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975685; c=relaxed/simple;
	bh=aM5qG+4yxm72Z97PK63zuUnHgVpyXdwXPEQPrA1BXew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSLrS5b0aEPIu7rSswZZuqEx5YVIbNpX0g1Pl0Gg2L+CrgBEHHflGgKPaaITfVCw+MSEB7feYRn9W1aQBkASS42bXpZD5eXc6uk77InIdW++pA8mixve43XfVBsvTzFs7m0oA2Sv9U4oH9155oCOf1mqAEs4LHZalK53F/JLmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cR06CJgo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774975685; x=1806511685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aM5qG+4yxm72Z97PK63zuUnHgVpyXdwXPEQPrA1BXew=;
  b=cR06CJgofq4K5XuciCpMHfKuQIMNEHwpiGgL2tvqgMTFeSPXEVwyPoAf
   tpErLh/nK5yUJ//ENRCEDKYj0JPsOBX/T/PT9b4nPTTwr1hiizECOMM/e
   gDpqAITsX/bv+MWZrLxoooHiJiADWGcrjiQPQYPJJy9dDQUhuJDOt2Rdi
   oI3Lhvqfg7QPRp18dtPuZA4fe6nZP05TCZcXUO/ZAzDRzJJMtBSFbDo2Q
   /97Pa1TAp1/QnRP5pxIUOEHcWqknMQHbmYNrdUPbVJHCI123OAzPU0KJz
   XayLd2z4O1ouBpDXt1yjaQU1MnYkjWiH045tEdrO6XlPVVVIxyOTK1X/J
   Q==;
X-CSE-ConnectionGUID: 5LIx6tQDS7qLZSTyq3aNNw==
X-CSE-MsgGUID: 65WjkHOQR5KdqdTCsSMtWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="63550246"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="63550246"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 09:48:04 -0700
X-CSE-ConnectionGUID: 5P2aml7iQBGT1HScRhkx8w==
X-CSE-MsgGUID: 4l/5J7rUR/iNXcsH1WvH+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="221557860"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 31 Mar 2026 09:48:00 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7cFw-00000000389-40Ha;
	Tue, 31 Mar 2026 16:47:56 +0000
Date: Wed, 1 Apr 2026 00:47:35 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dave.jiang@intel.com,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Fan Ni <fan.ni@samsung.com>, Edward Cree <ecree.xilinx@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v25 05/11] sfc: create type2 cxl memdev
Message-ID: <202604010047.zovyb3Z0-lkp@intel.com>
References: <20260330143827.1278677-6-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330143827.1278677-6-alejandro.lucero-palau@amd.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lists.linux.dev,amd.com,gmail.com,samsung.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-273704-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 9B84536E792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 64584273dfb8a1e5fc7d78094ba22a93c204b44e]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/sfc-add-cxl-support/20260331-055820
base:   64584273dfb8a1e5fc7d78094ba22a93c204b44e
patch link:    https://lore.kernel.org/r/20260330143827.1278677-6-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v25 05/11] sfc: create type2 cxl memdev
config: x86_64-randconfig-003-20260331 (https://download.01.org/0day-ci/archive/20260401/202604010047.zovyb3Z0-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010047.zovyb3Z0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010047.zovyb3Z0-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `efx_cxl_init':
>> drivers/net/ethernet/sfc/efx_cxl.c:78:(.text+0xd33fcd): undefined reference to `devm_cxl_add_memdev'


vim +78 drivers/net/ethernet/sfc/efx_cxl.c

    16	
    17	int efx_cxl_init(struct efx_probe_data *probe_data)
    18	{
    19		struct efx_nic *efx = &probe_data->efx;
    20		struct pci_dev *pci_dev = efx->pci_dev;
    21		struct efx_cxl *cxl;
    22		u16 dvsec;
    23		int rc;
    24	
    25		probe_data->cxl_pio_initialised = false;
    26	
    27		/* Is the device configured with and using CXL? */
    28		if (!pcie_is_cxl(pci_dev))
    29			return 0;
    30	
    31		dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
    32						  PCI_DVSEC_CXL_DEVICE);
    33		if (!dvsec) {
    34			pci_info(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
    35			return 0;
    36		}
    37	
    38		pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
    39	
    40		/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
    41		 * specifying no mbox available.
    42		 */
    43		cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
    44						pci_dev->dev.id, dvsec, struct efx_cxl,
    45						cxlds, false);
    46	
    47		if (!cxl)
    48			return -ENOMEM;
    49	
    50		rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
    51					&cxl->cxlds.reg_map);
    52		if (rc) {
    53			pci_err(pci_dev, "No component registers\n");
    54			return rc;
    55		}
    56	
    57		if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
    58			pci_err(pci_dev, "Expected HDM component register not found\n");
    59			return -ENODEV;
    60		}
    61	
    62		if (!cxl->cxlds.reg_map.component_map.ras.valid) {
    63			pci_err(pci_dev, "Expected RAS component register not found\n");
    64			return -ENODEV;
    65		}
    66	
    67		/* Set media ready explicitly as there are neither mailbox for checking
    68		 * this state nor the CXL register involved, both not mandatory for
    69		 * type2.
    70		 */
    71		cxl->cxlds.media_ready = true;
    72	
    73		if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE)) {
    74			pci_err(pci_dev, "dpa capacity setup failed\n");
    75			return -ENODEV;
    76		}
    77	
  > 78		cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
    79		if (IS_ERR(cxl->cxlmd)) {
    80			pci_err(pci_dev, "CXL accel memdev creation failed");
    81			return PTR_ERR(cxl->cxlmd);
    82		}
    83	
    84		probe_data->cxl = cxl;
    85	
    86		return 0;
    87	}
    88	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

