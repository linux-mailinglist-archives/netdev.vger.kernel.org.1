Return-Path: <netdev+bounces-216134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE3CB322C6
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2391C27E34
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406DE2D0C7A;
	Fri, 22 Aug 2025 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVg8ve+8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86A264A8D;
	Fri, 22 Aug 2025 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890681; cv=none; b=cwYyzdzxQlOaN2uKrrV001XZYN2rvYc/N9Mnd55XWTvOi3ca/BeQG7ijatXLgweUOmPYseyZWq2eIS2TPBqA0SugphxpOSSlGArGbcrzNRaVdmhlmSXQ5TM5Y64OOaKih4DqbBCXg+6jT8yxixJHZsvC/zvx4OJAGGRTvlj6Q5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890681; c=relaxed/simple;
	bh=SdzyWkJAzOO2UlYMiYWy5ai/AEGjR+xAlJX/HhnHj7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFOs2IdtQqO3UfDC8laygHBxk1VR6uKJYpO1vlWhFfryog3hstVSyvynuMZODNaeyfbR/wtVBYq7QHwQjlwRPbaiN9aOceUJH58muIs31NuAdN11biRo6EyyCstyYgemsmVQ8WNk25D0jaFp7Xe1Mx0jdOJ2XB6UeAjlhyE5oPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVg8ve+8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755890678; x=1787426678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SdzyWkJAzOO2UlYMiYWy5ai/AEGjR+xAlJX/HhnHj7k=;
  b=HVg8ve+8abjZsRGbCnwRo4Ux/bWuPb4CuUeEuQBLu8/K8QKyB8qDPCR8
   wMeCAkeJWA+jf3BbEVjos15CD6tuUNnMHWlNCAvECkA8mM/aea2OrEeRv
   WsCFxFD0hAfJYnbc2kvEJRzJ8efsUhzja/hXqVAQY11gUPsM+lX77sZFp
   vVTAROwmEXFf2cEItdqE3FA5DAzsPmvVVRHjNel1bn8pYKAWb9QRvOvTP
   0lZ5MMeFvTYXAIWHgy8nFCQsAFio+JaZ227FssRpszSruluGbjk9SGey0
   fWmz5o7AWbQwugksWkP8RSut/5OykPgzTSOg9/9/cH70tjFsRLY8DIqmL
   g==;
X-CSE-ConnectionGUID: K54HUth/Rx2Wd0VvjL0fXg==
X-CSE-MsgGUID: NPbqyWeiQuyAxnmneA6dSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68799811"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68799811"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 12:24:37 -0700
X-CSE-ConnectionGUID: zPpUW5pKRUWTW/CEPJwoOQ==
X-CSE-MsgGUID: 5v9QTRJAS1K8T3dgUeB/7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="173052733"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 22 Aug 2025 12:24:35 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upXNI-000Lg3-0m;
	Fri, 22 Aug 2025 19:24:32 +0000
Date: Sat, 23 Aug 2025 03:24:08 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Bob Gilligan <gilligan@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in
 .sk_destruct()
Message-ID: <202508230331.PEHBlmSk-lkp@intel.com>
References: <20250822-b4-tcp-ao-md5-rst-finwait2-v1-1-25825d085dcb@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-b4-tcp-ao-md5-rst-finwait2-v1-1-25825d085dcb@arista.com>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a7bd72158063740212344fad5d99dcef45bc70d6]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Safonov-via-B4-Relay/tcp-Destroy-TCP-AO-TCP-MD5-keys-in-sk_destruct/20250822-125815
base:   a7bd72158063740212344fad5d99dcef45bc70d6
patch link:    https://lore.kernel.org/r/20250822-b4-tcp-ao-md5-rst-finwait2-v1-1-25825d085dcb%40arista.com
patch subject: [PATCH net-next 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
config: x86_64-buildonly-randconfig-001-20250823 (https://download.01.org/0day-ci/archive/20250823/202508230331.PEHBlmSk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250823/202508230331.PEHBlmSk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508230331.PEHBlmSk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_destruct_sock':
>> net/ipv4/tcp.c:429:26: warning: unused variable 'tp' [-Wunused-variable]
     429 |         struct tcp_sock *tp = tcp_sk(sk);
         |                          ^~


vim +/tp +429 net/ipv4/tcp.c

   426	
   427	static void tcp_destruct_sock(struct sock *sk)
   428	{
 > 429		struct tcp_sock *tp = tcp_sk(sk);
   430	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

