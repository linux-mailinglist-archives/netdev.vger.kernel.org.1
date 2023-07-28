Return-Path: <netdev+bounces-22350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71B276719D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4532827D6
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8592714A98;
	Fri, 28 Jul 2023 16:12:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96A14012
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 16:12:04 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5480FC
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 09:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690560721; x=1722096721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6XO8YByLW8dxE5YOqdKPTTlu9HcvmVeDjDgu9q7kPJg=;
  b=iaTMxOUgMQAKSyakY3t8dtPO+pVYZPrFtV9aWB+/sG85qIyGtF3f0MwA
   RLtWui1rREmPaNGpp03YKqhxki2YT0Pr23I3rBE04q5fBNlVdYvEShlI2
   cpE5ObcuJavFXZfQMhIYddGFTDGO0h856g/tmCppfEUEDEsMyCJvoiLuV
   M6ASlIwgi9vD/SGPSP8aoIdjKEdGBzRrhhpXISLidxapWENyVW7BeCTT5
   tipo8nQ53ckDSqHEPmdMOJwjF9/mEh8Fl0h1ZMlEDPQN1O3RSboLdsFjI
   Bg9VdoatXjzPnOZ0mhWa8v/LUo2ZvMhkUk7V+fMzshv7J4DFZVld6+3RH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454984413"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="454984413"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 09:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841367149"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="841367149"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 09:08:24 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qPQ0t-0003Lv-0d;
	Fri, 28 Jul 2023 16:08:23 +0000
Date: Sat, 29 Jul 2023 00:01:51 +0800
From: kernel test robot <lkp@intel.com>
To: Shenwei Wang <shenwei.wang@nxp.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Simon Horman <simon.horman@corigine.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Wong Vee Khee <veekhee@apple.com>
Subject: Re: [PATCH v2 net 1/2] net: stmmac: add new mode parameter for
 fix_mac_speed
Message-ID: <202307282338.veVKQvK3-lkp@intel.com>
References: <20230727152503.2199550-2-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727152503.2199550-2-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Shenwei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenwei-Wang/net-stmmac-add-new-mode-parameter-for-fix_mac_speed/20230727-232922
base:   net/main
patch link:    https://lore.kernel.org/r/20230727152503.2199550-2-shenwei.wang%40nxp.com
patch subject: [PATCH v2 net 1/2] net: stmmac: add new mode parameter for fix_mac_speed
config: x86_64-randconfig-x004-20230728 (https://download.01.org/0day-ci/archive/20230728/202307282338.veVKQvK3-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307282338.veVKQvK3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307282338.veVKQvK3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c:359:22: error: incompatible function pointer types assigning to 'void (*)(void *, uint, uint)' (aka 'void (*)(void *, unsigned int, unsigned int)') from 'void (void *, unsigned int)' [-Wincompatible-function-pointer-types]
           data->fix_mac_speed = tegra_eqos_fix_speed;
                               ^ ~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c:108:28: error: incompatible function pointer types assigning to 'void (*)(void *, uint, uint)' (aka 'void (*)(void *, unsigned int, unsigned int)') from 'void (*const)(void *, unsigned int)' [-Wincompatible-function-pointer-types]
                           plat_dat->fix_mac_speed = dwmac->data->fix_mac_speed;
                                                   ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +359 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c

e6ea2d16fc615e Thierry Reding 2017-03-10  267  
a884915f4cef94 Jisheng Zhang  2020-11-09  268  static int tegra_eqos_probe(struct platform_device *pdev,
e6ea2d16fc615e Thierry Reding 2017-03-10  269  			    struct plat_stmmacenet_data *data,
e6ea2d16fc615e Thierry Reding 2017-03-10  270  			    struct stmmac_resources *res)
e6ea2d16fc615e Thierry Reding 2017-03-10  271  {
1d4605e0aff9ff Ajay Gupta     2019-12-15  272  	struct device *dev = &pdev->dev;
e6ea2d16fc615e Thierry Reding 2017-03-10  273  	struct tegra_eqos *eqos;
e6ea2d16fc615e Thierry Reding 2017-03-10  274  	int err;
e6ea2d16fc615e Thierry Reding 2017-03-10  275  
e6ea2d16fc615e Thierry Reding 2017-03-10  276  	eqos = devm_kzalloc(&pdev->dev, sizeof(*eqos), GFP_KERNEL);
a884915f4cef94 Jisheng Zhang  2020-11-09  277  	if (!eqos)
a884915f4cef94 Jisheng Zhang  2020-11-09  278  		return -ENOMEM;
e6ea2d16fc615e Thierry Reding 2017-03-10  279  
e6ea2d16fc615e Thierry Reding 2017-03-10  280  	eqos->dev = &pdev->dev;
e6ea2d16fc615e Thierry Reding 2017-03-10  281  	eqos->regs = res->addr;
e6ea2d16fc615e Thierry Reding 2017-03-10  282  
1d4605e0aff9ff Ajay Gupta     2019-12-15  283  	if (!is_of_node(dev->fwnode))
1d4605e0aff9ff Ajay Gupta     2019-12-15  284  		goto bypass_clk_reset_gpio;
1d4605e0aff9ff Ajay Gupta     2019-12-15  285  
e6ea2d16fc615e Thierry Reding 2017-03-10  286  	eqos->clk_master = devm_clk_get(&pdev->dev, "master_bus");
e6ea2d16fc615e Thierry Reding 2017-03-10  287  	if (IS_ERR(eqos->clk_master)) {
e6ea2d16fc615e Thierry Reding 2017-03-10  288  		err = PTR_ERR(eqos->clk_master);
e6ea2d16fc615e Thierry Reding 2017-03-10  289  		goto error;
e6ea2d16fc615e Thierry Reding 2017-03-10  290  	}
e6ea2d16fc615e Thierry Reding 2017-03-10  291  
e6ea2d16fc615e Thierry Reding 2017-03-10  292  	err = clk_prepare_enable(eqos->clk_master);
e6ea2d16fc615e Thierry Reding 2017-03-10  293  	if (err < 0)
e6ea2d16fc615e Thierry Reding 2017-03-10  294  		goto error;
e6ea2d16fc615e Thierry Reding 2017-03-10  295  
e6ea2d16fc615e Thierry Reding 2017-03-10  296  	eqos->clk_slave = devm_clk_get(&pdev->dev, "slave_bus");
e6ea2d16fc615e Thierry Reding 2017-03-10  297  	if (IS_ERR(eqos->clk_slave)) {
e6ea2d16fc615e Thierry Reding 2017-03-10  298  		err = PTR_ERR(eqos->clk_slave);
e6ea2d16fc615e Thierry Reding 2017-03-10  299  		goto disable_master;
e6ea2d16fc615e Thierry Reding 2017-03-10  300  	}
e6ea2d16fc615e Thierry Reding 2017-03-10  301  
e6ea2d16fc615e Thierry Reding 2017-03-10  302  	data->stmmac_clk = eqos->clk_slave;
e6ea2d16fc615e Thierry Reding 2017-03-10  303  
e6ea2d16fc615e Thierry Reding 2017-03-10  304  	err = clk_prepare_enable(eqos->clk_slave);
e6ea2d16fc615e Thierry Reding 2017-03-10  305  	if (err < 0)
e6ea2d16fc615e Thierry Reding 2017-03-10  306  		goto disable_master;
e6ea2d16fc615e Thierry Reding 2017-03-10  307  
e6ea2d16fc615e Thierry Reding 2017-03-10  308  	eqos->clk_rx = devm_clk_get(&pdev->dev, "rx");
e6ea2d16fc615e Thierry Reding 2017-03-10  309  	if (IS_ERR(eqos->clk_rx)) {
e6ea2d16fc615e Thierry Reding 2017-03-10  310  		err = PTR_ERR(eqos->clk_rx);
e6ea2d16fc615e Thierry Reding 2017-03-10  311  		goto disable_slave;
e6ea2d16fc615e Thierry Reding 2017-03-10  312  	}
e6ea2d16fc615e Thierry Reding 2017-03-10  313  
e6ea2d16fc615e Thierry Reding 2017-03-10  314  	err = clk_prepare_enable(eqos->clk_rx);
e6ea2d16fc615e Thierry Reding 2017-03-10  315  	if (err < 0)
e6ea2d16fc615e Thierry Reding 2017-03-10  316  		goto disable_slave;
e6ea2d16fc615e Thierry Reding 2017-03-10  317  
e6ea2d16fc615e Thierry Reding 2017-03-10  318  	eqos->clk_tx = devm_clk_get(&pdev->dev, "tx");
e6ea2d16fc615e Thierry Reding 2017-03-10  319  	if (IS_ERR(eqos->clk_tx)) {
e6ea2d16fc615e Thierry Reding 2017-03-10  320  		err = PTR_ERR(eqos->clk_tx);
e6ea2d16fc615e Thierry Reding 2017-03-10  321  		goto disable_rx;
e6ea2d16fc615e Thierry Reding 2017-03-10  322  	}
e6ea2d16fc615e Thierry Reding 2017-03-10  323  
e6ea2d16fc615e Thierry Reding 2017-03-10  324  	err = clk_prepare_enable(eqos->clk_tx);
e6ea2d16fc615e Thierry Reding 2017-03-10  325  	if (err < 0)
e6ea2d16fc615e Thierry Reding 2017-03-10  326  		goto disable_rx;
e6ea2d16fc615e Thierry Reding 2017-03-10  327  
e6ea2d16fc615e Thierry Reding 2017-03-10  328  	eqos->reset = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_OUT_HIGH);
e6ea2d16fc615e Thierry Reding 2017-03-10  329  	if (IS_ERR(eqos->reset)) {
e6ea2d16fc615e Thierry Reding 2017-03-10  330  		err = PTR_ERR(eqos->reset);
e6ea2d16fc615e Thierry Reding 2017-03-10  331  		goto disable_tx;
e6ea2d16fc615e Thierry Reding 2017-03-10  332  	}
e6ea2d16fc615e Thierry Reding 2017-03-10  333  
e6ea2d16fc615e Thierry Reding 2017-03-10  334  	usleep_range(2000, 4000);
e6ea2d16fc615e Thierry Reding 2017-03-10  335  	gpiod_set_value(eqos->reset, 0);
e6ea2d16fc615e Thierry Reding 2017-03-10  336  
1a981c0586c038 Thierry Reding 2019-07-26  337  	/* MDIO bus was already reset just above */
1a981c0586c038 Thierry Reding 2019-07-26  338  	data->mdio_bus_data->needs_reset = false;
1a981c0586c038 Thierry Reding 2019-07-26  339  
e6ea2d16fc615e Thierry Reding 2017-03-10  340  	eqos->rst = devm_reset_control_get(&pdev->dev, "eqos");
e6ea2d16fc615e Thierry Reding 2017-03-10  341  	if (IS_ERR(eqos->rst)) {
e6ea2d16fc615e Thierry Reding 2017-03-10  342  		err = PTR_ERR(eqos->rst);
e6ea2d16fc615e Thierry Reding 2017-03-10  343  		goto reset_phy;
e6ea2d16fc615e Thierry Reding 2017-03-10  344  	}
e6ea2d16fc615e Thierry Reding 2017-03-10  345  
e6ea2d16fc615e Thierry Reding 2017-03-10  346  	err = reset_control_assert(eqos->rst);
e6ea2d16fc615e Thierry Reding 2017-03-10  347  	if (err < 0)
e6ea2d16fc615e Thierry Reding 2017-03-10  348  		goto reset_phy;
e6ea2d16fc615e Thierry Reding 2017-03-10  349  
e6ea2d16fc615e Thierry Reding 2017-03-10  350  	usleep_range(2000, 4000);
e6ea2d16fc615e Thierry Reding 2017-03-10  351  
e6ea2d16fc615e Thierry Reding 2017-03-10  352  	err = reset_control_deassert(eqos->rst);
e6ea2d16fc615e Thierry Reding 2017-03-10  353  	if (err < 0)
e6ea2d16fc615e Thierry Reding 2017-03-10  354  		goto reset_phy;
e6ea2d16fc615e Thierry Reding 2017-03-10  355  
e6ea2d16fc615e Thierry Reding 2017-03-10  356  	usleep_range(2000, 4000);
e6ea2d16fc615e Thierry Reding 2017-03-10  357  
1d4605e0aff9ff Ajay Gupta     2019-12-15  358  bypass_clk_reset_gpio:
e6ea2d16fc615e Thierry Reding 2017-03-10 @359  	data->fix_mac_speed = tegra_eqos_fix_speed;
e6ea2d16fc615e Thierry Reding 2017-03-10  360  	data->init = tegra_eqos_init;
e6ea2d16fc615e Thierry Reding 2017-03-10  361  	data->bsp_priv = eqos;
029c1c2059e9c4 Jon Hunter     2022-07-06  362  	data->sph_disable = 1;
e6ea2d16fc615e Thierry Reding 2017-03-10  363  
e6ea2d16fc615e Thierry Reding 2017-03-10  364  	err = tegra_eqos_init(pdev, eqos);
e6ea2d16fc615e Thierry Reding 2017-03-10  365  	if (err < 0)
e6ea2d16fc615e Thierry Reding 2017-03-10  366  		goto reset;
e6ea2d16fc615e Thierry Reding 2017-03-10  367  
a884915f4cef94 Jisheng Zhang  2020-11-09  368  	return 0;
e6ea2d16fc615e Thierry Reding 2017-03-10  369  reset:
e6ea2d16fc615e Thierry Reding 2017-03-10  370  	reset_control_assert(eqos->rst);
e6ea2d16fc615e Thierry Reding 2017-03-10  371  reset_phy:
e6ea2d16fc615e Thierry Reding 2017-03-10  372  	gpiod_set_value(eqos->reset, 1);
e6ea2d16fc615e Thierry Reding 2017-03-10  373  disable_tx:
e6ea2d16fc615e Thierry Reding 2017-03-10  374  	clk_disable_unprepare(eqos->clk_tx);
e6ea2d16fc615e Thierry Reding 2017-03-10  375  disable_rx:
e6ea2d16fc615e Thierry Reding 2017-03-10  376  	clk_disable_unprepare(eqos->clk_rx);
e6ea2d16fc615e Thierry Reding 2017-03-10  377  disable_slave:
e6ea2d16fc615e Thierry Reding 2017-03-10  378  	clk_disable_unprepare(eqos->clk_slave);
e6ea2d16fc615e Thierry Reding 2017-03-10  379  disable_master:
e6ea2d16fc615e Thierry Reding 2017-03-10  380  	clk_disable_unprepare(eqos->clk_master);
e6ea2d16fc615e Thierry Reding 2017-03-10  381  error:
a884915f4cef94 Jisheng Zhang  2020-11-09  382  	return err;
e6ea2d16fc615e Thierry Reding 2017-03-10  383  }
e6ea2d16fc615e Thierry Reding 2017-03-10  384  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

