Return-Path: <netdev+bounces-190100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4624AB52B2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8795F1680F9
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C011B26C3B9;
	Tue, 13 May 2025 10:24:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB2926AA82;
	Tue, 13 May 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131879; cv=none; b=pKhtiuzT5lejOxvNWrSLLHaU9WtyqDypa2GNJB8sTP6UIqgedxGs5gKV7rohtlAb7/V7PWtEow9/jcTEuNUn7oFOQkvL/rFbpqooOLZJYLvBPZZg3teGw0WS9d0BbCEuEE00xBaO0Mk/FthzxqrbTEkxPZq6DMblCTC7zhlSTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131879; c=relaxed/simple;
	bh=9/DKrlEAvctFt86S6cWxCGzlEewY2s8TuwAG+PR8JyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgaHnqAAfxW99QlrTLyFPO8QaNIXC/IFbJ55GV2XmZA9s8bBuZjEfYIU9p0ZDym7SlJOqsxaFEc6oGrPaDz2tIAmfSaNioy+KPqtcQLroz0NpfJn/QjhlSv3MeRRjDIYGeG5FNnmzs8pdt9Kb5U+M6B90JMBC8X6Ne754bxb0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-85-68231de074e2
Date: Tue, 13 May 2025 19:24:27 +0900
From: Byungchul Park <byungchul@sk.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	almasrymina@google.com, ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct
 page
Message-ID: <20250513102427.GA17155@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-20-byungchul@sk.com>
 <aB5DNqwP_LFV_ULL@casper.infradead.org>
 <20250512125103.GC45370@system.software.com>
 <aCII7vd3C2gB0oi_@casper.infradead.org>
 <20250513014200.GA577@system.software.com>
 <aCK6J2YtA7vi1Kjz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCK6J2YtA7vi1Kjz@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsXC9ZZnoe4DWeUMg76bEhZz1q9hs1j9o8Ji
	+YMdrBZfft5mt1i88BuzxZzzLSwWT489Yre4v+wZi8We9u3MFr0tv5ktmnasYLK4sK2P1eLy
	rjlsFvfW/Ge1OLZAzOLb6TeMFuv33WC1+P1jDpuDkMeWlTeZPHbOusvusWBTqcfmFVoeXTcu
	MXtsWtXJ5rHp0yR2jzvX9rB5nJjxm8Vj547PTB4fn95i8Xi/7yqbx+dNcgG8UVw2Kak5mWWp
	Rfp2CVwZvU+nsBcc46hY9uIxSwPjE7YuRk4OCQETiR8f1zPB2EfWTGAGsVkEVCVOfZoMZrMJ
	qEvcuPETyObgEBHQkHizxQgkzCywlFli+lRhEFtYIEhi8uOH7CA2r4CFxLOGy0DlXBxCAnuY
	JNbN28wMkRCUODnzCQtEs5bEjX8vmUBmMgtISyz/xwES5gQ64e7i94wgtqiAssSBbceZQOZI
	CGxil2h9Ph3qTkmJgytusExgFJiFZOwsJGNnIYxdwMi8ilEoM68sNzEzx0QvozIvs0IvOT93
	EyMwIpfV/onewfjpQvAhRgEORiUe3hMvFTOEWBPLiitzDzFKcDArifA2bgcK8aYkVlalFuXH
	F5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYJwkbef5SyjujrzhN63Q9qvL
	9f4ucd2aO9/ydsyLLNYiox/XJXSfsD9dIHdJ9E7S1/qvboz/qo987Unc0C/xXHVO/rO5aq4X
	96Rql5p0sxk/3frI1F3puwjDI/39Wnw72Pji7e8Ku+hq2h+ZduF31o28f3/nujIHZV/3C3rp
	dWdK2b71ki0W0UosxRmJhlrMRcWJAEZ7DJ7EAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXC5WfdrPtAVjnDYNc/Fos569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK6P36RT2gmMcFctePGZpYHzC1sXIySEhYCJxZM0EZhCbRUBV4tSn
	yWA2m4C6xI0bP4FsDg4RAQ2JN1uMQMLMAkuZJaZPFQaxhQWCJCY/fsgOYvMKWEg8a7gMVM7F
	ISSwh0li3bzNzBAJQYmTM5+wQDRrSdz495IJZCazgLTE8n8cIGFOoBPuLn7PCGKLCihLHNh2
	nGkCI+8sJN2zkHTPQuhewMi8ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzC+ltX+mbiD8ctl
	90OMAhyMSjy8J14qZgixJpYVV+YeYpTgYFYS4W3cDhTiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgtI/Imn30Zs/zlz8fNy1dyrB8RuP2u3lLJEQ2Br4z
	ejn3888v9TkVjJ6G3n86LphJvWre+emJ+hWHdVHXciZqrc6ZffKyb98r3wlLd2Rm5a6X276y
	SLnjqdC7bQvmaR5/p8h/S0lLWsI9dEvTO0HVd99ZlVOPGqhc+lAVeuUsn5X4+5dtbLNEDZRY
	ijMSDbWYi4oTAdaZeECrAgAA
X-CFilter-Loop: Reflected

On Tue, May 13, 2025 at 04:19:03AM +0100, Matthew Wilcox wrote:
> On Tue, May 13, 2025 at 10:42:00AM +0900, Byungchul Park wrote:
> > Just in case, lemme explain what I meant, for *example*:
> 
> I understood what you meant.
> 
> > In here, operating on struct netmem_desc can smash _mapcount and
> > _refcount in struct page unexpectedly, even though sizeof(struct
> > netmem_desc) <= sizeof(struct page).  That's why I think the place holder
> > is necessary until it completely gets separated so as to have its own
> > instance.
> 
> We could tighten up the assert a bit.  eg
> 
> static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));

This mitigates what I concern.  I will replace the place holder with
this (but it must never happen to relocate the fields in struct page by
any chance for any reason until the day.  I trust you :).

	Byungchul

> We _can't_ shrink struct page until struct folio is dynamically
> allocated.  The same patch series that dynamically allocates folio will
> do the same for netmem and slab and ptdesc and ...

