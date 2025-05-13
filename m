Return-Path: <netdev+bounces-189948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347B3AB490F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E66E19E776B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50B19FA8D;
	Tue, 13 May 2025 02:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC919E7D1;
	Tue, 13 May 2025 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101620; cv=none; b=bZPczUEe6IwDHeqY0lONVcON+Z+Szo+DMEJh/862gP9E62lrlOLDTqCzXyH/94qRzwqo5F0x+7evlJ+qOWWGnKpb29MhRlr2xLC/MQ+drA8ub3GwPHZDm2hgFc3RBgvNyBAcpeswJJYeflMDqeRfx4khz/FAvX8sxgFDovv1tCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101620; c=relaxed/simple;
	bh=ORcdYmpndfQmytzq1kttDWPRZSVuKUaoO6dr6mwuHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFvqEk32kahJVdvHYiNa6aE1vKFqy75OVrXlz2WlUFJUlaon7jmoecHawWrwVZJhK4FTxp0xZUegYLL/rVcwnY+zbX+VcV1BMTTwaZpDxCn4m0ns+0xJ9XqgHEWmw1139AirzOaZMkvwHjEwbQBFGz7cYEfvVL2HZIOQYymcM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-02-6822a7accd37
Date: Tue, 13 May 2025 11:00:07 +0900
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
Subject: Re: [RFC 01/19] netmem: rename struct net_iov to struct netmem_desc
Message-ID: <20250513020007.GB577@system.software.com>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-2-byungchul@sk.com>
 <ea4f2f83-e9e4-4512-b4be-af91b3d6b050@gmail.com>
 <20250512132939.GF45370@system.software.com>
 <CAHS8izPoNw9qbtAZgsNxAAPYqu7czdRYSZAXVZbJo9pP-htfDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPoNw9qbtAZgsNxAAPYqu7czdRYSZAXVZbJo9pP-htfDg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsXC9ZZnoe6a5UoZBlc3y1nMWb+GzWL1jwqL
	5Q92sFrMWbWN0eLLz9vsFosXfmO2mHO+hcXi6bFH7Bb3lz1jsdjTvp3ZorflN7NF044VTBYX
	tvWxWlzeNYfN4t6a/6wWxxaIWXw7/YbRYv2+G6wWv3/MYXMQ9tiy8iaTx85Zd9k9Fmwq9di8
	Qsuj68YlZo9NqzrZPDZ9msTucefaHjaPEzN+s3js3PGZyePj01ssHu/3XWXz+LxJLoA3issm
	JTUnsyy1SN8ugSujZ/cFtoLVAhV/flc3MC7i6WLk5JAQMJG4N6uHEcbe+PY5E4jNIqAq8XT7
	CWYQm01AXeLGjZ9gtoiApsSSfRNZuxi5OJgFzjJLfP10jhUkISzgI3Hh5X12EJtXwExiy7lZ
	jCBFQgJdTBKfdx1nhkgISpyc+YQFxGYGmvpn3iWgOAeQLS2x/B8HRFheonnrbLByToFAieWL
	GsDmiwooSxzYdpwJZKaEwCl2iZk3n7FDXC0pcXDFDZYJjIKzkKyYhWTFLIQVs5CsWMDIsopR
	KDOvLDcxM8dEL6MyL7NCLzk/dxMjMJqX1f6J3sH46ULwIUYBDkYlHt4TLxUzhFgTy4orcw8x
	SnAwK4nwNm4HCvGmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCU
	amCUm+bHtl6vXiaVg8F24uubk0sSdb57R7zSDbk3MV0mcFM2y6HnHrtk8zcYScxKvj2x5lxU
	07UloTciVhwOrvvG2Dgxb2U0mwuXsNOftAttF9S7wwT5ZjskisvKCRydxbJzY5zMikS9Oxvn
	sZ38IbNsTsMNX1F3Lrm385sbE27fu/TwwJ0oXk0lluKMREMt5qLiRADQefqS4gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsXC5WfdrLtmuVKGwdPrfBZz1q9hs1j9o8Ji
	+YMdrBZzVm1jtPjy8za7xeKF35gt5pxvYbF4euwRu8X9Zc9YLPa0b2e26G35zWzRtGMFk8Xh
	uSdZLS5s62O1uLxrDpvFvTX/WS2OLRCz+Hb6DaPF+n03WC1+/5jD5iDisWXlTSaPnbPusnss
	2FTqsXmFlkfXjUvMHptWdbJ5bPo0id3jzrU9bB4nZvxm8di54zOTx8ent1g83u+7yuax+MUH
	Jo/Pm+QC+KK4bFJSczLLUov07RK4Mnp2X2ArWC1Q8ed3dQPjIp4uRk4OCQETiY1vnzOB2CwC
	qhJPt59gBrHZBNQlbtz4CWaLCGhKLNk3kbWLkYuDWeAss8TXT+dYQRLCAj4SF17eZwexeQXM
	JLacm8UIUiQk0MUk8XnXcWaIhKDEyZlPWEBsZqCpf+ZdAopzANnSEsv/cUCE5SWat84GK+cU
	CJRYvqgBbL6ogLLEgW3HmSYw8s1CMmkWkkmzECbNQjJpASPLKkaRzLyy3MTMHFO94uyMyrzM
	Cr3k/NxNjMDYXFb7Z+IOxi+X3Q8xCnAwKvHwnnipmCHEmlhWXJl7iFGCg1lJhLdxO1CINyWx
	siq1KD++qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qB8XQF3zUL98knDu9b
	MmnnjQd2HGn9eaJvD3lL5LNWGdy6dTdgd4SA0WMmmy/1f5k/nG+bN4dh5dRfr4V3/r3uxj/5
	z+X/69f0xjFPCYrRkD0VpK0558iigJCMlYfvZXRH6lzOv3YnXZ3PtVn6nG3YJlWZXZWp0RP2
	tP8J77Wyz4s56SCXU/ygVYmlOCPRUIu5qDgRAClqDYrJAgAA
X-CFilter-Loop: Reflected

On Mon, May 12, 2025 at 12:14:13PM -0700, Mina Almasry wrote:
> On Mon, May 12, 2025 at 6:29 AM Byungchul Park <byungchul@sk.com> wrote:
> >
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
> > > >   include/linux/skbuff.h                  |  4 +--
> > > >   include/net/netmem.h                    | 20 ++++++------
> > > >   include/net/page_pool/memory_provider.h |  6 ++--
> > > >   io_uring/zcrx.c                         | 42 ++++++++++++-------------
> > >
> > > You're unnecessarily complicating it for yourself. It'll certainly
> > > conflict with changes in the io_uring tree, and hence it can't
> > > be taken normally through the net tree.
> > >
> > > Why are you renaming it in the first place? If there are good
> >
> > It's because the struct should be used for not only io vetor things but
> > also system memory.  Current network code uses struct page as system
> > memory descriptor but struct page fields for page pool will be gone.
> >
> > So I had to reuse struct net_iov and I thought renaming it made more
> > sense.  It'd be welcome if you have better idea.
> >
> 
> As I said in another thread, struct page should not embed struct

I don't understand here.  Can you explain more?  Do you mean do not use
place holder?

> net_iov as-is. struct net_iov already has fields that are unrelated to
> page (like net_iov_owner) and more will be added in the future.
> 
> I think what Matthew seems to agree with AFAIU in the other thread is
> creating a new struct, struct netmem_desc, and having struct net_iov
> embed netmem_desc.

This would look better.  I will try.

	Byungchul

> -- 
> Thanks,
> Mina

