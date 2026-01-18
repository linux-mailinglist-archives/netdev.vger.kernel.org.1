Return-Path: <netdev+bounces-250917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE4D39929
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 19:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3C1130021CA
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063852FF15B;
	Sun, 18 Jan 2026 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nINGoDhx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C771D5174;
	Sun, 18 Jan 2026 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768761430; cv=none; b=mO2EEL5NZNsm8ssLLfG/C4+OoFwhDrRKAZvKVkmfVNnej+5QZOU702oMWMVcsknYlYmUOGPrdpxLQns1F+aSYy99rQQJA8Q7OBmxxc7PpCzj/r+B3m8i7LHaFcLh1Vwr7UcKVkhu6fqa9I8J6SnNEwgZ/f9y8wgUDQz7g3uNLok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768761430; c=relaxed/simple;
	bh=8O/5joRe3cFbEUfBDmw9o/JAu/DiyxFA8DnJE5KGfag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFEhBFcudTnoSxEYkOYkiE6YuvoDiI5WnjhVMajTuWHCwkV2FI1R0SmO7Y3AnGx88zJUaUwZUKCSht3fl6GR908dbaAjgQIqnyuSKg9ecvYGClMUvVtUYDCtynBfhGvdoSMlKstI0daLT7s1YIyTkhQSsuy8andJpvOkkHYpxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nINGoDhx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768761428; x=1800297428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8O/5joRe3cFbEUfBDmw9o/JAu/DiyxFA8DnJE5KGfag=;
  b=nINGoDhx0n5E4XQQSKMLK3nOvqsDvkBD2OYb4RfJLUH7xW31vr7EtH/b
   Yrue+THY3/ou2j0zyyuGvXKRWqKmVq5oweOrvEQ5Fw1qXj2Fc31eSmnYY
   oGoS7+JWBZz0LxrUlThxHry9hJ63qwV+TvsUS+kGhniNE2uwx4flwc1PX
   y1BA6JSAWW2OMkCKzzMwiPeVRpGIHZU4Pb98Mt0YOSM7VB63wmk/JUeP/
   4rmvxoLdYJGs0MXHh4jCQz9i/lpmZWDrDKLTUkBJ5SDcLBSrvNJlEy+/L
   VxvyFb7MZnKtqpoAnB+21PEGQjc1UbveLszMLRHqNtiXcXXxCNK8U0yCF
   Q==;
X-CSE-ConnectionGUID: 6IFE5G+HQrei3ttKRHDFHA==
X-CSE-MsgGUID: 5/jEqOn/R9GwRhZnewdAdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="73835480"
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="73835480"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 10:37:08 -0800
X-CSE-ConnectionGUID: hm2VYymoQTiQVnvTIOnENw==
X-CSE-MsgGUID: Z31XybFiRhilpkSXiTJoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="210543106"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jan 2026 10:37:05 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhXe2-00000000N9g-2MNB;
	Sun, 18 Jan 2026 18:37:02 +0000
Date: Mon, 19 Jan 2026 02:36:18 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-ID: <202601190247.dDAvbbMH-lkp@intel.com>
References: <20260118152448.2560414-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118152448.2560414-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e84d960149e71e8d5e4db69775ce31305898ed0c]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/compiler_types-Introduce-inline_for_performance/20260118-232653
base:   e84d960149e71e8d5e4db69775ce31305898ed0c
patch link:    https://lore.kernel.org/r/20260118152448.2560414-1-edumazet%40google.com
patch subject: [PATCH] compiler_types: Introduce inline_for_performance
config: m68k-amcore_defconfig (https://download.01.org/0day-ci/archive/20260119/202601190247.dDAvbbMH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601190247.dDAvbbMH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601190247.dDAvbbMH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/div64.h:6,
                    from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from arch/m68k/coldfire/cache.c:12:
>> include/asm-generic/div64.h:138:10: warning: '__arch_xprod_64' defined but not used [-Wunused-function]
     138 | uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
         |          ^~~~~~~~~~~~~~~


vim +/__arch_xprod_64 +138 include/asm-generic/div64.h

461a5e51060c93 Nicolas Pitre 2015-10-30  125  
f682b27c57aec2 Nicolas Pitre 2015-10-30  126  #ifndef __arch_xprod_64
f682b27c57aec2 Nicolas Pitre 2015-10-30  127  /*
f682b27c57aec2 Nicolas Pitre 2015-10-30  128   * Default C implementation for __arch_xprod_64()
f682b27c57aec2 Nicolas Pitre 2015-10-30  129   *
f682b27c57aec2 Nicolas Pitre 2015-10-30  130   * Prototype: uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
f682b27c57aec2 Nicolas Pitre 2015-10-30  131   * Semantic:  retval = ((bias ? m : 0) + m * n) >> 64
f682b27c57aec2 Nicolas Pitre 2015-10-30  132   *
f682b27c57aec2 Nicolas Pitre 2015-10-30  133   * The product is a 128-bit value, scaled down to 64 bits.
00a31dd3acea0f Nicolas Pitre 2024-10-03  134   * Hoping for compile-time optimization of  conditional code.
f682b27c57aec2 Nicolas Pitre 2015-10-30  135   * Architectures may provide their own optimized assembly implementation.
f682b27c57aec2 Nicolas Pitre 2015-10-30  136   */
5f712d70e20a46 Eric Dumazet  2026-01-18  137  static inline_for_performance
d533cb2d2af400 Nicolas Pitre 2024-10-03 @138  uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
f682b27c57aec2 Nicolas Pitre 2015-10-30  139  {
f682b27c57aec2 Nicolas Pitre 2015-10-30  140  	uint32_t m_lo = m;
f682b27c57aec2 Nicolas Pitre 2015-10-30  141  	uint32_t m_hi = m >> 32;
f682b27c57aec2 Nicolas Pitre 2015-10-30  142  	uint32_t n_lo = n;
f682b27c57aec2 Nicolas Pitre 2015-10-30  143  	uint32_t n_hi = n >> 32;
00a31dd3acea0f Nicolas Pitre 2024-10-03  144  	uint64_t x, y;
f682b27c57aec2 Nicolas Pitre 2015-10-30  145  
00a31dd3acea0f Nicolas Pitre 2024-10-03  146  	/* Determine if overflow handling can be dispensed with. */
00a31dd3acea0f Nicolas Pitre 2024-10-03  147  	bool no_ovf = __builtin_constant_p(m) &&
00a31dd3acea0f Nicolas Pitre 2024-10-03  148  		      ((m >> 32) + (m & 0xffffffff) < 0x100000000);
f682b27c57aec2 Nicolas Pitre 2015-10-30  149  
00a31dd3acea0f Nicolas Pitre 2024-10-03  150  	if (no_ovf) {
00a31dd3acea0f Nicolas Pitre 2024-10-03  151  		x = (uint64_t)m_lo * n_lo + (bias ? m : 0);
00a31dd3acea0f Nicolas Pitre 2024-10-03  152  		x >>= 32;
00a31dd3acea0f Nicolas Pitre 2024-10-03  153  		x += (uint64_t)m_lo * n_hi;
00a31dd3acea0f Nicolas Pitre 2024-10-03  154  		x += (uint64_t)m_hi * n_lo;
00a31dd3acea0f Nicolas Pitre 2024-10-03  155  		x >>= 32;
00a31dd3acea0f Nicolas Pitre 2024-10-03  156  		x += (uint64_t)m_hi * n_hi;
f682b27c57aec2 Nicolas Pitre 2015-10-30  157  	} else {
00a31dd3acea0f Nicolas Pitre 2024-10-03  158  		x = (uint64_t)m_lo * n_lo + (bias ? m_lo : 0);
00a31dd3acea0f Nicolas Pitre 2024-10-03  159  		y = (uint64_t)m_lo * n_hi + (uint32_t)(x >> 32) + (bias ? m_hi : 0);
00a31dd3acea0f Nicolas Pitre 2024-10-03  160  		x = (uint64_t)m_hi * n_hi + (uint32_t)(y >> 32);
00a31dd3acea0f Nicolas Pitre 2024-10-03  161  		y = (uint64_t)m_hi * n_lo + (uint32_t)y;
00a31dd3acea0f Nicolas Pitre 2024-10-03  162  		x += (uint32_t)(y >> 32);
f682b27c57aec2 Nicolas Pitre 2015-10-30  163  	}
f682b27c57aec2 Nicolas Pitre 2015-10-30  164  
00a31dd3acea0f Nicolas Pitre 2024-10-03  165  	return x;
f682b27c57aec2 Nicolas Pitre 2015-10-30  166  }
f682b27c57aec2 Nicolas Pitre 2015-10-30  167  #endif
f682b27c57aec2 Nicolas Pitre 2015-10-30  168  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

