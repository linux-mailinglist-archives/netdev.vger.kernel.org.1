Return-Path: <netdev+bounces-258152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ca0qII2Ci2lDVAAAu9opvQ
	(envelope-from <netdev+bounces-258152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:10:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E642E11E832
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A14302E417
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE632D45C;
	Tue, 10 Feb 2026 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMzQKnVs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0D2ECE9D;
	Tue, 10 Feb 2026 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750600; cv=none; b=FLqLr4neXzUL0Es+GZCXbcjfuoKnmDabD62dKZKCKakCAjnJqg44cGdsde/wh21AwybaqynU7rr3esFSf6wFWaCOduvZefYA/M04rnHPs7RpJJ2S3l7XApzNpSw9eD+f70WLm/52QFrkGBNVLfxI7NHbKc7kiky7NJZ9Zm3xxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750600; c=relaxed/simple;
	bh=RXGCWouJzaLaYrIqq05XaV+MNcokzq4bb1AoK0Rn7nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruZAQ+Q+vLWTBb2+UToBSxIpjyDoSrAXGQbYYj7lWCund2ZU5Rqav8Qa+Xsl9Z8lYDO1ARXUabBpk1LaruQjXqj7K8o2XLr3+tE02IVU43ItFPnSYn5VM2WFsnXo+p/y/EJqloPcvuZd87BZILD4z66AbEuKfwt1w7tqS6kMZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMzQKnVs; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770750599; x=1802286599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RXGCWouJzaLaYrIqq05XaV+MNcokzq4bb1AoK0Rn7nY=;
  b=cMzQKnVsE0wUrq0xmOrd0zN1zo2eynd5a/qv5Whb6bWhg3AlZLmwgacQ
   jihEdW8FgjliGoFne4CCEo+TuekkK146nv8bYGX5vN2L6POkOwOD5FZeR
   T4+HB8uzj5W5CtHGZG/f3GTTsYSfNBhEmA5Kvc5gnBWBaCL4XZ3fBznbP
   7kG9lrr0Tdm+GbieFhuedlSfb/ZT5M99gNKQmpeAnmKOU7dnVcW4nOzyG
   thPQ+eCvVoiz5SlCQbB+X52GJ5vmhlHkWcXOQLdq75vYu03PZciViDhC6
   WPNKpwy3i1XrgFgOrRD2+E/HkSE6mpDDjUYbHFaXV+/5Ot9UUklMdcp7d
   g==;
X-CSE-ConnectionGUID: g6awSo4xSD2eDcQEmD7M/Q==
X-CSE-MsgGUID: pTDEYw51SWC/sDD658MgOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71789129"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71789129"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 11:09:58 -0800
X-CSE-ConnectionGUID: O0TVIcK0R6GQPK5ciHl8aw==
X-CSE-MsgGUID: Om1TA5oqTaWSzxiTmmo0FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211331531"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Feb 2026 11:09:55 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpt7Q-00000000pKe-35NA;
	Tue, 10 Feb 2026 19:09:52 +0000
Date: Wed, 11 Feb 2026 03:08:56 +0800
From: kernel test robot <lkp@intel.com>
To: Feng Yang <yangfeng59949@163.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	yangfeng59949@163.com
Subject: Re: [PATCH v5] bpf: test_run: Fix the null pointer dereference issue
 in bpf_lwt_xmit_push_encap
Message-ID: <202602110336.LIXRMPDU-lkp@intel.com>
References: <20260210090657.86977-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210090657.86977-1-yangfeng59949@163.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-258152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E642E11E832
X-Rspamd-Action: no action

Hi Feng,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/net]
[also build test ERROR on bpf-next/master bpf/master net-next/main net/main linus/master v6.19 next-20260209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Feng-Yang/bpf-test_run-Fix-the-null-pointer-dereference-issue-in-bpf_lwt_xmit_push_encap/20260210-171138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260210090657.86977-1-yangfeng59949%40163.com
patch subject: [PATCH v5] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
config: sparc-randconfig-002-20260210 (https://download.01.org/0day-ci/archive/20260211/202602110336.LIXRMPDU-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260211/202602110336.LIXRMPDU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602110336.LIXRMPDU-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: net/bpf/test_run.o: in function `bpf_prog_test_run_skb':
>> test_run.c:(.text+0x46fc): undefined reference to `ip_route_output_flow'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

