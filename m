Return-Path: <netdev+bounces-160780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C995BA1B6BF
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 14:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A31188F740
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF44939AD6;
	Fri, 24 Jan 2025 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuU2fzOb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC76F305
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737724788; cv=none; b=EUvs75827lT5cXC1VAi93LAMdiJ84OEdQagYrRapWZIFmLAFjz02NalmDJpXIHrpp91zUMlZtjWcrx7FXr9OTkULD6xtvRUCGZHDse6JXPLb0kHXqVleETxYpAZyhkrQqiduaLouaz9yCFNIXnlMiBL0EK7QSgHZ2f3a/LjxglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737724788; c=relaxed/simple;
	bh=XiDNncfJXCpmO1bVzSjTzo876biRjptiWYhvhFLU/9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxHEd0eD9Qxyert6GY0bMPmXPlT4EtcFiQ9E/A5KZbg8Jlg+euiEJ6HzTyfWpb1p81rVg3X9j0U2+5Sd/NGI6B20Bhpx8uvOxGwpTPzVnh+lYPvOaTbi8rS8CpfnDFIOvwAZSoHQBISMSNiTsafCLtGMtzRoglVc6vhTCfzjqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuU2fzOb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737724787; x=1769260787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XiDNncfJXCpmO1bVzSjTzo876biRjptiWYhvhFLU/9Q=;
  b=AuU2fzOb773WS9PNzkpsRckpxwR99YdmojKgBor0q32qThY5Zn6iY/ig
   6zGmfIW2/IJXGK9Vfqo7jKxKxM4FeVRo2bKW+Ux6cyWUjrbqCb75b60BX
   UaGpYSNwsbkeuJh1867S30wuQcclWAnAZ5nOT6Vg0UfBS8DM/q2U8KfdO
   mNcmaP2WWwPXn/rA/4Fabkb887KGDBuubT5UUtJRdStxFxqi25brrwJAb
   fzdOvJf/u2etmMI9vEh+AVNuBj45p1uouap5wp+Y8TcaV0kDwUvle50Td
   594K0uFZyZKKW7q+XrdmcgzNBheJ4W7uGWQhyoByrwrXbaDimCL5Ox1E6
   A==;
X-CSE-ConnectionGUID: R7FUpkOQS466QUPLF0zkAQ==
X-CSE-MsgGUID: JG5sMKNTTbO+/upXLrDDNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="60723374"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="60723374"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 05:19:46 -0800
X-CSE-ConnectionGUID: iAoI0VKkQSSdkvcOYgqT3w==
X-CSE-MsgGUID: 35JcTyp9QyusNXRqgTs5Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107617094"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 Jan 2025 05:19:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tbJb3-000chr-00;
	Fri, 24 Jan 2025 13:19:41 +0000
Date: Fri, 24 Jan 2025 21:18:55 +0800
From: kernel test robot <lkp@intel.com>
To: Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	skhawaja@google.com
Subject: Re: [PATCH net-next v2 3/4] Extend napi threaded polling to allow
 kthread based busy polling
Message-ID: <202501242114.hSuOcqsi-lkp@intel.com>
References: <20250123231236.2657321-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123231236.2657321-4-skhawaja@google.com>

Hi Samiullah,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Samiullah-Khawaja/Add-support-to-set-napi-threaded-for-individual-napi/20250124-071412
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250123231236.2657321-4-skhawaja%40google.com
patch subject: [PATCH net-next v2 3/4] Extend napi threaded polling to allow kthread based busy polling
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250124/202501242114.hSuOcqsi-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250124/202501242114.hSuOcqsi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501242114.hSuOcqsi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/renesas/ravb_main.c: In function 'ravb_probe':
>> drivers/net/ethernet/renesas/ravb_main.c:3078:48: warning: implicit conversion from 'enum <anonymous>' to 'enum netdev_napi_threaded' [-Wenum-conversion]
    3078 |                         dev_set_threaded(ndev, true);
         |                                                ^~~~
--
   drivers/net/ethernet/mellanox/mlxsw/pci.c: In function 'mlxsw_pci_napi_devs_init':
>> drivers/net/ethernet/mellanox/mlxsw/pci.c:159:50: warning: implicit conversion from 'enum <anonymous>' to 'enum netdev_napi_threaded' [-Wenum-conversion]
     159 |         dev_set_threaded(mlxsw_pci->napi_dev_rx, true);
         |                                                  ^~~~
--
   drivers/net/wireless/ath/ath10k/snoc.c: In function 'ath10k_snoc_hif_start':
>> drivers/net/wireless/ath/ath10k/snoc.c:938:40: warning: implicit conversion from 'enum <anonymous>' to 'enum netdev_napi_threaded' [-Wenum-conversion]
     938 |         dev_set_threaded(ar->napi_dev, true);
         |                                        ^~~~


vim +3078 drivers/net/ethernet/renesas/ravb_main.c

32f012b8c01ca9 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2901  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2902  static int ravb_probe(struct platform_device *pdev)
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2903  {
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2904  	struct device_node *np = pdev->dev.of_node;
ebb091461a9e14 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-18  2905  	const struct ravb_hw_info *info;
0d13a1a464a023 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  2906  	struct reset_control *rstc;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2907  	struct ravb_private *priv;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2908  	struct net_device *ndev;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2909  	struct resource *res;
32f012b8c01ca9 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2910  	int error, q;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2911  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2912  	if (!np) {
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2913  		dev_err(&pdev->dev,
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2914  			"this driver is required to be instantiated from device tree\n");
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2915  		return -EINVAL;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2916  	}
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2917  
b1768e3dc47792 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2918  	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
0d13a1a464a023 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  2919  	if (IS_ERR(rstc))
0d13a1a464a023 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  2920  		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
0d13a1a464a023 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  2921  				     "failed to get cpg reset\n");
0d13a1a464a023 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  2922  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2923  	ndev = alloc_etherdev_mqs(sizeof(struct ravb_private),
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2924  				  NUM_TX_QUEUE, NUM_RX_QUEUE);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2925  	if (!ndev)
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2926  		return -ENOMEM;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2927  
8912ed25daf6fc drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-18  2928  	info = of_device_get_match_data(&pdev->dev);
8912ed25daf6fc drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-18  2929  
8912ed25daf6fc drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-18  2930  	ndev->features = info->net_features;
8912ed25daf6fc drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-18  2931  	ndev->hw_features = info->net_hw_features;
546875ccba938b drivers/net/ethernet/renesas/ravb_main.c Paul Barker        2024-10-15  2932  	ndev->vlan_features = info->vlan_features;
4d86d381862714 drivers/net/ethernet/renesas/ravb_main.c Simon Horman       2017-10-04  2933  
d8eb6ea4b302e7 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2023-11-28  2934  	error = reset_control_deassert(rstc);
d8eb6ea4b302e7 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2023-11-28  2935  	if (error)
d8eb6ea4b302e7 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2023-11-28  2936  		goto out_free_netdev;
d8eb6ea4b302e7 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2023-11-28  2937  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2938  	SET_NETDEV_DEV(ndev, &pdev->dev);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2939  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2940  	priv = netdev_priv(ndev);
ebb091461a9e14 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-18  2941  	priv->info = info;
0d13a1a464a023 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  2942  	priv->rstc = rstc;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2943  	priv->ndev = ndev;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2944  	priv->pdev = pdev;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2945  	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2946  	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
1091da579d7ccd drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-10-12  2947  	if (info->nc_queues) {
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2948  		priv->num_tx_ring[RAVB_NC] = NC_TX_RING_SIZE;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2949  		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
a92f4f0662bf2c drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-10-01  2950  	}
a92f4f0662bf2c drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-10-01  2951  
32f012b8c01ca9 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2952  	error = ravb_setup_irqs(priv);
32f012b8c01ca9 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2953  	if (error)
32f012b8c01ca9 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2954  		goto out_reset_assert;
32f012b8c01ca9 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2955  
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2956  	priv->clk = devm_clk_get(&pdev->dev, NULL);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2957  	if (IS_ERR(priv->clk)) {
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2958  		error = PTR_ERR(priv->clk);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2959  		goto out_reset_assert;
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2960  	}
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2961  
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2962  	if (info->gptp_ref_clk) {
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2963  		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2964  		if (IS_ERR(priv->gptp_clk)) {
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2965  			error = PTR_ERR(priv->gptp_clk);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2966  			goto out_reset_assert;
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2967  		}
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2968  	}
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2969  
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2970  	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2971  	if (IS_ERR(priv->refclk)) {
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2972  		error = PTR_ERR(priv->refclk);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2973  		goto out_reset_assert;
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2974  	}
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2975  	clk_prepare(priv->refclk);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2976  
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2977  	platform_set_drvdata(pdev, ndev);
48f894ab07c444 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-14  2978  	pm_runtime_set_autosuspend_delay(&pdev->dev, 100);
48f894ab07c444 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-14  2979  	pm_runtime_use_autosuspend(&pdev->dev);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2980  	pm_runtime_enable(&pdev->dev);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2981  	error = pm_runtime_resume_and_get(&pdev->dev);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2982  	if (error < 0)
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2983  		goto out_rpm_disable;
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2984  
e89a2cdb1cca51 drivers/net/ethernet/renesas/ravb_main.c Yang Yingliang     2021-06-09  2985  	priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2986  	if (IS_ERR(priv->addr)) {
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2987  		error = PTR_ERR(priv->addr);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2988  		goto out_rpm_put;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2989  	}
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2990  
e89a2cdb1cca51 drivers/net/ethernet/renesas/ravb_main.c Yang Yingliang     2021-06-09  2991  	/* The Ether-specific entries in the device structure. */
e89a2cdb1cca51 drivers/net/ethernet/renesas/ravb_main.c Yang Yingliang     2021-06-09  2992  	ndev->base_addr = res->start;
e89a2cdb1cca51 drivers/net/ethernet/renesas/ravb_main.c Yang Yingliang     2021-06-09  2993  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2994  	spin_lock_init(&priv->lock);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2995  	INIT_WORK(&priv->work, ravb_tx_timeout_work);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  2996  
0c65b2b90d13c1 drivers/net/ethernet/renesas/ravb_main.c Andrew Lunn        2019-11-04  2997  	error = of_get_phy_mode(np, &priv->phy_interface);
0c65b2b90d13c1 drivers/net/ethernet/renesas/ravb_main.c Andrew Lunn        2019-11-04  2998  	if (error && error != -ENODEV)
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  2999  		goto out_rpm_put;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3000  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3001  	priv->no_avb_link = of_property_read_bool(np, "renesas,no-ether-link");
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3002  	priv->avb_link_active_low =
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3003  		of_property_read_bool(np, "renesas,ether-link-active-low");
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3004  
1d63864299cafa drivers/net/ethernet/renesas/ravb_main.c Paul Barker        2024-09-18  3005  	ndev->max_mtu = info->tx_max_frame_size -
e82700b8662ce5 drivers/net/ethernet/renesas/ravb_main.c Niklas Söderlund   2024-03-04  3006  		(ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
75efa06f457bbe drivers/net/ethernet/renesas/ravb_main.c Niklas Söderlund   2018-02-16  3007  	ndev->min_mtu = ETH_MIN_MTU;
75efa06f457bbe drivers/net/ethernet/renesas/ravb_main.c Niklas Söderlund   2018-02-16  3008  
c81d894226b944 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  3009  	/* FIXME: R-Car Gen2 has 4byte alignment restriction for tx buffer
c81d894226b944 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  3010  	 * Use two descriptor to handle such situation. First descriptor to
c81d894226b944 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  3011  	 * handle aligned data buffer and second descriptor to handle the
c81d894226b944 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  3012  	 * overflow data because of alignment.
c81d894226b944 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  3013  	 */
c81d894226b944 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  3014  	priv->num_tx_desc = info->aligned_tx ? 2 : 1;
f543305da9b5a5 drivers/net/ethernet/renesas/ravb_main.c Kazuya Mizuguchi   2018-09-19  3015  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3016  	/* Set function */
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3017  	ndev->netdev_ops = &ravb_netdev_ops;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3018  	ndev->ethtool_ops = &ravb_ethtool_ops;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3019  
f384ab481cab6a drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3020  	error = ravb_compute_gti(ndev);
b3d39a8805c510 drivers/net/ethernet/renesas/ravb_main.c Simon Horman       2015-11-20  3021  	if (error)
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3022  		goto out_rpm_put;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3023  
a6f51f2efa742d drivers/net/ethernet/renesas/ravb_main.c Geert Uytterhoeven 2020-10-01  3024  	ravb_parse_delay_mode(np, ndev);
61fccb2d6274f7 drivers/net/ethernet/renesas/ravb_main.c Kazuya Mizuguchi   2017-01-27  3025  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3026  	/* Allocate descriptor base address table */
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3027  	priv->desc_bat_size = sizeof(struct ravb_desc) * DBAT_ENTRY_NUM;
e2dbb33ad9545d drivers/net/ethernet/renesas/ravb_main.c Kazuya Mizuguchi   2015-09-30  3028  	priv->desc_bat = dma_alloc_coherent(ndev->dev.parent, priv->desc_bat_size,
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3029  					    &priv->desc_bat_dma, GFP_KERNEL);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3030  	if (!priv->desc_bat) {
c451113291c193 drivers/net/ethernet/renesas/ravb_main.c Simon Horman       2015-11-02  3031  		dev_err(&pdev->dev,
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3032  			"Cannot allocate desc base address table (size %d bytes)\n",
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3033  			priv->desc_bat_size);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3034  		error = -ENOMEM;
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3035  		goto out_rpm_put;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3036  	}
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3037  	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3038  		priv->desc_bat[q].die_dt = DT_EOS;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3039  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3040  	/* Initialise HW timestamp list */
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3041  	INIT_LIST_HEAD(&priv->ts_skb_list);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3042  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3043  	/* Debug message level */
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3044  	priv->msg_enable = RAVB_DEF_MSG_ENABLE;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3045  
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3046  	/* Set config mode as this is needed for PHY initialization. */
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3047  	error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3048  	if (error)
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3049  		goto out_rpm_put;
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3050  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3051  	/* Read and set MAC address */
83216e3988cd19 drivers/net/ethernet/renesas/ravb_main.c Michael Walle      2021-04-12  3052  	ravb_read_mac_address(np, ndev);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3053  	if (!is_valid_ether_addr(ndev->dev_addr)) {
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3054  		dev_warn(&pdev->dev,
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3055  			 "no valid MAC address supplied, using a random one\n");
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3056  		eth_hw_addr_random(ndev);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3057  	}
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3058  
77972b55fb9d35 drivers/net/ethernet/renesas/ravb_main.c Geert Uytterhoeven 2020-09-22  3059  	/* MDIO bus init */
77972b55fb9d35 drivers/net/ethernet/renesas/ravb_main.c Geert Uytterhoeven 2020-09-22  3060  	error = ravb_mdio_init(priv);
77972b55fb9d35 drivers/net/ethernet/renesas/ravb_main.c Geert Uytterhoeven 2020-09-22  3061  	if (error) {
77972b55fb9d35 drivers/net/ethernet/renesas/ravb_main.c Geert Uytterhoeven 2020-09-22  3062  		dev_err(&pdev->dev, "failed to initialize MDIO\n");
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3063  		goto out_reset_mode;
77972b55fb9d35 drivers/net/ethernet/renesas/ravb_main.c Geert Uytterhoeven 2020-09-22  3064  	}
77972b55fb9d35 drivers/net/ethernet/renesas/ravb_main.c Geert Uytterhoeven 2020-09-22  3065  
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3066  	/* Undo previous switch to config opmode. */
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3067  	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3068  	if (error)
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3069  		goto out_mdio_release;
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3070  
b48b89f9c189d2 drivers/net/ethernet/renesas/ravb_main.c Jakub Kicinski     2022-09-27  3071  	netif_napi_add(ndev, &priv->napi[RAVB_BE], ravb_poll);
1091da579d7ccd drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-10-12  3072  	if (info->nc_queues)
b48b89f9c189d2 drivers/net/ethernet/renesas/ravb_main.c Jakub Kicinski     2022-09-27  3073  		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3074  
65c482bc226ab2 drivers/net/ethernet/renesas/ravb_main.c Paul Barker        2024-06-04  3075  	if (info->coalesce_irqs) {
7b39c1814ce3bc drivers/net/ethernet/renesas/ravb_main.c Paul Barker        2024-06-04  3076  		netdev_sw_irq_coalesce_default_on(ndev);
65c482bc226ab2 drivers/net/ethernet/renesas/ravb_main.c Paul Barker        2024-06-04  3077  		if (num_present_cpus() == 1)
65c482bc226ab2 drivers/net/ethernet/renesas/ravb_main.c Paul Barker        2024-06-04 @3078  			dev_set_threaded(ndev, true);
65c482bc226ab2 drivers/net/ethernet/renesas/ravb_main.c Paul Barker        2024-06-04  3079  	}
7b39c1814ce3bc drivers/net/ethernet/renesas/ravb_main.c Paul Barker        2024-06-04  3080  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3081  	/* Network device register */
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3082  	error = register_netdev(ndev);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3083  	if (error)
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3084  		goto out_napi_del;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3085  
3e3d647715d401 drivers/net/ethernet/renesas/ravb_main.c Niklas Söderlund   2017-08-01  3086  	device_set_wakeup_capable(&pdev->dev, 1);
3e3d647715d401 drivers/net/ethernet/renesas/ravb_main.c Niklas Söderlund   2017-08-01  3087  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3088  	/* Print device information */
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3089  	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3090  		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3091  
48f894ab07c444 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-14  3092  	pm_runtime_mark_last_busy(&pdev->dev);
48f894ab07c444 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-14  3093  	pm_runtime_put_autosuspend(&pdev->dev);
48f894ab07c444 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-14  3094  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3095  	return 0;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3096  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3097  out_napi_del:
1091da579d7ccd drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-10-12  3098  	if (info->nc_queues)
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3099  		netif_napi_del(&priv->napi[RAVB_NC]);
a92f4f0662bf2c drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-10-01  3100  
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3101  	netif_napi_del(&priv->napi[RAVB_BE]);
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3102  out_mdio_release:
77972b55fb9d35 drivers/net/ethernet/renesas/ravb_main.c Geert Uytterhoeven 2020-09-22  3103  	ravb_mdio_release(priv);
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3104  out_reset_mode:
76fd52c1007785 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3105  	ravb_set_opmode(ndev, CCC_OPC_RESET);
e2dbb33ad9545d drivers/net/ethernet/renesas/ravb_main.c Kazuya Mizuguchi   2015-09-30  3106  	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3107  			  priv->desc_bat_dma);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3108  out_rpm_put:
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3109  	pm_runtime_put(&pdev->dev);
88b74831faaee4 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2023-11-28  3110  out_rpm_disable:
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3111  	pm_runtime_disable(&pdev->dev);
48f894ab07c444 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-14  3112  	pm_runtime_dont_use_autosuspend(&pdev->dev);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3113  	clk_unprepare(priv->refclk);
a654f6e875b753 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2024-02-02  3114  out_reset_assert:
0d13a1a464a023 drivers/net/ethernet/renesas/ravb_main.c Biju Das           2021-08-25  3115  	reset_control_assert(rstc);
d8eb6ea4b302e7 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2023-11-28  3116  out_free_netdev:
d8eb6ea4b302e7 drivers/net/ethernet/renesas/ravb_main.c Claudiu Beznea     2023-11-28  3117  	free_netdev(ndev);
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3118  	return error;
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3119  }
c156633f135326 drivers/net/ethernet/renesas/ravb.c      Sergei Shtylyov    2015-06-11  3120  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

