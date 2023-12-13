Return-Path: <netdev+bounces-57080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CAF8120E9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31262826A0
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 21:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC497FBA8;
	Wed, 13 Dec 2023 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SRMjANT1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4916DE3;
	Wed, 13 Dec 2023 13:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MnuwIncJ+1uHR/ZbVaq1see8GJHClbLY2HX2n4sRIY8=; b=SRMjANT1sRoeT1QavByhvAstHk
	rugjG5ubjW//AU+dHdv/yxcOkVfJv2yqjjC8kgNYvXCRer9Y153LISjbsgLs+W0zBDHjHjGDGAI27
	KkGJnKToSU3eKOpDb/avFoy54lF8EI1fI0mPvDqnVVi0zFYuJMHPeRydmBhhwZMbAl2I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDX5r-002rT1-Lx; Wed, 13 Dec 2023 22:48:39 +0100
Date: Wed, 13 Dec 2023 22:48:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <83511ed4-1fbe-4cf6-ba63-5f7e638ea2a1@lunn.ch>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux>
 <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
 <ZXfFzKYMxBt7OhrM@boqun-archlinux>
 <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
 <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
 <67da9a6a-b0eb-470c-ae43-65cf313051b3@lunn.ch>
 <ZXnfHbKE3K_J4yul@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXnfHbKE3K_J4yul@Boquns-Mac-mini.home>

> Well, a safety comment is a basic part of Rust, which identifies the
> safe/unsafe boundary (i.e. where the code could go wrong in memory
> safety) and without that, the code will be just using Rust syntax and
> grammar. Honestly, if one doesn't try hard to identify the safe/unsafe
> boundaries, why do they try to use Rust? Unsafe Rust is harder to write
> than C, and safe Rust is pointless without a clear safe/unsafe boundary.
> Plus the syntax is not liked by anyone last time I heard ;-)

Maybe comments are the wrong format for this? Maybe it should be a
formal language? It could then be compiled into an executable form and
tested? It won't show it is complete, but it would at least show it is
correct/incorrect description of the assumptions. For normal builds it
would not be included in the final binary, but maybe debug or formal
verification builds it would be included?

> Having a correct safety comment is really the bottom line. Without that,
> it's just bad Rust code, which I don't think netdev doesn't want either?
> Am I missing something here?

It seems much easier to agree actual code is correct, maybe because it
is a formal language, with a compiler, and a method to test it. Is
that code really bad without the comments? It would be interesting to
look back and see how much the actual code has changed because of
these comments? I _think_ most of the review comments have resulted in
changes to the comments, not the executable code itself. Does that
mean it is much harder to write correct comments than correct code?

       Andrew

