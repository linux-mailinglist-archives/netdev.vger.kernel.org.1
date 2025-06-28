Return-Path: <netdev+bounces-202197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE54AECA4C
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 22:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6647D189F306
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809B221566;
	Sat, 28 Jun 2025 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DG5Ojzwa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C71A257D;
	Sat, 28 Jun 2025 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751142671; cv=none; b=SHrlGhFzn3tuVO4t2rp2cu6tuUxfPGPZ3AlOprQPytKjCP6FBCB/+fFxgQikRBhUGUi2Kjp2q4nPkIE41rOMJUSZphEEJYwH2fqHu8PdEMGBTwriXSwn0wwmFezgF76aY3Anxe+FaVixq5+oLk8az3BRVtbFZhmdZEzT9K6PpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751142671; c=relaxed/simple;
	bh=jj3Wf8/p/EcjaNqLJXtMs6VmzdJXUP1vBHIwniCxulE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0JmpmaqTowd/jO25WJOtFriD4k1hfaP9eHW3D22VMC1bBu2OEBt27sRB+453BArBMY1PHrgu11MK9tfeevsr9BgjYo8qe5rQP1H3IaLmrJGKmHxIF2Un7FbAI6VCGdfoiYs1HA4Np1AxX/KmTiM219rfURCFhP9jUhOeI2/dZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DG5Ojzwa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751142669; x=1782678669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jj3Wf8/p/EcjaNqLJXtMs6VmzdJXUP1vBHIwniCxulE=;
  b=DG5OjzwasmHjmSDVwQkRAc3+BnOViC+lsv0XZ+zLpKhPTk1WoQFVFvFW
   chYVgQFWNlLEMtIxiJVVQ5uE/l/hyM4RE13PnTGmlPsG7FSAipW7SzsYi
   Rh2ksPHz1CBRwebTDMdILdCAmg6PbZgo1hD56T+cfRyJDMqTCa04Bys6E
   ot5VYeqLsACWCr+iBDmDugFWDu+nUnE9mm8IVHs565asQzpB3PMhLCpvN
   sdZwbC+aBARSAH1nYg5efr4QXsNH2sznHPyQUxnKkruL0E+oudLZHND/F
   Gz6F2N7zMxka7fR3Tn2KuXmeNYZ09WFqgARb07p1cMCf1Mfb0iZlVLyiG
   A==;
X-CSE-ConnectionGUID: EOEpBwtPQxOxmvkWIXCfAA==
X-CSE-MsgGUID: Cl0jraXBQ7ySGv0s6CXIdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="64110343"
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="64110343"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 13:31:08 -0700
X-CSE-ConnectionGUID: 74A3WXuHTc+lcVO1G28YbQ==
X-CSE-MsgGUID: rxJqBR8CQH2Fhq95SW+GlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="153265867"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Jun 2025 13:31:03 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVcCT-000XMc-1c;
	Sat, 28 Jun 2025 20:31:01 +0000
Date: Sun, 29 Jun 2025 04:30:38 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net/next 3/3] net: ethernet: mtk_eth_soc: use genpool
 allocator for SRAM
Message-ID: <202506290403.FwUOUzZq-lkp@intel.com>
References: <566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on next-20250627]
[cannot apply to net/main linus/master v6.16-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-ethernet-mtk_eth_soc-improve-support-for-named-interrupts/20250628-093324
base:   net-next/main
patch link:    https://lore.kernel.org/r/566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel%40makrotopia.org
patch subject: [PATCH net/next 3/3] net: ethernet: mtk_eth_soc: use genpool allocator for SRAM
config: arm-randconfig-003-20250629 (https://download.01.org/0day-ci/archive/20250629/202506290403.FwUOUzZq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250629/202506290403.FwUOUzZq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506290403.FwUOUzZq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_dma_ring_alloc':
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1282:10: warning: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
      return -ENOMEM;
             ^


vim +1282 drivers/net/ethernet/mediatek/mtk_eth_soc.c

  1275	
  1276	static void *mtk_dma_ring_alloc(struct mtk_eth *eth, size_t size,
  1277					dma_addr_t *dma_handle)
  1278	{
  1279		void *dma_ring;
  1280	
  1281		if (WARN_ON(mtk_use_legacy_sram(eth)))
> 1282			return -ENOMEM;
  1283	
  1284		if (eth->sram_pool) {
  1285			dma_ring = (void *)gen_pool_alloc(eth->sram_pool, size);
  1286			if (!dma_ring)
  1287				return dma_ring;
  1288			*dma_handle = gen_pool_virt_to_phys(eth->sram_pool, (unsigned long)dma_ring);
  1289		} else {
  1290			dma_ring = dma_alloc_coherent(eth->dma_dev, size, dma_handle,
  1291						      GFP_KERNEL);
  1292		}
  1293	
  1294		return dma_ring;
  1295	}
  1296	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

