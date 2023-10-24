Return-Path: <netdev+bounces-43914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9C57D56FF
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 17:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9638FB20F06
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26DA38DD7;
	Tue, 24 Oct 2023 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koeL6VnG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611591D6A9;
	Tue, 24 Oct 2023 15:56:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91FE83;
	Tue, 24 Oct 2023 08:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698162974; x=1729698974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SddTswXNy85QoKJZdafbQk9nSfChueXqS/eU+G7CMYg=;
  b=koeL6VnGVGJKMm0OZoKUANAQAtyXmNPmeVBL333MTn7PKsKdezKzflx6
   PffPi4bDwB/pV3+9SlP/LlDdTxBdS9+hHIld92T37DDTv1WOAKOElxcVO
   Nc+IvFHWx1xknjlumgNufiFkY0I/Nakl4/TW2RS/kDw3weY1t1Ddq1f8i
   aV1bZ0zLIROX+kSHF7Az3+gnIEBM6TuJizN8ahYQ/o/GktRwpmoZGWSOx
   rzRJ8cFfN3yaFTZZTZGgsS815HD1b+k3+QSlY0kQkM35LtuqaaqeXQgWJ
   kMdeBAH4ZpyeCd3r5i8dJUTXo7es/j6G4pQyS/oF2sQMR831RQbDBZiVH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5719680"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="5719680"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758510350"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="758510350"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Oct 2023 08:56:07 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qvJlF-0007yD-1U;
	Tue, 24 Oct 2023 15:56:05 +0000
Date: Tue, 24 Oct 2023 23:55:30 +0800
From: kernel test robot <lkp@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Romain Gantois <romain.gantois@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 3/5] net: ipqess: introduce the Qualcomm IPQESS
 driver
Message-ID: <202310242300.y8Z3ImgQ-lkp@intel.com>
References: <20231023155013.512999-4-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023155013.512999-4-romain.gantois@bootlin.com>

Hi Romain,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Romain-Gantois/net-dt-bindings-Introduce-the-Qualcomm-IPQESS-Ethernet-switch/20231023-235323
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231023155013.512999-4-romain.gantois%40bootlin.com
patch subject: [PATCH net-next 3/5] net: ipqess: introduce the Qualcomm IPQESS driver
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20231024/202310242300.y8Z3ImgQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310242300.y8Z3ImgQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310242300.y8Z3ImgQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c: In function 'ipqess_edma_rx_buf_prepare':
>> drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c:156:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     156 |                         (struct ipqess_edma_rx_desc *)buf->dma;
         |                         ^


vim +156 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c

   139	
   140	static int ipqess_edma_rx_buf_prepare(struct ipqess_edma_buf *buf,
   141					      struct ipqess_edma_rx_ring *rx_ring)
   142	{
   143		memset(buf->skb->data, 0, sizeof(struct ipqess_edma_rx_desc));
   144	
   145		buf->dma = dma_map_single(rx_ring->ppdev, buf->skb->data,
   146					  IPQESS_EDMA_RX_HEAD_BUFF_SIZE,
   147					  DMA_FROM_DEVICE);
   148		if (dma_mapping_error(rx_ring->ppdev, buf->dma)) {
   149			dev_kfree_skb_any(buf->skb);
   150			buf->skb = NULL;
   151			return -EFAULT;
   152		}
   153	
   154		buf->length = IPQESS_EDMA_RX_HEAD_BUFF_SIZE;
   155		rx_ring->hw_desc[rx_ring->head] =
 > 156				(struct ipqess_edma_rx_desc *)buf->dma;
   157		rx_ring->head = (rx_ring->head + 1) % IPQESS_EDMA_RX_RING_SIZE;
   158	
   159		ipqess_edma_m32(rx_ring->edma, IPQESS_EDMA_RFD_PROD_IDX_BITS,
   160				(rx_ring->head + IPQESS_EDMA_RX_RING_SIZE - 1)
   161				% IPQESS_EDMA_RX_RING_SIZE,
   162				IPQESS_EDMA_REG_RFD_IDX_Q(rx_ring->idx));
   163	
   164		return 0;
   165	}
   166	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

