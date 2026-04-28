Return-Path: <netdev+bounces-281661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECfaL71N8GncRQEAu9opvQ
	(envelope-from <netdev+bounces-281661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:03:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C97E47DDB6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33CEA3018B71
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 06:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEE63290AA;
	Tue, 28 Apr 2026 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcR7ZQMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124A2D6E58
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356179; cv=none; b=Sp722iXrzdIHF5Fzolvva8BUveO//jafiwgsp2EV45EgfGnVoF9pFxCcVrNDgVSKWmYPUos34e4khnsAb30cuwSfNZQUeFpZ90NbHMbRzJn1NfgvW2eMI3w7JERDLazWWN4NhT9Q/HE0M5YY/KdhoQyaYmU1l/vcBp+DTxswGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356179; c=relaxed/simple;
	bh=bnBKURh2CCSd96pdSXR1lYVcneWMv6pNHcGvaINt2/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/yTGU4PmPshM3ZlbeaQEkuTFjttE5jcB0wzi4xKFSl7VduB9GOcsdXyTNQNullgtUSXVEhAA73CK7ks41MZmZNDIGEcZ71CkSfGf5syR8i6jXvatffMwKzpoq0XB7Dk2x9tQecQYamim5xcALVio8BEwNBCaGOxrX+LqwPdvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcR7ZQMQ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777356178; x=1808892178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bnBKURh2CCSd96pdSXR1lYVcneWMv6pNHcGvaINt2/c=;
  b=HcR7ZQMQtUDrtpWZOEX5oR+VrH59Z4CEZYwDx/qsmXaRsrx2PChJrVa0
   orTRK2d6NIhz/NKV/kFV5IAcRH5EHY/jnvxV2HfI9pLZeLofNEsDz+R0N
   4PPIYpXFGvAdOf/fczy6CMBeJYH4kmpwxANVY6s6iBAGgPzFUpxaAMlxH
   2e0fLgNyjz21P+sqOSoWABTfIv9ZDoSaSIGoLs4jcOIT6ZsQ9bLJk/3f9
   dz4tPyv66dh9ZigNq62kSCkLv0UMfNDIjySdmCXpTXe9JVN3LeNxSAvP3
   0SMuE7Ow9ItuY6KlWtsxt2syIJ+A6ZujjYj18xAfjKtGYUnbmP/41r3tQ
   w==;
X-CSE-ConnectionGUID: efz66lMpRUKRlivDS0zM7Q==
X-CSE-MsgGUID: eO++QZjiTVCdmZFm5GYq/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78239622"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78239622"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 23:02:58 -0700
X-CSE-ConnectionGUID: f6VeYzKjQya4iCxTFN2vPA==
X-CSE-MsgGUID: yK3emIbdS0yqGhfzZjyQXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="232852885"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2026 23:02:55 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wHbX1-000000004CL-36bR;
	Tue, 28 Apr 2026 06:02:51 +0000
Date: Tue, 28 Apr 2026 08:02:40 +0200
From: kernel test robot <lkp@intel.com>
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
	willemdebruijn.kernel@gmail.com, idosch@nvidia.com,
	justin.iurman@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: Implement limits on extension header parsing
Message-ID: <202604280700.QqKZKu4g-lkp@intel.com>
References: <20260427101318.750730-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427101318.750730-1-daniel@iogearbox.net>
X-Rspamd-Queue-Id: 5C97E47DDB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281661-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Borkmann/ipv6-Implement-limits-on-extension-header-parsing/20260427-194303
base:   net/main
patch link:    https://lore.kernel.org/r/20260427101318.750730-1-daniel%40iogearbox.net
patch subject: [PATCH net v3] ipv6: Implement limits on extension header parsing
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260428/202604280700.QqKZKu4g-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260428/202604280700.QqKZKu4g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604280700.QqKZKu4g-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv6/exthdrs_core.c:77:38: error: no member named 'ipv6' in 'struct net'
      77 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:660:10: note: expanded from macro '__native_word'
     660 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/ipv6/exthdrs_core.c:77:38: error: no member named 'ipv6' in 'struct net'
      77 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:660:39: note: expanded from macro '__native_word'
     660 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/ipv6/exthdrs_core.c:77:38: error: no member named 'ipv6' in 'struct net'
      77 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:661:10: note: expanded from macro '__native_word'
     661 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/ipv6/exthdrs_core.c:77:38: error: no member named 'ipv6' in 'struct net'
      77 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:661:38: note: expanded from macro '__native_word'
     661 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/ipv6/exthdrs_core.c:77:38: error: no member named 'ipv6' in 'struct net'
      77 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:48: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                                       ^
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> net/ipv6/exthdrs_core.c:77:38: error: no member named 'ipv6' in 'struct net'
      77 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:635:53: note: expanded from macro '__unqual_scalar_typeof'
     635 | #define __unqual_scalar_typeof(x) __typeof_unqual__(x)
         |                                                     ^
>> net/ipv6/exthdrs_core.c:77:38: error: no member named 'ipv6' in 'struct net'
      77 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   net/ipv6/exthdrs_core.c:197:38: error: no member named 'ipv6' in 'struct net'
     197 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:660:10: note: expanded from macro '__native_word'
     660 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   net/ipv6/exthdrs_core.c:197:38: error: no member named 'ipv6' in 'struct net'
     197 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:660:39: note: expanded from macro '__native_word'
     660 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   net/ipv6/exthdrs_core.c:197:38: error: no member named 'ipv6' in 'struct net'
     197 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:661:10: note: expanded from macro '__native_word'
     661 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   net/ipv6/exthdrs_core.c:197:38: error: no member named 'ipv6' in 'struct net'
     197 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:661:38: note: expanded from macro '__native_word'
     661 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   include/linux/compiler_types.h:699:22: note: expanded from macro 'compiletime_assert'
     699 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:687:23: note: expanded from macro '_compiletime_assert'
     687 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:679:9: note: expanded from macro '__compiletime_assert'
     679 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   net/ipv6/exthdrs_core.c:197:38: error: no member named 'ipv6' in 'struct net'
     197 |         int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
         |                                    ~~~~~~~~ ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:48: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \


vim +77 net/ipv6/exthdrs_core.c

    28	
    29	/*
    30	 * Skip any extension headers. This is used by the ICMP module.
    31	 *
    32	 * Note that strictly speaking this conflicts with RFC 2460 4.0:
    33	 * ...The contents and semantics of each extension header determine whether
    34	 * or not to proceed to the next header.  Therefore, extension headers must
    35	 * be processed strictly in the order they appear in the packet; a
    36	 * receiver must not, for example, scan through a packet looking for a
    37	 * particular kind of extension header and process that header prior to
    38	 * processing all preceding ones.
    39	 *
    40	 * We do exactly this. This is a protocol bug. We can't decide after a
    41	 * seeing an unknown discard-with-error flavour TLV option if it's a
    42	 * ICMP error message or not (errors should never be send in reply to
    43	 * ICMP error messages).
    44	 *
    45	 * But I see no other way to do this. This might need to be reexamined
    46	 * when Linux implements ESP (and maybe AUTH) headers.
    47	 * --AK
    48	 *
    49	 * This function parses (probably truncated) exthdr set "hdr".
    50	 * "nexthdrp" initially points to some place,
    51	 * where type of the first header can be found.
    52	 *
    53	 * It skips all well-known exthdrs, and returns pointer to the start
    54	 * of unparsable area i.e. the first header with unknown type.
    55	 * If it is not NULL *nexthdr is updated by type/protocol of this header.
    56	 *
    57	 * NOTES: - if packet terminated with NEXTHDR_NONE it returns NULL.
    58	 *        - it may return pointer pointing beyond end of packet,
    59	 *	    if the last recognized header is truncated in the middle.
    60	 *        - if packet is truncated, so that all parsed headers are skipped,
    61	 *	    it returns NULL.
    62	 *	  - First fragment header is skipped, not-first ones
    63	 *	    are considered as unparsable.
    64	 *	  - Reports the offset field of the final fragment header so it is
    65	 *	    possible to tell whether this is a first fragment, later fragment,
    66	 *	    or not fragmented.
    67	 *	  - ESP is unparsable for now and considered like
    68	 *	    normal payload protocol.
    69	 *	  - Note also special handling of AUTH header. Thanks to IPsec wizards.
    70	 *
    71	 * --ANK (980726)
    72	 */
    73	
    74	int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
    75			     __be16 *frag_offp)
    76	{
  > 77		int exthdr_max = READ_ONCE(init_net.ipv6.sysctl.max_ext_hdrs_cnt);
    78		u8 nexthdr = *nexthdrp;
    79		int exthdr_cnt = 0;
    80	
    81		*frag_offp = 0;
    82	
    83		while (ipv6_ext_hdr(nexthdr)) {
    84			struct ipv6_opt_hdr _hdr, *hp;
    85			int hdrlen;
    86	
    87			if (nexthdr == NEXTHDR_NONE)
    88				return -1;
    89			if (unlikely(exthdr_cnt++ >= exthdr_max))
    90				return -1;
    91			hp = skb_header_pointer(skb, start, sizeof(_hdr), &_hdr);
    92			if (!hp)
    93				return -1;
    94			if (nexthdr == NEXTHDR_FRAGMENT) {
    95				__be16 _frag_off, *fp;
    96				fp = skb_header_pointer(skb,
    97							start+offsetof(struct frag_hdr,
    98								       frag_off),
    99							sizeof(_frag_off),
   100							&_frag_off);
   101				if (!fp)
   102					return -1;
   103	
   104				*frag_offp = *fp;
   105				if (ntohs(*frag_offp) & ~0x7)
   106					break;
   107				hdrlen = 8;
   108			} else if (nexthdr == NEXTHDR_AUTH)
   109				hdrlen = ipv6_authlen(hp);
   110			else
   111				hdrlen = ipv6_optlen(hp);
   112	
   113			nexthdr = hp->nexthdr;
   114			start += hdrlen;
   115		}
   116	
   117		*nexthdrp = nexthdr;
   118		return start;
   119	}
   120	EXPORT_SYMBOL(ipv6_skip_exthdr);
   121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

