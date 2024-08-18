Return-Path: <netdev+bounces-119495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4255955E4C
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 19:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E30E1F20FDA
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16DF80054;
	Sun, 18 Aug 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ek0ON/Jd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B11D551;
	Sun, 18 Aug 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002768; cv=none; b=TpW75yVfvaR51vTGM4gW5KuOFpU5l8x4kYYHBBfngL3isE3e1HcubtfW+ZonQpHfgQ/COm3TGPtKL4xSFFGEf1u7F93L2pQtl70BaVd5PwGZJ/ZHLuKjf48/mwZ6Tb+sQxye+B9K5h1e+rkfBXn8qbNcMZeB1169hiu/9PYjnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002768; c=relaxed/simple;
	bh=MUispAl9g8BbGpxRcKkTd+9L1jsuZPQybAuNsLB6KoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsQ7VIdwpABFoOGWKAFMZjHChWWK+31IDkeTMzNHEInDANXW5GBrYUyKghQcreL0fDJIZmu4/RV3GZ+NPqgZ6Y4E74c20g94REl666azz6+1HR4g33DJJr6XweyrRHpku4m0ZiR9Fd9bl0BYK7Pn8uLLzVNKx1sxSmAz/cwOu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ek0ON/Jd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wKSOkNO8Sg+YG0BLKTf4EZv5hDKZoidIasg9HDR/uto=; b=Ek0ON/JdiX/L6KWMeMx8fPwcGS
	ZspKWJm6Jr3HF+kDo0ILqBKbXkUlAP+/LpHwHCxEIYhbdkyaqiRPl1amtuzwWijv5CkyALb2zoo//
	2mxbjT4+R+3sXynFzgVofEdxkYeizheKorvCtbKXAd3e6Oox61neW7NjBHr95Z/Uylog=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfjsC-0052z2-5c; Sun, 18 Aug 2024 19:39:24 +0200
Date: Sun, 18 Aug 2024 19:39:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <bdfdac7c-edb0-4b78-b616-76be287c7597@lunn.ch>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
 <20240817051939.77735-7-fujita.tomonori@gmail.com>
 <9a7c687a-29a9-4a1a-ad69-39ce7edad371@lunn.ch>
 <7f835fe8-e641-4b84-a080-13f4841fb64a@proton.me>
 <1a717f2d-8512-47bd-a5b3-c5ceb9b44f03@lunn.ch>
 <0797f8e8-ea3c-413d-b782-84dd97919ea9@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0797f8e8-ea3c-413d-b782-84dd97919ea9@proton.me>

> Then you get this error:
> 
>     error: unused `core::result::Result` that must be used
>       --> drivers/net/phy/qt2025.rs:88:9
>        |
>     88 |         dev.genphy_read_status::<C45>();
>        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>        |
>        = note: this `Result` may be an `Err` variant, which should be handled
>        = note: `-D unused-must-use` implied by `-D warnings`
>        = help: to override `-D warnings` add `#[allow(unused_must_use)]`
>     help: use `let _ = ...` to ignore the resulting value
>        |
>     88 |         let _ = dev.genphy_read_status::<C45>();
>        |         +++++++

O.K, so the compiler tells you, which is great. The C compiler would
not, which is why i tend to think of these things.

	Andrew

