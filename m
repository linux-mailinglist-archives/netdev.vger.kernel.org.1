Return-Path: <netdev+bounces-120380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7446959148
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CB31F232CC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B5B1C8FAB;
	Tue, 20 Aug 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fjzrP2UC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE414A4F0;
	Tue, 20 Aug 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724197288; cv=none; b=CuwIgjokmDnVHEETJeKR+Kpz8h/YmY19AoyFFld4tgIemPBiSgc/o1H4K0Coet5tWN1K3TAiDBDDMslRUv0Xm5/gB7+wXvdLKdiyUtIlkjvIU7NdnbbBUJFfL+XyWB80nsAJ6kGLg18AHhctUpnqRzxw+SVzi9gof1pyrPxwQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724197288; c=relaxed/simple;
	bh=2C1+fevqxPQfpmLOWSDAXkqFMWb31NM79hCoChzWAJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ7txzFIpmkWthBDjd0lrWXM4sySNiwrWiinbBIsHhc+2/6Cy7H0ww8xFqG4aifX04eLZBLBn1+5RQeTHwHl5THJ6paT6dKkDIL1Bx+YS0TxuGPMWi4HpqVAB5cQDjeKfi5t6nbSmMXhPrge387U7xFMWDfBU3MpZdUQ/1juLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fjzrP2UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FFCC4AF09;
	Tue, 20 Aug 2024 23:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724197288;
	bh=2C1+fevqxPQfpmLOWSDAXkqFMWb31NM79hCoChzWAJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjzrP2UCDe6P96m/i5mMRm6/os3z55k5saXaXiGdplqziJR08esyx4eDTYs1VSvJn
	 Td+wjiMx7UgbU3VkkYwo9zPncFLdH1smgsbP0GbqqGdRK1D+ofiZqPm6xwvsJDeCbT
	 iFcbWtGGcF/TQJdRQwRQ6YIiKpNJAu/sVU0I0FAM=
Date: Wed, 21 Aug 2024 07:41:24 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v6 1/6] rust: sizes: add commonly used constants
Message-ID: <2024082121-anemic-reformed-de75@gregkh>
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
 <20240820225719.91410-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820225719.91410-2-fujita.tomonori@gmail.com>

On Tue, Aug 20, 2024 at 10:57:14PM +0000, FUJITA Tomonori wrote:
> Add rust equivalent to include/linux/sizes.h, makes code more
> readable.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/lib.rs   |  1 +
>  rust/kernel/sizes.rs | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 rust/kernel/sizes.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 274bdc1b0a82..58ed400198bf 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -43,6 +43,7 @@
>  pub mod page;
>  pub mod prelude;
>  pub mod print;
> +pub mod sizes;
>  mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
> diff --git a/rust/kernel/sizes.rs b/rust/kernel/sizes.rs
> new file mode 100644
> index 000000000000..834c343e4170
> --- /dev/null
> +++ b/rust/kernel/sizes.rs
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Commonly used sizes.
> +//!
> +//! C headers: [`include/linux/sizes.h`](srctree/include/linux/sizes.h).
> +
> +/// 0x00000400
> +pub const SZ_1K: usize = bindings::SZ_1K as usize;
> +/// 0x00000800
> +pub const SZ_2K: usize = bindings::SZ_2K as usize;
> +/// 0x00001000
> +pub const SZ_4K: usize = bindings::SZ_4K as usize;
> +/// 0x00002000
> +pub const SZ_8K: usize = bindings::SZ_8K as usize;
> +/// 0x00004000
> +pub const SZ_16K: usize = bindings::SZ_16K as usize;
> +/// 0x00008000
> +pub const SZ_32K: usize = bindings::SZ_32K as usize;
> +/// 0x00010000
> +pub const SZ_64K: usize = bindings::SZ_64K as usize;
> +/// 0x00020000
> +pub const SZ_128K: usize = bindings::SZ_128K as usize;
> +/// 0x00040000
> +pub const SZ_256K: usize = bindings::SZ_256K as usize;
> +/// 0x00080000
> +pub const SZ_512K: usize = bindings::SZ_512K as usize;

Why only some of the values in sizes.h?

And why can't sizes.h be directly translated into rust code without
having to do it "by hand" here?  We do that for other header file
bindings, right?

thanks,

greg k-h

