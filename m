Return-Path: <netdev+bounces-191330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13861ABAE68
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 09:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36EFD7A41B5
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9525C1FFC48;
	Sun, 18 May 2025 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE7jrBFM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0B2CA6;
	Sun, 18 May 2025 07:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747552461; cv=none; b=Sh/Vhoqzmb0o8jMRK3KXXhgkhHhT53ZwtWa+JcmcCW71YonJPo7DRJwX0tIySeVWJC0ov+2kOvt/gP6Xiq/2uyCAp4AcXamRCivgWG/BrRJh4tfjK6SleKiejVCdkJXvRsHStNf0sz9YcwI+PojDoF4tl2PZyxM7njwDxjTbV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747552461; c=relaxed/simple;
	bh=th82xeU04pP4E1vW7aHTdnYx+NniyE/zFWrDt873AaI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sk31MWS08nRMoPDOMnavnUIbr5cendKvV7dxooAaZFMQ3vjWt1DoIrnifUNmy9TT/TRBfh8JnYcX3BDc/HjGkJmO2vgkgbScb2T6n0VSssQ6qevgat59zZvMRSNlqeXnBmjOiQb8L290DXziFBhrp+VWgm4LgFFxEbfHi1rImSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE7jrBFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47621C4CEE7;
	Sun, 18 May 2025 07:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747552460;
	bh=th82xeU04pP4E1vW7aHTdnYx+NniyE/zFWrDt873AaI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BE7jrBFM3p5MX2og2sFN4O/IlZJu7LoBVB0qpxz+9LrlsL52HQd1vE9wgv+IucRh2
	 9eerZq9583igSVHqU33QcInpaExU4+3hheYk9D5DTZa5SDLA98ybD4FMGk/EJib2bQ
	 7eL3BRNXEXdyCXJ6f1UKi7S8Dlnjor8iN6hnwvXCqrTho+7Glk44dFUeWLbdPcl79i
	 2PyD2sqaZQS1Sdosb3Rub2BqehCfZSVZdKEZfv/tGdosl3K7InYE22sAK6YzSYrQ46
	 QxuD6pWrU1hbrwrOZ+0etWP+tStHeLeahM/fKauByGEONWCkx6g6zPyHcB+IXfTN9n
	 6K/V/ywM37hXQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 May 2025 09:13:52 +0200
Message-Id: <D9Z3MWPWLMNF.2JS9XJ9U8C4H1@kernel.org>
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
References: <D9XV0Y22JHU5.3T51FVQONVERC@kernel.org>
 <20250517.152735.1375764560545086525.fujita.tomonori@gmail.com>
 <D9YA4FS5EX4S.217A1IK0WW4WR@kernel.org>
 <20250517.221313.1252217275580085717.fujita.tomonori@gmail.com>
 <D9YO3781UI2X.1CI7FG1EATN8G@kernel.org>
 <6828ece4.050a0220.49f8b.ca57@mx.google.com>
In-Reply-To: <6828ece4.050a0220.49f8b.ca57@mx.google.com>

On Sat May 17, 2025 at 10:09 PM CEST, Christian Marangi wrote:
> On Sat, May 17, 2025 at 09:02:51PM +0200, Benno Lossin wrote:
>> On Sat May 17, 2025 at 3:13 PM CEST, FUJITA Tomonori wrote:
>> > On Sat, 17 May 2025 10:06:13 +0200
>> > "Benno Lossin" <lossin@kernel.org> wrote:
>> >>>> I looked at the `phy.rs` file again and now I'm pretty sure the abo=
ve
>> >>>> code is wrong. `Self` can be implemented on any type (even types li=
ke
>> >>>> `Infallible` that do not have any valid bit patterns, since it's an
>> >>>> empty enum). The abstraction for `bindings::phy_driver` is
>> >>>> `DriverVTable` not an object of type `Self`, so you should cast to =
that
>> >>>> pointer instead.
>> >>>
>> >>> Yeah.
>> >>>
>> >>> I don't want to delay this patchset due to Rust side changes so
>> >>> casting a pointer to bindings::phy_driver to DriverVTable is ok but
>> >>> the following signature doesn't look useful for Rust phy drivers:
>> >>>
>> >>> fn match_phy_device(_dev: &mut Device, _drv: &DriverVTable) -> bool
>> >>>
>> >>> struct DriverVTable is only used to create an array of
>> >>> bindings::phy_driver for C side, and it doesn't provide any
>> >>> information to the Rust driver.
>> >>=20
>> >> Yeah, but we could add accessor functions that provide that informati=
on.
>> >
>> > Yes. I thought that implementation was one of the options as well but
>> > realized it makes sense because inside match_phy_device() callback, a
>> > driver might call a helper function that takes a pointer to
>> > bindings::phy_driver (please see below for details).
>> >
>> >
>> >> Although that doesn't really make sense at the moment, see below.
>> >>
>> >>> In match_phy_device(), for example, a device driver accesses to
>> >>> PHY_DEVICE_ID, which the Driver trait provides. I think we need to
>> >>> create an instance of the device driver's own type that implements t=
he
>> >>> Driver trait and make it accessible.
>> >>=20
>> >> I think that's wrong, nothing stops me from implementing `Driver` for=
 an
>> >> empty enum and that can't be instantiated. The reason that one wants =
to
>> >> have this in C is because the same `match` function is used for
>> >> different drivers (or maybe devices? I'm not too familiar with the
>> >> terminology). In Rust, you must implement the match function for a
>> >> single PHY_DEVICE_ID only, so maybe we don't need to change the
>> >> signature at all?
>> >
>> > I'm not sure I understand the last sentence. The Rust PHY abstraction
>> > allows one module to support multiple drivers. So we can could the
>> > similar trick that the second patch in this patchset does.
>> >
>> > fn match_device_id(dev: &mut phy::Device, drv: &phy::DriverVTable) -> =
bool {
>> >     // do comparison workking for three drivers
>> > }
>>=20
>> I wouldn't do it like this in Rust, instead this would be a "rustier"
>> function signature:
>>=20
>>     fn match_device_id<T: Driver>(dev: &mut phy::Device) -> bool {
>>         // do the comparison with T::PHY_DEVICE_ID
>>         dev.id() =3D=3D T::PHY_DEVICE_ID
>>     }
>>=20
>> And then in the impls for Phy{A,B,C,D} do this:
>>=20
>>     impl Driver for PhyA {
>>         fn match_phy_device(dev: &mut phy::Device) -> bool {
>>             match_device_id::<Self>(dev)
>>         }
>>     }
>>=20
>
> My 2 cent about the discussion and I'm totally detached from how it
> works on Rust kernel code but shouldn't we try to keep parallel API and
> args between C and Rust?

It depends :) There are several things to consider in this from safety
to ease of use. Sometimes we diverge from the C implementation, because
it makes it safe. For example, from the very beginning, mutexes in Rust
have used guards, but those have only been recently-ish introduced in
C. Mutexes in Rust also store the value inside of them, making it
impossible to access the inner value without taking the lock. This makes
the API safer, but diverges from C.

Now in this case, we're talking about making an API more rusty and thus
diverging from the C side. One can argue for either side and we have to
strike a balance, but in the end it'll probably be up to each subsystem
how they will handle it. It's not as big of an argument as safety (which
we strive very hard for).

In this concrete case, a `DriverVTable` is just an adapter type that we
use to make a trait in Rust be compatible with a C vtable. From Rusts
perspective, the single origin of truth is the trait and the vtable is
derived from that. So from a Rust perspective it's much more natural to
use the trait than the vtable. (This might also end up being more
performant, since we statically know which ID the driver supports and
the C side needs to dynamically look it up.)

> I know maybe some thing doesn't make sense from C to Rust but doesn't
> deviates from C code introduce more confusion when something need to be
> ported from C to Rust?

Ideally we have people that work on both sides and can bridge that gap.
If not, then having a Rust expert and a C expert work together has
worked out great in the past. I don't see this becoming a big problem
unless one of the sides is poorly maintained, which could also happen in
C.

> Again no idea if this apply so I'm just curious about this.

No worries, glad to hear your perspective.

---
Cheers,
Benno

