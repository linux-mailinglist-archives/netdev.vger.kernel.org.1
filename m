Return-Path: <netdev+bounces-268715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGt+LriiuWmiLQIAu9opvQ
	(envelope-from <netdev+bounces-268715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:51:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E932B1361
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0C14300C323
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4753F660D;
	Tue, 17 Mar 2026 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcWDAlA7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E337C91B
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773494; cv=none; b=Yk4sCQIKpK/u0hUiR3doT7zxJphirW55zoxuXrVIQ5/60g47F7WFZNdS9ZzSO6CgV3A93GeH2fSh090lbgZRlrgUjt8ER3CIi1DxcdT8YxNdXT4BntbE5P6DW+gVXpY+iDvMNrxFql+aurAtiCCNgDRYxQ5b/lcM9BvKUp9y+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773494; c=relaxed/simple;
	bh=Yb2DCeLzNtUt5enlhMNxpE5dFjaCvOsc/ytqk6bDheU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9mX4VaUN0HjYVXANCWt0UIREDszYUcHekK0s61C7JNCsCJNTjucBw4XaDlDf9pmbz/QlarBosUi/Q0Ur3A8prFb1DiACkKeXkRwFiVZKOlTZSgvWJjRWdy9gwpIKDh7PgGf6ipeExofcuhbUr7SXrhtsCM2lcGqLFvJwQ5diMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcWDAlA7; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773773492; x=1805309492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yb2DCeLzNtUt5enlhMNxpE5dFjaCvOsc/ytqk6bDheU=;
  b=ZcWDAlA7TXyfDXWNIur1S3gaSk1PASiUaZ8A3jof0XkQNuEWN6nYdiBq
   /xM7OQR6OZwvxaJGIX8fBMZ+KyH+gXSKVdBoWdryBMv35E7CWKCnnK7Z8
   /IKnV4M89Prwe4NPg2XD/Zy4OIMKIHh2b7gaEkEPua+keh0gZtx4lGxIU
   mPUqz7NoxR0p139/CzQC4hcNpxTHH4f9ETIo1ZkIDROiHTea3kgmMKmS4
   AOmwNdTVLLATTOltZjQJH8cu/kf80fktvl1LENLq6fbdTIWOJfgrUJFG1
   hKwy42VUsQyDpmcH0pcMqFjChGtNvDEHGsHEdZECIRhXolPrhawiQpm0e
   g==;
X-CSE-ConnectionGUID: 7NkHgbnoTiG5vjjeQ0wsHw==
X-CSE-MsgGUID: camel/LJTI6o0+kGwt917Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="100274509"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="100274509"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:51:32 -0700
X-CSE-ConnectionGUID: KW0y3OcqQn6DEaTNSyoWYA==
X-CSE-MsgGUID: pBVoPaVWR1m2+kvt1tF/7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="226503096"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Mar 2026 11:51:29 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2ZVm-000000001pV-2vuF;
	Tue, 17 Mar 2026 18:51:26 +0000
Date: Wed, 18 Mar 2026 02:51:02 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v17 14/14] net: homa: create Makefile and Kconfig
Message-ID: <202603180241.OVIQpOJ1-lkp@intel.com>
References: <20260316223228.2611-15-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316223228.2611-15-ouster@cs.stanford.edu>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-268715-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 60E932B1361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20260317-070659
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260316223228.2611-15-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v17 14/14] net: homa: create Makefile and Kconfig
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260318/202603180241.OVIQpOJ1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260318/202603180241.OVIQpOJ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603180241.OVIQpOJ1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/homa/homa_plumbing.c:94:30: error: initialization of 'int (*)(struct sock *, struct msghdr *, size_t,  int)' {aka 'int (*)(struct sock *, struct msghdr *, unsigned int,  int)'} from incompatible pointer type 'int (*)(struct sock *, struct msghdr *, size_t,  int,  int *)' {aka 'int (*)(struct sock *, struct msghdr *, unsigned int,  int,  int *)'} [-Wincompatible-pointer-types]
      94 |         .recvmsg           = homa_recvmsg,
         |                              ^~~~~~~~~~~~
   net/homa/homa_plumbing.c:94:30: note: (near initialization for 'homa_prot.recvmsg')
   In file included from net/homa/homa_plumbing.c:7:
   net/homa/homa_impl.h:402:10: note: 'homa_recvmsg' declared here
     402 | int      homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
         |          ^~~~~~~~~~~~
   net/homa/homa_plumbing.c:111:30: error: initialization of 'int (*)(struct sock *, struct msghdr *, size_t,  int)' {aka 'int (*)(struct sock *, struct msghdr *, unsigned int,  int)'} from incompatible pointer type 'int (*)(struct sock *, struct msghdr *, size_t,  int,  int *)' {aka 'int (*)(struct sock *, struct msghdr *, unsigned int,  int,  int *)'} [-Wincompatible-pointer-types]
     111 |         .recvmsg           = homa_recvmsg,
         |                              ^~~~~~~~~~~~
   net/homa/homa_plumbing.c:111:30: note: (near initialization for 'homav6_prot.recvmsg')
   net/homa/homa_impl.h:402:10: note: 'homa_recvmsg' declared here
     402 | int      homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
         |          ^~~~~~~~~~~~


vim +94 net/homa/homa_plumbing.c

fda29e883f7618 John Ousterhout 2026-03-16   77  
fda29e883f7618 John Ousterhout 2026-03-16   78  /* This structure also defines functions that handle various operations
fda29e883f7618 John Ousterhout 2026-03-16   79   * on Homa sockets. However, these functions are lower-level than those
fda29e883f7618 John Ousterhout 2026-03-16   80   * in homa_proto_ops: they are specific to the PF_INET or PF_INET6
fda29e883f7618 John Ousterhout 2026-03-16   81   * protocol family, and in many cases they are invoked by functions in
fda29e883f7618 John Ousterhout 2026-03-16   82   * homa_proto_ops. Most of these functions have Homa-specific implementations.
fda29e883f7618 John Ousterhout 2026-03-16   83   */
fda29e883f7618 John Ousterhout 2026-03-16   84  static struct proto homa_prot = {
fda29e883f7618 John Ousterhout 2026-03-16   85  	.name		   = "HOMA",
fda29e883f7618 John Ousterhout 2026-03-16   86  	.owner		   = THIS_MODULE,
fda29e883f7618 John Ousterhout 2026-03-16   87  	.close		   = homa_close,
fda29e883f7618 John Ousterhout 2026-03-16   88  	.connect	   = ip4_datagram_connect,
fda29e883f7618 John Ousterhout 2026-03-16   89  	.init		   = homa_socket,
fda29e883f7618 John Ousterhout 2026-03-16   90  	.destroy	   = homa_sock_destroy,
fda29e883f7618 John Ousterhout 2026-03-16   91  	.setsockopt	   = homa_setsockopt,
fda29e883f7618 John Ousterhout 2026-03-16   92  	.getsockopt	   = homa_getsockopt,
fda29e883f7618 John Ousterhout 2026-03-16   93  	.sendmsg	   = homa_sendmsg,
fda29e883f7618 John Ousterhout 2026-03-16  @94  	.recvmsg	   = homa_recvmsg,
fda29e883f7618 John Ousterhout 2026-03-16   95  	.hash		   = homa_hash,
fda29e883f7618 John Ousterhout 2026-03-16   96  	.unhash		   = homa_unhash,
fda29e883f7618 John Ousterhout 2026-03-16   97  	.obj_size	   = sizeof(struct homa_sock),
fda29e883f7618 John Ousterhout 2026-03-16   98  	.no_autobind       = 1,
fda29e883f7618 John Ousterhout 2026-03-16   99  };
fda29e883f7618 John Ousterhout 2026-03-16  100  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

