Return-Path: <netdev+bounces-56661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3549B81065D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666C81C20CCC
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D3191;
	Wed, 13 Dec 2023 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEHZrqdP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D239C19A5
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 16:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702426577; x=1733962577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQ95E3bjLhv0mxNO54t15w5AjtMTiN3wjABB9e7EUaQ=;
  b=eEHZrqdPnXWbB9L31TPvztKmM3JQYZAqFcblRHGqyY9+ZMG9xzSPdGA9
   VYB9IM6lQ7wUnfpqncd0lURtlxD7HZLdLvFdJreQSV5Su+zE5SEwuOCYl
   sSbEAP9pQWmo3bqpmPCZrN/EQJq8hXItFKgev7ydUqMBts5zp7hlfritn
   3hEhS0bqawrQuNpTTUSllpqTClDU7mGU9Qo9miifmJ+5SqYLLw5vQ3OPE
   VzfL7WAtDBoBFh1CoFXGhrD4iNh6lcqlv3G/5XD9Cfm0/6FPYor/DJ2qI
   Tx6pyOA4fVWgs6o1IqBR3c09EXFoMrhELuOPCbGALOt5cuwwC8+Ywdx4N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1968144"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1968144"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 16:16:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="21727159"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 12 Dec 2023 16:16:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDCv5-000Jsl-0q;
	Wed, 13 Dec 2023 00:16:11 +0000
Date: Wed, 13 Dec 2023 08:15:30 +0800
From: kernel test robot <lkp@intel.com>
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: oe-kbuild-all@lists.linux.dev, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
	Jonathan Cooper <jonathan.s.cooper@amd.com>
Subject: Re: [PATCH net-next 4/7] sfc: debugfs for (nic) TX queues
Message-ID: <202312130801.r8TbjUfD-lkp@intel.com>
References: <91beef38162b8e243c2275b41a6f37c01f19850f.1702314695.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91beef38162b8e243c2275b41a6f37c01f19850f.1702314695.git.ecree.xilinx@gmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/edward-cree-amd-com/sfc-initial-debugfs-implementation/20231212-013223
base:   net-next/main
patch link:    https://lore.kernel.org/r/91beef38162b8e243c2275b41a6f37c01f19850f.1702314695.git.ecree.xilinx%40gmail.com
patch subject: [PATCH net-next 4/7] sfc: debugfs for (nic) TX queues
config: mips-ip27_defconfig (https://download.01.org/0day-ci/archive/20231213/202312130801.r8TbjUfD-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312130801.r8TbjUfD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130801.r8TbjUfD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/sfc/efx.c:36:
>> drivers/net/ethernet/sfc/debugfs.h:68:5: warning: no previous prototype for 'efx_init_debugfs_tx_queue' [-Wmissing-prototypes]
      68 | int efx_init_debugfs_tx_queue(struct efx_tx_queue *tx_queue)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/sfc/debugfs.h:72:6: warning: no previous prototype for 'efx_fini_debugfs_tx_queue' [-Wmissing-prototypes]
      72 | void efx_fini_debugfs_tx_queue(struct efx_tx_queue *tx_queue) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/debugfs.h:74:5: warning: no previous prototype for 'efx_init_debugfs_rx_queue' [-Wmissing-prototypes]
      74 | int efx_init_debugfs_rx_queue(struct efx_rx_queue *rx_queue)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/debugfs.h:78:6: warning: no previous prototype for 'efx_fini_debugfs_rx_queue' [-Wmissing-prototypes]
      78 | void efx_fini_debugfs_rx_queue(struct efx_rx_queue *rx_queue) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/debugfs.h:80:5: warning: no previous prototype for 'efx_init_debugfs_channel' [-Wmissing-prototypes]
      80 | int efx_init_debugfs_channel(struct efx_channel *channel)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/sfc/debugfs.h:84:6: warning: no previous prototype for 'efx_fini_debugfs_channel' [-Wmissing-prototypes]
      84 | void efx_fini_debugfs_channel(struct efx_channel *channel) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/efx_init_debugfs_tx_queue +68 drivers/net/ethernet/sfc/debugfs.h

    67	
  > 68	int efx_init_debugfs_tx_queue(struct efx_tx_queue *tx_queue)
    69	{
    70		return 0;
    71	}
  > 72	void efx_fini_debugfs_tx_queue(struct efx_tx_queue *tx_queue) {}
    73	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

