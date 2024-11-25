Return-Path: <netdev+bounces-147120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE369D7951
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19257B21046
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58366621;
	Mon, 25 Nov 2024 00:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqPde7mu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E51372;
	Mon, 25 Nov 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732494423; cv=none; b=nqHdVsA8JoF8MjTH/uut/Z2aIHw3/6bPZ/tUKzVSF/pb8zfocnKjoLetwpVho4+V1iihLET42a1N63ch0/hGGMbHHD1cD1yi2SpFh29Nd0BvHRO5XeHG9oqTru2izV4/ampnMWsBjmCyHDJ4oj7NkKRMc2zThmn2I05XSFx207Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732494423; c=relaxed/simple;
	bh=KH0/XG5YyrgvJxmq7f9f7f5+Q8jUHpb97a+ADgUrfbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKhAw19xLfnPWJTvBF3Xr33wXl7ThK7keWfXu82tttdjhaBvjyg4KO46K2L+q0vHE7bNQ94KJ/oV3mPu4ZeKbW7gZJ0+ONy8tBL5v+ATRyrG/z2YR2kyqo70EiwXjFMucBatJZLK/nQwpLN3ITbP6B64wT9SA2YU4r9E5WtKcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqPde7mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6C6C4CECC;
	Mon, 25 Nov 2024 00:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732494422;
	bh=KH0/XG5YyrgvJxmq7f9f7f5+Q8jUHpb97a+ADgUrfbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gqPde7muw2FZPO4kyvIRn4JVYJJszSwAl0+IWemtSJRWWstcTCk8Bp+sJmbyRtJEs
	 nAMGGHMXKgeOjjDMGbBwlBiwGH/6Tx3zYewxsCAEdlTNu8cD8rktJanw28Imm4EIor
	 pnchuQLB9U/gzScMUF/x1i9tNLfwDy/u7eEdy299tLz/KbHPHq6Y8VgjMSgDdxrwmP
	 rMYhZ3gb8ShuLfyoN2Fz8/JbHpwehvBBcqijGMigMvB6d0N6KtUvTV6O5SYkAuf6n+
	 OZIHMeiX7YdeTt5wd6auxL18f7u9/hGCcjPd7E/WGDE5b4w908F7GiZ6tQhXHHnLQY
	 7fmFAoTtI4CGg==
Date: Sun, 24 Nov 2024 16:27:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>,
 rust-for-linux@vger.kernel.org
Cc: netdev@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Andrew
 Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] rust: net::phy scope ThisModule usage in the
 module_phy_driver macro
Message-ID: <20241124162700.4ec4b6ce@kernel.org>
In-Reply-To: <20241113174438.327414-3-sergeantsagara@protonmail.com>
References: <20241113174438.327414-3-sergeantsagara@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 17:45:22 +0000 Rahul Rameshbabu wrote:
> Similar to the use of $crate::Module, ThisModule should be referred to as
> $crate::ThisModule in the macro evaluation. The reason the macro previously
> did not cause any errors is because all the users of the macro would use
> kernel::prelude::*, bringing ThisModule into scope.

You say "previously", does it mean there are no in-tree users where
this could cause bugs? If so no Fixes tag necessary..

> Fixes: 2fe11d5ab35d ("rust: net::phy add module_phy_driver macro")
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
> ---
> 
> Notes:
>     How I came up with this change:
>     
>     I was working on my own rust bindings and rust driver when I compared my
>     macro_rule to the one used for module_phy_driver. I noticed, if I made a
>     driver that does not use kernel::prelude::*, that the ThisModule type
>     identifier used in the macro would cause an error without being scoped in
>     the macro_rule. I believe the correct implementation for the macro is one
>     where the types used are correctly expanded with needed scopes.

Rust experts, does the patch itself make sense?

> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 910ce867480a..80f9f571b88c 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -837,7 +837,7 @@ const fn as_int(&self) -> u32 {
>  ///         [::kernel::net::phy::create_phy_driver::<PhySample>()];
>  ///
>  ///     impl ::kernel::Module for Module {
> -///         fn init(module: &'static ThisModule) -> Result<Self> {
> +///         fn init(module: &'static ::kernel::ThisModule) -> Result<Self> {
>  ///             let drivers = unsafe { &mut DRIVERS };
>  ///             let mut reg = ::kernel::net::phy::Registration::register(
>  ///                 module,
> @@ -899,7 +899,7 @@ struct Module {
>                  [$($crate::net::phy::create_phy_driver::<$driver>()),+];
>  
>              impl $crate::Module for Module {
> -                fn init(module: &'static ThisModule) -> Result<Self> {
> +                fn init(module: &'static $crate::ThisModule) -> Result<Self> {
>                      // SAFETY: The anonymous constant guarantees that nobody else can access
>                      // the `DRIVERS` static. The array is used only in the C side.
>                      let drivers = unsafe { &mut DRIVERS };
> 
> base-commit: 73af53d82076bbe184d9ece9e14b0dc8599e6055


