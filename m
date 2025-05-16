Return-Path: <netdev+bounces-191061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F49AB9EEA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC05E175041
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4C1A316C;
	Fri, 16 May 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0qkjECU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955E1A0730;
	Fri, 16 May 2025 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406948; cv=none; b=GRV0yePYxe/iunN7PFVvtA2ZguhySZlnxlJCeOQEqVTv9qoM2rsJ+77Rdqg97FNurOaflXeH5+uZNxQx7PBw/ImO7EOO75lgwYOYXyC8jy4+WmmV3rZDRbJuWbAT7Jn5HLEOWTWNE461M+VnoA3L+Cr+7Op9QQNIGq4mAaEUklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406948; c=relaxed/simple;
	bh=D1CGvBnQQz/JZMACaTEpjRYHJ6/5pcLjYTQPBYt2h5I=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Wt8rVL8tjQzT7uQAMivYyNVZEjXx5KKAe5NJY7iKzRx8h+SVZnqYdxXpx6dh2YQ1AGEkYLMDW26gWy+ycBaCff/OMBcheJiazCON1NTJWblMzhCDSSXAXVod1PJrS/frcL4IZtHnUDGizJGRC7F4A79e6jCqzZQcx7IJuzTJgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0qkjECU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BEFC4CEE4;
	Fri, 16 May 2025 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747406947;
	bh=D1CGvBnQQz/JZMACaTEpjRYHJ6/5pcLjYTQPBYt2h5I=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=g0qkjECUdimjT1pLQ3tvce+3Qwde2SMfsbsVRmEzVuBvdIWxY1MzSE6z8UqVx3j7X
	 jKOQIuAnmfFP5mk51dRJLcTV2rpGii66ymdiQtZzrcvpYE6vT+qMvOOfwqNtxoldOY
	 z2iW1SF7frqvOKzswhCSziinTE0A66UMs9j2P3zao3yX6KyyTUdOpjHHytHQDHer+y
	 hb17S4TlPEQyzQ6udKp0J68TJ/tWUH9rHIoP5LIBhgZy/WujkiOenR2T6d0XU3GGxS
	 mNrxUY5vS5enZpfk4k+4DI+tylFUTCxohROUGVqsEnCeDFoaoocsTibDSZjQxb83/A
	 rk+P+Rp/rvH5w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 16:48:53 +0200
Message-Id: <D9XO2721HEQI.3BGSHJXCHPTL@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <ansuelsmth@gmail.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <florian.fainelli@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <kabel@kernel.org>,
 <andrei.botila@oss.nxp.com>, <tmgross@umich.edu>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <dakr@kernel.org>,
 <sd@queasysnail.net>, <michael@fossekall.de>, <daniel@makrotopia.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
 <20250515112721.19323-8-ansuelsmth@gmail.com>
 <20250516.213005.1257508224493103119.fujita.tomonori@gmail.com>
In-Reply-To: <20250516.213005.1257508224493103119.fujita.tomonori@gmail.com>

On Fri May 16, 2025 at 2:30 PM CEST, FUJITA Tomonori wrote:
> On Thu, 15 May 2025 13:27:12 +0200
> Christian Marangi <ansuelsmth@gmail.com> wrote:
>> @@ -574,6 +577,23 @@ pub const fn create_phy_driver<T: Driver>() -> Driv=
erVTable {
>>  /// This trait is used to create a [`DriverVTable`].
>>  #[vtable]
>>  pub trait Driver {
>> +    /// # Safety
>> +    ///
>> +    /// For the duration of `'a`,
>> +    /// - the pointer must point at a valid `phy_driver`, and the calle=
r
>> +    ///   must be in a context where all methods defined on this struct
>> +    ///   are safe to call.
>> +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a Sel=
f
>> +    where
>> +        Self: Sized,
>> +    {
>> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindin=
gs::phy_driver`.
>> +        let ptr =3D ptr.cast::<Self>();
>> +        // SAFETY: by the function requirements the pointer is valid an=
d we have unique access for
>> +        // the duration of `'a`.
>> +        unsafe { &*ptr }
>> +    }
>
> We might need to update the comment. phy_driver is const so I think
> that we can access to it any time.

Why is any type implementing `Driver` a transparent wrapper around
`bindings::phy_driver`?

>>      /// Defines certain other features this PHY supports.
>>      /// It is a combination of the flags in the [`flags`] module.
>>      const FLAGS: u32 =3D 0;
>> @@ -602,7 +622,7 @@ fn get_features(_dev: &mut Device) -> Result {
>> =20
>>      /// Returns true if this is a suitable driver for the given phydev.
>>      /// If not implemented, matching is based on [`Driver::PHY_DEVICE_I=
D`].
>> -    fn match_phy_device(_dev: &Device) -> bool {
>> +    fn match_phy_device<T: Driver>(_dev: &mut Device, _drv: &T) -> bool=
 {
>>          false
>>      }
>
> I think that it could be a bit simpler:
>
> fn match_phy_device(_dev: &mut Device, _drv: &Self) -> bool
>
> Or making it a trait method might be more idiomatic?
>
> fn match_phy_device(&self, _dev: &mut Device) -> bool

Yeah that would make most sense.

---
Cheers,
Benno

