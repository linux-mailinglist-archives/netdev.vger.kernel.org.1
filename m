Return-Path: <netdev+bounces-243907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A8BCAA642
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 13:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 936F330A7A06
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 12:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D272F0685;
	Sat,  6 Dec 2025 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FquEg5iE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F7A1DEFE9;
	Sat,  6 Dec 2025 12:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024857; cv=none; b=QszG9Z3xrZwQQMq8Sef+fG8Bnaw4xLhRsrNVCzY7IZhbLMy4JRQwh1rb+WDW/5JJoSgvFrPUK9eMTJP7gNmDBqeoiLopyX9/lKoPeZg3PuBv7tNjH+hppQjWmDmlt3L+JqHXK63B1E0NKrgld5UPA36Tw6G83pgKhjZVLADLijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024857; c=relaxed/simple;
	bh=YuXVO7Ked5yDTKt3UNKLXolIkM11aGqm1I2YemhKdbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIhCjdBMrp9kDtXDGWeNPGnAQ6DAhiQ7Nw/k9tgqXpJOBzqbsIdIO1xdu2wU4OiIpIckFn//IGVAYjHZTkI43zlqxaKjs9WpvEwySNQVJc4NDrosXwgEK56PBu7LNngGruSoGrjAwN0MEfkDnIR+OppdhdAx942Hdi30mxd8OtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FquEg5iE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765024855; x=1796560855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YuXVO7Ked5yDTKt3UNKLXolIkM11aGqm1I2YemhKdbc=;
  b=FquEg5iEFwRgtl7rkR3OJZxMVDQ73G6xYv+/mlnCtrwQU5paWdIqT/AE
   sSQ00Kj86DBstTI4BRdc026vOg8Ezs5prKFgG99lf92+X5eyyadS7ihm/
   31Uv+kuupwa+XyuLQqnelMUjZqlltj9zSX1AdkigxXPhJIAvu/JvAEPv2
   wINEgWU+O4PXwBwAYA/Cv3yO39E3JT04q6nXolbAzk4Ln6KaPCazEEabl
   gXCeISiwYnisE+ciix5Cqg/pxoOGzaTwmWPY/367XiYhTWCGEryBTzOZh
   HwWGuR+FOQK/PHYc28s5PNiz87Ms+paI4va4c1GPVNTuBkbbePxj65pch
   w==;
X-CSE-ConnectionGUID: LR9Yba77Sxmc/y2FBp5FJg==
X-CSE-MsgGUID: hHPwGwaDTWeb+401Xk81yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="67117945"
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="67117945"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 04:40:55 -0800
X-CSE-ConnectionGUID: zsg/6LOTRWaLTrir+ToD2Q==
X-CSE-MsgGUID: 04Ua61wGRsSmx2BGJRbXFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="199967263"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Dec 2025 04:40:52 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRrak-00000000IAf-10L7;
	Sat, 06 Dec 2025 12:40:50 +0000
Date: Sat, 6 Dec 2025 20:39:52 +0800
From: kernel test robot <lkp@intel.com>
To: Vimlesh Kumar <vimleshk@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sedara@marvell.com, srasheed@marvell.com,
	hgani@marvell.com, Vimlesh Kumar <vimleshk@marvell.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] octeon_ep: reset firmware ready status
Message-ID: <202512062026.fpQ6NHC3-lkp@intel.com>
References: <20251205091045.1655157-1-vimleshk@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205091045.1655157-1-vimleshk@marvell.com>

Hi Vimlesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vimlesh-Kumar/octeon_ep-reset-firmware-ready-status/20251205-172517
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251205091045.1655157-1-vimleshk%40marvell.com
patch subject: [PATCH net-next v2] octeon_ep: reset firmware ready status
config: loongarch-randconfig-002-20251206 (https://download.01.org/0day-ci/archive/20251206/202512062026.fpQ6NHC3-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251206/202512062026.fpQ6NHC3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512062026.fpQ6NHC3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c:14:
   drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c: In function 'octep_soft_reset_cn93_pf':
>> drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h:393:55: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     393 |                                                       FIELD_PREP(CN9K_PEM_GENMASK, pem)\
         |                                                       ^~~~~~~~~~
   drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c:648:34: note: in expansion of macro 'CN9K_PEMX_PFX_CSX_PFCFGX'
     648 |         OCTEP_PCI_WIN_WRITE(oct, CN9K_PEMX_PFX_CSX_PFCFGX(0, 0, CN9K_PCIEEP_VSECST_CTL),
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +393 drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h

   388	
   389	#define CN9K_PEM_GENMASK BIT_ULL(36)
   390	#define CN9K_PF_GENMASK GENMASK_ULL(21, 18)
   391	#define PFX_CSX_PFCFGX_SHADOW_BIT BIT_ULL(16)
   392	#define CN9K_PEMX_PFX_CSX_PFCFGX(pem, pf, offset)   ((0x8e0000008000 | (uint64_t)\
 > 393							      FIELD_PREP(CN9K_PEM_GENMASK, pem)\
   394							      | FIELD_PREP(CN9K_PF_GENMASK, pf)\
   395							      | (PFX_CSX_PFCFGX_SHADOW_BIT & (offset))\
   396							      | (rounddown((offset), 8)))\
   397							      + ((offset) & BIT_ULL(2)))
   398	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

