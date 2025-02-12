Return-Path: <netdev+bounces-165324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D64A31A4E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF191883AAD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731127180D;
	Wed, 12 Feb 2025 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edaeb4Q0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99530156CA
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319448; cv=none; b=TNyowFa2USyUPPPK+uPFtiv+gO6ya2GjxiOYGvRL2ZCbXCYH0PxbuSl0EEq02kOUIAjDQttzwPkZU8Nt2t1AU2Fyem+a58a0NT9wu92OnDlhTNOgke1ha9YtivxPRuvoqJSJck4s/Avp9fDfMc6dmG7jNY6pcGjqY7jMJaNYYUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319448; c=relaxed/simple;
	bh=+sQk7LLDeTVogvnQZtwP/Ug9OrxfaSM61JxX4BvQoLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shlVZq8jACcPT7i+ETiCb30TqbA2Daxq7f/apS53t+Dj/zGJMI5Cy6TjSIdoE5SWxLOygLJUrKXLQ+dILaHELa6MKP1DRC3OQSnjFr62vUqq7zAhTABQNH5/yNPfIPoTQIwXdkEiLoWZBoZmy5U5ns6HotQDk00iDI3z/iEwSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edaeb4Q0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739319447; x=1770855447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+sQk7LLDeTVogvnQZtwP/Ug9OrxfaSM61JxX4BvQoLU=;
  b=edaeb4Q0oWnFi8enGCRRmX0yxNQ0YbYiguwLWrSAFyyu8J4k+txEdV7y
   m7+Jszn6kCjYhLPIAJaHmBSV3bQk0ZMKwon0EuLzMda1L8n397x9GNT4e
   MSyNMIea8hNaeDmaTYpkwDz3IsVQMfhr8/jZuQQTwucCSznm2LGlVPNWO
   RN1MAtd7RjpDaUEjki15pcjE+jgcvor/kbWFXCYbMswujCoz46lGEKsbE
   HaSiydpU/wVn5gpmj6cqXq57ff70oJAldbjlj8O0MzU45S9QtHWjNrmGd
   GXqHw6Ry0Z6/EtiP3mk6degyPKpF6j4+CqT4HOiUY5/a4npytOK6lcLPI
   w==;
X-CSE-ConnectionGUID: XauaZ9LbQe2m0SeqNP8bmg==
X-CSE-MsgGUID: K4pHERImS+SLi0ZU7hvclA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57495852"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="57495852"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:17:26 -0800
X-CSE-ConnectionGUID: 8n8wMHpDS9i3wtZsKRVugQ==
X-CSE-MsgGUID: 3C2ggCtZSv2hbek/1hOE3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112488938"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Feb 2025 16:17:23 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti0RN-0014rz-18;
	Wed, 12 Feb 2025 00:17:21 +0000
Date: Wed, 12 Feb 2025 08:16:27 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Yael Chemla <ychemla@nvidia.com>
Subject: Re: [PATCH v3 net 1/2] net: Fix dev_net(dev) race in
 unregister_netdevice_notifier_dev_net().
Message-ID: <202502120733.xsF3H4iE-lkp@intel.com>
References: <20250211051217.12613-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211051217.12613-2-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/net-Fix-dev_net-dev-race-in-unregister_netdevice_notifier_dev_net/20250211-131633
base:   net/main
patch link:    https://lore.kernel.org/r/20250211051217.12613-2-kuniyu%40amazon.com
patch subject: [PATCH v3 net 1/2] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
config: s390-randconfig-002-20250212 (https://download.01.org/0day-ci/archive/20250212/202502120733.xsF3H4iE-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120733.xsF3H4iE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502120733.xsF3H4iE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:10: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                 ^
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:31: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                      ^
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:53: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:53: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:53: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:53: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:53: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:542:22: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:530:23: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:522:9: note: expanded from macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:53: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:498:13: note: expanded from macro '__unqual_scalar_typeof'
     498 |                 _Generic((x),                                           \
         |                           ^
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:53: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:505:15: note: expanded from macro '__unqual_scalar_typeof'
     505 |                          default: (x)))
         |                                    ^
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:531:53: note: expanded from macro '__rcu_access_pointer'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                            ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
>> net/core/dev.c:2087:50: error: no member named 'net' in 'possible_net_t'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                             ~~~~~~~~~~~ ^
   include/linux/rcupdate.h:650:53: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                                                     ^
   include/linux/rcupdate.h:533:12: note: expanded from macro '__rcu_access_pointer'
     533 |         ((typeof(*p) __force __kernel *)(local)); \
         |                   ^
>> net/core/dev.c:2087:19: error: passing 'void' to parameter of incompatible type 'const struct net *'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:650:31: note: expanded from macro 'rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:529:47: note: expanded from macro '__rcu_access_pointer'
     529 | #define __rcu_access_pointer(p, local, space) \
         |                                               ^
     530 | ({ \
         | ~~~~
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     532 |         rcu_check_sparse(p, space); \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     533 |         ((typeof(*p) __force __kernel *)(local)); \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     534 | })
         | ~~
   include/net/net_namespace.h:318:54: note: passing argument to parameter 'net2' here
     318 | int net_eq(const struct net *net1, const struct net *net2)
         |                                                      ^
>> net/core/dev.c:2089:14: error: called object type 'void *' is not a function or function pointer
    2089 |                 net_drop_ns(net);
         |                 ~~~~~~~~~~~^
   net/core/dev.c:2099:13: error: called object type 'void *' is not a function or function pointer
    2099 |         net_drop_ns(net);
         |         ~~~~~~~~~~~^
   14 errors generated.


vim +2087 net/core/dev.c

  2072	
  2073	static void rtnl_net_dev_lock(struct net_device *dev)
  2074	{
  2075		struct net *net;
  2076	
  2077	again:
  2078		/* netns might be being dismantled. */
  2079		rcu_read_lock();
  2080		net = dev_net_rcu(dev);
  2081		refcount_inc(&net->passive);
  2082		rcu_read_unlock();
  2083	
  2084		rtnl_net_lock(net);
  2085	
  2086		/* dev might have been moved to another netns. */
> 2087		if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
  2088			rtnl_net_unlock(net);
> 2089			net_drop_ns(net);
  2090			goto again;
  2091		}
  2092	}
  2093	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

