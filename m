Return-Path: <netdev+bounces-216190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DBB326EF
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 07:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9441FA06168
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 05:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8120C461;
	Sat, 23 Aug 2025 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJCguNRV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463A41FA178
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755927421; cv=none; b=IHVrBs+E0Eldj8c/AGI04Vyz9Q3w8EPx8vsxSb2Aqb6KKdSN+Z1Nrr7uC/Y8/jeMxsXw1tWtOzn2vX4Dl0k4qYFFJfOjehm4/3W6xC/Hq5ZNFMrQVgltre5EBIrvgvlL9mKwnQB1iR2SqoqluIqWwwKDy/8hW/ELolugluddoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755927421; c=relaxed/simple;
	bh=uK/ueCfU4pns+bwPpZslSYBj9WPm/c7mPAKo4rXRMKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIFtelvk5UKkR5gHSM4+sh9jlwnmNKtwRTS+3D0ml1XKNPGKcOqQsljmFseJE6cwf35FelymGt3agoZtVHhLlQ6aw+vwlQUzNrg4sHGDjEzJ23kqzeDEqfgjIdkjINCITlJ/sUBBk/sJC288zoMGvNsSRh83EbCllpv5sXyYThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJCguNRV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755927419; x=1787463419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uK/ueCfU4pns+bwPpZslSYBj9WPm/c7mPAKo4rXRMKw=;
  b=TJCguNRVlngwzz1qzLVp7j2Bjh9HWCbzXHVG5WGGbuZ0jPBkkck2+v+q
   Z6ATJKtI0t2XO2ty25FvbeRNdQXoVjB09r8hLkFMrcMrVZAJ1A/T9I3fZ
   jP/l1DP28cexbQwgI4+zL/sH7lcViXMN0ZrM9RBz3z/bI9H7woUbQkPQn
   xAOAvphSV6RfHxq+o+EQSChNrdqUocB8f1m2x0RMw5ARegCb4yvu8QT4n
   kedakZI0RPazSPLn0Z7E5XS3dHigND+0/msEBxF/sGwSVM7LV5XK7+HWu
   jdSRfwxm0dg0jTW2AowXfxwFRnYkl/N5dJDhmWgqpXCXT0z2bZSz4Hkm6
   A==;
X-CSE-ConnectionGUID: dT8muuQgQxOWbtN2UMRSQQ==
X-CSE-MsgGUID: bV58a2fjQ/i0h0TBTbB0xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75684108"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="75684108"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 22:36:59 -0700
X-CSE-ConnectionGUID: vNBtLRQSSWqej6v2t+G8rA==
X-CSE-MsgGUID: BkxMHIugTAe/Z93RHTc3+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168370247"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 22 Aug 2025 22:36:56 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upgvu-000M6r-0p;
	Sat, 23 Aug 2025 05:36:54 +0000
Date: Sat, 23 Aug 2025 13:36:02 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v15 15/15] net: homa: create Makefile and Kconfig
Message-ID: <202508231353.SNg0KuDi-lkp@intel.com>
References: <20250818205551.2082-16-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818205551.2082-16-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20250819-050052
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250818205551.2082-16-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v15 15/15] net: homa: create Makefile and Kconfig
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250823/202508231353.SNg0KuDi-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508231353.SNg0KuDi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508231353.SNg0KuDi-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/homa/homa_incoming.c:5:
   In file included from net/homa/homa_impl.h:13:
   In file included from include/linux/icmp.h:16:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
   In file included from net/homa/homa_incoming.c:5:
   In file included from net/homa/homa_impl.h:33:
>> arch/x86/include/asm/tsc.h:70:28: error: typedef redefinition with different types ('unsigned long long' vs 'unsigned long')
      70 | typedef unsigned long long cycles_t;
         |                            ^
   include/asm-generic/timex.h:8:23: note: previous definition is here
       8 | typedef unsigned long cycles_t;
         |                       ^
   In file included from net/homa/homa_incoming.c:5:
   In file included from net/homa/homa_impl.h:33:
>> arch/x86/include/asm/tsc.h:77:24: error: redefinition of 'get_cycles'
      77 | static inline cycles_t get_cycles(void)
         |                        ^
   include/asm-generic/timex.h:10:24: note: previous definition is here
      10 | static inline cycles_t get_cycles(void)
         |                        ^
   In file included from net/homa/homa_incoming.c:5:
   In file included from net/homa/homa_impl.h:33:
>> arch/x86/include/asm/tsc.h:80:7: error: call to undeclared function 'DISABLED_MASK_BIT_SET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      80 |             !cpu_feature_enabled(X86_FEATURE_TSC))
         |              ^
   arch/um/include/asm/cpufeature.h:52:32: note: expanded from macro 'cpu_feature_enabled'
      52 |         (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
         |                                       ^
   1 warning and 3 errors generated.


vim +70 arch/x86/include/asm/tsc.h

288a4ff0ad29d1 arch/x86/include/asm/tsc.h Xin Li (Intel             2025-05-02  66) 
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  67  /*
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  68   * Standard way to access the cycle counter.
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  69   */
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06 @70  typedef unsigned long long cycles_t;
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  71  
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  72  extern unsigned int cpu_khz;
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  73  extern unsigned int tsc_khz;
73018a66e70fa6 include/asm-x86/tsc.h      Glauber de Oliveira Costa 2008-01-30  74  
73018a66e70fa6 include/asm-x86/tsc.h      Glauber de Oliveira Costa 2008-01-30  75  extern void disable_TSC(void);
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  76  
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06 @77  static inline cycles_t get_cycles(void)
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  78  {
3bd4abc07a267e arch/x86/include/asm/tsc.h Jason A. Donenfeld        2022-04-08  79  	if (!IS_ENABLED(CONFIG_X86_TSC) &&
3bd4abc07a267e arch/x86/include/asm/tsc.h Jason A. Donenfeld        2022-04-08 @80  	    !cpu_feature_enabled(X86_FEATURE_TSC))
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  81  		return 0;
4ea1636b04dbd6 arch/x86/include/asm/tsc.h Andy Lutomirski           2015-06-25  82  	return rdtsc();
6d63de8dbcda98 include/asm-x86/tsc.h      Andi Kleen                2008-01-30  83  }
3bd4abc07a267e arch/x86/include/asm/tsc.h Jason A. Donenfeld        2022-04-08  84  #define get_cycles get_cycles
2272b0e03ea573 include/asm-i386/tsc.h     Andres Salomon            2007-03-06  85  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

