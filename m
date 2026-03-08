Return-Path: <netdev+bounces-265309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHU7J8aMrWkl4QEAu9opvQ
	(envelope-from <netdev+bounces-265309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 15:50:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D906230BE3
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 15:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 408B33005A8C
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F0246774;
	Sun,  8 Mar 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEPUjMWD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77BE1D47B4
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772981442; cv=none; b=gWGP2fNX5vCWl00lfmqHhiBcnGFIvLJiXCGGX+QArFDxT/ZX46zdpd/BhxsGhYx7Ru8+BlhZQstei4x1TEw8VGvtSwszFo2MGop9hOBQmb03WRpRJ7aI8k1D6Q/1dzeF8wFjIhw1GeNBl9M1mHCYZ/sNAXEM++GocsLpMlPjrKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772981442; c=relaxed/simple;
	bh=ya7IGQQMqrpD1PRzjzeApYjZ3tn4leNLkyn1Vk0Gk6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UND2jWBVrZyPlY9bKyiKAUeoJmOd8q8unt/+AJChdnNUT0mTX+wVd5vmHB88xG0nTPkr7bsU7JWS6EtV+nWxSfoe9SCI32lLW8RKO6M3BL6dMsIqkCNCh52PEDIeC/Z2cKjN98SdqoZ9cYUVUZSLCpm8FkjkGlwHReZSrOahTZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEPUjMWD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772981441; x=1804517441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ya7IGQQMqrpD1PRzjzeApYjZ3tn4leNLkyn1Vk0Gk6g=;
  b=KEPUjMWDopl5aQhKm07H50+i2huJgKK1qmtz+fnis31eZqEPhpTw5tLH
   nNM44L+M5x/l8UKzCQ134RAOyKMIl/CTtiLeFmKtaa6M0i0mDgVRBXZ7l
   x/pmXud4GXiTiE53PlCanzgODgaO8ByYZz8JuZN75i3d3AYUmsK4UudnP
   6fLauztGPM5I9euoLalFA8+UazKOYFIunlnP8u5ndTohEvUCboUshNJhn
   cGNoDfURWmvry5Ug+cIHmKjYVkCmABGYtr7MND+r4AvGBnMlVDdtCw60R
   GVdkEVxwLI6OvCJWy4XfHNZCvrpI2GyeNC27Veg8NTZnNL4Mg4FNTi8aj
   Q==;
X-CSE-ConnectionGUID: wH/TRGvlRrmKcSrVlECfWw==
X-CSE-MsgGUID: Pc4a1mv6RaeRiOjPExTJlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73895174"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="73895174"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 07:50:40 -0700
X-CSE-ConnectionGUID: x704P8jhRDWQLxRpxHzN9Q==
X-CSE-MsgGUID: Dwld1+/FT/aOTS1BS5Ylyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="217609807"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Mar 2026 07:50:37 -0700
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzFSk-000000003BE-2seO;
	Sun, 08 Mar 2026 14:50:34 +0000
Date: Sun, 8 Mar 2026 22:50:11 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
Message-ID: <202603082250.0lR88YW6-lkp@intel.com>
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
X-Rspamd-Queue-Id: 3D906230BE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265309-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/ipv6-Remove-permanent-routes-from-tb6_gc_hlist-when-all-exceptions-expire/20260308-113030
base:   net/main
patch link:    https://lore.kernel.org/r/20260308032304.1841198-3-kuniyu%40google.com
patch subject: [PATCH v2 net 2/2] ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260308/202603082250.0lR88YW6-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c32caeec8158d634bb71ab8911a6031248b9fc47)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603082250.0lR88YW6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603082250.0lR88YW6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv6/addrconf.c:1282:5: error: call to undeclared function 'fib6_add_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1282 |                                 fib6_add_gc_list(f6i);
         |                                 ^
   net/ipv6/addrconf.c:2862:6: error: call to undeclared function 'fib6_add_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2862 |                                         fib6_add_gc_list(rt);
         |                                         ^
>> net/ipv6/addrconf.c:2865:6: error: call to undeclared function 'fib6_may_remove_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2865 |                                         fib6_may_remove_gc_list(net, rt);
         |                                         ^
   net/ipv6/addrconf.c:4843:4: error: call to undeclared function 'fib6_may_remove_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    4843 |                         fib6_may_remove_gc_list(net, f6i);
         |                         ^
   net/ipv6/addrconf.c:4846:4: error: call to undeclared function 'fib6_add_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    4846 |                         fib6_add_gc_list(f6i);
         |                         ^
   5 errors generated.
--
>> net/ipv6/route.c:1036:4: error: call to undeclared function 'fib6_may_remove_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1036 |                         fib6_may_remove_gc_list(net, rt);
         |                         ^
>> net/ipv6/route.c:1039:4: error: call to undeclared function 'fib6_add_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1039 |                         fib6_add_gc_list(rt);
         |                         ^
   net/ipv6/route.c:1786:3: error: call to undeclared function 'fib6_add_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1786 |                 fib6_add_gc_list(f6i);
         |                 ^
   3 errors generated.
--
>> net/ipv6/ip6_fib.c:1073:2: error: call to undeclared function 'fib6_remove_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1073 |         fib6_remove_gc_list(rt);
         |         ^
>> net/ipv6/ip6_fib.c:1136:6: error: call to undeclared function 'fib6_may_remove_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1136 |                                         fib6_may_remove_gc_list(info->nl_net, iter);
         |                                         ^
>> net/ipv6/ip6_fib.c:1139:6: error: call to undeclared function 'fib6_add_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1139 |                                         fib6_add_gc_list(iter);
         |                                         ^
   net/ipv6/ip6_fib.c:1546:4: error: call to undeclared function 'fib6_add_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1546 |                         fib6_add_gc_list(rt);
         |                         ^
   net/ipv6/ip6_fib.c:2360:3: error: call to undeclared function 'fib6_remove_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2360 |                 fib6_remove_gc_list(rt);
         |                 ^
   5 errors generated.
--
>> net/ipv6/ndisc.c:1405:3: error: call to undeclared function 'fib6_add_gc_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1405 |                 fib6_add_gc_list(rt);
         |                 ^
   1 error generated.


vim +/fib6_add_gc_list +1282 net/ipv6/addrconf.c

5b84efecb7d939d Thomas Haller 2014-01-15  1262  
5b84efecb7d939d Thomas Haller 2014-01-15  1263  static void
d0098e4c6b83e50 Hangbin Liu   2020-03-03  1264  cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long expires,
d0098e4c6b83e50 Hangbin Liu   2020-03-03  1265  		     bool del_rt, bool del_peer)
5b84efecb7d939d Thomas Haller 2014-01-15  1266  {
5eb902b8e7193cd Kui-Feng Lee  2024-02-08  1267  	struct fib6_table *table;
93c2fb253d177a0 David Ahern   2018-04-18  1268  	struct fib6_info *f6i;
5b84efecb7d939d Thomas Haller 2014-01-15  1269  
d0098e4c6b83e50 Hangbin Liu   2020-03-03  1270  	f6i = addrconf_get_prefix_route(del_peer ? &ifp->peer_addr : &ifp->addr,
d0098e4c6b83e50 Hangbin Liu   2020-03-03  1271  					ifp->prefix_len,
2b2450ca4a2d9d7 David Ahern   2019-03-27  1272  					ifp->idev->dev, 0, RTF_DEFAULT, true);
93c2fb253d177a0 David Ahern   2018-04-18  1273  	if (f6i) {
5b84efecb7d939d Thomas Haller 2014-01-15  1274  		if (del_rt)
11dd74b338bf83f Roopa Prabhu  2020-04-27  1275  			ip6_del_rt(dev_net(ifp->idev->dev), f6i, false);
5b84efecb7d939d Thomas Haller 2014-01-15  1276  		else {
5eb902b8e7193cd Kui-Feng Lee  2024-02-08  1277  			if (!(f6i->fib6_flags & RTF_EXPIRES)) {
5eb902b8e7193cd Kui-Feng Lee  2024-02-08  1278  				table = f6i->fib6_table;
5eb902b8e7193cd Kui-Feng Lee  2024-02-08  1279  				spin_lock_bh(&table->tb6_lock);
5eb902b8e7193cd Kui-Feng Lee  2024-02-08  1280  
93c2fb253d177a0 David Ahern   2018-04-18  1281  				fib6_set_expires(f6i, expires);
5eb902b8e7193cd Kui-Feng Lee  2024-02-08 @1282  				fib6_add_gc_list(f6i);
5eb902b8e7193cd Kui-Feng Lee  2024-02-08  1283  
5eb902b8e7193cd Kui-Feng Lee  2024-02-08  1284  				spin_unlock_bh(&table->tb6_lock);
5eb902b8e7193cd Kui-Feng Lee  2024-02-08  1285  			}
93c2fb253d177a0 David Ahern   2018-04-18  1286  			fib6_info_release(f6i);
5b84efecb7d939d Thomas Haller 2014-01-15  1287  		}
5b84efecb7d939d Thomas Haller 2014-01-15  1288  	}
5b84efecb7d939d Thomas Haller 2014-01-15  1289  }
5b84efecb7d939d Thomas Haller 2014-01-15  1290  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

