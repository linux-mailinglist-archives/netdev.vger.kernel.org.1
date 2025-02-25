Return-Path: <netdev+bounces-169372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E864A43966
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BD21889FB8
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89F713A88A;
	Tue, 25 Feb 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kgq8EhGF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9C4C80
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475332; cv=none; b=T9oMzKXHRUnLjUCYhvLI/uxJ9Lr/llJXDXNinVgzcwbGBrOsonUPVG+dJ0zaETj7TRZR+On6S205WdMAsroj+NVwPegpWV9TtaakQYowEDD9iw+3Jnf2zeFO1Ho6pELPaYsG1QwjSqWekgBzIsXFiKwFJwD1nbAYzJXxNOFCbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475332; c=relaxed/simple;
	bh=ghBZlERKySYoRjKVYWwh2srPu0NK7DrzmXz35z9CGgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEqhawojvJ9H/L8RWTDyWenpIW0kw0lbb+DDuF9DzijgpzIYfuFCAOpKimS+Fkbihy1b3bLNmrVGQZGZ/7mhvZu7mSQgv8TGgaeAsuLcZnmVLNyWWujG7HVT9rt9OUnrJ2dMwUXkYNlL2sxYrj/BQNRrtKYuMhkl8FgVu5a3D0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kgq8EhGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F440C4CEDD;
	Tue, 25 Feb 2025 09:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740475332;
	bh=ghBZlERKySYoRjKVYWwh2srPu0NK7DrzmXz35z9CGgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kgq8EhGFOBvEr+lDUqQMUft8W0Eex2vjLKXaMPTtHyOp65FAZAhbk7dixQUJHZVO/
	 f09b0xkMNYR0+veIo7MAbv8UvviKwmrN3a/trLZpzX7QazYVjYILp6gvJReIC/ULpf
	 fCea9/GtDn8uzUNlZNogtnsZ0JR1YIjc8nBBgLpHp1BIs+dFWEZVJ/VlEPPH3nLGqx
	 w5RYQu/D5lTll/ClZD3dXZdSJNCzjii3cls1ZET9Z4XPgaR4DjCvZfHEnO5rCvZCLd
	 vvqAYV0ROp2V8UsYbPuc5tLy/vOvEgTQVZVGiK9kydDIr52WW+r/r5yCCGLVpVGqUj
	 W90LkEYjq6ibQ==
Date: Tue, 25 Feb 2025 11:22:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Subject: Re: [PATCH ipsec-next] xfrm: remove hash table alloc/free helpers
Message-ID: <20250225092206.GG53094@unreal>
References: <20250224171055.15951-1-fw@strlen.de>
 <20250225080440.GE53094@unreal>
 <20250225082832.GA6982@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225082832.GA6982@breakpoint.cc>

On Tue, Feb 25, 2025 at 09:28:32AM +0100, Florian Westphal wrote:
> Leon Romanovsky <leon@kernel.org> wrote:
> > > xfrm_hash_free() is kept around because of 'struct hlist_head *' arg type
> > > instead of 'void *'.
> > 
> > <...>
> > 
> > > -struct hlist_head *xfrm_hash_alloc(unsigned int sz);
> > > -void xfrm_hash_free(struct hlist_head *n, unsigned int sz);
> > > +static inline struct hlist_head *xfrm_hash_alloc(unsigned int sz)
> > > +{
> > > +	return kvzalloc(sz, GFP_KERNEL);
> > > +}
> > >  
> > > +static inline void xfrm_hash_free(struct hlist_head *n)
> > > +{
> > > +	kvfree(n);
> > > +}
> > 
> > Sorry, what does this wrapper give us?
> > You are passing pointer as is and there is no any pointer type check
> > that this construction will give us.
> 
> Compiler will warn when the argument is something other than a pointer
> to a hlist_head.

I personally didn't see any bug where wrong pointer was passed to kfree :).

> 
> I can send a v2 with this wrapper removed if you don't think its worth it.

It is up to you.

> 
> Thanks for reviewing.
> 

