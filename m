Return-Path: <netdev+bounces-183219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED09A8B6A4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9313AA0AB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931482459D7;
	Wed, 16 Apr 2025 10:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCA02417EF
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798829; cv=none; b=tBb6pufDZtZRwju5+kz/NZDP8WkRDLjlkF7E5qdn5SIVzZdTyx3Iz5foAol3vCg04L8Xur6SqiofMadMUziRTF7kEbVkAbS2FNZcNS0rRI+HTChQmoTaJ1KuNaJo3IwxVhRu7XzPyQjmvLZo0zl801GAAacF3HTQH2t0v+0MVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798829; c=relaxed/simple;
	bh=v08iT7nLrXY1m+7NkyJo8rZEFMUUUlTKmYi3g4MRK3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN277NlVR36/OX5y7XefPB2aolB8JO2OqDBoPKSFGXMUgfVWrMpS2FkJEhiTBaj14L6Y2lLih5/zN6Xxu/uEQra9NgBQGXSDtioT6Qajijtx35KJdR620sqKGhLHn9LNRdu3CwOslKouPKiPs/zwB1O8C3rC8dGBssorCbRxyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-21-67ff8464fd92
Date: Wed, 16 Apr 2025 19:20:15 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: willy@infradead.org, ilias.apalodimas@linaro.org,
	almasrymina@google.com, kernel_team@skhynix.com,
	42.hyeyoo@gmail.com, linux-mm@kvack.org, hawk@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC] shrinking struct page (part of page pool)
Message-ID: <20250416102015.GA5520@system.software.com>
References: <20250414013627.GA9161@system.software.com>
 <20250414015207.GA50437@system.software.com>
 <20250414163002.166d1a36@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414163002.166d1a36@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXC9ZZnoW5Ky/90gw27NC0m9hhYrP5RYbGn
	fTuzRW/Lb2aLC9v6WC3urfnPanFsgZjF7x9z2Bw4PHbOusvusWBTqcfmFVoem1Z1snls+jSJ
	3ePOtT1sHp83yQWwR3HZpKTmZJalFunbJXBl/Gnfy1hwWKDicM8F5gbGCzxdjJwcEgImEh3t
	M5hh7PbGf0wgNouAqsTdZd1gcTYBdYkbN36C2SICKhItm2eydDFycTAL7GWUuDL/BlhCWMBG
	YvuPuawgNq+AucSDnUfZQYqEBHoZJaZcvsICkRCUODnzCZjNLKAlcePfS6BtHEC2tMTyfxwg
	YU4BQ4lbj/rYQGxRAWWJA9uOM4HMkRDYwyax9cFPVohLJSUOrrjBMoFRYBaSsbOQjJ2FMHYB
	I/MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMCQX1b7J3oH46cLwYcYBTgYlXh4I+L/pQuxJpYV
	V+YeYpTgYFYS4T1nDhTiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgm
	y8TBKdXAmHxY7m7goRS2RwmXYlVqbCa9D1Ip2S+z/ujnLq7C1Oa2Fh/Fd1N6JvDwf/5fltf4
	/Efi0vKmixbGR18V5WQ1tX1NevqzMeBOfOvNTQuEX36uN5P0XpXevUte24/D7o1GyZx7Mv2c
	AiXf3I5fz9L+/HL7xODF6VeCHV79s79V72L0pex2lEyvEktxRqKhFnNRcSIAVL83BHUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC5WfdrJvS8j/d4FGfnMXEHgOL1T8qLPa0
	b2e26G35zWxxeO5JVosL2/pYLe6t+c9qcWyBmMXvH3PYHDg9ds66y+6xYFOpx+YVWh6bVnWy
	eWz6NInd4861PWwei198YPL4vEkugCOKyyYlNSezLLVI3y6BK+NP+17GgsMCFYd7LjA3MF7g
	6WLk5JAQMJFob/zHBGKzCKhK3F3WzQxiswmoS9y48RPMFhFQkWjZPJOli5GLg1lgL6PElfk3
	wBLCAjYS23/MZQWxeQXMJR7sPMoOUiQk0MsoMeXyFRaIhKDEyZlPwGxmAS2JG/9eAm3jALKl
	JZb/4wAJcwoYStx61McGYosKKEsc2HacaQIj7ywk3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84
	O6MyL7NCLzk/dxMjMICX1f6ZuIPxy2X3Q4wCHIxKPLwR8f/ShVgTy4orcw8xSnAwK4nwnjMH
	CvGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTByiJx63FPC
	Lp7ous/5rsGSwiN9CkZnZ5ktCPvzMf5/9fxFT2Zse9qWz8Npk1wo+3yzks+k8pcREmIPnV97
	OHTZBnCaT/OyuDL9sOrvf8pLDbbXsz0xYbHoEtberuRs3Hf2U0vCoXjHrVtsTi5zEao70bDD
	y1fTj3niM4P9E2bO3FOt/3b9ollKLMUZiYZazEXFiQA/WoffXAIAAA==
X-CFilter-Loop: Reflected

On Mon, Apr 14, 2025 at 04:30:02PM -0700, Jakub Kicinski wrote:
> On Mon, 14 Apr 2025 10:52:07 +0900 Byungchul Park wrote:
> > > Fortunately, many prerequisite works have been done by Mina but I guess
> > > he or she has done it for other purpose than 'shrinking struct page'.
> > > 
> > > I'd like to just finalize the work so that the fields above can be
> > > removed from struct page.  However, I need to resolve a curiousity
> > > before starting.
> 
> I don't understand what the question is but FWIW from my perspective
> the ZC APIs are fairly contained, or at least we tried to make sure
> that net_iov pages cannot reach random parts of the stack.
> 
> Replacing all uses of struct page would require converting much more
> of the stack, AFAIU. But that's best discussed over posted patches.

Okay.  Let's discuss it once posting patches.

> > >    Network guys already introduced a sperate strcut, struct net_iov,
> > >    to overlay the interesting fields.  However, another separate struct
> > >    for system memory might be also needed e.g. struct bump so that
> > >    struct net_iov and struct bump can be overlayed depending on the
> > >    source:
> > > 
> > >    struct bump {
> > > 	unsigned long _page_flags;
> > > 	unsigned long bump_magic;
> > > 	struct page_pool *bump_pp;
> > > 	unsigned long _pp_mapping_pad;
> > > 	unsigned long dma_addr;
> > > 	atomic_long_t bump_ref_count;
> > > 	unsigned int _page_type;
> > > 	atomic_t _refcount;
> > >    };
> > > 
> > > To netwrok guys, any thoughts on it?
> > > To Willy, do I understand correctly your direction?
> > > 
> > > Plus, it's a quite another issue but I'm curious, that is, what do you
> > > guys think about moving the bump allocator(= page pool) code from
> > > network to mm?  I'd like to start on the work once gathering opinion
> > > from both Willy and network guys.
> 
> I don't see any benefit from moving page pool to MM. It is quite
> networking specific. But we can discuss this later. Moving code
> is trivial, it should not be the initial focus.

I think so.

	Byungchul

