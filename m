Return-Path: <netdev+bounces-24691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BC9771348
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 04:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079BE281454
	for <lists+netdev@lfdr.de>; Sun,  6 Aug 2023 02:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA61F17D1;
	Sun,  6 Aug 2023 02:49:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95217D0
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 02:49:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65DE130
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 19:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691290147; x=1722826147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PhAZR5+gYK6dezZ4NV0mKUs5qP6QH8F/+UUezWgYV/8=;
  b=UIJDDplLt8e1nm9Clx4MrCAk/CDtx5lnTmbq82XrkjC/InHOeC9OPium
   r4BTM2pKCxkbQtM3XFQ5D26y4w5UgTfE4ibUr62KB3VeeB6b6hAyn2YIy
   v2zzHOx8fEwmmhOezxoYV3ZwL/tQhaRoQ4WvK5kCxuiYgsnRnhnub7iLZ
   sh6+BjmRcuxmhisQcEjSbRd+F6ucYdjQb8bBULK47Bn1y0eGjiXfOtniu
   RAcOnSNSTKeCyTJnEOa7PSPzbBrfrhzYJxyOI8b0vZpsWxjoKoEhfYHGG
   7ml6Hu1UYm6q+kJYoPF2sfvpSh6Zr5PFBAdCAt0Ho9zwAhxOOfrpN/I4d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="350662138"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="350662138"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 19:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="800528124"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="800528124"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2023 19:48:59 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qSTpD-0003zv-0K;
	Sun, 06 Aug 2023 02:48:59 +0000
Date: Sun, 6 Aug 2023 10:48:18 +0800
From: kernel test robot <lkp@intel.com>
To: Shenwei Wang <shenwei.wang@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
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
	Shenwei Wang <shenwei.wang@nxp.com>
Subject: Re: [PATCH v4 net-next 1/2] net: stmmac: add new mode parameter for
 fix_mac_speed
Message-ID: <202308061048.nLnNqNUP-lkp@intel.com>
References: <20230804144629.358455-2-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804144629.358455-2-shenwei.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Shenwei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenwei-Wang/net-stmmac-add-new-mode-parameter-for-fix_mac_speed/20230804-224841
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230804144629.358455-2-shenwei.wang%40nxp.com
patch subject: [PATCH v4 net-next 1/2] net: stmmac: add new mode parameter for fix_mac_speed
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230806/202308061048.nLnNqNUP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230806/202308061048.nLnNqNUP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308061048.nLnNqNUP-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c: In function 'sti_dwmac_probe':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c:295:33: error: assignment to 'void (*)(void *, unsigned int,  unsigned int)' from incompatible pointer type 'void (*)(void *, unsigned int)' [-Werror=incompatible-pointer-types]
     295 |         plat_dat->fix_mac_speed = data->fix_retime_src;
         |                                 ^
   cc1: some warnings being treated as errors


vim +295 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c

d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  257  
8387ee21f972de Joachim Eastwood    2015-07-29  258  static int sti_dwmac_probe(struct platform_device *pdev)
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  259  {
8387ee21f972de Joachim Eastwood    2015-07-29  260  	struct plat_stmmacenet_data *plat_dat;
07ca3749cec2b8 Joachim Eastwood    2015-07-29  261  	const struct sti_dwmac_of_data *data;
8387ee21f972de Joachim Eastwood    2015-07-29  262  	struct stmmac_resources stmmac_res;
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  263  	struct sti_dwmac *dwmac;
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  264  	int ret;
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  265  
149adedd7696cb Joachim Eastwood    2015-07-29  266  	data = of_device_get_match_data(&pdev->dev);
149adedd7696cb Joachim Eastwood    2015-07-29  267  	if (!data) {
149adedd7696cb Joachim Eastwood    2015-07-29  268  		dev_err(&pdev->dev, "No OF match data provided\n");
149adedd7696cb Joachim Eastwood    2015-07-29  269  		return -EINVAL;
149adedd7696cb Joachim Eastwood    2015-07-29  270  	}
149adedd7696cb Joachim Eastwood    2015-07-29  271  
8387ee21f972de Joachim Eastwood    2015-07-29  272  	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
8387ee21f972de Joachim Eastwood    2015-07-29  273  	if (ret)
8387ee21f972de Joachim Eastwood    2015-07-29  274  		return ret;
8387ee21f972de Joachim Eastwood    2015-07-29  275  
83216e3988cd19 Michael Walle       2021-04-12  276  	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
8387ee21f972de Joachim Eastwood    2015-07-29  277  	if (IS_ERR(plat_dat))
8387ee21f972de Joachim Eastwood    2015-07-29  278  		return PTR_ERR(plat_dat);
8387ee21f972de Joachim Eastwood    2015-07-29  279  
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  280  	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
d2ed0a7755fe14 Johan Hovold        2016-11-30  281  	if (!dwmac) {
d2ed0a7755fe14 Johan Hovold        2016-11-30  282  		ret = -ENOMEM;
d2ed0a7755fe14 Johan Hovold        2016-11-30  283  		goto err_remove_config_dt;
d2ed0a7755fe14 Johan Hovold        2016-11-30  284  	}
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  285  
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  286  	ret = sti_dwmac_parse_data(dwmac, pdev);
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  287  	if (ret) {
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  288  		dev_err(&pdev->dev, "Unable to parse OF data\n");
d2ed0a7755fe14 Johan Hovold        2016-11-30  289  		goto err_remove_config_dt;
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  290  	}
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  291  
16b1adbb16c8a5 Joachim Eastwood    2015-07-29  292  	dwmac->fix_retime_src = data->fix_retime_src;
16b1adbb16c8a5 Joachim Eastwood    2015-07-29  293  
8387ee21f972de Joachim Eastwood    2015-07-29  294  	plat_dat->bsp_priv = dwmac;
16b1adbb16c8a5 Joachim Eastwood    2015-07-29 @295  	plat_dat->fix_mac_speed = data->fix_retime_src;
8387ee21f972de Joachim Eastwood    2015-07-29  296  
b89cbfb01a2855 Joachim Eastwood    2016-11-04  297  	ret = clk_prepare_enable(dwmac->clk);
8387ee21f972de Joachim Eastwood    2015-07-29  298  	if (ret)
d2ed0a7755fe14 Johan Hovold        2016-11-30  299  		goto err_remove_config_dt;
8387ee21f972de Joachim Eastwood    2015-07-29  300  
0eebedc2fd284e Joachim Eastwood    2016-11-04  301  	ret = sti_dwmac_set_mode(dwmac);
b89cbfb01a2855 Joachim Eastwood    2016-11-04  302  	if (ret)
b89cbfb01a2855 Joachim Eastwood    2016-11-04  303  		goto disable_clk;
b89cbfb01a2855 Joachim Eastwood    2016-11-04  304  
b89cbfb01a2855 Joachim Eastwood    2016-11-04  305  	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
b89cbfb01a2855 Joachim Eastwood    2016-11-04  306  	if (ret)
b89cbfb01a2855 Joachim Eastwood    2016-11-04  307  		goto disable_clk;
b89cbfb01a2855 Joachim Eastwood    2016-11-04  308  
b89cbfb01a2855 Joachim Eastwood    2016-11-04  309  	return 0;
b89cbfb01a2855 Joachim Eastwood    2016-11-04  310  
b89cbfb01a2855 Joachim Eastwood    2016-11-04  311  disable_clk:
b89cbfb01a2855 Joachim Eastwood    2016-11-04  312  	clk_disable_unprepare(dwmac->clk);
d2ed0a7755fe14 Johan Hovold        2016-11-30  313  err_remove_config_dt:
d2ed0a7755fe14 Johan Hovold        2016-11-30  314  	stmmac_remove_config_dt(pdev, plat_dat);
0a9e22715ee384 Johan Hovold        2016-11-30  315  
b89cbfb01a2855 Joachim Eastwood    2016-11-04  316  	return ret;
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  317  }
d15891ca1fdd7f Srinivas Kandagatla 2014-02-11  318  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

