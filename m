Return-Path: <netdev+bounces-173997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360ECA5CE6B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57C53B1F0E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F35263C74;
	Tue, 11 Mar 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWYRxfXz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19431F03F2;
	Tue, 11 Mar 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719712; cv=none; b=g3HTH60XBGQOpsAa+TormN5NguLZ5GKRRll83uVl2ubUvhNuNN0sIlPjiTciWKMvGu/rgeWG6OgG4Voqx2g7xPQ5BsGBKQaTg5yB0A/jxTzQfWMjjwjeHU6zVmB9snikUh+m5Oc5X4Uk4QxbXlpq91zQVnhDkxALifvqQWoSLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719712; c=relaxed/simple;
	bh=21KNfjHCQwgSBouMQ+GkmY7Vp+GDPvf52Urbqbhmd+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDl8RnLZL9LrGQ9gnuGnYoKaBaSlasrKcD6ZWpa2VjOQvUNLXOc06f7cb3UWOERUoaXhMo60xnkvhjGDJ57ZLlJQU5M/hLniRSAHJ2X0kd+0Z5+S0WRnUFcDYP5AZDDM1dGWeT9Q9wvI7xNLE6UCiHTVUSIYAn07WoYx1ULJG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWYRxfXz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741719710; x=1773255710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=21KNfjHCQwgSBouMQ+GkmY7Vp+GDPvf52Urbqbhmd+c=;
  b=jWYRxfXzHdD0z9BKzq4iIvKTmhlzL43xyQz7TkZvKgxtiRCQHBOOsbBB
   Xrt3eaIh8LTkOLbetpz+rppxZd58YxyZF6JiP/20AiZsRJTA3yj+iMbVc
   2sPfv8zCcnKnMRuHdC4++2wdsITry1/MhcIkI3lnX98H3N+ldRjvx4rVq
   5RFZfAEx7c76fbtEaJPMom8E+ky1ZWLo4JsL+FOQi4qP4qovZy5kL8ejK
   KBHh4IEzOtBTWEmXDXM4Cv7HzcUSKNCvkL+ieAn56OrNjEq4KtCVy5KOH
   2ORFgFCPi/VMW4kAK4CG+re4dwFATni1+UxJ0g+4Wy3kj9pJmpzDa6YTL
   w==;
X-CSE-ConnectionGUID: R9KkS2V/TvCl2Nc8oj0iLg==
X-CSE-MsgGUID: DZ+OFnSSTNqJa0CzJtuGiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="68138573"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="68138573"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 12:01:49 -0700
X-CSE-ConnectionGUID: +4iAEKThRaKTjqbBUkUEiQ==
X-CSE-MsgGUID: bfx8fdpSQE+hvnHAKLhHiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="120907899"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 11 Mar 2025 12:01:47 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts4rI-0007kO-0e;
	Tue, 11 Mar 2025 19:01:44 +0000
Date: Wed, 12 Mar 2025 03:01:39 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ipv6: fix TCP GSO segmentation with NAT
Message-ID: <202503120224.LbO66Ztw-lkp@intel.com>
References: <20250310112121.73654-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310112121.73654-1-nbd@nbd.name>

Hi Felix,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Felix-Fietkau/net-ipv6-fix-TCP-GSO-segmentation-with-NAT/20250310-192256
base:   net/main
patch link:    https://lore.kernel.org/r/20250310112121.73654-1-nbd%40nbd.name
patch subject: [PATCH net v2] net: ipv6: fix TCP GSO segmentation with NAT
config: s390-randconfig-001-20250312 (https://download.01.org/0day-ci/archive/20250312/202503120224.LbO66Ztw-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503120224.LbO66Ztw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503120224.LbO66Ztw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv6/tcpv6_offload.c:104:30: warning: variable 'th' is uninitialized when used here [-Wuninitialized]
                   inet_proto_csum_replace16(&th->check, seg,
                                              ^~
   net/ipv6/tcpv6_offload.c:101:19: note: initialize the variable 'th' to silence this warning
           struct tcphdr *th;
                            ^
                             = NULL
   1 warning generated.


vim +/th +104 net/ipv6/tcpv6_offload.c

    95	
    96	static void __tcpv6_gso_segment_csum(struct sk_buff *seg,
    97					     struct in6_addr *oldip,
    98					     const struct in6_addr *newip,
    99					     __be16 *oldport, __be16 newport)
   100	{
   101		struct tcphdr *th;
   102	
   103		if (!ipv6_addr_equal(oldip, newip)) {
 > 104			inet_proto_csum_replace16(&th->check, seg,
   105						  oldip->s6_addr32,
   106						  newip->s6_addr32,
   107						  true);
   108			*oldip = *newip;
   109		}
   110	
   111		if (*oldport == newport)
   112			return;
   113	
   114		th = tcp_hdr(seg);
   115		inet_proto_csum_replace2(&th->check, seg, *oldport, newport, false);
   116		*oldport = newport;
   117	}
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

