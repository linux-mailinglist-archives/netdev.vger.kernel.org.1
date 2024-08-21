Return-Path: <netdev+bounces-120388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAA69591BB
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 02:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE81C20FC4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B7F9E4;
	Wed, 21 Aug 2024 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ht1lMh+x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F2F510;
	Wed, 21 Aug 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199745; cv=none; b=TrS+JuON2l1tL9Wsc5GO3zOaEB1M66bGAvt0MEo1qWK7zGofNnQ5Jdkhk1gsh1ijxDZMok6/NlPadUE0Sl3qrjYB64UnanwPxQ+9WZHgmB7wzOpyukW7HLEhekEcF6WHBqsz73YUaafV9SzFWe27cHoJvK9EB82ipUzoYvBCu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199745; c=relaxed/simple;
	bh=fOa1cEJ/E2+mB7MJ4he/MyTHRycelX40z6QjkAR1dBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRsHQcf4euCKCPkrG4mIL3zxwzEM4clpWflVS7pF2AIr563GVi1bmu5itiJ0/e6a9Dx/53h6ZjjkiS1d+cSm5U54Wdr5JG1Xp8vcv38aYHRCbHXVJDpQAexti5a526WSDP4w89EgWzWN4+WKa8lu45UGDjk/F/dnddqsRSDCZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ht1lMh+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11072C4AF09;
	Wed, 21 Aug 2024 00:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724199744;
	bh=fOa1cEJ/E2+mB7MJ4he/MyTHRycelX40z6QjkAR1dBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ht1lMh+x9A9cvtvfZBvR9gSWwn+sG1G9zai0TmOyvsOk6cSYTTkqkMNaKmBdHL1mo
	 Qw8d3zzqk89HobZPx0OjxNu4a+JWH3+PPXHX/P77NLY6lNyRHaDNeLb2xcWoBTgFRZ
	 DYIIHmYFV0kfs6lGJbTcJgJ9ulzSpzWmOBFR/DIM=
Date: Wed, 21 Aug 2024 08:22:21 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
	aliceryhl@google.com
Subject: Re: [PATCH net-next v6 1/6] rust: sizes: add commonly used constants
Message-ID: <2024082100-estate-eccentric-c1a6@gregkh>
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
 <20240820225719.91410-2-fujita.tomonori@gmail.com>
 <2024082121-anemic-reformed-de75@gregkh>
 <93e4d643-a38b-4416-9097-af11b9c60f56@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e4d643-a38b-4416-9097-af11b9c60f56@kernel.org>

On Wed, Aug 21, 2024 at 01:54:43AM +0200, Danilo Krummrich wrote:
> On 8/21/24 1:41 AM, Greg KH wrote:
> > On Tue, Aug 20, 2024 at 10:57:14PM +0000, FUJITA Tomonori wrote:
> > > Add rust equivalent to include/linux/sizes.h, makes code more
> > > readable.
> > > 
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > > ---
> > >   rust/kernel/lib.rs   |  1 +
> > >   rust/kernel/sizes.rs | 26 ++++++++++++++++++++++++++
> > >   2 files changed, 27 insertions(+)
> > >   create mode 100644 rust/kernel/sizes.rs
> > > 
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index 274bdc1b0a82..58ed400198bf 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
> > > @@ -43,6 +43,7 @@
> > >   pub mod page;
> > >   pub mod prelude;
> > >   pub mod print;
> > > +pub mod sizes;
> > >   mod static_assert;
> > >   #[doc(hidden)]
> > >   pub mod std_vendor;
> > > diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
> > > new file mode 100644
> > > index 000000000000..834c343e4170
> > > --- /dev/null
> > > +++ b/rust/kernel/sizes.rs
> > > @@ -0,0 +1,26 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Commonly used sizes.
> > > +//!
> > > +//! C headers: [`include/linux/sizes.h`](srctree/include/linux/sizes.h).
> > > +
> > > +/// 0x00000400
> > > +pub const SZ_1K: usize = bindings::SZ_1K as usize;
> > > +/// 0x00000800
> > > +pub const SZ_2K: usize = bindings::SZ_2K as usize;
> > > +/// 0x00001000
> > > +pub const SZ_4K: usize = bindings::SZ_4K as usize;
> > > +/// 0x00002000
> > > +pub const SZ_8K: usize = bindings::SZ_8K as usize;
> > > +/// 0x00004000
> > > +pub const SZ_16K: usize = bindings::SZ_16K as usize;
> > > +/// 0x00008000
> > > +pub const SZ_32K: usize = bindings::SZ_32K as usize;
> > > +/// 0x00010000
> > > +pub const SZ_64K: usize = bindings::SZ_64K as usize;
> > > +/// 0x00020000
> > > +pub const SZ_128K: usize = bindings::SZ_128K as usize;
> > > +/// 0x00040000
> > > +pub const SZ_256K: usize = bindings::SZ_256K as usize;
> > > +/// 0x00080000
> > > +pub const SZ_512K: usize = bindings::SZ_512K as usize;
> > 
> > Why only some of the values in sizes.h?
> > 
> > And why can't sizes.h be directly translated into rust code without
> > having to do it "by hand" here?  We do that for other header file
> > bindings, right?
> 
> Those are all generated bindings from C headers, e.g. `bindings::SZ_2K `, but
> bindgen isn't guaranteed to assign the type we want (`usize` in this case), plus
> for size constants having the `bindings::` prefix doesn't really add any value.
> 
> Rust could also define those without using bindings at all, but this was already
> discussed in earlier versions of this series.

Then this information should probably go in the changelog text so that
others don't keep asking the same question :)

thanks,

greg k-h

