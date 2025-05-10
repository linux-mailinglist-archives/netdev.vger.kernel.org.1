Return-Path: <netdev+bounces-189426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11206AB209B
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 02:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4613AC6EC
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B721ADA2;
	Sat, 10 May 2025 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLDprFrv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392711F03EA;
	Sat, 10 May 2025 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746837801; cv=none; b=Rfak5MEs7HLsbknCl9Is1jAvac+86sfxRK4I+1VAQ+Ak7A8HRyQGhgYVT6Ui7U5a7EqSW0E1exOJ9qXO9r791/1CW9F2Xsz7eSlWa0Kyhmeor7Obhpk0i0mhAX+baHetImVStuj3vCxNTA4w5yKlQmV+cashRQad73N0w798eUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746837801; c=relaxed/simple;
	bh=LhGiLxgbPdM3rN4eXh0z57NIuiVRKtbA6flRQ9sDwmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4nKK7MpNiYMoKu5sINGVPDU8YnUizdnvzcOeUitAijNUQaDWrNGXcmf4Q/4Vw/nq/E1Nfrp2+4D2lQcVm2x18duORvTNYkLTxr+CdTVS+cotNPE1wtbfR6hMzxWTdsf2z9iplv8gX42kXpngMDM8mcgb/kFiMCLlwNvtjxlzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLDprFrv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746837799; x=1778373799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LhGiLxgbPdM3rN4eXh0z57NIuiVRKtbA6flRQ9sDwmg=;
  b=TLDprFrvmsC/VeFPIn8Y9Ty2dC2M818fxDPiLDVDs0FG5eiGPpv3OV1M
   a7v0826qFpz0ZgBB27DV1Rj8KyYdrIDV8JRag113yIgxlnY28ppJ1Zpog
   8hMUaT46Xn8KyxO5BBF5SI9Wq6EwiDaIwHnzCBd0PMhwq3UfLbhzM9crU
   LCNYU7sr2oEyJgKyKZfuCK7sRE68ZK4AkCO+jiHsBusCxW2e3hUcnbt4r
   jXtsS4u+d8lCf1mhrS203dnkh5tFo6Hkfq9AeXRugk+M/W/eme2Hip24D
   9D3j0/lHo+XA6u/8Ub43F2bEDXuzpzOiaRlOpZL6DEVtVkevfWPHB3kh9
   g==;
X-CSE-ConnectionGUID: oXodDbdkTLuMaRC0lZsrfQ==
X-CSE-MsgGUID: zSlLX0RXT/KRtp+diLepIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59338510"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="59338510"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 17:43:18 -0700
X-CSE-ConnectionGUID: cZSWvVo7TseXullJDOJHqA==
X-CSE-MsgGUID: 1WYYRw9mR96Qwx4dKYoVCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="141735621"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 May 2025 17:43:15 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDYJ6-000CbX-2b;
	Sat, 10 May 2025 00:43:12 +0000
Date: Sat, 10 May 2025 08:42:41 +0800
From: kernel test robot <lkp@intel.com>
To: Raghav Sharma <raghav.s@samsung.com>, krzk@kernel.org,
	s.nawrocki@samsung.com, cw00.choi@samsung.com,
	mturquette@baylibre.com, sboyd@kernel.org, richardcochran@gmail.com,
	alim.akhtar@samsung.com
Cc: oe-kbuild-all@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Raghav Sharma <raghav.s@samsung.com>
Subject: Re: [PATCH v1] clk: samsung: exynosautov920: add block hsi2 clock
 support
Message-ID: <202505100814.gnMY3LoZ-lkp@intel.com>
References: <20250509131210.3192208-1-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509131210.3192208-1-raghav.s@samsung.com>

Hi Raghav,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on linus/master v6.15-rc5 next-20250509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Raghav-Sharma/clk-samsung-exynosautov920-add-block-hsi2-clock-support/20250509-212922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20250509131210.3192208-1-raghav.s%40samsung.com
patch subject: [PATCH v1] clk: samsung: exynosautov920: add block hsi2 clock support
config: csky-randconfig-002-20250510 (https://download.01.org/0day-ci/archive/20250510/202505100814.gnMY3LoZ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250510/202505100814.gnMY3LoZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505100814.gnMY3LoZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/clk/samsung/clk-exynosautov920.c:16:
>> drivers/clk/samsung/clk-exynosautov920.c:1781:23: error: 'FOUT_PLL_ETH' undeclared here (not in a function)
    1781 |         PLL(pll_531x, FOUT_PLL_ETH, "fout_pll_eth", "oscclk",
         |                       ^~~~~~~~~~~~
   drivers/clk/samsung/clk.h:273:35: note: in definition of macro '__PLL'
     273 |                 .id             = _id,                                  \
         |                                   ^~~
   drivers/clk/samsung/clk-exynosautov920.c:1781:9: note: in expansion of macro 'PLL'
    1781 |         PLL(pll_531x, FOUT_PLL_ETH, "fout_pll_eth", "oscclk",
         |         ^~~
>> drivers/clk/samsung/clk-exynosautov920.c:1792:13: error: 'CLK_MOUT_HSI2_NOC_UFS_USER' undeclared here (not in a function); did you mean 'CLK_MOUT_HSI1_NOC_USER'?
    1792 |         MUX(CLK_MOUT_HSI2_NOC_UFS_USER, "mout_clkcmu_hsi2_noc_ufs_user",
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:133:35: note: in definition of macro '__MUX'
     133 |                 .id             = _id,                          \
         |                                   ^~~
   drivers/clk/samsung/clk-exynosautov920.c:1792:9: note: in expansion of macro 'MUX'
    1792 |         MUX(CLK_MOUT_HSI2_NOC_UFS_USER, "mout_clkcmu_hsi2_noc_ufs_user",
         |         ^~~
>> drivers/clk/samsung/clk-exynosautov920.c:1794:13: error: 'CLK_MOUT_HSI2_UFS_EMBD_USER' undeclared here (not in a function); did you mean 'CLK_MOUT_HSI1_USBDRD_USER'?
    1794 |         MUX(CLK_MOUT_HSI2_UFS_EMBD_USER, "mout_clkcmu_hsi2_ufs_embd_user",
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:133:35: note: in definition of macro '__MUX'
     133 |                 .id             = _id,                          \
         |                                   ^~~
   drivers/clk/samsung/clk-exynosautov920.c:1794:9: note: in expansion of macro 'MUX'
    1794 |         MUX(CLK_MOUT_HSI2_UFS_EMBD_USER, "mout_clkcmu_hsi2_ufs_embd_user",
         |         ^~~
>> drivers/clk/samsung/clk-exynosautov920.c:1796:13: error: 'CLK_MOUT_HSI2_ETHERNET' undeclared here (not in a function)
    1796 |         MUX(CLK_MOUT_HSI2_ETHERNET, "mout_hsi2_ethernet",
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:133:35: note: in definition of macro '__MUX'
     133 |                 .id             = _id,                          \
         |                                   ^~~
   drivers/clk/samsung/clk-exynosautov920.c:1796:9: note: in expansion of macro 'MUX'
    1796 |         MUX(CLK_MOUT_HSI2_ETHERNET, "mout_hsi2_ethernet",
         |         ^~~
>> drivers/clk/samsung/clk-exynosautov920.c:1798:13: error: 'CLK_MOUT_HSI2_ETHERNET_USER' undeclared here (not in a function); did you mean 'CLK_MOUT_HSI1_NOC_USER'?
    1798 |         MUX(CLK_MOUT_HSI2_ETHERNET_USER, "mout_clkcmu_hsi2_ethernet_user",
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:133:35: note: in definition of macro '__MUX'
     133 |                 .id             = _id,                          \
         |                                   ^~~
   drivers/clk/samsung/clk-exynosautov920.c:1798:9: note: in expansion of macro 'MUX'
    1798 |         MUX(CLK_MOUT_HSI2_ETHERNET_USER, "mout_clkcmu_hsi2_ethernet_user",
         |         ^~~
>> drivers/clk/samsung/clk-exynosautov920.c:1803:13: error: 'CLK_DOUT_HSI2_ETHERNET' undeclared here (not in a function)
    1803 |         DIV(CLK_DOUT_HSI2_ETHERNET, "dout_hsi2_ethernet",
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:183:35: note: in definition of macro '__DIV'
     183 |                 .id             = _id,                          \
         |                                   ^~~
   drivers/clk/samsung/clk-exynosautov920.c:1803:9: note: in expansion of macro 'DIV'
    1803 |         DIV(CLK_DOUT_HSI2_ETHERNET, "dout_hsi2_ethernet",
         |         ^~~
>> drivers/clk/samsung/clk-exynosautov920.c:1806:13: error: 'CLK_DOUT_HSI2_ETHERNET_PTP' undeclared here (not in a function)
    1806 |         DIV(CLK_DOUT_HSI2_ETHERNET_PTP, "dout_hsi2_ethernet_ptp",
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/samsung/clk.h:183:35: note: in definition of macro '__DIV'
     183 |                 .id             = _id,                          \
         |                                   ^~~
   drivers/clk/samsung/clk-exynosautov920.c:1806:9: note: in expansion of macro 'DIV'
    1806 |         DIV(CLK_DOUT_HSI2_ETHERNET_PTP, "dout_hsi2_ethernet_ptp",
         |         ^~~


vim +/FOUT_PLL_ETH +1781 drivers/clk/samsung/clk-exynosautov920.c

  1778	
  1779	static const struct samsung_pll_clock hsi2_pll_clks[] __initconst = {
  1780		/* CMU_HSI2_PLL */
> 1781		PLL(pll_531x, FOUT_PLL_ETH, "fout_pll_eth", "oscclk",
  1782		    PLL_LOCKTIME_PLL_ETH, PLL_CON3_PLL_ETH, NULL),
  1783	};
  1784	
  1785	/* List of parent clocks for Muxes in CMU_HSI2 */
  1786	PNAME(mout_clkcmu_hsi2_noc_ufs_user_p) = { "oscclk", "dout_clkcmu_hsi2_noc_ufs" };
  1787	PNAME(mout_clkcmu_hsi2_ufs_embd_user_p) = { "oscclk", "dout_clkcmu_hsi2_ufs_embd" };
  1788	PNAME(mout_hsi2_ethernet_p) = { "fout_pll_eth", "mout_clkcmu_hsi2_ethernet_user" };
  1789	PNAME(mout_clkcmu_hsi2_ethernet_user_p) = { "oscclk", "dout_clkcmu_hsi2_ethernet" };
  1790	
  1791	static const struct samsung_mux_clock hsi2_mux_clks[] __initconst = {
> 1792		MUX(CLK_MOUT_HSI2_NOC_UFS_USER, "mout_clkcmu_hsi2_noc_ufs_user",
  1793		    mout_clkcmu_hsi2_noc_ufs_user_p, PLL_CON0_MUX_CLKCMU_HSI2_NOC_UFS_USER, 4, 1),
> 1794		MUX(CLK_MOUT_HSI2_UFS_EMBD_USER, "mout_clkcmu_hsi2_ufs_embd_user",
  1795		    mout_clkcmu_hsi2_ufs_embd_user_p, PLL_CON0_MUX_CLKCMU_HSI2_UFS_EMBD_USER, 4, 1),
> 1796		MUX(CLK_MOUT_HSI2_ETHERNET, "mout_hsi2_ethernet",
  1797		    mout_hsi2_ethernet_p, CLK_CON_MUX_MUX_CLK_HSI2_ETHERNET, 0, 1),
> 1798		MUX(CLK_MOUT_HSI2_ETHERNET_USER, "mout_clkcmu_hsi2_ethernet_user",
  1799		    mout_clkcmu_hsi2_ethernet_user_p, PLL_CON0_MUX_CLKCMU_HSI2_ETHERNET_USER, 4, 1),
  1800	};
  1801	
  1802	static const struct samsung_div_clock hsi2_div_clks[] __initconst = {
> 1803		DIV(CLK_DOUT_HSI2_ETHERNET, "dout_hsi2_ethernet",
  1804		    "mout_hsi2_ethernet", CLK_CON_DIV_DIV_CLK_HSI2_ETHERNET,
  1805		    0, 4),
> 1806		DIV(CLK_DOUT_HSI2_ETHERNET_PTP, "dout_hsi2_ethernet_ptp",
  1807		    "mout_hsi2_ethernet", CLK_CON_DIV_DIV_CLK_HSI2_ETHERNET_PTP,
  1808		    0, 4),
  1809	};
  1810	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

