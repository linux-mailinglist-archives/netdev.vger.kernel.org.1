Return-Path: <netdev+bounces-165255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96851A31486
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422DF7A145D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76951F940A;
	Tue, 11 Feb 2025 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VU2zCh3A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB01E3DDB
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739300457; cv=none; b=qJKjfJqevANjtZqd6HWMAw0NK12UuMmJ5iKZ3MDKwf+hYXv29PLtrM28vlYF/RGkDNDF+c5Pv1UvxuIU80vC1Ty4JQMsqs3TW2qprlFiOsr6pWk/TTzdwSCmud8xHxkaXvbjsPkszQXM/ZnyBarZ36yIUmXP1ph6WfI3kDeFH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739300457; c=relaxed/simple;
	bh=Jyf0yoFhMemZFUYtX1qgIax7oxWiciLNVAx6C3sSiKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Phc6AfqwMv6XO0x4df2/zT+1lYu3ZDDQuho+G01io8WI8eZz5888PsOVoTwMhvwuy871kfiUb5D5Xx+RMoZBDrMYwQEPArUk0aKtaCXO6eB2g8Fc7r0sl1x4F6YAS2o40YXeusSz3pE/BikIxtq3QhSrGyR7zG8X9SzoGEpg0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VU2zCh3A; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739300454; x=1770836454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jyf0yoFhMemZFUYtX1qgIax7oxWiciLNVAx6C3sSiKU=;
  b=VU2zCh3AR+DPfNl7ApDP1kzdzo+hTDH7kVY0pg6LIKXXwcEbLI2uLlUP
   U2XHc3Z86xSlgVuTbOs5xBTYdDnSAvE4mdd604wynly7hXH3YmQdCnn0a
   mN7ZWRczAtbNPCr/JodStuR/W5igqauGAX/H2ijGwRJLjyDXub8bo+AQG
   qu/x+jASSrwcK+DxIJ3G4QGzVMt6hdLUB2o3StV1FGeV4h+VDJhlLO3y6
   zJWUCJIZx67feYfv4k5tW5zW85Lf5VY1GCabc2GBFY8kRdvpkyb38wWHq
   2hl+yOfwIk9rQQQSNCRoCmF2KzB7ixI7TPf++tSaGM5vT6+hRkrh7xHDK
   Q==;
X-CSE-ConnectionGUID: JCtQ0sZWSZu64xQHk4QH9w==
X-CSE-MsgGUID: VLHaIiLtREi0eNqbR0eSsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43591214"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="43591214"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:00:52 -0800
X-CSE-ConnectionGUID: 24veieCiSTSZSyJlND5/wg==
X-CSE-MsgGUID: z+AmJLRlRzCQSFERkR6svA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="117673937"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 11:00:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thvV1-0014ad-1j;
	Tue, 11 Feb 2025 19:00:47 +0000
Date: Wed, 12 Feb 2025 03:00:37 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Yael Chemla <ychemla@nvidia.com>
Subject: Re: [PATCH v3 net 1/2] net: Fix dev_net(dev) race in
 unregister_netdevice_notifier_dev_net().
Message-ID: <202502120246.vNfiNOn3-lkp@intel.com>
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
config: sparc64-randconfig-001-20250212 (https://download.01.org/0day-ci/archive/20250212/202502120246.vNfiNOn3-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120246.vNfiNOn3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502120246.vNfiNOn3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/instrumented.h:10,
                    from include/linux/uaccess.h:6,
                    from net/core/dev.c:71:
   net/core/dev.c: In function 'rtnl_net_dev_lock':
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:57:69: note: in expansion of macro '__trace_if_value'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/asm-generic/rwonce.h:44:43: note: in expansion of macro '__unqual_scalar_typeof'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
>> net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:61: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:61: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:61: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:531:50: note: in expansion of macro 'READ_ONCE'
     531 |         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
         |                                                  ^~~~~~~~~
   include/linux/rcupdate.h:650:31: note: in expansion of macro '__rcu_access_pointer'
     650 | #define rcu_access_pointer(p) __rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu)
         |                               ^~~~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:26: note: in expansion of macro 'rcu_access_pointer'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                          ^~~~~~~~~~~~~~~~~~
   net/core/dev.c:2087:56: error: 'possible_net_t' has no member named 'net'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |                                                        ^
   include/linux/compiler.h:57:61: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/core/dev.c:2087:9: note: in expansion of macro 'if'
    2087 |         if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
         |         ^~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   include/linux/compiler_types.h:522:17: note: in expansion of macro 'if'
     522 |                 if (!(condition))                                       \
         |                 ^~
   include/linux/compiler_types.h:530:9: note: in expansion of macro '__compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)


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
  2089			net_drop_ns(net);
  2090			goto again;
  2091		}
  2092	}
  2093	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

