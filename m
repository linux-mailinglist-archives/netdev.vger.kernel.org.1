Return-Path: <netdev+bounces-119379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 259EB9555A3
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 07:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1F4B22816
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 05:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCD47F7CA;
	Sat, 17 Aug 2024 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CAYvVyjq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB2101DE;
	Sat, 17 Aug 2024 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723874009; cv=none; b=nEi2mDGXDnwty8pBvcgjdbFv/bwtnD6VbaOmdU8IuLLbiv/2JfxaQug3Ed76xu1EVkTzZna4inC2I1UueKnEwdVYjJT73NoDpS5umxNEnUnuF+WSXJaBnMfQ4nIJPANTH98FNw1ciB9QqStQmgV0t8YUgl+CskVZ0spDPEPHjiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723874009; c=relaxed/simple;
	bh=r3s33uqtMLMjUNemSpNRXmHtlunmWTJ2M/hYdutcdNM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNh8Ql1uZHENNvFT8GX9VNG/vtMNCvXmEnuHzkUfNTx8KYS/7i6pFzfqHWvemDb7ANJCgmCzaBaLjVRS7nEVJWIKm3n/6RerTTMWuqxubSDOYfe5+k+9fJosjmW4w/VepaZVPE7gZ8V9IsxLrC06iYmIfXyb1z4o8gPPWIegh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CAYvVyjq; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723873996; x=1724133196;
	bh=ERyRIby2dPM/hZ/0cK3OuN0NVmyPjV3yJM+DrrW2qaE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CAYvVyjqAE1Rae41bv2RnUYbC75FLbKkF4PaClcZFabulQq62JVlQKkej4VNvhUNF
	 W9g26DmEN8u5TSJ8zrnxHRECWzz/nWCAdQxMuXop/2S5yqIeQaTWD+K/tksJwMWWqX
	 yDgk9KEtLyohwPuj9ThgDEU0ewlFD7j5Z3AOl0sv3TsbEEw/UXnsfVAPYix1ea9m99
	 LJc3yhCgnC23jcjDuVcfN51TR4MIYJ0DPzLzVpkbhTB4BO0GvzcBEU3/uneGyddg7V
	 XXFINw0r1dXEtaoax3I0wWs8IXqm4HPsqFIvRAW+xO3upixyOpUoil70JuGcyF+WPX
	 HDKJosoRlOAwA==
Date: Sat, 17 Aug 2024 05:53:10 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 1/6] rust: sizes: add commonly used constants
Message-ID: <29eac62b-3d72-448c-9e46-b1ac460a4f10@proton.me>
In-Reply-To: <20240817051939.77735-2-fujita.tomonori@gmail.com>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com> <20240817051939.77735-2-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4398cc9d1692535840abed0e6ef7be68e256756a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.24 07:19, FUJITA Tomonori wrote:
> Add rust equivalent to include/linux/sizes.h, makes code more
> readable.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/lib.rs   |  1 +
>  rust/kernel/sizes.rs | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 rust/kernel/sizes.rs

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


