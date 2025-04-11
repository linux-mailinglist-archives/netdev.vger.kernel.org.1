Return-Path: <netdev+bounces-181489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 774ABA852B0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507B34644F9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C771E832E;
	Fri, 11 Apr 2025 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KU4zT2Lv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2643C1DB55C
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744346309; cv=none; b=eoG/1plbin5WvpDJpDV1ipVUsOtzJJYCbBelgpUhZ9foRDl8F+/BUJLdt+14ZlkWJwKPhQuYIMtRD9e4bbPdH4Od4h78yJoEDhLGibhojG3RpzTs7gHiiL0DZMYr+8D+xMbnhEVt98g76RxvFrjebd3uxx5/ia23lMDMsQPYeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744346309; c=relaxed/simple;
	bh=4ZW7Q5ISlJJYXO5OejRTMXU+a79AtOia+NS+Kw9SGdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf0joN3E4zNnmV983EjoGGq4aMqEIZ4dFJpXnmr+7KZgwzk0QWQdxrzYPorvXaiCDW6CRXPonQmIKLAclRo+9POYGf354Wu8Un4FOc4bSGj1695CMWSMI8Tv1LYe+cm/nerv7bzibGOnwZhq8iY/bcRdFle3GuaDRcu/wU4WRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KU4zT2Lv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744346308; x=1775882308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ZW7Q5ISlJJYXO5OejRTMXU+a79AtOia+NS+Kw9SGdQ=;
  b=KU4zT2LvSbdp1VvQHah+57KfBtEz6GzxXUetISpWMmqwsD62zLxFu1MK
   8mR+Qp928KdTfNHBH+qFggzk1Loxg2HV5RZl7E8jmxmRyvYVVOXVgZGVm
   bRm5DYPVT/8u+DQcrM21XFnnSUSbJFNAOH17RtsCaXPbz3q2gjIhKonus
   zYQ7cpg3PpsjpAL6TczUYTS/khVvTp5flRZbos9AzLPL71FeVim4h2Fvo
   H7SSRvI60CR7KVHyyDTciBc5YOD9PPHgNAanEB52FYNLkl3zXR+vHXcFR
   m2jkdproinYOoAb9t0OzpLixnV8eY9Zx26NhPeS+5JL6aN4dL8QrsP6g0
   A==;
X-CSE-ConnectionGUID: ao0H3fECRy+wAAaa+2ZV8A==
X-CSE-MsgGUID: 1BH6WBeYS6OZ44IV8vlZ8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45129021"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="45129021"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 21:38:27 -0700
X-CSE-ConnectionGUID: T5yb7r00TYWOtOV5noFO+g==
X-CSE-MsgGUID: 1X4UObc3Sz6X1TC+4y9XqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133958160"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Apr 2025 21:38:25 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u369m-000ApP-1g;
	Fri, 11 Apr 2025 04:38:22 +0000
Date: Fri, 11 Apr 2025 12:37:44 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 02/14] net: Add ops_undo_single for module
 load/unload.
Message-ID: <202504111226.iQKPbEOI-lkp@intel.com>
References: <20250410022004.8668-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410022004.8668-3-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/net-Factorise-setup_net-and-cleanup_net/20250410-102752
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250410022004.8668-3-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 02/14] net: Add ops_undo_single for module load/unload.
config: arm-randconfig-001-20250411 (https://download.01.org/0day-ci/archive/20250411/202504111226.iQKPbEOI-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250411/202504111226.iQKPbEOI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504111226.iQKPbEOI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/net_namespace.c:1311:3: error: call to undeclared function 'free_exit_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1311 |                 free_exit_list(ops, &net_exit_list);
         |                 ^
   net/core/net_namespace.c:1311:3: note: did you mean 'ops_exit_list'?
   net/core/net_namespace.c:166:13: note: 'ops_exit_list' declared here
     166 | static void ops_exit_list(const struct pernet_operations *ops,
         |             ^
   1 error generated.


vim +/free_exit_list +1311 net/core/net_namespace.c

ed160e839d2e11 Denis V. Lunev    2007-11-13  1303  
f875bae0653349 Eric W. Biederman 2009-11-29  1304  static void __unregister_pernet_operations(struct pernet_operations *ops)
ed160e839d2e11 Denis V. Lunev    2007-11-13  1305  {
f8c46cb39079b7 Dmitry Torokhov   2016-08-10  1306  	if (!init_net_initialized) {
f8c46cb39079b7 Dmitry Torokhov   2016-08-10  1307  		list_del(&ops->list);
f8c46cb39079b7 Dmitry Torokhov   2016-08-10  1308  	} else {
72ad937abd0a43 Eric W. Biederman 2009-12-03  1309  		LIST_HEAD(net_exit_list);
72ad937abd0a43 Eric W. Biederman 2009-12-03  1310  		list_add(&init_net.exit_list, &net_exit_list);
41467d2ff4dfe1 Yajun Deng        2021-08-17 @1311  		free_exit_list(ops, &net_exit_list);
ed160e839d2e11 Denis V. Lunev    2007-11-13  1312  	}
f8c46cb39079b7 Dmitry Torokhov   2016-08-10  1313  }
f875bae0653349 Eric W. Biederman 2009-11-29  1314  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

