Return-Path: <netdev+bounces-293319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNU9EVaqGmo67AgAu9opvQ
	(envelope-from <netdev+bounces-293319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:13:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 911ED60BCF9
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAD72300D84A
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF6B39A048;
	Sat, 30 May 2026 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCs4gOiE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B311B808;
	Sat, 30 May 2026 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780132432; cv=none; b=hfNc8Cnww3G+zFNLOFTSEDnnN65MmeFvDH5d3lgqtph+cyIZyElRLq8IXx9TG+o6PlOV2SnSp1I6ATA1js7BmO+rS22vPd41KubB8p74VNTcPlD1uDJBqjUWT7SIGyNVlFI8x5hu1MfMkk6lqfRbsYaPTlpcAtaPvsRh2Aorh0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780132432; c=relaxed/simple;
	bh=22tmpD69P1URiswlRoWhBg/BX2jx5Dn1SpOE5c+SaRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5SXsXXMSgap2JAQorn4TIjNqcM7rMZyVCsd6LgdbDiWvm0ZAx5GAkDyf//xV3ePMiQH30TEh+kZg2u7Low5eQN4h3Z+8HyRHcDIuykGpwHTxYyF/HIWQ7wZWAhY/WW7DnJZmVt7I3mw1x2NWTLv3PIgo1WNGlcSIX6MYkPpTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCs4gOiE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780132431; x=1811668431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=22tmpD69P1URiswlRoWhBg/BX2jx5Dn1SpOE5c+SaRw=;
  b=fCs4gOiEebh1evuXFgL9v/wuh8s1Uc5Ih2dCKAvvgb4PQSBuemwOtt2x
   lCJUNc/wgQ6CmLtaoVttRYGa/auyVgHvzD3oBOeFnEADkklKFsbeZFCVh
   1syyu0QlMAYZ8OpLSoS/UcTKHcP3NteogfbOa1itF1fJKJqo13ePxYH8D
   wnIX5ZVwSHNCW8KN4wpg0aSjPnCCa9a+WsCCGSvbGzuQKfccaU/7l6r1f
   p+3ZmMCDpgWmfXv4husiM8iciS6bQFen51q26vnzZWbPQaMBBEOXMYWoZ
   /cxjmmDpknLkdJWnRk3nwpMSgmL2M6qPG2RRHeGyfFFrqOqCvdgdFVfn7
   g==;
X-CSE-ConnectionGUID: A/CFJ1XRTkqinKi613nK+Q==
X-CSE-MsgGUID: T5KaacTqSwi/QtefxhQkew==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80112665"
X-IronPort-AV: E=Sophos;i="6.24,177,1774335600"; 
   d="scan'208";a="80112665"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2026 02:13:51 -0700
X-CSE-ConnectionGUID: mDD6+TLDRNeHEF6Qv2iPgw==
X-CSE-MsgGUID: UrfCGkIIQG23p/OWwKiWPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,177,1774335600"; 
   d="scan'208";a="240528979"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 30 May 2026 02:13:47 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wTFlJ-00000000169-0kTS;
	Sat, 30 May 2026 09:13:45 +0000
Date: Sat, 30 May 2026 11:13:18 +0200
From: kernel test robot <lkp@intel.com>
To: Neil Spring <ntspring@meta.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ntspring@meta.com,
	bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Subject: Re: [PATCH net-next v10 2/2] selftests: net: add local ECMP rehash
 test
Message-ID: <202605301121.q28WSYib-lkp@intel.com>
References: <20260529160136.1010064-3-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529160136.1010064-3-ntspring@meta.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293319-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 911ED60BCF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Neil,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Spring/tcp-rehash-onto-different-local-ECMP-path-on-retransmit-timeout/20260530-005334
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260529160136.1010064-3-ntspring%40meta.com
patch subject: [PATCH net-next v10 2/2] selftests: net: add local ECMP rehash test
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260530/202605301121.q28WSYib-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260530/202605301121.q28WSYib-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605301121.q28WSYib-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/slip/slhc.c:74:
>> include/net/tcp.h:2557:2: error: call to undeclared function 'tcp_synq_overflow'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2557 |         tcp_synq_overflow(sk);
         |         ^
   1 error generated.
--
   In file included from drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:48:
>> include/net/tcp.h:2557:2: error: call to undeclared function 'tcp_synq_overflow'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2557 |         tcp_synq_overflow(sk);
         |         ^
   drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:15197:26: warning: shift count >= width of type [-Wshift-count-overflow]
    15197 |         bp->cyclecounter.mask = CYCLECOUNTER_MASK(64);
          |                                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/timecounter.h:14:59: note: expanded from macro 'CYCLECOUNTER_MASK'
      14 | #define CYCLECOUNTER_MASK(bits) (u64)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)
         |                                                           ^ ~~~~~~
   1 warning and 1 error generated.


vim +/tcp_synq_overflow +2557 include/net/tcp.h

  2554	
  2555	static inline void cookie_record_sent(const struct sock *sk)
  2556	{
> 2557		tcp_synq_overflow(sk);
  2558		__NET_INC_STATS(sock_net(sk), LINUX_MIB_SYNCOOKIESSENT);
  2559	}
  2560	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

