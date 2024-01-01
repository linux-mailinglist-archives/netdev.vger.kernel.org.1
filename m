Return-Path: <netdev+bounces-60684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26A38212E2
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 04:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B46528282C
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 03:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B487FD;
	Mon,  1 Jan 2024 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CuS3I/4X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7F802
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704078523; x=1735614523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JL99D2vzqvQrF9XQj62LoxrQEZkGaKIs4cGAKo7vGdc=;
  b=CuS3I/4XjNRqowahbQBXL7P8IaXmgAX2/XE7yGmCtlqYjEvzzaks0T0u
   TNNZTJ8jYy9qZw2k+HGjnW+zwMI4TQ3GrWK4XNL4AbU9uKA1BQyneuzRP
   +RpeeUUUMRofYB38FyApO3xWuBpjro5t0Hm4CvZ8UQEYcBshEOURG7SvB
   CmhcEH76WYP6usR3JqRwf9Ch+xlDzJWZE2at9SRb3Glhf5mwlhHiacdSv
   sr7+FLgvexHR4+L7sBqV/wfXLpkdQ3zi4Ua3F2CCoWaisy74VemoPNO7Y
   +tdlB7maj5OVG4xIAYgRmRGFfE3IuimE1XBA1EjnySCLpvTj0EDZNdFsl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="4092896"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="4092896"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 19:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="755584262"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="755584262"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2023 19:08:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rK8fN-000Jwm-2o;
	Mon, 01 Jan 2024 03:08:37 +0000
Date: Mon, 1 Jan 2024 11:07:39 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Safonov <dima@arista.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: [net-next:main 19/93]
 tools/testing/selftests/net/tcp_ao/bench-lookups.c:202: undefined reference
 to `sqrt'
Message-ID: <202401011151.veyYTJzq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   92de776d20904b51e6dc2d39280c5f143a80f987
commit: 826eb9bcc1844990e3c4a7c84846f1c1eaee0ed0 [19/93] selftest/tcp-ao: Rectify out-of-tree build
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240101/202401011151.veyYTJzq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401011151.veyYTJzq-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: /tmp/ccYsvLsz.o: in function `test_print_stats':
>> tools/testing/selftests/net/tcp_ao/bench-lookups.c:202: undefined reference to `sqrt'
   collect2: error: ld returned 1 exit status
--
   /usr/bin/ld: /tmp/ccHYcIAg.o: in function `test_print_stats':
>> tools/testing/selftests/net/tcp_ao/bench-lookups.c:202: undefined reference to `sqrt'
   collect2: error: ld returned 1 exit status


vim +202 tools/testing/selftests/net/tcp_ao/bench-lookups.c

d1066c9c58d48b Dmitry Safonov 2023-12-15  199  
d1066c9c58d48b Dmitry Safonov 2023-12-15  200  static void test_print_stats(const char *desc, size_t nr, struct bench_stats *bs)
d1066c9c58d48b Dmitry Safonov 2023-12-15  201  {
d1066c9c58d48b Dmitry Safonov 2023-12-15 @202  	test_ok("%-20s\t%zu keys: min=%" PRIu64 "ms max=%" PRIu64 "ms mean=%gms stddev=%g",
d1066c9c58d48b Dmitry Safonov 2023-12-15  203  		desc, nr, bs->min / 1000000, bs->max / 1000000,
d1066c9c58d48b Dmitry Safonov 2023-12-15  204  		bs->mean / 1000000, sqrt((bs->mean / 1000000) / bs->nr));
d1066c9c58d48b Dmitry Safonov 2023-12-15  205  }
d1066c9c58d48b Dmitry Safonov 2023-12-15  206  

:::::: The code at line 202 was first introduced by commit
:::::: d1066c9c58d48bdbda0236b4744dc03f8a903d49 selftests/net: Add test/benchmark for removing MKTs

:::::: TO: Dmitry Safonov <dima@arista.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

