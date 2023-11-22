Return-Path: <netdev+bounces-50259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18977F5182
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 21:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDE02812C4
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BB55D918;
	Wed, 22 Nov 2023 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHPdezc1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A079A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 12:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700684630; x=1732220630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMaYkdk7ELFbFc/sQHKRfNTGUIp0Gihc+5+qFcwD0bQ=;
  b=CHPdezc1uPyIDMHRuGytJHJYYOUh8D6eg8eboKePfoQxKrM1BWYqfLoq
   olhlxHO7kyz081ts3/sn0PBsjmBtPsrHB8PDYj1pVQg4BHpSxUUP05D0g
   wAMVX3vxFOaDAjxv7OQLwpS83Z01AbqB8KHpsSf2fPeyVLzwLU/P3O6FP
   bido6J2DsrTAimsSvatoW+Y+6vu9vEDHO7WAPvZylvWFdQGNCWWHsw0I4
   whJz6VotWDohsE1+Q2oRFTZu1NyKXZWW0DaZsPMAxw7lPi3SkunCloY9W
   sOBogg1sMNHmlnSbxZCVWCX3YM38K4EKgs44YdKZv3LnVGuq99F0bzbWv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478336633"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="478336633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 12:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833188356"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="833188356"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Nov 2023 12:23:47 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r5tlA-0000qm-36;
	Wed, 22 Nov 2023 20:23:44 +0000
Date: Thu, 23 Nov 2023 04:23:17 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Ivan Babrou <ivan@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 4/4] af_unix: Try to run GC async.
Message-ID: <202311230220.WfMchMxF-lkp@intel.com>
References: <20231122013629.28554-5-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122013629.28554-5-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/af_unix-Do-not-use-atomic-ops-for-unix_sk-sk-inflight/20231122-094214
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231122013629.28554-5-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 4/4] af_unix: Try to run GC async.
config: x86_64-buildonly-randconfig-006-20231122 (https://download.01.org/0day-ci/archive/20231123/202311230220.WfMchMxF-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311230220.WfMchMxF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230220.WfMchMxF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: unix_get_socket
   >>> referenced by usercopy_64.c
   >>>               vmlinux.o:(__scm_send)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

