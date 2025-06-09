Return-Path: <netdev+bounces-195752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F496AD2294
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EDB3A903F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3BB175D53;
	Mon,  9 Jun 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lP7vJ3JA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA6CA5A
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483471; cv=none; b=N2Gi85jpBzcKQwiu+nzhKFOs3AhBEXCHgBs2Ysh4QPpoAxltzqzwcz102ebVh4pvNdZlaM+msQdEf3jhz8vyfwT1wESmvXboixQJna1LVwoNes+1wZOGxN8uUl57BtT7o3GoZuUFV8gr3UK7f5edK0Zg4c8wCdRORuUgyuUJ3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483471; c=relaxed/simple;
	bh=97JP++SVxZiXbEC1UYi5k2TjGUIsfz1cYx27/SerUTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4rA8xs+gxTekPkn8wriYLu3xQy3Gc3CL7oKgrOuf7GkANkVh7IhHDXNHX8Ic/IEwzFXdZDVtFVqvlu8uRhQEh4+EP1t+Rn/tGFKL8q1CfV8G9M3s7UunJps6HJs1KoigcBZEMHOpPRIvvQVUGqRpmvc2sVbs+eOSJF1dwnDozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lP7vJ3JA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B630DC4CEEB;
	Mon,  9 Jun 2025 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749483471;
	bh=97JP++SVxZiXbEC1UYi5k2TjGUIsfz1cYx27/SerUTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lP7vJ3JAR7HNmk6Lh4YFdF6MI5XLSnfw/ytp5/V8M6w97CWfIHKrN8HIj7Nb8Avk5
	 q2pwpFI9Axi1aAo+ZZ7Ks3gCMOUMK0UPk4FK1rwvz+97jxKOL3G47uU5LWp9YXhh3l
	 IJgXFz34ztuZ7uOmR0sCoIJJJmofjiejVK24KK2Z0yGVXGoYiYAMr1p+y8i9VnnPCn
	 avT3HJJnrJRJOQnVQTqFZ/hzYVdwDoU7f84J4L43rCdXsp2IWILecDRctA2xFM5s14
	 YlpzAU0yQec3wbs4m/eieF6kKDVTIO34iN7HCAWWKg0rGGedlOe7U0KGNjroWQ22oC
	 gza3zeIkv62iA==
Date: Mon, 9 Jun 2025 08:37:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>,
 Matt Johnston <matt@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Patrick Williams <patrick@stwcx.xyz>, Peter Yin
 <peteryin.openbmc@gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "mctp: no longer rely on
 net->dev_index_head[]"
Message-ID: <20250609083749.741c27f5@kernel.org>
In-Reply-To: <c4c4f4b58dccb6544f03e4da1827ec8f4f9c4a54.camel@codeconstruct.com.au>
References: <20250609-dev-mctp-nl-addrinfo-v1-1-7e5609a862f3@codeconstruct.com.au>
	<CANn89iJd5FZiOyaHEDrESsZ8h+N7ngfkCNnTRNULxV+xM+qMQg@mail.gmail.com>
	<c4c4f4b58dccb6544f03e4da1827ec8f4f9c4a54.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Jun 2025 22:13:52 +0800 Jeremy Kerr wrote:
> > I would rather make sure f22b4b55edb5 ("net: make
> > for_each_netdev_dump() a little more bug-proof")
> > is backported to kernels using for_each_netdev_dump()  
> 
> Either way works for me, but I assume that changing the semantics of
> for_each_netdev_dump() would be fairly risky for a stable series,
> especially given the amount of testing 6.6.y has had.
> 
> Jakub, as the author of that fix: any preferences?

We should backport it, I can't think of why someone would depend 
on the old behavior.

