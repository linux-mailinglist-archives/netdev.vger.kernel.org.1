Return-Path: <netdev+bounces-209721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CECB10935
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693D817372A
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B226AA93;
	Thu, 24 Jul 2025 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fb0c2dSU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390027B51C
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356620; cv=none; b=TwkHZIEmGUQhLtytJfLeC8NN0uUwjVhT+bNsL+2mUKPZ/d6YnwRImQTIWoXzmpzjXbmAH/1Lxw3QKT+IuA+N15SWGEtHZAsehfBmaKlBr/qL3L5l50HDYfXF7/jmUriZscVDNKl0H1EU4cH0ESTAAC1FH9Mo1DqGAAwfZNvHQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356620; c=relaxed/simple;
	bh=o2WahqbeZeycX8fjUrJq0tctPz7i6hdWD/3VYlJEH04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/q7xAQMmGbCPN0h3eDgv3VkWbfzbcBkSvqK5Ktl4U2IzKCvb0xQlShrMvHdNuF78u0+iuTZBCGzCRWMLuU3S1PyBRJKQ5R6gMplKY1qAuJpS7Z+IALfGHloqMHrkNt1S1xyx7EvXADB2OIl3Y/hBNUarzOxp7nFhbuEBMCV7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fb0c2dSU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753356619; x=1784892619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o2WahqbeZeycX8fjUrJq0tctPz7i6hdWD/3VYlJEH04=;
  b=Fb0c2dSUimwB/+uF+8fzUnFLkcX9+ORmM2U9vx/pIrpOKMGPo94FWPgo
   Lbpvx7mEK+r+sXrLSm1zc1B2FW20QvMzzUAOx1c8oCFyRpflwEcg7BLTz
   kOLZziKxaciDqCzyQ1ROKLVRltn1AGeMXgf9F2A9U2F2jz+O7ds2Muh99
   sSjvaY0EhxWa+uOKHlNA3zaq0hEtb1Rb8jfsl35gttaUms+UglAWu3EK0
   S7y0nGIxZDcjiZwyj12kJsfBo+oHr3Mb+3WMt3KlAfJtpizrKxk0QRfOm
   JptdtY0/EBFLU1jhjRB2AyPXy8aS60gKEbxUDhG0O0nLUXSVWJQPJVKa/
   Q==;
X-CSE-ConnectionGUID: kPUXYgEQQGKsDrDHlTZ1fQ==
X-CSE-MsgGUID: TJqnvausQOus0AddusBRTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="54881485"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="54881485"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:30:18 -0700
X-CSE-ConnectionGUID: 8fICLahTRj6+dim0JNridA==
X-CSE-MsgGUID: 3ey7wWnfTNCClzSKKptcvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="159446817"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 Jul 2025 04:30:16 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueu9N-000KNf-0z;
	Thu, 24 Jul 2025 11:30:13 +0000
Date: Thu, 24 Jul 2025 19:29:15 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Kees Cook <kees@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 3/6 net-next] net: Convert proto_ops bind() callbacks to
 use sockaddr_unspec
Message-ID: <202507241955.LuEWrXAU-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250723]
[also build test WARNING on v6.16-rc7]
[cannot apply to net-next/main bluetooth-next/master bluetooth/master brauner-vfs/vfs.all mkl-can-next/testing mptcp/export mptcp/export-net trondmy-nfs/linux-next linus/master v6.16-rc7 v6.16-rc6 v6.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/net-uapi-Add-__kernel_sockaddr_unspec-for-sockaddr-of-unknown-length/20250724-072218
base:   next-20250723
patch link:    https://lore.kernel.org/r/20250723231921.2293685-3-kees%40kernel.org
patch subject: [PATCH 3/6 net-next] net: Convert proto_ops bind() callbacks to use sockaddr_unspec
config: x86_64-buildonly-randconfig-003-20250724 (https://download.01.org/0day-ci/archive/20250724/202507241955.LuEWrXAU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507241955.LuEWrXAU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507241955.LuEWrXAU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/packet/af_packet.c: In function 'packet_bind_spkt':
   net/packet/af_packet.c:3340:33: error: 'struct __kernel_sockaddr_unspec' has no member named 'sa_data_min'; did you mean 'sa_data'?
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
>> net/packet/af_packet.c:3340:14: warning: unused variable 'name' [-Wunused-variable]
    3340 |         char name[sizeof(uaddr->sa_data_min) + 1];
         |              ^~~~
>> net/packet/af_packet.c:3355:1: warning: control reaches end of non-void function [-Wreturn-type]
    3355 | }
         | ^


vim +/name +3340 net/packet/af_packet.c

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
^1da177e4c3f41 Linus Torvalds      2005-04-16 @3355  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  3356  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

