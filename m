Return-Path: <netdev+bounces-233423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EED4C130D7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6905F1AA544A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 06:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E725A23BD17;
	Tue, 28 Oct 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nnaj3hz3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B11F09A5
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631371; cv=none; b=eh7HMbODKOzntJip2TnsP4TpnaanwShNMurwqLhSNVynHYMfDm6GwhnC/57A+ft4+cufouJWYwdyIN25A3IXcF7I9pn62kdlYHNhCkKHzO+Etuoo/RSSx43+5iav8MQtMCCdK/dS//C9l92MqTqHXTvRoKAc3SUnrAc5rjwK5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631371; c=relaxed/simple;
	bh=Yw0JWC0o8nz0687CrUsCbr9yeALQQ7d56oxweouCg5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIi/c14DVNGl+MBQorfqm+32t86T4iadTfzK8seMhmwJe67JwNazOHCuFDJo0+a93aggSwZ9Peb+6EuBvvkRpPU92s6e56mzU1fh8/OeVDJmHLM1PULVSHFmS35qWvjHR5SkwvEYlKJTk6MbG9826t8oHEi2JxRCkzbegCRZp1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nnaj3hz3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761631370; x=1793167370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yw0JWC0o8nz0687CrUsCbr9yeALQQ7d56oxweouCg5Q=;
  b=Nnaj3hz3O+2fNYl1AcuPdHNqQrZuZzZW3tNwguLWXiBaJg27BPDoiniF
   f/hdykuI+hTOQsYp8iql7axOAtIz9g5P7kBLGST1j0w/NGv+JE6JsqVVn
   dSeemhHBb+neMB1qpNNPCbFk/2QFwa1BOGRQX4+4/TobBJNZaz7CgjMAe
   Mj2sNVe4SGCGsQ1fQscr60MC9Z9OA8H/WXf6j13/BxCgJmZpQN9ZbaFNK
   GswzgaQVHfRekU9C3BGnTKBfb19QxPhsUBOekeaplFMOxPCwAsfZsmOzP
   5xbnt0aMATwdC66rH/6iAPVGwd4DgMyIBq29HSPE5fh8ycfNsjqeV6n6c
   g==;
X-CSE-ConnectionGUID: pJeyWsldRNmFM8MXpRbxNQ==
X-CSE-MsgGUID: QXIpsk8sQFKS+ybnwBP89A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63425891"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="63425891"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 23:02:49 -0700
X-CSE-ConnectionGUID: 2QlvLPKbTiCUTnvFWLoxNg==
X-CSE-MsgGUID: kNGTzRatSqOfDmTWXzIDsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="185588824"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Oct 2025 23:02:42 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDclq-000Io5-2D;
	Tue, 28 Oct 2025 06:01:55 +0000
Date: Tue, 28 Oct 2025 14:01:15 +0800
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
Subject: Re: [PATCH v5 12/23] clk: at91: Convert to common field_{get,prep}()
 helpers
Message-ID: <202510281335.UpSLYJG9-lkp@intel.com>
References: <b9e9b7d94ba51c7bc028321a85e91adecb23f925.1761588465.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e9b7d94ba51c7bc028321a85e91adecb23f925.1761588465.git.geert+renesas@glider.be>

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
patch link:    https://lore.kernel.org/r/b9e9b7d94ba51c7bc028321a85e91adecb23f925.1761588465.git.geert%2Brenesas%40glider.be
patch subject: [PATCH v5 12/23] clk: at91: Convert to common field_{get,prep}() helpers
config: arm-randconfig-001-20251028 (https://download.01.org/0day-ci/archive/20251028/202510281335.UpSLYJG9-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project e1ae12640102fd2b05bc567243580f90acb1135f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510281335.UpSLYJG9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510281335.UpSLYJG9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/at91/clk-peripheral.c:179:7: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((periph->layout->div_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (periph->layout->div_mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     179 |                            field_prep(periph->layout->div_mask, periph->div) |
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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


vim +179 drivers/clk/at91/clk-peripheral.c

6114067e437eb8 Boris Brezillon   2013-10-11  163  
36971566ea7a51 Claudiu Beznea    2021-10-11  164  static int clk_sam9x5_peripheral_set(struct clk_sam9x5_peripheral *periph,
36971566ea7a51 Claudiu Beznea    2021-10-11  165  				     unsigned int status)
6114067e437eb8 Boris Brezillon   2013-10-11  166  {
1bdf02326b71ea Boris Brezillon   2014-09-07  167  	unsigned long flags;
36971566ea7a51 Claudiu Beznea    2021-10-11  168  	unsigned int enable = status ? AT91_PMC_PCR_EN : 0;
6114067e437eb8 Boris Brezillon   2013-10-11  169  
6114067e437eb8 Boris Brezillon   2013-10-11  170  	if (periph->id < PERIPHERAL_ID_MIN)
6114067e437eb8 Boris Brezillon   2013-10-11  171  		return 0;
6114067e437eb8 Boris Brezillon   2013-10-11  172  
1bdf02326b71ea Boris Brezillon   2014-09-07  173  	spin_lock_irqsave(periph->lock, flags);
cb4f4949b1c76f Alexandre Belloni 2019-04-02  174  	regmap_write(periph->regmap, periph->layout->offset,
cb4f4949b1c76f Alexandre Belloni 2019-04-02  175  		     (periph->id & periph->layout->pid_mask));
cb4f4949b1c76f Alexandre Belloni 2019-04-02  176  	regmap_update_bits(periph->regmap, periph->layout->offset,
cb4f4949b1c76f Alexandre Belloni 2019-04-02  177  			   periph->layout->div_mask | periph->layout->cmd |
36971566ea7a51 Claudiu Beznea    2021-10-11  178  			   enable,
cb4f4949b1c76f Alexandre Belloni 2019-04-02 @179  			   field_prep(periph->layout->div_mask, periph->div) |
36971566ea7a51 Claudiu Beznea    2021-10-11  180  			   periph->layout->cmd | enable);
1bdf02326b71ea Boris Brezillon   2014-09-07  181  	spin_unlock_irqrestore(periph->lock, flags);
1bdf02326b71ea Boris Brezillon   2014-09-07  182  
6114067e437eb8 Boris Brezillon   2013-10-11  183  	return 0;
6114067e437eb8 Boris Brezillon   2013-10-11  184  }
6114067e437eb8 Boris Brezillon   2013-10-11  185  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

