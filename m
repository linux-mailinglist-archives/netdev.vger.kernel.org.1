Return-Path: <netdev+bounces-299772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id anYxNQgDMWqEaQUAu9opvQ
	(envelope-from <netdev+bounces-299772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:02:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B9C68D024
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:02:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=IwXuumrS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299772-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299772-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 911E03028F58
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164434CFC7;
	Tue, 16 Jun 2026 08:02:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E62DECC2;
	Tue, 16 Jun 2026 08:02:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596929; cv=none; b=E4QdVwqtIowvL0A+J6W+AHL5YNT5Y3KZHgjpQHWkG3OE/fDbkMUr0yLYAu9Kv133Gc+vCptGayQfDWTGQplW1kacnjqSwGKAgF1J0QHQKt8yOrYZylGTPYGZiKpLlNeTgtIh3QeR+WKSGH2j4bkGtFwrdRw0Izm9OU+UFAdTyRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596929; c=relaxed/simple;
	bh=2hprFDhuFZzyagpO1XXJLuYtZVfZ1p82Mf8obLvYWTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khKgkuQUxwhFjWTjx0Pnk9HnrN4YEYuW+SvihCksjaNYFz6wCHPMzv7RbDcTZz/lsBGThcjyjSVMYZET5Dzg9Bs2k8NOa8u8xr/O0oV8OCx+NthoQUcnBaIuHAcbvQuhkjPgxNP9W/4NS6eMjgf/GDYiQXlrjuBtUG22ULdi0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwXuumrS; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781596928; x=1813132928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2hprFDhuFZzyagpO1XXJLuYtZVfZ1p82Mf8obLvYWTw=;
  b=IwXuumrS6+eSVU/0tVxa+HkzJV/vNCDFkbA5hpFS7Cjpc16EZqCuENc6
   ew3mWqXIWpGbOjdJV/PlCl2J3PoWBO7Flm7baXFQQfVUI/V5gQLllHRa0
   HwKZ5OFrWrdNbOcsnsM3oXV+U7mMiCjnmsK2BUBtORjXMWn1zNLItOu2T
   oaV4cVL6fiO/xSGiWOkSm7GvgIVVO1q0+LbgJZceqZT25UbV10A4+IwSI
   NYXG0SXJ7OBKUZDL4WF4N9fIC8xVNTCaGbpUjfmcCvIb2Al3E7eLyW8pU
   NYXsNjVgjJv41kKq+3esHMPFORycDTYbd0+adP/8skdilUpZiMzEt3Tsg
   g==;
X-CSE-ConnectionGUID: OUac+x68RAWU3EF2U4HfTA==
X-CSE-MsgGUID: 21c+/wtNRqC83z/pAPw8vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82550883"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82550883"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:01:56 -0700
X-CSE-ConnectionGUID: 7zZaPk4/S+6rYw01pC5BWg==
X-CSE-MsgGUID: cd+jSqhqQFmyLsBIOvDNBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="243536319"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jun 2026 01:01:51 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZOk0-00000000Ssg-09T9;
	Tue, 16 Jun 2026 08:01:48 +0000
Date: Tue, 16 Jun 2026 16:01:18 +0800
From: kernel test robot <lkp@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, rizzo.unipi@gmail.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com,
	kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, david@kernel.org, netdev@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <202606161519.z7SY98jp-lkp@intel.com>
References: <20260615234220.3946885-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615234220.3946885-1-lrizzo@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:lrizzo@google.com,m:rizzo.unipi@gmail.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299772-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,gmail.com,samsung.com,arm.com,davemloft.net,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_URIBL_FAIL(0.00)[01.org:query timed out];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RSPAMD_EMAILBL_FAIL(0.00)[lkp@intel.com:query timed out];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,git-scm.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88B9C68D024

Hi Luigi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v7.1 next-20260615]
[cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/swiotlb-avoid-double-copy-with-swiotlb-on-tx-socket/20260616-074655
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260615234220.3946885-1-lrizzo%40google.com
patch subject: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20260616/202606161519.z7SY98jp-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260616/202606161519.z7SY98jp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606161519.z7SY98jp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/page_alloc.c:721:17: warning: unused variable 'folio' [-Wunused-variable]
     721 |                 struct folio *folio = (struct folio *)page;
         |                               ^~~~~
   1 warning generated.
--
>> Warning: kernel/dma/swiotlb.c:95 cannot understand function prototype: 'atomic_t global_device_serial = ATOMIC_INIT(0);'
>> Warning: kernel/dma/swiotlb.c:2087 function parameter 'where_debug_only' not described in 'swiotlb_free_pages'
>> Warning: kernel/dma/swiotlb.c:2087 function parameter 'where_debug_only' not described in 'swiotlb_free_pages'


vim +/folio +721 mm/page_alloc.c

   717	
   718	void swiotlb_destroy_compound_page(struct page *page, unsigned int order)
   719	{
   720		if (order > 0) {
 > 721			struct folio *folio = (struct folio *)page;
   722	
   723			__ClearPageHead(page);
   724			page[1].flags.f &= ~PAGE_FLAGS_SECOND;
   725	#ifdef NR_PAGES_IN_LARGE_FOLIO
   726			folio->_nr_pages = 0;
   727	#endif
   728			for (int i = 1; i < (1 << order); i++) {
   729				page[i].mapping = NULL;
   730				clear_compound_head(&page[i]);
   731			}
   732		}
   733	}
   734	#endif /* CONFIG_SWIOTLB */
   735	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

