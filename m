Return-Path: <netdev+bounces-34825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C177A553B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F45A1C20A8D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D828E04;
	Mon, 18 Sep 2023 21:49:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB5286B1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:49:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C38E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695073795; x=1726609795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VK9Drx5ZB9mVGLqUzZs+rI2r0wC/1ZzZtxn0Hm3/FUY=;
  b=g42rLu2d+oHeNAidrwPxnN36SghKr9ULWQ60k8Co6Db8GJwQHXzUXL8t
   FY8AwDSmeSW5q6orWAmOm/MFO+o0ct6Dp/hWHAyn45xOIBKR5orrC8TZO
   j3fBrdw7hZQaxKhwloQ+G3bggF59jJ+SQxgogm7jXbVC8FfYTxu87AI9W
   tGg5joLYOxiD+Qm7s8aekikIeJyiXlouV/AoOD2Jc62T450rsoC0NZZQY
   oK+XpEVHyRzRoTdNPnBjxp9+t/0xHSm1d62CgJD57vBa1tqclkgMLQoIS
   Fe4Y/Cwupw5u/thYd3ne+XDyS48gDAz/L4cA13ADA4h+cVvqNK1rIRwRx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377095416"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="377095416"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="1076740171"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="1076740171"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2023 14:49:52 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qiM7q-0006Ye-2t;
	Mon, 18 Sep 2023 21:49:50 +0000
Date: Tue, 19 Sep 2023 05:49:16 +0800
From: kernel test robot <lkp@intel.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [net-next:main 8/84] drivers/dpll/dpll_netlink.c:847:3-4: Unneeded
 semicolon
Message-ID: <202309190540.RFwfIgO7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   a5ea26536e89d04485aa9e1c8f60ba11dfc5469e
commit: d7999f5ea64bb10d2857b8cbfe973be373bac7c9 [8/84] ice: implement dpll interface to control cgu
config: i386-randconfig-051-20230918 (https://download.01.org/0day-ci/archive/20230919/202309190540.RFwfIgO7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230919/202309190540.RFwfIgO7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309190540.RFwfIgO7-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/dpll/dpll_netlink.c:847:3-4: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

