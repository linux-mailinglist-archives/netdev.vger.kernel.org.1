Return-Path: <netdev+bounces-132413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA8699192A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78AEB21A06
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4B146592;
	Sat,  5 Oct 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vkv6snKJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702B140C15;
	Sat,  5 Oct 2024 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151400; cv=none; b=DVK8Mr+JT8/Gjx+DcvFeLT9WYFj3P1YNjtmUG1IkXqRlp0MJWPlFPkUsliOriwn9OnTpcj01EdNLQGLpCJe7yhFw3xydvFivEpTHMNPCSQyUaUcXAkLNuKbGr6z0U846t581TNvMGkjaQIcM5sPWSf6QpcOyfjvWx9aP0avYfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151400; c=relaxed/simple;
	bh=EuhI4PbtmA1CdWKcn5dQlDHomXi2n7CB6JciD1aQyhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9LrZLGtej7gDmR0qwkduZlZbrvph4wpyIEtSPBHhQqYZvYh3DvQus15qoln/bPIR1rAgu4ePNtczFQMEzuwvQyfnWJ21HwQaSXwAcYRxQtjdqB5UiFeLGXth1I7BXzKo2Uo11UlCq1Cs5WOytW9wrZin/bNQXC19b+ZlcrkC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Vkv6snKJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8sSguXETkbnC8AcMv4h0F2S6mFERoM2NTtTrLgWtJvw=; b=Vkv6snKJTNeOP53+iuObo3XgKJ
	/rWpWlKunyT9z3VcG7/ZgAhEmQuro41+5IGwSoRgzOG1jpGa7W1BQBBeA62RHUx0w9darE/z9KXU0
	uuMqgW3Ff4BsK4TFwhm/dVhEuKf3J6ehs6pB2sMqi/EVk4McbiUyHuwnVlQx+mpXxp2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx97H-00994w-DG; Sat, 05 Oct 2024 20:02:55 +0200
Date: Sat, 5 Oct 2024 20:02:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
Message-ID: <3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005122531.20298-3-fujita.tomonori@gmail.com>

> +/// A span of time.
> +#[derive(Copy, Clone)]
> +pub struct Delta {
> +    nanos: i64,

Is there are use case for negative Deltas ? Should this be u64?

A u64 would allow upto 500 years, if i did my back of an envelope
maths correct. So i suppose 250 years allowing negative delta would
also work.

> +}
> +
> +impl Delta {
> +    /// Create a new `Delta` from a number of nanoseconds.
> +    #[inline]
> +    pub fn from_nanos(nanos: u16) -> Self {

So here you don't allow negative values.

But why limit it to u16, when the base value is a 63 bits? 65535 nS is
not very long.

> +        Self {
> +            nanos: nanos.into(),
> +        }
> +    }
> +
> +    /// Create a new `Delta` from a number of microseconds.
> +    #[inline]
> +    pub fn from_micros(micros: u16) -> Self {

A u32 should not overflow when converted to nS in an i64.

Dumb question. What does Rust in the kernel do if there is an
overflow?

> +    /// Return the number of nanoseconds in the `Delta`.
> +    #[inline]
> +    pub fn as_nanos(self) -> i64 {
> +        self.nanos
> +    }
> +
> +    /// Return the number of microseconds in the `Delta`.
> +    #[inline]
> +    pub fn as_micros(self) -> i64 {
> +        self.nanos / NSEC_PER_USEC
> +    }
> +}

So here we are back to signed values. And also you cannot create a
Delta from a Delta because the types are not transitive.

	Andrew

