Return-Path: <netdev+bounces-233429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B374C13321
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8F61AA6E6D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 06:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB42C027C;
	Tue, 28 Oct 2025 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqH9cCS1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F552BE047
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633642; cv=none; b=KqR+85MJtxZLoxvsIWEqmrdywvgD8VDjQA65CUkFPuWYOPCZWKByx3tGoSlLj9dGjUXeS2S/CGAdAu8QIwvmHUe2t+iwfYSkgQTVHKhBbfVhD2vt8eponKDR4giErib1TII6jwuXUQE0BZtFfpLdGEr91ZdgkOKexAOysOiQA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633642; c=relaxed/simple;
	bh=Sgqs0YMyTEOcNyaZDyzD2vJw5rl5OjZcujPtI3AnvtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psRBIunBNYndT9HXqoYxfkxk+QqwwMEtDwpuWM+Uh512bP4SHE2miJKvZ66ReisEZOr1snzAVPQBfzpWD14fqVAWcK+EybVZJH5NsEN0hfK8nZM8px6sL8bBWydY4z2+pbuVxREYMMsFNUgiDqbls7cBogsnOEHKbGq6rGrxSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqH9cCS1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761633641; x=1793169641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sgqs0YMyTEOcNyaZDyzD2vJw5rl5OjZcujPtI3AnvtM=;
  b=ZqH9cCS123iaz5mdSdks2IWYLY0aPq4XZfRr9e4G7HqvguUbYXwrKwuz
   nd94KcRWbXIraTLTGWHWIavSoIGqMNAzWt+x3I7VnIVC0/mro3OJpZgBm
   PelYjPmdmERpYUiKuZF8/uSNpFExU65sRv3sDno2C/3AtKu1ZA10btwfb
   t61331hKj6cvSJBTBMTrx4qKUlzmhACAjdlPUfZwFUj1QZq8TDdO6SgVG
   FRTvX9t4CIkfSX3gSOYEb5dzE/O7BqyuJ5kktVRMIPHzYkg4x5vKR7MwD
   dt3thXeBMMm2iAAD/lz3uUyptkwVPwzA1HZ4SiNCXHFfBj3Woc4JEAVYR
   A==;
X-CSE-ConnectionGUID: IXbeSO5dQS2gMbQQJJzD6w==
X-CSE-MsgGUID: e6edAyPaTNOPH5wQGOyxGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81356429"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="81356429"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 23:40:40 -0700
X-CSE-ConnectionGUID: /NT+Aj9oQ8urbmzFV07u4Q==
X-CSE-MsgGUID: GQKqL3eOR1KNT1jBKY1etg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="185347797"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 27 Oct 2025 23:40:34 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDdML-000Iqx-0d;
	Tue, 28 Oct 2025 06:39:28 +0000
Date: Tue, 28 Oct 2025 14:37:09 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 15/23] gpio: aspeed: Convert to common
 field_{get,prep}() helpers
Message-ID: <202510281414.DnejZh4n-lkp@intel.com>
References: <fbefa056d1e2cd13c52a0489b955c2b9442f0c9a.1761588465.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbefa056d1e2cd13c52a0489b955c2b9442f0c9a.1761588465.git.geert+renesas@glider.be>

Hi Geert,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on next-20251027]
[cannot apply to clk/clk-next geert-renesas-devel/next geert-renesas-drivers/renesas-clk linus/master v6.18-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geert-Uytterhoeven/clk-at91-pmc-undef-field_-get-prep-before-definition/20251028-025423
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/fbefa056d1e2cd13c52a0489b955c2b9442f0c9a.1761588465.git.geert%2Brenesas%40glider.be
patch subject: [PATCH v5 15/23] gpio: aspeed: Convert to common field_{get,prep}() helpers
config: x86_64-buildonly-randconfig-003-20251028 (https://download.01.org/0day-ci/archive/20251028/202510281414.DnejZh4n-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510281414.DnejZh4n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510281414.DnejZh4n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-aspeed.c:1161:44: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
    1161 |                 write_val = (ioread32(addr) & ~(mask)) | field_prep(mask, val);
         |                                                          ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:256:32: note: expanded from macro 'field_prep'
     256 |         (__builtin_constant_p(mask) ? FIELD_PREP(mask, val)             \
         |                                       ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:3: note: expanded from macro 'FIELD_PREP'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:53: note: expanded from macro '__BF_FIELD_CHECK'
      72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
      73 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      74 |                                  _pfx "type of reg too small for mask"); \
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:597:22: note: expanded from macro 'compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:585:23: note: expanded from macro '_compiletime_assert'
     585 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:577:9: note: expanded from macro '__compiletime_assert'
     577 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   1 warning generated.


vim +1161 drivers/gpio/gpio-aspeed.c

b2e861bd1eaf4c Billy Tsai 2024-10-08  1152  
b2e861bd1eaf4c Billy Tsai 2024-10-08  1153  static void aspeed_g7_reg_bit_set(struct aspeed_gpio *gpio, unsigned int offset,
b2e861bd1eaf4c Billy Tsai 2024-10-08  1154  				  const enum aspeed_gpio_reg reg, bool val)
b2e861bd1eaf4c Billy Tsai 2024-10-08  1155  {
b2e861bd1eaf4c Billy Tsai 2024-10-08  1156  	u32 mask = aspeed_gpio_g7_reg_mask(reg);
b2e861bd1eaf4c Billy Tsai 2024-10-08  1157  	void __iomem *addr = gpio->base + GPIO_G7_CTRL_REG_OFFSET(offset);
b2e861bd1eaf4c Billy Tsai 2024-10-08  1158  	u32 write_val;
b2e861bd1eaf4c Billy Tsai 2024-10-08  1159  
b2e861bd1eaf4c Billy Tsai 2024-10-08  1160  	if (mask) {
b2e861bd1eaf4c Billy Tsai 2024-10-08 @1161  		write_val = (ioread32(addr) & ~(mask)) | field_prep(mask, val);
b2e861bd1eaf4c Billy Tsai 2024-10-08  1162  		iowrite32(write_val, addr);
b2e861bd1eaf4c Billy Tsai 2024-10-08  1163  	}
b2e861bd1eaf4c Billy Tsai 2024-10-08  1164  }
b2e861bd1eaf4c Billy Tsai 2024-10-08  1165  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

