Return-Path: <netdev+bounces-21099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92146762743
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3931C20F58
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD39427704;
	Tue, 25 Jul 2023 23:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD7275D4
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:24:47 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38E19AD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690327486; x=1721863486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p47ozaRPxRfd7xjJ3KOYaPYCsYx6E4f8EMoQSRJfMcM=;
  b=gpI0helsL/eMiZKHryIUaGZajpB1bAmnE1tLest3LbDIc4VyA8FE2Hxx
   WOoivF4i/fxu3ySfPdHnlYXYiCSPMlOShnJ9LcQCK4zzod0TNH1ObXXSo
   bu/hDTZisDtjuR0Ez4ltQd2BYx21wjRAXpQhSJBei4H/WNJJl0cHj/a16
   lAuFBP2VcJPhwJFgXFFKB3Ht4gr0dz4WWtzY0B5ki0DRtu5Sb+BNbLhRC
   IbQ6Akocl0bJ5sFLhjbwRxlWDA1nsIN1ZxX00i/5uyAOLhbkLxTJC9OkA
   SpVMbM3nPIp1U1uDqQwn7m/7H6No5b3hT93qW55DzTcGlgUjI0MpqK+fy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="371476291"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="371476291"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 16:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="726271867"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="726271867"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 25 Jul 2023 16:24:40 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qOROQ-0000QR-0C;
	Tue, 25 Jul 2023 23:24:38 +0000
Date: Wed, 26 Jul 2023 07:23:44 +0800
From: kernel test robot <lkp@intel.com>
To: Shenwei Wang <shenwei.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Shenwei Wang <shenwei.wang@nxp.com>, Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
Message-ID: <202307260736.EE13gy3b-lkp@intel.com>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725194931.1989102-1-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Shenwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on net-next/main net/main linus/master v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenwei-Wang/net-stmmac-dwmac-imx-pause-the-TXC-clock-in-fixed-link/20230726-035218
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20230725194931.1989102-1-shenwei.wang%40nxp.com
patch subject: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230726/202307260736.EE13gy3b-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260736.EE13gy3b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260736.EE13gy3b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c: In function 'imx_dwmac_fix_speed_mx93':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c:240:38: warning: variable 'plat_dat' set but not used [-Wunused-but-set-variable]
     240 |         struct plat_stmmacenet_data *plat_dat;
         |                                      ^~~~~~~~


vim +/plat_dat +240 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c

   237	
   238	static void imx_dwmac_fix_speed_mx93(void *priv, unsigned int speed)
   239	{
 > 240		struct plat_stmmacenet_data *plat_dat;
   241		struct imx_priv_data *dwmac = priv;
   242		int val, ctrl, old_ctrl;
   243	
   244		imx_dwmac_fix_speed(priv, speed);
   245	
   246		old_ctrl = readl(dwmac->base_addr + MAC_CTRL_REG);
   247		plat_dat = dwmac->plat_dat;
   248		ctrl = old_ctrl & ~CTRL_SPEED_MASK;
   249	
   250		/* by default ctrl will be SPEED_1000 */
   251		if (speed == SPEED_100)
   252			ctrl |= RMII_RESET_SPEED;
   253		if (speed == SPEED_10)
   254			ctrl |= TEN_BASET_RESET_SPEED;
   255	
   256		if (imx_dwmac_is_fixed_link(dwmac)) {
   257			writel(ctrl, dwmac->base_addr + MAC_CTRL_REG);
   258	
   259			/* Ensure the settings for CTRL are applied */
   260			wmb();
   261	
   262			val = MX93_GPR_ENET_QOS_INTF_SEL_RGMII;
   263			regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
   264					   MX93_GPR_ENET_QOS_INTF_MODE_MASK, val);
   265			usleep_range(50, 100);
   266			val = MX93_GPR_ENET_QOS_INTF_SEL_RGMII | MX93_GPR_ENET_QOS_CLK_GEN_EN;
   267			regmap_update_bits(dwmac->intf_regmap, dwmac->intf_reg_off,
   268					   MX93_GPR_ENET_QOS_INTF_MODE_MASK, val);
   269	
   270			writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG);
   271		}
   272	}
   273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

