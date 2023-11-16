Return-Path: <netdev+bounces-48482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B747EE881
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47C91F25868
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 20:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBC46533;
	Thu, 16 Nov 2023 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awcFxJrv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0973D51
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 12:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700167842; x=1731703842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UCBWxgYOdvDpizYZV7+ud+iHcd1i1ABfkVy5RhbIbI0=;
  b=awcFxJrvEGT/zk04rFW29JbVlaLtlvV9JH3QNhg+pugoH2KtatUIuBzD
   1JiLwXgqDHyQd+z/plHrzY0lmr4PhADoTm+Kao2k5BHTf22pm/rVC6e8m
   b3SxHSkYSKx+qihNybLNg+hzUhrJxBfx5XDgD+3BQkHSgzAIjxN7b0rAZ
   2KAUv+V8DNQ8HixyYyUCsye6q4GEijgY/wbUQ88+Q5Ptxc0LFhYjAopaG
   j8qepV17VAM0d5YMDRNLwwydxMDKwmKUa7pmxMgi/dbWgQvwKqfG3fIB6
   7SQsSTwkamVa/WCfcoyXO7IAf0XWRaqC5d23sQnYHTRw/Rakvg8WGBgNU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="370535843"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="370535843"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 12:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="741880404"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="741880404"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2023 12:50:39 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3jJt-00023f-0c;
	Thu, 16 Nov 2023 20:50:37 +0000
Date: Fri, 17 Nov 2023 04:49:51 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH v2 net-next 4/4] amd-xgbe: use smn functions to avoid race
Message-ID: <202311170405.t3M3Drrw-lkp@intel.com>
References: <20231116135416.3371367-5-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116135416.3371367-5-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-reorganize-the-code-of-XPCS-access/20231116-215630
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231116135416.3371367-5-Raju.Rangoju%40amd.com
patch subject: [PATCH v2 net-next 4/4] amd-xgbe: use smn functions to avoid race
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231117/202311170405.t3M3Drrw-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311170405.t3M3Drrw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311170405.t3M3Drrw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/amd/xgbe/xgbe-pci.c: In function 'xgbe_pci_probe':
>> drivers/net/ethernet/amd/xgbe/xgbe-pci.c:316:17: error: implicit declaration of function 'amd_smn_read' [-Werror=implicit-function-declaration]
     316 |                 amd_smn_read(0, pdata->smn_base + (pdata->xpcs_window_def_reg), &reg);
         |                 ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/amd/xgbe/xgbe-dev.c: In function 'xgbe_read_mmd_regs_v3':
>> drivers/net/ethernet/amd/xgbe/xgbe-dev.c:1194:9: error: implicit declaration of function 'amd_smn_write'; did you mean 'pmd_mkwrite'? [-Werror=implicit-function-declaration]
    1194 |         amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
         |         ^~~~~~~~~~~~~
         |         pmd_mkwrite
>> drivers/net/ethernet/amd/xgbe/xgbe-dev.c:1195:9: error: implicit declaration of function 'amd_smn_read' [-Werror=implicit-function-declaration]
    1195 |         amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
         |         ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/amd_smn_read +316 drivers/net/ethernet/amd/xgbe/xgbe-pci.c

   211	
   212	static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
   213	{
   214		struct xgbe_prv_data *pdata;
   215		struct device *dev = &pdev->dev;
   216		void __iomem * const *iomap_table;
   217		struct pci_dev *rdev;
   218		unsigned int ma_lo, ma_hi;
   219		unsigned int reg;
   220		int bar_mask;
   221		int ret;
   222	
   223		pdata = xgbe_alloc_pdata(dev);
   224		if (IS_ERR(pdata)) {
   225			ret = PTR_ERR(pdata);
   226			goto err_alloc;
   227		}
   228	
   229		pdata->pcidev = pdev;
   230		pci_set_drvdata(pdev, pdata);
   231	
   232		/* Get the version data */
   233		pdata->vdata = (struct xgbe_version_data *)id->driver_data;
   234	
   235		ret = pcim_enable_device(pdev);
   236		if (ret) {
   237			dev_err(dev, "pcim_enable_device failed\n");
   238			goto err_pci_enable;
   239		}
   240	
   241		/* Obtain the mmio areas for the device */
   242		bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
   243		ret = pcim_iomap_regions(pdev, bar_mask, XGBE_DRV_NAME);
   244		if (ret) {
   245			dev_err(dev, "pcim_iomap_regions failed\n");
   246			goto err_pci_enable;
   247		}
   248	
   249		iomap_table = pcim_iomap_table(pdev);
   250		if (!iomap_table) {
   251			dev_err(dev, "pcim_iomap_table failed\n");
   252			ret = -ENOMEM;
   253			goto err_pci_enable;
   254		}
   255	
   256		pdata->xgmac_regs = iomap_table[XGBE_XGMAC_BAR];
   257		if (!pdata->xgmac_regs) {
   258			dev_err(dev, "xgmac ioremap failed\n");
   259			ret = -ENOMEM;
   260			goto err_pci_enable;
   261		}
   262		pdata->xprop_regs = pdata->xgmac_regs + XGBE_MAC_PROP_OFFSET;
   263		pdata->xi2c_regs = pdata->xgmac_regs + XGBE_I2C_CTRL_OFFSET;
   264		if (netif_msg_probe(pdata)) {
   265			dev_dbg(dev, "xgmac_regs = %p\n", pdata->xgmac_regs);
   266			dev_dbg(dev, "xprop_regs = %p\n", pdata->xprop_regs);
   267			dev_dbg(dev, "xi2c_regs  = %p\n", pdata->xi2c_regs);
   268		}
   269	
   270		pdata->xpcs_regs = iomap_table[XGBE_XPCS_BAR];
   271		if (!pdata->xpcs_regs) {
   272			dev_err(dev, "xpcs ioremap failed\n");
   273			ret = -ENOMEM;
   274			goto err_pci_enable;
   275		}
   276		if (netif_msg_probe(pdata))
   277			dev_dbg(dev, "xpcs_regs  = %p\n", pdata->xpcs_regs);
   278	
   279		/* Set the PCS indirect addressing definition registers */
   280		rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
   281	
   282		if (!(rdev && rdev->vendor == PCI_VENDOR_ID_AMD))
   283			goto err_pci_enable;
   284	
   285		switch (rdev->device) {
   286		case 0x15d0:
   287			pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
   288			pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
   289			break;
   290		case 0x14b5:
   291			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
   292			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
   293	
   294			/* Yellow Carp devices do not need cdr workaround */
   295			pdata->vdata->an_cdr_workaround = 0;
   296	
   297			/* Yellow Carp devices do not need rrc */
   298			pdata->vdata->enable_rrc = 0;
   299			break;
   300		case 0x1630:
   301			pdata->xpcs_window_def_reg = PCS_V2_RN_WINDOW_DEF;
   302			pdata->xpcs_window_sel_reg = PCS_V2_RN_WINDOW_SELECT;
   303			break;
   304		default:
   305			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
   306			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
   307			break;
   308		}
   309		pci_dev_put(rdev);
   310	
   311		/* Configure the PCS indirect addressing support */
   312		if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
   313			reg = XP_IOREAD(pdata, XP_PROP_0);
   314			pdata->smn_base = PCS_RN_SMN_BASE_ADDR +
   315					  (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, XP_PROP_0, PORT_ID));
 > 316			amd_smn_read(0, pdata->smn_base + (pdata->xpcs_window_def_reg), &reg);
   317		} else {
   318			reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
   319		}
   320	
   321		pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
   322		pdata->xpcs_window <<= 6;
   323		pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
   324		pdata->xpcs_window_size = 1 << (pdata->xpcs_window_size + 7);
   325		pdata->xpcs_window_mask = pdata->xpcs_window_size - 1;
   326		if (netif_msg_probe(pdata)) {
   327			dev_dbg(dev, "xpcs window def  = %#010x\n",
   328				pdata->xpcs_window_def_reg);
   329			dev_dbg(dev, "xpcs window sel  = %#010x\n",
   330				pdata->xpcs_window_sel_reg);
   331			dev_dbg(dev, "xpcs window      = %#010x\n",
   332				pdata->xpcs_window);
   333			dev_dbg(dev, "xpcs window size = %#010x\n",
   334				pdata->xpcs_window_size);
   335			dev_dbg(dev, "xpcs window mask = %#010x\n",
   336				pdata->xpcs_window_mask);
   337		}
   338	
   339		pci_set_master(pdev);
   340	
   341		/* Enable all interrupts in the hardware */
   342		XP_IOWRITE(pdata, XP_INT_EN, 0x1fffff);
   343	
   344		/* Retrieve the MAC address */
   345		ma_lo = XP_IOREAD(pdata, XP_MAC_ADDR_LO);
   346		ma_hi = XP_IOREAD(pdata, XP_MAC_ADDR_HI);
   347		pdata->mac_addr[0] = ma_lo & 0xff;
   348		pdata->mac_addr[1] = (ma_lo >> 8) & 0xff;
   349		pdata->mac_addr[2] = (ma_lo >> 16) & 0xff;
   350		pdata->mac_addr[3] = (ma_lo >> 24) & 0xff;
   351		pdata->mac_addr[4] = ma_hi & 0xff;
   352		pdata->mac_addr[5] = (ma_hi >> 8) & 0xff;
   353		if (!XP_GET_BITS(ma_hi, XP_MAC_ADDR_HI, VALID) ||
   354		    !is_valid_ether_addr(pdata->mac_addr)) {
   355			dev_err(dev, "invalid mac address\n");
   356			ret = -EINVAL;
   357			goto err_pci_enable;
   358		}
   359	
   360		/* Clock settings */
   361		pdata->sysclk_rate = XGBE_V2_DMA_CLOCK_FREQ;
   362		pdata->ptpclk_rate = XGBE_V2_PTP_CLOCK_FREQ;
   363	
   364		/* Set the DMA coherency values */
   365		pdata->coherent = 1;
   366		pdata->arcr = XGBE_DMA_PCI_ARCR;
   367		pdata->awcr = XGBE_DMA_PCI_AWCR;
   368		pdata->awarcr = XGBE_DMA_PCI_AWARCR;
   369	
   370		/* Read the port property registers */
   371		pdata->pp0 = XP_IOREAD(pdata, XP_PROP_0);
   372		pdata->pp1 = XP_IOREAD(pdata, XP_PROP_1);
   373		pdata->pp2 = XP_IOREAD(pdata, XP_PROP_2);
   374		pdata->pp3 = XP_IOREAD(pdata, XP_PROP_3);
   375		pdata->pp4 = XP_IOREAD(pdata, XP_PROP_4);
   376		if (netif_msg_probe(pdata)) {
   377			dev_dbg(dev, "port property 0 = %#010x\n", pdata->pp0);
   378			dev_dbg(dev, "port property 1 = %#010x\n", pdata->pp1);
   379			dev_dbg(dev, "port property 2 = %#010x\n", pdata->pp2);
   380			dev_dbg(dev, "port property 3 = %#010x\n", pdata->pp3);
   381			dev_dbg(dev, "port property 4 = %#010x\n", pdata->pp4);
   382		}
   383	
   384		/* Set the maximum channels and queues */
   385		pdata->tx_max_channel_count = XP_GET_BITS(pdata->pp1, XP_PROP_1,
   386							  MAX_TX_DMA);
   387		pdata->rx_max_channel_count = XP_GET_BITS(pdata->pp1, XP_PROP_1,
   388							  MAX_RX_DMA);
   389		pdata->tx_max_q_count = XP_GET_BITS(pdata->pp1, XP_PROP_1,
   390						    MAX_TX_QUEUES);
   391		pdata->rx_max_q_count = XP_GET_BITS(pdata->pp1, XP_PROP_1,
   392						    MAX_RX_QUEUES);
   393		if (netif_msg_probe(pdata)) {
   394			dev_dbg(dev, "max tx/rx channel count = %u/%u\n",
   395				pdata->tx_max_channel_count,
   396				pdata->rx_max_channel_count);
   397			dev_dbg(dev, "max tx/rx hw queue count = %u/%u\n",
   398				pdata->tx_max_q_count, pdata->rx_max_q_count);
   399		}
   400	
   401		/* Set the hardware channel and queue counts */
   402		xgbe_set_counts(pdata);
   403	
   404		/* Set the maximum fifo amounts */
   405		pdata->tx_max_fifo_size = XP_GET_BITS(pdata->pp2, XP_PROP_2,
   406						      TX_FIFO_SIZE);
   407		pdata->tx_max_fifo_size *= 16384;
   408		pdata->tx_max_fifo_size = min(pdata->tx_max_fifo_size,
   409					      pdata->vdata->tx_max_fifo_size);
   410		pdata->rx_max_fifo_size = XP_GET_BITS(pdata->pp2, XP_PROP_2,
   411						      RX_FIFO_SIZE);
   412		pdata->rx_max_fifo_size *= 16384;
   413		pdata->rx_max_fifo_size = min(pdata->rx_max_fifo_size,
   414					      pdata->vdata->rx_max_fifo_size);
   415		if (netif_msg_probe(pdata))
   416			dev_dbg(dev, "max tx/rx max fifo size = %u/%u\n",
   417				pdata->tx_max_fifo_size, pdata->rx_max_fifo_size);
   418	
   419		/* Configure interrupt support */
   420		ret = xgbe_config_irqs(pdata);
   421		if (ret)
   422			goto err_pci_enable;
   423	
   424		/* Configure the netdev resource */
   425		ret = xgbe_config_netdev(pdata);
   426		if (ret)
   427			goto err_irq_vectors;
   428	
   429		netdev_notice(pdata->netdev, "net device enabled\n");
   430	
   431		return 0;
   432	
   433	err_irq_vectors:
   434		pci_free_irq_vectors(pdata->pcidev);
   435	
   436	err_pci_enable:
   437		xgbe_free_pdata(pdata);
   438	
   439	err_alloc:
   440		dev_notice(dev, "net device not enabled\n");
   441	
   442		return ret;
   443	}
   444	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

