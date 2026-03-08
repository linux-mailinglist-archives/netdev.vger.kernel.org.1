Return-Path: <netdev+bounces-265298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O4eHIHJzrWmf3AEAu9opvQ
	(envelope-from <netdev+bounces-265298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:02:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1027230532
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 14:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C66E300EF85
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626F637FF64;
	Sun,  8 Mar 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4M83TJz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767F37E2EE
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772974958; cv=none; b=FYmtP0HQB74RfVQOFDn/nivwiCugmUrQ1RauRfCbYEFlCgRqEsIyETeTuygKlyY+qzAhHHOnYxb70Iym88LJrT53nXLgk/+q9liLW1Z+MWq6dfKtWebB5rjXUzZpJ3ssxttkNF7kqfvmN0HkLac9ZC7eKZmbPgS1GbBXtJ+xo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772974958; c=relaxed/simple;
	bh=5wKwcIM9/JT7IVaFwYBUG1ERFtjxawAgFFjSCMOGK2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFlrAIGelPMicNzQ2v1AKYSlLlxlMcW/yHM+u12TUk2ch/uioICZGGU/y/cmtyGaD0gIDoiGt7WbPLYYmpdUtt6C0rLiOJUOgZMydtt0Npfp+ngAVAfIM2yIa2Ipq8DVmc/Zd0e2DWBwU4+E/E9EC7yvuOyR3Bmhw01AU2/qGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4M83TJz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772974955; x=1804510955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5wKwcIM9/JT7IVaFwYBUG1ERFtjxawAgFFjSCMOGK2c=;
  b=n4M83TJzD+PkyXTuzadI1KKsJZWneWsDHUI0mQMZl1Xje6J0JQLboOc0
   F4tP3hhBhrMhiWzvn3hUafNyHweHyq5+F33OoIvwPxhZyDqhPi8ACaUpT
   PVX/zASrDy5Y2o5DgRaC9CgC97Xr186Zti2blnRKBLW1CzhpDBcy9rftT
   imH9HIDPQO7rVm/tUKuz/DDCbTCCn1Mnm9ERZ6u7lKjqVsYxOO/Alr5yA
   Dj1EMVJc3OXZNgATaeR46cmJ97Pv+WOY2+W+vEWLv47tXWzr86IqYyq8p
   yXx8USzu8zmTHpL4FRmjqPoHUnZEFM7xs0w1EBs5D/FACGUE8PTXDinXJ
   w==;
X-CSE-ConnectionGUID: 7yF91ADgTMOhB5nQvdk6rg==
X-CSE-MsgGUID: TFOtPe4RRbu4mqx6dgxjqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="77895303"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="77895303"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 06:02:34 -0700
X-CSE-ConnectionGUID: 13f6q7PYQKSn9/PFfpSoDQ==
X-CSE-MsgGUID: Ziz8lOSvQjyXPovqbeY8gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="217595544"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Mar 2026 06:02:33 -0700
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzDm9-0000000037Q-0E5T;
	Sun, 08 Mar 2026 13:02:29 +0000
Date: Sun, 8 Mar 2026 21:02:17 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Kui-Feng Lee <thinker.li@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
Message-ID: <202603082146.XcUdD9Ob-lkp@intel.com>
References: <20260308032304.1841198-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308032304.1841198-3-kuniyu@google.com>
X-Rspamd-Queue-Id: E1027230532
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,kernel.org,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265298-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/ipv6-Remove-permanent-routes-from-tb6_gc_hlist-when-all-exceptions-expire/20260308-113030
base:   net/main
patch link:    https://lore.kernel.org/r/20260308032304.1841198-3-kuniyu%40google.com
patch subject: [PATCH v2 net 2/2] ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260308/202603082146.XcUdD9Ob-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603082146.XcUdD9Ob-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603082146.XcUdD9Ob-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv6/addrconf.c: In function 'cleanup_prefix_route':
>> net/ipv6/addrconf.c:1282:33: error: implicit declaration of function 'fib6_add_gc_list' [-Werror=implicit-function-declaration]
    1282 |                                 fib6_add_gc_list(f6i);
         |                                 ^~~~~~~~~~~~~~~~
   net/ipv6/addrconf.c: In function 'addrconf_prefix_rcv':
>> net/ipv6/addrconf.c:2865:41: error: implicit declaration of function 'fib6_may_remove_gc_list' [-Werror=implicit-function-declaration]
    2865 |                                         fib6_may_remove_gc_list(net, rt);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   net/ipv6/route.c: In function 'rt6_route_rcv':
>> net/ipv6/route.c:1036:25: error: implicit declaration of function 'fib6_may_remove_gc_list' [-Werror=implicit-function-declaration]
    1036 |                         fib6_may_remove_gc_list(net, rt);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
>> net/ipv6/route.c:1039:25: error: implicit declaration of function 'fib6_add_gc_list' [-Werror=implicit-function-declaration]
    1039 |                         fib6_add_gc_list(rt);
         |                         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   net/ipv6/ip6_fib.c: In function 'fib6_purge_rt':
>> net/ipv6/ip6_fib.c:1073:9: error: implicit declaration of function 'fib6_remove_gc_list' [-Werror=implicit-function-declaration]
    1073 |         fib6_remove_gc_list(rt);
         |         ^~~~~~~~~~~~~~~~~~~
   net/ipv6/ip6_fib.c: In function 'fib6_add_rt2node':
>> net/ipv6/ip6_fib.c:1136:41: error: implicit declaration of function 'fib6_may_remove_gc_list' [-Werror=implicit-function-declaration]
    1136 |                                         fib6_may_remove_gc_list(info->nl_net, iter);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
>> net/ipv6/ip6_fib.c:1139:41: error: implicit declaration of function 'fib6_add_gc_list' [-Werror=implicit-function-declaration]
    1139 |                                         fib6_add_gc_list(iter);
         |                                         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   net/ipv6/ndisc.c: In function 'ndisc_router_discovery':
>> net/ipv6/ndisc.c:1405:17: error: implicit declaration of function 'fib6_add_gc_list' [-Werror=implicit-function-declaration]
    1405 |                 fib6_add_gc_list(rt);
         |                 ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/fib6_add_gc_list +1282 net/ipv6/addrconf.c

5b84efecb7d939 Thomas Haller 2014-01-15  1262  
5b84efecb7d939 Thomas Haller 2014-01-15  1263  static void
d0098e4c6b83e5 Hangbin Liu   2020-03-03  1264  cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long expires,
d0098e4c6b83e5 Hangbin Liu   2020-03-03  1265  		     bool del_rt, bool del_peer)
5b84efecb7d939 Thomas Haller 2014-01-15  1266  {
5eb902b8e7193c Kui-Feng Lee  2024-02-08  1267  	struct fib6_table *table;
93c2fb253d177a David Ahern   2018-04-18  1268  	struct fib6_info *f6i;
5b84efecb7d939 Thomas Haller 2014-01-15  1269  
d0098e4c6b83e5 Hangbin Liu   2020-03-03  1270  	f6i = addrconf_get_prefix_route(del_peer ? &ifp->peer_addr : &ifp->addr,
d0098e4c6b83e5 Hangbin Liu   2020-03-03  1271  					ifp->prefix_len,
2b2450ca4a2d9d David Ahern   2019-03-27  1272  					ifp->idev->dev, 0, RTF_DEFAULT, true);
93c2fb253d177a David Ahern   2018-04-18  1273  	if (f6i) {
5b84efecb7d939 Thomas Haller 2014-01-15  1274  		if (del_rt)
11dd74b338bf83 Roopa Prabhu  2020-04-27  1275  			ip6_del_rt(dev_net(ifp->idev->dev), f6i, false);
5b84efecb7d939 Thomas Haller 2014-01-15  1276  		else {
5eb902b8e7193c Kui-Feng Lee  2024-02-08  1277  			if (!(f6i->fib6_flags & RTF_EXPIRES)) {
5eb902b8e7193c Kui-Feng Lee  2024-02-08  1278  				table = f6i->fib6_table;
5eb902b8e7193c Kui-Feng Lee  2024-02-08  1279  				spin_lock_bh(&table->tb6_lock);
5eb902b8e7193c Kui-Feng Lee  2024-02-08  1280  
93c2fb253d177a David Ahern   2018-04-18  1281  				fib6_set_expires(f6i, expires);
5eb902b8e7193c Kui-Feng Lee  2024-02-08 @1282  				fib6_add_gc_list(f6i);
5eb902b8e7193c Kui-Feng Lee  2024-02-08  1283  
5eb902b8e7193c Kui-Feng Lee  2024-02-08  1284  				spin_unlock_bh(&table->tb6_lock);
5eb902b8e7193c Kui-Feng Lee  2024-02-08  1285  			}
93c2fb253d177a David Ahern   2018-04-18  1286  			fib6_info_release(f6i);
5b84efecb7d939 Thomas Haller 2014-01-15  1287  		}
5b84efecb7d939 Thomas Haller 2014-01-15  1288  	}
5b84efecb7d939 Thomas Haller 2014-01-15  1289  }
5b84efecb7d939 Thomas Haller 2014-01-15  1290  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

