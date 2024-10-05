Return-Path: <netdev+bounces-132419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEA3991987
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 20:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4023F282B0A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B202A15B96E;
	Sat,  5 Oct 2024 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3WE5XFed"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73D15B12A;
	Sat,  5 Oct 2024 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728153142; cv=none; b=R2YBrbrD/jhPxb3gwYYo0YEkG8X+b5w6j50FaXcPrZDh628c7LWIlkTECJBVRyES6kaLVURAdmnSc7JTtsmervBXA2xmoBT86VZwacCh9/TaMLVm5HxWV8tfGBOMOT0M0H1P+N1P1cIsAuaPqCzJiNhzkqnb/fFgI+ohuhsIbWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728153142; c=relaxed/simple;
	bh=k4aywGo3+ToqSVGKHrkQjtdm4PA72EIji3yAB8KyJZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjhellfmgUPPL1puI43RRLanJ6kcUyCoSznu4pcjAJ4nIxGPqb6UC7xBZXOWIG0xn5gSN2Tcq7SMDAOUlPFs/jxJ8b0B3l+847aIVy7kZR90SqMQCssKGSKfS1Fy8ink2hMHkHI4MEQHs7k186xJjf/a7kkrpGkhPCEJEn20zUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3WE5XFed; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IAwWbAtE+ZVi4JeitYeaVZGm5lyxXx2jtcW2zxUCW0M=; b=3WE5XFedqEDH5SMg7QSldZIoHU
	HDfEns6uK/KH/7786GG4MYN9xvNcLAEjwxb5npv22ffwzC3lnVbwy27Y/UyqAu55KFm0o0qn3iwgp
	pdqmjtfLIEhtyBTRS8WtwApC/PTTwKxhDED6K3rxFojWRQymD6aBTVznqNFUc8H7xd6Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sx9ZR-0099Bm-6f; Sat, 05 Oct 2024 20:32:01 +0200
Date: Sat, 5 Oct 2024 20:32:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] rust: Add read_poll_timeout function
Message-ID: <06cbea6a-d03e-4c89-9c05-4dc51b38738e@lunn.ch>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005122531.20298-6-fujita.tomonori@gmail.com>

> might_sleep() is called via a wrapper so the __FILE__ and __LINE__
> debug info with CONFIG_DEBUG_ATOMIC_SLEEP enabled isn't what we
> expect; the wrapper instead of the caller.

So not very useful. All we know is that somewhere in Rust something is
sleeping in atomic context. Is it possible to do better? Does __FILE__
and __LINE__ exist in Rust?

> +    if sleep {
> +        // SAFETY: FFI call.
> +        unsafe { bindings::might_sleep() }
> +    }

What is actually unsafe about might_sleep()? It is a void foo(void)
function, so takes no parameters, returns no results. It cannot affect
anything which Rust is managing.

> +        // SAFETY: FFI call.
> +        unsafe { bindings::cpu_relax() }

Same here.

	Andrew

