Return-Path: <netdev+bounces-213617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF2B25E2E
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA461891339
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865052D63E0;
	Thu, 14 Aug 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdwYhxrt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910A42E2DF8;
	Thu, 14 Aug 2025 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158124; cv=none; b=KZCzG488SQw32ZTyNuo05iWcGu+vbn6VClcVV+6NZ+wwu9mu3nSE9BGg1PF7fYRzcHQmx9S81mK+EA7h0Q4lwNW9XD4uDxBVOOVFsbT5thtv6citKjiPpVu+SOCGy5k3ZU9LZpOpLRNBEblfNvP+Jorn+3mlitbwkZcnXDq7KQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158124; c=relaxed/simple;
	bh=K706a+/OcSbYHCeqVGCGuDEaiNuFaDDkMqHrEExkTsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koYNm27UwXeYu140gTmx5NaewBOgQ8VtoggI01mxBsgBikc6gKH8R/zTko2R98m/54r7OtoBxoHJOxIJf8N9b5LfnP5nkwGEx6ZIfpzpKuMrxrSqlajdyipvKbwZU/UMt6K80ZuF1cpKqZJBGFKes65epc5Y/QEwtsqQwjK2Q1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdwYhxrt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755158122; x=1786694122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K706a+/OcSbYHCeqVGCGuDEaiNuFaDDkMqHrEExkTsc=;
  b=CdwYhxrtsBKioQInW0AjPvjbuIsrSqkN+CckBQRWf/9lbSxnXhuHz0Kt
   PoE5snaMJv3LZAe9uhoNCN68wSw4ijSphWCTwf6NevNQnLFLw1QLah8yY
   0WCB0p+Rv5zv22zhQqRtCllRcsZT2S5pz9ym+yvMbNTtYVUOQwVLJxQSw
   h48Zv4WkkJs2nG8Pogq4mafxfSfsBpq5YZWGcmKzDpqQaGgMEkoj4Azdm
   3hwN1deh5dZUZBITfL8NdPiYc/cQf/D3BPogiVnrlCQZJ6sIrx3PkXLja
   HH6a7/zcP/kAgxw9qLmoM9O/+bpy/+KDGmeQtFQ5fiP/Sq4RAJ7d1u581
   A==;
X-CSE-ConnectionGUID: WwLb6U4lRL2q8vlJPkFz+w==
X-CSE-MsgGUID: u4pg/TtrQkm5P0V+roThUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57534677"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57534677"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 00:55:22 -0700
X-CSE-ConnectionGUID: COBFqvLsRs+TDow72JtVwA==
X-CSE-MsgGUID: Y+Z7SIpxTC+IDyoW1ArBpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="167064142"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 14 Aug 2025 00:55:19 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umSnl-000AjE-2G;
	Thu, 14 Aug 2025 07:55:11 +0000
Date: Thu, 14 Aug 2025 15:54:36 +0800
From: kernel test robot <lkp@intel.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next 7/9] bng_en: Register rings with the firmware
Message-ID: <202508141517.TTc9sw7w-lkp@intel.com>
References: <20250813215603.76526-8-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813215603.76526-8-bhargava.marreddy@broadcom.com>

Hi Bhargava,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargava-Marreddy/bng_en-Add-initial-support-for-RX-and-TX-rings/20250814-004339
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250813215603.76526-8-bhargava.marreddy%40broadcom.com
patch subject: [net-next 7/9] bng_en: Register rings with the firmware
config: um-randconfig-002-20250814 (https://download.01.org/0day-ci/archive/20250814/202508141517.TTc9sw7w-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250814/202508141517.TTc9sw7w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508141517.TTc9sw7w-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/broadcom/bnge/bnge_core.c:5:
   In file included from include/linux/crash_dump.h:5:
   In file included from include/linux/kexec.h:20:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_core.c:9:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge.h:13:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_resc.h:7:
>> drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:430:15: error: incomplete definition of type 'struct bnge_dev'
     430 |         spin_lock(&bd->db_lock);
         |                    ~~^
   drivers/net/ethernet/broadcom/bnge/bnge_rmem.h:8:8: note: forward declaration of 'struct bnge_dev'
       8 | struct bnge_dev;
         |        ^
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_core.c:9:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge.h:13:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_resc.h:7:
>> drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:431:2: error: call to undeclared function 'lo_hi_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     431 |         lo_hi_writeq(val, addr);
         |         ^
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:432:17: error: incomplete definition of type 'struct bnge_dev'
     432 |         spin_unlock(&bd->db_lock);
         |                      ~~^
   drivers/net/ethernet/broadcom/bnge/bnge_rmem.h:8:8: note: forward declaration of 'struct bnge_dev'
       8 | struct bnge_dev;
         |        ^
   drivers/net/ethernet/broadcom/bnge/bnge_core.c:177:40: warning: shift count >= width of type [-Wshift-count-overflow]
     177 |         dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
         |                                               ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   2 warnings and 3 errors generated.
--
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_resc.c:6:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_resc.c:10:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge.h:13:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_resc.h:7:
>> drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:430:15: error: incomplete definition of type 'struct bnge_dev'
     430 |         spin_lock(&bd->db_lock);
         |                    ~~^
   drivers/net/ethernet/broadcom/bnge/bnge_rmem.h:8:8: note: forward declaration of 'struct bnge_dev'
       8 | struct bnge_dev;
         |        ^
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_resc.c:10:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge.h:13:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_resc.h:7:
>> drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:431:2: error: call to undeclared function 'lo_hi_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     431 |         lo_hi_writeq(val, addr);
         |         ^
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:432:17: error: incomplete definition of type 'struct bnge_dev'
     432 |         spin_unlock(&bd->db_lock);
         |                      ~~^
   drivers/net/ethernet/broadcom/bnge/bnge_rmem.h:8:8: note: forward declaration of 'struct bnge_dev'
       8 | struct bnge_dev;
         |        ^
   1 warning and 3 errors generated.
--
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c:7:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c:10:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge.h:13:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_resc.h:7:
>> drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:430:15: error: incomplete definition of type 'struct bnge_dev'
     430 |         spin_lock(&bd->db_lock);
         |                    ~~^
   drivers/net/ethernet/broadcom/bnge/bnge_rmem.h:8:8: note: forward declaration of 'struct bnge_dev'
       8 | struct bnge_dev;
         |        ^
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c:10:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge.h:13:
   In file included from drivers/net/ethernet/broadcom/bnge/bnge_resc.h:7:
>> drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:431:2: error: call to undeclared function 'lo_hi_writeq'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     431 |         lo_hi_writeq(val, addr);
         |         ^
   drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:432:17: error: incomplete definition of type 'struct bnge_dev'
     432 |         spin_unlock(&bd->db_lock);
         |                      ~~^
   drivers/net/ethernet/broadcom/bnge/bnge_rmem.h:8:8: note: forward declaration of 'struct bnge_dev'
       8 | struct bnge_dev;
         |        ^
   drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c:768:32: warning: variable 'resp' set but not used [-Wunused-but-set-variable]
     768 |         struct hwrm_ring_free_output *resp;
         |                                       ^
   2 warnings and 3 errors generated.


vim +430 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h

   425	
   426	static inline void bnge_writeq(struct bnge_dev *bd, u64 val,
   427				       void __iomem *addr)
   428	{
   429	#if BITS_PER_LONG == 32
 > 430		spin_lock(&bd->db_lock);
 > 431		lo_hi_writeq(val, addr);
   432		spin_unlock(&bd->db_lock);
   433	#else
   434		writeq(val, addr);
   435	#endif
   436	}
   437	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

