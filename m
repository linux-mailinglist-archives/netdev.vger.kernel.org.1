Return-Path: <netdev+bounces-161866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC66A24411
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 21:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107A1167C38
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9901F473E;
	Fri, 31 Jan 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUED2icT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353301F3FCA;
	Fri, 31 Jan 2025 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355352; cv=none; b=q3yuktBSC5qE9lqWpy+hnjKDSLmc4sjr6cuo8GOrjuvISqM5BKOsJeRFJGw9ujaRT5+FPwc0ySlLFLKrEB7Sq4zSdPz0inKIY1pikZCVFANWtNnnvI5oBroLmuPWtYANKs+2OjG/zw1FNhBQWfVDqcujUIXa/YB2BLdxXIaUPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355352; c=relaxed/simple;
	bh=EynNZ3KZB+x2P7pj6u0q7Xg1eZEI3V6d3C0lN8teTY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUxT1+DFIPNSeLfqHTGe2GpNGeuMGI9C5H9PZiIFly4sVzsCBbwEu/9JINgYHPBZo4Fn7OUufgraoGxQ0ondbKEZGAIT8okeQ/Va3MupUOTRyLCP2DsUXG/Msm5JN2fEl+EVHbs1fxdUdp9dKgoTX9JuCJ86dKhtcW/ejkAH8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUED2icT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738355350; x=1769891350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EynNZ3KZB+x2P7pj6u0q7Xg1eZEI3V6d3C0lN8teTY8=;
  b=EUED2icTzJSFa6xTpg5CFOp66TCWM4Tw0uGFcbC8JiGkmYHRD2GRN0jZ
   kpEwebr2hKLWgpG64GO51XPXJtaqOdEBiUB+tdhSu2agELz6dGKpYug0J
   3Q2AG9TQgjNyXquU6YSCV9M7c5Q6NugN085my4NEGgIRIM2rUPBsZeYKy
   tEH9ZR0SAT8jJRAUxJ4wm+eJ9F4A5op1RbrR10QA9hyYf2wvCdnvuFJU2
   8MhM5ZqOxQbfY6J39WDzMvzDP2/xyYl6SYW5fffnkfMc5X5A+75L6hRtt
   mDHg1NdQh5cxm16g++vCe5jL+EOozIWf6Yp1VWxSEjGk7iCt9BUN+NtBC
   A==;
X-CSE-ConnectionGUID: I4OKs7cCTvGbeOXZOPG/+g==
X-CSE-MsgGUID: anNgZnxgTw6DSy6z8mW7DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39036724"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39036724"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 12:29:09 -0800
X-CSE-ConnectionGUID: dNg+jXNfT0ua2Ftjpb+gFA==
X-CSE-MsgGUID: YmZZkXpaRX6Y24oOj3UJnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140607068"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 12:29:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tdxdQ-000n5r-1b;
	Fri, 31 Jan 2025 20:29:04 +0000
Date: Sat, 1 Feb 2025 04:28:13 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Carpenter <error27@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: oe-kbuild-all@lists.linux.dev, Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] xfrm: fix integer overflow in
 xfrm_replay_state_esn_len()
Message-ID: <202502010449.iTcpQDX9-lkp@intel.com>
References: <018ecf13-e371-4b39-8946-c7510baf916b@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018ecf13-e371-4b39-8946-c7510baf916b@stanley.mountain>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Carpenter/xfrm-fix-integer-overflow-in-xfrm_replay_state_esn_len/20250121-191827
base:   net/main
patch link:    https://lore.kernel.org/r/018ecf13-e371-4b39-8946-c7510baf916b%40stanley.mountain
patch subject: [PATCH net] xfrm: fix integer overflow in xfrm_replay_state_esn_len()
config: i386-randconfig-016-20250201 (https://download.01.org/0day-ci/archive/20250201/202502010449.iTcpQDX9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250201/202502010449.iTcpQDX9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502010449.iTcpQDX9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:389,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/net/xfrm.h:7,
                    from net/xfrm/xfrm_replay.c:10:
   In function 'memcmp',
       inlined from 'xfrm_replay_notify_bmp' at net/xfrm/xfrm_replay.c:336:7:
>> include/linux/fortify-string.h:120:33: warning: '__builtin_memcmp_eq' specified bound 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overread]
     120 | #define __underlying_memcmp     __builtin_memcmp
         |                                 ^
   include/linux/fortify-string.h:727:16: note: in expansion of macro '__underlying_memcmp'
     727 |         return __underlying_memcmp(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h: In function 'xfrm_replay_notify_bmp':
   net/xfrm/xfrm_replay.c:308:39: note: source object allocated here
     308 |         struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
         |                                       ^~~~~~~~~~
   In file included from include/linux/string.h:389,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/net/xfrm.h:7,
                    from net/xfrm/xfrm_replay.c:10:
   In function 'memcmp',
       inlined from 'xfrm_replay_notify_esn' at net/xfrm/xfrm_replay.c:402:7:
>> include/linux/fortify-string.h:120:33: warning: '__builtin_memcmp_eq' specified bound 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overread]
     120 | #define __underlying_memcmp     __builtin_memcmp
         |                                 ^
   include/linux/fortify-string.h:727:16: note: in expansion of macro '__underlying_memcmp'
     727 |         return __underlying_memcmp(p, q, size);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h: In function 'xfrm_replay_notify_esn':
   net/xfrm/xfrm_replay.c:360:39: note: source object allocated here
     360 |         struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
         |                                       ^~~~~~~~~~


vim +/__builtin_memcmp_eq +120 include/linux/fortify-string.h

78a498c3a227f2 Alexander Potapenko 2022-10-24  118  
78a498c3a227f2 Alexander Potapenko 2022-10-24  119  #define __underlying_memchr	__builtin_memchr
78a498c3a227f2 Alexander Potapenko 2022-10-24 @120  #define __underlying_memcmp	__builtin_memcmp
a28a6e860c6cf2 Francis Laniel      2021-02-25  121  #define __underlying_strcat	__builtin_strcat
a28a6e860c6cf2 Francis Laniel      2021-02-25  122  #define __underlying_strcpy	__builtin_strcpy
a28a6e860c6cf2 Francis Laniel      2021-02-25  123  #define __underlying_strlen	__builtin_strlen
a28a6e860c6cf2 Francis Laniel      2021-02-25  124  #define __underlying_strncat	__builtin_strncat
a28a6e860c6cf2 Francis Laniel      2021-02-25  125  #define __underlying_strncpy	__builtin_strncpy
2e577732e8d28b Andrey Konovalov    2024-05-17  126  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

