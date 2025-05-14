Return-Path: <netdev+bounces-190292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49DAB6107
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 05:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76ECD3A551E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ECC29D05;
	Wed, 14 May 2025 03:00:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3071F4ED;
	Wed, 14 May 2025 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747191653; cv=none; b=A6q6Z2hk7ySQESZgqAxK9i5qKcV7d5rb3iroSavdq0mb15pHrfL7WiWIFXVFDsdPy6B/vxcZehdQ1McRok+w2LNi3wTNXY+FSz8y61sFbasFtiN9auZmmpjCUA9WOWH9dEaXE34vtMjIqoEIhd40Zap65hzYzvzpUgFcRxZpZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747191653; c=relaxed/simple;
	bh=vX8mNa31YG9zmPqphOmHRm2XjzaN7O5/YoRb0FhDIVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttuXnJERibiw0gBMTSQyMFEsI9+fVYBe0WD+bbPF/ttj64ORxY6i+8ltPb47bKyN21tcEpwr63+FTBcI6YR0E8ZXMxLnklf5hW5lNjE9+2YlpFJX23FPv5+nb5vH8kEMdEGaF6Mwm6GS64THPKh+BNo8yUnyBOlk8fb76vA5no4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-65-6824075daadc
Date: Wed, 14 May 2025 12:00:40 +0900
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
Message-ID: <20250514030040.GA48035@system.software.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsXC9ZZnoW4su0qGwZdHKhZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLK4sK2P1eLy
	rjlsFvfW/Ge1OLZAzOLb6TeMFpcOP2KxWL/vBqvF7x9z2ByEPbasvMnksXPWXXaPBZtKPTav
	0PLounGJ2WPTqk42j02fJrF73Lm2h83jxIzfLB47d3xm8vj49BaLx/t9V9k8Pm+SC+CN4rJJ
	Sc3JLEst0rdL4Mpo27+JqWCLRMXSt2cZGxgvC3cxcnJICJhILL++jwnG3nD5LSOIzSKgKnF4
	6ytmEJtNQF3ixo2fQDYHh4iAo8TpH+ldjFwczAJ7mCUun50OVi8sECpx+lcDWD2vgIVEa1Mn
	C4gtJFAr8WbrNXaIuKDEyZlPwOLMAjoSO7feYQOZySwgLbH8HwdEWF6ieetssDGcQCfcO/id
	DcQWFVCWOLDtOBPIXgmBU+wSZx61skLcLClxcMUNlgmMgrOQrJiFZMUshBWzkKxYwMiyilEo
	M68sNzEzx0QvozIvs0IvOT93EyMwlpfV/onewfjpQvAhRgEORiUeXgtd5Qwh1sSy4srcQ4wS
	HMxKIrzXs4BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUa
	GKW4LINn7E8+9Mtl56R9mp/50yY43sl/M6csO9d8xcTbAQtlLtgfDpP7f7ykbPvSEA7r1DeK
	zE+ehAbFLdjamvOpKUatbokic1bx+XXvIhLcBB1UJKbISR9r1Hw9V+Pt4d0pC3IVpDcdFF4Y
	xd0WWr960hPGIKEHuU1xsspHfktdzVhycO+yUiWW4oxEQy3mouJEAHTBG17hAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXC5WfdrBvLrpJhMLGX12LO+jVsFqt/VFgs
	f7CD1eLLz9vsFosXfmO2mHO+hcXi6bFH7Bb3lz1jsdjTvp3ZorflN7NF044VTBaH555ktbiw
	rY/V4vKuOWwW99b8Z7U4tkDM4tvpN4wWlw4/YrFYv+8Gq8XvH3PYHEQ8tqy8yeSxc9Zddo8F
	m0o9Nq/Q8ui6cYnZY9OqTjaPTZ8msXvcubaHzePEjN8sHjt3fGby+Pj0FovH+31X2TwWv/jA
	5PF5k1wAXxSXTUpqTmZZapG+XQJXRtv+TUwFWyQqlr49y9jAeFm4i5GTQ0LARGLD5beMIDaL
	gKrE4a2vmEFsNgF1iRs3fgLZHBwiAo4Sp3+kdzFycTAL7GGWuHx2Oli9sECoxOlfDWD1vAIW
	Eq1NnSwgtpBArcSbrdfYIeKCEidnPgGLMwvoSOzceocNZCazgLTE8n8cEGF5ieats8HGcAKd
	cO/gdzYQW1RAWeLAtuNMExj5ZiGZNAvJpFkIk2YhmbSAkWUVo0hmXlluYmaOqV5xdkZlXmaF
	XnJ+7iZGYGQuq/0zcQfjl8vuhxgFOBiVeHgtdJUzhFgTy4orcw8xSnAwK4nwXs8CCvGmJFZW
	pRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTD2WHh9C3wbzdLdudD1
	5nmBgL8bX5hfc+6zkw4+VrExxfTD+s2xBQxv5h6XWXWma4rB+jBd6brCS5pbxfcJrtm4P+fO
	rquhNvu9WwMW1oUkei9qTHgmk7qKj31vWzaLftzz6AI3ybDnEsf7zs1qWb902pFtbB3SPC4M
	1Y81D/57utJ7/z+dV81KLMUZiYZazEXFiQD6qRSxyAIAAA==
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

Is this net-next you are mentioning?  I will rebase on this if so.

   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/

	Byungchul

> on, so I guess you'll pick it up there, put flagging it here just for
> completeness :)
> 
> -Toke
> 

