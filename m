Return-Path: <netdev+bounces-151955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C269F1F5C
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33731885C0A
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF91885A5;
	Sat, 14 Dec 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoTTaKbc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0472EAE6
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186931; cv=none; b=kTZ+hkaYlDMPbrKO3/j0twbUXZRq+fKkLQ8/iJxLJrBWKUepAvZRCDPm2M7gInf81tQH4bmcNKEKAoJtPNqL4DfdeZoKa1yRz/YVUy3f2nYxFlK4d3OB8qjFOOfLTZXswTgSLAwPkS6o3iXXh6zuGSxv/7s9PhX8s/29BuxdGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186931; c=relaxed/simple;
	bh=glLwDssS48XpxLAZvjeVW2DO3KavTVBC+g33gzwbSxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4XtMnvwKbdtQuCFlnLnbha+wN8E/TcUU40vp/B+z6GVu/R7cX6GJcfxF3e2PJsZL4A9jR+eIdkAtpQjE8js6z+ggaYHh9UdVnS/Cihep3BT9C+b3F6eeKexNh4WnEKxGAtp9BCDgDBpegadtuRhqeTm+qslaU7LvL13ZG8v0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoTTaKbc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734186929; x=1765722929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=glLwDssS48XpxLAZvjeVW2DO3KavTVBC+g33gzwbSxs=;
  b=YoTTaKbc/jZl2k6ib8x1p7Uh1bg+GmjMtBCCh9wM6jo2+EPQQpeeyCGW
   QCpa+0+jVdXr740U32tcIapDGkv+PgdufZEVQDMahOxBdgRfQXBpetiDn
   jlIIATeRvcGfRoxu29Wcp8R9A7/L+z2rKYTMbxCOaVukTMjNMS1ZoKD0X
   BO3NmhmfX2VWwB0a093hhqUbmyo7g2BtKYN/XwJJaRFdIkmclBcECs8R/
   iPDQ737eKb3NqdNdSTt61GTtbR/tdc7KYbGGtVfSdckewKFRAbUrX5wRr
   Fn6zDz7UWeg7dm70A3BNgxGLTnma2XEyD2p3dzyMTPO4KX9X8A5QY8mk9
   g==;
X-CSE-ConnectionGUID: 9QrszqwCSPe6ZXvl4YWDsg==
X-CSE-MsgGUID: xHdOfZ+kTQW0meSgnkiQtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="33929182"
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="33929182"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 06:35:28 -0800
X-CSE-ConnectionGUID: IwlLk9wSQLm3Ne2d618stQ==
X-CSE-MsgGUID: O7BVAkOUQLSSuOStDpef4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="96861605"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 14 Dec 2024 06:35:25 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMTEp-000Cyr-1b;
	Sat, 14 Dec 2024 14:35:23 +0000
Date: Sat, 14 Dec 2024 22:34:40 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 2/4] inetpeer: remove create argument of
 inet_getpeer()
Message-ID: <202412142229.7lFHEOun-lkp@intel.com>
References: <20241213130212.1783302-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213130212.1783302-3-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/inetpeer-remove-create-argument-of-inet_getpeer_v-46/20241213-210500
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241213130212.1783302-3-edumazet%40google.com
patch subject: [PATCH net-next 2/4] inetpeer: remove create argument of inet_getpeer()
config: i386-buildonly-randconfig-003-20241214 (https://download.01.org/0day-ci/archive/20241214/202412142229.7lFHEOun-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241214/202412142229.7lFHEOun-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412142229.7lFHEOun-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/ipv4/inetpeer.c:19:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/ipv4/inetpeer.c:177:6: warning: variable 'invalidated' set but not used [-Wunused-but-set-variable]
     177 |         int invalidated;
         |             ^
   2 warnings generated.


vim +/invalidated +177 net/ipv4/inetpeer.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  170  
c0efc887dcadbd David S. Miller  2012-06-09  171  struct inet_peer *inet_getpeer(struct inet_peer_base *base,
4a6cb3d13bf1f8 Eric Dumazet     2024-12-13  172  			       const struct inetpeer_addr *daddr)
^1da177e4c3f41 Linus Torvalds   2005-04-16  173  {
b145425f269a17 Eric Dumazet     2017-07-17  174  	struct inet_peer *p, *gc_stack[PEER_MAX_GC];
b145425f269a17 Eric Dumazet     2017-07-17  175  	struct rb_node **pp, *parent;
b145425f269a17 Eric Dumazet     2017-07-17  176  	unsigned int gc_cnt, seq;
b145425f269a17 Eric Dumazet     2017-07-17 @177  	int invalidated;
^1da177e4c3f41 Linus Torvalds   2005-04-16  178  
4b9d9be839fdb7 Eric Dumazet     2011-06-08  179  	/* Attempt a lockless lookup first.
aa1039e73cc2cf Eric Dumazet     2010-06-15  180  	 * Because of a concurrent writer, we might not find an existing entry.
aa1039e73cc2cf Eric Dumazet     2010-06-15  181  	 */
7b46ac4e77f322 David S. Miller  2011-03-08  182  	rcu_read_lock();
b145425f269a17 Eric Dumazet     2017-07-17  183  	seq = read_seqbegin(&base->lock);
b145425f269a17 Eric Dumazet     2017-07-17  184  	p = lookup(daddr, base, seq, NULL, &gc_cnt, &parent, &pp);
b145425f269a17 Eric Dumazet     2017-07-17  185  	invalidated = read_seqretry(&base->lock, seq);
7b46ac4e77f322 David S. Miller  2011-03-08  186  	rcu_read_unlock();
^1da177e4c3f41 Linus Torvalds   2005-04-16  187  
4b9d9be839fdb7 Eric Dumazet     2011-06-08  188  	if (p)
aa1039e73cc2cf Eric Dumazet     2010-06-15  189  		return p;
aa1039e73cc2cf Eric Dumazet     2010-06-15  190  
aa1039e73cc2cf Eric Dumazet     2010-06-15  191  	/* retry an exact lookup, taking the lock before.
aa1039e73cc2cf Eric Dumazet     2010-06-15  192  	 * At least, nodes should be hot in our cache.
aa1039e73cc2cf Eric Dumazet     2010-06-15  193  	 */
b145425f269a17 Eric Dumazet     2017-07-17  194  	parent = NULL;
65e8354ec13a45 Eric Dumazet     2011-03-04  195  	write_seqlock_bh(&base->lock);
b145425f269a17 Eric Dumazet     2017-07-17  196  
b145425f269a17 Eric Dumazet     2017-07-17  197  	gc_cnt = 0;
b145425f269a17 Eric Dumazet     2017-07-17  198  	p = lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
4a6cb3d13bf1f8 Eric Dumazet     2024-12-13  199  	if (!p) {
b145425f269a17 Eric Dumazet     2017-07-17  200  		p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
aa1039e73cc2cf Eric Dumazet     2010-06-15  201  		if (p) {
b534ecf1cd26f0 David S. Miller  2010-11-30  202  			p->daddr = *daddr;
b6a37e5e25414d Eric Dumazet     2018-04-09  203  			p->dtime = (__u32)jiffies;
1cc9a98b59ba92 Reshetova, Elena 2017-06-30  204  			refcount_set(&p->refcnt, 2);
aa1039e73cc2cf Eric Dumazet     2010-06-15  205  			atomic_set(&p->rid, 0);
144001bddcb4db David S. Miller  2011-01-27  206  			p->metrics[RTAX_LOCK-1] = INETPEER_METRICS_NEW;
92d8682926342d David S. Miller  2011-02-04  207  			p->rate_tokens = 0;
c09551c6ff7fe1 Lorenzo Bianconi 2019-02-06  208  			p->n_redirects = 0;
bc9259a8bae9e8 Nicolas Dichtel  2012-09-27  209  			/* 60*HZ is arbitrary, but chosen enough high so that the first
bc9259a8bae9e8 Nicolas Dichtel  2012-09-27  210  			 * calculation of tokens is at its maximum.
bc9259a8bae9e8 Nicolas Dichtel  2012-09-27  211  			 */
bc9259a8bae9e8 Nicolas Dichtel  2012-09-27  212  			p->rate_last = jiffies - 60*HZ;
^1da177e4c3f41 Linus Torvalds   2005-04-16  213  
b145425f269a17 Eric Dumazet     2017-07-17  214  			rb_link_node(&p->rb_node, parent, pp);
b145425f269a17 Eric Dumazet     2017-07-17  215  			rb_insert_color(&p->rb_node, &base->rb_root);
98158f5a853caf David S. Miller  2010-11-30  216  			base->total++;
aa1039e73cc2cf Eric Dumazet     2010-06-15  217  		}
b145425f269a17 Eric Dumazet     2017-07-17  218  	}
b145425f269a17 Eric Dumazet     2017-07-17  219  	if (gc_cnt)
b145425f269a17 Eric Dumazet     2017-07-17  220  		inet_peer_gc(base, gc_stack, gc_cnt);
65e8354ec13a45 Eric Dumazet     2011-03-04  221  	write_sequnlock_bh(&base->lock);
^1da177e4c3f41 Linus Torvalds   2005-04-16  222  
^1da177e4c3f41 Linus Torvalds   2005-04-16  223  	return p;
^1da177e4c3f41 Linus Torvalds   2005-04-16  224  }
b3419363808f24 David S. Miller  2010-11-30  225  EXPORT_SYMBOL_GPL(inet_getpeer);
98158f5a853caf David S. Miller  2010-11-30  226  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

