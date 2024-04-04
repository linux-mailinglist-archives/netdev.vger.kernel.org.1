Return-Path: <netdev+bounces-84811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A774D898646
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5A428872E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5886248;
	Thu,  4 Apr 2024 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UR81OxVc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BD85C68
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230974; cv=none; b=teY6tAfdZ3b5/BqMNP/VCYwlhwQFSaUMSg/bk7jq1TOCBH0x+IbwiOYeEdblPsGNZYoJMbbMtvP/ADemFs+Ax2y+mCHmfHrsZr8En7hdONsGPditnrrarpr0CkDT8GpaZ6jydEDFEtdmcGQgIuNP3r6wh9i7llxXgFsLFYj7KyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230974; c=relaxed/simple;
	bh=XfVw85LlYxUIoWD+n31Wz341FL4ChN0VrqdDihjnxj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrjV5x9c4RIh+BvlOwLRyzEAjcqlckHwcaXq69yBBjnS88ZxOr1fzx3IHtwLA8XyPBzEqWqOzjUFSCyw0Ft2p7H6TpCNIvoUkR6D8qVK0bwYwZxmL34N3wrlDAB4aOF/I3oTGuQPkv7oQIVnb1QxwRCsBbKBG3FAY0YRTihIDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UR81OxVc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712230970; x=1743766970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfVw85LlYxUIoWD+n31Wz341FL4ChN0VrqdDihjnxj4=;
  b=UR81OxVcbYRXAKau/ZJNDFRX9z3Hz1/Irkrg5zG2Qvy0rRR23i/0bRiz
   pgs/+TrdSbls1V7agWw89/zxyd+f0yAarfbIr86jFRxGnrc4kW8PgPwZ3
   TyfkXAovxIV9yRPFF6mOgEz6wVfpjNdDHXpdXsfaSJYKbvN6+NE19spVP
   MQisHUrVcs7F8SnAHPfaxQv7Hwv8kijqceWUOuiuzV5ueHZOtu9QuC3vF
   8831pQyssIU4GkVm1BgCe2pEFWgTPSpBhZ9ZsXN6Ht4LQoCbs7qGouxPx
   cgMe5bGODA0two9lH5uhEz1MvL4JcBXYCm5gMaYTjbQ+FIE6HAc+zg5/L
   w==;
X-CSE-ConnectionGUID: Hw+/iy57TpS75l2Z/NXpsA==
X-CSE-MsgGUID: s91uFnURS3Wce6gDiPVAcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7694489"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7694489"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 04:42:49 -0700
X-CSE-ConnectionGUID: xHjDDfFiRTevZ3xn64/scQ==
X-CSE-MsgGUID: KTfw1ycfTdaOzCV3DtEawg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18869861"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 04 Apr 2024 04:42:47 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsLUS-000100-2H;
	Thu, 04 Apr 2024 11:42:44 +0000
Date: Thu, 4 Apr 2024 19:42:13 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 09/15] eth: fbnic: implement Rx queue
 alloc/start/stop/free
Message-ID: <202404041954.giczimoH-lkp@intel.com>
References: <171217494276.1598374.468010123854919775.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217494276.1598374.468010123854919775.stgit@ahduyck-xeon-server.home.arpa>

Hi Alexander,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Duyck/PCI-Add-Meta-Platforms-vendor-ID/20240404-041319
base:   net-next/main
patch link:    https://lore.kernel.org/r/171217494276.1598374.468010123854919775.stgit%40ahduyck-xeon-server.home.arpa
patch subject: [net-next PATCH 09/15] eth: fbnic: implement Rx queue alloc/start/stop/free
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240404/202404041954.giczimoH-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 546dc2245ffc4cccd0b05b58b7a5955e355a3b27)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240404/202404041954.giczimoH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404041954.giczimoH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:4:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:4:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:4:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:5:
   In file included from include/linux/pci.h:37:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/meta/fbnic/fbnic_txrx.c:1041:6: error: call to '__compiletime_assert_733' declared with 'error' attribute: FIELD_PREP: value too large for the field
    1041 |             FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM);
         |             ^
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^
   include/linux/bitfield.h:68:3: note: expanded from macro '__BF_FIELD_CHECK'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:448:2: note: expanded from macro '_compiletime_assert'
     448 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:441:4: note: expanded from macro '__compiletime_assert'
     441 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:54:1: note: expanded from here
      54 | __compiletime_assert_733
         | ^
   17 warnings and 1 error generated.


vim +1041 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c

  1030	
  1031	static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
  1032					       struct fbnic_ring *rcq)
  1033	{
  1034		u32 drop_mode, rcq_ctl;
  1035	
  1036		drop_mode = FBNIC_QUEUE_RDE_CTL0_DROP_IMMEDIATE;
  1037	
  1038		/* Specify packet layout */
  1039		rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
  1040		    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, FBNIC_RX_HROOM) |
> 1041		    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM);
  1042	
  1043		fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
  1044	}
  1045	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

