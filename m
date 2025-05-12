Return-Path: <netdev+bounces-189756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F0AB37F4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E671E7A1245
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65429375C;
	Mon, 12 May 2025 12:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7431EB3D;
	Mon, 12 May 2025 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054708; cv=none; b=Bh0RIY4CKpx09pAuU9lU5A1jqraR9B/OonUz1pwMv3K0HpPPXfAoWJ9GbZB4byWxzxAhJ3d7EfbT/Gx0aPQVP1oO1nckmIC6brqhdQuwzEgFqlSdKBZKZzxmHe/FS5Mdm41Qg2V1b+sOV+6DqsGTbgXGlOPAvQGroqsPswLILcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054708; c=relaxed/simple;
	bh=5682P/V1yDxx7hI8HSB8iUFfbhIQqqzTSuLza0F69jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liG+JRac4Y4oXlED+kFOJNPp08A9X9BX7apq33FBwdOWWGRX5kvpn1dQafMhbiVFvLiWwFty+Zb7Bi0OEsa8toOd+GWTAT2+fJ9zGqCowSvIfXnysBPyVXyzvd+AQV2UepxwYaytdROi0ewDDyYho1xXl2axu8oXtfMMRqk3fI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-13-6821f067eaad
Date: Mon, 12 May 2025 21:58:10 +0900
From: Byungchul Park <byungchul@sk.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct
 page
Message-ID: <20250512125810.GE45370@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-20-byungchul@sk.com>
 <CAC_iWj+vweve6V33cqHGZ6tSehs85vXd7VKAGNiEjLoK2pc+PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+vweve6V33cqHGZ6tSehs85vXd7VKAGNiEjLoK2pc+PQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsXC9ZZnkW7GB8UMg6YDnBZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLK4sK2P1eLy
	rjlsFvfW/Ge1OLZAzOLb6TeMFuv33WC1+P1jDpuDkMeWlTeZPHbOusvusWBTqcfmFVoeXTcu
	MXtsWtXJ5rHp0yR2jzvX9rB5nJjxm8Vj547PTB4fn95i8Xi/7yqbx+dNcgG8UVw2Kak5mWWp
	Rfp2CVwZh6/vZSr4K1jx4dsXpgbGY7xdjJwcEgImEisWrWWGsT/8+sEGYrMIqEos/XuUFcRm
	E1CXuHHjJ1ANB4eIgJHE3YPVXYxcHMwCc5klZn2cygRSIywQJDH58UN2EJtXwELi4NXb7CBF
	QgIrGSWOvO1mg0gISpyc+YQFxGYW0JK48e8lE8hQZgFpieX/OEDCnAKBEj8XnQW7R1RAWeLA
	tuNMIHMkBPaxS3Q+3s0IcaikxMEVN1gmMArMQjJ2FpKxsxDGLmBkXsUolJlXlpuYmWOil1GZ
	l1mhl5yfu4kRGJPLav9E72D8dCH4EKMAB6MSD++Jl4oZQqyJZcWVuYcYJTiYlUR4G7cDhXhT
	EiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgskycXBKNTCyKeUySk3u9Rb/
	kx8rfP/exTu2p//d4d5zfMm681n2f+4rZWW+q5zUseJuJ/+SudPOXdixu0dt48TysCvyz+rr
	fUWkrGaLfdMwzGc7vOd/r+2BqugK84N7XsXNYz0Rkbsxe314rOelYxzXZi/kkXxXlPx+i+Tz
	wI4f/yxdy/X2LY0xfF35kvWLEktxRqKhFnNRcSIA5d6Zd8UCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXC5WfdrJv+QTHDYM4Ec4s569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK+Pw9b1MBX8FKz58+8LUwHiMt4uRk0NCwETiw68fbCA2i4CqxNK/
	R1lBbDYBdYkbN34ydzFycIgIGEncPVjdxcjFwSwwl1li1sepTCA1wgJBEpMfP2QHsXkFLCQO
	Xr3NDlIkJLCSUeLI2242iISgxMmZT1hAbGYBLYkb/14ygQxlFpCWWP6PAyTMKRAo8XPRWWYQ
	W1RAWeLAtuNMExh5ZyHpnoWkexZC9wJG5lWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBEbas
	9s/EHYxfLrsfYhTgYFTi4T3xUjFDiDWxrLgy9xCjBAezkghv43agEG9KYmVValF+fFFpTmrx
	IUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA2NobY18zNmgMzbKPU4mvFpSRplOAjwc
	Bn+unpy+Y2W7W/t6tcrDD914/1VaS1c8XX9ebMYehZLyYr45t0P2L9n/JV4u5e/tk1xBef+O
	e4bwzJ97ZQdj++EdK3ZPOLpQ9vQxRufbN8Li963fNdGoIYxfNkxjakyG4U6DyFMK5/bvONOw
	LnaCyi4lluKMREMt5qLiRADkUyCsrAIAAA==
X-CFilter-Loop: Reflected

On Sat, May 10, 2025 at 10:26:00AM +0300, Ilias Apalodimas wrote:
> Hi Byungchul
> 
> On Fri, 9 May 2025 at 14:51, Byungchul Park <byungchul@sk.com> wrote:
> >
> > Now that all the users of the page pool members in struct page have been
> > gone, the members can be removed from struct page.  However, the space
> > in struct page needs to be kept using a place holder with the same size,
> > until struct netmem_desc has its own instance, not overlayed onto struct
> > page, to avoid conficting with other members within struct page.
> >
> 
> FWIW similar mirroring was intially proposed [0] a few years ago
> 
> > Remove the page pool members in struct page and replace with a place
> > holder.  The place holder should be removed once struct netmem_desc has
> > its own instance.
> 
> instance? To make sure I understand this, the netmem_descs are
> expected to be allocated in the future right?

Yes.

> [...]
> 
> > -
> >  static inline struct net_iov_area *net_iov_owner(const struct netmem_desc *niov)
> >  {
> >         return niov->owner;
> > diff --git a/include/net/netmem_type.h b/include/net/netmem_type.h
> > new file mode 100644
> > index 0000000000000..6a3ac8e908515
> > --- /dev/null
> > +++ b/include/net/netmem_type.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + *     Author: Byungchul Park <max.byungchul.park@gmail.com>
> 
> Shouldn't Minas authorship be preserved here?

Ah.  I dunno what I'm supposed to do in the case.  I will remove the
author part :) if it's still okay.

	Byungchul

> > + */
> > +
> > +#ifndef _NET_NETMEM_TYPE_H
> > +#define _NET_NETMEM_TYPE_H
> > +
> > +#include <linux/stddef.h>
> > +
> > +struct netmem_desc {
> > +       unsigned long __unused_padding;
> > +       struct_group_tagged(__netmem_desc, actual_data,
> > +               unsigned long pp_magic;
> > +               struct page_pool *pp;
> > +               struct net_iov_area *owner;
> > +               unsigned long dma_addr;
> > +               atomic_long_t pp_ref_count;
> > +       );
> > +};
> > +
> > +#endif /* _NET_NETMEM_TYPE_H */
> > --
> > 2.17.1
> >
> 
> [0] https://lore.kernel.org/netdev/1549550196-25581-1-git-send-email-ilias.apalodimas@linaro.org/
> Thanks
> /Ilias

