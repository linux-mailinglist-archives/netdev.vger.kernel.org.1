Return-Path: <netdev+bounces-191305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E14ABABF7
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 21:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A980617F311
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD25F2147EE;
	Sat, 17 May 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSPIH9VZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95A62144D8;
	Sat, 17 May 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747508579; cv=none; b=dNlai4AMflurXb9SUjscLAVR9IBTNu1vvSNUU0qTClyTbuQ5hJIKKzOhQJsUSiGGwsv8RcsrQQVAU4TjAgmQNLL06DZ0lmI97yIX416p3nAXOlIOLZEwRCvFSKIhNw8ZTRNiPbZS6USrSvjCrygPOcdZUtrnLzU1MzNnY0q6fGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747508579; c=relaxed/simple;
	bh=4ZA86XqxmpCFZRexveuDvS99A9RUuM5vs/0fQymdDv8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=HqLwZBlZxDoSLVbA75jMp6ZI29lUz+Y//woFe/NmvP9V6px2LBvZzJI7gMerDzw+bTQh7kBErOFX8LsjoymLHtSCNiW9M9sohwvTR6zvqdqbuKZ8p05G47CEQALFSzXoWv8d/sUK9aQyG1+hMIClrC6HRkLbov+8s5f7DvuMEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSPIH9VZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8A2C4CEEA;
	Sat, 17 May 2025 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747508579;
	bh=4ZA86XqxmpCFZRexveuDvS99A9RUuM5vs/0fQymdDv8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=pSPIH9VZBC8oDDlJb5G2qmfhHn+cTIT8DMWuyvT4NaX5rzC42fwweThYfo0z3M/VC
	 1yKMs0qesT2JuR2kh1OH6RsugELP/GNWdWeGjW3RgTR2xtwqGo7rYtgzubTlDRtk8l
	 jivztcFmInubI9ZptDmFRozbLR5tdhbmALrSWvqiYlRUGm+V9xmgjIVq45LwR/5U6w
	 Ha6ihiIZ9F7HVcZh9OvprVrUmhE0FpRxJBoStKl1tZWqZG5LRINlDY/ZrZSb8KI0Ad
	 G+vo/S592cpVO8kUfpN0fjqMKZxsz4jtUM/K578UC1pERx0wHZ7fMyV5AQWDCMhu7R
	 Uska3CQpeV6GQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 May 2025 21:02:51 +0200
Message-Id: <D9YO3781UI2X.1CI7FG1EATN8G@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
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
X-Mailer: aerc 0.20.1
References: <D9XV0Y22JHU5.3T51FVQONVERC@kernel.org>
 <20250517.152735.1375764560545086525.fujita.tomonori@gmail.com>
 <D9YA4FS5EX4S.217A1IK0WW4WR@kernel.org>
 <20250517.221313.1252217275580085717.fujita.tomonori@gmail.com>
In-Reply-To: <20250517.221313.1252217275580085717.fujita.tomonori@gmail.com>

On Sat May 17, 2025 at 3:13 PM CEST, FUJITA Tomonori wrote:
> On Sat, 17 May 2025 10:06:13 +0200
> "Benno Lossin" <lossin@kernel.org> wrote:
>>>> I looked at the `phy.rs` file again and now I'm pretty sure the above
>>>> code is wrong. `Self` can be implemented on any type (even types like
>>>> `Infallible` that do not have any valid bit patterns, since it's an
>>>> empty enum). The abstraction for `bindings::phy_driver` is
>>>> `DriverVTable` not an object of type `Self`, so you should cast to tha=
t
>>>> pointer instead.
>>>
>>> Yeah.
>>>
>>> I don't want to delay this patchset due to Rust side changes so
>>> casting a pointer to bindings::phy_driver to DriverVTable is ok but
>>> the following signature doesn't look useful for Rust phy drivers:
>>>
>>> fn match_phy_device(_dev: &mut Device, _drv: &DriverVTable) -> bool
>>>
>>> struct DriverVTable is only used to create an array of
>>> bindings::phy_driver for C side, and it doesn't provide any
>>> information to the Rust driver.
>>=20
>> Yeah, but we could add accessor functions that provide that information.
>
> Yes. I thought that implementation was one of the options as well but
> realized it makes sense because inside match_phy_device() callback, a
> driver might call a helper function that takes a pointer to
> bindings::phy_driver (please see below for details).
>
>
>> Although that doesn't really make sense at the moment, see below.
>>
>>> In match_phy_device(), for example, a device driver accesses to
>>> PHY_DEVICE_ID, which the Driver trait provides. I think we need to
>>> create an instance of the device driver's own type that implements the
>>> Driver trait and make it accessible.
>>=20
>> I think that's wrong, nothing stops me from implementing `Driver` for an
>> empty enum and that can't be instantiated. The reason that one wants to
>> have this in C is because the same `match` function is used for
>> different drivers (or maybe devices? I'm not too familiar with the
>> terminology). In Rust, you must implement the match function for a
>> single PHY_DEVICE_ID only, so maybe we don't need to change the
>> signature at all?
>
> I'm not sure I understand the last sentence. The Rust PHY abstraction
> allows one module to support multiple drivers. So we can could the
> similar trick that the second patch in this patchset does.
>
> fn match_device_id(dev: &mut phy::Device, drv: &phy::DriverVTable) -> boo=
l {
>     // do comparison workking for three drivers
> }

I wouldn't do it like this in Rust, instead this would be a "rustier"
function signature:

    fn match_device_id<T: Driver>(dev: &mut phy::Device) -> bool {
        // do the comparison with T::PHY_DEVICE_ID
        dev.id() =3D=3D T::PHY_DEVICE_ID
    }

And then in the impls for Phy{A,B,C,D} do this:

    impl Driver for PhyA {
        fn match_phy_device(dev: &mut phy::Device) -> bool {
            match_device_id::<Self>(dev)
        }
    }

>
> #[vtable]
> impl Driver for PhyA {
>     ...
>     fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -=
> bool {
>         match_device_id(dev, drv)
>     }
> }
>
> #[vtable]
> impl Driver for PhyB {
>     ...
>     fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -=
> bool {
>         match_device_id(dev, drv)
>     }
> }
>
> #[vtable]
> impl Driver for PhyC {
>     ...
>     fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -=
> bool {
>         match_device_id(dev, drv)
>     }
> }
>
>
> The other use case, as mentioned above, is when using the generic helper
> function inside match_phy_device() callback. For example, the 4th
> patch in this patchset adds genphy_match_phy_device():
>
> int genphy_match_phy_device(struct phy_device *phydev,
>                            const struct phy_driver *phydrv)
>
> We could add a wrapper for this function as phy::Device's method like
>
> impl Device {
>     ...
>     pub fn genphy_match_phy_device(&self, drv: &phy::DriverVTable) -> i32=
=20

Not sure why this returns an `i32`, but we probably could have such a
function as well (though I wouldn't use the vtable for that).

---
Cheers,
Benno

> Then a driver could do something like 5th patch in the patchset:
>
> #[vtable]
> impl Driver for PhyD {
>     ...
>     fn match_phy_device(dev: &mut phy::Device, drv: &phy::DriverVTable) -=
> bool {
>        let val =3D dev.genphy_match_phy_device(drv);
>        ...
>     }
> }


