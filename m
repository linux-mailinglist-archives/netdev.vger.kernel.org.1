Return-Path: <netdev+bounces-273710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M9sIOIEzGm4NQYAu9opvQ
	(envelope-from <netdev+bounces-273710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:31:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50F36EDAF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 688C0314CB6A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72925426D3F;
	Tue, 31 Mar 2026 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4AZlpVN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A0426D20;
	Tue, 31 Mar 2026 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975972; cv=none; b=bO48wH9/IwxI/IvDs9veF12o3hYtN+4Y6F9uLjOpo96YlVXW0T8Jn3yB2YZl4j8pJFONNLdN1qFwS5gUJqz7jz7buFRz0rM+57sSdadufeJ4EvmAQw3SKAomS8GPwkJKhw0yVzzXTB1Ksq+v+LX8heKOQ0z5pP34xLh4nvvsG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975972; c=relaxed/simple;
	bh=Lfkw22piQF1Hnab39FNJQNBXwCljMCpCQxPx6A77SCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UspMfp0SHQ7fT+k7tEhHgZYQ4YmzJ/Hwu603MCquCWqJgXe88I7aaFegQaYOpVY1VyHKKk6PO3AZTtA+lk64Tw3EBngPIsdvFZ0LOQik1aCeCIwrqEmYxWqTG5RD897FhBwWhKHKaYFDbCb8kbOLbra+KivjsUpFJBnepqAKDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4AZlpVN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774975971; x=1806511971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lfkw22piQF1Hnab39FNJQNBXwCljMCpCQxPx6A77SCo=;
  b=X4AZlpVNWWEAMWpb8hPKHQ9n1/Xn4xhzARuhzxyqTBO2IH0Pdq26JOAy
   23Iv56tok36Hzak2WC7PiD8WZnjK+8d1Lm1CP52OcDscpurMtqBtJlGMC
   w1s2OqME/lu6E9tWSq9Md1Vmo2FhyjGwVh08hKnydlTyVSZlITHfP6cXE
   YafgvteVsh4TOfwatUoU2LYZAEus8DC/NBDw8cl4G1m3MEKpL8k2p87fE
   /oHdq0lL09/kK/rf3fKr4U++S6yNZH8RlTFdTkOhnKj/naDjev6IUXHVw
   6qGOELv6g5OlJ1xu0rIe0JpnsGKNbJJAs4p2vFmFWd37ogDht0k0QC9U+
   A==;
X-CSE-ConnectionGUID: ukq2CRnSTay4pUpuHlBsog==
X-CSE-MsgGUID: nU0uPXOERPGuff0qYuiDcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76011992"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="76011992"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 09:52:50 -0700
X-CSE-ConnectionGUID: wmrsDVQhSdaqqR9AcLAxQw==
X-CSE-MsgGUID: Q6H8HRIDSP+9SoiiVpzixw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230863703"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 31 Mar 2026 09:52:46 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7cKb-000000008SD-12F6;
	Tue, 31 Mar 2026 16:52:45 +0000
Date: Tue, 31 Mar 2026 18:51:52 +0200
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
Message-ID: <202603311827.nefybt0I-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	TAGGED_FROM(0.00)[bounces-273710-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: AD50F36EDAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jordan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rife/udp-Only-compare-daddr-dport-when-sk_state-TCP_ESTABLISHED/20260331-082300
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260330215707.2374657-3-jrife%40google.com
patch subject: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from the 4-tuple hash
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260331/202603311827.nefybt0I-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603311827.nefybt0I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603311827.nefybt0I-lkp@intel.com/

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

