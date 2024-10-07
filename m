Return-Path: <netdev+bounces-132696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09BC992D78
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED7A1C22AB5
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C931D54D6;
	Mon,  7 Oct 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z4ZAl78g"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C721D4320;
	Mon,  7 Oct 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308014; cv=none; b=ptgJm1Vmp/J0fCiodlbkmepYPl657oybJmyITwqgNq0eDMOTT1vRUJ++q7ojD18eFqmcFXtV64TzKpCkXU10Su/xrD/byYUqWAxmOomsq+Rv549Ad3X4P2BZJM+FTTQvlEAM1Pj/gjsN4ETVq4Njl6KsO7cFFR4X1H4pwOCKv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308014; c=relaxed/simple;
	bh=7XkLgux/mmCu9ej4L4xrAIwzwCX0qoF6a8unFDU24y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAGx1fpE4E/ICXzYVPYg3IjBxWCQ5xmme8cOhKfrNtu9jBVydvMhu46/qQBrIxbMGx6MiwFXjOY7WpDVgAmBB3OtuPgora0nUP196Lv8dQyVlM2nogJucvT+kkcAor5xO1mR3r5nLMWcBesLh2dW+39uyxvx+t9O33XwiVsWU9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z4ZAl78g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=N7keAL0fN5A2rYpWEAF2Fn6KYKz3K/xUhGpXZg4dQPQ=; b=z4ZAl78gmvqFkrfOwsGR6N+iQY
	gtma2Lmls+AwCm8F1c6rG/YnpMcXrBLsZHRQ+01cxUZFG7eO9daAeH3COy/t6HrsCzGTLY7QpLS9Q
	OEjnbhn+yfLMn4hLP8OgQ6lzFk+qNHbiJYbRPUOUj/p1YSYuokZKL1vTvliUBpcIbDdU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sxnrN-009GXE-VL; Mon, 07 Oct 2024 15:33:13 +0200
Date: Mon, 7 Oct 2024 15:33:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
Message-ID: <54924687-4634-4a41-9f0f-f052ac34e1bf@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-3-fujita.tomonori@gmail.com>
 <3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
 <20241007.150148.1812176549368696434.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007.150148.1812176549368696434.fujita.tomonori@gmail.com>

> I thought that from_secs(u16) gives long enough duration but
> how about the following APIs?
> 
> pub fn from_nanos(nanos: u64)
> pub fn from_micros(micros: u32)
> pub fn from_millis(millis: u16) 
> 
> You can create the maximum via from_nanos. from_micros and from_millis
> don't cause wrapping.

When i talked about transitive types, i was meaning that to_nanos(),
to_micros(), to_millis() should have the same type as from_nanos(),
to_micros(), and to_millis().

It is clear these APIs cause discard. millis is a lot less accurate
than nanos. Which is fine, the names make that obvious. But what about
the range? Are there values i can create using from_nanos() which i
cannot then use to_millis() on because it overflows the u16? And i
guess the overflow point is different to to_micros()? This API feels
inconsistent to me. This is why i suggested u64 is used
everywhere. And we avoid the range issues, by artificially clamping to
something which can be represented in all forms, so we have a uniform
behaviour.

But i have little experience of dealing with time in the kernel. I
don't know what the real issues are here, what developers have been
getting wrong for the last 30 years etc.

	Andrew

