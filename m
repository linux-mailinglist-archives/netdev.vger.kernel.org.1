Return-Path: <netdev+bounces-105483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B09115D8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 00:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E17ABB21F76
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F8A13D278;
	Thu, 20 Jun 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnjQCVbi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8813C8E5;
	Thu, 20 Jun 2024 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923707; cv=none; b=rl+8XRSEDMVTGB7YU5a/NwMXbPmbY/RSQtJxJ5QMlWf4n+7ZORZRwNTgrsvK1qMA/p682Ygj6AvWticUJtCFE4zNl374LgaJrIUKbWK8p+Z/hK2QO2lYmblpgUJbSzFyPVQq8HBR/VJxFDYnFSsc2XsKkkqNDliqgyQOBo8cLKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923707; c=relaxed/simple;
	bh=zoovoJhNRfgDjC9B72bTorp2/szLX092n+btLcuuqSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSt6S+NO9rFmUwPS2Xwa8HrOkpf8qHAZkvUhF4+e5Ai6pSDCw4iE5H/XGYlxsZyXFAtccKw/BLzbJR6OXVmmoIMlPJV/lfW8VOwQCmbPlK38DlAPvd/cS8jtvSyrdOs5ew4A7JQbNfSCCPoXzRYiyW+35dAn4kvdw6nfww106Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnjQCVbi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718923706; x=1750459706;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zoovoJhNRfgDjC9B72bTorp2/szLX092n+btLcuuqSU=;
  b=hnjQCVbiGaHSN02uY5HLtVBUE01Qn9B/9Nup2NHjXz4OYPY2E9DI3gO5
   mrv9SwC/fqeC+5seN9yl43+/p0ImfLNKffOWuHCLIN2EWZynRijjJqFG6
   lrU7/bxTBUgFpBhWsJsmH9aJBioUET4zBDwwYhnecKBxnCzW6iGAI1BCr
   BKSBwu7mtFtyP6BjaLUUOac9sATXpnrg9Tw1ktcoPwNAABWYuCULKDBKJ
   wHMiSJnkLkfKi/ixNedmBk5MQ3Wam8ujPqbzJeC9CyJBHbiy1ZSHCXx40
   BxSD1CothIfxNn+uzTSCsUeUCW9j9b/9ScBUadMIZIPiNyMv6KB8Va8nJ
   Q==;
X-CSE-ConnectionGUID: gyIUlsTtR1ubTVyXc4MaQw==
X-CSE-MsgGUID: zaJQlcAKTNSP76m3uzGGNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15767076"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15767076"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:48:25 -0700
X-CSE-ConnectionGUID: XpaLxycjSxeqMiVY+nQ8Bw==
X-CSE-MsgGUID: nKLgFteISSeH3bWw+T/wLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42506433"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmviesa010.fm.intel.com with ESMTP; 20 Jun 2024 15:48:24 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 537703003B6; Thu, 20 Jun 2024 15:48:24 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,  "GONG, Ruiqi"
 <gongruiqi@huaweicloud.com>,  Christoph Lameter <cl@linux.com>,  Pekka
 Enberg <penberg@kernel.org>,  David Rientjes <rientjes@google.com>,
  Joonsoo Kim <iamjoonsoo.kim@lge.com>,  jvoisin
 <julien.voisin@dustri.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Roman Gushchin <roman.gushchin@linux.dev>,  Hyeonggon Yoo
 <42.hyeyoo@gmail.com>,  Xiu Jianfeng <xiujianfeng@huawei.com>,  Suren
 Baghdasaryan <surenb@google.com>,  Kent Overstreet
 <kent.overstreet@linux.dev>,  Jann Horn <jannh@google.com>,  Matteo Rizzo
 <matteorizzo@google.com>,  Thomas Graf <tgraf@suug.ch>,  Herbert Xu
 <herbert@gondor.apana.org.au>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-hardening@vger.kernel.org,
  netdev@vger.kernel.org
Subject: Re: [PATCH v5 4/6] mm/slab: Introduce kmem_buckets_create() and family
In-Reply-To: <20240619193357.1333772-4-kees@kernel.org> (Kees Cook's message
	of "Wed, 19 Jun 2024 12:33:52 -0700")
References: <20240619192131.do.115-kees@kernel.org>
	<20240619193357.1333772-4-kees@kernel.org>
Date: Thu, 20 Jun 2024 15:48:24 -0700
Message-ID: <87r0crut6v.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <kees@kernel.org> writes:

> Dedicated caches are available for fixed size allocations via
> kmem_cache_alloc(), but for dynamically sized allocations there is only
> the global kmalloc API's set of buckets available. This means it isn't
> possible to separate specific sets of dynamically sized allocations into
> a separate collection of caches.
>
> This leads to a use-after-free exploitation weakness in the Linux
> kernel since many heap memory spraying/grooming attacks depend on using
> userspace-controllable dynamically sized allocations to collide with
> fixed size allocations that end up in same cache.
>
> While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> against these kinds of "type confusion" attacks, including for fixed
> same-size heap objects, we can create a complementary deterministic
> defense for dynamically sized allocations that are directly user
> controlled. Addressing these cases is limited in scope, so isolating these
> kinds of interfaces will not become an unbounded game of whack-a-mole. For
> example, many pass through memdup_user(), making isolation there very
> effective.

Isn't the attack still possible if the attacker can free the slab page
during the use-after-free period with enough memory pressure?

Someone else might grab the page that was in the bucket for another slab
and the type confusion could hurt again.

Or is there some other defense against that, other than
CONFIG_DEBUG_PAGEALLOC or full slab poisoning? And how expensive
does it get when any of those are enabled?

I remember reading some paper about a apple allocator trying similar
techniques and it tried very hard to never reuse memory (probably
not a good idea for Linux though)

I assume you thought about this, but it would be good to discuss such
limitations and interactions in the commit log.

-Andi

