Return-Path: <netdev+bounces-137026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD59A40A6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB5F1F22B5D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74CA1DA2FE;
	Fri, 18 Oct 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JkgqFFyS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69D1D7E3D;
	Fri, 18 Oct 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729260347; cv=none; b=n+ENY5YnYS8fDyjaaaEgYPSTc/MGEbyLPL7PC5LYyMdYLaVfBx8X7kAWPgEMEkMujr8CrkTu/ztO7s7Yf5TKilum7AS22ILAIAj71X3PH4ZHyMzJXyvs3CrcweG2R1vkvoWY5aX10xx6JlXK4g04CZpKLicRhvOYe+iwi0NKi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729260347; c=relaxed/simple;
	bh=+RCB/8imlMP7I0R5+dLbRC2pOf22HBd0bzGYlLVD34w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGAvlmM3y39qFkeC+4cqBID1ZWqj/jb1sCtPduGthPGNeVTAO5xbSpQWSXO0stt3+EVTG6npBdb1/BAcU2dbNdaMz4msGjK8cfkeCburZoMgMSqoIhX5dwDPQUVJqhOa8t1MmkZoYgaaquke/RQlcsKoK4xzZ7bhNhW4/SxxJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JkgqFFyS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9xModl0LXKR97D6bTC1dOF0MC+8n7lokOrXW7ATMYxc=; b=JkgqFFyS99QUgDr4rm8w6lew7p
	aboc3E6bt0G5NM5qv/32E/rRv0wVI/+yspOhXMrD5lwreXPsg2GJoNkPWQkiUlmW95/6fMgObZ6I8
	kHxLgWGBysCX2uFuqtL1ER2HOGpOePi+HEeT7Jlpu9EMefe9UrkNw8YoGD/Jwr3sXIE8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1nbc-00AXbU-7a; Fri, 18 Oct 2024 16:05:28 +0200
Date: Fri, 18 Oct 2024 16:05:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/8] rust: time: Add wrapper for fsleep
 function
Message-ID: <e08ce8e2-a44a-425a-aef7-b9fd046970aa@lunn.ch>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-6-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016035214.2229-6-fujita.tomonori@gmail.com>

> +/// This function can only be used in a nonatomic context.
> +pub fn fsleep(delta: time::Delta) {
> +    // SAFETY: FFI call.
> +    unsafe {
> +        // Convert the duration to microseconds and round up to preserve
> +        // the guarantee; fsleep sleeps for at least the provided duration,
> +        // but that it may sleep for longer under some circumstances.
> +        bindings::fsleep(
> +            ((delta.as_nanos() + time::NSEC_PER_USEC - 1) / time::NSEC_PER_USEC) as c_ulong,

You add a as_sec() helper, but then don't use it? If the helper does
not do what you want, maybe the helper is wrong? This is part of why
we say all APIs should have a user.

	Andrew

