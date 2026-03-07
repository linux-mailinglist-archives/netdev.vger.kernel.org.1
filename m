Return-Path: <netdev+bounces-265141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLyxBN4drGkRlAEAu9opvQ
	(envelope-from <netdev+bounces-265141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 13:45:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9D22BBDE
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 13:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 987ED3008303
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C973F392C46;
	Sat,  7 Mar 2026 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gePsTJQf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97C34BA53
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772887514; cv=none; b=BE22wQ4Gmgd9i/R0o93kwnmMSGnZB+sJhl7Wl2jkNYPJtSH56A8cLEzDfSp75N3JRSsoXqCeWZs3wMLL+myHE2r401OXO0yAl4TlLi/xRMrLU6bjD2A8eS64Zp+mNmfokLMbCWqF6UStzqlObh3gGjzMfJt3S0u4cbSamh0lwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772887514; c=relaxed/simple;
	bh=cVLLyXB9vg75HttolN/DpKVa2tDWJ/km/qpiCJZiY4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8p6iuUvSF76IPazxpF7hHd7Liqjamwcm+P0svBnSgRsM8ttaXso7rf5POjbid4amG7b5CpNEY8FaHEbagymZZgOth4+EN1U8xsMWObWiPJLnv+Fi4QHNr3is9qNigSKGTGSaeZH6KJTBM5lhbBAL5CYRxgw3azsUSyGoBmUjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gePsTJQf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772887512; x=1804423512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cVLLyXB9vg75HttolN/DpKVa2tDWJ/km/qpiCJZiY4A=;
  b=gePsTJQfdg3zY0FRMQDLmgEBiA5ESdC9qs+RIX9pcHkxL/7QK8NIYH+v
   9ZsatJ+lGreiEPgkp0LoiiPONin6/t9f5cNnP9UrT7967gglAQgSIknJs
   5B/OuasLK14Qk0zBu8JqGZ8jtvJRY18WHlSVPVwV6eRwp03eJz070nyYK
   cCBqxRs0qFL8ALkK/7gsCFBjGVQJx6XL4/8+IXoOlqX73+67Jyh9+xigA
   NPPIZTcEcl7UGOcH2PTZEbIw+vm1xhBDuDOXpn2oJx5BntZFjBu/UQeBX
   EiPuFYGsuloEpRsRDItgOMhGvCcxVTZSP6Vfy7uz7J/EPvK53nzpTtXML
   w==;
X-CSE-ConnectionGUID: CbJNT5njQJmYi5x96FmZlg==
X-CSE-MsgGUID: ZBcmSAqqQqSabLO08406sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="99449775"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="99449775"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 04:45:12 -0800
X-CSE-ConnectionGUID: xdG1BgUvSL2QGH/mU7NYzA==
X-CSE-MsgGUID: nJ1zVpPXQWSxDUl+P2cadg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; 
   d="scan'208";a="242289603"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 07 Mar 2026 04:45:09 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyr1n-000000002UD-0WUM;
	Sat, 07 Mar 2026 12:45:07 +0000
Date: Sat, 7 Mar 2026 13:44:28 +0100
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
Message-ID: <202603071301.jcZkyoAP-lkp@intel.com>
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
X-Rspamd-Queue-Id: ACA9D22BBDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,kernel.org,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265141-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/ipv6-Remove-permanent-routes-from-tb6_gc_hlist-when-all-exceptions-expire/20260307-104803
base:   net/main
patch link:    https://lore.kernel.org/r/20260307024709.718395-3-kuniyu%40google.com
patch subject: [PATCH v1 net 2/2] ipv6: Don't remove permanent routes with exceptions from tb6_gc_hlist.
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260307/202603071301.jcZkyoAP-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603071301.jcZkyoAP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603071301.jcZkyoAP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/cxgbi/libcxgbi.c:28:
   In file included from include/net/ip6_route.h:7:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:667:10: note: expanded from macro '__native_word'
     667 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/libcxgbi.c:28:
   In file included from include/net/ip6_route.h:7:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:667:39: note: expanded from macro '__native_word'
     667 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/libcxgbi.c:28:
   In file included from include/net/ip6_route.h:7:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:668:10: note: expanded from macro '__native_word'
     668 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/libcxgbi.c:28:
   In file included from include/net/ip6_route.h:7:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:668:38: note: expanded from macro '__native_word'
     668 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/libcxgbi.c:28:
   In file included from include/net/ip6_route.h:7:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:48: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                                       ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/libcxgbi.c:28:
   In file included from include/net/ip6_route.h:7:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:642:53: note: expanded from macro '__unqual_scalar_typeof'
     642 | #define __unqual_scalar_typeof(x) __typeof_unqual__(x)
         |                                                     ^
   In file included from drivers/scsi/cxgbi/libcxgbi.c:28:
   In file included from include/net/ip6_route.h:7:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   7 errors generated.
--
   In file included from drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:667:10: note: expanded from macro '__native_word'
     667 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:667:39: note: expanded from macro '__native_word'
     667 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:668:10: note: expanded from macro '__native_word'
     668 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:668:38: note: expanded from macro '__native_word'
     668 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:48: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                                       ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:642:53: note: expanded from macro '__unqual_scalar_typeof'
     642 | #define __unqual_scalar_typeof(x) __typeof_unqual__(x)
         |                                                     ^
   In file included from drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:995:44: warning: variable 'size6' set but not used [-Wunused-but-set-variable]
     995 |         int t4 = is_t4(lldi->adapter_type), size, size6;
         |                                                   ^
   drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:1776:21: warning: variable 'size6' set but not used [-Wunused-but-set-variable]
    1776 |         unsigned int size, size6;
         |                            ^
   2 warnings and 7 errors generated.
--
   In file included from cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:667:10: note: expanded from macro '__native_word'
     667 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:667:39: note: expanded from macro '__native_word'
     667 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:668:10: note: expanded from macro '__native_word'
     668 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                          ^
   include/linux/compiler_types.h:668:38: note: expanded from macro '__native_word'
     668 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:49:33: note: expanded from macro 'READ_ONCE'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |                                        ^
   include/asm-generic/rwonce.h:36:48: note: expanded from macro 'compiletime_assert_rwonce_type'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                                                       ^
   include/linux/compiler_types.h:706:22: note: expanded from macro 'compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:694:23: note: expanded from macro '_compiletime_assert'
     694 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:686:9: note: expanded from macro '__compiletime_assert'
     686 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   In file included from cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:65: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                  ^
   include/linux/compiler_types.h:642:53: note: expanded from macro '__unqual_scalar_typeof'
     642 | #define __unqual_scalar_typeof(x) __typeof_unqual__(x)
         |                                                     ^
   In file included from cxgb4i/cxgb4i.c:20:
   In file included from include/net/tcp.h:45:
   In file included from include/net/xfrm.h:26:
>> include/net/ip6_fib.h:557:35: error: no member named 'ipv6' in 'struct net'
     557 |         gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
         |                                     ~~~  ^
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   cxgb4i/cxgb4i.c:995:44: warning: variable 'size6' set but not used [-Wunused-but-set-variable]
     995 |         int t4 = is_t4(lldi->adapter_type), size, size6;
         |                                                   ^
   cxgb4i/cxgb4i.c:1776:21: warning: variable 'size6' set but not used [-Wunused-but-set-variable]
    1776 |         unsigned int size, size6;
         |                            ^
   2 warnings and 7 errors generated.


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

