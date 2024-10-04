Return-Path: <netdev+bounces-131861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A998FBF9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 03:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129FFB216A4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2BC10A24;
	Fri,  4 Oct 2024 01:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jISuFQDH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27BFD512
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728006124; cv=none; b=kmBtSYDGbfcmkhOn+vN4uBV1wDvYhsyikhZk21tEOTejyzEIFnjkKR5MVzJh4I5XFEAfsctGgPuucxPt6NXgLu2MyxN1ZYzllCHohNGYkhB9gpieJRzFt/htoq+zeLZNTF6bzw96MeGtzr5y+LdriI9r0+1Rp00FGH3dPXhXZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728006124; c=relaxed/simple;
	bh=U1ri5w6InTaOfBluOhiNBQPwEBErBfgKaJMt9cmrilE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRm/ic0B9ngxNkUqkQfq2AQqjm+yuG6ufggX86ILhqLe84d4vbow3p1dJ0BkmVAd6ip+HZwxZ8f3vLRY7QnIfUh0RxQ68LuhzNaGR/5MdI2kpgRTchbw5T1fjbJg5faV5Ax9msCpB+aPhrQFs/vLrKKNxV6IDEjYYQwtfwOzErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jISuFQDH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728006122; x=1759542122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1ri5w6InTaOfBluOhiNBQPwEBErBfgKaJMt9cmrilE=;
  b=jISuFQDHMsBFK7b6X8FTKO5dT84mZFdbNu6BCy9ogG5GVovgarMBqo8T
   WCLcW/i+RAcq1iRTJ84VzJw9/vmvxdfYF9Uxe11fnhbctBqQDaIzA02+5
   /lqJWylQBCeLXb0GgGckeI36GoJ22oyI0cM+jBeJbJosKwGYR82HF6Q1Q
   1oycN4DrlMZ5Fo6W7w6bHRRtZmGhex2YRDEEkndnCbRT6ppa60AxEgye6
   hXLgkXYFwQ8Ss6G6tKBdeQXegj9ZQsTiwiR0VGO15w3hQDYe0LwrGo4eh
   INiRVVHkfeN6haz6OZMewrH8impik++LZqOlDP3lhUaFtlpYx2WGL9bdk
   A==;
X-CSE-ConnectionGUID: hYgztE1ZSYyUuhiC12abJg==
X-CSE-MsgGUID: jBoy1AZjR9C61OaqkKbD5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37882878"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="37882878"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 18:42:01 -0700
X-CSE-ConnectionGUID: 0sSy+tcEQyCVDNb64aKh6A==
X-CSE-MsgGUID: bYbnkVgSSEe+PqPjoW5i2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="79525517"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Oct 2024 18:41:59 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swXKO-00016g-1P;
	Fri, 04 Oct 2024 01:41:56 +0000
Date: Fri, 4 Oct 2024 09:41:24 +0800
From: kernel test robot <lkp@intel.com>
To: Gilad Naaman <gnaaman@drivenets.com>, netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Gilad Naaman <gnaaman@drivenets.com>
Subject: Re: [PATCH net-next 1/2] Convert neighbour-table to use hlist
Message-ID: <202410040908.loCFe95v-lkp@intel.com>
References: <20241001050959.1799151-2-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001050959.1799151-2-gnaaman@drivenets.com>

Hi Gilad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Gilad-Naaman/Convert-neighbour-table-to-use-hlist/20241001-131234
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241001050959.1799151-2-gnaaman%40drivenets.com
patch subject: [PATCH net-next 1/2] Convert neighbour-table to use hlist
config: x86_64-randconfig-121-20241004 (https://download.01.org/0day-ci/archive/20241004/202410040908.loCFe95v-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410040908.loCFe95v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410040908.loCFe95v-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:215:32: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct hlist_node *n @@     got struct hlist_node [noderef] * @@
   net/core/neighbour.c:215:32: sparse:     expected struct hlist_node *n
   net/core/neighbour.c:215:32: sparse:     got struct hlist_node [noderef] *
   net/core/neighbour.c:370:26: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:382:40: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct hlist_node *n @@     got struct hlist_node [noderef] * @@
   net/core/neighbour.c:382:40: sparse:     expected struct hlist_node *n
   net/core/neighbour.c:382:40: sparse:     got struct hlist_node [noderef] *
>> net/core/neighbour.c:519:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *buckets @@     got void *_res @@
   net/core/neighbour.c:519:25: sparse:     expected struct hlist_head [noderef] __rcu *buckets
   net/core/neighbour.c:519:25: sparse:     got void *_res
>> net/core/neighbour.c:524:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *ptr @@     got struct hlist_head [noderef] __rcu *[assigned] buckets @@
   net/core/neighbour.c:524:32: sparse:     expected void const *ptr
   net/core/neighbour.c:524:32: sparse:     got struct hlist_head [noderef] __rcu *[assigned] buckets
>> net/core/neighbour.c:546:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *objp @@     got struct hlist_head [noderef] __rcu *buckets @@
   net/core/neighbour.c:546:23: sparse:     expected void const *objp
   net/core/neighbour.c:546:23: sparse:     got struct hlist_head [noderef] __rcu *buckets
>> net/core/neighbour.c:548:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *ptr @@     got struct hlist_head [noderef] __rcu *buckets @@
   net/core/neighbour.c:548:31: sparse:     expected void const *ptr
   net/core/neighbour.c:548:31: sparse:     got struct hlist_head [noderef] __rcu *buckets
>> net/core/neighbour.c:572:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/core/neighbour.c:572:25: sparse:    struct hlist_node [noderef] __rcu *
   net/core/neighbour.c:572:25: sparse:    struct hlist_node *
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
>> net/core/neighbour.c:669:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:688:29: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct hlist_node *n @@     got struct hlist_node [noderef] * @@
>> net/core/neighbour.c:688:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/core/neighbour.c:948:23: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:971:48: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct hlist_node *n @@     got struct hlist_node [noderef] * @@
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:2698:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3065:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3086:23: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3094:48: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct hlist_node *n @@     got struct hlist_node [noderef] * @@
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3164:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3203:14: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3222:30: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3231:41: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:3231:22: sparse: sparse: cast removes address space '__rcu' of expression
   net/core/neighbour.c:429:9: sparse: sparse: context imbalance in '__neigh_ifdown' - wrong count at exit
>> net/core/neighbour.c:572:25: sparse: sparse: dereference of noderef expression
   net/core/neighbour.c: note: in included file:
>> include/net/neighbour.h:307:38: sparse: sparse: cast removes address space '__rcu' of expression
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
--
   net/core/filter.c:1423:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1423:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1423:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:1501:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sock_filter const *filter @@     got struct sock_filter [noderef] __user *filter @@
   net/core/filter.c:1501:39: sparse:     expected struct sock_filter const *filter
   net/core/filter.c:1501:39: sparse:     got struct sock_filter [noderef] __user *filter
   net/core/filter.c:2340:45: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] daddr @@     got unsigned int [usertype] ipv4_nh @@
   net/core/filter.c:2340:45: sparse:     expected restricted __be32 [usertype] daddr
   net/core/filter.c:2340:45: sparse:     got unsigned int [usertype] ipv4_nh
   net/core/filter.c:11048:31: sparse: sparse: symbol 'cg_skb_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11054:27: sparse: sparse: symbol 'cg_skb_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11098:31: sparse: sparse: symbol 'cg_sock_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11104:27: sparse: sparse: symbol 'cg_sock_prog_ops' was not declared. Should it be static?
   net/core/filter.c:11107:31: sparse: sparse: symbol 'cg_sock_addr_verifier_ops' was not declared. Should it be static?
   net/core/filter.c:11113:27: sparse: sparse: symbol 'cg_sock_addr_prog_ops' was not declared. Should it be static?
   net/core/filter.c:1943:43: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1943:43: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:1943:43: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1946:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be16 [usertype] old @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1946:36: sparse:     expected restricted __be16 [usertype] old
   net/core/filter.c:1946:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1946:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] new @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1946:42: sparse:     expected restricted __be16 [usertype] new
   net/core/filter.c:1946:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1949:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1949:36: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:1949:36: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1949:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1949:42: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:1949:42: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1994:59: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] diff @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1994:59: sparse:     expected restricted __wsum [usertype] diff
   net/core/filter.c:1994:59: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:1997:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be16 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:1997:52: sparse:     expected restricted __be16 [usertype] from
   net/core/filter.c:1997:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:1997:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be16 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:1997:58: sparse:     expected restricted __be16 [usertype] to
   net/core/filter.c:1997:58: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:2000:52: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __be32 [usertype] from @@     got unsigned long long [usertype] from @@
   net/core/filter.c:2000:52: sparse:     expected restricted __be32 [usertype] from
   net/core/filter.c:2000:52: sparse:     got unsigned long long [usertype] from
   net/core/filter.c:2000:58: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 [usertype] to @@     got unsigned long long [usertype] to @@
   net/core/filter.c:2000:58: sparse:     expected restricted __be32 [usertype] to
   net/core/filter.c:2000:58: sparse:     got unsigned long long [usertype] to
   net/core/filter.c:2050:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [assigned] [usertype] ret @@
   net/core/filter.c:2050:16: sparse:     expected unsigned long long
   net/core/filter.c:2050:16: sparse:     got restricted __wsum [assigned] [usertype] ret
   net/core/filter.c:2072:35: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __wsum [usertype] csum @@
   net/core/filter.c:2072:35: sparse:     expected unsigned long long
   net/core/filter.c:2072:35: sparse:     got restricted __wsum [usertype] csum
   net/core/filter.c: note: in included file (through include/net/dst.h, include/net/sock.h, include/linux/sock_diag.h):
>> include/net/neighbour.h:307:38: sparse: sparse: cast removes address space '__rcu' of expression
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *
>> include/net/neighbour.h:307:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:307:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:307:38: sparse:    struct hlist_node *
   include/net/neighbour.h:309:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/neighbour.h:309:38: sparse:    struct hlist_node [noderef] __rcu *
   include/net/neighbour.h:309:38: sparse:    struct hlist_node *

vim +/__rcu +669 net/core/neighbour.c

   507	
   508	static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
   509	{
   510		size_t size = (1 << shift) * sizeof(struct hlist_head);
   511		struct neigh_hash_table *ret;
   512		struct hlist_head __rcu *buckets;
   513		int i;
   514	
   515		ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
   516		if (!ret)
   517			return NULL;
   518		if (size <= PAGE_SIZE) {
 > 519			buckets = kzalloc(size, GFP_ATOMIC);
   520		} else {
   521			buckets = (struct hlist_head __rcu *)
   522				  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
   523						   get_order(size));
 > 524			kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
   525		}
   526		if (!buckets) {
   527			kfree(ret);
   528			return NULL;
   529		}
   530		ret->hash_buckets = buckets;
   531		ret->hash_shift = shift;
   532		for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
   533			neigh_get_hash_rnd(&ret->hash_rnd[i]);
   534		return ret;
   535	}
   536	
   537	static void neigh_hash_free_rcu(struct rcu_head *head)
   538	{
   539		struct neigh_hash_table *nht = container_of(head,
   540							    struct neigh_hash_table,
   541							    rcu);
   542		size_t size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
   543		struct hlist_head __rcu *buckets = nht->hash_buckets;
   544	
   545		if (size <= PAGE_SIZE) {
 > 546			kfree(buckets);
   547		} else {
 > 548			kmemleak_free(buckets);
   549			free_pages((unsigned long)buckets, get_order(size));
   550		}
   551		kfree(nht);
   552	}
   553	
   554	static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
   555							unsigned long new_shift)
   556	{
   557		unsigned int i, hash;
   558		struct neigh_hash_table *new_nht, *old_nht;
   559	
   560		NEIGH_CACHE_STAT_INC(tbl, hash_grows);
   561	
   562		old_nht = rcu_dereference_protected(tbl->nht,
   563						    lockdep_is_held(&tbl->lock));
   564		new_nht = neigh_hash_alloc(new_shift);
   565		if (!new_nht)
   566			return old_nht;
   567	
   568		for (i = 0; i < (1 << old_nht->hash_shift); i++) {
   569			struct neighbour *n, *next;
   570	
   571			for (n = (struct neighbour *)
 > 572				rcu_dereference_protected(old_nht->hash_buckets[i].first,
   573							  lockdep_is_held(&tbl->lock));
   574			     n != NULL;
   575			     n = next) {
   576				hash = tbl->hash(n->primary_key, n->dev,
   577						 new_nht->hash_rnd);
   578	
   579				hash >>= (32 - new_nht->hash_shift);
   580				next = (struct neighbour *)hlist_next_rcu(&n->list);
   581				hlist_del_rcu(&n->list);
   582				hlist_add_head_rcu(&n->list, &new_nht->hash_buckets[hash]);
   583			}
   584		}
   585	
   586		rcu_assign_pointer(tbl->nht, new_nht);
   587		call_rcu(&old_nht->rcu, neigh_hash_free_rcu);
   588		return new_nht;
   589	}
   590	
   591	struct neighbour *neigh_lookup(struct neigh_table *tbl, const void *pkey,
   592				       struct net_device *dev)
   593	{
   594		struct neighbour *n;
   595	
   596		NEIGH_CACHE_STAT_INC(tbl, lookups);
   597	
   598		rcu_read_lock();
   599		n = __neigh_lookup_noref(tbl, pkey, dev);
   600		if (n) {
   601			if (!refcount_inc_not_zero(&n->refcnt))
   602				n = NULL;
   603			NEIGH_CACHE_STAT_INC(tbl, hits);
   604		}
   605	
   606		rcu_read_unlock();
   607		return n;
   608	}
   609	EXPORT_SYMBOL(neigh_lookup);
   610	
   611	static struct neighbour *
   612	___neigh_create(struct neigh_table *tbl, const void *pkey,
   613			struct net_device *dev, u32 flags,
   614			bool exempt_from_gc, bool want_ref)
   615	{
   616		u32 hash_val, key_len = tbl->key_len;
   617		struct neighbour *n1, *rc, *n;
   618		struct neigh_hash_table *nht;
   619		int error;
   620	
   621		n = neigh_alloc(tbl, dev, flags, exempt_from_gc);
   622		trace_neigh_create(tbl, dev, pkey, n, exempt_from_gc);
   623		if (!n) {
   624			rc = ERR_PTR(-ENOBUFS);
   625			goto out;
   626		}
   627	
   628		memcpy(n->primary_key, pkey, key_len);
   629		n->dev = dev;
   630		netdev_hold(dev, &n->dev_tracker, GFP_ATOMIC);
   631	
   632		/* Protocol specific setup. */
   633		if (tbl->constructor &&	(error = tbl->constructor(n)) < 0) {
   634			rc = ERR_PTR(error);
   635			goto out_neigh_release;
   636		}
   637	
   638		if (dev->netdev_ops->ndo_neigh_construct) {
   639			error = dev->netdev_ops->ndo_neigh_construct(dev, n);
   640			if (error < 0) {
   641				rc = ERR_PTR(error);
   642				goto out_neigh_release;
   643			}
   644		}
   645	
   646		/* Device specific setup. */
   647		if (n->parms->neigh_setup &&
   648		    (error = n->parms->neigh_setup(n)) < 0) {
   649			rc = ERR_PTR(error);
   650			goto out_neigh_release;
   651		}
   652	
   653		n->confirmed = jiffies - (NEIGH_VAR(n->parms, BASE_REACHABLE_TIME) << 1);
   654	
   655		write_lock_bh(&tbl->lock);
   656		nht = rcu_dereference_protected(tbl->nht,
   657						lockdep_is_held(&tbl->lock));
   658	
   659		if (atomic_read(&tbl->entries) > (1 << nht->hash_shift))
   660			nht = neigh_hash_grow(tbl, nht->hash_shift + 1);
   661	
   662		hash_val = tbl->hash(n->primary_key, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
   663	
   664		if (n->parms->dead) {
   665			rc = ERR_PTR(-EINVAL);
   666			goto out_tbl_unlock;
   667		}
   668	
 > 669		hlist_for_each_entry_rcu(n1,
   670					 &nht->hash_buckets[hash_val],
   671					 list,
   672					 lockdep_is_held(&tbl->lock)) {
   673			if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
   674				if (want_ref)
   675					neigh_hold(n1);
   676				rc = n1;
   677				goto out_tbl_unlock;
   678			}
   679		}
   680	
   681		n->dead = 0;
   682		if (!exempt_from_gc)
   683			list_add_tail(&n->gc_list, &n->tbl->gc_list);
   684		if (n->flags & NTF_MANAGED)
   685			list_add_tail(&n->managed_list, &n->tbl->managed_list);
   686		if (want_ref)
   687			neigh_hold(n);
 > 688		hlist_add_head_rcu(&n->list, &nht->hash_buckets[hash_val]);
   689		write_unlock_bh(&tbl->lock);
   690		neigh_dbg(2, "neigh %p is created\n", n);
   691		rc = n;
   692	out:
   693		return rc;
   694	out_tbl_unlock:
   695		write_unlock_bh(&tbl->lock);
   696	out_neigh_release:
   697		if (!exempt_from_gc)
   698			atomic_dec(&tbl->gc_entries);
   699		neigh_release(n);
   700		goto out;
   701	}
   702	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

