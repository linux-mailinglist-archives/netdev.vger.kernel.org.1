Return-Path: <netdev+bounces-162711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A501BA27BB6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 20:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CA1188381F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2CE21CA16;
	Tue,  4 Feb 2025 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6ObKSQ0y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4821C19D
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698122; cv=none; b=uiEQKSID7ip7zHo89UTBt7wInaz9wMr+VTFnr/84ztxPW+uSXkFVQ+I2mUig1lDKm97kHQaNINxZCNbtO6weRKcIv5YQ9Uzg2nCxQAIrrtmQLcRMwb2feuahcHIupLEH1MhGkxB8EfXpmzQ+MVywQjffUJYUj2xH/VbNfu8KQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698122; c=relaxed/simple;
	bh=JnI/dF+PZ4pxk2+y98qb0ArIepd8dFUGwvbvUhznKfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK+mf9+kXJZcps4QAaCgZ79WECuhvGQ+5OuqL8Zj0gx9ahMcl5NDtcgTGx2Mq1pynTovjbc4jDJFOVWNFkp4JdulX0PNqNFSsTwj7lPXhlvZ1MEP/e7rMjAn13HOfckmNH3K8UixAu8WDRvV4f6Gu94wvWX2SDzYIuvfDF/Kyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6ObKSQ0y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IujJPUNOBEmHXEtKG3Ofmy54dJ6tyc3bpfPA/wYO8vs=; b=6ObKSQ0yAvvK01pOv/8YeiYiw0
	yMMmv5Kq6uyjzzRtVqbYWt40nfBpOG82zIBu43qiw99tQ5I31A6E53xPzWt0Lg/ZBpey/+/GsbB7W
	uJGSvy7z9LdYazloWZIA6fWpE8z3TFFVS0FJ0jG6P51y+xxUBcf+y3yeEWQH8T9fZqEw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfOns-00Ax6O-E7; Tue, 04 Feb 2025 20:41:48 +0100
Date: Tue, 4 Feb 2025 20:41:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
Message-ID: <a3295c97-9734-4baa-b9c7-408c54b0702c@lunn.ch>
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-9-ouster@cs.stanford.edu>
 <530c3a8c-fa5b-4fbe-9200-6e62353ebeaf@redhat.com>
 <CAGXJAmya3xU69ghKO10SZz4sh48CyBgBsF7AaV1OOCRyVPr0Nw@mail.gmail.com>
 <991b5ad9-57cf-4e1d-8e01-9d0639fa4e49@redhat.com>
 <CAGXJAmxfkmKg4NqHd9eU94Y2hCd4F9WJ2sOyCU1pPnppVhju=A@mail.gmail.com>
 <7b05dc31-e00f-497e-945f-2964ff00969f@redhat.com>
 <CAGXJAmyNPhA-6L0jv8AT9_xaxM81k+8nD5H+wtj=UN84PB_KnA@mail.gmail.com>
 <52365045-c771-412a-9232-70e80e26c34f@redhat.com>
 <CAGXJAmzL39XZ-tcDRrLs-hiAXi3W79cAoVe18hHkD7iGDKe7yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmzL39XZ-tcDRrLs-hiAXi3W79cAoVe18hHkD7iGDKe7yQ@mail.gmail.com>

> > If unprivileged applications could use unlimited amount of kernel
> > memory, they could hurt the whole system stability, possibly causing
> > functional issue of core kernel due to ENOMEM.
> >
> > The we always try to bound/put limits on amount of kernel memory
> > user-space application can use.
> 
> Homa's receive buffer space is *not kernel memory*; it's just a large
> mmapped region created by the application., no different from an
> application allocating a large region of memory for its internal
> computation.

ulimit -v should be able to limit this, if user space is doing the
mmap(). It should be easy to test. Set a low enough limit the mmap()
should fail, and i guess you get MAP_FAILED and errno = ENOMEM?

	Andrew

