Return-Path: <netdev+bounces-139177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B913E9B0A8E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 19:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CAC1C21C5A
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84261DD0F7;
	Fri, 25 Oct 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikZDEar7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B618CC19;
	Fri, 25 Oct 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876286; cv=none; b=d4v4ViFeGD2LmAFXcH4qa4wkSUdn7vkOTHInSFKBooA28xssRx6ZE4yt/0Gs3VuvI9nf5y01EFSXyWUYjhYrLKw9FPHu3hHyQFRz1xvN6523rWJ6aLkXNL4XXnrzhNaViQ1Ot2IHVUOaziCorcRdYtFr0MBzHNGNM9iZV0oV/DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876286; c=relaxed/simple;
	bh=MYQYsh2ZM0F5hLiv9jWAnO8EjpYfnIqM2b9zMJRm42c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsBet9e/DRwbLP6uGdLvr68pRsyhRviIRxHh7k4P2gzmED2WaltvIDtJdzkrrsQZiH/yZeZ6RwK9nkA4fiTgwxEsDWsDhBDDdWEYa7kj1h22pW+NjnD1Ku+rO0UQqW0iAb80wakwNPpW6RxcG2yki994ViT9ifKbYLS8jH0VZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikZDEar7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729876285; x=1761412285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MYQYsh2ZM0F5hLiv9jWAnO8EjpYfnIqM2b9zMJRm42c=;
  b=ikZDEar7QA1SpCS2AIP+nuBrjwkz9yralhRHQzqyv+LsGdq7kUy2ksHW
   arO3xxopYCxe6dVqE8QRtMPu/XO1m9TVgzf0IRD/kK6otkJDTkuOrJuiu
   Rb2meY6Oa3iX6ebG5omcJf9JXSw83zTzage+ua1y0v+JCj5ixXbM6a5xN
   nT+BPNL00ZVYxl0U2rwmsJc+dUjK81/pvmXMTqHr4mGP+dznDYDGCnDFb
   ZJfSB3f1VGfMUU9p5zMlt8aJgAhhHXjAHLyEUAL2p2o27TBCt/NFwETD2
   4cWthQk5YfPaxuFY6iExhFFS6jojBpF2KWggCHz8HxU4KXWqrQvjpgpxa
   g==;
X-CSE-ConnectionGUID: jmUrpIBvQu2biQQoDHw49A==
X-CSE-MsgGUID: m8Wm0tluRDqljN4qtgouXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29497045"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29497045"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:11:24 -0700
X-CSE-ConnectionGUID: W8ffi6AWRIKUCKXfgRWWzw==
X-CSE-MsgGUID: jBgwIuxpQcCrOIKJrpn2Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81267315"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Oct 2024 10:11:20 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4NqH-000Yeq-1K;
	Fri, 25 Oct 2024 17:11:17 +0000
Date: Sat, 26 Oct 2024 01:10:17 +0800
From: kernel test robot <lkp@intel.com>
To: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: Re: [PATCH net-next v4 3/6] net: stmmac: Refactor FPE functions to
 generic version
Message-ID: <202410260025.sME33DwY-lkp@intel.com>
References: <cfc647f0d031517f9ec9095235a574aad9dc2c95.1729757625.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc647f0d031517f9ec9095235a574aad9dc2c95.1729757625.git.0x1207@gmail.com>

Hi Furong,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Furong-Xu/net-stmmac-Introduce-separate-files-for-FPE-implementation/20241024-163526
base:   net-next/main
patch link:    https://lore.kernel.org/r/cfc647f0d031517f9ec9095235a574aad9dc2c95.1729757625.git.0x1207%40gmail.com
patch subject: [PATCH net-next v4 3/6] net: stmmac: Refactor FPE functions to generic version
config: arm-spear13xx_defconfig (https://download.01.org/0day-ci/archive/20241026/202410260025.sME33DwY-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260025.sME33DwY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260025.sME33DwY-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.o: in function `stmmac_fpe_configure':
>> drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c:205:(.text+0x154): undefined reference to `__ffsdi2'


vim +205 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c

   191	
   192	void stmmac_fpe_configure(struct stmmac_priv *priv, u32 num_txq, u32 num_rxq,
   193				  bool tx_enable, bool pmac_enable)
   194	{
   195		struct stmmac_fpe_cfg *cfg = &priv->fpe_cfg;
   196		const struct stmmac_fpe_reg *reg = cfg->reg;
   197		void __iomem *ioaddr = priv->ioaddr;
   198		u32 value;
   199	
   200		if (tx_enable) {
   201			cfg->fpe_csr = STMMAC_MAC_FPE_CTRL_STS_EFPE;
   202			value = readl(ioaddr + reg->rxq_ctrl1_reg);
   203			value &= ~reg->fprq_mask;
   204			/* Keep this SHIFT, FIELD_PREP() expects a constant mask :-/ */
 > 205			value |= (num_rxq - 1) << __bf_shf(reg->fprq_mask);
   206			writel(value, ioaddr + reg->rxq_ctrl1_reg);
   207		} else {
   208			cfg->fpe_csr = 0;
   209		}
   210		writel(cfg->fpe_csr, ioaddr + reg->mac_fpe_reg);
   211	
   212		value = readl(ioaddr + reg->int_en_reg);
   213	
   214		if (pmac_enable) {
   215			if (!(value & reg->int_en_bit)) {
   216				/* Dummy read to clear any pending masked interrupts */
   217				readl(ioaddr + reg->mac_fpe_reg);
   218	
   219				value |= reg->int_en_bit;
   220			}
   221		} else {
   222			value &= ~reg->int_en_bit;
   223		}
   224	
   225		writel(value, ioaddr + reg->int_en_reg);
   226	}
   227	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

