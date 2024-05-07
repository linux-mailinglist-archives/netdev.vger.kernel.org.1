Return-Path: <netdev+bounces-94274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3645E8BEF00
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 23:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E148A1F2585B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF97640E;
	Tue,  7 May 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TicnrHpv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB241187348;
	Tue,  7 May 2024 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118295; cv=none; b=FwnrQ/lyY37yXmm0CAIuVTUzdYw77O/md60vuKyxs0uQj6+nVuPAhQ01ayp2vRPLxEC4y2xczVGY8gSzZXuDg6SWgTAZs9a3hEsk9efaY9NvRDLF+Iz2p6WBhi6G1josj3sT12a2b1Wzvw+IGHiZrXkFKRq+ZeTwF87Xyf+cLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118295; c=relaxed/simple;
	bh=8Kks+YQ+RgJfm/5ALrDxQU4SyhuXGSCU5OOJP8icVW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMZrLouHaZPjKGtIoUBGanluPZlBnT3bjx4GKjzHHiXmENeLzPMl+A+Rzp+U23Duj7LACPJ+lkByrOqHjhB+Fhbhb2tkkOHI5xmTfkeOcjMljOIeyBO+b70KsKD30W3r6xa2HiePhUqXhoTq8rhMAgY8m3ert/YtSYia/TYGJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TicnrHpv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715118294; x=1746654294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Kks+YQ+RgJfm/5ALrDxQU4SyhuXGSCU5OOJP8icVW8=;
  b=TicnrHpvrmxHMN3SBzU5VfR/yNG8SNAlkd90V3dwF3t1Kp0r0WkoFpdW
   tA7/eZUFTOlqiq8eIvKc+SxwQASv6O7joPGG8qtiiB5l3dMcoGBmiwmAq
   NExqkcaILMbeDQE7LlW6ahwN+LuMZQD9jvBeqlNeo8pE1FZltN79M647c
   yU08MzMsoR3Ds4+9+0AntIL9HmaC23VePRvq3Kl+y71W6cWDw07A++H0R
   ewedBZHPCgQ678ux7TA3jWgylPpbp1FiGOgARTMgz8wP/ATFJEPJxvCTU
   YzavNXvZLrgtiH3NBIWRG+nSFgKcWaRr39S95R5KCb9wKCiHcK8c6Avh0
   w==;
X-CSE-ConnectionGUID: KptgGozJQQSyvXtFjhrIrg==
X-CSE-MsgGUID: +XB4dEAxTFaQaDUDCt42qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21505746"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="21505746"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 14:44:53 -0700
X-CSE-ConnectionGUID: CbGhnG5XQs2gLcCI/53hZw==
X-CSE-MsgGUID: UNgLkOKIRK6YWhIxhGIM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33185958"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 May 2024 14:44:51 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4ScC-0002fG-1m;
	Tue, 07 May 2024 21:44:48 +0000
Date: Wed, 8 May 2024 05:43:48 +0800
From: kernel test robot <lkp@intel.com>
To: Davide Caratti <dcaratti@redhat.com>, paul@paul-moore.com
Cc: oe-kbuild-all@lists.linux.dev, casey@schaufler-ca.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, xmu@redhat.com
Subject: Re: [PATCH net v3] netlabel: fix RCU annotation for IPv4 options on
 socket creation
Message-ID: <202405080517.oMJNehoP-lkp@intel.com>
References: <ce1a2b59831d74cf8395501f1138923bb842dbce.1714992251.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce1a2b59831d74cf8395501f1138923bb842dbce.1714992251.git.dcaratti@redhat.com>

Hi Davide,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Davide-Caratti/netlabel-fix-RCU-annotation-for-IPv4-options-on-socket-creation/20240506-184702
base:   net/main
patch link:    https://lore.kernel.org/r/ce1a2b59831d74cf8395501f1138923bb842dbce.1714992251.git.dcaratti%40redhat.com
patch subject: [PATCH net v3] netlabel: fix RCU annotation for IPv4 options on socket creation
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240508/202405080517.oMJNehoP-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080517.oMJNehoP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080517.oMJNehoP-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `lockdep_sock_is_held':
>> include/net/sock.h:1665:(.text+0xfe52da): undefined reference to `lockdep_is_held'
>> ld: include/net/sock.h:1666:(.text+0xfe5306): undefined reference to `lockdep_is_held'


vim +1665 include/net/sock.h

ed07536ed67317 Peter Zijlstra       2006-12-06  1662  
05b93801a23c21 Matthew Wilcox       2018-01-17  1663  static inline bool lockdep_sock_is_held(const struct sock *sk)
1e1d04e678cf72 Hannes Frederic Sowa 2016-04-05  1664  {
1e1d04e678cf72 Hannes Frederic Sowa 2016-04-05 @1665  	return lockdep_is_held(&sk->sk_lock) ||
1e1d04e678cf72 Hannes Frederic Sowa 2016-04-05 @1666  	       lockdep_is_held(&sk->sk_lock.slock);
1e1d04e678cf72 Hannes Frederic Sowa 2016-04-05  1667  }
1e1d04e678cf72 Hannes Frederic Sowa 2016-04-05  1668  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

