Return-Path: <netdev+bounces-188588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A35AADA54
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609DA9832E6
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF2C2153CE;
	Wed,  7 May 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM1lSedd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD51FC0F3;
	Wed,  7 May 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607139; cv=none; b=jNpUqSgyYy0kZwJHpp40swrHCW+sXXaykACPQeaPjZRGMqf/jhEemcvgge/VCayaM+iTaDNsO/MF1HLQ9dA/yvfggXmSJyzuh0nbtW5jAXhQGwfxJRt+gkCHkpwGzUq2cBVlOwV03HDz5oNapC8Wkm4CE5HhEhYdtivwrHxznDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607139; c=relaxed/simple;
	bh=rUf/+8WEAKoqZwi0tdXW88XfEBNtnpTRxzqre/OWWBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er+T0rD+V/96hDMYQsrWzvLtj31tnE0b8tCCM1oyA/tRoa2PUI2DilJrVF3Z1YfQVXnpx1+rovXqbRdleA4B37A3BclEOxhNW+m0IxH/+yUyQg78QcwVxkmouhosw0ynwlln9zWZD+XFaWybNJF2aR7NleKKSmvaJmsHNrq1RQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM1lSedd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746607138; x=1778143138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rUf/+8WEAKoqZwi0tdXW88XfEBNtnpTRxzqre/OWWBc=;
  b=QM1lSedd1/5vXbWWEz4MekqN00pONZS074nhsHz+rpXfCMCWr6pi1m17
   lHJDb5Ru4JmRJcqH+z8IPCOGHvofhZiq5L2n+YmPcX7d4w0yJ1Ve3T5Fk
   FjeyBUh4tIsXDbkg8kw7bSXPyYfE9jqwIXoRxc59+qmds3QJFL5D0jomx
   rcimmK4MuSeRNYSw8cbI6TilqaTucEv0oLVp0yQ8DNdn3KRSFREpzi11V
   yDvqSXF0sO4WJKAEQdaHxX0O6bElu/uKV76Zo+G3bDAL0KuKKlIxVV5yl
   wxnhtUyNbWeaplwONYJMRvPmcLrK1hOstMzcOAQxoxyfwgq9DSSW84q3g
   g==;
X-CSE-ConnectionGUID: N7BRRnjoRnqGk42dMo1arA==
X-CSE-MsgGUID: zM6XZ8PRTWKvEGOkGtvgcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48195739"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="48195739"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 01:38:56 -0700
X-CSE-ConnectionGUID: Hol80FtkT02IDDNx8FOUJA==
X-CSE-MsgGUID: JqKBrAYiT1SdI5ZL61q8MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="136410607"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 May 2025 01:38:53 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCaIk-0007QD-3C;
	Wed, 07 May 2025 08:38:50 +0000
Date: Wed, 7 May 2025 16:37:53 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH net-next v2 3/5] amd-xgbe: add support for new XPCS
 routines
Message-ID: <202505071632.XaIo3kvL-lkp@intel.com>
References: <20250428150235.2938110-4-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428150235.2938110-4-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-reorganize-the-code-of-XPCS-access/20250428-230635
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250428150235.2938110-4-Raju.Rangoju%40amd.com
patch subject: [PATCH net-next v2 3/5] amd-xgbe: add support for new XPCS routines
config: i386-buildonly-randconfig-002-20250429 (https://download.01.org/0day-ci/archive/20250507/202505071632.XaIo3kvL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071632.XaIo3kvL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071632.XaIo3kvL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/amd/xgbe/xgbe-dev.c: In function 'xgbe_write_mmd_regs_v3':
>> drivers/net/ethernet/amd/xgbe/xgbe-dev.c:1110:17: error: implicit declaration of function 'pci_err'; did you mean 'pr_err'? [-Werror=implicit-function-declaration]
    1110 |                 pci_err(dev, "Failed to write data 0x%x\n", index);
         |                 ^~~~~~~
         |                 pr_err
   cc1: some warnings being treated as errors


vim +1110 drivers/net/ethernet/amd/xgbe/xgbe-dev.c

  1094	
  1095	static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
  1096					   int mmd_reg, int mmd_data)
  1097	{
  1098		unsigned int pci_mmd_data, hi_mask, lo_mask;
  1099		unsigned int mmd_address, index, offset;
  1100		struct pci_dev *dev;
  1101		int ret;
  1102	
  1103		dev = pdata->pcidev;
  1104		mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
  1105	
  1106		xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
  1107	
  1108		ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
  1109		if (ret) {
> 1110			pci_err(dev, "Failed to write data 0x%x\n", index);
  1111			return;
  1112		}
  1113	
  1114		ret = amd_smn_read(0, pdata->smn_base + offset, &pci_mmd_data);
  1115		if (ret) {
  1116			pci_err(dev, "Failed to read data\n");
  1117			return;
  1118		}
  1119	
  1120		if (offset % 4) {
  1121			hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
  1122			lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
  1123		} else {
  1124			hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
  1125					     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
  1126			lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
  1127		}
  1128	
  1129		pci_mmd_data = hi_mask | lo_mask;
  1130	
  1131		ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
  1132		if (ret) {
  1133			pci_err(dev, "Failed to write data 0x%x\n", index);
  1134			return;
  1135		}
  1136	
  1137		ret = amd_smn_write(0, (pdata->smn_base + offset), pci_mmd_data);
  1138		if (ret) {
  1139			pci_err(dev, "Failed to write data 0x%x\n", pci_mmd_data);
  1140			return;
  1141		}
  1142	}
  1143	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

