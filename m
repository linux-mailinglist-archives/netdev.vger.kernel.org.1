Return-Path: <netdev+bounces-274814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDdnAxISz2nXsgYAu9opvQ
	(envelope-from <netdev+bounces-274814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F838FCD6
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F28ED30229D6
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA51270575;
	Fri,  3 Apr 2026 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z/MxJZPP"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217178F3A
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178244; cv=none; b=bIVClfHzSEaGQMYwUmOd+RjLCWcjjBZXl6Kzk6LIxJEqjEkpBgSEhsJFJwaBbJKVCgyy4F9ZxSjPkjyNfGItF3NB/1eabcF8IGib4+l7Fzt+IUdT/QMAggg1M3pRMKLU+93vuy38XprJm8J9YJ1N2+J9OriiYrolyjKJgc3kw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178244; c=relaxed/simple;
	bh=1LdY924vImLVp8wuouo5L+CLn7ldDb4dU8H3KLLBkFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xkjrp/2v07U7GaTgok6CjLnmDBVbcB3+IEPovJEmdCVRDK72f90N9rNGCXMsmuA1hW029f8bTXywas2O9w9WsTrEebBXK7pg+6z/E3ldq42Ip8IUEocCmB1xe/+nhWG8W6Ix7wHVlPWJd2FuttDiNpab0mUqhlZ/tomBycuaDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z/MxJZPP; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 2 Apr 2026 18:03:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775178230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=53BQQ0sHBNvn674bx/yqTRF2ETsE2dMIOa2LRdAyEbE=;
	b=Z/MxJZPPnsX8EwiAvUnTfqMgeFGfJRCzrXPTm8DTel/l7vcNI33UAbPJY/rnSxrwBZwfD6
	qi+IXFa4TWtZcl70sQi+mYuc+Aupau0+ryjaj6kb9uWyJ4qmh17WH9eFz/PFvdDB0BWnZb
	r/U5c7QJdQE+LDZMppnM17iGrgepiHw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, willy@infradead.org, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	kasong@tencent.com, qi.zheng@linux.dev, baohua@kernel.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, riel@surriel.com, kuba@kernel.org, 
	edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm/vmpressure: skip socket pressure for costly order
 reclaim
Message-ID: <ac8DEuZhb_aQA4ez@linux.dev>
References: <20260402232511.17246-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402232511.17246-1-jp.kobryn@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274814-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: A53F838FCD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 04:25:11PM -0700, JP Kobryn (Meta) wrote:
> When kswapd reclaims at high order due to fragmentation,

* kswapd is woken up for the higher order reclaim request

But this can be direct reclaim as well.

> vmpressure() can
> report poor reclaim efficiency even though the system has plenty of free
> memory. This is because kswapd scans many pages but finds little to reclaim
> - the pages are actively in use and don't need to be freed. The resulting
> scan:reclaim ratio triggers socket pressure, throttling TCP throughput
> unnecessarily.
> 
> Net allocations do not exceed order 3 (PAGE_ALLOC_COSTLY_ORDER),

Net not doing costly order allocations is irrelevant here. IIUC you want all
costly order allocations (like THPs) to not raise vmpressure as those don't
necessarily represents the memory pressure.

> so high
> order reclaim difficulty should not trigger socket pressure. The kernel
> already treats this order as the boundary where reclaim is no longer
> expected to succeed and compaction may take over.
> 
> Make vmpressure() order-aware through an additional parameter sourced from
> scan_control at existing call sites. Socket pressure is now only asserted
> when order <= PAGE_ALLOC_COSTLY_ORDER.
> 
> Memcg reclaim is unaffected since try_to_free_mem_cgroup_pages() always
> uses order 0, which passes the filter unconditionally. Similarly,
> vmpressure_prio() now passes order 0 internally when calling vmpressure(),
> ensuring critical pressure from low reclaim priority is not suppressed by
> the order filter.
> 
> Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>

The patch looks good. I think we can ask Andrew to just adjust the commit
message and then you don't need to resend.

Moving networking stack away from vmpressure in my plan for a long time and this
tells me I should get to it sooner.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


