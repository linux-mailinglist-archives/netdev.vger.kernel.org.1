Return-Path: <netdev+bounces-22443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A858767868
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E07F1C2098F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BDF1FB39;
	Fri, 28 Jul 2023 22:15:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86401FB36
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 22:15:41 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E75448A
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690582539; x=1722118539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dkxWn9zA6NEMUYhLOvzMdteEPBXCCjOX+NYgb6juRSo=;
  b=IARazrakSzOcmCIRgeTzuc7HmSDSQ57yZ0yuupV7QbF3VS+tpnt63TqB
   21Yh8C/Q/YCfHo2fc1qybcs/P6fsLUjjShxpoD7gaoynLivknCMrZNmuZ
   snzzggyk5i9uBj44Bho8vWFdWIocWUPjNzi2tgonffEG8Wg25q35AFeQX
   +sfoifF2myFXqz2DK59kho1uBGxT5bbVe5Eqz5lOBcNVEqfAhg3DO6j7+
   ayywhQY3FJtDplI9swbPm5Ur0676/WT74yIcyuGdmeWZOUJTQJw+xYUKd
   5gc07PD8jiV/YpP0/+WgnR8frsJiIJ36u8XXSDCctZ1xaNEGTGoPCyjjq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="353601748"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="353601748"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 15:15:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="721411763"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="721411763"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 Jul 2023 15:15:31 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qPVkA-0003cR-1V;
	Fri, 28 Jul 2023 22:15:30 +0000
Date: Sat, 29 Jul 2023 06:14:31 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
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
Message-ID: <202307290635.TOWvHdhK-lkp@intel.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Shenwei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenwei-Wang/net-stmmac-add-new-mode-parameter-for-fix_mac_speed/20230727-232922
base:   net/main
patch link:    https://lore.kernel.org/r/20230727152503.2199550-2-shenwei.wang%40nxp.com
patch subject: [PATCH v2 net 1/2] net: stmmac: add new mode parameter for fix_mac_speed
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230729/202307290635.TOWvHdhK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290635.TOWvHdhK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290635.TOWvHdhK-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c: In function 'starfive_dwmac_probe':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c:132:41: error: assignment to 'void (*)(void *, uint,  uint)' {aka 'void (*)(void *, unsigned int,  unsigned int)'} from incompatible pointer type 'void (*)(void *, unsigned int)' [-Werror=incompatible-pointer-types]
     132 |                 plat_dat->fix_mac_speed = starfive_dwmac_fix_mac_speed;
         |                                         ^
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c: In function 'sti_dwmac_probe':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c:296:33: error: assignment to 'void (*)(void *, uint,  uint)' {aka 'void (*)(void *, unsigned int,  unsigned int)'} from incompatible pointer type 'void (*)(void *, unsigned int)' [-Werror=incompatible-pointer-types]
     296 |         plat_dat->fix_mac_speed = data->fix_retime_src;
         |                                 ^
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c: In function 'tegra_eqos_probe':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c:359:29: error: assignment to 'void (*)(void *, uint,  uint)' {aka 'void (*)(void *, unsigned int,  unsigned int)'} from incompatible pointer type 'void (*)(void *, unsigned int)' [-Werror=incompatible-pointer-types]
     359 |         data->fix_mac_speed = tegra_eqos_fix_speed;
         |                             ^
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c: In function 'intel_eth_plat_probe':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c:108:49: error: assignment to 'void (*)(void *, uint,  uint)' {aka 'void (*)(void *, unsigned int,  unsigned int)'} from incompatible pointer type 'void (*)(void *, unsigned int)' [-Werror=incompatible-pointer-types]
     108 |                         plat_dat->fix_mac_speed = dwmac->data->fix_mac_speed;
         |                                                 ^
   cc1: some warnings being treated as errors


vim +132 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c

b4a5afa51ceeca Samin Guo 2023-04-17   92  
4bd3bb7b452690 Samin Guo 2023-04-17   93  static int starfive_dwmac_probe(struct platform_device *pdev)
4bd3bb7b452690 Samin Guo 2023-04-17   94  {
4bd3bb7b452690 Samin Guo 2023-04-17   95  	struct plat_stmmacenet_data *plat_dat;
4bd3bb7b452690 Samin Guo 2023-04-17   96  	struct stmmac_resources stmmac_res;
4bd3bb7b452690 Samin Guo 2023-04-17   97  	struct starfive_dwmac *dwmac;
4bd3bb7b452690 Samin Guo 2023-04-17   98  	struct clk *clk_gtx;
4bd3bb7b452690 Samin Guo 2023-04-17   99  	int err;
4bd3bb7b452690 Samin Guo 2023-04-17  100  
4bd3bb7b452690 Samin Guo 2023-04-17  101  	err = stmmac_get_platform_resources(pdev, &stmmac_res);
4bd3bb7b452690 Samin Guo 2023-04-17  102  	if (err)
4bd3bb7b452690 Samin Guo 2023-04-17  103  		return dev_err_probe(&pdev->dev, err,
4bd3bb7b452690 Samin Guo 2023-04-17  104  				     "failed to get resources\n");
4bd3bb7b452690 Samin Guo 2023-04-17  105  
4bd3bb7b452690 Samin Guo 2023-04-17  106  	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
4bd3bb7b452690 Samin Guo 2023-04-17  107  	if (IS_ERR(plat_dat))
4bd3bb7b452690 Samin Guo 2023-04-17  108  		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
4bd3bb7b452690 Samin Guo 2023-04-17  109  				     "dt configuration failed\n");
4bd3bb7b452690 Samin Guo 2023-04-17  110  
4bd3bb7b452690 Samin Guo 2023-04-17  111  	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
4bd3bb7b452690 Samin Guo 2023-04-17  112  	if (!dwmac)
4bd3bb7b452690 Samin Guo 2023-04-17  113  		return -ENOMEM;
4bd3bb7b452690 Samin Guo 2023-04-17  114  
4bd3bb7b452690 Samin Guo 2023-04-17  115  	dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
4bd3bb7b452690 Samin Guo 2023-04-17  116  	if (IS_ERR(dwmac->clk_tx))
4bd3bb7b452690 Samin Guo 2023-04-17  117  		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
4bd3bb7b452690 Samin Guo 2023-04-17  118  				     "error getting tx clock\n");
4bd3bb7b452690 Samin Guo 2023-04-17  119  
4bd3bb7b452690 Samin Guo 2023-04-17  120  	clk_gtx = devm_clk_get_enabled(&pdev->dev, "gtx");
4bd3bb7b452690 Samin Guo 2023-04-17  121  	if (IS_ERR(clk_gtx))
4bd3bb7b452690 Samin Guo 2023-04-17  122  		return dev_err_probe(&pdev->dev, PTR_ERR(clk_gtx),
4bd3bb7b452690 Samin Guo 2023-04-17  123  				     "error getting gtx clock\n");
4bd3bb7b452690 Samin Guo 2023-04-17  124  
4bd3bb7b452690 Samin Guo 2023-04-17  125  	/* Generally, the rgmii_tx clock is provided by the internal clock,
4bd3bb7b452690 Samin Guo 2023-04-17  126  	 * which needs to match the corresponding clock frequency according
4bd3bb7b452690 Samin Guo 2023-04-17  127  	 * to different speeds. If the rgmii_tx clock is provided by the
4bd3bb7b452690 Samin Guo 2023-04-17  128  	 * external rgmii_rxin, there is no need to configure the clock
4bd3bb7b452690 Samin Guo 2023-04-17  129  	 * internally, because rgmii_rxin will be adaptively adjusted.
4bd3bb7b452690 Samin Guo 2023-04-17  130  	 */
4bd3bb7b452690 Samin Guo 2023-04-17  131  	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk"))
4bd3bb7b452690 Samin Guo 2023-04-17 @132  		plat_dat->fix_mac_speed = starfive_dwmac_fix_mac_speed;
4bd3bb7b452690 Samin Guo 2023-04-17  133  
4bd3bb7b452690 Samin Guo 2023-04-17  134  	dwmac->dev = &pdev->dev;
4bd3bb7b452690 Samin Guo 2023-04-17  135  	plat_dat->bsp_priv = dwmac;
4bd3bb7b452690 Samin Guo 2023-04-17  136  	plat_dat->dma_cfg->dche = true;
4bd3bb7b452690 Samin Guo 2023-04-17  137  
b4a5afa51ceeca Samin Guo 2023-04-17  138  	err = starfive_dwmac_set_mode(plat_dat);
b4a5afa51ceeca Samin Guo 2023-04-17  139  	if (err)
b4a5afa51ceeca Samin Guo 2023-04-17  140  		return err;
b4a5afa51ceeca Samin Guo 2023-04-17  141  
4bd3bb7b452690 Samin Guo 2023-04-17  142  	err = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
4bd3bb7b452690 Samin Guo 2023-04-17  143  	if (err) {
4bd3bb7b452690 Samin Guo 2023-04-17  144  		stmmac_remove_config_dt(pdev, plat_dat);
4bd3bb7b452690 Samin Guo 2023-04-17  145  		return err;
4bd3bb7b452690 Samin Guo 2023-04-17  146  	}
4bd3bb7b452690 Samin Guo 2023-04-17  147  
4bd3bb7b452690 Samin Guo 2023-04-17  148  	return 0;
4bd3bb7b452690 Samin Guo 2023-04-17  149  }
4bd3bb7b452690 Samin Guo 2023-04-17  150  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

