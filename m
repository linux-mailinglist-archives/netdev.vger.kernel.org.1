Return-Path: <netdev+bounces-114557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE5942DE8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634EC1C21B5E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F78F1AB52E;
	Wed, 31 Jul 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C2v6Yaxe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F118E03E;
	Wed, 31 Jul 2024 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428224; cv=none; b=VEfJYpNRynGuZgw49a17CAIWIoBvmV7jIr4xnAOGA++dZ3GpRtQ0/HUP+sMzo5wtCFL7gZEh5/JXnbAY5vmLDIcWqANLBorR/rgc3iieAlZCL1Oh9RIA9eQDKEZceHTUnpuNupD4knzNgbk8yOFbN0qPf+HQMo8YiFrlQsHKJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428224; c=relaxed/simple;
	bh=97pZF4oHEpPR9yYU9guO8N7AGSkoqCshx75Uwh4wruU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uyj38YferXOIpuCltvfR/GmkV4YqXBYZRKNVFbHIIU43P8Dl3wdsB2CX+7HpeBFlz1GaHPNGzvE/endr+Ym1mgyaBpSnNreuWoem2ToMyDauN0VowN93W9gm+4AOclwBm+dEA8J4zitwOhsIvgoUme4RVlom7SNlfuW93yxisfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C2v6Yaxe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SOXrg7FLR6aEPYT1+0tfp7kMuAflPXYhxMOZPj/mGWk=; b=C2v6YaxeFXluBIcR/3qAKzmsqF
	EKyEIMcIkID3tS2PvkD2sFT/FqkHK38qGFNXc1RfREecKDC5jCTSQH3ExzFxYTFAIGJaWkT5W0V7M
	RsM4sLNGc3nxG8Jp/OPS6Ds6bZ7i0X+wIKpfrUlJZqywIc1dFlJiPvGeIcn3YUyNriuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZ8GI-003fig-2P; Wed, 31 Jul 2024 14:16:58 +0200
Date: Wed, 31 Jul 2024 14:16:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: Re: [PATCH net-next v2 1/6] rust: sizes: add commonly used constants
Message-ID: <6749fc34-c4e0-4971-8ab8-7d39260fc9bb@lunn.ch>
References: <20240731042136.201327-1-fujita.tomonori@gmail.com>
 <20240731042136.201327-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731042136.201327-2-fujita.tomonori@gmail.com>

On Wed, Jul 31, 2024 at 01:21:31PM +0900, FUJITA Tomonori wrote:
> Add rust equivalent to include/linux/sizes.h, makes code more
> readable. This adds only SZ_*K, which mostly used.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/lib.rs   |  1 +
>  rust/kernel/sizes.rs | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 rust/kernel/sizes.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e6b7d3a80bbc..ba2ba996678d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -42,6 +42,7 @@
>  pub mod net;
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

1K is 1K, independent of it being C 1K or Rust 1K. In this case, does
it makes sense to actually use the C header? I don't know? But the
Rust people seems to think this is O.K.

   Andrew

