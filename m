Return-Path: <netdev+bounces-299818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JBTyERAyMWotdwUAu9opvQ
	(envelope-from <netdev+bounces-299818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:22:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE20068EC17
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:22:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=gYVH7dtK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299818-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299818-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C95C3044969
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA73BED0C;
	Tue, 16 Jun 2026 11:22:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC55386557;
	Tue, 16 Jun 2026 11:22:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608941; cv=none; b=HOldnDEuDJYI20SvSYYnAdXBOgfRKDWWqqRxYQI626V2hpJJ0V4JrTbYn4EMT/gZt18o/5UxJaPRGQiaqcMD0rTHcY9+W7x3MWUoJbMYI06wxk+I/JaY/x4KqfaMRK2PneNFR0SzbzlnTX9wihV+7FQWH38/g3qtlffZg+h2xE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608941; c=relaxed/simple;
	bh=nohL65ROZIqtmEJOb8WOvehUuPoWHPtjZtI1TlTx0/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJUWoTbLj9+3Fbf74nfU/NztwJaa1EoySI/ThAxrtavPYjqkOEKXSODKQBUlSsCtxWk+Mlr1nTBhEOO9+Ahudhxa9xXFP6kFjaelzAO18p0/57G/N1Tyjf3OrNXZVh9gLiFIiriUhS9KU+aEjmstx5P9ltpXeoNFhp9x5k+8rNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYVH7dtK; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781608939; x=1813144939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nohL65ROZIqtmEJOb8WOvehUuPoWHPtjZtI1TlTx0/Y=;
  b=gYVH7dtKfdgg3Eo22nsb/iHWy0tGFgJjCp7cgmXALfVh6mrmv71da5o6
   env9lj7QaJmZEws/3zYKV2X1taZYCUoOLfGZHmy0tNSAOJ6UYoZi2OoOu
   qZxzPWPQoZBuDYa0RcNx0lNO+uH/UjYE0HnQieYKtP48rWovtTit0jnxA
   HfmNWH/5ZLudKhxENwICwsJZdxr3LEza/eR7bZyANDWNeFpokO0mGa6iX
   h7mMvjRZCqBSKnyxDL2Gpf7kttdOh26FDL1MPTaIHlvD6PvwSd06atiQI
   fyDDLbaHrWYcf29pJrzKHvpWjWz0VuP/sU0f+daAAjjB/ITr7QXzrCqrS
   w==;
X-CSE-ConnectionGUID: lv/pg06pTcKsMP0Ckml4fg==
X-CSE-MsgGUID: 7JBt8pmHRNqdsiERN8PmRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82271779"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82271779"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 04:22:18 -0700
X-CSE-ConnectionGUID: yuoDe4CTQU+HO5V73soi0g==
X-CSE-MsgGUID: ccB/ruOPR8KdguyS4qxCSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="244860539"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jun 2026 04:22:14 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZRrv-00000000T66-2F3Z;
	Tue, 16 Jun 2026 11:22:11 +0000
Date: Tue, 16 Jun 2026 19:21:11 +0800
From: kernel test robot <lkp@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, rizzo.unipi@gmail.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, willemb@google.com,
	kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	rafael@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	netdev@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
Message-ID: <202606161921.OPkgBApm-lkp@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299818-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lrizzo@google.com,m:rizzo.unipi@gmail.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oe-kbuild-all@lists.linux.dev,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,gmail.com,samsung.com,arm.com,davemloft.net,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,git-scm.com:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,01.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE20068EC17

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
config: arm-randconfig-r122-20260616 (https://download.01.org/0day-ci/archive/20260616/202606161921.OPkgBApm-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.1.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260616/202606161921.OPkgBApm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606161921.OPkgBApm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/dma/swiotlb.c: note: in included file (through include/linux/dma-direct.h):
>> include/linux/swiotlb.h:229:65: sparse: sparse: Using plain integer as NULL pointer
>> include/linux/swiotlb.h:229:65: sparse: sparse: Using plain integer as NULL pointer

vim +229 include/linux/swiotlb.h

   224	
   225	static inline bool is_zerocopy_swiotlb_folio(struct page *page)
   226	{
   227		struct folio *folio = page_folio(page);
   228	
 > 229		return folio_test_zcswiotlb(folio) && folio->private != 0;
   230	}
   231	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

