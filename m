Return-Path: <netdev+bounces-227068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4ECBA7C61
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 03:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8D31886679
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C461F30A9;
	Mon, 29 Sep 2025 01:46:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A117736;
	Mon, 29 Sep 2025 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759110399; cv=none; b=mK60Z2/2vN6m2QnzOOAmEfCdEzF6k5jS2HtLfF8Pix+Fb2ztFV4GmMSUbirCtbqcoXguFd+GMnc/eUQIznMhWZuF8i1tkFrT9g8wdYzetM4URSb5oF8+7D764cL2ATErKXFs1S1pwZBBGTk7YhZb9CXcYYnz2SiACae8IGDvmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759110399; c=relaxed/simple;
	bh=M+C4ALP2XPsI/NhnAy+5Jv44vhN7LY3whPEnUNwIqxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf+kH+YXuOkWIByPejq/WfPbt/vce6vU947YQtzZkiVr4DkhHm1Z5uTOHiv+LiQegWrcnUoAGa48DNYH3rhyUqnccOFTHnC01097gLLJhxZa6YBuMuZjmS5c0vyYF6n9OndclYwmgfhwGXGSjFXzdn2xz5M/oIDNWcPaCxr7FlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-28-68d9e4f0d952
Date: Mon, 29 Sep 2025 10:46:19 +0900
From: Byungchul Park <byungchul@sk.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, almasrymina@google.com,
	hawk@kernel.org, toke@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with
 netmem_to_nmdesc()
Message-ID: <20250929014619.GA20562@system.software.com>
References: <20250926035423.51210-1-byungchul@sk.com>
 <aNau1UuLdO296pJf@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNau1UuLdO296pJf@horms.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsXC9ZZnke6HJzczDB4dF7VY/aPCYs6qbYwW
	c863sFg8PfaI3WJP+3Zmi0f9J9gsLmzrY7W4vGsOm8WxBWIW306/YbS4dPgRiwO3x5aVN5k8
	ds66y+6xYFOpx6ZVnWwe7/ddZfP4vEkugC2KyyYlNSezLLVI3y6BK+P3TqmCNYIVv9sfMDcw
	HubtYuTkkBAwkei5s5URxp6xZTcbiM0ioCqx48YVJhCbTUBd4saNn8wgtoiAssTZuS1AcS4O
	ZoHvjBJX9/4BaxAWiJfYuOotWAOvgIXE3D3TWUFsIYFoiUPn97NAxAUlTs58AmYzC2hJ3Pj3
	EqieA8iWllj+jwMkzClgIHHl2gywkaJAuw5sOw62S0LgDJvE+88T2SEOlZQ4uOIGywRGgVlI
	xs5CMnYWwtgFjMyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQLjYFntn+gdjJ8uBB9iFOBgVOLh
	TbC/mSHEmlhWXJl7iFGCg1lJhLdu840MId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATS
	E0tSs1NTC1KLYLJMHJxSDYzRtg76T8s0WhYta2RRLnPgnpRzjfOtzc0jTAXXr29gLDolOsN9
	ytmJjhut4y4yvdF3s/mxS8zWQVunsX3qpt37DGvl2a7qiBmXSnzzariVuyRgx5qkywyFZ2+Y
	pi3u+vHzqg/LpM5lqjpcFxkPxv/jFZ61KSSj1t/1uIzuH3EvkfBJ04O3piixFGckGmoxFxUn
	AgAsr/WyfwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC5WfdrPvhyc0Mgw3b2S1W/6iwmLNqG6PF
	nPMtLBZPjz1it9jTvp3Z4lH/CTaLw3NPslpc2NbHanF51xw2i2MLxCy+nX7DaHHp8CMWBx6P
	LStvMnnsnHWX3WPBplKPTas62Tze77vK5rH4xQcmj8+b5ALYo7hsUlJzMstSi/TtErgyfu+U
	KlgjWPG7/QFzA+Nh3i5GTg4JAROJGVt2s4HYLAKqEjtuXGECsdkE1CVu3PjJDGKLCChLnJ3b
	AhTn4mAW+M4ocXXvH7AGYYF4iY2r3oI18ApYSMzdM50VxBYSiJY4dH4/C0RcUOLkzCdgNrOA
	lsSNfy+B6jmAbGmJ5f84QMKcAgYSV67NABspCrTrwLbjTBMYeWch6Z6FpHsWQvcCRuZVjCKZ
	eWW5iZk5pnrF2RmVeZkVesn5uZsYgUG9rPbPxB2MXy67H2IU4GBU4uFNsL+ZIcSaWFZcmXuI
	UYKDWUmEt27zjQwh3pTEyqrUovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYO
	TqkGRuaMc/Nka/7d3Zo8/6iI7P3nW/9EPHxlfucEP+Oc5ee2xLEv++mhPs3yiX+1CFv12Wu9
	XCujvjF+nv/Zdua1DtV3qlde/DzceFspbMvq3O3fay+xfHgRHMOwakW+n4r95mfTjv/IEQjM
	lZ/UlfMtsv6PhBSb9Vt+FzntJXf8Jyy2r1TTFv/n66TEUpyRaKjFXFScCAB4WJT+ZgIAAA==
X-CFilter-Loop: Reflected

On Fri, Sep 26, 2025 at 04:18:45PM +0100, Simon Horman wrote:
> On Fri, Sep 26, 2025 at 12:54:23PM +0900, Byungchul Park wrote:
> > Changes from RFC v2:
> >       1. Add a Reviewed-by tag (Thanks to Mina)
> >       2. Rebase on main branch as of Sep 22
> >
> > Changes from RFC:
> >       1. Optimize the implementation of netmem_to_nmdesc to use less
> >          instructions (feedbacked by Pavel)
> >
> > --->8---
> > >From 01d23fc4b20c369a2ecf29dc92319d55a4e63aa2 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Tue, 29 Jul 2025 19:34:12 +0900
> > Subject: [PATCH net-next v3] netmem: replace __netmem_clear_lsb() with netmem_to_nmdesc()
> >
> > Now that we have struct netmem_desc, it'd better access the pp fields
> > via struct netmem_desc rather than struct net_iov.
> >
> > Introduce netmem_to_nmdesc() for safely converting netmem_ref to
> > netmem_desc regardless of the type underneath e.i. netmem_desc, net_iov.
> >
> > While at it, remove __netmem_clear_lsb() and make netmem_to_nmdesc()
> > used instead.
> >
> > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> 
> Hi Byungchul,
> 
> Some process issues from my side.
> 
> 1. The revision information, up to including the '--->8---' line above
>    should be below the scissors ('---') below.
> 
>    This is so that it is available to reviewers, appears in mailing
>    list archives, and so on. But is not included in git history.

Ah yes.  Thank you.  Lemme check.

> 2. Starting the patch description with a 'From: ' line is fine.
>    But 'Date:" and 'Subject:' lines don't belong there.
> 
>    Perhaps 1 and 2 are some sort of tooling error?
> 
> 3. Unfortunately while this patch is targeted at net-next,
>    it doesn't apply cleanly there.

I don't understand why.  Now I just rebased on the latest 'main' and it
works well.  What should I check else?

> When you repost, be sure to observe the 24h rule.

Thanks!

	Byungchul

> Link: https://docs.kernel.org/process/maintainer-netdev.html
> 
> --
> pw-bot: changes-requested
> 
> ...

