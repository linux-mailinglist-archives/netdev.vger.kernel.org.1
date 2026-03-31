Return-Path: <netdev+bounces-273732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAmHD6oXzGkeOQYAu9opvQ
	(envelope-from <netdev+bounces-273732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:51:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6037037A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94FD130086C7
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A93A16AB;
	Tue, 31 Mar 2026 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Psd3Kzgu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC330FF08;
	Tue, 31 Mar 2026 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982983; cv=none; b=MbxwtwJSNuh+lpxAqn4Le10Wv7poy0DSQqP0ApcutdkvGcpRKHEEy5htXgK9XHnBjOb/8t7KNWqDgV1asRZb2G0t24qY7mFKAB/p3auNh59a+DG6Pw23NZ/bBddcaXHLlVO0KTpLfWEyyny3bQajufy9lufeRL2jJ581kDsdWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982983; c=relaxed/simple;
	bh=5SKQoGxZ2Np4n4qJpn+lEqUim0Gn5U2UIHOvwizikpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+poMV27s5lKii2Zp/PUwtnKU6NuvPuFyNTW0YweZi8KylgxFiVRIWSy60za0TuMwOPSsu388eIuBGGq1ztbDIzoiGLiS7zzGmDyWlhIAsZsfTx8vYFkU9UA6AOoqzsoDJOxBGXg7LZANsvqnfQT2SvqG1081DhFkMjl+EQJaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Psd3Kzgu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774982982; x=1806518982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5SKQoGxZ2Np4n4qJpn+lEqUim0Gn5U2UIHOvwizikpo=;
  b=Psd3Kzguv1JYHJ/ESOoaWkshO9ZYANYoubY9CRA2Hql8i6Onp0u/4M98
   uYLFGdQ8C2igHaIz2CYUP1/uPoDUkNXq/ief6LucVZYE9JsT9ErdCg6rZ
   mUI/dcam4BIYfEKAEZ0mNg3Y14nuQMogEYTUnfYenPH9apB8bJuRiYgYh
   R9jD4Lx+fpAK0F1FeDogYoG+ztZy9Ggdg6HK3UZG6ch8J0Y+H0RXRCSWs
   2OMk3Pg1LSPjDuG4MNtDXYOkFYzYVr/GXgwMotOjWiU8N4p7234Eo2cjK
   n3EGG/v5nqTLBS8hHShh2fR+84qOslJXrCkps8GTvdBKArblBMD7byLmc
   w==;
X-CSE-ConnectionGUID: bNedgbGmQeu/eoWnnFZ2ng==
X-CSE-MsgGUID: xANp/byESEqOFjTtlx05ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76122472"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76122472"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 11:49:41 -0700
X-CSE-ConnectionGUID: E6a592iPSS6kQGrB5r9dKw==
X-CSE-MsgGUID: bbo3wJeKT3yDy1GiktAoXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230882169"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Mar 2026 11:49:37 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7e9e-0000000049R-3eTN;
	Tue, 31 Mar 2026 18:49:34 +0000
Date: Wed, 1 Apr 2026 02:49:05 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Rife <jrife@google.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jordan Rife <jrife@google.com>, bpf@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from
 the 4-tuple hash
Message-ID: <202604010240.xuggtnr1-lkp@intel.com>
References: <20260330215707.2374657-3-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330215707.2374657-3-jrife@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	TAGGED_FROM(0.00)[bounces-273732-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: B3A6037037A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jordan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rife/udp-Only-compare-daddr-dport-when-sk_state-TCP_ESTABLISHED/20260331-082300
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260330215707.2374657-3-jrife%40google.com
patch subject: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from the 4-tuple hash
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260401/202604010240.xuggtnr1-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010240.xuggtnr1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010240.xuggtnr1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv4/udp.c:2182:31: error: call to undeclared function 'udp_get_table_prot'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2182 |         struct udp_table *udptable = udp_get_table_prot(sk);
         |                                      ^
   net/ipv4/udp.c:2182:31: note: did you mean 'vm_get_page_prot'?
   include/linux/mm.h:4105:10: note: 'vm_get_page_prot' declared here
    4105 | pgprot_t vm_get_page_prot(vm_flags_t vm_flags);
         |          ^
>> net/ipv4/udp.c:2182:20: error: incompatible integer to pointer conversion initializing 'struct udp_table *' with an expression of type 'int' [-Wint-conversion]
    2182 |         struct udp_table *udptable = udp_get_table_prot(sk);
         |                           ^          ~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/udp_get_table_prot +2182 net/ipv4/udp.c

  2179	
  2180	static int udp_disconnect_unhash4(struct sock *sk, int flags)
  2181	{
> 2182		struct udp_table *udptable = udp_get_table_prot(sk);
  2183	
  2184		udp_unhash4(udptable, sk);
  2185		__udp_disconnect(sk, flags);
  2186	
  2187		return 0;
  2188	}
  2189	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

