Return-Path: <netdev+bounces-257185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGGxLwGghGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:49:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A432F38A8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16D09304C4BB
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0799D28506B;
	Thu,  5 Feb 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEIT2Fba"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0317283FFB;
	Thu,  5 Feb 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299069; cv=none; b=ASUfIA1N5ER/nr0dBdkLH+xn7Tc+EK/bjzSRdQCV95Fg/kbmIpPYPDgGdJPnYdCFBgvzDqBsJ+8mIUooRndm9L65DtNxYJ8efbp3s4Oq+zVwKbXBuoF09jasDd3iiNB09NFBuykGeZ3ZANGKVqQKzj9JTULKNifXj3N5MoH+9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299069; c=relaxed/simple;
	bh=+XcJc4Y73NCfrZTD+9DmarCzXkV9jJFSlBeo5lqiIaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX95S2RKJqnJSH5hd4d6Z2mNCvgNMlTObJBDD4AepB9NuFRZRpQsPAjVXt2GMAk6W5b1UWflolzKTNBWp0RBrYc9R/MB/+8KGFUMfXLAAeEis/bHYKU4+ZPKXn3H6uhS82uYdc32j8uYg9cJ9vEueSnGkzKSMQk6j+/dR1bTu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEIT2Fba; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770299070; x=1801835070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+XcJc4Y73NCfrZTD+9DmarCzXkV9jJFSlBeo5lqiIaQ=;
  b=JEIT2Fbaq8bXxyxrXlbX4lMvZcI1nUfLYWVLaP/Yud7bB09r+78xZUwf
   hbIgL8ZKlEgmwKVdS+VHRdwVfgJyuxQJjYw58ax57AGBolUDc23DxmC0o
   wrvZaOoZ/YEhxwhaYN6RykK2TkY0qgCplk/MTu/Bf3EfpGgzSBUuOTWdA
   MKviERMshIeKTKvFPLQ+O5ffYd1HtKn4DnzLI68VsXRfQah1PthIQEXD5
   t2ENIoDFi5YULVJeqEr5yaqz1pWumvW/DYPnac1L60O9cEONJwW/RcXIL
   9BD0Y3JdRDVAeG2k494JO1QheDKHXM/TprWkdo3VP6Big83U8jJSgFuaW
   w==;
X-CSE-ConnectionGUID: fUXtqPRVSMCUw5CD/NpwbQ==
X-CSE-MsgGUID: OD2UJcyLQimSDqsGhKAtfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71486685"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71486685"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 05:44:30 -0800
X-CSE-ConnectionGUID: 0DTb0rsKSWCJcU79gSaarA==
X-CSE-MsgGUID: JGiF1l+eR8WFw1aLLheqoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="215048553"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 05 Feb 2026 05:44:26 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnzeh-000000004B3-2wHq;
	Thu, 05 Feb 2026 13:44:23 +0000
Date: Thu, 5 Feb 2026 14:43:58 +0100
From: kernel test robot <lkp@intel.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev,
	song@kernel.org, haoluo@google.com, ameryhung@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v6 09/17] bpf: Prepare for
 bpf_selem_unlink_nofail()
Message-ID: <202602051417.ebnQFUul-lkp@intel.com>
References: <20260205070208.186382-10-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205070208.186382-10-ameryhung@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-257185-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 3A432F38A8
X-Rspamd-Action: no action

Hi Amery,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Amery-Hung/bpf-Select-bpf_local_storage_map_bucket-based-on-bpf_local_storage/20260205-150959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260205070208.186382-10-ameryhung%40gmail.com
patch subject: [PATCH bpf-next v6 09/17] bpf: Prepare for bpf_selem_unlink_nofail()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260205/202602051417.ebnQFUul-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602051417.ebnQFUul-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602051417.ebnQFUul-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/bpf/bpf_local_storage.c:289:8: warning: variable 'owner' set but not used [-Wunused-but-set-variable]
     289 |         void *owner;
         |               ^
   kernel/bpf/bpf_local_storage.c:64:13: warning: unused function 'selem_linked_to_map' [-Wunused-function]
      64 | static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
         |             ^~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/owner +289 kernel/bpf/bpf_local_storage.c

588d80f1d996ea9 Amery Hung       2026-02-04  278  
450af8d0f6be2e7 KP Singh         2020-08-25  279  /* local_storage->lock must be held and selem->local_storage == local_storage.
450af8d0f6be2e7 KP Singh         2020-08-25  280   * The caller must ensure selem->smap is still valid to be
450af8d0f6be2e7 KP Singh         2020-08-25  281   * dereferenced for its smap->elem_size and smap->cache_idx.
450af8d0f6be2e7 KP Singh         2020-08-25  282   */
c83597fa5dc6b32 Yonghong Song    2022-10-25  283  static bool bpf_selem_unlink_storage_nolock(struct bpf_local_storage *local_storage,
450af8d0f6be2e7 KP Singh         2020-08-25  284  					    struct bpf_local_storage_elem *selem,
0e854e553569083 Amery Hung       2025-11-14  285  					    struct hlist_head *free_selem_list)
450af8d0f6be2e7 KP Singh         2020-08-25  286  {
450af8d0f6be2e7 KP Singh         2020-08-25  287  	struct bpf_local_storage_map *smap;
450af8d0f6be2e7 KP Singh         2020-08-25  288  	bool free_local_storage;
450af8d0f6be2e7 KP Singh         2020-08-25 @289  	void *owner;
450af8d0f6be2e7 KP Singh         2020-08-25  290  
0fe4b381a59ebc5 KP Singh         2021-12-24  291  	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
450af8d0f6be2e7 KP Singh         2020-08-25  292  	owner = local_storage->owner;
450af8d0f6be2e7 KP Singh         2020-08-25  293  
450af8d0f6be2e7 KP Singh         2020-08-25  294  	free_local_storage = hlist_is_singular_node(&selem->snode,
450af8d0f6be2e7 KP Singh         2020-08-25  295  						    &local_storage->list);
450af8d0f6be2e7 KP Singh         2020-08-25  296  
588d80f1d996ea9 Amery Hung       2026-02-04  297  	bpf_selem_unlink_storage_nolock_misc(selem, smap, local_storage,
588d80f1d996ea9 Amery Hung       2026-02-04  298  					     free_local_storage);
450af8d0f6be2e7 KP Singh         2020-08-25  299  
450af8d0f6be2e7 KP Singh         2020-08-25  300  	hlist_del_init_rcu(&selem->snode);
450af8d0f6be2e7 KP Singh         2020-08-25  301  
5bd5bab76669b1e Martin KaFai Lau 2024-10-23  302  	hlist_add_head(&selem->free_node, free_selem_list);
dcf456c9a095a6e KP Singh         2022-04-18  303  
450af8d0f6be2e7 KP Singh         2020-08-25  304  	return free_local_storage;
450af8d0f6be2e7 KP Singh         2020-08-25  305  }
450af8d0f6be2e7 KP Singh         2020-08-25  306  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

