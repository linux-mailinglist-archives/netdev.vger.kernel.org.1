Return-Path: <netdev+bounces-139165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844CE9B08D2
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E251F27BA5
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87215ADAB;
	Fri, 25 Oct 2024 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atUaxLq2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409721A4B8;
	Fri, 25 Oct 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871301; cv=none; b=nth8sr7gq/SuhWM8YX3wADvKrwY58HOdLTf5t+YU6tWjoDTxOQv7I/8O7K19Kzmm8m7po556GtM5G43659wOIANO/fnMqP7s/cXRuCxJyOvv0xS6vsiUYasSQCQi8xlspI/GaF0fssZJkjufAHZamDVrRCzkq8f8xJuh5R11eNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871301; c=relaxed/simple;
	bh=pYHHIJNTG01AQgTmBwG9U5BsfqO8HYoXVzbsu2Ldj1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dej07h6ZVGrCfBWNLlTfPtZZpJYcP98K129GtWZZ/0OYjAYmn5Ith2AA+APHKvFk+XftBenbxLSCx8+l9g+6t0BMLNXYSoz7EHtyXXmngrKxiQNuX390rgastdN2JjdoJJ6dmGcY3jb89Zj/+V3WFeUyIPxWdRyy0oQpo2jckoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atUaxLq2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729871299; x=1761407299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pYHHIJNTG01AQgTmBwG9U5BsfqO8HYoXVzbsu2Ldj1Y=;
  b=atUaxLq2g4YKKd1vowsHVR3mhFSQ8GooeBFr3qjZAa3fzV4UPVpAv8NT
   Aa7MV4Al1BuwTwiHl1Q10w9vR3+Nlvoks74MSKgyZNw6covAtPXWjH6hc
   eNn100rpFY/apH9FLzZKVHQFpZIcmshFj3kr1T1zkMSEV/v+qzUE7qoiN
   vUCoWS/z77Z2bNaMCKN4BCoJxmkOIQKifFWqtIbNGF/GNaAdU2smhREnI
   UowSimO+bL7fsEyEg6GQ4jB00Qo2Tpga+qpm/M59DfAShHUcLcx4vsbFJ
   /2qseHNudOO44jFYZi/ElI2TuJFu/Lbki5/d9fx8x0VRH9iWlQ0Lq3cKA
   w==;
X-CSE-ConnectionGUID: ntTYvcvFR7W26evvACJaZA==
X-CSE-MsgGUID: k2RwiHT9TeO1yphmmukXMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="28996538"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="28996538"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 08:48:18 -0700
X-CSE-ConnectionGUID: 6O3g3ryfTOyp22Ft1rrElQ==
X-CSE-MsgGUID: TeHm3+K9ReK+WrkH/5guHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80865917"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 25 Oct 2024 08:48:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4MXp-000YQm-1F;
	Fri, 25 Oct 2024 15:48:09 +0000
Date: Fri, 25 Oct 2024 23:48:04 +0800
From: kernel test robot <lkp@intel.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Message-ID: <202410252357.pCyOX2bg-lkp@intel.com>
References: <20241025011000.244350-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025011000.244350-5-inochiama@gmail.com>

Hi Inochi,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on sophgo/for-next sophgo/fixes net-next/main net/main linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-net-snps-dwmac-Add-dwmac-5-30a-version/20241025-091315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241025011000.244350-5-inochiama%40gmail.com
patch subject: [PATCH v2 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241025/202410252357.pCyOX2bg-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410252357.pCyOX2bg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410252357.pCyOX2bg-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c: In function 'sophgo_dwmac_fix_mac_speed':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:30:16: error: implicit declaration of function 'rgmii_clock' [-Wimplicit-function-declaration]
      30 |         rate = rgmii_clock(speed);
         |                ^~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c: In function 'sophgo_sg2044_dwmac_init':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:46:13: warning: unused variable 'ret' [-Wunused-variable]
      46 |         int ret;
         |             ^~~


vim +/rgmii_clock +30 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

    23	
    24	static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
    25	{
    26		struct sophgo_dwmac *dwmac = priv;
    27		long rate;
    28		int ret;
    29	
  > 30		rate = rgmii_clock(speed);
    31		if (ret < 0) {
    32			dev_err(dwmac->dev, "invalid speed %u\n", speed);
    33			return;
    34		}
    35	
    36		ret = clk_set_rate(dwmac->clk_tx, rate);
    37		if (ret)
    38			dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
    39	}
    40	
    41	static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
    42					    struct plat_stmmacenet_data *plat_dat,
    43					    struct stmmac_resources *stmmac_res)
    44	{
    45		struct sophgo_dwmac *dwmac;
  > 46		int ret;
    47	
    48		dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
    49		if (!dwmac)
    50			return -ENOMEM;
    51	
    52		dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
    53		if (IS_ERR(dwmac->clk_tx))
    54			return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
    55					     "failed to get tx clock\n");
    56	
    57		dwmac->dev = &pdev->dev;
    58		plat_dat->bsp_priv = dwmac;
    59		plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
    60		plat_dat->fix_mac_speed = sophgo_dwmac_fix_mac_speed;
    61		plat_dat->multicast_filter_bins = 0;
    62		plat_dat->unicast_filter_entries = 1;
    63	
    64		return 0;
    65	}
    66	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

