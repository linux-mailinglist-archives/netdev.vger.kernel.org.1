Return-Path: <netdev+bounces-189744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0215AB3725
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B053A8CF8
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19135293747;
	Mon, 12 May 2025 12:36:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA4329373F;
	Mon, 12 May 2025 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053399; cv=none; b=XCf4ijiOXwa3ECQIyqJmS6s4BIVZb1grngGwgrWFeZej8li0rTI5MiG+tF6GcxaNZt+TbQqVAokS7GHttc7cIBqj2AJ7jcfauZ9cYuCAZyAVIWbgOxoqb1hZU4FL3wcXRRz4Tkdkm6fXgLA/kfT3QufWUBlEBwauRnuPRcSfS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053399; c=relaxed/simple;
	bh=g4nck2QMZGwAZ9w81HswNK6wCtGG7pe79Jg7VJ70KhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBrX53pMjMXhfAxTeOIWmL2ygRMg0rW8QFAe4my5tiWMh93rlCaBUF2Ij3my3QaXl8dLoVjFxkl041btZKxuBVRGLgviN/SgOTd6NSTRUvJpH/0xtT8OaUMnsm8dROdF5oo9m2kQfoYrfbQfgnc162MMVKaNsJsp6DZ2i0F7Zlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-07-6821eb4fc11d
Date: Mon, 12 May 2025 21:36:26 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, willy@infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, john.fastabend@gmail.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: Re: [RFC 00/19] Split netmem from struct page
Message-ID: <20250512123626.GB45370@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <CAHS8izPFiytN_bM6cu2X8qbvyVTL6pFMeobW=qFwjgHbg5La9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPFiytN_bM6cu2X8qbvyVTL6pFMeobW=qFwjgHbg5La9Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsXC9ZZnoa7/a8UMg9OX5CzmrF/DZrH6R4XF
	8gc7WC3mrNrGaPHl5212i8ULvzFbzDnfwmLx9Ngjdov7y56xWOxp385s0dvym9miaccKJosL
	2/pYLS7vmsNmcW/Nf1aLYwvELL6dfsNosX7fDVaL3z/msDkIe2xZeZPJY+esu+weCzaVemxe
	oeXRdeMSs8emVZ1sHps+TWL3uHNtD5vHiRm/WTx27vjM5PHx6S0Wj/f7rrJ5fN4kF8AbxWWT
	kpqTWZZapG+XwJWx5ft99oKjvBUPv69nb2A8zdXFyMkhIWAi8eDlVXYYe+HP00wgNouAqsS+
	TwvBbDYBdYkbN34yg9giApoSS/ZNZO1i5OJgFjjLLPH10zlWkISwgJnE8cs3GEFsXgELiWnT
	24GGcnAICdRIbDmTDxEWlDg58wkLiM0MNPPPvEvMICXMAtISy/9xQITlJZq3zgZbxSkQKDGp
	+z7YCaICyhIHth1ngjjzHLvE5z/pELakxMEVN1gmMArOQrJhFpINsxA2zEKyYQEjyypGocy8
	stzEzBwTvYzKvMwKveT83E2MwEheVvsnegfjpwvBhxgFOBiVeHhPvFTMEGJNLCuuzD3EKMHB
	rCTC27gdKMSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFR
	x+LqkVKDxgeRRnLyHG7qPb4Sew6Vx1mJnszo3P6x4/HXprNJSz7e4z+2k/+70bO2masVG7vM
	3045LHf2srUnV7zzPrNGrWlqiQf3v55zv2vjR9789uz4ubkaQf93lZ9oKWoytVTrDZN6+Hri
	93CTkxcXOmqtDM7wqX/W5vctLHfVAZNT6ycpsRRnJBpqMRcVJwIA//ACmuACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXC5WfdrOv/WjHD4HWrsMWc9WvYLFb/qLBY
	/mAHq8WcVdsYLb78vM1usXjhN2aLOedbWCyeHnvEbnF/2TMWiz3t25ktelt+M1s07VjBZHF4
	7klWiwvb+lgtLu+aw2Zxb81/VotjC8Qsvp1+w2ixft8NVovfP+awOYh4bFl5k8lj56y77B4L
	NpV6bF6h5dF14xKzx6ZVnWwemz5NYve4c20Pm8eJGb9ZPHbu+Mzk8fHpLRaP9/uusnksfvGB
	yePzJrkAvigum5TUnMyy1CJ9uwSujC3f77MXHOWtePh9PXsD42muLkZODgkBE4mFP08zgdgs
	AqoS+z4tBLPZBNQlbtz4yQxiiwhoSizZN5G1i5GLg1ngLLPE10/nWEESwgJmEscv32AEsXkF
	LCSmTW9n72Lk4BASqJHYciYfIiwocXLmExYQmxlo5p95l5hBSpgFpCWW/+OACMtLNG+dDbaK
	UyBQYlL3fbATRAWUJQ5sO840gZFvFpJJs5BMmoUwaRaSSQsYWVYximTmleUmZuaY6hVnZ1Tm
	ZVboJefnbmIERuay2j8TdzB+uex+iFGAg1GJh/fES8UMIdbEsuLK3EOMEhzMSiK8jduBQrwp
	iZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYz+tVElnb3lWzL2
	vjZXrIn0LrTYvXtCu6/4EsP+ZbLG/xbtYCvtkSosYf57zdlPzOB1Lq9n15qvV6ccOXLwmIhY
	dLcs64qCc1+MPHTKp3ZIflrwv3JDvGrXb+4Vph8d1H4fO/av+sfkQ+tO37t8N6Jj/fs3U//V
	RF5m0/5ml/fm/fTtpjurT51XYinOSDTUYi4qTgQAYc+tCMgCAAA=
X-CFilter-Loop: Reflected

On Fri, May 09, 2025 at 07:09:16AM -0700, Mina Almasry wrote:
> On Fri, May 9, 2025 at 4:51 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > The MM subsystem is trying to reduce struct page to a single pointer.
> > The first step towards that is splitting struct page by its individual
> > users, as has already been done with folio and slab.  This patchset does
> > that for netmem which is used for page pools.
> >
> > Matthew Wilcox tried and stopped the same work, you can see in:
> >
> >    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
> >
> > Mina Almasry already has done a lot fo prerequisite works by luck, he
> > said :).  I stacked my patches on the top of his work e.i. netmem.
> >
> > I focused on removing the page pool members in struct page this time,
> > not moving the allocation code of page pool from net to mm.  It can be
> > done later if needed.
> >
> > There are still a lot of works to do, to remove the dependency on struct
> > page in the network subsystem.  I will continue to work on this after
> > this base patchset is merged.
> >
> > This patchset is based on mm tree's mm-unstable branch.
> >
> 
> This series largely looks good to me, but a couple of things:
> 
> - For deep changes like this to the page_pool, I think we need a
> before/after run to Jesper's currently out-of-tree benchmark to see
> any regressions:
> https://lore.kernel.org/netdev/20250309084118.3080950-1-almasrymina@google.com/

Sure.  I will check it.

> - Also please CC Pavel on iterations related to netmem/net_iov, they
> are reusing that in io_uring code for iouring rx rc as well.

I will.  Thank you.

	Byungchul

> --
> Thanks,
> Mina

