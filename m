Return-Path: <netdev+bounces-268722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHhzOmeruWkhLwIAu9opvQ
	(envelope-from <netdev+bounces-268722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:28:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 575BB2B18CC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8128313D5EB
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624ED33F369;
	Tue, 17 Mar 2026 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBS5NMcX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBC33BBCC
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775597; cv=none; b=GWV1Tptbys+g7N2BgOQn02Gstp9iqVbvS2j51k1gBJdWaz/7Osy9KcrxU3GSRrrGGtjPq3bgUqRIDkn5IW3E7Uw52r12sbXj3Xv1sGjsYdcZha5XLaWFaI8aDmpAHOGlKZpjB5y0qVzOyVnIjXEMfuZfUqe4VkgltD/xlEC+m8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775597; c=relaxed/simple;
	bh=rrlbfIW+VnOm0b0ICuUS8QojTdTqgDOtq9/xFyMzsnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLK2fHixLIYfpzsZdLiR2S06nlIeM8FnrtqF1zHGyPZMq91nJvZy9FBZHl/8qytfjkkB29Qjen8DCtfv59xOHsGF15q2PPJ5uRNMynKH0HCInqI/ZFntMr9C4n+a2coRtJOG8pjzP3V9Gtg2IYskwfoFqWohUqN/yOzaPint0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBS5NMcX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773775595; x=1805311595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rrlbfIW+VnOm0b0ICuUS8QojTdTqgDOtq9/xFyMzsnY=;
  b=lBS5NMcX3x7Vyj7NTrxJUWTCp4/Ktr+09lWmZmkJ+Awk/H0cT7GTutB+
   oB33j4QMGpvp4YOGi+8yd9nc6Ds8JykjGpyf9n+kFUcurI0HS6Ht3qtTI
   oLBknYyIX9FSiu44EZ8lOX4z7hgqu1gS47fZgF1JcrM3SMutQdEevZ6IU
   R0IhYLC2cDxU8NZodXCjAkBJxHxbtbh1E3lzUoOFEeYmeYjN7s0Zc1vL0
   HipGc5B8Jo7eG9SBQW+TAO4FXmNKWmht6X3F73BILst0amf/0qSWGbMwp
   Z6r6wEiYJN/o/FwWAy6v1rKjg3eGkHIF6DE/uO2RPWsux6ha7t/d0GHjw
   A==;
X-CSE-ConnectionGUID: R6gTxtR2S5GKlY6sOJ9sRA==
X-CSE-MsgGUID: BHIdInWfQ16ZZYBmqJrU6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74000800"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74000800"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 12:26:34 -0700
X-CSE-ConnectionGUID: gqCc6hgUT1uViNBfW08Q8A==
X-CSE-MsgGUID: T8tF0lF7RxG0bJCeGpQLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="219851330"
Received: from lkp-server01.sh.intel.com (HELO 63737dd503cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 17 Mar 2026 12:26:32 -0700
Received: from kbuild by 63737dd503cb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2a3i-000000001sP-0MSs;
	Tue, 17 Mar 2026 19:26:30 +0000
Date: Wed, 18 Mar 2026 03:26:12 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v17 14/14] net: homa: create Makefile and Kconfig
Message-ID: <202603180330.3g4vKnoZ-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-268722-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 575BB2B18CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20260317-070659
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260316223228.2611-15-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v17 14/14] net: homa: create Makefile and Kconfig
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260318/202603180330.3g4vKnoZ-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 4abb927bacf37f18f6359a41639a6d1b3bffffb5)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260318/202603180330.3g4vKnoZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603180330.3g4vKnoZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/homa/homa_plumbing.c:94:16: error: incompatible function pointer types initializing 'int (*)(struct sock *, struct msghdr *, size_t, int)' (aka 'int (*)(struct sock *, struct msghdr *, unsigned long, int)') with an expression of type 'int (struct sock *, struct msghdr *, size_t, int, int *)' (aka 'int (struct sock *, struct msghdr *, unsigned long, int, int *)') [-Wincompatible-function-pointer-types]
      94 |         .recvmsg           = homa_recvmsg,
         |                              ^~~~~~~~~~~~
   net/homa/homa_plumbing.c:111:16: error: incompatible function pointer types initializing 'int (*)(struct sock *, struct msghdr *, size_t, int)' (aka 'int (*)(struct sock *, struct msghdr *, unsigned long, int)') with an expression of type 'int (struct sock *, struct msghdr *, size_t, int, int *)' (aka 'int (struct sock *, struct msghdr *, unsigned long, int, int *)') [-Wincompatible-function-pointer-types]
     111 |         .recvmsg           = homa_recvmsg,
         |                              ^~~~~~~~~~~~
   2 errors generated.


vim +94 net/homa/homa_plumbing.c

fda29e883f7618b John Ousterhout 2026-03-16   77  
fda29e883f7618b John Ousterhout 2026-03-16   78  /* This structure also defines functions that handle various operations
fda29e883f7618b John Ousterhout 2026-03-16   79   * on Homa sockets. However, these functions are lower-level than those
fda29e883f7618b John Ousterhout 2026-03-16   80   * in homa_proto_ops: they are specific to the PF_INET or PF_INET6
fda29e883f7618b John Ousterhout 2026-03-16   81   * protocol family, and in many cases they are invoked by functions in
fda29e883f7618b John Ousterhout 2026-03-16   82   * homa_proto_ops. Most of these functions have Homa-specific implementations.
fda29e883f7618b John Ousterhout 2026-03-16   83   */
fda29e883f7618b John Ousterhout 2026-03-16   84  static struct proto homa_prot = {
fda29e883f7618b John Ousterhout 2026-03-16   85  	.name		   = "HOMA",
fda29e883f7618b John Ousterhout 2026-03-16   86  	.owner		   = THIS_MODULE,
fda29e883f7618b John Ousterhout 2026-03-16   87  	.close		   = homa_close,
fda29e883f7618b John Ousterhout 2026-03-16   88  	.connect	   = ip4_datagram_connect,
fda29e883f7618b John Ousterhout 2026-03-16   89  	.init		   = homa_socket,
fda29e883f7618b John Ousterhout 2026-03-16   90  	.destroy	   = homa_sock_destroy,
fda29e883f7618b John Ousterhout 2026-03-16   91  	.setsockopt	   = homa_setsockopt,
fda29e883f7618b John Ousterhout 2026-03-16   92  	.getsockopt	   = homa_getsockopt,
fda29e883f7618b John Ousterhout 2026-03-16   93  	.sendmsg	   = homa_sendmsg,
fda29e883f7618b John Ousterhout 2026-03-16  @94  	.recvmsg	   = homa_recvmsg,
fda29e883f7618b John Ousterhout 2026-03-16   95  	.hash		   = homa_hash,
fda29e883f7618b John Ousterhout 2026-03-16   96  	.unhash		   = homa_unhash,
fda29e883f7618b John Ousterhout 2026-03-16   97  	.obj_size	   = sizeof(struct homa_sock),
fda29e883f7618b John Ousterhout 2026-03-16   98  	.no_autobind       = 1,
fda29e883f7618b John Ousterhout 2026-03-16   99  };
fda29e883f7618b John Ousterhout 2026-03-16  100  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

