Return-Path: <netdev+bounces-285015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7U/YDhqZ+2kMeQMAu9opvQ
	(envelope-from <netdev+bounces-285015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:40:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 840354DFE1F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB839300A616
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAA731E82F;
	Wed,  6 May 2026 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1aEmZsd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D54309DDF;
	Wed,  6 May 2026 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096185; cv=none; b=pxBUktwfklVdSf/xIsXvpf6sOQMPcoUPLIfABKcxSFbmy7nIOsriT7NjctGTl8moNQiTwobpd6ZNI0Nn5Qn34tz/Yr4vXsAIC4/Uwh/+Ffl/cU9d9wi3zf4DC24ylruC7wMjTb71sHhRrtN5InNpHVXkQpVDFSvdsQhcsRQBwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096185; c=relaxed/simple;
	bh=NrxXVqT6gZqs778saJwmFa7N3g9GsPnabIuBuX5oqIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4FiMrnvDZNdfErLsi9r6YZoshWbsZx6Ez8POJMxb4AEHCnNWCdl4dKZIyTtIeCD2IuRkAjR1qmkf+Sqg/ORPdXPt/HelPvGUcCgjy97xU0diKOgcfhxK6s87/Az0Y+2XPNGN3+YwQNiRX27Lkbdv3gQQJbfGK1tfYOQ1aXlZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1aEmZsd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778096184; x=1809632184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NrxXVqT6gZqs778saJwmFa7N3g9GsPnabIuBuX5oqIM=;
  b=b1aEmZsduuWco4AxxSp8zlKiz86wHzrzziogs1YRRHJD4/oe+51tdfkR
   pwiKNM0y0cLGVEZXmNJeci2erKx2NEA0cPeVERwx7E8v/3la6yWKtFbXR
   Jt16SbnGCIrdr77Gexmwc1xCp/wSWg3J67juQMToiGOMbW0jQxvEvHV9Z
   xXMJ8eCqiZBZJCbevmcbC+kX2mNPGSrcAYAVBuiy4bw5cDJZqQ6KZMlQi
   Trzf/NVxGlwWzofye2kWNcSiUzbTT5C0CyRt6TOOeSeNQMzdik5KGyx7G
   ErhH6HYTfhj7BDK56VBCAHBuA0gB47mLg1dqJZ8mDX0XxDMlXKAtA/WGU
   A==;
X-CSE-ConnectionGUID: +nfR/DgkT5CNCWxGE2i+PA==
X-CSE-MsgGUID: zu9r6EXQQ7GZfXeP1J97Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79086557"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="79086557"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 12:36:23 -0700
X-CSE-ConnectionGUID: FE+u2+MMSB+CUTST28UnZA==
X-CSE-MsgGUID: SuIM1A7jSJGWv3SsGJVDrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="233132424"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 06 May 2026 12:36:21 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKi2d-000000006bx-0SxN;
	Wed, 06 May 2026 19:36:19 +0000
Date: Wed, 6 May 2026 21:36:09 +0200
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	Eulgyu Kim <eulgyukim@snu.ac.kr>
Subject: Re: [PATCH v1 bpf] bpf: Free reuseport cBPF prog after RCU grace
 period.
Message-ID: <202605062104.y7Xps52z-lkp@intel.com>
References: <20260424235247.1990272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424235247.1990272-1-kuniyu@google.com>
X-Rspamd-Queue-Id: 840354DFE1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285015-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,linux.dev,kernel.org,iogearbox.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/bpf-Free-reuseport-cBPF-prog-after-RCU-grace-period/20260425-093050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20260424235247.1990272-1-kuniyu%40google.com
patch subject: [PATCH v1 bpf] bpf: Free reuseport cBPF prog after RCU grace period.
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260506/202605062104.y7Xps52z-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260506/202605062104.y7Xps52z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605062104.y7Xps52z-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/filter.c:1666:6: error: conflicting types for 'sk_reuseport_prog_free'; have 'void(struct bpf_prog *, bool)' {aka 'void(struct bpf_prog *, _Bool)'}
    1666 | void sk_reuseport_prog_free(struct bpf_prog *prog, bool wait_rcu)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/bpf_verifier.h:9,
                    from net/core/filter.c:21:
   include/linux/filter.h:1146:6: note: previous declaration of 'sk_reuseport_prog_free' with type 'void(struct bpf_prog *)'
    1146 | void sk_reuseport_prog_free(struct bpf_prog *prog);
         |      ^~~~~~~~~~~~~~~~~~~~~~


vim +1666 net/core/filter.c

  1665	
> 1666	void sk_reuseport_prog_free(struct bpf_prog *prog, bool wait_rcu)
  1667	{
  1668		if (!prog)
  1669			return;
  1670	
  1671		if (bpf_prog_was_classic(prog))
  1672			call_rcu(&prog->aux->rcu, sk_reuseport_prog_free_rcu);
  1673		else
  1674			bpf_prog_put(prog);
  1675	}
  1676	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

