Return-Path: <netdev+bounces-197755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42264AD9C37
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 12:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA013B9E9D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9706E22F774;
	Sat, 14 Jun 2025 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fg5k5+m+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016251F30BB
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749897874; cv=none; b=s5DagPTEoIoyhHqj2XCJ5apctzPybFgI8qC1cAuO1ASTgNWQ0NWALAh96Z+5jQ1uk9rJcjZSZHo4zaiHJcp5OwpLhnra7IPOah6myibIPxDrUMWORLgbbd0pVMrdZT98rAh7u3+OrUPtowboGM/sC9ZUCgR8fRFAaVy9D8d0r5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749897874; c=relaxed/simple;
	bh=xeIs7XHD5JO+zs4tJNJpqL3nFDdUzb/RuvGcgio0oHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZzNyL0yEP8scX7P6gcO1uO5CYmMrVVr6PLACUT3B1z/xaCkpp9fC9v0hJN7VTGeM2ifV5sAqWEr5UU+edzGrrHAzg1EQh+jWOqpmmaB2PTDNenw22YgQBY+G4jYTLzivPHpt9vRPITMZ6c6D9x1Uw9XLTTwXdM8cF19kZ4yAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fg5k5+m+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749897873; x=1781433873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xeIs7XHD5JO+zs4tJNJpqL3nFDdUzb/RuvGcgio0oHw=;
  b=Fg5k5+m++Ze3dk//cImlkpx0u3iba6vy7YgP4WT2qmpS6ECERm2anoFl
   nuJXF/gVSqal6QZXUYLQkYJpgFRzxalDJhb8QvwinCeQX4SymdpQTzAz3
   F2HvLGge3SwFZMhLh/8u1giIEIcDV4sxUdre78sAtKu30lUKJBKbECTU/
   ER8nxrbbBWORR3pQ9oq99I1bPHGURt8jlJ7wIZgC/uiDI8vl0BtpuVV1z
   RAlkpQJv1fC3451Isp4lZIni9uRMjmXoA5yD7BtwTOdyfHlbzJz4r23bs
   A9ByatcTiFgX2GGF7sCJfKCxQcWJeKV0vaDLQZtykjefbFBxVp1pdfPK+
   w==;
X-CSE-ConnectionGUID: nnheye0ZRPGGWZ4OUU/ODg==
X-CSE-MsgGUID: ZmgREhRcS2G2P1RBBOuAFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="62755769"
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="62755769"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2025 03:44:32 -0700
X-CSE-ConnectionGUID: 5XooLxEFRSCG+h28fYmEGw==
X-CSE-MsgGUID: DF9SiP9gQeSVatZystItVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,236,1744095600"; 
   d="scan'208";a="148418494"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Jun 2025 03:44:25 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQON5-000DSQ-1r;
	Sat, 14 Jun 2025 10:44:23 +0000
Date: Sat, 14 Jun 2025 18:43:54 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, skalluru@marvell.com,
	manishc@marvell.com, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, tariqt@nvidia.com, saeedm@nvidia.com,
	louis.peens@corigine.com, shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com,
	horms@kernel.org, dsahern@kernel.org, shuah@kernel.org,
	tglx@linutronix.de, mingo@kernel.org, ruanjinjie@huawei.com,
	idosch@nvidia.com, razor@blackwall.org, petrm@nvidia.com
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 2/6] vxlan: drop sock_lock
Message-ID: <202506141822.kFKjPah5-lkp@intel.com>
References: <20250613203325.1127217-3-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613203325.1127217-3-stfomichev@gmail.com>

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/geneve-rely-on-rtnl-lock-in-geneve_offload_rx_ports/20250614-043457
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250613203325.1127217-3-stfomichev%40gmail.com
patch subject: [Intel-wired-lan] [PATCH net-next v4 2/6] vxlan: drop sock_lock
config: m68k-atari_defconfig (https://download.01.org/0day-ci/archive/20250614/202506141822.kFKjPah5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250614/202506141822.kFKjPah5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506141822.kFKjPah5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/vxlan/vxlan_core.c: In function '__vxlan_sock_release_prep':
>> drivers/net/vxlan/vxlan_core.c:1488:27: warning: variable 'vn' set but not used [-Wunused-but-set-variable]
    1488 |         struct vxlan_net *vn;
         |                           ^~


vim +/vn +1488 drivers/net/vxlan/vxlan_core.c

d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger    2012-10-01  1485  
544a773a01828e drivers/net/vxlan.c            Hannes Frederic Sowa 2016-04-09  1486  static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
7c47cedf43a8b3 drivers/net/vxlan.c            Stephen Hemminger    2013-06-17  1487  {
b1be00a6c39fda drivers/net/vxlan.c            Jiri Benc            2015-09-24 @1488  	struct vxlan_net *vn;
012a5729ff933e drivers/net/vxlan.c            Pravin B Shelar      2013-08-19  1489  
dc248376cdc061 drivers/net/vxlan/vxlan_core.c Stanislav Fomichev   2025-06-13  1490  	ASSERT_RTNL();
dc248376cdc061 drivers/net/vxlan/vxlan_core.c Stanislav Fomichev   2025-06-13  1491  
b1be00a6c39fda drivers/net/vxlan.c            Jiri Benc            2015-09-24  1492  	if (!vs)
544a773a01828e drivers/net/vxlan.c            Hannes Frederic Sowa 2016-04-09  1493  		return false;
66af846fe54b78 drivers/net/vxlan.c            Reshetova, Elena     2017-07-04  1494  	if (!refcount_dec_and_test(&vs->refcnt))
544a773a01828e drivers/net/vxlan.c            Hannes Frederic Sowa 2016-04-09  1495  		return false;
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger    2012-10-01  1496  
b1be00a6c39fda drivers/net/vxlan.c            Jiri Benc            2015-09-24  1497  	vn = net_generic(sock_net(vs->sock->sk), vxlan_net_id);
7c47cedf43a8b3 drivers/net/vxlan.c            Stephen Hemminger    2013-06-17  1498  	hlist_del_rcu(&vs->hlist);
e7b3db5e60e8f4 drivers/net/vxlan.c            Alexander Duyck      2016-06-16  1499  	udp_tunnel_notify_del_rx_port(vs->sock,
b9adcd69bd7b41 drivers/net/vxlan.c            Alexander Duyck      2016-06-16  1500  				      (vs->flags & VXLAN_F_GPE) ?
b9adcd69bd7b41 drivers/net/vxlan.c            Alexander Duyck      2016-06-16  1501  				      UDP_TUNNEL_TYPE_VXLAN_GPE :
e7b3db5e60e8f4 drivers/net/vxlan.c            Alexander Duyck      2016-06-16  1502  				      UDP_TUNNEL_TYPE_VXLAN);
1c51a9159ddefa drivers/net/vxlan.c            Stephen Hemminger    2013-06-17  1503  
544a773a01828e drivers/net/vxlan.c            Hannes Frederic Sowa 2016-04-09  1504  	return true;
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger    2012-10-01  1505  }
d342894c5d2f8c drivers/net/vxlan.c            stephen hemminger    2012-10-01  1506  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

