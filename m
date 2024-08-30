Return-Path: <netdev+bounces-123750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBF99666B4
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EBE1F21008
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045011BA863;
	Fri, 30 Aug 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNDhWc51"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22301B5EB7;
	Fri, 30 Aug 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034705; cv=none; b=b8eftrLIgqVBJEVIkQQvNGVKWp8OQs3hGj5naS2bqDWtvj4BYb+K6ursjSPKshHqFUVX52QsBN3N/EcEVUzVFjH8HJ41r8RWDbmgb1SxhgGHuGAOWB24oaDTRTM82QZkpfkBafdnbMUAwm4fEE5JOLtFyxNaL/Kvh8WS7P5e/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034705; c=relaxed/simple;
	bh=BHdDxWxftTd+NhLkgGG1bavh6T1vX+aER+Sv1ZHn7+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ry8OuxjMXMgvcMMmYsKrZgM+MKeFK4TNRT8pzAodAn1SN783Gx/p+/x1RFUyQiFcmICVj4UWndHK0r9aGgmhPBEtd5xqF2sEexxzs//AaVAf1Z2D7JdZUuXNfRIf4UCRRnoFaADy3hPQrgCcXcxRXWdrCWU0SJsCTFICjuxm3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNDhWc51; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725034702; x=1756570702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BHdDxWxftTd+NhLkgGG1bavh6T1vX+aER+Sv1ZHn7+o=;
  b=WNDhWc51ZWymm276jUVZL0RpnJ3Oe+h0uF6Udh6PW+iiFmlJaB7NmU5/
   g33Bchc/pmYOZcrqHgaMC4dTxXQ1K47lC+37g+1QDXPxzRHH/8QHGq2YG
   ylnF9NvjYRhGgoYyIDS4cyTKvcGpnK3TOvtEMvJS4npvMKnLbVpulO2mH
   DX2ZGL4oqbWNklwNnGYUJT4FDUG78htNpFxIzH97NV/lUD7MW1+rHIWHR
   FhwZbUtltXkFHcSn6jWaR7bCpuJi4fGG1InnNbxjtW6QPVdCzneP7yZa+
   evB0geGGRz5uThM5sG4jSckPBHbl+fYQISMhRF84Hfjhpf5sveVsea6gw
   Q==;
X-CSE-ConnectionGUID: Po13A0ypSA+ziW9fxh9cAA==
X-CSE-MsgGUID: zrwKsiIuQWevxTJxmDK2Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23201135"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23201135"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:18:21 -0700
X-CSE-ConnectionGUID: scwKR1YqSBO+WJXI0k+PTQ==
X-CSE-MsgGUID: cCC4RtAKQyWaaqCcWzXWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64134779"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 30 Aug 2024 09:18:17 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk4KF-0001dV-0P;
	Fri, 30 Aug 2024 16:18:15 +0000
Date: Sat, 31 Aug 2024 00:18:10 +0800
From: kernel test robot <lkp@intel.com>
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: napi: Make gro_flush_timeout per-NAPI
Message-ID: <202408310043.fmwHg8BS-lkp@intel.com>
References: <20240829131214.169977-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829131214.169977-4-jdamato@fastly.com>

Hi Joe,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Joe-Damato/net-napi-Make-napi_defer_hard_irqs-per-NAPI/20240829-211617
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240829131214.169977-4-jdamato%40fastly.com
patch subject: [PATCH net-next 3/5] net: napi: Make gro_flush_timeout per-NAPI
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240831/202408310043.fmwHg8BS-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310043.fmwHg8BS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310043.fmwHg8BS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/minmax.h:5,
                    from include/linux/jiffies.h:8,
                    from include/net/pkt_sched.h:5,
                    from drivers/net/ethernet/intel/idpf/idpf.h:12,
                    from drivers/net/ethernet/intel/idpf/idpf_dev.c:4:
   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct idpf_q_vector, __cacheline_group_end__read_write) - offsetofend(struct idpf_q_vector, __cacheline_group_begin__read_write) == (424 + 2 * sizeof(struct dim))"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/libeth/cache.h:17:9: note: in expansion of macro 'static_assert'
      17 |         static_assert(offsetof(type, __cacheline_group_end__##grp) -          \
         |         ^~~~~~~~~~~~~
   include/net/libeth/cache.h:62:9: note: in expansion of macro 'libeth_cacheline_group_assert'
      62 |         libeth_cacheline_group_assert(type, read_write, rw);                  \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/idpf/idpf_txrx.h:475:1: note: in expansion of macro 'libeth_cacheline_set_assert'
     475 | libeth_cacheline_set_assert(struct idpf_q_vector, 104,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct idpf_q_vector) == ((((((104)) + ((__typeof__((104)))(((1 << 6))) - 1)) & ~((__typeof__((104)))(((1 << 6))) - 1)) + ((((424 + 2 * sizeof(struct dim))) + ((__typeof__((424 + 2 * sizeof(struct dim))))(((1 << 6))) - 1)) & ~((__typeof__((424 + 2 * sizeof(struct dim))))(((1 << 6))) - 1)) + ((((8 + sizeof(cpumask_var_t))) + ((__typeof__((8 + sizeof(cpumask_var_t))))(((1 << 6))) - 1)) & ~((__typeof__((8 + sizeof(cpumask_var_t))))(((1 << 6))) - 1))))"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/net/libeth/cache.h:21:9: note: in expansion of macro 'static_assert'
      21 |         static_assert(sizeof(type) == (sz))
         |         ^~~~~~~~~~~~~
   include/net/libeth/cache.h:48:9: note: in expansion of macro '__libeth_cacheline_struct_assert'
      48 |         __libeth_cacheline_struct_assert(type, __libeth_cls(__VA_ARGS__));    \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/libeth/cache.h:64:9: note: in expansion of macro 'libeth_cacheline_struct_assert'
      64 |         libeth_cacheline_struct_assert(type, ro, rw, c)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/idpf/idpf_txrx.h:475:1: note: in expansion of macro 'libeth_cacheline_set_assert'
     475 | libeth_cacheline_set_assert(struct idpf_q_vector, 104,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~


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

