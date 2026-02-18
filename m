Return-Path: <netdev+bounces-259237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBWUIaWFlWm9SAIAu9opvQ
	(envelope-from <netdev+bounces-259237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:25:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FA154B4E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AD9E300877A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B333ADB6;
	Wed, 18 Feb 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKShtMU2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42212C11EE;
	Wed, 18 Feb 2026 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406752; cv=none; b=cM8Rn/z+Oqdy4TYxwyWEonh2vmc9wtMVkeCWyJ4sJlgwEYUof+wGOSCItZvGBMbFBJ6NDONW66w5YumGj3BFvdDtdlHdBKthQpFIBntTjGYNqi03GeW8J5zwc7wuzcPnF/FIx3+Bz+NrcxTkab/obk2UsicIrnWNKLL+UHSeY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406752; c=relaxed/simple;
	bh=7Mi9qac5ReGqC6chwcM+0FI8Kzvlyju/4bHh3m/uhJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzkLZiHijh4m9+bbToFMGBfzUOVsKggtUiOaUwk1aRT72nvdxpotX4TZTAzzh/034gBdmXBgmVQI3xeLUAv3MWaTYw1WZrYhN8Bxdns9ef97gRVFSDcK17KnZr2+zJefBYT7FnF7rPaOQ+Ymyva1rzmViH8vHW4oe5zyRA6P3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKShtMU2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771406751; x=1802942751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Mi9qac5ReGqC6chwcM+0FI8Kzvlyju/4bHh3m/uhJU=;
  b=hKShtMU2KvSWIwYpXgsQaTqtm5saMnvTy3iFVnUUqkly+7dxQOrA61Mw
   ELGSasdoFtMoTgfK2PeoyfqdtbfKOpsbDV6G8z7blr+jzP59mUvARmMZj
   qTxXlJCflb25kDXnrvAR4AGiT6rwCQJ5YHLjxY47sbgMfqj/QxldQd53+
   ksUXyI4Ic96gPHZv+/1mgu/b7YWRYo6J7xLqtZBdUZTbQN0Imj+Y/5vmk
   qABe/QMMG0huf/CEzvv6YD6XjN861E2WiOguI0qyadG6g5bDSJ8Myof4v
   xxYu9uhvvqYgxCRmfWbwjGsTbdF+CfWu8+2xLtii/KC+mSHe24vZG0B+3
   w==;
X-CSE-ConnectionGUID: rByOHHPcSvmBjEfvmyaGXQ==
X-CSE-MsgGUID: Eq50VlS5SOCo31P2xmJx6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="75088896"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="75088896"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 01:25:50 -0800
X-CSE-ConnectionGUID: Rh52ltp/RYiXXH6MzyV6iw==
X-CSE-MsgGUID: wkye9/XKQ3iuGwpAWVPCsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="214136496"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 18 Feb 2026 01:25:45 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsdoT-000000012EC-3hfd;
	Wed, 18 Feb 2026 09:25:41 +0000
Date: Wed, 18 Feb 2026 17:25:10 +0800
From: kernel test robot <lkp@intel.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	shuah@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-open-source@crowdstrike.com,
	Slava Imameev <slava.imameev@crowdstrike.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add trampolines
 multi-level pointer params test coverage
Message-ID: <202602181710.tEK6nOl6-lkp@intel.com>
References: <20260217221357.18215-3-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217221357.18215-3-slava.imameev@crowdstrike.com>
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
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[lists.linux.dev,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,crowdstrike.com];
	TAGGED_FROM(0.00)[bounces-259237-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 2F9FA154B4E
X-Rspamd-Action: no action

Hi Slava,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Slava-Imameev/bpf-Support-multi-level-pointer-params-via-PTR_TO_MEM-for-trampolines/20260218-062417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20260217221357.18215-3-slava.imameev%40crowdstrike.com
patch subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add trampolines multi-level pointer params test coverage
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260218/202602181710.tEK6nOl6-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602181710.tEK6nOl6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602181710.tEK6nOl6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/bpf/test_run.c:737:2: error: call to undeclared function 'flush_tlb_kernel_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     737 |         flush_tlb_kernel_range((unsigned long)page_address(page),
         |         ^
   net/bpf/test_run.c:760:2: error: call to undeclared function 'flush_tlb_kernel_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     760 |         flush_tlb_kernel_range((unsigned long)addr,
         |         ^
   2 errors generated.


vim +/flush_tlb_kernel_range +737 net/bpf/test_run.c

   709	
   710	static void *create_bad_kaddr(void)
   711	{
   712		/*
   713		 * Try to get an address that passes kernel range checks but causes
   714		 * a page fault handler invocation if accessed from a BPF program.
   715		 */
   716	#if defined(CONFIG_ARCH_HAS_SET_MEMORY) && defined(CONFIG_X86)
   717		void *addr = vmalloc(PAGE_SIZE);
   718	
   719		if (!addr)
   720			return NULL;
   721		/* Make it non-present - any access will fault */
   722		if (set_memory_np((unsigned long)addr, 1)) {
   723			vfree(addr);
   724			return NULL;
   725		}
   726		return addr;
   727	#elif defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
   728		struct page *page = alloc_page(GFP_KERNEL);
   729	
   730		if (!page)
   731			return NULL;
   732		/* Remove from direct map - any access will fault */
   733		if (set_direct_map_invalid_noflush(page)) {
   734			__free_page(page);
   735			return NULL;
   736		}
 > 737		flush_tlb_kernel_range((unsigned long)page_address(page),
   738				       (unsigned long)page_address(page) + PAGE_SIZE);
   739		return page_address(page);
   740	#endif
   741		return NULL;
   742	}
   743	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

