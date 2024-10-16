Return-Path: <netdev+bounces-136168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B69A0C35
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 16:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CAF28994A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355720C47E;
	Wed, 16 Oct 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+rFV/ST"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94A20C00F;
	Wed, 16 Oct 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087165; cv=none; b=NTVIULIiTW9+eb7wzrschabVgiI6aBa7H6CMQ8oTKpdaM6I4H8GRtExrKSVHKG1bU10SiDXhSe5uVlrdwmpgGXhItRbMCWEP6wl6ovow+Cc0T6loElNXSU0yplnnWqFBLCKICKtX/e7pli8D+1o4snukh8I1pPQ8CKwFywpUWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087165; c=relaxed/simple;
	bh=1QhS/ZQtaLfxfKipAIdLpF/f15cK8G1+3Y9DdLBavL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoNnwNM1s2UA/TqFslen9Lgq2VpO551C+ltucgfCDv90sFtKJWKrvJs5L4z5tny8JAFYOKq5WDFcZeUo0L7hFAfqbWJIEh7SguB2niuWv3tfpd/gtWmwQceCcZtyHuHqtJCutcGWwmoGz7G31GRw6+M/l7B6AV4YLHLtn+qxK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+rFV/ST; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729087165; x=1760623165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1QhS/ZQtaLfxfKipAIdLpF/f15cK8G1+3Y9DdLBavL8=;
  b=L+rFV/STUS11d2+EMBMKt02rPROi9a2PyF88Y7uGD38sPV9uSFYoE5uu
   trAVxB7LM+3kiaCBk9rDrMhXSeVIluuqizSQwck3m25wmIFw83wd95cbm
   BrAuKDsJB4fN700GsNq/5zXDdBApENM3s3uJMpCWI4EQkiMVtPTMJE8Gb
   afEwvZ2howneGAjCYOLlsAj+sFaa0uPwWT9Z5EBD/hPT6eZFNB+n9XaOT
   CJNSaj6J1A47QDVjKGGkQmQ7+CK1YskZa7C6tfrKPk+X2nlxiA4xtAAjQ
   aNF04Ms6q4weaXSA+dDT4Z7Qrtv+T+kRXBCMAPWVfzxN++FhO6w7LSU/9
   g==;
X-CSE-ConnectionGUID: p/QHkfQ0TguJHEH2VB3tAQ==
X-CSE-MsgGUID: cE6GxUSlQrqrT7ldd3CJ1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="32335950"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="32335950"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:59:24 -0700
X-CSE-ConnectionGUID: 35FUm06sQuSy7IjIHDMHBQ==
X-CSE-MsgGUID: r23weTMzQI2u/Y7UX/aNkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78284536"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Oct 2024 06:59:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t14YW-000KyF-2E;
	Wed, 16 Oct 2024 13:59:16 +0000
Date: Wed, 16 Oct 2024 21:59:09 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	George McCollister <george.mccollister@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Rosen Penev <rosenp@gmail.com>, Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: memcpy to ethtool_puts
Message-ID: <202410162106.9WmH0oPN-lkp@intel.com>
References: <20241015200222.12452-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015200222.12452-3-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master horms-ipvs/master v6.12-rc3 next-20241016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-memcpy-to-ethtool_puts/20241016-040502
base:   net/main
patch link:    https://lore.kernel.org/r/20241015200222.12452-3-rosenp%40gmail.com
patch subject: [PATCH] net: memcpy to ethtool_puts
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20241016/202410162106.9WmH0oPN-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410162106.9WmH0oPN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410162106.9WmH0oPN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/mv88e6xxx/chip.c: In function 'mv88e6xxx_get_strings':
>> drivers/net/dsa/mv88e6xxx/chip.c:1215:13: warning: variable 'count' set but not used [-Wunused-but-set-variable]
    1215 |         int count = 0;
         |             ^~~~~
   during RTL pass: mach
   drivers/net/dsa/mv88e6xxx/chip.c: In function 'mv88e6xxx_read':
   drivers/net/dsa/mv88e6xxx/chip.c:68:1: internal compiler error: in arc_ifcvt, at config/arc/arc.cc:9703
      68 | }
         | ^
   0x5b78c1 arc_ifcvt
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/config/arc/arc.cc:9703
   0xe431b4 arc_reorg
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/config/arc/arc.cc:8552
   0xaed299 execute
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/reorg.cc:3927
   Please submit a full bug report, with preprocessed source (by using -freport-bug).
   Please include the complete backtrace with any bug report.
   See <https://gcc.gnu.org/bugs/> for instructions.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/count +1215 drivers/net/dsa/mv88e6xxx/chip.c

65f60e4582bd32 drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2018-03-28  1210  
dfafe449bbc91d drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2016-11-21  1211  static void mv88e6xxx_get_strings(struct dsa_switch *ds, int port,
89f09048348936 drivers/net/dsa/mv88e6xxx/chip.c Florian Fainelli 2018-04-25  1212  				  u32 stringset, uint8_t *data)
f5e2ed022dff60 drivers/net/dsa/mv88e6xxx.c      Andrew Lunn      2015-12-23  1213  {
04bed1434df256 drivers/net/dsa/mv88e6xxx/chip.c Vivien Didelot   2016-08-31  1214  	struct mv88e6xxx_chip *chip = ds->priv;
436fe17d273bed drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2018-03-01 @1215  	int count = 0;
dfafe449bbc91d drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2016-11-21  1216  
89f09048348936 drivers/net/dsa/mv88e6xxx/chip.c Florian Fainelli 2018-04-25  1217  	if (stringset != ETH_SS_STATS)
89f09048348936 drivers/net/dsa/mv88e6xxx/chip.c Florian Fainelli 2018-04-25  1218  		return;
89f09048348936 drivers/net/dsa/mv88e6xxx/chip.c Florian Fainelli 2018-04-25  1219  
c9acece064e3f0 drivers/net/dsa/mv88e6xxx/chip.c Rasmus Villemoes 2019-06-20  1220  	mv88e6xxx_reg_lock(chip);
c6c8cd5e3ce494 drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2018-03-01  1221  
dfafe449bbc91d drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2016-11-21  1222  	if (chip->info->ops->stats_get_strings)
436fe17d273bed drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2018-03-01  1223  		count = chip->info->ops->stats_get_strings(chip, data);
436fe17d273bed drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2018-03-01  1224  
577149384b2aab drivers/net/dsa/mv88e6xxx/chip.c Rosen Penev      2024-10-15  1225  	if (chip->info->ops->serdes_get_strings)
65f60e4582bd32 drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2018-03-28  1226  		count = chip->info->ops->serdes_get_strings(chip, port, data);
c6c8cd5e3ce494 drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2018-03-01  1227  
65f60e4582bd32 drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2018-03-28  1228  	mv88e6xxx_atu_vtu_get_strings(data);
65f60e4582bd32 drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2018-03-28  1229  
c9acece064e3f0 drivers/net/dsa/mv88e6xxx/chip.c Rasmus Villemoes 2019-06-20  1230  	mv88e6xxx_reg_unlock(chip);
dfafe449bbc91d drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2016-11-21  1231  }
dfafe449bbc91d drivers/net/dsa/mv88e6xxx/chip.c Andrew Lunn      2016-11-21  1232  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

