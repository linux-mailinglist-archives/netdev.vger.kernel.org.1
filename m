Return-Path: <netdev+bounces-22512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160E767DC9
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D046F282784
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3E1078E;
	Sat, 29 Jul 2023 09:56:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865BC2E3
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 09:56:23 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3123DE
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690624581; x=1722160581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lYIdpUI6ON6LSWkOvjPT6/fKgb2akcDCdX/fI1Rv+8E=;
  b=OTyi3nGI5JQXt1+krBTsp7v6AoWMpGqHzCH+AEzl9ESaCKXkNeKQWRmv
   FfndVaGhUMPfTa4TnUrdZRMR4dKg1FbT28LpDSfOW3FeVnRx3uLeiMw/G
   d/6FY3KclznJghjZpZfzrrVdCeHZhghJl38nhSv3S9HdJml5Zq031SrZV
   2pqxvcY90ZRJjVUZbLxzJomV1UuLeiNwY/5HSNUsOOalC+3OBCP0L2yBo
   o8K9k3HSDCoJ/I12WVT7AbyenWR7lb30t4Jz+ok7GjHBjNIYUIIHr3DMM
   TyPtOLwXm4jGjLDaTLyj1VduPJcO7mpgLkQ6m+BCsW9qbVrxEETz1vbx3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="349044925"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="349044925"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 02:56:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="851501028"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="851501028"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Jul 2023 02:56:19 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qPggM-0003xr-2P;
	Sat, 29 Jul 2023 09:56:18 +0000
Date: Sat, 29 Jul 2023 17:55:57 +0800
From: kernel test robot <lkp@intel.com>
To: Amritha Nambiar <amritha.nambiar@intel.com>, netdev@vger.kernel.org,
	kuba@kernel.org, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com
Subject: Re: [net-next PATCH v1 1/9] net: Introduce new fields for napi and
 queue associations
Message-ID: <202307291714.SUP7uQyV-lkp@intel.com>
References: <169059161688.3736.18170697577939556255.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169059161688.3736.18170697577939556255.stgit@anambiarhost.jf.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Amritha,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Amritha-Nambiar/net-Introduce-new-fields-for-napi-and-queue-associations/20230729-083646
base:   net-next/main
patch link:    https://lore.kernel.org/r/169059161688.3736.18170697577939556255.stgit%40anambiarhost.jf.intel.com
patch subject: [net-next PATCH v1 1/9] net: Introduce new fields for napi and queue associations
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230729/202307291714.SUP7uQyV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291714.SUP7uQyV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291714.SUP7uQyV-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/infiniband/sw/rxe/rxe_comp.c:11:
>> drivers/infiniband/sw/rxe/rxe_queue.h:53:6: error: redeclaration of 'enum queue_type'
      53 | enum queue_type {
         |      ^~~~~~~~~~
   In file included from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:94,
                    from include/net/ipv6.h:12,
                    from include/rdma/ib_verbs.h:25,
                    from drivers/infiniband/sw/rxe/rxe.h:17,
                    from drivers/infiniband/sw/rxe/rxe_comp.c:9:
   include/linux/netdevice.h:348:6: note: originally defined here
     348 | enum queue_type {
         |      ^~~~~~~~~~


vim +53 drivers/infiniband/sw/rxe/rxe_queue.h

8700e3e7c4857d Moni Shoua  2016-06-16   9  
ae6e843fe08d0e Bob Pearson 2021-09-14  10  /* Implements a simple circular buffer that is shared between user
ae6e843fe08d0e Bob Pearson 2021-09-14  11   * and the driver and can be resized. The requested element size is
ae6e843fe08d0e Bob Pearson 2021-09-14  12   * rounded up to a power of 2 and the number of elements in the buffer
ae6e843fe08d0e Bob Pearson 2021-09-14  13   * is also rounded up to a power of 2. Since the queue is empty when
ae6e843fe08d0e Bob Pearson 2021-09-14  14   * the producer and consumer indices match the maximum capacity of the
ae6e843fe08d0e Bob Pearson 2021-09-14  15   * queue is one less than the number of element slots.
5bcf5a59c41e19 Bob Pearson 2021-05-27  16   *
5bcf5a59c41e19 Bob Pearson 2021-05-27  17   * Notes:
ae6e843fe08d0e Bob Pearson 2021-09-14  18   *   - The driver indices are always masked off to q->index_mask
5bcf5a59c41e19 Bob Pearson 2021-05-27  19   *     before storing so do not need to be checked on reads.
ae6e843fe08d0e Bob Pearson 2021-09-14  20   *   - The user whether user space or kernel is generally
ae6e843fe08d0e Bob Pearson 2021-09-14  21   *     not trusted so its parameters are masked to make sure
ae6e843fe08d0e Bob Pearson 2021-09-14  22   *     they do not access the queue out of bounds on reads.
ae6e843fe08d0e Bob Pearson 2021-09-14  23   *   - The driver indices for queues must not be written
ae6e843fe08d0e Bob Pearson 2021-09-14  24   *     by user so a local copy is used and a shared copy is
ae6e843fe08d0e Bob Pearson 2021-09-14  25   *     stored when the local copy is changed.
5bcf5a59c41e19 Bob Pearson 2021-05-27  26   *   - By passing the type in the parameter list separate from q
5bcf5a59c41e19 Bob Pearson 2021-05-27  27   *     the compiler can eliminate the switch statement when the
ae6e843fe08d0e Bob Pearson 2021-09-14  28   *     actual queue type is known when the function is called at
ae6e843fe08d0e Bob Pearson 2021-09-14  29   *     compile time.
ae6e843fe08d0e Bob Pearson 2021-09-14  30   *   - These queues are lock free. The user and driver must protect
ae6e843fe08d0e Bob Pearson 2021-09-14  31   *     changes to their end of the queues with locks if more than one
ae6e843fe08d0e Bob Pearson 2021-09-14  32   *     CPU can be accessing it at the same time.
8700e3e7c4857d Moni Shoua  2016-06-16  33   */
8700e3e7c4857d Moni Shoua  2016-06-16  34  
ae6e843fe08d0e Bob Pearson 2021-09-14  35  /**
ae6e843fe08d0e Bob Pearson 2021-09-14  36   * enum queue_type - type of queue
ae6e843fe08d0e Bob Pearson 2021-09-14  37   * @QUEUE_TYPE_TO_CLIENT:	Queue is written by rxe driver and
a77a52385e9a76 Bob Pearson 2023-02-14  38   *				read by client which may be a user space
a77a52385e9a76 Bob Pearson 2023-02-14  39   *				application or a kernel ulp.
a77a52385e9a76 Bob Pearson 2023-02-14  40   *				Used by rxe internals only.
ae6e843fe08d0e Bob Pearson 2021-09-14  41   * @QUEUE_TYPE_FROM_CLIENT:	Queue is written by client and
a77a52385e9a76 Bob Pearson 2023-02-14  42   *				read by rxe driver.
a77a52385e9a76 Bob Pearson 2023-02-14  43   *				Used by rxe internals only.
a77a52385e9a76 Bob Pearson 2023-02-14  44   * @QUEUE_TYPE_FROM_ULP:	Queue is written by kernel ulp and
a77a52385e9a76 Bob Pearson 2023-02-14  45   *				read by rxe driver.
a77a52385e9a76 Bob Pearson 2023-02-14  46   *				Used by kernel verbs APIs only on
a77a52385e9a76 Bob Pearson 2023-02-14  47   *				behalf of ulps.
a77a52385e9a76 Bob Pearson 2023-02-14  48   * @QUEUE_TYPE_TO_ULP:		Queue is written by rxe driver and
a77a52385e9a76 Bob Pearson 2023-02-14  49   *				read by kernel ulp.
a77a52385e9a76 Bob Pearson 2023-02-14  50   *				Used by kernel verbs APIs only on
a77a52385e9a76 Bob Pearson 2023-02-14  51   *				behalf of ulps.
ae6e843fe08d0e Bob Pearson 2021-09-14  52   */
59daff49f25fbb Bob Pearson 2021-05-27 @53  enum queue_type {
ae6e843fe08d0e Bob Pearson 2021-09-14  54  	QUEUE_TYPE_TO_CLIENT,
ae6e843fe08d0e Bob Pearson 2021-09-14  55  	QUEUE_TYPE_FROM_CLIENT,
a77a52385e9a76 Bob Pearson 2023-02-14  56  	QUEUE_TYPE_FROM_ULP,
a77a52385e9a76 Bob Pearson 2023-02-14  57  	QUEUE_TYPE_TO_ULP,
59daff49f25fbb Bob Pearson 2021-05-27  58  };
59daff49f25fbb Bob Pearson 2021-05-27  59  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

