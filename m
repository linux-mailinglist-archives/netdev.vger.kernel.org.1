Return-Path: <netdev+bounces-273719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHP9IAwMzGnGNgYAu9opvQ
	(envelope-from <netdev+bounces-273719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:01:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA536FA0B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5DC5307E13F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8C43DA2B;
	Tue, 31 Mar 2026 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUdn4dA2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B943DA27;
	Tue, 31 Mar 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978976; cv=none; b=nNGu8rcA2YHsQGTZNfz+lyYcimUd0nwX87CcE5Ew53yl9kD4KUg5MvYmE/PvZllyu65MPp9q/rV5tKxEl16dY2iinOmYy1YIlCdNxVeXjfzPD0pgo7Z1W7sDGRt7MKKHDrQ46/7qraZHuySSEBJ7dijOQ7ip0uqFFn47cO+FaMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978976; c=relaxed/simple;
	bh=mZdGS/f/SYcwOsCwtcdESkfbxrPbR4QFcGm1edkc4tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfPxALIjJDIf61ohvxURUHYSO+l7cVlrftKYdnGEqNCEzgocWoEK+gvaTHDkQUG5Q7ZaEozYWwHpv0zRKLnFvlI1TW5Z36T7UAD/f3shMLzRjqT32SkVDa4qn0KPizy+B7BBB3MjuFJc0xtx+mcGVg0D6OGlEtJtVOE0ERBc0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUdn4dA2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774978972; x=1806514972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mZdGS/f/SYcwOsCwtcdESkfbxrPbR4QFcGm1edkc4tU=;
  b=HUdn4dA2sGl+Cyaf1IaGExkMgCUSb2UIMTxMEJk9SFo4BD5PvQphwb/7
   Rx4KJuXppSnrTJ9lCB+kA/PFevyGzNAtkCYv72fyoIP4osTRGvnfF6Sa6
   m4uF6+TY3JvCBgW91DsvBVKLell2x4eGN2Y4lILXLtB2WgjoWi642fmJt
   tXKsuXfHRL3kkb0nwhzOJhq+cFHM5tq1dwhbAw9LFtHJK6ynGArY69hst
   C9sevywvzMVYJE7zGmyvreDfHqqpej+PCsJuBib0MDJU2jPbm1RQ0vupq
   YXtgf3gSPomBxCio9aNYMikKnuPOJVb7LM3cmje6qM7GgQjEu0GgrIDrj
   A==;
X-CSE-ConnectionGUID: /4C31g3kTUGipVZoV6Vb8g==
X-CSE-MsgGUID: aE1f1oClTCW0d9gnzSHKyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75036939"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75036939"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 10:42:50 -0700
X-CSE-ConnectionGUID: 7D66jnOeQLi8AwqnmGuPNw==
X-CSE-MsgGUID: kodmoxfISR25nyrOLuD2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="249645584"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 31 Mar 2026 10:42:48 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7d6z-000000008Sr-3DXx;
	Tue, 31 Mar 2026 17:42:45 +0000
Date: Tue, 31 Mar 2026 19:42:42 +0200
From: kernel test robot <lkp@intel.com>
To: Jordan Rife <jrife@google.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jordan Rife <jrife@google.com>,
	bpf@vger.kernel.org,
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
Message-ID: <202603311954.k4BkWpJN-lkp@intel.com>
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
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	TAGGED_FROM(0.00)[bounces-273719-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 7CBA536FA0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jordan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rife/udp-Only-compare-daddr-dport-when-sk_state-TCP_ESTABLISHED/20260331-082300
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260330215707.2374657-3-jrife%40google.com
patch subject: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from the 4-tuple hash
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260331/202603311954.k4BkWpJN-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603311954.k4BkWpJN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603311954.k4BkWpJN-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/udp.c: In function 'udp_disconnect_unhash4':
>> net/ipv4/udp.c:2182:38: error: implicit declaration of function 'udp_get_table_prot'; did you mean 'vm_get_page_prot'? [-Wimplicit-function-declaration]
    2182 |         struct udp_table *udptable = udp_get_table_prot(sk);
         |                                      ^~~~~~~~~~~~~~~~~~
         |                                      vm_get_page_prot
>> net/ipv4/udp.c:2182:38: error: initialization of 'struct udp_table *' from 'int' makes pointer from integer without a cast [-Wint-conversion]


vim +2182 net/ipv4/udp.c

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

