Return-Path: <netdev+bounces-190284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716F2AB600B
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 02:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050DC170AF8
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504861FDD;
	Wed, 14 May 2025 00:08:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444BD17BD9;
	Wed, 14 May 2025 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747181289; cv=none; b=jN6azlPqIneS8N/8AnHb5KZzH2pNeHOtn9WKpTeu4zTEwZ+NchEuTrdwNggEuM8iLyDpIVLiy01xK0wczf5KrOugB8AOOjz8VCZ8IFKZaQ55JYL7vLip8MK9GUE1dg9hWMvvm5DubvEz3CC9zVjocIiblmsHlIeFjrDh6xNUAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747181289; c=relaxed/simple;
	bh=VymPZz5dxqp//+cI6U/6LPh2jAhgsDMsNBoWUdgFXuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5g1esearoSE+lZ+GWEyHORNC5GFJw3G4Wy8kNjBRpRIUyL2hQcEZPJbepHIk9twlyb9k4Rr0t3/s7EwK1dDAi0V/xiStNp6Mk+dvYnK4FcSqg1AvLH5qTOC6n5HNkcVcvTJ9MSb339u2F4G/poA5B/+AufRrcMf23jeGKqPVfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-97-6823dedb8991
Date: Wed, 14 May 2025 09:07:49 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, john.fastabend@gmail.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: Re: [RFC 01/19] netmem: rename struct net_iov to struct netmem_desc
Message-ID: <20250514000749.GA51632@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-2-byungchul@sk.com>
 <ea4f2f83-e9e4-4512-b4be-af91b3d6b050@gmail.com>
 <20250512132939.GF45370@system.software.com>
 <eae3e1a9-1d82-40b7-a835-978be4a6ef56@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae3e1a9-1d82-40b7-a835-978be4a6ef56@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsXC9ZZnke7te8oZBs8vyVnMWb+GzWL1jwqL
	5Q92sFrMWbWN0eLLz9vsFosXfmO2mHO+hcXi6bFH7Bb3lz1jsdjTvp3ZorflN7NF044VTBYX
	tvWxWlzeNYfN4t6a/6wWxxaIWXw7/YbRYv2+G6wWv3/MYXMQ9tiy8iaTx85Zd9k9Fmwq9di8
	Qsuj68YlZo9NqzrZPDZ9msTucefaHjaPEzN+s3js3PGZyePj01ssHu/3XWXz+LxJLoA3issm
	JTUnsyy1SN8ugStjwrrfbAU7+SumfN7K1MB4kruLkZNDQsBEYuu7FiYYe8Gva6xdjBwcLAKq
	Ejc3GoKE2QTUJW7c+MkMYosIaEu8vn6IvYuRi4NZYA+zxOWz0xlBEsICPhIXXt5nB7F5BSwk
	vsyYxAZSJCTwjVHi7pONjBAJQYmTM5+wgNjMAloSN/69ZAJZxiwgLbH8HwdImFPAVuL41h9g
	94gKKEsc2HacCWSOhMAxdone9bfZIA6VlDi44gbLBEaBWUjGzkIydhbC2AWMzKsYhTLzynIT
	M3NM9DIq8zIr9JLzczcxAqNzWe2f6B2Mny4EH2IU4GBU4uG10FXOEGJNLCuuzD3EKMHBrCTC
	ez0LKMSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoHRjjVZ
	7aDJvYnHH39/LchimqLRse/Yit9L/vvwfP4TekGglvnLdZH4jS/5F0x8fSnSSuVFpiKzTff6
	Oa+2LTylzK971+DY3K74cM1bTOcL+47qpRmddlv1LCbm2eQv9hbTcwQNbst2Wqp9vrHrn+sC
	OQ2OKwUl/VYBVm0XVnKuN1p+e8dC6zB/JZbijERDLeai4kQAabFjA8oCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsXC5WfdrHv7nnKGwck+Jos569ewWaz+UWGx
	/MEOVos5q7YxWnz5eZvdYvHCb8wWc863sFg8PfaI3eL+smcsFnvatzNb9Lb8ZrZo2rGCyeLw
	3JOsFhe29bFaXN41h83i3pr/rBbHFohZfDv9htFi/b4brBa/f8xhcxDx2LLyJpPHzll32T0W
	bCr12LxCy6PrxiVmj02rOtk8Nn2axO5x59oeNo8TM36zeOzc8ZnJ4+PTWywe7/ddZfNY/OID
	k8fnTXIBfFFcNimpOZllqUX6dglcGRPW/WYr2MlfMeXzVqYGxpPcXYycHBICJhILfl1j7WLk
	4GARUJW4udEQJMwmoC5x48ZPZhBbREBb4vX1Q+xdjFwczAJ7mCUun53OCJIQFvCRuPDyPjuI
	zStgIfFlxiQ2kCIhgW+MEnefbGSESAhKnJz5hAXEZhbQkrjx7yUTyDJmAWmJ5f84QMKcArYS
	x7f+YAKxRQWUJQ5sO840gZF3FpLuWUi6ZyF0L2BkXsUokplXlpuYmWOqV5ydUZmXWaGXnJ+7
	iREYa8tq/0zcwfjlsvshRgEORiUeXgtd5Qwh1sSy4srcQ4wSHMxKIrzXs4BCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjLdE7m7eMXmNyvc/QYx5orYS
	Ebu3Kao/tOv2yE+5nb0sZOPkN9zHteXWmD3PmyjwqM2c59qDL7y7S9c/0VI0PXjW4OTL6LU5
	r9zrJTZ+ePDpEGfa9NaGktNG02I8e5P5FuimG3sp3i8PcI5Uvch0ZN/tGsb5T4N4Pp2+kf3s
	7ckbwua8T3YKT1diKc5INNRiLipOBAAkrAYasQIAAA==
X-CFilter-Loop: Reflected

On Tue, May 13, 2025 at 01:49:56PM +0100, Pavel Begunkov wrote:
> On 5/12/25 14:29, Byungchul Park wrote:
> > On Mon, May 12, 2025 at 02:11:13PM +0100, Pavel Begunkov wrote:
> > > On 5/9/25 12:51, Byungchul Park wrote:
> > > > To simplify struct page, the page pool members of struct page should be
> > > > moved to other, allowing these members to be removed from struct page.
> > > > 
> > > > Reuse struct net_iov for also system memory, that already mirrored the
> > > > page pool members.
> > > > 
> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > > ---
> > > >    include/linux/skbuff.h                  |  4 +--
> > > >    include/net/netmem.h                    | 20 ++++++------
> > > >    include/net/page_pool/memory_provider.h |  6 ++--
> > > >    io_uring/zcrx.c                         | 42 ++++++++++++-------------
> > > 
> > > You're unnecessarily complicating it for yourself. It'll certainly
> > > conflict with changes in the io_uring tree, and hence it can't
> > > be taken normally through the net tree.
> > > 
> > > Why are you renaming it in the first place? If there are good
> > 
> > It's because the struct should be used for not only io vetor things but
> > also system memory.  Current network code uses struct page as system
> 
> Not sure what you mean by "io vector things", but it can already
> point to system memory, and if anything, the use conceptually more
> resembles struct pages rather than iovec. IOW, it's just a name,
> neither gives a perfect understanding until you look up details,
> so you could just leave it net_iov. Or follow what Mina suggested,
> I like that option.

I appreciate all of your feedback and will try to apply them.

	Byungchul

> > memory descriptor but struct page fields for page pool will be gone.
> > 
> > So I had to reuse struct net_iov and I thought renaming it made more
> > sense.  It'd be welcome if you have better idea.
> -- 
> Pavel Begunkov

