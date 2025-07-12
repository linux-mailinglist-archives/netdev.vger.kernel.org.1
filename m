Return-Path: <netdev+bounces-206359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A3FB02C1B
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 19:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAD4189DB56
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69950289357;
	Sat, 12 Jul 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrM815jp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841F70823
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752340509; cv=none; b=nsE9IvFXRREzaLR68fQ+sn2NMv5IeYCKUGnnPmNjf3gwT3FSz9bU4f1guFlKgAjn30vQVC3vMMMDltm/K7l3qsM7jKmcgdsve0mYxOGJ7hiY2dVMgbgXXwIlLARYpaXAO0QkH/l0dXdeuflPk+3m6u9GMIEyGH553bycRD+3gHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752340509; c=relaxed/simple;
	bh=6frN7N+PZRfZmFjGd771R8NVmjODzYe3sPQI4d3IujQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7eVFPHK1bU0vFdpCJmEpCWNCVM5rJj0b8faNhvcrWKCUA7Bol82fXzeE1e+JJstNHxoMYspxbKj57O2m5h15/CM0cGxDvrkPSIE9lOoOPL+cGc5ioYqkZXbaW9lMQDah5TmYCZaXfTkCFbEog3d8LLsUp9vVZfPmqVrExSHsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrM815jp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752340507; x=1783876507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6frN7N+PZRfZmFjGd771R8NVmjODzYe3sPQI4d3IujQ=;
  b=IrM815jpyV4+6BikcWM0yM6S3dK+SliPxGT8zsdN53zw3QkjVX+80Pou
   Jj3s1eBjBczGdAPTqWGJL6rab7PItV9cNvyKd3IdNmWXRuIs4WQi6VuZa
   2PoKahqXZoyqY1lDQJrCVvskVjRq+GX6uiP4wlSyWmq86/1CTo7bDe+f5
   s0+rFq2CwFUgqrF3GVO8GQT25QKOsMWqDDqZ9qGF07KE7WV92m8V0/nz4
   dADsoXqaPe/VE7Z/6uGkUyjazU7g+/aMbHzxcLB4UtvpOahXzRKcgW/y6
   9q7t+DZynw8A02r6+nAo8AHVXZvoj5suX2PEIfA+ETAbyYp+mXsyVYxMu
   g==;
X-CSE-ConnectionGUID: xX5uZHdSTUyGXuo4d1eBAw==
X-CSE-MsgGUID: Xp6UMxQXRACg6UzeWtwOYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66047249"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="66047249"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 10:15:07 -0700
X-CSE-ConnectionGUID: n7DokkFwQw+pbZY4yCVFXg==
X-CSE-MsgGUID: UL5sCSo5SkO3jjTXSGTBxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="156697898"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2025 10:15:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uadoT-0007XD-0x;
	Sat, 12 Jul 2025 17:15:01 +0000
Date: Sun, 13 Jul 2025 01:14:12 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 06/14] neighbour: Free pneigh_entry after RCU
 grace period.
Message-ID: <202507130021.ovxzu4FO-lkp@intel.com>
References: <20250711191007.3591938-7-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711191007.3591938-7-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/neighbour-Make-neigh_valid_get_req-return-ndmsg/20250712-031447
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250711191007.3591938-7-kuniyu%40google.com
patch subject: [PATCH v1 net-next 06/14] neighbour: Free pneigh_entry after RCU grace period.
config: csky-randconfig-r111-20250712 (https://download.01.org/0day-ci/archive/20250713/202507130021.ovxzu4FO-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250713/202507130021.ovxzu4FO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507130021.ovxzu4FO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/neighbour.c:860:33: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/core/neighbour.c:860:33: sparse:    struct pneigh_entry [noderef] __rcu *
   net/core/neighbour.c:860:33: sparse:    struct pneigh_entry *
   net/core/neighbour.c:806:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/core/neighbour.c:806:9: sparse:    struct pneigh_entry [noderef] __rcu *
   net/core/neighbour.c:806:9: sparse:    struct pneigh_entry *
   net/core/neighbour.c:832:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/core/neighbour.c:832:25: sparse:    struct pneigh_entry [noderef] __rcu *
   net/core/neighbour.c:832:25: sparse:    struct pneigh_entry *
   net/core/neighbour.c:445:9: sparse: sparse: context imbalance in '__neigh_ifdown' - wrong count at exit
   net/core/neighbour.c:869:9: sparse: sparse: context imbalance in 'pneigh_ifdown_and_unlock' - unexpected unlock

vim +860 net/core/neighbour.c

   845	
   846	static void pneigh_ifdown_and_unlock(struct neigh_table *tbl,
   847					     struct net_device *dev,
   848					     bool skip_perm)
   849	{
   850		struct pneigh_entry *n, **np;
   851		LIST_HEAD(head);
   852		u32 h;
   853	
   854		for (h = 0; h <= PNEIGH_HASHMASK; h++) {
   855			np = &tbl->phash_buckets[h];
   856			while ((n = *np) != NULL) {
   857				if (skip_perm && n->permanent)
   858					goto skip;
   859				if (!dev || n->dev == dev) {
 > 860					rcu_assign_pointer(*np, n->next);
   861					list_add(&n->free_node, &head);
   862					continue;
   863				}
   864	skip:
   865				np = &n->next;
   866			}
   867		}
   868	
   869		write_unlock_bh(&tbl->lock);
   870	
   871		while (!list_empty(&head)) {
   872			n = list_first_entry(&head, typeof(*n), free_node);
   873			list_del(&n->free_node);
   874	
   875			if (tbl->pdestructor)
   876				tbl->pdestructor(n);
   877	
   878			call_rcu(&n->rcu, pneigh_destroy);
   879		}
   880	}
   881	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

