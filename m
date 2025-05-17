Return-Path: <netdev+bounces-191281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C1ABA8D0
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 10:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C2B3B3E64
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 08:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612A91C5485;
	Sat, 17 May 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwY7/cN2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E1154457;
	Sat, 17 May 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747469181; cv=none; b=LPQ9DzMqCi4a3gqjcII03AgWtdd4FA5ZaGLLqBRUXeFEjpp85HtnSC/GKfzEjLzFKDv0hk+nbcY6vHaYqtGDABHwFAc6grEfrrqyB3IS9C6B4z8jvo4NGIhzYDKQUYz8vELjIYu3LCUulhXEoDVSxzCrdFhK1rPKAW1iYZyrEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747469181; c=relaxed/simple;
	bh=v25frJiPTgTzstYi/qAYHKcOdKSdtiKU5KMYe58p61Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IrsVA6HO50F6psJCwrHbwqmHjqFlqeah40LvFxHnjhmV+gJCvB+1kWLZrPuihm9K9gB+V8p2DAhnTyCB25dX8wr2GhxSfFvrUpkdU0bi1OXRqBQ/fsSvzypxC5YEzMO8U2KGfd7aDmO4UR1puIsiw1g6WA0cnmlfJD467uexSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwY7/cN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DA1C4CEE3;
	Sat, 17 May 2025 08:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747469180;
	bh=v25frJiPTgTzstYi/qAYHKcOdKSdtiKU5KMYe58p61Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SwY7/cN2Yk1sCK+NCwebNdelth5ocrTWsV+A1Vlb+aXtKBAIwx9r0Xxn42aF7YHHU
	 Hl9f+82kqPSdIRZ8Qn+R6VFiudcyRLYrxVQ1aZUwePfIgfQxa8d9qau99wVJeEQdWl
	 YIRlkDxedT3uy8iapsaVkDx+0kFGnIbSsUal3aRHGlLJUqq+c23DWs0H5bl1qGMxNV
	 3BD0fsEX0HU8pzsA/lGNKlHpiaazodmAW+mgK9tjJx62dfeNPimse6k1LT4ghBHOvb
	 OsbIoyQcyU9cACNzuN+xjcyMHWm/vi4nGQt/rso3x5IGSAY7phQ/oMjWuzL/zPg63X
	 d6ZBqH+vI6ykg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 May 2025 10:06:13 +0200
Message-Id: <D9YA4FS5EX4S.217A1IK0WW4WR@kernel.org>
Cc: <ansuelsmth@gmail.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
 <kabel@kernel.org>, <andrei.botila@oss.nxp.com>, <tmgross@umich.edu>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <dakr@kernel.org>,
 <sd@queasysnail.net>, <michael@fossekall.de>, <daniel@makrotopia.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
From: "Benno Lossin" <lossin@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
X-Mailer: aerc 0.20.1
References: <D9XO2721HEQI.3BGSHJXCHPTL@kernel.org>
 <682755d8.050a0220.3c78c8.a604@mx.google.com>
 <D9XV0Y22JHU5.3T51FVQONVERC@kernel.org>
 <20250517.152735.1375764560545086525.fujita.tomonori@gmail.com>
In-Reply-To: <20250517.152735.1375764560545086525.fujita.tomonori@gmail.com>

On Sat May 17, 2025 at 8:27 AM CEST, FUJITA Tomonori wrote:
> On Fri, 16 May 2025 22:16:23 +0200
> "Benno Lossin" <lossin@kernel.org> wrote:
>> On Fri May 16, 2025 at 5:12 PM CEST, Christian Marangi wrote:
>>> On Fri, May 16, 2025 at 04:48:53PM +0200, Benno Lossin wrote:
>>>> On Fri May 16, 2025 at 2:30 PM CEST, FUJITA Tomonori wrote:
>>>> > On Thu, 15 May 2025 13:27:12 +0200
>>>> > Christian Marangi <ansuelsmth@gmail.com> wrote:
>>>> >> @@ -574,6 +577,23 @@ pub const fn create_phy_driver<T: Driver>() ->=
 DriverVTable {
>>>> >>  /// This trait is used to create a [`DriverVTable`].
>>>> >>  #[vtable]
>>>> >>  pub trait Driver {
>>>> >> +    /// # Safety
>>>> >> +    ///
>>>> >> +    /// For the duration of `'a`,
>>>> >> +    /// - the pointer must point at a valid `phy_driver`, and the =
caller
>>>> >> +    ///   must be in a context where all methods defined on this s=
truct
>>>> >> +    ///   are safe to call.
>>>> >> +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'=
a Self
>>>> >> +    where
>>>> >> +        Self: Sized,
>>>> >> +    {
>>>> >> +        // CAST: `Self` is a `repr(transparent)` wrapper around `b=
indings::phy_driver`.
>>>> >> +        let ptr =3D ptr.cast::<Self>();
>>>> >> +        // SAFETY: by the function requirements the pointer is val=
id and we have unique access for
>>>> >> +        // the duration of `'a`.
>>>> >> +        unsafe { &*ptr }
>>>> >> +    }
>>>> >
>>>> > We might need to update the comment. phy_driver is const so I think
>>>> > that we can access to it any time.
>>>>=20
>>>> Why is any type implementing `Driver` a transparent wrapper around
>>>> `bindings::phy_driver`?
>>>>=20
>>>
>>> Is this referred to a problem with using from_raw or more of a general
>>> question on how the rust wrapper are done for phy code?
>>=20
>> I looked at the `phy.rs` file again and now I'm pretty sure the above
>> code is wrong. `Self` can be implemented on any type (even types like
>> `Infallible` that do not have any valid bit patterns, since it's an
>> empty enum). The abstraction for `bindings::phy_driver` is
>> `DriverVTable` not an object of type `Self`, so you should cast to that
>> pointer instead.
>
> Yeah.
>
> I don't want to delay this patchset due to Rust side changes so
> casting a pointer to bindings::phy_driver to DriverVTable is ok but
> the following signature doesn't look useful for Rust phy drivers:
>
> fn match_phy_device(_dev: &mut Device, _drv: &DriverVTable) -> bool
>
> struct DriverVTable is only used to create an array of
> bindings::phy_driver for C side, and it doesn't provide any
> information to the Rust driver.

Yeah, but we could add accessor functions that provide that information.
Although that doesn't really make sense at the moment, see below.

> In match_phy_device(), for example, a device driver accesses to
> PHY_DEVICE_ID, which the Driver trait provides. I think we need to
> create an instance of the device driver's own type that implements the
> Driver trait and make it accessible.

I think that's wrong, nothing stops me from implementing `Driver` for an
empty enum and that can't be instantiated. The reason that one wants to
have this in C is because the same `match` function is used for
different drivers (or maybe devices? I'm not too familiar with the
terminology). In Rust, you must implement the match function for a
single PHY_DEVICE_ID only, so maybe we don't need to change the
signature at all?

---
Cheers,
Benno

