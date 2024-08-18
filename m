Return-Path: <netdev+bounces-119484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB0955D51
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB85B20C5B
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2212F5B1;
	Sun, 18 Aug 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="K0A9q36z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0E12B93;
	Sun, 18 Aug 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723996546; cv=none; b=rhKhgFCAwbOxJaH4E6RZpw8G0DV/h90O2+spwwW5aFgcIh0ko15AjJZljBx7JjT/Wvx35wsAOyV+IxtN/jd/+yf6AFIWvwie4nFHtscPdhLIoSoXsVjPueijM5/xeYFzk9Op0e7EUiKIxHqBoMcBAFZjHkhx3hq4E7qUtK50zZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723996546; c=relaxed/simple;
	bh=BDi7ZI0+pvbnwkHWrh/inZjgT2D/pDDMudpb6xPVq28=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dARF1h7Bi+4UM0aLzHEAV13B6qnapcuWnNfMQKL1U0SPvvREJtfvUKnbFu9yyey2Z+XWYahjQ2eKC1JlA1VEV8ruDr+6SrsWxnJr2Y8fA79abrOxI1J2PUYINgLJ36Zx6rFz/Kejs5o4PUdmPqz8JnOIK8auY6JKlLaLstl95qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=K0A9q36z; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723996536; x=1724255736;
	bh=vhtEFhxTxXkQIQ29h6xmKY9R1BywLvD7Lkn692ujfJo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=K0A9q36zUgFgZelaJMl8/c7gIpuhu3AzWcochgTIGawzscDaIFDAqiwpGGbMGwmzt
	 8KZEnzEzanCuHrPnyw2vd+5un6J5/7IauYyni4AGUwHwTkAAuQ/Uws9626wNAmoW1V
	 MxF2YwhQV/XHI9PoBFhrrDm48okI7g1JDVGwCClOOSRm9pnLyDnFbirNAFMa41CspC
	 wgPpCIziQ8MirzwRRrLzuUoiIHDrXehz4PQwDr2XCpJdeYL3DfpaWgO2bxIgv4uiuh
	 Vh7TcEQ7vOccw7R5SPB7CDryFHvpKKsZCYm8CChBCqXmE+k0xnsU8BD8m1lExHb+cR
	 gdrG+2knR3qSA==
Date: Sun, 18 Aug 2024 15:55:31 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Message-ID: <3feed4bb-6298-4379-8a71-0b88437b6250@proton.me>
In-Reply-To: <20240818.112518.2098286584782950755.fujita.tomonori@gmail.com>
References: <f480eb03-78f5-497e-a71d-57ba4f596153@proton.me> <20240818.091533.348920797210419357.fujita.tomonori@gmail.com> <dc644e0a-516b-40cb-8c33-cf98ef0111c9@proton.me> <20240818.112518.2098286584782950755.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b493542ebaae495a396b251f4ae67d7447ecf032
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.08.24 13:25, FUJITA Tomonori wrote:
> On Sun, 18 Aug 2024 10:42:32 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>>> /// - Referencing a `phy_device` using this struct asserts that you are=
 in
>>> ///   a context where all methods defined on this struct are safe to ca=
ll.
>>> /// - This struct always has a valid `mdio.dev`.
>>
>> Hmm, I think `self.0.mdio.dev` would be clearer.
>=20
> Sure, fixed.
>=20
>>> /// # Safety
>>> ///
>>> /// For the duration of 'a,
>>> /// - the pointer must point at a valid `phy_device`, and the caller
>>> ///   must be in a context where all methods defined on this struct
>>> ///   are safe to call.
>>> /// - 'mdio.dev' must be a valid.
>>
>> Also here: `(*ptr).mdio.dev`.
>=20
> Thanks, looks better.
>=20
> Here's an updated patch.
>=20
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 5e8137a1972f..ec337cbd391b 100644
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
> @@ -58,8 +57,9 @@ pub enum DuplexMode {
>  ///
>  /// # Invariants
>  ///
> -/// Referencing a `phy_device` using this struct asserts that you are in
> -/// a context where all methods defined on this struct are safe to call.
> +/// - Referencing a `phy_device` using this struct asserts that you are =
in
> +///   a context where all methods defined on this struct are safe to cal=
l.
> +/// - This struct always has a valid `self.0.mdio.dev`.
>  ///
>  /// [`struct phy_device`]: srctree/include/linux/phy.h
>  // During the calls to most functions in [`Driver`], the C side (`PHYLIB=
`) holds a lock that is
> @@ -76,9 +76,11 @@ impl Device {
>      ///
>      /// # Safety
>      ///
> -    /// For the duration of 'a, the pointer must point at a valid `phy_d=
evice`,
> -    /// and the caller must be in a context where all methods defined on=
 this struct
> -    /// are safe to call.
> +    /// For the duration of 'a,
> +    /// - the pointer must point at a valid `phy_device`, and the caller
> +    ///   must be in a context where all methods defined on this struct
> +    ///   are safe to call.
> +    /// - `(*ptr).mdio.dev` must be a valid.
>      unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Se=
lf {
>          // CAST: `Self` is a `repr(transparent)` wrapper around `binding=
s::phy_device`.
>          let ptr =3D ptr.cast::<Self>();
> @@ -302,6 +304,14 @@ pub fn genphy_read_abilities(&mut self) -> Result {
>      }
>  }
>=20
> +impl AsRef<kernel::device::Device> for Device {
> +    fn as_ref(&self) -> &kernel::device::Device {
> +        let phydev =3D self.0.get();
> +        // SAFETY: The struct invariant ensures that `mdio.dev` is valid=
.
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

This looks, good, if you want, you can add my reviewed-by on this patch.

---
Cheers,
Benno


