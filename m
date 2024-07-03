Return-Path: <netdev+bounces-108831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9C2925D54
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417951F21C51
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866F1802CC;
	Wed,  3 Jul 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ArzpZTEI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1880617FAB8;
	Wed,  3 Jul 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005493; cv=none; b=kXumtmBtu/52Nz/6fW4CAsPaDm2YaA5U8903agG7PbrNXhbaSyVmI5AINq34qqjCIOz7ItpQTHo2DE5jE2d79ZPHn3wJe16g3tM+vmWucSBsx+6/lq+ceJENv/J5CscN2Q14loRRdbPrs6nswgh13s7EtVdapwOvB5VPQh4e8CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005493; c=relaxed/simple;
	bh=sZu3WEtVwQ9fs2ISGrtXyLLe+vIoesZ01sKD9VWZu5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hozqe0nsfKMW/sNeBT/FW6XdsOWrgYCgWslycoyAymX3bwYP0G549L65wrbwoRAzzpZlKz5kan1qRafr86xRf1JCJenN0CBv2pS4uN8GXamYqYB4j7yZnEkVxoaYbZMCl2M7mtBbCaMp6D0M3sdoQQuBjY7DvqPVA4XwnjOWY+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ArzpZTEI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720005492; x=1751541492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sZu3WEtVwQ9fs2ISGrtXyLLe+vIoesZ01sKD9VWZu5o=;
  b=ArzpZTEI9kNo43GuhEun31bSzHsIt56FZAcUYbSTuPVr4bYZhkgt1UuI
   c5x+C5sh7OR7ocpe2lNeO826lzGGQ8Npql4bJ5NOaXgc62La7oIIjN2B/
   MHv0pGI7RHYNWFsHailYIAyFiYe3YyctWKzj9yJA5IjS4wkNyqxMl2JHO
   deq9a8HLd6CkNvhxKxgKn5AHG/DqmUnqI/OsyZ5mgvbmVF+qYlENnxHOH
   Qf6c7rfLa6S+iDL4uaWTJ8U31xQp0WtVvKmjy6pwlQ93dodzuKMdehFuj
   8B+XH42Ah9WzxWSkzA9G1ZEpfqHxF2XF75Ik2box8+1lCeVq/Bk0B4tVk
   Q==;
X-CSE-ConnectionGUID: upSXtZFYT5i2iBr4f8oE5w==
X-CSE-MsgGUID: Jinl/rb5RgeN6EjsLktJAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="34677381"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="34677381"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 04:18:12 -0700
X-CSE-ConnectionGUID: XrOeSyk8TZy62vYVf9OUPw==
X-CSE-MsgGUID: fltt//wxQBiTuWRISZn2XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51411818"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Jul 2024 04:18:06 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sOxzv-000PeM-1b;
	Wed, 03 Jul 2024 11:18:03 +0000
Date: Wed, 3 Jul 2024 19:17:25 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, nbd@nbd.name,
	lorenzo.bianconi83@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor@kernel.org, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
	horms@kernel.org
Subject: Re: [PATCH v4 2/2] net: airoha: Introduce ethernet support for
 EN7581 SoC
Message-ID: <202407031841.Ww5ZFVKk-lkp@intel.com>
References: <56f57f37b80796e9706555503e5b4cf194f69479.1719672695.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56f57f37b80796e9706555503e5b4cf194f69479.1719672695.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.10-rc6]
[cannot apply to horms-ipvs/master next-20240703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-net-airoha-Add-EN7581-ethernet-controller/20240630-185836
base:   net/main
patch link:    https://lore.kernel.org/r/56f57f37b80796e9706555503e5b4cf194f69479.1719672695.git.lorenzo%40kernel.org
patch subject: [PATCH v4 2/2] net: airoha: Introduce ethernet support for EN7581 SoC
config: arm-randconfig-r123-20240703 (https://download.01.org/0day-ci/archive/20240703/202407031841.Ww5ZFVKk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240703/202407031841.Ww5ZFVKk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407031841.Ww5ZFVKk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mediatek/airoha_eth.c:848:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct airoha_eth *eth @@
   drivers/net/ethernet/mediatek/airoha_eth.c:848:19: sparse:     expected void [noderef] __iomem *base
   drivers/net/ethernet/mediatek/airoha_eth.c:848:19: sparse:     got struct airoha_eth *eth
   drivers/net/ethernet/mediatek/airoha_eth.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +848 drivers/net/ethernet/mediatek/airoha_eth.c

   809	
   810	#define airoha_fe_rr(eth, offset)				\
   811		airoha_rr((eth)->fe_regs, (offset))
   812	#define airoha_fe_wr(eth, offset, val)				\
   813		airoha_wr((eth)->fe_regs, (offset), (val))
   814	#define airoha_fe_rmw(eth, offset, mask, val)			\
   815		airoha_rmw((eth)->fe_regs, (offset), (mask), (val))
   816	#define airoha_fe_set(eth, offset, val)				\
   817		airoha_rmw((eth)->fe_regs, (offset), 0, (val))
   818	#define airoha_fe_clear(eth, offset, val)			\
   819		airoha_rmw((eth)->fe_regs, (offset), (val), 0)
   820	
   821	#define airoha_qdma_rr(eth, offset)				\
   822		airoha_rr((eth)->qdma_regs, (offset))
   823	#define airoha_qdma_wr(eth, offset, val)			\
   824		airoha_wr((eth)->qdma_regs, (offset), (val))
   825	#define airoha_qdma_rmw(eth, offset, mask, val)			\
   826		airoha_rmw((eth)->qdma_regs, (offset), (mask), (val))
   827	#define airoha_qdma_set(eth, offset, val)			\
   828		airoha_rmw((eth)->qdma_regs, (offset), 0, (val))
   829	#define airoha_qdma_clear(eth, offset, val)			\
   830		airoha_rmw((eth)->qdma_regs, (offset), (val), 0)
   831	
   832	static void airoha_qdma_set_irqmask(struct airoha_eth *eth, int index,
   833					    u32 clear, u32 set)
   834	{
   835		unsigned long flags;
   836	
   837		if (WARN_ON_ONCE(index >= ARRAY_SIZE(eth->irqmask)))
   838			return;
   839	
   840		spin_lock_irqsave(&eth->irq_lock, flags);
   841	
   842		eth->irqmask[index] &= ~clear;
   843		eth->irqmask[index] |= set;
   844		airoha_qdma_wr(eth, REG_INT_ENABLE(index), eth->irqmask[index]);
   845		/* Read irq_enable register in order to guarantee the update above
   846		 * completes in the spinlock critical section.
   847		 */
 > 848		airoha_rr(eth, REG_INT_ENABLE(index));
   849	
   850		spin_unlock_irqrestore(&eth->irq_lock, flags);
   851	}
   852	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

