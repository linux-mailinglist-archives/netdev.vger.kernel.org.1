Return-Path: <netdev+bounces-204222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07969AF99B1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712DD1CC02E9
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73E08F5B;
	Fri,  4 Jul 2025 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxO4fyXF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397C2E36FF
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650285; cv=none; b=fWGIr+H9cnRbqDmgScllR0kWLtOjupNuN47L142i5VAYaOfQYDABYsUvjQAdu8eyIvRbx+bgvEJ5VDEJVqHKq6ekUh7aQinRV8NkEXP5OE0yaIPLZ4pj/Sq0TRts/d9mrYEbYDqvQpB0i+Q+uBp7+B/snP6ceg3WMYeiOnDTD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650285; c=relaxed/simple;
	bh=NKk6c78uRA66DoTs6cF0whB+T2dVkZSNDvCh77x5Nmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjR2d+tVxT7Lt9eJYj1aEby5l7WEf6q/CSO5ayb52tPwueobwPNGrhd3QVhEFkz/lXXAY61VINBG0mgX62C2PL14Q7KBLb+mL2daPuPtxp7JWKSReuK5rhU9HSFaqSkS7V7q1OXhq/Yw5dbnBZrjy5Knkdy81GxiwMiUsZOB3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxO4fyXF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751650285; x=1783186285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NKk6c78uRA66DoTs6cF0whB+T2dVkZSNDvCh77x5Nmc=;
  b=JxO4fyXFb4iUk50+Um1HJ51ji/nvupUzFjK5whD4zBunDvJt1LhGtLDU
   auBwgM4gJMw0SlEsJKds/uNVg0Jo52L28bXWCJlpKVwi0yDw5nUR9kI9e
   u20MMHdXgugnpYcFpuJpLwQeoXi4DoSxzlZhtwFK64neQdLychK/l/J0I
   RnDiDgxni6c1PyMDvmeB9839LgerDtjEVr0FRceVBj0N/omV3n3RE2c6L
   RwJbqFlXrqVgtxcbdh1N1L6E4hNijM4WQwV6S7HQtrMy9vaPgN6j1rh98
   MB+spY76A1Wve+lBBaNtAL3zAdh3UEkiGjmQhPCCOPx78oBn4IppQkKFu
   A==;
X-CSE-ConnectionGUID: fXYwiRHgSqG8s5Yaeba2Qg==
X-CSE-MsgGUID: h82YCX/HQb+hqIMkiMVgzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="54105569"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="54105569"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 10:31:24 -0700
X-CSE-ConnectionGUID: oBCictNeSAu6oJTnwKE4jg==
X-CSE-MsgGUID: 9dA7UOUMTSacf8WZ2vnfWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="154327853"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jul 2025 10:31:22 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXkFr-0003x1-1u;
	Fri, 04 Jul 2025 17:31:19 +0000
Date: Sat, 5 Jul 2025 01:30:24 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v10 15/15] net: homa: create Makefile and Kconfig
Message-ID: <202507050104.p9sjOlBX-lkp@intel.com>
References: <20250703031445.569-16-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703031445.569-16-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20250703-113049
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250703031445.569-16-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v10 15/15] net: homa: create Makefile and Kconfig
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20250705/202507050104.p9sjOlBX-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507050104.p9sjOlBX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507050104.p9sjOlBX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   net/homa/homa_plumbing.c: In function 'homa_load':
>> include/linux/compiler_types.h:568:45: error: call to '__compiletime_assert_981' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct homa_recvmsg_args) != 88
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:549:25: note: in definition of macro '__compiletime_assert'
     549 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:568:9: note: in expansion of macro '_compiletime_assert'
     568 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   net/homa/homa_plumbing.c:216:9: note: in expansion of macro 'BUILD_BUG_ON'
     216 |         BUILD_BUG_ON(sizeof(struct homa_recvmsg_args) != 88);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_981 +568 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  554  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  555  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  556  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  557  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  558  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  559   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  560   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  561   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  562   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  563   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  564   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  565   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  566   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  567  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @568  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  569  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

