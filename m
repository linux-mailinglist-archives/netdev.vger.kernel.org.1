Return-Path: <netdev+bounces-32343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ED3794608
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 00:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D261C20957
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 22:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F820125B2;
	Wed,  6 Sep 2023 22:14:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D011CB8
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 22:14:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D7919BA
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694038449; x=1725574449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zpsofr5YQS7XviEdlyUuI4LanVZQY/6bAIVyEtREdJE=;
  b=kx7EPKuQpX4Z4MqfkoFYXdeq+u+oVA9KX1+W6hjIsmm06WyS7MSOC+yw
   +TBjnRjX1XbdgPS366RULNOadiJ7ilJxX4+7M1tT5F5TefWyxiRiVALCX
   KuTa4Kl9YniYCcR60U2irW2+0CuOO6+mmoSs6lnievepXg+oFbczTL3mr
   Z5i7+sGaczDni8b/j6b6eLB0t2C/r9UQTVlhJFQqj0giiY5wvGfbKBQ4A
   pi2mNhm+bjAve1WkaATeQloKbCuGH6gbMvELGOF3pOA/F6yeRjnb8iA2k
   bUbAVhzWwwdejEwM9wx1X9sP52loQcyGXBudVwf+81Jni+v+fhO240qYd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="377110541"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="377110541"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 15:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741744354"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="741744354"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2023 15:14:06 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qe0mi-0000dP-17;
	Wed, 06 Sep 2023 22:14:04 +0000
Date: Thu, 7 Sep 2023 06:13:51 +0800
From: kernel test robot <lkp@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>, richardcochran@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com, netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com, reibax@gmail.com
Subject: Re: [PATCH 2/3] ptp: support multiple timestamp event readers
Message-ID: <202309070650.eysYMNnu-lkp@intel.com>
References: <20230906104754.1324412-3-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906104754.1324412-3-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Xabier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master horms-ipvs/master v6.5 next-20230906]
[cannot apply to shuah-kselftest/next shuah-kselftest/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xabier-Marquiegui/ptp-support-multiple-timestamp-event-readers/20230906-194848
base:   net/main
patch link:    https://lore.kernel.org/r/20230906104754.1324412-3-reibax%40gmail.com
patch subject: [PATCH 2/3] ptp: support multiple timestamp event readers
config: i386-randconfig-061-20230906 (https://download.01.org/0day-ci/archive/20230907/202309070650.eysYMNnu-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070650.eysYMNnu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070650.eysYMNnu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/ptp/ptp_chardev.c:487:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   drivers/ptp/ptp_chardev.c:487:24: sparse:     expected restricted __poll_t
   drivers/ptp/ptp_chardev.c:487:24: sparse:     got int

vim +487 drivers/ptp/ptp_chardev.c

   464	
   465	__poll_t ptp_poll(struct posix_clock *pc, struct file *fp, poll_table *wait)
   466	{
   467		struct ptp_clock *ptp = container_of(pc, struct ptp_clock, clock);
   468		struct timestamp_event_queue *queue;
   469		struct list_head *pos, *n;
   470		bool found = false;
   471		pid_t reader_pid = task_pid_nr(current);
   472	
   473		poll_wait(fp, &ptp->tsev_wq, wait);
   474	
   475		/*
   476		 * Extract only the desired element in the queue list
   477		 */
   478		list_for_each_safe(pos, n, &ptp->tsevqs) {
   479			queue = list_entry(pos, struct timestamp_event_queue, qlist);
   480			if (queue->reader_pid == reader_pid) {
   481				found = true;
   482				break;
   483			}
   484		}
   485	
   486		if (!found)
 > 487			return -EINVAL;
   488	
   489		return queue_cnt(queue) ? EPOLLIN : 0;
   490	}
   491	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

