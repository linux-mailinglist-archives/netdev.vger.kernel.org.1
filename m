Return-Path: <netdev+bounces-183131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D9A8AFA8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 07:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC1817F9CB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 05:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7D228CA3;
	Wed, 16 Apr 2025 05:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10847E571
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781102; cv=none; b=Rw//+EhF1ly63JfhIn3m8NvZqLI5HHra6IE2fL5IKV+n6IZojk/wqdX4q3SWfzYcIsY2OwaiVcamvRjd2SL4u9s11qYVlAa1iZNKo5avA3UcdCiLOWYbAc6MKKOSNywQw5I8xAvdY0YJp1nSoUgKOgOwGzkvWmmlAO/FRShYC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781102; c=relaxed/simple;
	bh=0cfVMMf0wnMHXObDteJGX+7onz3AqXSrVjcJhiSVWxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwbNI5WrQth0xqz+WJzYh44m4BPTN3Fo12et3emiOvCQqtZB/6ED45Pyp0qDy/P6zauYACHhUhS337nZnho1QP9h7qLAqAWbPPhxAGXl2DgLXpe33YOA8Uhg/OVU+K/o3Qmz4Q4qIqhz4XSlTPt7JEqI4AoWdGougNSttk/URaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-90-67ff3f25994d
Date: Wed, 16 Apr 2025 14:24:48 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	netdev <netdev@vger.kernel.org>, willy@infradead.org,
	ilias.apalodimas@linaro.org, kernel_team@skhynix.com,
	42.hyeyoo@gmail.com, linux-mm@kvack.org
Subject: Re: [RFC] shrinking struct page (part of page pool)
Message-ID: <20250416052448.GB39145@system.software.com>
References: <20250414013627.GA9161@system.software.com>
 <CAHS8izO_9gXzj2sUubyNSQjp-a3h_332pQNRPBtW6bLOXS-XoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izO_9gXzj2sUubyNSQjp-a3h_332pQNRPBtW6bLOXS-XoA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXC9ZZnka6q/f90g95vAhYTewwsVv+osNjT
	vp3ZorflN7PFvTX/WS2OLRCz+P1jDpsDu8fOWXfZPRZsKvXYvELLY9OqTjaPTZ8msXvcubaH
	zePzJrkA9igum5TUnMyy1CJ9uwSujKunV7MUTJCrWHH4F3MD4zGxLkZODgkBE4nfW38ydzFy
	gNm375SAhFkEVCUmzGpjBLHZBNQlbtwAKeHkEBHQlFiybyJrFyMXB7PAcUaJ/xe+sIIkhAVs
	JLb/mAtm8wpYSDRPW80CYgsJ1Em0Lf/GCBEXlDg58wlYnBlo6J95l8D2MgtISyz/xwERlpdo
	3jobbBenQKDEmyWTwEaKCihLHNh2nAni5CNsEksOGELYkhIHV9xgmcAoOAvJhllINsxC2DAL
	yYYFjCyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQJjYlntn+gdjJ8uBB9iFOBgVOLhjYj/ly7E
	mlhWXJl7iFGCg1lJhPecOVCINyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTEktTs1NSC
	1CKYLBMHp1QDY/cTv20TnkpJM3fKJDoHGk2ak/dis9bjCSFbFjlss82QT4vUbppyfqt8Tfox
	3lD+Ux+ruS8FCzGdzujduTgoR1mF73OYR5rXli3SJzRuvzrzSCCr2Kn97MKMDx/tima83rZo
	XXuMhZOK1+S3gW/m75y/Z4tTc2MM7wmHjrkMTO2HfTbbeWzuU2Ipzkg01GIuKk4EALktWXGF
	AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXC5WfdrKtq/z/d4PZnFouJPQYWq39UWOxp
	385s0dvym9ni8NyTrBb31vxntTi2QMzi9485bA4cHjtn3WX3WLCp1GPzCi2PTas62Tw2fZrE
	7nHn2h42j8UvPjB5fN4kF8ARxWWTkpqTWZZapG+XwJVx9fRqloIJchUrDv9ibmA8JtbFyMEh
	IWAicftOSRcjJweLgKrEhFltjCA2m4C6xI0bP5lBbBEBTYkl+yaydjFycTALHGeU+H/hCytI
	QljARmL7j7lgNq+AhUTztNUsILaQQJ1E2/JvjBBxQYmTM5+AxZmBhv6Zd4kZZC+zgLTE8n8c
	EGF5ieats8F2cQoESrxZMglspKiAssSBbceZJjDyzUIyaRaSSbMQJs1CMmkBI8sqRpHMvLLc
	xMwcU73i7IzKvMwKveT83E2MwBBfVvtn4g7GL5fdDzEKcDAq8fBGxP9LF2JNLCuuzD3EKMHB
	rCTCe84cKMSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cCo
	/7Nj5WT7H1MtBHZMXLDxjsDBxeXRTftNjX6ovnL6+4Vjkvx9g7bzxi/F1l647G1wUXN7WrV9
	9G/J2bp7bYry3eZ1GH8+N4e3rNcpTCq2SW/hjej9aqF2vx5nLVCyWrtGwkXdccv6vy79VVP3
	B+9dzrymazJDt0ybaGCulrjswYszdrcLOzEqsRRnJBpqMRcVJwIAO4/QT20CAAA=
X-CFilter-Loop: Reflected

On Tue, Apr 15, 2025 at 08:39:47AM -0700, Mina Almasry wrote:
> On Sun, Apr 13, 2025 at 6:36 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > Hi guys,
> >
> > I'm looking at network's page pool code to help 'shrinking struct page'
> > project by Matthew Wilcox.  See the following link:
> >
> >    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> >
> > My first goal is to remove fields for page pool from struct page like:
> >
> 
> Remove them, but put them where? The page above specificies "Split the

We need to introduce a new struct that will be used as a new descriptor
e.g. bump, instead of struct page, similar to net_iov, overlaying struct
page for now.

> pagepool bump allocator out of struct page, as has been done for, eg,
> slab and ptdesc.", but I'm not familiar what happened with slab and
> ptdesc. Are these fields moving to a different location? Or being

Move to the newly introduced struct e.g. bump and temporarily let it
overlay struct page for now.

> somehow removed entirely?

And then we can remove the fields from struct page.

> >    struct {     /* page_pool used by netstack */
> >         /**
> >          * @pp_magic: magic value to avoid recycling non
> >          * page_pool allocated pages.
> >          */
> >         unsigned long pp_magic;
> >         struct page_pool *pp;
> >         unsigned long _pp_mapping_pad;
> >         unsigned long dma_addr;
> >         atomic_long_t pp_ref_count;
> >    };
> >
> > Fortunately, many prerequisite works have been done by Mina but I guess
> > he or she has done it for other purpose than 'shrinking struct page'.
> >
> 
> Yeah, we did it to support non-page memory in the net stack, which is
> quite orthogonal to what you're trying to do AFAICT so far. Looks like
> maybe some implementation details are shared by luck?

Oh.

> > I'd like to just finalize the work so that the fields above can be
> > removed from struct page.  However, I need to resolve a curiousity
> > before starting.
> >
> >    Network guys already introduced a sperate strcut, struct net_iov,
> >    to overlay the interesting fields.  However, another separate struct
> >    for system memory might be also needed e.g. struct bump so that
> >    struct net_iov and struct bump can be overlayed depending on the
> >    source:
> >
> >    struct bump {
> >         unsigned long _page_flags;
> >         unsigned long bump_magic;
> >         struct page_pool *bump_pp;
> >         unsigned long _pp_mapping_pad;
> >         unsigned long dma_addr;
> >         atomic_long_t bump_ref_count;
> >         unsigned int _page_type;
> >         atomic_t _refcount;
> >    };
> >
> > To netwrok guys, any thoughts on it?
> 
> Need more details. What does struct bump represent? If it's meant to

'bump' comes from how page pool works.  See the following link:

   https://en.wikipedia.org/wiki/Region-based_memory_management

However, any better name suggestion from network guys should be
appreciated.

> replace the fields used by the page_pool referenced above, then it
> should not have _page_flags, bump_ref_count should be pp_ref_count,
> and should not have _page_type or _refcount.

These are place holders that might be needed for now but should be
removed later.

> > To Willy, do I understand correctly your direction?
> >
> > Plus, it's a quite another issue but I'm curious, that is, what do you
> > guys think about moving the bump allocator(= page pool) code from
> > network to mm?  I'd like to start on the work once gathering opinion
> > from both Willy and network guys.
> >
> 
> What is the terminology "bump"? Are you wanting to rename page_pool to
> "bump"? What does the new name mean?

I hope the link above explain it.

	Byungchul

> 
> -- 
> Thanks,
> Mina

