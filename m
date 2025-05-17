Return-Path: <netdev+bounces-191283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B729ABA8D4
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 10:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725A63B4CD9
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE0C1D6DBB;
	Sat, 17 May 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3QCJ9gi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9076026;
	Sat, 17 May 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747469401; cv=none; b=bSD8KJgZend/UkyQl2Bpdf07vw3CyuJU7JnDb3eoDSYoGxSCszv5SKHZQpKYdIZ4rOkekEJSSJwU0x4AeP7QL+gkh/TonQHKPzbwkf3Dtljp60WVsvlPiR9BawcP2SAOWxpxSsFKmZ7IxTlb4zyTAqIi5IL5bJdIaPLtHUeudQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747469401; c=relaxed/simple;
	bh=lI5GXMPHMKJCva/XfenAwMLqoCDzoC16fyY0XcNLI1I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=a/utPcm0j6huubRsBzq9XHzzcyyzcmsIfSMhwxeHSt1Gl/eW/bZuznakhSvVtWyld6KiYOVvk4Lz5ekKNhORMNTLbKf/HkHtoTdtXV+N/62ZH8XhGtrO7snVWLT2dawtsS6cYdq3Uthh23RvcDm/zfyiTsRmX26nsI0hkh2nqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3QCJ9gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9A3C4CEE3;
	Sat, 17 May 2025 08:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747469401;
	bh=lI5GXMPHMKJCva/XfenAwMLqoCDzoC16fyY0XcNLI1I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=i3QCJ9giswxYKl0Wb3eh0fywapf6vpoC0xTDdrqTVbzbfaXlD90MjDZD0WoFBnHUb
	 W5g2tEfyuRwDiNh0K1z3rJpM26CX/YF3AJWiWTWtFdiUOPEirIleSPmHZtCKjWDq2k
	 xmEiAQ8UWXblnjysLoyBdUgRYIY43igUH6B/3XnoUqw5OIOUK9RANug5+y1OJqDVQr
	 3y5CMJ96nrY2vTkBIE80B+gXmbKZA+zOIco9hdu9mHTDZYC/pOrojefXzdqSP1djhQ
	 1kaX6KqGoiIb7IqsRtNNluk/QI2Cd8DrN3Y/1BAuQ4Cmfi0ZfOE4Yv+5G+C0fwlmXW
	 /1yXT7CchCo3Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 May 2025 10:09:53 +0200
Message-Id: <D9YA78RFVQMH.QPUFXMHSVU7V@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: Re: [net-next PATCH v11 1/6] net: phy: pass PHY driver to
 .match_phy_device OP
From: "Benno Lossin" <lossin@kernel.org>
To: "Christian Marangi" <ansuelsmth@gmail.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "Florian Fainelli"
 <florian.fainelli@broadcom.com>, "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, "Andrei Botila" <andrei.botila@oss.nxp.com>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Michael Klein"
 <michael@fossekall.de>, "Daniel Golle" <daniel@makrotopia.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250516212354.32313-1-ansuelsmth@gmail.com>
 <20250516212354.32313-2-ansuelsmth@gmail.com>
In-Reply-To: <20250516212354.32313-2-ansuelsmth@gmail.com>

On Fri May 16, 2025 at 11:23 PM CEST, Christian Marangi wrote:
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index a59469c785e3..079a0f884887 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -418,15 +418,18 @@ impl<T: Driver> Adapter<T> {
> =20
>      /// # Safety
>      ///
> -    /// `phydev` must be passed by the corresponding callback in `phy_dr=
iver`.
> +    /// `phydev` and `phydrv` must be passed by the corresponding callba=
ck in
> +    //  `phy_driver`.
>      unsafe extern "C" fn match_phy_device_callback(
>          phydev: *mut bindings::phy_device,
> +        phydrv: *const bindings::phy_driver,
>      ) -> crate::ffi::c_int {
>          // SAFETY: This callback is called only in contexts
>          // where we hold `phy_device->lock`, so the accessors on
>          // `Device` are okay to call.
>          let dev =3D unsafe { Device::from_raw(phydev) };
> -        T::match_phy_device(dev) as i32
> +        let drv =3D unsafe { T::from_raw(phydrv) };
> +        T::match_phy_device(dev, drv) as i32
>      }
> =20
>      /// # Safety
> @@ -574,6 +577,19 @@ pub const fn create_phy_driver<T: Driver>() -> Drive=
rVTable {
>  /// This trait is used to create a [`DriverVTable`].
>  #[vtable]
>  pub trait Driver {
> +    /// # Safety
> +    ///
> +    /// For the duration of `'a`, the pointer must point at a valid
> +    /// `phy_driver`, and the caller must be in a context where all
> +    /// methods defined on this struct are safe to call.
> +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a Driv=
erVTable {
> +        // CAST: `DriverVTable` is a `repr(transparent)` wrapper around =
`bindings::phy_driver`.
> +        let ptr =3D ptr.cast::<DriverVTable>();
> +        // SAFETY: by the function requirements the pointer is const and=
 is
> +        // always valid to access for the duration of `'a`.
> +        unsafe { &*ptr }
> +    }

If we go the way of supplying a `&DriverVTable` in the
`match_phy_device` function, then this should be a function in the impl
block of `DriverVTable` and not in `Driver`.

See my reply to Fujita on the previous version, I don't think that we
need to add the `DriverVTable` to the `match_phy_device` function if we
don't provide accessor methods. Currently that isn't needed, so you only
need the hunks above this one. (I'd wait for Fujita's reply though).

---
Cheers,
Benno

> +
>      /// Defines certain other features this PHY supports.
>      /// It is a combination of the flags in the [`flags`] module.
>      const FLAGS: u32 =3D 0;
> @@ -602,7 +618,7 @@ fn get_features(_dev: &mut Device) -> Result {
> =20
>      /// Returns true if this is a suitable driver for the given phydev.
>      /// If not implemented, matching is based on [`Driver::PHY_DEVICE_ID=
`].
> -    fn match_phy_device(_dev: &Device) -> bool {
> +    fn match_phy_device(_dev: &mut Device, _drv: &DriverVTable) -> bool =
{
>          false
>      }
> =20


