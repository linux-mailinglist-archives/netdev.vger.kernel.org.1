Return-Path: <netdev+bounces-197576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A6AD93AA
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F543B3A4B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB03D224AE0;
	Fri, 13 Jun 2025 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaV7VmZa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89893223DF6
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835119; cv=none; b=CT1EHJ5bGxWv8a7ZOtdNhHqeNsTeESxIU5Vlh0giQrfwZcnTQbQvJCr2Msuy96WF09u9lTJ2NXRM578cDTxEr5hhbrNRVdyJqk3Jhca8hbpAb4WuN73l6dehP0zlz5ygEd+/p/pcctBF/Gr+RyA34UciZHrd4LvRvRcybSKROyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835119; c=relaxed/simple;
	bh=2zYTssG6g5pp5PrZu6ZcoczYQpJEQlrjjNFYRG6yupE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzaSTHAa1X2ZRi6DjowwviAROalOoqrXMbwz6o2edbRveNLSmgOmF3MSccLVenA23Lf/PQd47rpnxKHksxqxpVL4WZwjZPWGP/nY/NhPGUAlomIJXlIhrwzJiLi6pkNI/dbd2abMCKQ5hJlUtmc13UWr1LnEOPI+X2aT5l65UsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaV7VmZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E904DC4CEE3;
	Fri, 13 Jun 2025 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749835117;
	bh=2zYTssG6g5pp5PrZu6ZcoczYQpJEQlrjjNFYRG6yupE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaV7VmZaQSHjmnVoq0m2QAhb4Z3hHJWFyA7HTFRFNJvQZ9YBbU7W34d6sbNGFKWWu
	 kTtHx31aF4x2nxQCHn889BQQCtDQC6jEma/H01PNVirDG4nEYA5jbaUyvLkJaCKRnC
	 XKYG603hwftSiZwiMxSeCoeCTPVHvTeDNtsE9k4tDREKt5jPx54ONhYexcTqVtkxz/
	 b1ze6ppJuyxCe68Br3q8wnG8o0yy3mnLMG5oP5DSjtgZ8IesCc31EPra2P6l5v/8nR
	 aU1wOSuLCFjmlf0g3RzEPA8KREUSjMt4ptUV4DgHDQuF5zeWaucYQuryApTMy/mw8Z
	 r9xStUmqIpVwA==
Date: Fri, 13 Jun 2025 18:18:33 +0100
From: Simon Horman <horms@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org
Subject: Re: [PATCH net-next v9 05/15] net: homa: create homa_peer.h and
 homa_peer.c
Message-ID: <20250613171833.GN414686@horms.kernel.org>
References: <20250609154051.1319-1-ouster@cs.stanford.edu>
 <20250609154051.1319-6-ouster@cs.stanford.edu>
 <20250613143958.GH414686@horms.kernel.org>
 <CAGXJAmxQn_iAqhOHwxEQ16n+MKjFyEbiUoBbGyDY+TLYooeJhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmxQn_iAqhOHwxEQ16n+MKjFyEbiUoBbGyDY+TLYooeJhQ@mail.gmail.com>

On Fri, Jun 13, 2025 at 10:12:11AM -0700, John Ousterhout wrote:
> (I have implemented all of your suggestions for which there are no
> responses below)
> 
> On Fri, Jun 13, 2025 at 7:40 AM Simon Horman <horms@kernel.org> wrote:
> > > +/**
> > > + * homa_peer_hash() - Hash function used for @peertab->ht.
> > > + * @data:    Pointer to key for which a hash is desired. Must actually
> > > + *           be a struct homa_peer_key.
> > > + * @dummy:   Not used
> > > + * @seed:    Seed for the hash.
> > > + * Return:   A 32-bit hash value for the given key.
> > > + */
> > > +static inline u32 homa_peer_hash(const void *data, u32 dummy, u32 seed)
> >
> > Sorry if this has already been asked but can homa reuse the code in
> > drivers/md/dm-vdo/murmurhash3.c:murmurhash3_128() (after moving it
> > somewhere else).
> 
> No problem; the question hasn't been asked before. I'd be happy to use
> an existing implementation of murmurhash3 but couldn't find one that
> was accessible. What do you mean by "moving it somewhere else"? Are
> you suggesting I add a new murmurhash3 implementation somewhere
> "public" in the kernel? I'm a little hesitant to do this because I'm
> not at all expert on murmurhash3: I'm not confident about getting this
> right. Also, I wouldn't feel comfortable taking on maintainer
> responsibility for this.

Hi John,

I'm suggesting moving murmurhash3_128(), say to lib/ at the top
of the Kernel tree. And I'm happy to assist with this.

Aside from being accessible, does murmurhash3_128() meet your
needs in it's current form?

> 
> > > +     const struct homa_peer *peer = obj;
> > > +     const struct homa_peer_key *key = arg->key;
> >
> > nit: Reverse xmas tree here please.
> >      Likewise elsewhere in this patchset.
> >
> >      This tool can he useful here
> >      https://github.com/ecree-solarflare/xmastree/commits/master/
> 
> Thanks for the pointer to xmastree.pl; I wasn't aware of it and it
> will be super-helpful. I've fixed all of the reverse xmas tree issues
> now.
> 
> -John-
> 

