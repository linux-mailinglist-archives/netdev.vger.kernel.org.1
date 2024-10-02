Return-Path: <netdev+bounces-131331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5390998E199
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C1FB21AF1
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E011D151E;
	Wed,  2 Oct 2024 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAc0+ZsI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B551D1510
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890111; cv=none; b=X+Axb2nl3iEi9ThnHEE4t5tgc09rzjqQ3oB6VBnIwCTWKnyvgGdnwfINjUZpLL9s6FgfypbMQK3Fh5RCKLRPsN5YDku+Q3qUBNNWzews2pseIwl1zthMR3RZkTVU2PHsb4XWE43L1R87LK9JHuPU2NclQ+65KrJE/64KysVT/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890111; c=relaxed/simple;
	bh=c8N7kexXebvoRSJx8SCEcTgwgVy4fd+hnsW2NJLjE4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCRDJfOIR9+6OStkcdAh9x0eLaEEa45bbYrHcR+hHTlijY0mrDbXzQLVxIha1im40xAje01Ag6lURa3ek+mstHlJSSegGUuQBMTUYBz+5g9BmSm4IOjovsTrIL9EFp7w8czt8iFxEBIWy24kPEhEU6S5d7dGqLrMLdHXybk/RYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAc0+ZsI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727890108; x=1759426108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c8N7kexXebvoRSJx8SCEcTgwgVy4fd+hnsW2NJLjE4E=;
  b=WAc0+ZsI0+mAIlmjvUo0bRtT2VJmD5no+bgD+mleboKsrYbwNyIha74c
   60OYmyOlIC1DoMiTjxe1v07v3dwaNRknyNKZdjMhR6KEyieOH0ZuX9FUN
   8XYGe/O4loXQc5G9cWVtcJI5AnbbMRvCO9bjAHk4aVZ3gkUVlt4wknaci
   kIISnnUD8k3ACABQCbPnRziuUwMY/SnJmvE40ljKz4O6H6zl+/tS8ZItE
   XwkX/ziP73vorqU4XRZK1O37JdPtrIfngN3NJz1FJDTwLkDujf1ShBcyC
   Ysp0JB9ElYo3pW9VeSWxW2SpRkxmulTVcT5HT1gLTUs+fl9uLHqzNbxwZ
   A==;
X-CSE-ConnectionGUID: XRSsoajtReGNxOWxkz3dWQ==
X-CSE-MsgGUID: G1DjHaLNQuON4x3chcYElw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="49589481"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="49589481"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 10:28:28 -0700
X-CSE-ConnectionGUID: wmtljO9YTim0mjN/4MBEpQ==
X-CSE-MsgGUID: gVpOJz2xQw6OVNmova+NYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78822568"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Oct 2024 10:28:26 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sw39E-000UJV-09;
	Wed, 02 Oct 2024 17:28:24 +0000
Date: Thu, 3 Oct 2024 01:28:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 1/3] rtnetlink: Add per-net RTNL.
Message-ID: <202410030120.kCWC9qb0-lkp@intel.com>
References: <20240930202524.59357-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930202524.59357-2-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/rtnetlink-Add-per-net-RTNL/20241001-043219
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240930202524.59357-2-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 1/3] rtnetlink: Add per-net RTNL.
config: hexagon-randconfig-r132-20241002 (https://download.01.org/0day-ci/archive/20241003/202410030120.kCWC9qb0-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce: (https://download.01.org/0day-ci/archive/20241003/202410030120.kCWC9qb0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410030120.kCWC9qb0-lkp@intel.com/

All errors (new ones prefixed by >>):

   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:7:
   In file included from include/linux/rhashtable-types.h:15:
   In file included from include/linux/mutex.h:17:
>> include/linux/lockdep.h:413:52: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   413 | void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
   |                                                    ^
   |                                                    int
   include/linux/lockdep.h:413:65: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   413 | void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
   |                                                                 ^
   |                                                                 int
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
   98 |                 return (set->sig[3] | set->sig[2] |
   |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
   62 |         unsigned long sig[_NSIG_WORDS];
   |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
   98 |                 return (set->sig[3] | set->sig[2] |
   |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
   62 |         unsigned long sig[_NSIG_WORDS];
   |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
   114 |                 return  (set1->sig[3] == set2->sig[3]) &&
   |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
   62 |         unsigned long sig[_NSIG_WORDS];
   |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
   114 |                 return  (set1->sig[3] == set2->sig[3]) &&
   |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
   62 |         unsigned long sig[_NSIG_WORDS];
   |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
   115 |                         (set1->sig[2] == set2->sig[2]) &&
   |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
   62 |         unsigned long sig[_NSIG_WORDS];
   |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
   115 |                         (set1->sig[2] == set2->sig[2]) &&
   |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
   62 |         unsigned long sig[_NSIG_WORDS];
   |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
   157 | _SIG_SET_BINOP(sigorsets, _sig_or)
   | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:8: note: expanded from macro '_SIG_SET_BINOP'
   138 |                 a3 = a->sig[3]; a2 = a->sig[2];                               |                      ^      ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
   62 |         unsigned long sig[_NSIG_WORDS];
   |         ^
   In file included from arch/hexagon/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PROVE_LOCKING
   Depends on [n]: DEBUG_KERNEL [=n] && LOCK_DEBUGGING_SUPPORT [=y]
   Selected by [y]:
   - DEBUG_NET_SMALL_RTNL [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/int +413 include/linux/lockdep.h

fbb9ce9530fd9b Ingo Molnar     2006-07-03  411  
eb1cfd09f788e3 Kent Overstreet 2023-05-09  412  #ifdef CONFIG_PROVE_LOCKING
eb1cfd09f788e3 Kent Overstreet 2023-05-09 @413  void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
eb1cfd09f788e3 Kent Overstreet 2023-05-09  414  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

