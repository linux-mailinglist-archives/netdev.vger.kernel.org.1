Return-Path: <netdev+bounces-233424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA18C130E6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4351AA494D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 06:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170902727FD;
	Tue, 28 Oct 2025 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0jcydBa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1171C3F0C
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631481; cv=none; b=eD8GA4Fjc5jeQqLGRKyXx+T+gQYn8BNZbTGbUatY44pHmRvgD2G8lgTFfLbaOcupRnyaocesw5bUE1z9D22a6ZUzFwX6RkpTRs6Vj/GZuehERMBvFrG301kCTWpY42zCs2o0pM6I6jBB0dDATXuTlXsXxA/tr9xQJd2xlR+sPYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631481; c=relaxed/simple;
	bh=9wVKsjciKrTy3D956CfMuajzIEyyIjdi/6fv61U8dRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhiHDv1+lz0O1u9pVmnOL+C3I6yu3bAht3yV2pe1PXIeUYagBXGaxoZHple865JmcQx86qB3uh08zpO1SpMwMShGz4M/H86829F3HZssec+dXeq33sqV5SA7lhijK67kuyEitsxlHheD72n3M1kN4dfRuI3n4P35IwgQ42ApUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0jcydBa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761631479; x=1793167479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9wVKsjciKrTy3D956CfMuajzIEyyIjdi/6fv61U8dRo=;
  b=h0jcydBapa+hJkH9F+4oS4V/FWAqKm9xQxX0vczQFcyXmy+E8bXSlFwr
   5Jb5TA1an7vLPDJWiPwwVfOM/Nt56wrFDWOn+G4yQFu3A5k0VaH85INnp
   2BUD3cX5zWE9ArVjt7EylF1ZXKAWjmRADR3prc2kqN1r4xYQKRXH7POiR
   bGmBAYRaP1bBetWWQDIzkvxxgIPB1m2OOazK98zPAH8mndWRwsqJ+IsPP
   wlrNl+r4i2rNDzP06864HPKcNuanUBtVpx9F+RiaNtw+7c4Rvejaha+vd
   UjYrRHVKo56aE7P9y+ZJs6y0w1MdL6c8/7+/7eBuEOr9AYdXGLFeK/+Bg
   A==;
X-CSE-ConnectionGUID: P5eWJXghQ9OkYM0numnjHQ==
X-CSE-MsgGUID: aiYDGB3DTdyNVEgOgookvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63425972"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="63425972"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 23:04:38 -0700
X-CSE-ConnectionGUID: YBaphMryRBKBlQFK0cdKUw==
X-CSE-MsgGUID: u6X9RK1bT9qx4LM3uTiYlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="190454008"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Oct 2025 23:04:28 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDcmx-000Io7-2J;
	Tue, 28 Oct 2025 06:02:52 +0000
Date: Tue, 28 Oct 2025 13:59:54 +0800
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
Subject: Re: [PATCH v5 17/23] iio: mlx90614: Convert to common
 field_{get,prep}() helpers
Message-ID: <202510281304.RK3J3c3t-lkp@intel.com>
References: <8ea8d9d6c33d9589e8761f6000639546f1bd5148.1761588465.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ea8d9d6c33d9589e8761f6000639546f1bd5148.1761588465.git.geert+renesas@glider.be>

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
patch link:    https://lore.kernel.org/r/8ea8d9d6c33d9589e8761f6000639546f1bd5148.1761588465.git.geert%2Brenesas%40glider.be
patch subject: [PATCH v5 17/23] iio: mlx90614: Convert to common field_{get,prep}() helpers
config: hexagon-randconfig-001-20251028 (https://download.01.org/0day-ci/archive/20251028/202510281304.RK3J3c3t-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project e1ae12640102fd2b05bc567243580f90acb1135f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510281304.RK3J3c3t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510281304.RK3J3c3t-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/temperature/mlx90614.c:177:10: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((chip_info->fir_config_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (chip_info->fir_config_mask)))' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
     177 |                 ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>> drivers/iio/temperature/mlx90614.c:181:9: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((chip_info->iir_config_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (chip_info->iir_config_mask)))' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
     181 |         ret |= field_prep(chip_info->iir_config_mask, i);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   drivers/iio/temperature/mlx90614.c:331:9: warning: result of comparison of constant 4294967295 with expression of type 'typeof (_Generic((chip_info->iir_config_mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (chip_info->iir_config_mask)))' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
     331 |                 idx = field_get(chip_info->iir_config_mask, ret) -
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:274:32: note: expanded from macro 'field_get'
     274 |         (__builtin_constant_p(mask) ? FIELD_GET(mask, reg)              \
         |                                       ^~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:3: note: expanded from macro 'FIELD_GET'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   3 warnings generated.


vim +177 drivers/iio/temperature/mlx90614.c

fad65a8fe5b85b Vianney le Clément de Saint-Marcq 2015-03-30  141  
764589b688a1b0 Crt Mori                          2015-08-17  142  /*
3d5ead238bc85e Marek Vasut                       2023-05-10  143   * Find the IIR value inside iir_values array and return its position
764589b688a1b0 Crt Mori                          2015-08-17  144   * which is equivalent to the bit value in sensor register
764589b688a1b0 Crt Mori                          2015-08-17  145   */
764589b688a1b0 Crt Mori                          2015-08-17  146  static inline s32 mlx90614_iir_search(const struct i2c_client *client,
764589b688a1b0 Crt Mori                          2015-08-17  147  				      int value)
764589b688a1b0 Crt Mori                          2015-08-17  148  {
3d5ead238bc85e Marek Vasut                       2023-05-10  149  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
3d5ead238bc85e Marek Vasut                       2023-05-10  150  	struct mlx90614_data *data = iio_priv(indio_dev);
3d5ead238bc85e Marek Vasut                       2023-05-10  151  	const struct mlx_chip_info *chip_info = data->chip_info;
764589b688a1b0 Crt Mori                          2015-08-17  152  	int i;
764589b688a1b0 Crt Mori                          2015-08-17  153  	s32 ret;
764589b688a1b0 Crt Mori                          2015-08-17  154  
3d5ead238bc85e Marek Vasut                       2023-05-10  155  	for (i = chip_info->iir_valid_offset;
3d5ead238bc85e Marek Vasut                       2023-05-10  156  	     i < ARRAY_SIZE(chip_info->iir_values);
3d5ead238bc85e Marek Vasut                       2023-05-10  157  	     i++) {
3d5ead238bc85e Marek Vasut                       2023-05-10  158  		if (value == chip_info->iir_values[i])
764589b688a1b0 Crt Mori                          2015-08-17  159  			break;
764589b688a1b0 Crt Mori                          2015-08-17  160  	}
764589b688a1b0 Crt Mori                          2015-08-17  161  
3d5ead238bc85e Marek Vasut                       2023-05-10  162  	if (i == ARRAY_SIZE(chip_info->iir_values))
764589b688a1b0 Crt Mori                          2015-08-17  163  		return -EINVAL;
764589b688a1b0 Crt Mori                          2015-08-17  164  
764589b688a1b0 Crt Mori                          2015-08-17  165  	/*
764589b688a1b0 Crt Mori                          2015-08-17  166  	 * CONFIG register values must not be changed so
764589b688a1b0 Crt Mori                          2015-08-17  167  	 * we must read them before we actually write
764589b688a1b0 Crt Mori                          2015-08-17  168  	 * changes
764589b688a1b0 Crt Mori                          2015-08-17  169  	 */
3d5ead238bc85e Marek Vasut                       2023-05-10  170  	ret = i2c_smbus_read_word_data(client, chip_info->op_eeprom_config1);
1de953e77b8c8b Crt Mori                          2015-10-02  171  	if (ret < 0)
764589b688a1b0 Crt Mori                          2015-08-17  172  		return ret;
764589b688a1b0 Crt Mori                          2015-08-17  173  
3d5ead238bc85e Marek Vasut                       2023-05-10  174  	/* Modify FIR on parts which have configurable FIR filter */
3d5ead238bc85e Marek Vasut                       2023-05-10  175  	if (chip_info->fir_config_mask) {
3d5ead238bc85e Marek Vasut                       2023-05-10  176  		ret &= ~chip_info->fir_config_mask;
3d5ead238bc85e Marek Vasut                       2023-05-10 @177  		ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);
3d5ead238bc85e Marek Vasut                       2023-05-10  178  	}
3d5ead238bc85e Marek Vasut                       2023-05-10  179  
3d5ead238bc85e Marek Vasut                       2023-05-10  180  	ret &= ~chip_info->iir_config_mask;
3d5ead238bc85e Marek Vasut                       2023-05-10 @181  	ret |= field_prep(chip_info->iir_config_mask, i);
1de953e77b8c8b Crt Mori                          2015-10-02  182  
764589b688a1b0 Crt Mori                          2015-08-17  183  	/* Write changed values */
3d5ead238bc85e Marek Vasut                       2023-05-10  184  	ret = mlx90614_write_word(client, chip_info->op_eeprom_config1, ret);
764589b688a1b0 Crt Mori                          2015-08-17  185  	return ret;
764589b688a1b0 Crt Mori                          2015-08-17  186  }
764589b688a1b0 Crt Mori                          2015-08-17  187  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

