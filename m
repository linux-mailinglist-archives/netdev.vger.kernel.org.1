Return-Path: <netdev+bounces-155702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CC5A035C3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 04:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334C11884D4F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16D2156968;
	Tue,  7 Jan 2025 03:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br2dCDmh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA56155335
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736219689; cv=none; b=YVP4EOkqpw3zof6pOYpEiyMzD6T1OyD7LJ+e0eBm/qVV9MntkvceQb5RcFEo6XlgwFdlMuWsUwJD85aZPL1+6wkOLY6CpNTwmCjsbR/HgMLrsQku5mlOWUmDAZIxKnp/JIUghtRBPgeERALPcQ11xyessqs5R8gvOaMSqxuOTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736219689; c=relaxed/simple;
	bh=Pfm00YwR8YUIKzSJYC6BjhwDrzJ/MAOmPqfxOXYaWII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0guKf3jj3or6PtrubV0UPINeS8e4B9YG4U8BmpACESiVRbe4iX5ioLx6FlAfYRdEIPrTYTiptPThN+N+bfXmV4qbWGSnbdo1xkO76TtVJ4Qk6k0oAqu025UcJCsXQ3dEqOmw69rJdg4TrT55WDvaTU+oeralKQRHcXqhoRShE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br2dCDmh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736219686; x=1767755686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Pfm00YwR8YUIKzSJYC6BjhwDrzJ/MAOmPqfxOXYaWII=;
  b=Br2dCDmh/O2N9qQT++XZaGVOvcC5SsLxfSksIvE3mz3Q839rGSuPrgae
   j7r60YEIRc7i9+Qt9igNKT8u6BRn2akFhFJetqUIBi+TSL0zdYMNZXezy
   12nFCcgdXc8mhr0TfAcze8f2IEyKJxRdNPiwitTQvHwOHEn5Mmq/1pvKF
   t8dbkYmT2wlmFDBpTwDNpixOkkGU5CwjvyZJfZVTgfB2uclCFdxnyEPt1
   cParHXzJ1RS1Iqmmze86FikUpAIkHa1pj87MPzMhAhbDqb4rINUNKh5jB
   ux9/X4k2mq5K4IIxmynHbuGoXvMkQSFhTFNTHZOyxwAPgCIIL1eSdDQgS
   A==;
X-CSE-ConnectionGUID: CTL/w/JyS8KHWJP7gN5rvg==
X-CSE-MsgGUID: oYNFTr1PSC21mvfzDJty3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="58848365"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="58848365"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 19:14:46 -0800
X-CSE-ConnectionGUID: MsY+Y5jeTuWBSlRUzZYcKg==
X-CSE-MsgGUID: dx2me4eAT/2CvIT3StcRTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="103132334"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Jan 2025 19:14:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tV03D-000EAJ-1n;
	Tue, 07 Jan 2025 03:14:39 +0000
Date: Tue, 7 Jan 2025 11:13:43 +0800
From: kernel test robot <lkp@intel.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev,
	syzbot+f63600d288bfb7057424@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net] sched: sch_cake: add bounds checks to host bulk flow
 fairness counts
Message-ID: <202501071052.ZOECqwS9-lkp@intel.com>
References: <20250106133837.18609-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250106133837.18609-1-toke@redhat.com>

Hi Toke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Toke-H-iland-J-rgensen/sched-sch_cake-add-bounds-checks-to-host-bulk-flow-fairness-counts/20250106-214156
base:   net/main
patch link:    https://lore.kernel.org/r/20250106133837.18609-1-toke%40redhat.com
patch subject: [PATCH net] sched: sch_cake: add bounds checks to host bulk flow fairness counts
config: i386-buildonly-randconfig-004-20250107 (https://download.01.org/0day-ci/archive/20250107/202501071052.ZOECqwS9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250107/202501071052.ZOECqwS9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501071052.ZOECqwS9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/sched/sch_cake.c: In function 'cake_dequeue':
>> net/sched/sch_cake.c:1975:37: warning: variable 'dsthost' set but not used [-Wunused-but-set-variable]
    1975 |         struct cake_host *srchost, *dsthost;
         |                                     ^~~~~~~
>> net/sched/sch_cake.c:1975:27: warning: variable 'srchost' set but not used [-Wunused-but-set-variable]
    1975 |         struct cake_host *srchost, *dsthost;
         |                           ^~~~~~~


vim +/dsthost +1975 net/sched/sch_cake.c

046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1970  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1971  static struct sk_buff *cake_dequeue(struct Qdisc *sch)
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1972  {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1973  	struct cake_sched_data *q = qdisc_priv(sch);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1974  	struct cake_tin_data *b = &q->tins[q->cur_tin];
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06 @1975  	struct cake_host *srchost, *dsthost;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1976  	ktime_t now = ktime_get();
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1977  	struct cake_flow *flow;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1978  	struct list_head *head;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1979  	bool first_flow = true;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1980  	struct sk_buff *skb;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1981  	u64 delay;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1982  	u32 len;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1983  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1984  begin:
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1985  	if (!sch->q.qlen)
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1986  		return NULL;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1987  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1988  	/* global hard shaper */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1989  	if (ktime_after(q->time_next_packet, now) &&
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1990  	    ktime_after(q->failsafe_next_packet, now)) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1991  		u64 next = min(ktime_to_ns(q->time_next_packet),
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1992  			       ktime_to_ns(q->failsafe_next_packet));
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1993  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1994  		sch->qstats.overlimits++;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1995  		qdisc_watchdog_schedule_ns(&q->watchdog, next);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1996  		return NULL;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1997  	}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1998  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  1999  	/* Choose a class to work on. */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2000  	if (!q->rate_ns) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2001  		/* In unlimited mode, can't rely on shaper timings, just balance
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2002  		 * with DRR
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2003  		 */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2004  		bool wrapped = false, empty = true;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2005  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2006  		while (b->tin_deficit < 0 ||
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2007  		       !(b->sparse_flow_count + b->bulk_flow_count)) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2008  			if (b->tin_deficit <= 0)
cbd22f172df782 Kevin 'ldir' Darbyshire-Bryant 2019-12-18  2009  				b->tin_deficit += b->tin_quantum;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2010  			if (b->sparse_flow_count + b->bulk_flow_count)
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2011  				empty = false;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2012  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2013  			q->cur_tin++;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2014  			b++;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2015  			if (q->cur_tin >= q->tin_cnt) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2016  				q->cur_tin = 0;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2017  				b = q->tins;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2018  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2019  				if (wrapped) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2020  					/* It's possible for q->qlen to be
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2021  					 * nonzero when we actually have no
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2022  					 * packets anywhere.
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2023  					 */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2024  					if (empty)
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2025  						return NULL;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2026  				} else {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2027  					wrapped = true;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2028  				}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2029  			}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2030  		}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2031  	} else {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2032  		/* In shaped mode, choose:
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2033  		 * - Highest-priority tin with queue and meeting schedule, or
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2034  		 * - The earliest-scheduled tin with queue.
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2035  		 */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2036  		ktime_t best_time = KTIME_MAX;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2037  		int tin, best_tin = 0;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2038  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2039  		for (tin = 0; tin < q->tin_cnt; tin++) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2040  			b = q->tins + tin;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2041  			if ((b->sparse_flow_count + b->bulk_flow_count) > 0) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2042  				ktime_t time_to_pkt = \
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2043  					ktime_sub(b->time_next_packet, now);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2044  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2045  				if (ktime_to_ns(time_to_pkt) <= 0 ||
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2046  				    ktime_compare(time_to_pkt,
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2047  						  best_time) <= 0) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2048  					best_time = time_to_pkt;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2049  					best_tin = tin;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2050  				}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2051  			}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2052  		}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2053  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2054  		q->cur_tin = best_tin;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2055  		b = q->tins + best_tin;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2056  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2057  		/* No point in going further if no packets to deliver. */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2058  		if (unlikely(!(b->sparse_flow_count + b->bulk_flow_count)))
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2059  			return NULL;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2060  	}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2061  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2062  retry:
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2063  	/* service this class */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2064  	head = &b->decaying_flows;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2065  	if (!first_flow || list_empty(head)) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2066  		head = &b->new_flows;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2067  		if (list_empty(head)) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2068  			head = &b->old_flows;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2069  			if (unlikely(list_empty(head))) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2070  				head = &b->decaying_flows;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2071  				if (unlikely(list_empty(head)))
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2072  					goto begin;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2073  			}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2074  		}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2075  	}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2076  	flow = list_first_entry(head, struct cake_flow, flowchain);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2077  	q->cur_flow = flow - b->flows;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2078  	first_flow = false;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2079  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2080  	/* triple isolation (modified DRR++) */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2081  	srchost = &b->hosts[flow->srchost];
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2082  	dsthost = &b->hosts[flow->dsthost];
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2083  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2084  	/* flow isolation (DRR++) */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2085  	if (flow->deficit <= 0) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2086  		/* Keep all flows with deficits out of the sparse and decaying
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2087  		 * rotations.  No non-empty flow can go into the decaying
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2088  		 * rotation, so they can't get deficits
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2089  		 */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2090  		if (flow->set == CAKE_SET_SPARSE) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2091  			if (flow->head) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2092  				b->sparse_flow_count--;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2093  				b->bulk_flow_count++;
712639929912c5 George Amanakis                2019-03-01  2094  
c75152104797f8 Toke Høiland-Jørgensen         2025-01-06  2095  				cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
c75152104797f8 Toke Høiland-Jørgensen         2025-01-06  2096  				cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
712639929912c5 George Amanakis                2019-03-01  2097  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2098  				flow->set = CAKE_SET_BULK;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2099  			} else {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2100  				/* we've moved it to the bulk rotation for
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2101  				 * correct deficit accounting but we still want
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2102  				 * to count it as a sparse flow, not a bulk one.
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2103  				 */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2104  				flow->set = CAKE_SET_SPARSE_WAIT;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2105  			}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2106  		}
712639929912c5 George Amanakis                2019-03-01  2107  
c75152104797f8 Toke Høiland-Jørgensen         2025-01-06  2108  		flow->deficit += cake_get_flow_quantum(b, flow, q->flow_mode);
712639929912c5 George Amanakis                2019-03-01  2109  		list_move_tail(&flow->flowchain, &b->old_flows);
712639929912c5 George Amanakis                2019-03-01  2110  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2111  		goto retry;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2112  	}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2113  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2114  	/* Retrieve a packet via the AQM */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2115  	while (1) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2116  		skb = cake_dequeue_one(sch);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2117  		if (!skb) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2118  			/* this queue was actually empty */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2119  			if (cobalt_queue_empty(&flow->cvars, &b->cparams, now))
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2120  				b->unresponsive_flow_count--;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2121  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2122  			if (flow->cvars.p_drop || flow->cvars.count ||
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2123  			    ktime_before(now, flow->cvars.drop_next)) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2124  				/* keep in the flowchain until the state has
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2125  				 * decayed to rest
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2126  				 */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2127  				list_move_tail(&flow->flowchain,
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2128  					       &b->decaying_flows);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2129  				if (flow->set == CAKE_SET_BULK) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2130  					b->bulk_flow_count--;
712639929912c5 George Amanakis                2019-03-01  2131  
c75152104797f8 Toke Høiland-Jørgensen         2025-01-06  2132  					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
c75152104797f8 Toke Høiland-Jørgensen         2025-01-06  2133  					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
712639929912c5 George Amanakis                2019-03-01  2134  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2135  					b->decaying_flow_count++;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2136  				} else if (flow->set == CAKE_SET_SPARSE ||
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2137  					   flow->set == CAKE_SET_SPARSE_WAIT) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2138  					b->sparse_flow_count--;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2139  					b->decaying_flow_count++;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2140  				}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2141  				flow->set = CAKE_SET_DECAYING;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2142  			} else {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2143  				/* remove empty queue from the flowchain */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2144  				list_del_init(&flow->flowchain);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2145  				if (flow->set == CAKE_SET_SPARSE ||
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2146  				    flow->set == CAKE_SET_SPARSE_WAIT)
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2147  					b->sparse_flow_count--;
712639929912c5 George Amanakis                2019-03-01  2148  				else if (flow->set == CAKE_SET_BULK) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2149  					b->bulk_flow_count--;
712639929912c5 George Amanakis                2019-03-01  2150  
c75152104797f8 Toke Høiland-Jørgensen         2025-01-06  2151  					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
c75152104797f8 Toke Høiland-Jørgensen         2025-01-06  2152  					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
712639929912c5 George Amanakis                2019-03-01  2153  				} else
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2154  					b->decaying_flow_count--;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2155  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2156  				flow->set = CAKE_SET_NONE;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2157  			}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2158  			goto begin;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2159  		}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2160  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2161  		/* Last packet in queue may be marked, shouldn't be dropped */
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2162  		if (!cobalt_should_drop(&flow->cvars, &b->cparams, now, skb,
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2163  					(b->bulk_flow_count *
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2164  					 !!(q->rate_flags &
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2165  					    CAKE_FLAG_INGRESS))) ||
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2166  		    !flow->head)
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2167  			break;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2168  
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2169  		/* drop this packet, get another one */
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2170  		if (q->rate_flags & CAKE_FLAG_INGRESS) {
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2171  			len = cake_advance_shaper(q, b, skb,
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2172  						  now, true);
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2173  			flow->deficit -= len;
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2174  			b->tin_deficit -= len;
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2175  		}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2176  		flow->dropped++;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2177  		b->tin_dropped++;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2178  		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2179  		qdisc_qstats_drop(sch);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2180  		kfree_skb(skb);
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2181  		if (q->rate_flags & CAKE_FLAG_INGRESS)
7298de9cd7255a Toke Høiland-Jørgensen         2018-07-06  2182  			goto retry;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2183  	}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2184  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2185  	b->tin_ecn_mark += !!flow->cvars.ecn_marked;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2186  	qdisc_bstats_update(sch, skb);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2187  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2188  	/* collect delay stats */
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2189  	delay = ktime_to_ns(ktime_sub(now, cobalt_get_enqueue_time(skb)));
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2190  	b->avge_delay = cake_ewma(b->avge_delay, delay, 8);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2191  	b->peak_delay = cake_ewma(b->peak_delay, delay,
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2192  				  delay > b->peak_delay ? 2 : 8);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2193  	b->base_delay = cake_ewma(b->base_delay, delay,
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2194  				  delay < b->base_delay ? 2 : 8);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2195  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2196  	len = cake_advance_shaper(q, b, skb, now, false);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2197  	flow->deficit -= len;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2198  	b->tin_deficit -= len;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2199  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2200  	if (ktime_after(q->time_next_packet, now) && sch->q.qlen) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2201  		u64 next = min(ktime_to_ns(q->time_next_packet),
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2202  			       ktime_to_ns(q->failsafe_next_packet));
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2203  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2204  		qdisc_watchdog_schedule_ns(&q->watchdog, next);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2205  	} else if (!sch->q.qlen) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2206  		int i;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2207  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2208  		for (i = 0; i < q->tin_cnt; i++) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2209  			if (q->tins[i].decaying_flow_count) {
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2210  				ktime_t next = \
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2211  					ktime_add_ns(now,
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2212  						     q->tins[i].cparams.target);
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2213  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2214  				qdisc_watchdog_schedule_ns(&q->watchdog,
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2215  							   ktime_to_ns(next));
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2216  				break;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2217  			}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2218  		}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2219  	}
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2220  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2221  	if (q->overflow_timeout)
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2222  		q->overflow_timeout--;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2223  
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2224  	return skb;
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2225  }
046f6fd5daefac Toke Høiland-Jørgensen         2018-07-06  2226  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

