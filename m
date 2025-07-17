Return-Path: <netdev+bounces-207827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D794EB08AED
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F531A63E22
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5A299A85;
	Thu, 17 Jul 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igeXlC98"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973829993D;
	Thu, 17 Jul 2025 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748767; cv=none; b=mHc9jDUSYl3o11il+haoRNBPqTMidf/V2Ovu0qfFdet7qf4vklMBeAi68eYxnwgM5SPWTdQoQz7/FkIs7Tsi7K5T0hKvTBOjh8qTrOPpBqGAnX+mYEIVStkssr8xD32PQyXo2nyjhnfWb2PnPc223UyLhaiMLV2nSUj88VFDmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748767; c=relaxed/simple;
	bh=ixTbXkNXU9v3LqguSktx9Vk85ORfuWDLrT3XQJVQH3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTu6fP/XIhuin2FnE3NOrfDttSclA2SOqhrNDDGV9S40RhMrIhGrNY1yJ5I3Mlh8WnWlU0OxAM+ceV2upYuX3j6hcBgNTVyOlvPbt50+6sQ/hPT3oXw2MLPO8jxaFzcBAlFKiNBgO1rx4ymtlw9k7Lc4m/lDVpXECMWfEFLwvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igeXlC98; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752748765; x=1784284765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ixTbXkNXU9v3LqguSktx9Vk85ORfuWDLrT3XQJVQH3A=;
  b=igeXlC98s+apY+QHkmXwoxPnVOkj2NkrlVkHvH6ngi2Ln3joJCBtZwHO
   fXsPAY+ycdNLbRz+Vxmpf4JyIzFFCIKEH8bsceNK9hYNtG2PM9rnZs9FG
   ZTOokkvY+DHyaohLwNTlbkzb3uN4lGiiEPffX0G7ALx0bqQWJiGNkGqev
   VL+J7aqMnW48CgiMwTlnvOCJc+6p4sQ4dRFxcPnpLsJwJHPcyNeK8B+pG
   sJfON1GNcB74TN7fJTF1XAkqTJzA4Q7vKGbt6LSWy8PM9b0f0prBBIuGd
   nd2AtRaWuCsFIThiuk+UT/6EuubV3Cd5aowshw33C5DXbP6Z/oH5s59CY
   Q==;
X-CSE-ConnectionGUID: bQBaI+C2TYuCm4KZPA9BBw==
X-CSE-MsgGUID: PNSqcJf8QOm4S35NBvnMQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54892902"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="54892902"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 03:39:25 -0700
X-CSE-ConnectionGUID: nsFMpp06Rhaj6pDiKfv1kw==
X-CSE-MsgGUID: XCpSvSnZR2+chxWSjLRqaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="157860301"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Jul 2025 03:39:21 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucM1G-000DX1-30;
	Thu, 17 Jul 2025 10:39:18 +0000
Date: Thu, 17 Jul 2025 18:39:15 +0800
From: kernel test robot <lkp@intel.com>
To: aspeedyh <yh_chung@aspeedtech.com>, jk@codeconstruct.com.au,
	matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bmc-sw@aspeedtech.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Message-ID: <202507171855.3WJVpX2l-lkp@intel.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714062544.2612693-1-yh_chung@aspeedtech.com>

Hi aspeedyh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.16-rc6 next-20250716]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/aspeedyh/net-mctp-Add-MCTP-PCIe-VDM-transport-driver/20250714-142656
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250714062544.2612693-1-yh_chung%40aspeedtech.com
patch subject: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
config: powerpc64-randconfig-r122-20250717 (https://download.01.org/0day-ci/archive/20250717/202507171855.3WJVpX2l-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 16534d19bf50bde879a83f0ae62875e2c5120e64)
reproduce: (https://download.01.org/0day-ci/archive/20250717/202507171855.3WJVpX2l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171855.3WJVpX2l-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/mctp/mctp-pcie-vdm.c:130:1: sparse: sparse: symbol 'mctp_pcie_vdm_dev_mutex' was not declared. Should it be static?
>> drivers/net/mctp/mctp-pcie-vdm.c:131:1: sparse: sparse: symbol 'mctp_pcie_vdm_devs' was not declared. Should it be static?
>> drivers/net/mctp/mctp-pcie-vdm.c:132:25: sparse: sparse: symbol 'mctp_pcie_vdm_wq' was not declared. Should it be static?
>> drivers/net/mctp/mctp-pcie-vdm.c:343:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/mctp/mctp-pcie-vdm.c:343:9: sparse:     expected unsigned int [usertype]
   drivers/net/mctp/mctp-pcie-vdm.c:343:9: sparse:     got restricted __be32 [usertype]
>> drivers/net/mctp/mctp-pcie-vdm.c:398:17: sparse: sparse: cast to restricted __be32
>> drivers/net/mctp/mctp-pcie-vdm.c:398:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/mctp/mctp-pcie-vdm.c:398:17: sparse:     expected unsigned int [usertype]
   drivers/net/mctp/mctp-pcie-vdm.c:398:17: sparse:     got restricted __le32 [usertype]
   drivers/net/mctp/mctp-pcie-vdm.c:453:25: sparse: sparse: cast to restricted __be32
   drivers/net/mctp/mctp-pcie-vdm.c:453:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/net/mctp/mctp-pcie-vdm.c:453:25: sparse:     expected unsigned int [usertype]
   drivers/net/mctp/mctp-pcie-vdm.c:453:25: sparse:     got restricted __le32 [usertype]

vim +/mctp_pcie_vdm_dev_mutex +130 drivers/net/mctp/mctp-pcie-vdm.c

   128	
   129	/* mutex for vdm_devs add/delete */
 > 130	DEFINE_MUTEX(mctp_pcie_vdm_dev_mutex);
 > 131	LIST_HEAD(mctp_pcie_vdm_devs);
 > 132	struct workqueue_struct *mctp_pcie_vdm_wq;
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

