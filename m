Return-Path: <netdev+bounces-214042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC42FB27F30
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16F3621788
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B028725E;
	Fri, 15 Aug 2025 11:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APAZaaJ5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E00283130;
	Fri, 15 Aug 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257549; cv=none; b=n8NPl551thMZVjucVBu6R14RnFHPbL3l3isIWCKk4j04FYRR9HuMt+8VVJdTHsQAZOodXrPWYhpw6Ga6umrituIRrNrGetXQzuTRNqXdYOyFnRePBSXyzNtMSmuCtvEphRWgcu/UnDEmMojOmTCMjR/RqEdAP/PGSJ5eeZbKe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257549; c=relaxed/simple;
	bh=2h1fMYeROE4yIGF+CgZnPkm/+lHpvohrDgo1Bzz9TFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5+BX8TAwNMnQbcR8bADa8niY9ZNsoNgHUq74WNpLDq/vmNU/YikeiwRUFQX3APE4OMnJhtu02EOwkijYJIgf2Vp39FtQ4jWcRGZc1eV5b6RoyWzCrK7w/dcsDTo+PzT8J3Tv2zXeMrG/i1TxTzUI9bOVcEzL0/6bZsML/Yzg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APAZaaJ5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755257547; x=1786793547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2h1fMYeROE4yIGF+CgZnPkm/+lHpvohrDgo1Bzz9TFk=;
  b=APAZaaJ54WL/7bnb1qKWPOyrS30rC+jRveFvtjo79aNd8VrhuXrqMcFw
   z25NMmjhThoSb5QkNNYvHe9MoDvv2jAI4zLLEVIqKjeyjq0K+Ir6deY2g
   8idOwb1pgr6eashRxmOTH9vpu+X1F6YxdFAhMPuCBvl7YtSrMQYYctQYm
   rusV1gi4Jy1cgRVyaAvBXiIhXbU/UzyUcX1KqH4QQn0OQQwOPxyJJszaC
   dn/Fgieno9lNdEfUxcMIW7/CANCnfJceBbkWiaaI1UPv2hp9zNc/CkaBX
   2rPDUj/8l2KMwZkPUjGVN3Ohbcz943QmVAfJ6kMsfoausaXD3yNbblJVn
   w==;
X-CSE-ConnectionGUID: aGDD8SLMSeevbnCxzywxMw==
X-CSE-MsgGUID: 14UdNFFjSXKKKyAG1dtxCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61211987"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61211987"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 04:32:27 -0700
X-CSE-ConnectionGUID: pufAPPvqSiyqv3iaBbtgAg==
X-CSE-MsgGUID: ZdipE9jNR6KpldVQlQvDdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="197990603"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2025 04:32:24 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umsfU-000Buu-2l;
	Fri, 15 Aug 2025 11:32:20 +0000
Date: Fri, 15 Aug 2025 19:31:37 +0800
From: kernel test robot <lkp@intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Peter Seiderer <ps.report@gmx.net>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: pktgen: Use min() to simplify
 pktgen_finalize_skb()
Message-ID: <202508151939.AA9PxPv1-lkp@intel.com>
References: <20250814172242.231633-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814172242.231633-2-thorsten.blum@linux.dev>

Hi Thorsten,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Thorsten-Blum/net-pktgen-Use-min-to-simplify-pktgen_finalize_skb/20250815-012951
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250814172242.231633-2-thorsten.blum%40linux.dev
patch subject: [PATCH net-next] net: pktgen: Use min() to simplify pktgen_finalize_skb()
config: arc-randconfig-002-20250815 (https://download.01.org/0day-ci/archive/20250815/202508151939.AA9PxPv1-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151939.AA9PxPv1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151939.AA9PxPv1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   net/core/pktgen.c: In function 'pktgen_finalize_skb':
>> include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_853' declared with attribute error: min(datalen / frags, ((1UL) << 12)) signedness error
     572 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                      ^
   include/linux/compiler_types.h:553:4: note: in definition of macro '__compiletime_assert'
     553 |    prefix ## suffix();    \
         |    ^~~~~~
   include/linux/compiler_types.h:572:2: note: in expansion of macro '_compiletime_assert'
     572 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:93:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      93 |  BUILD_BUG_ON_MSG(!__types_ok(ux, uy),  \
         |  ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:98:2: note: in expansion of macro '__careful_cmp_once'
      98 |  __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |  ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:19: note: in expansion of macro '__careful_cmp'
     105 | #define min(x, y) __careful_cmp(min, x, y)
         |                   ^~~~~~~~~~~~~
   net/core/pktgen.c:2845:14: note: in expansion of macro 'min'
    2845 |   frag_len = min(datalen / frags, PAGE_SIZE);
         |              ^~~


vim +/__compiletime_assert_853 +572 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  558  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  559  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  560  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  561  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  562  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  563   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  564   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  565   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  566   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  567   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  568   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  569   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  570   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  571  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @572  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  573  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

