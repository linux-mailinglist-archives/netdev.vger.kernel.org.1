Return-Path: <netdev+bounces-14700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7374330F
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 05:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078CE1C20B7B
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 03:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097EA10FB;
	Fri, 30 Jun 2023 03:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02D717F5
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 03:20:20 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81A235BD;
	Thu, 29 Jun 2023 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688095215; x=1719631215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CleN5csZxWjHwwb4MOnNoiZ8h4BJOgyw+uua6zQ7x1U=;
  b=dmb9jSCGAhVd+Z6Ofg2gyEHPv+o+iNRBvAA7PwMBDckklm/UKBczl9Gd
   1129se0+DxmPHzeavViix8pf5zXzCy5l77R2ZxZ4nMfQZX6RZdKO8+wia
   mzyukiEbM7hVyQt08ufBFA9xcfMq9k605PZXB/vmENgQTAgJHMR4Y89BT
   EbAJoOVlglb2C32dOZ36NnQa/fZ/IWwu9SpH4fSEN4OK8FKjrtCQgxZaA
   yQme1vOZro/56GZ4VUyEp2zgeHbufDskctSBen8VaJGqWjOg4KPzSNhbw
   awqTPR5VhPNGiEf5dXKbMDKAElsm7rRKQ+EqEjJ5e/SsorFJbCwAizf1P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="393027491"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="393027491"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 20:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="1048058620"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="1048058620"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2023 20:20:10 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qF4g5-000Ee1-1N;
	Fri, 30 Jun 2023 03:20:09 +0000
Date: Fri, 30 Jun 2023 11:19:32 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Hu <weh@microsoft.com>, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
	longli@microsoft.com, sharmaajay@microsoft.com, jgg@ziepe.ca,
	leon@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vkuznets@redhat.com, ssengar@linux.microsoft.com,
	shradhagupta@linux.microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib
 driver.
Message-ID: <202306301145.qNZGZ0MP-lkp@intel.com>
References: <20230615111412.1687573-1-weh@microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615111412.1687573-1-weh@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on horms-ipvs/master v6.4 next-20230629]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Hu/RDMA-mana_ib-Add-EQ-interrupt-support-to-mana-ib-driver/20230615-191709
base:   linus/master
patch link:    https://lore.kernel.org/r/20230615111412.1687573-1-weh%40microsoft.com
patch subject: [PATCH v3 1/1] RDMA/mana_ib: Add EQ interrupt support to mana ib driver.
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230630/202306301145.qNZGZ0MP-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306301145.qNZGZ0MP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306301145.qNZGZ0MP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/hw/mana/main.c:150:20: warning: unused variable 'ibdev' [-Wunused-variable]
           struct ib_device *ibdev = ucontext->ibucontext.device;
                             ^
   1 warning generated.


vim +/ibdev +150 drivers/infiniband/hw/mana/main.c

   145	
   146	static void mana_ib_destroy_eq(struct mana_ib_ucontext *ucontext,
   147				       struct mana_ib_dev *mdev)
   148	{
   149		struct gdma_context *gc = mdev->gdma_dev->gdma_context;
 > 150		struct ib_device *ibdev = ucontext->ibucontext.device;
   151		struct gdma_queue *eq;
   152		int i;
   153	
   154		if (!ucontext->eqs)
   155			return;
   156	
   157		for (i = 0; i < gc->max_num_queues; i++) {
   158			eq = ucontext->eqs[i].eq;
   159			if (!eq)
   160				continue;
   161	
   162			mana_gd_destroy_queue(gc, eq);
   163		}
   164	
   165		kfree(ucontext->eqs);
   166		ucontext->eqs = NULL;
   167	}
   168	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

