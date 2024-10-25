Return-Path: <netdev+bounces-139140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7A99B05F4
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715EE1F24094
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF24C2022EC;
	Fri, 25 Oct 2024 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dg343Y6e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65009208209;
	Fri, 25 Oct 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867037; cv=none; b=MimnByb9hS2SdpXiDUX3jo9i8h747UIi8fH0ASCbT89nVCYo4JZRWNVZxtDznr27VTnfzGUME6A/2ICP2CJR17ywNGtCiILt4CZboswT3/+OKtYOvXxXh1kL0W2Jxucah+iAcp1cAtDLLIjdu4HQoLl+8nZdy4HEatCuS4xlQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867037; c=relaxed/simple;
	bh=wBK4Q5W4WJLNTzG1NF53EifkW/90VdiVn34zzoNQPnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dON2+p0JsM6nqgUcrUr6qR/ArIhdVH4dtJuM9n0VS9B4MTrNK0d6puGsIpsqd3cFfHWhKCeTnBpYewpXylA/TbpqCbeGuoa9PFTzhf98L6PsWy2L8G3Slsqa4Wqs8wwe7/b/QJvAAKgHC+s4zUiVGhdFH+vJipb5wKm6xA9ISMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dg343Y6e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729867036; x=1761403036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wBK4Q5W4WJLNTzG1NF53EifkW/90VdiVn34zzoNQPnk=;
  b=Dg343Y6euu8mjixSyTgQTSyUsqCSeTHPn/7jlX63pc/O3qlqfI70HGPq
   czfZkBlrkApL1mc5mrXmFiJWtHBjPhgl9cQ3wgym8Icf+6pubNvvK4SKC
   EMoZg4hD44bWnrYDMB4k1zxtZbJXSSJgFSe/nBTHKkfAw+Noq34NeroRd
   FYVay/CC2ZgZURxSY93GfemsQla2ravVhE1WNFZ8ad/ZG3ecNSPzKD4il
   afWm4ia89sgl1X+yro7of0mfWgU/4b+fm+rqwWUE3IbsArhS5KJCTcDnn
   lhYFVIyZGhrvSlucRcJExUh8WHrIgLiNPGV8sPQosTUPdTPH15GPq2zYi
   w==;
X-CSE-ConnectionGUID: B4dbT5qhQByChspypDIUTg==
X-CSE-MsgGUID: +TCKNrpNSgu1q5b/bohMgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="47021762"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="47021762"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:37:15 -0700
X-CSE-ConnectionGUID: bCV38PoTTeCmNINXGqmYRA==
X-CSE-MsgGUID: j5RovBWzSgW+deRdUluG6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85699443"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Oct 2024 07:37:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4LR4-000YMs-0J;
	Fri, 25 Oct 2024 14:37:06 +0000
Date: Fri, 25 Oct 2024 22:36:15 +0800
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
Message-ID: <202410252215.79396yyg-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on sophgo/for-next sophgo/fixes net-next/main net/main linus/master v6.12-rc4 next-20241025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-net-snps-dwmac-Add-dwmac-5-30a-version/20241025-091315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241025011000.244350-5-inochiama%40gmail.com
patch subject: [PATCH v2 4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20241025/202410252215.79396yyg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410252215.79396yyg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410252215.79396yyg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c: In function 'sophgo_dwmac_fix_mac_speed':
   drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:30:16: error: implicit declaration of function 'rgmii_clock' [-Werror=implicit-function-declaration]
      30 |         rate = rgmii_clock(speed);
         |                ^~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c: In function 'sophgo_sg2044_dwmac_init':
   drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:46:13: warning: unused variable 'ret' [-Wunused-variable]
      46 |         int ret;
         |             ^~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c: In function 'sophgo_dwmac_fix_mac_speed':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:31:12: warning: 'ret' is used uninitialized [-Wuninitialized]
      31 |         if (ret < 0) {
         |            ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c:28:13: note: 'ret' was declared here
      28 |         int ret;
         |             ^~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=n] || GCC_PLUGINS [=y]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [y]:
   - RESOURCE_KUNIT_TEST [=y] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]


vim +/ret +31 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

    23	
    24	static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed, unsigned int mode)
    25	{
    26		struct sophgo_dwmac *dwmac = priv;
    27		long rate;
    28		int ret;
    29	
    30		rate = rgmii_clock(speed);
  > 31		if (ret < 0) {
    32			dev_err(dwmac->dev, "invalid speed %u\n", speed);
    33			return;
    34		}
    35	
    36		ret = clk_set_rate(dwmac->clk_tx, rate);
    37		if (ret)
    38			dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
    39	}
    40	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

