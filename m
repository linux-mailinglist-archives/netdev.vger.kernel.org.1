Return-Path: <netdev+bounces-189754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA73AB37EC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B570D8618A0
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFF3293759;
	Mon, 12 May 2025 12:55:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6083C293B6D;
	Mon, 12 May 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054517; cv=none; b=sd5XAD4RWbtNcv9LuVgjgq678Cm5/59asG2/aFLS/zf494XKwqeE7/EINd6Xug6GOIyD3oOKWo6jpsc/VshGcZF9KTBLP6Ula6/rxyr7FrwAe4shVZ67OrxrI1HvOjhmvDNsFW6evC9yUXw6lW5YoxIO7bPDImWzf4tmcb1AtN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054517; c=relaxed/simple;
	bh=JZK5oFWObg94lBWmpshd/yy6m2fsIFigEGBxlOLncrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V643j9v2EGoyq4s2LJjd4NtersVSBKA0oxzIFUfcLai9X9X2N9bAYWiDtTWkJLCQyQT1YyfmaqKBkXHJvVqtm/DomIdvuMwz4oFGOmsbFLCNWu2Lub7eenrPoIfLLuXBt68KqAw4UyZ4/YhNBkhG4sgj+KoX0tSbAtZdabolzq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-41-6821efb0d2f7
Date: Mon, 12 May 2025 21:55:06 +0900
From: Byungchul Park <byungchul@sk.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, john.fastabend@gmail.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: Re: [RFC 13/19] page_pool: expand scope of is_pp_{netmem,page}() to
 global
Message-ID: <20250512125506.GD45370@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-14-byungchul@sk.com>
 <87y0v22dzn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0v22dzn.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsXC9ZZnke6G94oZBkdvcVjMWb+GzWL1jwqL
	5Q92sFp8+Xmb3WLxwm/MFnPOt7BYPD32iN3i/rJnLBZ72rczW/S2/Ga2aNqxgsniwrY+VovL
	u+awWdxb85/V4tgCMYtvp98wWlw6/IjFYv2+G6wWv3/MYXMQ9tiy8iaTx85Zd9k9Fmwq9di8
	Qsuj68YlZo9NqzrZPDZ9msTucefaHjaPEzN+s3js3PGZyePj01ssHu/3XWXz+LxJLoA3issm
	JTUnsyy1SN8ugStj0ZPKgoPiFVfu7GduYPwg1MXIySEhYCIx9/QLVhh72uTJTCA2i4CqRP/9
	k4wgNpuAusSNGz+Zuxg5OEQEHCVO/0jvYuTiYBbYwyxx+ex0sBphgVCJ078amEFsXgELid1z
	J4DZQgK1Em+2XmOHiAtKnJz5hAXEZhbQkdi59Q4byExmAWmJ5f84IMLyEs1bZ4O1cgKdcO/g
	dzYQW1RAWeLAtuNMIHslBE6xS1y908ACcbOkxMEVN1gmMArOQrJiFpIVsxBWzEKyYgEjyypG
	ocy8stzEzBwTvYzKvMwKveT83E2MwEheVvsnegfjpwvBhxgFOBiVeHhPvFTMEGJNLCuuzD3E
	KMHBrCTC27gdKMSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNT
	qoGRt7fpyY+/nQ8djtirs7Ddjbl3taUzaRmb563tz83jS2V5p8oe/SfFUZXv9blm5dS6Wa+O
	/L+4RU7mA3/Pq9mbufoPrpjJM2UxC6OL/34nFdlTRx53eMcJye5aOu+2n8gWdZ6FTyS6Hq3e
	cX33zZBlgXzegfJTvkxakjpn0jKzEJWT1kvCGL94KLEUZyQaajEXFScCADsTC0DgAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsXC5WfdrLv+vWKGweR5phZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLI4PPckq8WF
	bX2sFpd3zWGzuLfmP6vFsQViFt9Ov2G0uHT4EYvF+n03WC1+/5jD5iDisWXlTSaPnbPusnss
	2FTqsXmFlkfXjUvMHptWdbJ5bPo0id3jzrU9bB4nZvxm8di54zOTx8ent1g83u+7yuax+MUH
	Jo/Pm+QC+KK4bFJSczLLUov07RK4MhY9qSw4KF5x5c5+5gbGD0JdjJwcEgImEtMmT2YCsVkE
	VCX6759kBLHZBNQlbtz4ydzFyMEhIuAocfpHehcjFwezwB5mictnp4PVCAuESpz+1cAMYvMK
	WEjsnjsBzBYSqJV4s/UaO0RcUOLkzCcsIDazgI7Ezq132EBmMgtISyz/xwERlpdo3jobrJUT
	6IR7B7+zgdiiAsoSB7YdZ5rAyDcLyaRZSCbNQpg0C8mkBYwsqxhFMvPKchMzc0z1irMzKvMy
	K/SS83M3MQLjclntn4k7GL9cdj/EKMDBqMTDe+KlYoYQa2JZcWXuIUYJDmYlEd7G7UAh3pTE
	yqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGRt6dm05vcOxluWEk
	tDlhfr/Ni938+48silm9juGT6QeN24cVLtzSU9DjvaxxxU1p6Q8/9scaV5KMttpP/30nZV6R
	VmV9VUkin3noispMqWf+hQwWd0znC29hsDCU+Hn1RcvZ3het0qsfpcXWMl4QWhRyRPD8FHUv
	4y+rG0UuzTv+q2rNrG/XfZRYijMSDbWYi4oTAf8CLeTHAgAA
X-CFilter-Loop: Reflected

On Mon, May 12, 2025 at 02:46:36PM +0200, Toke Høiland-Jørgensen wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Other than skbuff.c might need to check if a page or netmem is for page
> > pool, for example, page_alloc.c needs to check the page state, whether
> > it comes from page pool or not for their own purpose.
> >
> > Expand the scope of is_pp_netmem() and introduce is_pp_page() newly, so
> > that those who want to check the source can achieve the checking without
> > accessing page pool member, page->pp_magic, directly.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  include/net/page_pool/types.h |  2 ++
> >  net/core/page_pool.c          | 10 ++++++++++
> >  net/core/skbuff.c             |  5 -----
> >  3 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> > index 36eb57d73abc6..d3e1a52f01e09 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -299,4 +299,6 @@ static inline bool is_page_pool_compiled_in(void)
> >  /* Caller must provide appropriate safe context, e.g. NAPI. */
> >  void page_pool_update_nid(struct page_pool *pool, int new_nid);
> >  
> > +bool is_pp_netmem(netmem_ref netmem);
> > +bool is_pp_page(struct page *page);
> >  #endif /* _NET_PAGE_POOL_H */
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index b61c1038f4c68..9c553e5a1b555 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -1225,3 +1225,13 @@ void net_mp_niov_clear_page_pool(struct netmem_desc *niov)
> >  
> >  	page_pool_clear_pp_info(netmem);
> >  }
> > +
> > +bool is_pp_netmem(netmem_ref netmem)
> > +{
> > +	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
> > +}
> > +
> > +bool is_pp_page(struct page *page)
> > +{
> > +	return is_pp_netmem(page_to_netmem(page));
> > +}
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 6cbf77bc61fce..11098c204fe3e 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -893,11 +893,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
> >  		skb_get(list);
> >  }
> >  
> > -static bool is_pp_netmem(netmem_ref netmem)
> > -{
> > -	return (netmem_get_pp_magic(netmem) & ~0x3UL) == PP_SIGNATURE;
> > -}
> > -
> 
> This has already been moved to mm.h (and the check changed) by commit:
> 
> cd3c93167da0 ("page_pool: Move pp_magic check into helper functions")
> 
> You should definitely rebase this series on top of that (and the
> subsequent ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap
> them when destroying the pool")), as these change the semantics of how
> page_pool interacts with struct page.
> 
> Both of these are in net-next, which Mina already asked you to rebase
> on, so I guess you'll pick it up there, put flagging it here just for
> completeness :)

I will not miss it.  Thanks.

	Byungchul
> 
> -Toke
> 

