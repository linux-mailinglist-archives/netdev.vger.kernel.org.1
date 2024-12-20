Return-Path: <netdev+bounces-153685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E909F9377
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749A6188AAB8
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD31215F40;
	Fri, 20 Dec 2024 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ef9mAkKn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9686349;
	Fri, 20 Dec 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702211; cv=none; b=k1GSxhFSKmM3VqR7Cm38ZXPYeKamBlY7dVTPRwRkVV5lKnVmIg/HTWJi78dzbSSzwZvsdV4KYvhYbwAnBRweeiUSRguovIOwcxE5I2DJArBBoekA2pGS4DS9JITJ4pEqwmH0LtknvTiRYgCOerXhg9Ay5xsFgyxO8VhTOTftUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702211; c=relaxed/simple;
	bh=D1DYlVWx+N8q+xaoc+H+qkYq6L6bLr3bZzEX+jbTMfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9ZKjrpxv8v2oxVcRivmPLezoWtdQDtlm7opBRKI8BuKRtQsssnecr1zJkHa6hUd8TstguSu85WeDk8hEcqmXkD+Bs5oWv7VEXiq9vgLCZGjUmyqHnz5hQ4Uur3jyj35KWbaCMV5tzsOg2nFqPCju2jWeScW/TPh8qYikBhRUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ef9mAkKn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734702208; x=1766238208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D1DYlVWx+N8q+xaoc+H+qkYq6L6bLr3bZzEX+jbTMfE=;
  b=ef9mAkKngJ2Ad/lkOm/1Y/HxnLEAon81mLG48urQcC7GMUUQq/qIVQtR
   Uz8/tLJH9AqBnXyUOh572XUZru+Z+XYE/vi2TaB3fgH6Dti25PnK2w85A
   e5qahy9o3OvBJV1Oq4qvy3T1eTSAVkC9i9bUQzGkDpXFSOp4+PULla/0J
   Kn8gi+No5HL4ipWaVwc1aW1WX+zs4z0/j//yR/XqhptAei2WOEVf5KRm9
   wXDixVwW4IdhBmAMCxCWkNSEjvMp7U0jF+nqeaxGaeG50VrRMm8c/xCRi
   6zqBUee2PM0NmnehdUzJX04s3uh2Vg0kWtT1gmWhnTcApUpuFjmQ96yfK
   g==;
X-CSE-ConnectionGUID: BewbjRXUT4meh9txweXVoA==
X-CSE-MsgGUID: uLn/T/UfQi+yyTg3pK1XDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35281101"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="35281101"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 05:43:28 -0800
X-CSE-ConnectionGUID: nqWMJoNzQdmMiP1bG6aL6A==
X-CSE-MsgGUID: rHjW1K4lQVOXgQ7ljJDvLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121791754"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Dec 2024 05:43:25 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOdHn-0001C5-1c;
	Fri, 20 Dec 2024 13:43:23 +0000
Date: Fri, 20 Dec 2024 21:42:55 +0800
From: kernel test robot <lkp@intel.com>
To: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH net-next] sock: make SKB_FRAG_PAGE_ORDER equal to
 PAGE_ALLOC_COSTLY_ORDER
Message-ID: <202412202122.04V0tnNx-lkp@intel.com>
References: <20241217105659.2215649-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217105659.2215649-1-yajun.deng@linux.dev>

Hi Yajun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Yajun-Deng/sock-make-SKB_FRAG_PAGE_ORDER-equal-to-PAGE_ALLOC_COSTLY_ORDER/20241217-185748
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241217105659.2215649-1-yajun.deng%40linux.dev
patch subject: [PATCH net-next] sock: make SKB_FRAG_PAGE_ORDER equal to PAGE_ALLOC_COSTLY_ORDER
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20241220/202412202122.04V0tnNx-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241220/202412202122.04V0tnNx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412202122.04V0tnNx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/openrisc/include/asm/page.h:18,
                    from arch/openrisc/include/asm/processor.h:19,
                    from arch/openrisc/include/asm/thread_info.h:22,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/openrisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from include/linux/ip.h:16,
                    from include/net/ip.h:22,
                    from include/linux/errqueue.h:6,
                    from net/core/sock.c:91:
   net/core/sock.c: In function 'skb_page_frag_refill':
>> include/vdso/page.h:15:25: warning: conversion from 'long unsigned int' to '__u16' {aka 'short unsigned int'} changes value from '65536' to '0' [-Woverflow]
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                         ^
   net/core/sock.c:3044:39: note: in expansion of macro 'PAGE_SIZE'
    3044 |                         pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
         |                                       ^~~~~~~~~


vim +15 include/vdso/page.h

efe8419ae78d65 Vincenzo Frascino 2024-10-14  14  
efe8419ae78d65 Vincenzo Frascino 2024-10-14 @15  #define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
efe8419ae78d65 Vincenzo Frascino 2024-10-14  16  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

