Return-Path: <netdev+bounces-205968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E5DB00F3B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE881CA8358
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5A299929;
	Thu, 10 Jul 2025 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKfpA/rT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510E28B7DF
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188775; cv=none; b=QiMZ7y2Vr/vrlCD1oLlq4Vbn8Hjypu4A2KTUKeQZANes/dk9EaBT3E4p9iBmdQpcKiVjrAykIPin3aG8prIFQ0tVndfmY90g4I203uM7hATVXp9CRUQbmwot45tqVuXR++mD3MyHQTomcpcmRizqyajbJ4Eas5fsC/wf7Ue/ECU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188775; c=relaxed/simple;
	bh=gR+udLZjcv0sGahdUh5bn/KKz8nD0rgunrRyccSYz6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgOeld6O1tM4wIJtsOhFRUspBSGLEWOXYleyzpvTh6s3TiLv/ThhvSKlKIhwU1e7W5roHNxesVH3vyPyKlTr1uKOxCqlR252sk8FbMl5jXObyL8oTcGuoMfJ/cKm07gON5PrAaqw8hJt9WM0Hdeq8/JExwFcQEINkebN4w40Gro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKfpA/rT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752188772; x=1783724772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gR+udLZjcv0sGahdUh5bn/KKz8nD0rgunrRyccSYz6Y=;
  b=mKfpA/rTh0ChbFi6Jwj4tuBFUjKUgpU1TIg/kqOXAe3+zOV5M+dkmiHT
   YU13a3s7XVAtzomi+x+qpHroZ7ijPYrg55+7Fuf67Q0dJcPl+j6mvH2Eg
   hPSAh5EzLI/AWp1bpcMrpSv+mEj9haPajgf2kpjufy0FCq194RXnU9rRW
   hlb8SLgMFTzBzfzIS4o3h0Li9/45oFkHO+FgLhffV7ur67yfb03otSRne
   w5Y98llOs6EcmhM5pCF3qQSjk34xzLEJWCUwAZ1KCL2w2w3Zi/Zw34AXh
   gkRB+8Dn/OvFqRuiwgYQ2oK32txkGidjMJM3NpYvCE5gPQ8vSene4Z6Lz
   w==;
X-CSE-ConnectionGUID: n/lEETRGQfC/0OhSye/rmQ==
X-CSE-MsgGUID: NNMS6XeFRuC3MiFm+m2OVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="72064154"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="72064154"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 16:06:12 -0700
X-CSE-ConnectionGUID: lZDEknDSRr+ZJ0FAc8ShhQ==
X-CSE-MsgGUID: oZ/Pr7TGTemQzpGJpgMZAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="156704259"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2025 16:06:09 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua0L7-0005ZH-28;
	Thu, 10 Jul 2025 23:06:05 +0000
Date: Fri, 11 Jul 2025 07:05:31 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v1 net-next] dev: Pass netdevice_tracker to
 dev_get_by_flags_rcu().
Message-ID: <202507110651.qJgShsUO-lkp@intel.com>
References: <20250709190144.659194-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709190144.659194-1-kuniyu@google.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/dev-Pass-netdevice_tracker-to-dev_get_by_flags_rcu/20250710-030425
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250709190144.659194-1-kuniyu%40google.com
patch subject: [PATCH v1 net-next] dev: Pass netdevice_tracker to dev_get_by_flags_rcu().
config: x86_64-randconfig-071-20250711 (https://download.01.org/0day-ci/archive/20250711/202507110651.qJgShsUO-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507110651.qJgShsUO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507110651.qJgShsUO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/dev.c:1294:17: error: use of undeclared identifier 'dev_get_by_flags_rcu'; did you mean 'netdev_get_by_flags_rcu'?
    1294 | EXPORT_IPV6_MOD(dev_get_by_flags_rcu);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 netdev_get_by_flags_rcu
   include/net/ip.h:693:42: note: expanded from macro 'EXPORT_IPV6_MOD'
     693 | #define EXPORT_IPV6_MOD(X) EXPORT_SYMBOL(X)
         |                                          ^
   include/linux/export.h:89:44: note: expanded from macro 'EXPORT_SYMBOL'
      89 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                                        ^
   include/linux/export.h:86:54: note: expanded from macro '_EXPORT_SYMBOL'
      86 | #define _EXPORT_SYMBOL(sym, license)    __EXPORT_SYMBOL(sym, license, "")
         |                                                         ^
   include/linux/export.h:76:16: note: expanded from macro '__EXPORT_SYMBOL'
      76 |         extern typeof(sym) sym;                                 \
         |                       ^
   net/core/dev.c:1280:20: note: 'netdev_get_by_flags_rcu' declared here
    1280 | struct net_device *netdev_get_by_flags_rcu(struct net *net, netdevice_tracker *tracker,
         |                    ^
   1 error generated.


vim +1294 net/core/dev.c

^1da177e4c3f415 Linus Torvalds    2005-04-16  1268  
^1da177e4c3f415 Linus Torvalds    2005-04-16  1269  /**
700489140bac828 Kuniyuki Iwashima 2025-07-09  1270   * netdev_get_by_flags_rcu - find any device with given flags
c4ea43c552ecc9c Randy Dunlap      2007-10-12  1271   * @net: the applicable net namespace
^1da177e4c3f415 Linus Torvalds    2005-04-16  1272   * @if_flags: IFF_* values
^1da177e4c3f415 Linus Torvalds    2005-04-16  1273   * @mask: bitmask of bits in if_flags to check
^1da177e4c3f415 Linus Torvalds    2005-04-16  1274   *
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1275   * Search for any interface with the given flags.
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1276   *
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1277   * Context: rcu_read_lock() must be held.
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1278   * Returns: NULL if a device is not found or a pointer to the device.
^1da177e4c3f415 Linus Torvalds    2005-04-16  1279   */
700489140bac828 Kuniyuki Iwashima 2025-07-09  1280  struct net_device *netdev_get_by_flags_rcu(struct net *net, netdevice_tracker *tracker,
700489140bac828 Kuniyuki Iwashima 2025-07-09  1281  					   unsigned short if_flags, unsigned short mask)
^1da177e4c3f415 Linus Torvalds    2005-04-16  1282  {
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1283  	struct net_device *dev;
6c555490e0ce885 WANG Cong         2014-09-11  1284  
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1285  	for_each_netdev_rcu(net, dev) {
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1286  		if (((READ_ONCE(dev->flags) ^ if_flags) & mask) == 0) {
700489140bac828 Kuniyuki Iwashima 2025-07-09  1287  			netdev_hold(dev, tracker, GFP_ATOMIC);
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1288  			return dev;
^1da177e4c3f415 Linus Torvalds    2005-04-16  1289  		}
^1da177e4c3f415 Linus Torvalds    2005-04-16  1290  	}
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1291  
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02  1292  	return NULL;
^1da177e4c3f415 Linus Torvalds    2005-04-16  1293  }
eb1ac9ff6c4a572 Kuniyuki Iwashima 2025-07-02 @1294  EXPORT_IPV6_MOD(dev_get_by_flags_rcu);
^1da177e4c3f415 Linus Torvalds    2005-04-16  1295  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

