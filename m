Return-Path: <netdev+bounces-207693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC9BB08417
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 06:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7BE566435
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 04:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C8D202F67;
	Thu, 17 Jul 2025 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0A49RFq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB20201266;
	Thu, 17 Jul 2025 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726928; cv=none; b=m+gUyOLr0U8G0O9Kx3jD6r4qdX0dc3f54svBIIFuBAHCDVRuDxD6Dd+ueWetnL/w6oDAzlCpv2o3jMKsxmbFR4prqhpRAAbUppkAHf/pEXH9bXtoXsmScmrdMzzadF9ShQ0KccTzzL1JdMzUtHpKH9KFUYDPOJfWdV2dds0OZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726928; c=relaxed/simple;
	bh=z9mn+EO35VMqhGecIxe0cnRbyrV0b0hdlIaV5NLXzKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFfuf6BoUP0/aRqsPVxN7IjZ6/bNXeNkWVSZxlQSom38oEk4s4f3pQYu0KK4zak+HY4mErAu9nCAy4I8uQZ5PQtvN5pNff0ipIUJqkkZ+dT6gsfWUSigfwxe7+uRNXZzRWma0ryZUwkUNpLNt6dUI5h24m76ggiX3GN3Nh37UzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0A49RFq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752726928; x=1784262928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z9mn+EO35VMqhGecIxe0cnRbyrV0b0hdlIaV5NLXzKY=;
  b=C0A49RFqi0H8Tz90Q7EWWZRP0s5OVkW/TVNgQZlWrb0ShvAakirIWsKI
   PlCz7hSuC7++s/GN+OyoGmzyROq36QTabbA5fLr64bHTcUwmEWljbqPlS
   Xt0fOmH4ZqpeND13l4Zrv3Oh/goCRlHnZiVHRP+S4BOAxD5ZDHJC17UdW
   aDGBiJi+a0RQLpT5tEd1EYSnttwSqKDAKPQUhEp41YZVjeGgarnIu6mDH
   i0uMPWAko7/oAWJXGOkoxGHDlK4IMzjFtp5YkjToS4sq4Le1isC4oxMee
   x4TeRdQUF6fvPbPYvED3JlWObaOF+45mF14HLtndRkyUiZBHoowL5/mf8
   g==;
X-CSE-ConnectionGUID: trAvtDiKQeuIdE6PuQ658A==
X-CSE-MsgGUID: NMebOJAOQwa27ScoDTkqXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58657222"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="58657222"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 21:35:27 -0700
X-CSE-ConnectionGUID: AsDHbvE/QSGrEoaYscOpgw==
X-CSE-MsgGUID: m1yrFukvSRiTewrPJzUkug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="158392715"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jul 2025 21:35:23 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucGL2-000D9R-2n;
	Thu, 17 Jul 2025 04:35:20 +0000
Date: Thu, 17 Jul 2025 12:35:06 +0800
From: kernel test robot <lkp@intel.com>
To: carlos.bilbao@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sforshee@kernel.org, bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from
 counter to jiffies
Message-ID: <202507171204.xrYX6hPj-lkp@intel.com>
References: <20250715205733.50911-1-carlos.bilbao@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715205733.50911-1-carlos.bilbao@kernel.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.16-rc6 next-20250716]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/carlos-bilbao-kernel-org/bonding-Switch-periodic-LACPDU-state-machine-from-counter-to-jiffies/20250716-045912
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250715205733.50911-1-carlos.bilbao%40kernel.org
patch subject: [PATCH] bonding: Switch periodic LACPDU state machine from counter to jiffies
config: i386-randconfig-017-20250717 (https://download.01.org/0day-ci/archive/20250717/202507171204.xrYX6hPj-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171204.xrYX6hPj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171204.xrYX6hPj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/bonding/bond_3ad.c:1484:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1484 |                 default:
         |                 ^
   drivers/net/bonding/bond_3ad.c:1484:3: note: insert 'break;' to avoid fall-through
    1484 |                 default:
         |                 ^
         |                 break; 
   1 warning generated.


vim +1484 drivers/net/bonding/bond_3ad.c

^1da177e4c3f41 Linus Torvalds      2005-04-16  1416  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1417  /**
^1da177e4c3f41 Linus Torvalds      2005-04-16  1418   * ad_periodic_machine - handle a port's periodic state machine
^1da177e4c3f41 Linus Torvalds      2005-04-16  1419   * @port: the port we're looking at
3a755cd8b7c601 Hangbin Liu         2021-08-02  1420   * @bond_params: bond parameters we will use
^1da177e4c3f41 Linus Torvalds      2005-04-16  1421   *
^1da177e4c3f41 Linus Torvalds      2005-04-16  1422   * Turn ntt flag on priodically to perform periodic transmission of lacpdu's.
^1da177e4c3f41 Linus Torvalds      2005-04-16  1423   */
bbef56d861f103 Colin Ian King      2021-09-07  1424  static void ad_periodic_machine(struct port *port, struct bond_params *bond_params)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1425  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1426  	periodic_states_t last_state;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1427  
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1428  	/* keep current state machine state to compare later if it was changed */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1429  	last_state = port->sm_periodic_state;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1430  
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1431  	/* check if port was reinitialized */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1432  	if (((port->sm_vars & AD_PORT_BEGIN) || !(port->sm_vars & AD_PORT_LACP_ENABLED) || !port->is_enabled) ||
3a755cd8b7c601 Hangbin Liu         2021-08-02  1433  	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
bbef56d861f103 Colin Ian King      2021-09-07  1434  	    !bond_params->lacp_active) {
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1435  		port->sm_periodic_state = AD_NO_PERIODIC;
a117d493f00ee2 Carlos Bilbao       2025-07-15  1436  	} else if (port->sm_periodic_state == AD_NO_PERIODIC)
a117d493f00ee2 Carlos Bilbao       2025-07-15  1437  		port->sm_periodic_state = AD_FAST_PERIODIC;
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1438  	/* check if periodic state machine expired */
a117d493f00ee2 Carlos Bilbao       2025-07-15  1439  	else if (time_after_eq(jiffies, port->sm_periodic_next_jiffies)) {
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1440  		/* if expired then do tx */
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1441  		port->sm_periodic_state = AD_PERIODIC_TX;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1442  	} else {
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1443  		/* If not expired, check if there is some new timeout
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1444  		 * parameter from the partner state
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1445  		 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1446  		switch (port->sm_periodic_state) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1447  		case AD_FAST_PERIODIC:
a117d493f00ee2 Carlos Bilbao       2025-07-15  1448  			if (!(port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1449  				port->sm_periodic_state = AD_SLOW_PERIODIC;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1450  			break;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1451  		case AD_SLOW_PERIODIC:
a117d493f00ee2 Carlos Bilbao       2025-07-15  1452  			if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1453  				port->sm_periodic_state = AD_PERIODIC_TX;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1454  			break;
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1455  		default:
^1da177e4c3f41 Linus Torvalds      2005-04-16  1456  			break;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1457  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1458  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1459  
3bf2d28a2d7112 Veaceslav Falico    2014-01-08  1460  	/* check if the state machine was changed */
^1da177e4c3f41 Linus Torvalds      2005-04-16  1461  	if (port->sm_periodic_state != last_state) {
17720981964ac5 Jarod Wilson        2019-06-07  1462  		slave_dbg(port->slave->bond->dev, port->slave->dev,
17720981964ac5 Jarod Wilson        2019-06-07  1463  			  "Periodic Machine: Port=%d, Last State=%d, Curr State=%d\n",
a4aee5c808fc5b Joe Perches         2009-12-13  1464  			  port->actor_port_number, last_state,
a4aee5c808fc5b Joe Perches         2009-12-13  1465  			  port->sm_periodic_state);
a117d493f00ee2 Carlos Bilbao       2025-07-15  1466  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1467  		switch (port->sm_periodic_state) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1468  		case AD_PERIODIC_TX:
d238d458a70ad1 Holger Eitzenberger 2008-12-26  1469  			port->ntt = true;
a117d493f00ee2 Carlos Bilbao       2025-07-15  1470  			if (!(port->partner_oper.port_state &
a117d493f00ee2 Carlos Bilbao       2025-07-15  1471  						LACP_STATE_LACP_TIMEOUT))
a117d493f00ee2 Carlos Bilbao       2025-07-15  1472  				port->sm_periodic_state = AD_SLOW_PERIODIC;
a117d493f00ee2 Carlos Bilbao       2025-07-15  1473  			else
a117d493f00ee2 Carlos Bilbao       2025-07-15  1474  				port->sm_periodic_state = AD_FAST_PERIODIC;
a117d493f00ee2 Carlos Bilbao       2025-07-15  1475  		fallthrough;
a117d493f00ee2 Carlos Bilbao       2025-07-15  1476  		case AD_SLOW_PERIODIC:
a117d493f00ee2 Carlos Bilbao       2025-07-15  1477  		case AD_FAST_PERIODIC:
a117d493f00ee2 Carlos Bilbao       2025-07-15  1478  			if (port->sm_periodic_state == AD_SLOW_PERIODIC)
a117d493f00ee2 Carlos Bilbao       2025-07-15  1479  				port->sm_periodic_next_jiffies = jiffies
a117d493f00ee2 Carlos Bilbao       2025-07-15  1480  					+ HZ * AD_SLOW_PERIODIC_TIME;
a117d493f00ee2 Carlos Bilbao       2025-07-15  1481  			else /* AD_FAST_PERIODIC */
a117d493f00ee2 Carlos Bilbao       2025-07-15  1482  				port->sm_periodic_next_jiffies = jiffies
a117d493f00ee2 Carlos Bilbao       2025-07-15  1483  					+ HZ * AD_FAST_PERIODIC_TIME;
3bf2d28a2d7112 Veaceslav Falico    2014-01-08 @1484  		default:
^1da177e4c3f41 Linus Torvalds      2005-04-16  1485  			break;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1486  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1487  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1488  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  1489  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

