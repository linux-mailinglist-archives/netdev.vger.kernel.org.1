Return-Path: <netdev+bounces-186928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE3AA4151
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 05:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CE35A57BD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 03:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE60D13EFF3;
	Wed, 30 Apr 2025 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZRLwQQo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5E259C
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 03:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745983321; cv=none; b=E/5ybGWrMRDq8dMZA+wcQnjIK6ErPw7hZId2yOr7giO3DcJBB8VvWmDp8NyLilhLFswXcKZSTdxRZnUP8t4r3l4F8NzhX3BSrLun7zHk0t2p2W7ja/0yn9dVzdxDYjdvcKK5HvmPYjFGbRwdjUzeZpah7JL3qGpvy5hUzohqUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745983321; c=relaxed/simple;
	bh=cw+nEyLbt3bjlKV7OO7fDKoAeFQAkt7WnyqvekvEf3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsKrMoKFlDpuAO6J5DbHQ+EAZ8Ad4i/8BC10M78Dps8g5qyukjzQL0NHcVYvWmhCk7CFF1ncYBkHJHFoOXhes6f9PYsURaTbLJxT9zEW6geJSQy0wEyZsl3F6ApytMcU9zuBlDqrX5tAefHEgkrj2poCBn9NJzctq+dbPLw+InQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZRLwQQo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745983320; x=1777519320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cw+nEyLbt3bjlKV7OO7fDKoAeFQAkt7WnyqvekvEf3A=;
  b=gZRLwQQoC+DFsX1FtKn3pNpzfRrehJDwRi0d8fjdkjBy62K4/q4xPMit
   aM0hqgD9if04UZdGlfJNvZ+8tSUoHI1mcxoItmF4HXE2Sv2u+v7vBo4Mq
   V78xDvI9Na2sT0Xbm6KHI8RYMWQ8J1mTnRzmDwIw3y8o9drXATEfVgEZ3
   lp/TvSMkqUJMDxrw7K3TmiK9w4ScuUj/RpZlTEW+IE2qA4l1G6uJlwOZb
   zZLu8u8IQeoC5mHK/qGYbp/OJcWerE9H/JucIhgdPpHSq5TRjOfvP7KFB
   K27tr4/ZUaziSbla7Mp8yDKW1/veP+OQSzvhWpprBBl1ws7wXnaZIamVO
   g==;
X-CSE-ConnectionGUID: zw8rYssuThOaNB8wPMLQKA==
X-CSE-MsgGUID: acSBTFkuS5ewE/X2EF8fGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="50286429"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="50286429"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 20:21:59 -0700
X-CSE-ConnectionGUID: 2qRSAAq6QE2cUACctuH5hg==
X-CSE-MsgGUID: mPQ2RPgUSFCjjKFesMPg5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="139111041"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 Apr 2025 20:21:51 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u9y16-00038H-1s;
	Wed, 30 Apr 2025 03:21:48 +0000
Date: Wed, 30 Apr 2025 11:20:49 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Yi Lai <yi1.lai@linux.intel.com>
Subject: Re: [PATCH v1 net-next] ipv6: Restore fib6_config validation for
 SIOCADDRT.
Message-ID: <202504301121.cFJmlUEg-lkp@intel.com>
References: <20250429014624.61938-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429014624.61938-1-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/ipv6-Restore-fib6_config-validation-for-SIOCADDRT/20250429-094825
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250429014624.61938-1-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next] ipv6: Restore fib6_config validation for SIOCADDRT.
config: sparc-randconfig-002-20250430 (https://download.01.org/0day-ci/archive/20250430/202504301121.cFJmlUEg-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250430/202504301121.cFJmlUEg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504301121.cFJmlUEg-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv6/route.c: In function 'inet6_rtm_newroute':
>> net/ipv6/route.c:5715:36: error: incompatible type for argument 1 of 'fib6_config_validate'
    5715 |         err = fib6_config_validate(cfg, extack);
         |                                    ^~~
         |                                    |
         |                                    struct fib6_config
   net/ipv6/route.c:4499:53: note: expected 'struct fib6_config *' but argument is of type 'struct fib6_config'
    4499 | static int fib6_config_validate(struct fib6_config *cfg,
         |                                 ~~~~~~~~~~~~~~~~~~~~^~~


vim +/fib6_config_validate +5715 net/ipv6/route.c

  5704	
  5705	static int inet6_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
  5706				      struct netlink_ext_ack *extack)
  5707	{
  5708		struct fib6_config cfg;
  5709		int err;
  5710	
  5711		err = rtm_to_fib6_config(skb, nlh, &cfg, extack);
  5712		if (err < 0)
  5713			return err;
  5714	
> 5715		err = fib6_config_validate(cfg, extack);
  5716		if (err)
  5717			return err;
  5718	
  5719		if (cfg.fc_metric == 0)
  5720			cfg.fc_metric = IP6_RT_PRIO_USER;
  5721	
  5722		if (cfg.fc_mp)
  5723			return ip6_route_multipath_add(&cfg, extack);
  5724		else
  5725			return ip6_route_add(&cfg, GFP_KERNEL, extack);
  5726	}
  5727	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

