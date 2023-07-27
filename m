Return-Path: <netdev+bounces-21992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63DB7658E9
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C232817EF
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E227132;
	Thu, 27 Jul 2023 16:39:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176B27124
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 16:39:41 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824EF2D4B
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690475975; x=1722011975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h+4dCkLMPc4K9vhEve+IB/2UKNL6/ESbbvqGzEUUYbo=;
  b=J24nh/vKPWIE8gEv5TjCkgpBFDVxF4gwA1A4E6s/FrxC3/+7qkNVVc8o
   kJutQazqcGoAii/PNkm8T3rqD979smVOWLGHiM8Ky6OZlT4bUWy91hzSZ
   6dQttu+aYUVZ28lMuZ6jAI5xf9vaIW0gHIou5cA0iOLLQdypXX4kVAF2K
   9K6/xVeFI6eS2XY8fIajtqnJ7KnWwPAJgs2sep/UnC1aQnS3fYaztoWJR
   c9G6uwPTjcMUF0oxlNjxQjeWRgNluw9aFVOPTdpmdpBwd7tgScSaXQTdK
   EHbRiVZkMl/e4eXA0+ij7sJUU16tQNRvTgaxelJD2AfeX6pJCCZP6Ldsk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348643852"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="348643852"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 09:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817177974"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817177974"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 09:36:24 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qP3yP-0002Pn-0r;
	Thu, 27 Jul 2023 16:36:24 +0000
Date: Fri, 28 Jul 2023 00:35:06 +0800
From: kernel test robot <lkp@intel.com>
To: Feiyang Chen <chenfeiyang@loongson.cn>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	chenhuacai@loongson.cn
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Feiyang Chen <chenfeiyang@loongson.cn>, linux@armlinux.org.uk,
	dongbiao@loongson.cn, loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org, loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2 03/10] net: stmmac: dwmac1000: Add multi-channel
 support
Message-ID: <202307280004.UhGTxBbU-lkp@intel.com>
References: <373259d4ac9ac0b9e1e64ad96d60a9bbd35b85aa.1690439335.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <373259d4ac9ac0b9e1e64ad96d60a9bbd35b85aa.1690439335.git.chenfeiyang@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Feiyang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on linus/master v6.5-rc3]
[cannot apply to sunxi/sunxi/for-next net-next/main horms-ipvs/master next-20230727]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Feiyang-Chen/net-stmmac-Pass-stmmac_priv-and-chan-in-some-callbacks/20230727-155954
base:   net/main
patch link:    https://lore.kernel.org/r/373259d4ac9ac0b9e1e64ad96d60a9bbd35b85aa.1690439335.git.chenfeiyang%40loongson.cn
patch subject: [PATCH v2 03/10] net: stmmac: dwmac1000: Add multi-channel support
config: i386-buildonly-randconfig-r006-20230727 (https://download.01.org/0day-ci/archive/20230728/202307280004.UhGTxBbU-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307280004.UhGTxBbU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307280004.UhGTxBbU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:114:6: warning: no previous prototype for function 'dwmac1000_dma_init_channel' [-Wmissing-prototypes]
   void dwmac1000_dma_init_channel(struct stmmac_priv *priv, void __iomem *ioaddr,
        ^
   drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c:114:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dwmac1000_dma_init_channel(struct stmmac_priv *priv, void __iomem *ioaddr,
   ^
   static 
   1 warning generated.


vim +/dwmac1000_dma_init_channel +114 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c

   113	
 > 114	void dwmac1000_dma_init_channel(struct stmmac_priv *priv, void __iomem *ioaddr,
   115					struct stmmac_dma_cfg *dma_cfg,
   116					u32 chan)
   117	{
   118		u32 value;
   119		int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
   120		int rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
   121	
   122		if (!priv->plat->dwmac_is_loongson)
   123			return;
   124	
   125		/* common channel control register config */
   126		value = readl(ioaddr + DMA_BUS_MODE + chan * DMA_CHAN_OFFSET);
   127	
   128		/*
   129		 * Set the DMA PBL (Programmable Burst Length) mode.
   130		 *
   131		 * Note: before stmmac core 3.50 this mode bit was 4xPBL, and
   132		 * post 3.5 mode bit acts as 8*PBL.
   133		 */
   134		if (dma_cfg->pblx8)
   135			value |= DMA_BUS_MODE_MAXPBL;
   136		value |= DMA_BUS_MODE_USP;
   137		value &= ~(DMA_BUS_MODE_PBL_MASK | DMA_BUS_MODE_RPBL_MASK);
   138		value |= (txpbl << DMA_BUS_MODE_PBL_SHIFT);
   139		value |= (rxpbl << DMA_BUS_MODE_RPBL_SHIFT);
   140	
   141		/* Set the Fixed burst mode */
   142		if (dma_cfg->fixed_burst)
   143			value |= DMA_BUS_MODE_FB;
   144	
   145		/* Mixed Burst has no effect when fb is set */
   146		if (dma_cfg->mixed_burst)
   147			value |= DMA_BUS_MODE_MB;
   148	
   149		value |= DMA_BUS_MODE_ATDS;
   150	
   151		if (dma_cfg->aal)
   152			value |= DMA_BUS_MODE_AAL;
   153	
   154		writel(value, ioaddr + DMA_BUS_MODE + chan * DMA_CHAN_OFFSET);
   155	
   156		/* Mask interrupts by writing to CSR7 */
   157		writel(DMA_INTR_DEFAULT_MASK,
   158		       ioaddr + DMA_INTR_ENA + chan * DMA_CHAN_OFFSET);
   159	}
   160	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

