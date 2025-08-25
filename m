Return-Path: <netdev+bounces-216688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4EB34F53
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390397B0F27
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD2D2C0F96;
	Mon, 25 Aug 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="EeGXvLO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6742C15AF;
	Mon, 25 Aug 2025 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162554; cv=none; b=H37cbo74PMbg7d41kK6sHZ45ISz9pZnX2V/6SDRT6R5rClDesHahl1+e2IOAQFlVyT2vo/gxrxZbfvg5178ROJeYWPZXZlmiQcGxoVeHSZ8w9jAnX9x1Tz9r64Aq6USE/LEvyIQp+gZNCYDu3/oI6krJJ4SUwp9f8SoS7DGxQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162554; c=relaxed/simple;
	bh=JtulgEh6jYZtyqJxDxTVj0G4v8UXD+NesCTAkrOa2wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6mNaVXmVoYAYuIfmVRsXsK0Zob5njGcszOW0bxn/YPJZvoeWY8UxZquug6csvCR8OAx5TKkSjy0FpkV1VdjJ+RE1KXY1GOl/4tQQ27GdXj2aJ79FwV12VmHp17LOdSt+9MowwVq1m9j9Hc9Sp4b5p+g0RuB2q1wXgEOidPXMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=EeGXvLO1; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1756162547; x=1756421747;
	bh=HmCIauylymQ9p5rm2SUsT9VM1At8y856vEpUbWcApvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EeGXvLO15UjBXqRSxY8u/b7UQHR495zCGnhU5rOFzb9vKXn6xjr7O9MOKAbMe19qx
	 k02FnSFmmSp4gvCAH/Noks6a27OgtiXKuEaJjikcKM1DExu4rfbhhTBIbx/5v3NduB
	 ej3mjXgDZArGnoggJc4F+gtr1Zb9QgZXf6lGffrz+2lSilvHDr5biU6EHYDAOs8YXf
	 Z+U37p2PbJzItXfmoBAAPqsw6fG0lRPbce5g0dGx1oQcPFQTi2vfvywgFA/s+2a3Fz
	 8KYl//Ii6CG+2rpO4FENrMc0T16NZIaV1AT9x3h1zE29ark6UtY41THtnx4h6G7McT
	 N48S96XoIrQcA==
X-Pm-Submission-Id: 4c9mNd0XdGz2ScX6
Date: Mon, 25 Aug 2025 22:55:42 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com,
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	dakr@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: phy: use to_result for error handling
Message-ID: <aKzp7sv-73BZGUqT@archiso>
References: <20250821091235.800-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821091235.800-1-work@onurozkan.dev>

On Thu, Aug 21, 2025 at 12:12:35PM +0300, Onur Özkan wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/net/phy.rs | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 7de5cc7a0eee..c895582cd624 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -196,11 +196,8 @@ pub fn read_paged(&mut self, page: u16, regnum: u16) -> Result<u16> {
>          // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>          // So it's just an FFI call.
>          let ret = unsafe { bindings::phy_read_paged(phydev, page.into(), regnum.into()) };
> -        if ret < 0 {
> -            Err(Error::from_errno(ret))
> -        } else {
> -            Ok(ret as u16)
> -        }
> +
> +        to_result(ret).map(|()| ret as u16)
>      }
> 
>      /// Resolves the advertisements into PHY settings.
> --
> 2.50.0

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

