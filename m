Return-Path: <netdev+bounces-285103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i+AsONHt+2m0IgAAu9opvQ
	(envelope-from <netdev+bounces-285103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:41:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF784E20BF
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DE730136B2
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 01:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BDA26B74A;
	Thu,  7 May 2026 01:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLdGKeZk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87723D283;
	Thu,  7 May 2026 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118094; cv=none; b=ce3TYzsrvd/NMw3whe8Nq4XJXxpTjW1CSbiY0RVsEOs6SHG/Y12Q+y6tKvptmQ9ousWEsNxbmHEI1NX0zQMB/UcoatUZBMQSH3ab7ioogAnsNRxk+2ktgjM+Mq254ibEEZggpcgGUn7+D+LqbVJU2Bl01y3shoL1ZlgR/xaK4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118094; c=relaxed/simple;
	bh=wO5vhQqDka++NhEZmxe7dc618EjmbcBVTo0a3RXkeCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE/Xldg0alVI9szCKFZk8nv1QKF47z7qDZegB9VVuspRI4omyXS+4nbYlFkVYw7MlpWkXTO/ypv3x8JrVuMaLrFToxQ/845lWl+vhSs5iGZd7mkvhUBMZcnnxIxrYW+Tos8cpjumYcQvhOK0TcvItAoegp6uNJvFifM9I1ilKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLdGKeZk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778118091; x=1809654091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wO5vhQqDka++NhEZmxe7dc618EjmbcBVTo0a3RXkeCY=;
  b=cLdGKeZkBYAnxARi4zYsTqOVKNkwMAHjUkFcOvAWenGYNRGdzwby0W0+
   Airuqb55yApxZqHFMuHQ+YysqjZEYQKYC+NlGcNkWKujJUmq7ip9NCND6
   ZohD0UEGXntLmdU41bOXEjm9m3UA+JQb65CmqhkJViVScThHH/zBpjWnm
   tu6666cZcOczjF47nX2Mv/AOt+4uGCTnndWNzdKoPR2XebLW0dqNmDRLw
   0ZFE4yXRCTHOhnlRsLAGl+lxRuhyMZSC3FgKWN21FBPXnfXUhgUSSnSRo
   Dk9rRoySGfLImqS+jdhQWFboi3MwjM6YDD6oV+h4vj8r7+h1VqVAZL651
   A==;
X-CSE-ConnectionGUID: X6AehSwXTyKL29ZUD44/Wg==
X-CSE-MsgGUID: 4VxoY5OERWyCGddq2UQeaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78089462"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78089462"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 18:41:31 -0700
X-CSE-ConnectionGUID: 8Sg+47i/Q3WGFjDN+XXGKA==
X-CSE-MsgGUID: T1z2AYfbTdCTuKErTLJmhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="266694515"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2026 18:41:28 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKnjx-000000006ib-3o27;
	Thu, 07 May 2026 01:41:25 +0000
Date: Thu, 7 May 2026 03:40:30 +0200
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Eulgyu Kim <eulgyukim@snu.ac.kr>
Subject: Re: [PATCH v1 bpf] bpf: Free reuseport cBPF prog after RCU grace
 period.
Message-ID: <202605070321.vVxQf7dU-lkp@intel.com>
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
X-Rspamd-Queue-Id: 3AF784E20BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285103-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,linux.dev,kernel.org,iogearbox.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/bpf-Free-reuseport-cBPF-prog-after-RCU-grace-period/20260425-093050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20260424235247.1990272-1-kuniyu%40google.com
patch subject: [PATCH v1 bpf] bpf: Free reuseport cBPF prog after RCU grace period.
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260507/202605070321.vVxQf7dU-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260507/202605070321.vVxQf7dU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605070321.vVxQf7dU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/filter.c:1666:6: error: conflicting types for 'sk_reuseport_prog_free'
    1666 | void sk_reuseport_prog_free(struct bpf_prog *prog, bool wait_rcu)
         |      ^
   include/linux/filter.h:1146:6: note: previous declaration is here
    1146 | void sk_reuseport_prog_free(struct bpf_prog *prog);
         |      ^
   1 error generated.


vim +/sk_reuseport_prog_free +1666 net/core/filter.c

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

