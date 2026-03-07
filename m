Return-Path: <netdev+bounces-265144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODo2L1UqrGmfmAEAu9opvQ
	(envelope-from <netdev+bounces-265144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 14:38:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FD522BFCF
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 14:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910A6300FECD
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8D2D780E;
	Sat,  7 Mar 2026 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vl8qJ/lr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88842D5A19
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772890703; cv=none; b=YE98sA5e56BERNpbjpcRMVR82JWw09uB7kzlAZ1U3nFTXtFwdSNsvDbqaQvfkD9KT+Y0Y9pYYFOD83diGxQts+arxOJhrAu/nPyqmTcNO0rnomTGw+nRbU83w/z0BMuefceJos2T3PBxQp51lNnFLisCk8A238F3PYLAAp8p5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772890703; c=relaxed/simple;
	bh=PqbtgbG+t3VigQKYJJfr6c/17wbVG9irva+I3YjSaAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o02Ff0YM4hcSCcYSZ0V9+iFK439QmFVIE9m0F7y38KfBSSy+WwQ1MirDR0/fq4ZyMx4/DkIFAp2Thh5aSiL3A2zZHdaHnEp0BHryjRkuJtpUyF41uStfoTLsmMmdg8+vCkB8A9iPUSvcVAz5sSv3Fq443sbKayLyGR7SFmc6MsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vl8qJ/lr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772890702; x=1804426702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PqbtgbG+t3VigQKYJJfr6c/17wbVG9irva+I3YjSaAo=;
  b=Vl8qJ/lrYJuBuzODcs0wm3G8U22iTgGPXknf/s7hMtQ9bYKkWR2ZwtmA
   NW24l2ab5tlozGFW5F+fxL7642G7Z/xs0m62GqtxxxgoKoG8GU1EEVrfc
   CgzzFW648PBDM5fcHLX1s2MuXPUdHMYTY8GCrVp5C6I0Vr3ThH6VcHdrL
   ofP8sicVwNwWV4zL+rDqceslCrSXGKXpfq+kophm1dga8GoG5kROmgDbv
   VTL5PaYFq7DGuCYrMMSes5F15Pd6XWQ4K44pENw9f7D1PHEgacGAwHeqI
   pmH1FLWrl37RdcAjcMgZDCMrQcXAvWgWcCYabdwVmR1V3Sf6BdBiuHk0x
   w==;
X-CSE-ConnectionGUID: ZcjqnyVCTLmn3iFS47/EAA==
X-CSE-MsgGUID: IO8+8W/VQ0GZEnPenbuKTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="91554259"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="91554259"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 05:38:21 -0800
X-CSE-ConnectionGUID: bhKrMhpsQeueIQEugd8exw==
X-CSE-MsgGUID: /Hgor2FcR1ag+M7FQyfU8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="218432650"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Mar 2026 05:38:18 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyrrC-0000000021t-1H55;
	Sat, 07 Mar 2026 13:38:14 +0000
Date: Sat, 7 Mar 2026 21:37:27 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
Message-ID: <202603072124.nNhJgNnw-lkp@intel.com>
References: <20260307024709.718395-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307024709.718395-3-kuniyu@google.com>
X-Rspamd-Queue-Id: 16FD522BFCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,kernel.org,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265144-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/ipv6-Remove-permanent-routes-from-tb6_gc_hlist-when-all-exceptions-expire/20260307-104803
base:   net/main
patch link:    https://lore.kernel.org/r/20260307024709.718395-3-kuniyu%40google.com
patch subject: [PATCH v1 net 2/2] ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
config: powerpc-currituck_defconfig (https://download.01.org/0day-ci/archive/20260307/202603072124.nNhJgNnw-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project c32caeec8158d634bb71ab8911a6031248b9fc47)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603072124.nNhJgNnw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603072124.nNhJgNnw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/sock.c:133:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   7 errors generated.


vim +557 include/net/ip6_fib.h

   548	
   549	static inline void fib6_may_remove_gc_list(struct net *net,
   550						   struct fib6_info *f6i)
   551	{
   552		struct fib6_gc_args gc_args;
   553	
   554		if (hlist_unhashed(&f6i->gc_link))
   555			return;
   556	
 > 557		gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
   558		gc_args.more = 0,
   559	
   560		fib6_age_exceptions(f6i, &gc_args, jiffies);
   561	}
   562	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

