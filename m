Return-Path: <netdev+bounces-255555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOd2GuObfmnGbQIAu9opvQ
	(envelope-from <netdev+bounces-255555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:18:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E22C47B0
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7919F30160F4
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E0199EAD;
	Sun,  1 Feb 2026 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpEN3rNo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5283EBF1D
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769905120; cv=none; b=JIDyPwSJRcBJL8+ghaemXzpvjlTWlxso0qD/HfeybtcIidKZIn5UotZXmpQyh1pNIdVhtMjS/dtOEVvtTIUH6R6hmFiwiwXM9JUcGP0LdFuqaiu1GJdheXi5D5YolWyL+1v1cS4O9cZS3sfeSzZSAXjvUk95NkAo/a4viccuhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769905120; c=relaxed/simple;
	bh=PJWv3FgT27atPv/BOizYjrt7ayNwj3DoMqPBVxQj1B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRGG2DWriXJaeZm04nTOQrp4o9w8jxeLIJcHQZ3TlwxPwi1/dKBS95W7EixfTj2lUkdFtyGEA4OiusPKmIlTnVOMDGRYuI+RJflc7/QIV5WVf+AV6WBMUgVVpxjB4J57cXPS803oLhrHXPp7agCsp68E8CuPsmgynLVt/RC7jC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpEN3rNo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769905119; x=1801441119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJWv3FgT27atPv/BOizYjrt7ayNwj3DoMqPBVxQj1B0=;
  b=DpEN3rNoFQugsPfv7CP8Q5HqKGV+xejLIvUyIEWzhJpVgK39BoGOC7ig
   +HucD9K8JtoslTA7fw7vNys5dSxcDDegCxqlSUI0qzP7RxMRWKzYMafX4
   HXhJsRYdz/5ShQLkYQMp8gS7yegR2yfFbIZTDELhrwunumqDBEU4gTgpg
   jRN5yTK7TH/0GY8GzYeJKAf4WlYQ2t7vHAaKCSjybdbDM+EFnfUWZeCFv
   u5+wUOh92pglUC1dx6WgSgL3GZ5Y9IycRKeAh1HMxOg3Os2q+xIHSl82x
   dx5EweLTw4pRDHIGGibkbtLkSSZtvfW03Td1RyHZrvxSrbXyq147mxsXC
   Q==;
X-CSE-ConnectionGUID: LpR/zXn+SsGrpBhA9GEkJA==
X-CSE-MsgGUID: +5f1rchORb2loLsrVVWf9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11688"; a="81847709"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="81847709"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 16:18:38 -0800
X-CSE-ConnectionGUID: APRkIp0gRGSInY2G62LxFA==
X-CSE-MsgGUID: +zOfM/0DROyApA/ad5hW1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="214062401"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 31 Jan 2026 16:18:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmLAf-00000000eUq-2aD8;
	Sun, 01 Feb 2026 00:18:33 +0000
Date: Sun, 1 Feb 2026 08:18:19 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] tcp: move __reqsk_free() out of line
Message-ID: <202602010830.7VDNDITy-lkp@intel.com>
References: <20260131171627.1852894-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131171627.1852894-1-edumazet@google.com>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255555-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0E22C47B0
X-Rspamd-Action: no action

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/tcp-move-__reqsk_free-out-of-line/20260201-011758
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260131171627.1852894-1-edumazet%40google.com
patch subject: [PATCH net-next] tcp: move __reqsk_free() out of line
config: um-randconfig-001-20260201 (https://download.01.org/0day-ci/archive/20260201/202602010830.7VDNDITy-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260201/202602010830.7VDNDITy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602010830.7VDNDITy-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   /usr/bin/ld: net/core/request_sock.o: in function `reqsk_fastopen_remove':
>> include/net/request_sock.h:137:(.ltext+0x103): undefined reference to `__reqsk_free'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)


vim +137 include/net/request_sock.h

9403cf23025880 Guillaume Nault  2019-03-19  133  
1e2e01172fd11b Eric Dumazet     2015-03-12  134  static inline void reqsk_put(struct request_sock *req)
1e2e01172fd11b Eric Dumazet     2015-03-12  135  {
41c6d650f6537e Reshetova, Elena 2017-06-30  136  	if (refcount_dec_and_test(&req->rsk_refcnt))
c34506406dd5cf Eric Dumazet     2024-06-05 @137  		__reqsk_free(req);
1e2e01172fd11b Eric Dumazet     2015-03-12  138  }
1e2e01172fd11b Eric Dumazet     2015-03-12  139  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

