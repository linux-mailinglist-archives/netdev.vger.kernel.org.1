Return-Path: <netdev+bounces-154859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC69AA00232
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90A91883D4C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63021494A8;
	Fri,  3 Jan 2025 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGfnuY1m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270ED24B34
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735866406; cv=none; b=BTH9/vsrAjeJTAUi3vXhoeAHfIvRZu4m6AqMg0mf5Gzb6Ks88LRQagS4tUygVvFO5uGIig9Jc/tXnG3cC0B/+08B+V/s1Xxwfjo/r8Qxq1JE7Io3gdOOCkHarkDsMbAcuJlOLKInqb+e8v1h4oKjhuQyMEz75iFGFxCOx6R8V3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735866406; c=relaxed/simple;
	bh=DMQKZbvjT3IhZkRxB7+oofR+nMrgbeHoaLM1Q80piKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRi5t2+RKfZqck4q+wGKYmJqLwk546P6wvl4sImK4ICG8STMfBVMkGnBQUSCrBNYWl/MOc/0U82xiAMQOpC7ZCQf2rWZu2ffBYNb95OJnf+wPyOB/gFqLKkKtVFwobRbyIuMLFmTsGAY0ayh2rQLojA3kQ4Jp8gIlfp3tOH8II0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGfnuY1m; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735866405; x=1767402405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DMQKZbvjT3IhZkRxB7+oofR+nMrgbeHoaLM1Q80piKI=;
  b=WGfnuY1mriSvhAquOAq4uiSV+79x+tjsl50GoRg9YiPzrYrCEUUSzhC7
   eFTLF2WBP6KCLEdUWjvYvUMUzyKn6cpn8SVWllRwbKTxenl0mMW5k9PI7
   on0rZaELzUQtn5F9vlQUljD7XOLacmhFka00tFwwlXv+mPQUYFZ5rg9Sf
   CSul4Am2QWtD9S1jgQoXM5eQRfQS5JWikWMv4HjZqcQiHRML4/dL8VeTP
   AuUS5xuF17d1yHU3DeYH0VgzOcswrBhJgVG+a4Uf60pme5lz7WnnbYU82
   xQDnrJ4zDFnLyx5oZX2PDacd2Wo8LK0/lCjOxgz+V7+LY2Yuz6WzTooem
   g==;
X-CSE-ConnectionGUID: wV3BWiiwR0uihazjPvJ7og==
X-CSE-MsgGUID: RZdHq+XuTY+vvQzoWN3qCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="36019914"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="36019914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 17:06:42 -0800
X-CSE-ConnectionGUID: aimplwUmRMiE9STF5FQDKw==
X-CSE-MsgGUID: w8n4LjtCT9+L2j3VqTlcMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138987630"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Jan 2025 17:06:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTW98-00091H-0h;
	Fri, 03 Jan 2025 01:06:38 +0000
Date: Fri, 3 Jan 2025 09:05:40 +0800
From: kernel test robot <lkp@intel.com>
To: Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	skhawaja@google.com
Subject: Re: [PATCH net-next 3/3] Extend napi threaded polling to allow
 kthread based busy polling
Message-ID: <202501030842.OdBE8ADq-lkp@intel.com>
References: <20250102191227.2084046-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102191227.2084046-4-skhawaja@google.com>

Hi Samiullah,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Samiullah-Khawaja/Add-support-to-set-napi-threaded-for-individual-napi/20250103-031428
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250102191227.2084046-4-skhawaja%40google.com
patch subject: [PATCH net-next 3/3] Extend napi threaded polling to allow kthread based busy polling
config: i386-buildonly-randconfig-006-20250103 (https://download.01.org/0day-ci/archive/20250103/202501030842.OdBE8ADq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250103/202501030842.OdBE8ADq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501030842.OdBE8ADq-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/atheros/atl1c/atl1c_main.c: In function 'atl1c_probe':
>> drivers/net/ethernet/atheros/atl1c/atl1c_main.c:2691:34: error: 'DEV_NAPI_THREADED' undeclared (first use in this function); did you mean 'NAPI_THREADED'?
    2691 |         dev_set_threaded(netdev, DEV_NAPI_THREADED);
         |                                  ^~~~~~~~~~~~~~~~~
         |                                  NAPI_THREADED
   drivers/net/ethernet/atheros/atl1c/atl1c_main.c:2691:34: note: each undeclared identifier is reported only once for each function it appears in


vim +2691 drivers/net/ethernet/atheros/atl1c/atl1c_main.c

  2600	
  2601	/**
  2602	 * atl1c_probe - Device Initialization Routine
  2603	 * @pdev: PCI device information struct
  2604	 * @ent: entry in atl1c_pci_tbl
  2605	 *
  2606	 * Returns 0 on success, negative on failure
  2607	 *
  2608	 * atl1c_probe initializes an adapter identified by a pci_dev structure.
  2609	 * The OS initialization, configuring of the adapter private structure,
  2610	 * and a hardware reset occur.
  2611	 */
  2612	static int atl1c_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  2613	{
  2614		struct net_device *netdev;
  2615		struct atl1c_adapter *adapter;
  2616		static int cards_found;
  2617		u8 __iomem *hw_addr;
  2618		enum atl1c_nic_type nic_type;
  2619		u32 queue_count = 1;
  2620		int err = 0;
  2621		int i;
  2622	
  2623		/* enable device (incl. PCI PM wakeup and hotplug setup) */
  2624		err = pci_enable_device_mem(pdev);
  2625		if (err)
  2626			return dev_err_probe(&pdev->dev, err, "cannot enable PCI device\n");
  2627	
  2628		/*
  2629		 * The atl1c chip can DMA to 64-bit addresses, but it uses a single
  2630		 * shared register for the high 32 bits, so only a single, aligned,
  2631		 * 4 GB physical address range can be used at a time.
  2632		 *
  2633		 * Supporting 64-bit DMA on this hardware is more trouble than it's
  2634		 * worth.  It is far easier to limit to 32-bit DMA than update
  2635		 * various kernel subsystems to support the mechanics required by a
  2636		 * fixed-high-32-bit system.
  2637		 */
  2638		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
  2639		if (err) {
  2640			dev_err(&pdev->dev, "No usable DMA configuration,aborting\n");
  2641			goto err_dma;
  2642		}
  2643	
  2644		err = pci_request_regions(pdev, atl1c_driver_name);
  2645		if (err) {
  2646			dev_err(&pdev->dev, "cannot obtain PCI resources\n");
  2647			goto err_pci_reg;
  2648		}
  2649	
  2650		pci_set_master(pdev);
  2651	
  2652		hw_addr = pci_ioremap_bar(pdev, 0);
  2653		if (!hw_addr) {
  2654			err = -EIO;
  2655			dev_err(&pdev->dev, "cannot map device registers\n");
  2656			goto err_ioremap;
  2657		}
  2658	
  2659		nic_type = atl1c_get_mac_type(pdev, hw_addr);
  2660		if (nic_type == athr_mt)
  2661			queue_count = 4;
  2662	
  2663		netdev = alloc_etherdev_mq(sizeof(struct atl1c_adapter), queue_count);
  2664		if (netdev == NULL) {
  2665			err = -ENOMEM;
  2666			goto err_alloc_etherdev;
  2667		}
  2668	
  2669		err = atl1c_init_netdev(netdev, pdev);
  2670		if (err) {
  2671			dev_err(&pdev->dev, "init netdevice failed\n");
  2672			goto err_init_netdev;
  2673		}
  2674		adapter = netdev_priv(netdev);
  2675		adapter->bd_number = cards_found;
  2676		adapter->netdev = netdev;
  2677		adapter->pdev = pdev;
  2678		adapter->hw.adapter = adapter;
  2679		adapter->hw.nic_type = nic_type;
  2680		adapter->msg_enable = netif_msg_init(-1, atl1c_default_msg);
  2681		adapter->hw.hw_addr = hw_addr;
  2682		adapter->tx_queue_count = queue_count;
  2683		adapter->rx_queue_count = queue_count;
  2684	
  2685		/* init mii data */
  2686		adapter->mii.dev = netdev;
  2687		adapter->mii.mdio_read  = atl1c_mdio_read;
  2688		adapter->mii.mdio_write = atl1c_mdio_write;
  2689		adapter->mii.phy_id_mask = 0x1f;
  2690		adapter->mii.reg_num_mask = MDIO_CTRL_REG_MASK;
> 2691		dev_set_threaded(netdev, DEV_NAPI_THREADED);
  2692		for (i = 0; i < adapter->rx_queue_count; ++i)
  2693			netif_napi_add(netdev, &adapter->rrd_ring[i].napi,
  2694				       atl1c_clean_rx);
  2695		for (i = 0; i < adapter->tx_queue_count; ++i)
  2696			netif_napi_add_tx(netdev, &adapter->tpd_ring[i].napi,
  2697					  atl1c_clean_tx);
  2698		timer_setup(&adapter->phy_config_timer, atl1c_phy_config, 0);
  2699		/* setup the private structure */
  2700		err = atl1c_sw_init(adapter);
  2701		if (err) {
  2702			dev_err(&pdev->dev, "net device private data init failed\n");
  2703			goto err_sw_init;
  2704		}
  2705		/* set max MTU */
  2706		atl1c_set_max_mtu(netdev);
  2707	
  2708		atl1c_reset_pcie(&adapter->hw, ATL1C_PCIE_L0S_L1_DISABLE);
  2709	
  2710		/* Init GPHY as early as possible due to power saving issue  */
  2711		atl1c_phy_reset(&adapter->hw);
  2712	
  2713		err = atl1c_reset_mac(&adapter->hw);
  2714		if (err) {
  2715			err = -EIO;
  2716			goto err_reset;
  2717		}
  2718	
  2719		/* reset the controller to
  2720		 * put the device in a known good starting state */
  2721		err = atl1c_phy_init(&adapter->hw);
  2722		if (err) {
  2723			err = -EIO;
  2724			goto err_reset;
  2725		}
  2726		if (atl1c_read_mac_addr(&adapter->hw)) {
  2727			/* got a random MAC address, set NET_ADDR_RANDOM to netdev */
  2728			netdev->addr_assign_type = NET_ADDR_RANDOM;
  2729		}
  2730		eth_hw_addr_set(netdev, adapter->hw.mac_addr);
  2731		if (netif_msg_probe(adapter))
  2732			dev_dbg(&pdev->dev, "mac address : %pM\n",
  2733				adapter->hw.mac_addr);
  2734	
  2735		atl1c_hw_set_mac_addr(&adapter->hw, adapter->hw.mac_addr);
  2736		INIT_WORK(&adapter->common_task, atl1c_common_task);
  2737		adapter->work_event = 0;
  2738		err = register_netdev(netdev);
  2739		if (err) {
  2740			dev_err(&pdev->dev, "register netdevice failed\n");
  2741			goto err_register;
  2742		}
  2743	
  2744		cards_found++;
  2745		return 0;
  2746	
  2747	err_reset:
  2748	err_register:
  2749	err_sw_init:
  2750	err_init_netdev:
  2751		free_netdev(netdev);
  2752	err_alloc_etherdev:
  2753		iounmap(hw_addr);
  2754	err_ioremap:
  2755		pci_release_regions(pdev);
  2756	err_pci_reg:
  2757	err_dma:
  2758		pci_disable_device(pdev);
  2759		return err;
  2760	}
  2761	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

