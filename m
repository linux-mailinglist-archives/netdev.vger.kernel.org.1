Return-Path: <netdev+bounces-256452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7/V5LwJTgmliSQMAu9opvQ
	(envelope-from <netdev+bounces-256452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 20:56:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA59DE4A6
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 20:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75DFC305B961
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158A3366821;
	Tue,  3 Feb 2026 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fHkJp5yV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26DD7261C
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148607; cv=none; b=eu7v8dGoPQw0lwXuXM66TQgUkeHl575/Cud2qAKTwhkLPjE6GV08jt1kh8Tre8NiAlYZ2fgCgj8kLPCB5TM3+2Ce7GpcHnLNEeZ/CoGeSJzITPv/FP7RugavjwF04dJINLCTul5RaarLVAtrVc6+tpwKkup1TLThLK2j4lH6C1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148607; c=relaxed/simple;
	bh=3DAmJvymplUSG8aFnz2n3IcxS57MankGaOrbX7ux0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2TbJSNnAXE1RyBKlfZvJqtEkU4RI5SyqV7OOtwQq7cFv+kYARvxPuLoLjCgm5K8VcP/JgvIULrCaMQlmnQNlGFJKsKmE0B+zKSlpUvy2Q1FjYq/VIKpy88PbZXKECsWyBC+6dTzbOYyy56avGyioDnEMzi8F7Z2/D+hDYa/iEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fHkJp5yV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770148604; x=1801684604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3DAmJvymplUSG8aFnz2n3IcxS57MankGaOrbX7ux0vc=;
  b=fHkJp5yVOG+sFmVixejmOZL/kmGya96CdlISoQzdvCCnAu7u6OhQBjX2
   4GjAsCl6dP0XOPFKw9hLkOnujGKgeuOY/7IT8+B9o1JzTB12vf3/5OFB9
   p4fb8TIzD9lyHaTsyw4JE8kr1Ut8p3+voM2gpSRhxIpWIml9gOsCVxyjh
   lbc6/ifgj4vsQ6+4yZkl2T0x7LNy5gqCxJv1ImuV1NdJ4Hvy0VhwFKSZJ
   g1LaQBGWXw0buMv413lpTI4nkfPh3TtXxhZAPDZ845p99NCM2WKjqH48Y
   X6+Tmz2hR1E2yAd0hoIzMJwnU+KVf9nKlpLBqEA5SxyQ0ZXK4bmAdr8Hk
   g==;
X-CSE-ConnectionGUID: vQj2qbd6RTOcV1ls0WokMQ==
X-CSE-MsgGUID: eCizxXlFQOuSDgnc1UzcxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="58908422"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="58908422"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 11:56:43 -0800
X-CSE-ConnectionGUID: SyQrICe4TtOXIje4E+inhw==
X-CSE-MsgGUID: Se+NOMuwSwOP7HfAbn5Utg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210068125"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 03 Feb 2026 11:56:41 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnMVq-00000000h2S-3VsN;
	Tue, 03 Feb 2026 19:56:38 +0000
Date: Wed, 4 Feb 2026 03:55:58 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/3] tcp: make tcp_v{4,6}_send_check() static
Message-ID: <202602040323.jUZrgY0y-lkp@intel.com>
References: <20260203144053.83193-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203144053.83193-4-edumazet@google.com>
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256452-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: EAA59DE4A6
X-Rspamd-Action: no action

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/tcp-inline-__tcp_v4_send_check/20260203-224938
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260203144053.83193-4-edumazet%40google.com
patch subject: [PATCH net-next 3/3] tcp: make tcp_v{4,6}_send_check() static
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20260204/202602040323.jUZrgY0y-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602040323.jUZrgY0y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602040323.jUZrgY0y-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv4/tcp_output.c:1482:13: warning: 'tcp_v4_send_check' defined but not used [-Wunused-function]
    1482 | static void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
         |             ^~~~~~~~~~~~~~~~~


vim +/tcp_v4_send_check +1482 net/ipv4/tcp_output.c

  1480	
  1481	/* This routine computes an IPv4 TCP checksum. */
> 1482	static void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
  1483	{
  1484		const struct inet_sock *inet = inet_sk(sk);
  1485	
  1486		__tcp_v4_send_check(skb, inet->inet_saddr, inet->inet_daddr);
  1487	}
  1488	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

