Return-Path: <netdev+bounces-38142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C757B98DE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 92CE1280E92
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259A374E1;
	Wed,  4 Oct 2023 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cgNT7l6w"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923AC31A96
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 23:48:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2BBC0;
	Wed,  4 Oct 2023 16:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696463307; x=1727999307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DeciXl2Atu8VXCLj4G2OA73SHmItxg7YaDBUu5u+dHo=;
  b=cgNT7l6wwMBlJXw//weht6hNDUUip/HMyxeuXHlN598s+mmnzw6dd8IC
   zE4Bu9GHPUkgW0ZpFN9W0MmayoObPgdOxwe2SvA6CrVIUbMMcSlSrD3YW
   kKZ2wPAWiHWtL9RungMkjSmO7AEvo0eOLHOj8HCEOPWL6x50ZtbHkYHMx
   iO10Zpr1jyMQ9Exw/gL8DCp2m1JV8ANPgzBob5vRs7p6CReUbT49T0I3L
   HEjkDUnlv/ibe/S4PdXdUs1PSKstyY1TO7etCiq9BZw0X/pD0DaZAD703
   FDs8snIZcW+MJ5f2auRXUs5vPJnupVzSvi3VrIOFbgScQEz3CWkphsPuJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="414312014"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="414312014"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 16:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="998710851"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="998710851"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Oct 2023 16:48:23 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qoBbI-000Kll-2c;
	Wed, 04 Oct 2023 23:48:20 +0000
Date: Thu, 5 Oct 2023 07:47:49 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
	larry.chiu@realtek.com, Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v9 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Message-ID: <202310050703.fr8Txbrs-lkp@intel.com>
References: <20230928104920.113511-13-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928104920.113511-13-justinlai0215@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Justin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/net-ethernet-realtek-rtase-Add-pci-table-supported-in-this-module/20230928-185229
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230928104920.113511-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v9 12/13] net:ethernet:realtek: Update the Makefile and Kconfig in the realtek folder
config: i386-randconfig-061-20231005 (https://download.01.org/0day-ci/archive/20231005/202310050703.fr8Txbrs-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050703.fr8Txbrs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310050703.fr8Txbrs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:203:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] addr @@     got long long @@
   drivers/net/ethernet/realtek/rtase/rtase_main.c:203:20: sparse:     expected restricted __le64 [usertype] addr
   drivers/net/ethernet/realtek/rtase/rtase_main.c:203:20: sparse:     got long long
   drivers/net/ethernet/realtek/rtase/rtase_main.c:362:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le64 [usertype] addr @@     got long long @@
   drivers/net/ethernet/realtek/rtase/rtase_main.c:362:29: sparse:     expected restricted __le64 [usertype] addr
   drivers/net/ethernet/realtek/rtase/rtase_main.c:362:29: sparse:     got long long
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:686:37: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:687:37: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:692:19: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:694:37: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:708:27: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:710:27: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:727:35: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:729:35: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:732:35: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:734:35: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1580:19: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1584:37: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1614:29: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1614:29: sparse: sparse: cast from restricted __le32
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1615:36: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1615:36: sparse: sparse: cast from restricted __le16
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1616:35: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1616:35: sparse: sparse: cast from restricted __le16

vim +203 drivers/net/ethernet/realtek/rtase/rtase_main.c

1f431ee317f33f Justin Lai 2023-09-28  195  
29576bc3be86aa Justin Lai 2023-09-28  196  static void rtase_unmap_tx_skb(struct pci_dev *pdev, u32 len,
29576bc3be86aa Justin Lai 2023-09-28  197  			       struct tx_desc *desc)
29576bc3be86aa Justin Lai 2023-09-28  198  {
29576bc3be86aa Justin Lai 2023-09-28  199  	dma_unmap_single(&pdev->dev, le64_to_cpu(desc->addr), len,
29576bc3be86aa Justin Lai 2023-09-28  200  			 DMA_TO_DEVICE);
29576bc3be86aa Justin Lai 2023-09-28  201  	desc->opts1 = cpu_to_le32(RTK_OPTS1_DEBUG_VALUE);
29576bc3be86aa Justin Lai 2023-09-28  202  	desc->opts2 = 0x00;
29576bc3be86aa Justin Lai 2023-09-28 @203  	desc->addr = RTK_MAGIC_NUMBER;
29576bc3be86aa Justin Lai 2023-09-28  204  }
29576bc3be86aa Justin Lai 2023-09-28  205  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

