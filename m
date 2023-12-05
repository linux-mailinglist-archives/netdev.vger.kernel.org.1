Return-Path: <netdev+bounces-54064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E461805E69
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F27B21031
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400F6D1A9;
	Tue,  5 Dec 2023 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcCCdWoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE2FB0
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 11:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701803555; x=1733339555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zkCkmjo/6gO+psYAjT3o4rmRiAce786m0PTs4ArlFcM=;
  b=QcCCdWoJ4DoP7eXHqLipNrf4G8bDk0i9r2CbyNp8+Y8L7XXgjX7wJ8H9
   pW3aPmxWxqjAbUqY86Mwz7tdQS5v3wwAcYAEjWQ2Mw3mjCVgtNzc8HZ23
   7AG1yoAeTnkl/rDFungj4CkIw9MAtqEwqgpWnaBIlvQHsoUY4ALJGOenm
   C+uPOH9m4LCJWibXGHXU3gCL0hIq2f9ifo0SHRrsT99lUtrya0Dc230zf
   T3ftyzQrtKcItxD4PmW2s9dxre/P7dNmCQ4X8ToxgFseOrh+ticQ8nidy
   3t7b9N1YpYzqk6BlWREDcCfSmS8/32PNBrWthsZNYMD6FPMBpw10bRtKa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12662571"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="12662571"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 11:12:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="889043566"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="889043566"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2023 11:12:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAaqJ-0009bC-1A;
	Tue, 05 Dec 2023 19:12:28 +0000
Date: Wed, 6 Dec 2023 03:12:01 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shirley Ma <mashirle@us.ibm.com>, David Ahern <dsahern@kernel.org>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net] net: ipv6: support reporting otherwise unknown
 prefix flags in RTM_NEWPREFIX
Message-ID: <202312060307.EaL1FRwu-lkp@intel.com>
References: <20231204195252.2004515-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204195252.2004515-1-maze@google.com>

Hi Maciej,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-enczykowski/net-ipv6-support-reporting-otherwise-unknown-prefix-flags-in-RTM_NEWPREFIX/20231205-035333
base:   net/main
patch link:    https://lore.kernel.org/r/20231204195252.2004515-1-maze%40google.com
patch subject: [PATCH net] net: ipv6: support reporting otherwise unknown prefix flags in RTM_NEWPREFIX
config: arm-rpc_defconfig (https://download.01.org/0day-ci/archive/20231206/202312060307.EaL1FRwu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060307.EaL1FRwu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060307.EaL1FRwu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from fs/lockd/svc.c:16:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct prefix_info) == 32"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/addrconf.h:58:1: note: in expansion of macro 'static_assert'
      58 | static_assert(sizeof(struct prefix_info) == 32);
         | ^~~~~~~~~~~~~
--
   In file included from lib/vsprintf.c:21:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct prefix_info) == 32"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/addrconf.h:58:1: note: in expansion of macro 'static_assert'
      58 | static_assert(sizeof(struct prefix_info) == 32);
         | ^~~~~~~~~~~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1683 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from net/ipv4/route.c:63:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct prefix_info) == 32"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/addrconf.h:58:1: note: in expansion of macro 'static_assert'
      58 | static_assert(sizeof(struct prefix_info) == 32);
         | ^~~~~~~~~~~~~
   net/ipv4/route.c: In function 'ip_rt_send_redirect':
   net/ipv4/route.c:880:13: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
     880 |         int log_martians;
         |             ^~~~~~~~~~~~
--
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/workqueue.h:9,
                    from include/linux/bpf.h:10,
                    from net/ipv6/ip6_fib.c:18:
>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct prefix_info) == 32"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/addrconf.h:58:1: note: in expansion of macro 'static_assert'
      58 | static_assert(sizeof(struct prefix_info) == 32);
         | ^~~~~~~~~~~~~
   net/ipv6/ip6_fib.c: In function 'fib6_add':
   net/ipv6/ip6_fib.c:1384:32: warning: variable 'pn' set but not used [-Wunused-but-set-variable]
    1384 |         struct fib6_node *fn, *pn = NULL;
         |                                ^~


vim +78 include/linux/build_bug.h

bc6245e5efd70c Ian Abbott       2017-07-10  60  
6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check integer constant expression at build time
6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a wrapper for the C11 _Static_assert, with a
6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to make the message optional (defaulting to the
6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the tested expression).
6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires the expression to be an integer constant
6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it is not enough that __builtin_constant_p() is
6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_BUG_ON() fails the build if the condition is
6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_assert() fails the build if the expression is
6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
6bab69c65013be Rasmus Villemoes 2019-03-07  79  
07a368b3f55a79 Maxim Levitsky   2022-10-25  80  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

