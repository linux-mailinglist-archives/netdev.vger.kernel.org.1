Return-Path: <netdev+bounces-154921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217CFA00590
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA47A162C7C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42FA1C760D;
	Fri,  3 Jan 2025 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUQtRcSP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460851C760A
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735891954; cv=none; b=LBiyVZAPX3uiKkVGDm3hHMW2lsR5m3QjwkIRIW/MWUgfj7YQfKkHnXw9fB43QtuM1Ftu1Ksw9ClN+EYDbuLkrxSDcdGIff+RLDIr8Ma2YXp1qd1RkVFus8BftVyVTpxQpWMIeZe0hwI7fBJzP5CwJ6X3E8CTUPPVVSHcWi2xzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735891954; c=relaxed/simple;
	bh=EYAHXl3CvaBhMHvkvveYzvjx1c1Lk/5xpjSieijDD3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMATdZHfPkUfkwcdQCz0ZgeGB/FiqLaaSgjEUrcSnjmRu/6vm2Gch6qNXIhuaK+AqUPMPQU9sRsFP0LEgDJun5VqBcZBley90frkqcTIN9uqiJ4uc6Ghz2UUlUu51xGdvdbdv4FSzxOH938lo72ELphZf5uq6gupBruIh8Xo6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUQtRcSP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735891952; x=1767427952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EYAHXl3CvaBhMHvkvveYzvjx1c1Lk/5xpjSieijDD3E=;
  b=CUQtRcSPklHp66XQm7eKN1Lyfuvo/8tYhZL63kFUEI6fLsQ7IbCeGahZ
   GtZWXKSiurgDvnjIaqcCqqmAv2f0As68GIz+90F6n5xhHIqBnPWy8ShNk
   /l1MRviZntHHQ78IxiAhWwBXMfSS4Dds/7cqoDlw5sHVoVrFIg4RWgj6b
   4OhEBXPe/R+pZ86ZrepDW2nMw+INQIZxg31Wn7heEYznqYdAhUajN6vXG
   F0dMAq71Bb4GpGlFHjVknFe69IUfQ/acdE2Wvok59rRwwI7Op1v2dGYTm
   f1QyQq7MaLbHTz99lyTZa/++qahrQsZ09CKiUbJqraEiM24Xvxtz9FG9/
   Q==;
X-CSE-ConnectionGUID: RA82a2UJQN2hSh7pZa+SuA==
X-CSE-MsgGUID: QreJXgrZSw6nUZPI5fVWaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11303"; a="35384474"
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="35384474"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2025 00:12:32 -0800
X-CSE-ConnectionGUID: X5Dw3mooQxuUzQCLathtxA==
X-CSE-MsgGUID: e28ANAOaRyyKyJ8L1bRAyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="102217915"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jan 2025 00:12:29 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tTcnD-0009RH-1w;
	Fri, 03 Jan 2025 08:12:27 +0000
Date: Fri, 3 Jan 2025 16:11:37 +0800
From: kernel test robot <lkp@intel.com>
To: Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, skhawaja@google.com
Subject: Re: [PATCH net-next 3/3] Extend napi threaded polling to allow
 kthread based busy polling
Message-ID: <202501031537.QXSNLahs-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250103/202501031537.QXSNLahs-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250103/202501031537.QXSNLahs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501031537.QXSNLahs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/atheros/atl1c/atl1c_main.c:9:
   In file included from drivers/net/ethernet/atheros/atl1c/atl1c.h:16:
   In file included from include/linux/pci.h:1658:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/atheros/atl1c/atl1c_main.c:2691:27: error: use of undeclared identifier 'DEV_NAPI_THREADED'; did you mean 'NAPI_THREADED'?
    2691 |         dev_set_threaded(netdev, DEV_NAPI_THREADED);
         |                                  ^~~~~~~~~~~~~~~~~
         |                                  NAPI_THREADED
   include/linux/netdevice.h:581:2: note: 'NAPI_THREADED' declared here
     581 |         NAPI_THREADED = 1,
         |         ^
   4 warnings and 1 error generated.


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

