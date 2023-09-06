Return-Path: <netdev+bounces-32332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE47942F4
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 20:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0C628155A
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 18:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5186C11197;
	Wed,  6 Sep 2023 18:18:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02E11182
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 18:18:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243EE6A
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694024333; x=1725560333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGNaPyfct9ZA6Jx8Fm3wIdCt4INUWzy/QTzzBAziiG4=;
  b=df/N/Suuexq9xB8Y/NoeggrTc9F/Pjrr2tZChm5T603JJBNbMOcqy3ed
   Wnw5B1yXBd/eqbrKScTcdhIUmbkvB7rltyYv/McHW++oIZqr8z7EIzoqc
   A0gj9b+OGIGpIJYn0L92OUzy7xhiWPYbBlfjqD1uauTSDhWojTQrSflPA
   OjCRcq3Ngs8xLThTzpX7nh9mpaNoe2/rBKdJ/198EbAaXisz5z7RpRBr9
   sqMuQfZANi9PR0ogXRPR3imU91GfNTA8rYbYJ7e7vA/MP+a5JNDmD+rvA
   UWT4ZsO9hLLRD1kGcQqsMeE8kWTiawoHnmmBtZ6JUV+1CaFWFDZIf0kSn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367367956"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="367367956"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 11:18:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="718368596"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="718368596"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2023 11:18:50 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qdx72-0000U3-0K;
	Wed, 06 Sep 2023 18:18:48 +0000
Date: Thu, 7 Sep 2023 02:18:07 +0800
From: kernel test robot <lkp@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>, richardcochran@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com, netdev@vger.kernel.org,
	ntp-lists@mattcorallo.com, reibax@gmail.com
Subject: Re: [PATCH 3/3] ptp: support event queue reader channel masks
Message-ID: <202309070203.1o2AVeeS-lkp@intel.com>
References: <20230906104754.1324412-4-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906104754.1324412-4-reibax@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Xabier,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master next-20230906]
[cannot apply to shuah-kselftest/next shuah-kselftest/fixes horms-ipvs/master v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xabier-Marquiegui/ptp-support-multiple-timestamp-event-readers/20230906-194848
base:   net/main
patch link:    https://lore.kernel.org/r/20230906104754.1324412-4-reibax%40gmail.com
patch subject: [PATCH 3/3] ptp: support event queue reader channel masks
config: i386-randconfig-005-20230906 (https://download.01.org/0day-ci/archive/20230907/202309070203.1o2AVeeS-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070203.1o2AVeeS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070203.1o2AVeeS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/ptp_clock.h:109:2: error: unknown type name 'pid_t'
     109 |  pid_t reader_pid; /* PID of process reading the timestamp event queue */
         |  ^~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

