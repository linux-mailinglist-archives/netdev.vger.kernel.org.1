Return-Path: <netdev+bounces-193169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E896AC2B4F
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC331BC4163
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA0F201034;
	Fri, 23 May 2025 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QW2GUz8T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E41F3B87;
	Fri, 23 May 2025 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035419; cv=none; b=JUivGNnTQMO7c4D8mbVpb5MDlJduT1Oos3WceH9hSb3xbuEdB69NnSht5JfSBremLFE+n2uGgWerVrx6/ikOm1eETWgTOfdGtcxWYuzhz9MB5da9Inu//7sXKMjn9Gpf5XISQQMYRFpykvYhuAGxkP8j7tQy9WKRQNMbPFyf7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035419; c=relaxed/simple;
	bh=mEEsEVyzh5RX4SOgkHg2TSRFjc10iRvTp7rqDX0+wEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SybaRxh2ygWrFrYh8q4NBtB1sXxA6bBhXtN1kiSs4Y3Np1drxeOohDfOkz6O1U1cbbYUBM+QZ8S0IR9S9f3NPCswzYhekd6JmnmhfOxrrY5UnKFM0XYCvAT+BBy/+4megyvpOhgp4XYuaJ3pViFA4pu2sgXUfnI/jcNjHC8fMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QW2GUz8T; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748035417; x=1779571417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mEEsEVyzh5RX4SOgkHg2TSRFjc10iRvTp7rqDX0+wEI=;
  b=QW2GUz8TivRLF5UWSA4EC6C19+vmI7XWAwLwLpXbiMPXvE2xaad64Wq6
   LUqnhCc3SJw7gQspDsahZ8Gf79M4/moUvAh+ZXpGOsExb/LbxZeRmExmO
   KSgUuOzV0Ozl8N4MLBow0lMp0AnpXrXS/gSbzuRACARpOnz13z1SLYG05
   2H6RmXFZIoQw1JdnmFEl6buT7en2QAQEypcbZ7YBccOVYT7fPk7umxIt9
   9kWKcw0TlTGCOm0Urv1IFOzmFTjG9gV3uAcoptAxeea0IKecJe4Y9/2j6
   HJyF8HB9dKmgM34ShS5de8vM59cNxSqxBI4wKcu3RnnHhUOjPHjctoAO6
   w==;
X-CSE-ConnectionGUID: u6DqFxqwR7WsTR70n9r/8w==
X-CSE-MsgGUID: QeFmD4HXTs2m9lQfzr6QqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50211993"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="50211993"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 14:23:36 -0700
X-CSE-ConnectionGUID: YqqT7tD4TOilD8oz2TVR0Q==
X-CSE-MsgGUID: uyc3147YQuCVwU8ZAbUmlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="145253906"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 May 2025 14:23:33 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIZrX-000Qjw-1o;
	Fri, 23 May 2025 21:23:31 +0000
Date: Sat, 24 May 2025 05:23:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dong Chenchen <dongchenchen2@huawei.com>, hawk@kernel.org,
	ilias.apalodimas@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, almasrymina@google.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangchangzhong@huawei.com,
	Dong Chenchen <dongchenchen2@huawei.com>,
	syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com
Subject: Re: [PATCH net] page_pool: Fix use-after-free in
 page_pool_recycle_in_ring
Message-ID: <202505240558.ANlvx42u-lkp@intel.com>
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523064524.3035067-1-dongchenchen2@huawei.com>

Hi Dong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dong-Chenchen/page_pool-Fix-use-after-free-in-page_pool_recycle_in_ring/20250523-144323
base:   net/main
patch link:    https://lore.kernel.org/r/20250523064524.3035067-1-dongchenchen2%40huawei.com
patch subject: [PATCH net] page_pool: Fix use-after-free in page_pool_recycle_in_ring
config: x86_64-buildonly-randconfig-004-20250524 (https://download.01.org/0day-ci/archive/20250524/202505240558.ANlvx42u-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505240558.ANlvx42u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505240558.ANlvx42u-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/page_pool.c: In function 'page_pool_recycle_in_ring':
>> net/core/page_pool.c:716:45: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     716 |                 recycle_stat_inc(pool, ring);
         |                                             ^


vim +/if +716 net/core/page_pool.c

ff7d6b27f894f1 Jesper Dangaard Brouer 2018-04-17  707  
4dec64c52e24c2 Mina Almasry           2024-06-28  708  static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
ff7d6b27f894f1 Jesper Dangaard Brouer 2018-04-17  709  {
8801e4b0622139 Dong Chenchen          2025-05-23  710  	bool in_softirq;
ff7d6b27f894f1 Jesper Dangaard Brouer 2018-04-17  711  	int ret;
542bcea4be866b Qingfang DENG          2023-02-03  712  	/* BH protection not needed if current is softirq */
8801e4b0622139 Dong Chenchen          2025-05-23  713  	in_softirq = page_pool_producer_lock(pool);
8801e4b0622139 Dong Chenchen          2025-05-23  714  	ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
8801e4b0622139 Dong Chenchen          2025-05-23  715  	if (ret)
ad6fa1e1ab1b81 Joe Damato             2022-03-01 @716  		recycle_stat_inc(pool, ring);
8801e4b0622139 Dong Chenchen          2025-05-23  717  	page_pool_producer_unlock(pool, in_softirq);
ad6fa1e1ab1b81 Joe Damato             2022-03-01  718  
8801e4b0622139 Dong Chenchen          2025-05-23  719  	return ret;
ff7d6b27f894f1 Jesper Dangaard Brouer 2018-04-17  720  }
ff7d6b27f894f1 Jesper Dangaard Brouer 2018-04-17  721  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

