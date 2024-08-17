Return-Path: <netdev+bounces-119414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7A795581E
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A8F282BBD
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62C714883F;
	Sat, 17 Aug 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eZ0XP1Ka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02524148855
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723901420; cv=none; b=nA53k4nI+y2oXEP3ZEY2IV1QvBEaDrYUtW5OSdFeh8yka441uwGjfBaC6vqj2MnuHPAA7JOcYcaqro64oFYExq3tIWDIP+OPwqXSmWaE75675eBNcc6LTUZ4uluGWWD3lqdelJYywPxFlhDrSVd9A09nbPgmUO8z74Hz/y59z/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723901420; c=relaxed/simple;
	bh=hqLWTwnaMT1gmr9cUxK35NoFw5H8avTg+Lzj+l96rXA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bh07YnUrgH4O3BCUCKGEnqSlalX/Tx5D+KMQ0fW7mI6FodP9nOEFap3qX4vmbvrkpIMgleD2up8WEjrfvCm201iOBcWgECmmQVG199V6gx+2OpeHvN6PPCRcD5q6MiRmvW+2ktpKmR9DNbSA3ZyQ97HNfdEU/Uuj4vDnAIT2AFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eZ0XP1Ka; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723901416; x=1724160616;
	bh=KHFXsHfbc7jxj+pypJ/Qvc9H7R3RX/nZwdNdqP5g4mU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eZ0XP1KaOlr+UyDDVdxIF2rwi53BF7nbiTJgLNrViXhElaVBkWL9g34DwqycU9net
	 jB95HM/HO3+rfv48a7+wKz/F+lbPkSshv1n3klRDkpH3Q+82y+HLlG49jX+OGQ+djD
	 Q6xA12PuEffbv/rS7enmAlyj9dGb/VC2bd3Pwd7b3+zFjiW20pKi8aijjohmz28fyI
	 WL6R9WgVUWlp+xKeFhwmuhcGk2GiVJ55EM0AqRlKH6UHpGMhpHSi+nqw+pqibpkr+L
	 MIihB8pZ15CJlgbfjFKfs1i5q7mj4VdvS2EyP7Wa4giOJ0HOMS7K5oW9uLJfa0k1Jt
	 btDUA1jkHCWrA==
Date: Sat, 17 Aug 2024 13:30:15 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Message-ID: <a8284afb-d01f-47c7-835f-49097708a53e@proton.me>
In-Reply-To: <20240817051939.77735-4-fujita.tomonori@gmail.com>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com> <20240817051939.77735-4-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a7b861ae599a8931ef0a7f37376f1e1765d72e2d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.24 07:19, FUJITA Tomonori wrote:
> Implement AsRef<kernel::device::Device> trait for Device. A PHY driver
> needs a reference to device::Device to call the firmware API.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 5e8137a1972f..569dd3beef9c 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -7,8 +7,7 @@
>  //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
>=20
>  use crate::{error::*, prelude::*, types::Opaque};
> -
> -use core::marker::PhantomData;
> +use core::{marker::PhantomData, ptr::addr_of_mut};
>=20
>  /// PHY state machine states.
>  ///
> @@ -302,6 +301,15 @@ pub fn genphy_read_abilities(&mut self) -> Result {
>      }
>  }
>=20
> +impl AsRef<kernel::device::Device> for Device {
> +    fn as_ref(&self) -> &kernel::device::Device {
> +        let phydev =3D self.0.get();
> +        // SAFETY: The struct invariant ensures that we may access
> +        // this field without additional synchronization.

I don't see this invariant on `phy::Device`.

---
Cheers,
Benno

> +        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).m=
dio.dev)) }
> +    }
> +}
> +
>  /// Defines certain other features this PHY supports (like interrupts).
>  ///
>  /// These flag values are used in [`Driver::FLAGS`].
> --
> 2.34.1
>=20


