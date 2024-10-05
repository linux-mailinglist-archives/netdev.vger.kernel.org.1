Return-Path: <netdev+bounces-132414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE299193D
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 20:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128801F22398
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7331615B559;
	Sat,  5 Oct 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nM4PzeDZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C215B561;
	Sat,  5 Oct 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151668; cv=none; b=P+BKG0PBY0og7XB0xhGa+pOE8gL6SLqlRtGnxIXnCAt2WoZItu6qWUV1hEkbeM6cue4x5aaS7BcZIukeaRbSY4Sha2EdoGMfFPBhxpt4YIWziAsTg5hvtZQETtXEdQkC1veekrUdZX5olkfa6HKDx7L5gOqZTUFAK4NyLC0eotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151668; c=relaxed/simple;
	bh=Jury7jyG5GvB/OmkLxA5xdj59+oU45l2EnCjy0e21dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7ZGkay7k1zAL0rAXErvhtG2A/qX5uB8f8Xxc4eQuMX1pGP1lVBkswc35zmQtK1o3XS8O54l199cTLPiIUHLAExApUC0TOqq8KiYi3zAlec28WZfwS6bWSK7QtRgxdGXfzGgYXyw7A6DnHxhhz0GA5V6TjWehNzhM2nu6QcVmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nM4PzeDZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0aIY657icUSEdbHhHJhyqSFrO4ck2JZbAE0jcwzjCWI=; b=nM4PzeDZLL2J+acZrteptoFQYW
	JqGCMUCbFRNTlof/6VAyULA3b/qxSlQtoSfo1ACsLWQq6M1+EsPaT9S1Xm466Fp6OK+El9wKRytZL
	SpyT0KTgEjLOWuGmEAX8gMKH/tpaT8HjY9/zfnL2/W9e5Ko/kiqfimw7vwEdHLraDQf4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx9Bj-00996D-E6; Sat, 05 Oct 2024 20:07:31 +0200
Date: Sat, 5 Oct 2024 20:07:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] rust: time: Implement addition of Ktime
 and Delta
Message-ID: <e540d2cd-2c47-4057-9000-8d403247abf6@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005122531.20298-4-fujita.tomonori@gmail.com>

On Sat, Oct 05, 2024 at 09:25:28PM +0900, FUJITA Tomonori wrote:
> Implement Add<Delta> for Ktime to support the operation:
> 
> Ktime = Ktime + Delta
> 
> This is used to calculate the future time when the timeout will occur.

Since Delta can be negative, it could also be a passed time. For a
timeout, that does not make much sense.

> +impl core::ops::Add<Delta> for Ktime {
> +    type Output = Ktime;
> +
> +    #[inline]
> +    fn add(self, delta: Delta) -> Ktime {
> +        // SAFETY: FFI call.
> +        let t = unsafe { bindings::ktime_add_ns(self.inner, delta.as_nanos() as u64) };

So you are throwing away the sign bit. What does Rust in the kernel do
if it was a negative delta?

I think the types being used here need more consideration.

	Andrew


