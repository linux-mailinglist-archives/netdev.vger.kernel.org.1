Return-Path: <netdev+bounces-193290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A57AC3773
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 02:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D33A83CE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 00:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA835975;
	Mon, 26 May 2025 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBJfRQh0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EB1BC5C;
	Mon, 26 May 2025 00:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748219805; cv=none; b=ixbzgVgoLYootkBUgCosFECBdRjsjnwMkL0Gk9mtvXwKfzF+P7h2EPQZqXNAuZFzqICLVNy7UlNttM9qfUzNru8TSRvIaX4grISN/nCiVtFovw3uzs4pHlLVXZekvGjgTzmI2ZG/WhE382gCAy/F6ba5UIZsd5KHgJ+WbShiA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748219805; c=relaxed/simple;
	bh=PWmxnlgfXVQMFwih64+oIqpx6GC1/1WEm1ZUh1+lD90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6bSqgZJyWYffF6+EwvIg3rPp3cSNpipXUCLssUq+59HP5dvO0OT6hFEtVKCZPptvLf7q08k30xGbbhjLpNR4fXaWebi+m0OtGhY/Dl4FtVDS5tLS3rcB+RxmYM8cE0k+syhbQkq7YTSgACkql6KRblBgAd5N4qENr9MYSnAqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBJfRQh0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748219804; x=1779755804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PWmxnlgfXVQMFwih64+oIqpx6GC1/1WEm1ZUh1+lD90=;
  b=kBJfRQh0+loaa5T0ceu3/6IaKZhkqhBu3aFlfvUVrHLu4IRaShePm3jL
   uK4bTg29PwB9plVozCr67m1hCgGwvylHnoJC3omygkeg/kCkASP2mn8Xq
   wmruw/s3XtkQQRJbT5IJWjgRnnx4H5bLyZ/luWrXvHmhbbizu1r+DhfUn
   /A4yF5SXW1wCe8n/6J2UouN4OSPJ/BcYZD/Ra4BxeqDOomRW5Wj5SBHHo
   G41DHmnrkPy2Y7agx7l8wD5+5bLDkLW3btB/X2FxhTbBH+/os5JrPmgGC
   X5AQzWTdvCb8KO6t09oN2B4+lCZ1Qaxydlt/iowPgdICepQJdWN19BMuv
   A==;
X-CSE-ConnectionGUID: fWxzr7KGRce9oSlGf1nYTw==
X-CSE-MsgGUID: Lq9onlxJQliD4+eNauzD2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="67739674"
X-IronPort-AV: E=Sophos;i="6.15,314,1739865600"; 
   d="scan'208";a="67739674"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2025 17:36:43 -0700
X-CSE-ConnectionGUID: nxxMPxjcSEOwAFrehzbeGA==
X-CSE-MsgGUID: B4+C7AphS5OWTk0wdO38Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,314,1739865600"; 
   d="scan'208";a="142594031"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 May 2025 17:36:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJLpU-000S32-36;
	Mon, 26 May 2025 00:36:36 +0000
Date: Mon, 26 May 2025 08:36:19 +0800
From: kernel test robot <lkp@intel.com>
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vkoul@kernel.org, michal.simek@amd.com,
	sean.anderson@linux.dev, radhey.shyam.pandey@amd.com,
	horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net-next] net: xilinx: axienet: Configure and report
 coalesce parameters in DMAengine flow
Message-ID: <202505260804.Mhztve8t-lkp@intel.com>
References: <20250525102217.1181104-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250525102217.1181104-1-suraj.gupta2@amd.com>

Hi Suraj,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Suraj-Gupta/net-xilinx-axienet-Configure-and-report-coalesce-parameters-in-DMAengine-flow/20250525-182400
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250525102217.1181104-1-suraj.gupta2%40amd.com
patch subject: [PATCH net-next] net: xilinx: axienet: Configure and report coalesce parameters in DMAengine flow
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250526/202505260804.Mhztve8t-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250526/202505260804.Mhztve8t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505260804.Mhztve8t-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/xilinx/xilinx_axienet_main.c: In function 'axienet_init_dmaengine':
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1524:18: error: 'struct dma_slave_config' has no member named 'coalesce_cnt'
    1524 |         tx_config.coalesce_cnt = XAXIDMAENGINE_DFT_TX_THRESHOLD;
         |                  ^
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1525:18: error: 'struct dma_slave_config' has no member named 'coalesce_usecs'
    1525 |         tx_config.coalesce_usecs = XAXIDMAENGINE_DFT_TX_USEC;
         |                  ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1526:18: error: 'struct dma_slave_config' has no member named 'coalesce_cnt'
    1526 |         rx_config.coalesce_cnt = XAXIDMAENGINE_DFT_RX_THRESHOLD;
         |                  ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1527:18: error: 'struct dma_slave_config' has no member named 'coalesce_usecs'
    1527 |         rx_config.coalesce_usecs =  XAXIDMAENGINE_DFT_RX_USEC;
         |                  ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c: In function 'axienet_ethtools_get_coalesce':
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2196:61: error: 'struct dma_slave_caps' has no member named 'coalesce_cnt'
    2196 |                 ecoalesce->tx_max_coalesced_frames = tx_caps.coalesce_cnt;
         |                                                             ^
>> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2197:55: error: 'struct dma_slave_caps' has no member named 'coalesce_usecs'
    2197 |                 ecoalesce->tx_coalesce_usecs = tx_caps.coalesce_usecs;
         |                                                       ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2198:61: error: 'struct dma_slave_caps' has no member named 'coalesce_cnt'
    2198 |                 ecoalesce->rx_max_coalesced_frames = rx_caps.coalesce_cnt;
         |                                                             ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2199:55: error: 'struct dma_slave_caps' has no member named 'coalesce_usecs'
    2199 |                 ecoalesce->rx_coalesce_usecs = rx_caps.coalesce_usecs;
         |                                                       ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c: In function 'axienet_ethtools_set_coalesce':
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2270:23: error: 'struct dma_slave_config' has no member named 'coalesce_cnt'
    2270 |                 tx_cfg.coalesce_cnt = ecoalesce->tx_max_coalesced_frames;
         |                       ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2271:23: error: 'struct dma_slave_config' has no member named 'coalesce_usecs'
    2271 |                 tx_cfg.coalesce_usecs = ecoalesce->tx_coalesce_usecs;
         |                       ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2272:23: error: 'struct dma_slave_config' has no member named 'coalesce_cnt'
    2272 |                 rx_cfg.coalesce_cnt = ecoalesce->rx_max_coalesced_frames;
         |                       ^
   drivers/net/ethernet/xilinx/xilinx_axienet_main.c:2273:23: error: 'struct dma_slave_config' has no member named 'coalesce_usecs'
    2273 |                 rx_cfg.coalesce_usecs = ecoalesce->rx_coalesce_usecs;
         |                       ^


vim +1524 drivers/net/ethernet/xilinx/xilinx_axienet_main.c

  1494	
  1495	/**
  1496	 * axienet_init_dmaengine - init the dmaengine code.
  1497	 * @ndev:       Pointer to net_device structure
  1498	 *
  1499	 * Return: 0, on success.
  1500	 *          non-zero error value on failure
  1501	 *
  1502	 * This is the dmaengine initialization code.
  1503	 */
  1504	static int axienet_init_dmaengine(struct net_device *ndev)
  1505	{
  1506		struct axienet_local *lp = netdev_priv(ndev);
  1507		struct skbuf_dma_descriptor *skbuf_dma;
  1508		struct dma_slave_config tx_config, rx_config;
  1509		int i, ret;
  1510	
  1511		lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
  1512		if (IS_ERR(lp->tx_chan)) {
  1513			dev_err(lp->dev, "No Ethernet DMA (TX) channel found\n");
  1514			return PTR_ERR(lp->tx_chan);
  1515		}
  1516	
  1517		lp->rx_chan = dma_request_chan(lp->dev, "rx_chan0");
  1518		if (IS_ERR(lp->rx_chan)) {
  1519			ret = PTR_ERR(lp->rx_chan);
  1520			dev_err(lp->dev, "No Ethernet DMA (RX) channel found\n");
  1521			goto err_dma_release_tx;
  1522		}
  1523	
> 1524		tx_config.coalesce_cnt = XAXIDMAENGINE_DFT_TX_THRESHOLD;
> 1525		tx_config.coalesce_usecs = XAXIDMAENGINE_DFT_TX_USEC;
> 1526		rx_config.coalesce_cnt = XAXIDMAENGINE_DFT_RX_THRESHOLD;
> 1527		rx_config.coalesce_usecs =  XAXIDMAENGINE_DFT_RX_USEC;
  1528	
  1529		ret = dmaengine_slave_config(lp->tx_chan, &tx_config);
  1530		if (ret) {
  1531			dev_err(lp->dev, "Failed to configure Tx coalesce parameters\n");
  1532			goto err_dma_release_tx;
  1533		}
  1534		ret = dmaengine_slave_config(lp->rx_chan, &rx_config);
  1535		if (ret) {
  1536			dev_err(lp->dev, "Failed to configure Rx coalesce parameters\n");
  1537			goto err_dma_release_tx;
  1538		}
  1539	
  1540		lp->tx_ring_tail = 0;
  1541		lp->tx_ring_head = 0;
  1542		lp->rx_ring_tail = 0;
  1543		lp->rx_ring_head = 0;
  1544		lp->tx_skb_ring = kcalloc(TX_BD_NUM_MAX, sizeof(*lp->tx_skb_ring),
  1545					  GFP_KERNEL);
  1546		if (!lp->tx_skb_ring) {
  1547			ret = -ENOMEM;
  1548			goto err_dma_release_rx;
  1549		}
  1550		for (i = 0; i < TX_BD_NUM_MAX; i++) {
  1551			skbuf_dma = kzalloc(sizeof(*skbuf_dma), GFP_KERNEL);
  1552			if (!skbuf_dma) {
  1553				ret = -ENOMEM;
  1554				goto err_free_tx_skb_ring;
  1555			}
  1556			lp->tx_skb_ring[i] = skbuf_dma;
  1557		}
  1558	
  1559		lp->rx_skb_ring = kcalloc(RX_BUF_NUM_DEFAULT, sizeof(*lp->rx_skb_ring),
  1560					  GFP_KERNEL);
  1561		if (!lp->rx_skb_ring) {
  1562			ret = -ENOMEM;
  1563			goto err_free_tx_skb_ring;
  1564		}
  1565		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++) {
  1566			skbuf_dma = kzalloc(sizeof(*skbuf_dma), GFP_KERNEL);
  1567			if (!skbuf_dma) {
  1568				ret = -ENOMEM;
  1569				goto err_free_rx_skb_ring;
  1570			}
  1571			lp->rx_skb_ring[i] = skbuf_dma;
  1572		}
  1573		/* TODO: Instead of BD_NUM_DEFAULT use runtime support */
  1574		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
  1575			axienet_rx_submit_desc(ndev);
  1576		dma_async_issue_pending(lp->rx_chan);
  1577	
  1578		return 0;
  1579	
  1580	err_free_rx_skb_ring:
  1581		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
  1582			kfree(lp->rx_skb_ring[i]);
  1583		kfree(lp->rx_skb_ring);
  1584	err_free_tx_skb_ring:
  1585		for (i = 0; i < TX_BD_NUM_MAX; i++)
  1586			kfree(lp->tx_skb_ring[i]);
  1587		kfree(lp->tx_skb_ring);
  1588	err_dma_release_rx:
  1589		dma_release_channel(lp->rx_chan);
  1590	err_dma_release_tx:
  1591		dma_release_channel(lp->tx_chan);
  1592		return ret;
  1593	}
  1594	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

