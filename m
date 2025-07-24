Return-Path: <netdev+bounces-209742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A7CB10ADB
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27968168184
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853EF248864;
	Thu, 24 Jul 2025 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWV9ECM9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DEA24113C
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362209; cv=none; b=a0AxS7su4QG922S7sD4AO+W+ZmlkgFiV6Lgx3Fudd5XYwBRF42LfHqOLCjHck/IAzmuUKreJw85FbidUbPhv4i3qDBrDyRRYOdBYmvyoH2hdlFNecXfWlXLWPqH7Sq1dGVZnz04FTKVuY24FxOayCdMoEPXObjJeDVmcntzyZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362209; c=relaxed/simple;
	bh=Z9yx0Znel3PZgr0veP+u6wAz+0Rq+E1+JLEXc+hdjsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbNSWQKPdycdQAR8BiDGMEGSdXF66hzHOYL3Fs8sb2apZphTATSqzreZL1/po1bIyabuwsBr+98liYAvEkKpNUq2tP8z/QeL94aIKrSXs+NV1wkJGQmRg75ojM5Dv70AWq35O4V8tjd2ovfDVXPJEk9653vKc8SgsDZF5bTwNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWV9ECM9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753362207; x=1784898207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z9yx0Znel3PZgr0veP+u6wAz+0Rq+E1+JLEXc+hdjsc=;
  b=bWV9ECM9Ur5xB89dQzRFEwJ/PacL+ilxmHNnik/gCgzTeMbZL6WGUeBp
   q6PFNI5N7bivNBMGPKX7cV0DG7nOIKDAIvbRBpJExTVKlf14Kptye0Qzp
   2Ee/abuGzFxmEDkd40dLab2zxPbNlASqcpQ9FUoT3pBQuU5i2T88OOpiN
   Xl4xxJsYmzbaf1VbLhPhZm1S+rzcV1bJEy8AXyLPLgTjvWGQb5at03r3y
   uZOORBtn3RP3BHjGY6pPCGkhKY00gRWhjWLvHB4gxFdPSQdCzKolawpQh
   kx+7oKV3+Nakwyx+coaZt9jgCorWufXt5zTm7gADRTXBkGaSdhN3XcMG3
   Q==;
X-CSE-ConnectionGUID: FgWUIOz+S1OyoIp3p8/yqw==
X-CSE-MsgGUID: 5jvRY66CROGHVZurRC5nHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55524712"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55524712"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 06:03:26 -0700
X-CSE-ConnectionGUID: qpFF78SRRAqtYYzAokPyjA==
X-CSE-MsgGUID: ARtbnSpRRXOw8IE+ng+FtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160515373"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Jul 2025 06:03:24 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uevbW-000KS7-08;
	Thu, 24 Jul 2025 13:03:22 +0000
Date: Thu, 24 Jul 2025 21:02:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Kees Cook <kees@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 3/6 net-next] net: Convert proto_ops bind() callbacks to
 use sockaddr_unspec
Message-ID: <202507242032.e0sbPWI4-lkp@intel.com>
References: <20250723231921.2293685-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723231921.2293685-3-kees@kernel.org>

Hi Kees,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250723]
[also build test ERROR on v6.16-rc7]
[cannot apply to net-next/main bluetooth-next/master bluetooth/master brauner-vfs/vfs.all mkl-can-next/testing mptcp/export mptcp/export-net trondmy-nfs/linux-next linus/master v6.16-rc7 v6.16-rc6 v6.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/net-uapi-Add-__kernel_sockaddr_unspec-for-sockaddr-of-unknown-length/20250724-072218
base:   next-20250723
patch link:    https://lore.kernel.org/r/20250723231921.2293685-3-kees%40kernel.org
patch subject: [PATCH 3/6 net-next] net: Convert proto_ops bind() callbacks to use sockaddr_unspec
config: x86_64-buildonly-randconfig-003-20250724 (https://download.01.org/0day-ci/archive/20250724/202507242032.e0sbPWI4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507242032.e0sbPWI4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507242032.e0sbPWI4-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/packet/af_packet.c: In function 'packet_bind_spkt':
>> net/packet/af_packet.c:3340:33: error: 'struct __kernel_sockaddr_unspec' has no member named 'sa_data_min'; did you mean 'sa_data'?
    3340 |         char name[sizeof(uaddr->sa_data_min) + 1];
         |                                 ^~~~~~~~~~~
         |                                 sa_data
   net/packet/af_packet.c:3351:52: error: 'struct __kernel_sockaddr_unspec' has no member named 'sa_data_min'; did you mean 'sa_data'?
    3351 |         memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data_min));
         |                                                    ^~~~~~~~~~~
         |                                                    sa_data
   net/packet/af_packet.c:3352:28: error: 'struct __kernel_sockaddr_unspec' has no member named 'sa_data_min'; did you mean 'sa_data'?
    3352 |         name[sizeof(uaddr->sa_data_min)] = 0;
         |                            ^~~~~~~~~~~
         |                            sa_data
   net/packet/af_packet.c:3340:14: warning: unused variable 'name' [-Wunused-variable]
    3340 |         char name[sizeof(uaddr->sa_data_min) + 1];
         |              ^~~~
   net/packet/af_packet.c:3355:1: warning: control reaches end of non-void function [-Wreturn-type]
    3355 | }
         | ^


vim +3340 net/packet/af_packet.c

^1da177e4c3f41 Linus Torvalds      2005-04-16  3331  
^1da177e4c3f41 Linus Torvalds      2005-04-16  3332  /*
^1da177e4c3f41 Linus Torvalds      2005-04-16  3333   *	Bind a packet socket to a device
^1da177e4c3f41 Linus Torvalds      2005-04-16  3334   */
^1da177e4c3f41 Linus Torvalds      2005-04-16  3335  
40570133fbb3ba Kees Cook           2025-07-23  3336  static int packet_bind_spkt(struct socket *sock, struct sockaddr_unspec *uaddr,
40d4e3dfc2f56a Eric Dumazet        2009-07-21  3337  			    int addr_len)
^1da177e4c3f41 Linus Torvalds      2005-04-16  3338  {
^1da177e4c3f41 Linus Torvalds      2005-04-16  3339  	struct sock *sk = sock->sk;
b5f0de6df6dce8 Kees Cook           2022-10-18 @3340  	char name[sizeof(uaddr->sa_data_min) + 1];
^1da177e4c3f41 Linus Torvalds      2005-04-16  3341  
^1da177e4c3f41 Linus Torvalds      2005-04-16  3342  	/*
^1da177e4c3f41 Linus Torvalds      2005-04-16  3343  	 *	Check legality
^1da177e4c3f41 Linus Torvalds      2005-04-16  3344  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  3345  
^1da177e4c3f41 Linus Torvalds      2005-04-16  3346  	if (addr_len != sizeof(struct sockaddr))
^1da177e4c3f41 Linus Torvalds      2005-04-16  3347  		return -EINVAL;
540e2894f79055 Alexander Potapenko 2017-03-01  3348  	/* uaddr->sa_data comes from the userspace, it's not guaranteed to be
540e2894f79055 Alexander Potapenko 2017-03-01  3349  	 * zero-terminated.
540e2894f79055 Alexander Potapenko 2017-03-01  3350  	 */
b5f0de6df6dce8 Kees Cook           2022-10-18  3351  	memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data_min));
b5f0de6df6dce8 Kees Cook           2022-10-18  3352  	name[sizeof(uaddr->sa_data_min)] = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  3353  
6ffc57ea004234 Eric Dumazet        2023-05-26  3354  	return packet_do_bind(sk, name, 0, 0);
^1da177e4c3f41 Linus Torvalds      2005-04-16  3355  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  3356  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

