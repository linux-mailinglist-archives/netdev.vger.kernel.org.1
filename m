Return-Path: <netdev+bounces-191156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA5ABA493
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24A03B18F9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB6A27FD4E;
	Fri, 16 May 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwqCmEeo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA427CCC4;
	Fri, 16 May 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426590; cv=none; b=sJZPhKQhALlh2k3PIRRBS05Xvs3/CSfwODlDXD1Ju6s0MZpzpcQTSamX6Z9dqgh+o6sJFb3OMcu39n+h+lHWrnSAjGHpxfaCF0VXFiDecfqmi34TC/O4J8Hb+zhMBQyVRe/ihLnsyaWuibb+zJQT2KIEVGcSKSQ+4GJ5ZKrsa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426590; c=relaxed/simple;
	bh=D1Z5w9AYGSfUlSKYqF+jgYYMgx9eNNsKAADS1moCkaw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dqbP0DcAA4DEhI+WCAWCKgx/gaZUHgYzzpkbv0akLuM8T8wwwthzmNqBiei/xU7AOlyxSDnnDVGWeXjbQcwFaO/jZ+Gsq4reUumUxZMe9QPBXHdmQNzrMnm13+xN1eOuu/5vEuGHbK5HzdwlfEKpMTh3U9Qi4kd5tPNO0AhUWtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwqCmEeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D593C4CEE4;
	Fri, 16 May 2025 20:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747426589;
	bh=D1Z5w9AYGSfUlSKYqF+jgYYMgx9eNNsKAADS1moCkaw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=pwqCmEeonx6ZXsuHmxwr0Jq+QDCCSpFRxtVtCeFnTCGBowrq1J/0iVNS+DlBi8lT5
	 3086VLUmQPO+HjhKKoeuLvHgdKJNjYW7tV11djgzhOesw81NxW4b83xfLL3WK+fRcG
	 eoA0LtBJgkrc++Tk0L9/C0/IKi3IZLSLwS5Ogyy9RATr+JzkQILJug8DFmCe85v5d/
	 8XGn6o4w1ZgJD4uipVfaCJAiGijIyz+xLxm1S6/Bve61cO+RXpK5PlweNjUVxB2JOf
	 7uWXhI4oCgWfRPAAcVHr7rz+6EB7ASHt6F+9GLxKvqQmu4ZJUKxDbASAGOUK2f58Z1
	 ieYD1QT0BfbYw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 22:16:23 +0200
Message-Id: <D9XV0Y22JHU5.3T51FVQONVERC@kernel.org>
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
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
To: "Christian Marangi" <ansuelsmth@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
 <20250515112721.19323-8-ansuelsmth@gmail.com>
 <20250516.213005.1257508224493103119.fujita.tomonori@gmail.com>
 <D9XO2721HEQI.3BGSHJXCHPTL@kernel.org>
 <682755d8.050a0220.3c78c8.a604@mx.google.com>
In-Reply-To: <682755d8.050a0220.3c78c8.a604@mx.google.com>

On Fri May 16, 2025 at 5:12 PM CEST, Christian Marangi wrote:
> On Fri, May 16, 2025 at 04:48:53PM +0200, Benno Lossin wrote:
>> On Fri May 16, 2025 at 2:30 PM CEST, FUJITA Tomonori wrote:
>> > On Thu, 15 May 2025 13:27:12 +0200
>> > Christian Marangi <ansuelsmth@gmail.com> wrote:
>> >> @@ -574,6 +577,23 @@ pub const fn create_phy_driver<T: Driver>() -> D=
riverVTable {
>> >>  /// This trait is used to create a [`DriverVTable`].
>> >>  #[vtable]
>> >>  pub trait Driver {
>> >> +    /// # Safety
>> >> +    ///
>> >> +    /// For the duration of `'a`,
>> >> +    /// - the pointer must point at a valid `phy_driver`, and the ca=
ller
>> >> +    ///   must be in a context where all methods defined on this str=
uct
>> >> +    ///   are safe to call.
>> >> +    unsafe fn from_raw<'a>(ptr: *const bindings::phy_driver) -> &'a =
Self
>> >> +    where
>> >> +        Self: Sized,
>> >> +    {
>> >> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bin=
dings::phy_driver`.
>> >> +        let ptr =3D ptr.cast::<Self>();
>> >> +        // SAFETY: by the function requirements the pointer is valid=
 and we have unique access for
>> >> +        // the duration of `'a`.
>> >> +        unsafe { &*ptr }
>> >> +    }
>> >
>> > We might need to update the comment. phy_driver is const so I think
>> > that we can access to it any time.
>>=20
>> Why is any type implementing `Driver` a transparent wrapper around
>> `bindings::phy_driver`?
>>=20
>
> Is this referred to a problem with using from_raw or more of a general
> question on how the rust wrapper are done for phy code?

I looked at the `phy.rs` file again and now I'm pretty sure the above
code is wrong. `Self` can be implemented on any type (even types like
`Infallible` that do not have any valid bit patterns, since it's an
empty enum). The abstraction for `bindings::phy_driver` is
`DriverVTable` not an object of type `Self`, so you should cast to that
pointer instead.

>> >>      /// Defines certain other features this PHY supports.
>> >>      /// It is a combination of the flags in the [`flags`] module.
>> >>      const FLAGS: u32 =3D 0;
>> >> @@ -602,7 +622,7 @@ fn get_features(_dev: &mut Device) -> Result {
>> >> =20
>> >>      /// Returns true if this is a suitable driver for the given phyd=
ev.
>> >>      /// If not implemented, matching is based on [`Driver::PHY_DEVIC=
E_ID`].
>> >> -    fn match_phy_device(_dev: &Device) -> bool {
>> >> +    fn match_phy_device<T: Driver>(_dev: &mut Device, _drv: &T) -> b=
ool {
>> >>          false
>> >>      }
>> >
>> > I think that it could be a bit simpler:
>> >
>> > fn match_phy_device(_dev: &mut Device, _drv: &Self) -> bool
>> >
>> > Or making it a trait method might be more idiomatic?
>> >
>> > fn match_phy_device(&self, _dev: &mut Device) -> bool
>>=20
>> Yeah that would make most sense.
>>
>
> I think
>
> fn match_phy_device(_dev: &mut Device, _drv: &Self) -> bool
>
> more resemble the C parallel function so I think this suite the best,
> should make it easier to port if ever (am I wrong?)

I don't understand what you mean by "easier to port if ever". From a
Rust perspective, it makes much more sense to use the `&self` receiver,
since the driver is asked if it can take care of the device. If you want
to keep the order how it is in C that is also fine, but if I were to
write it, I'd use the receiver.

---
Cheers,
Benno

