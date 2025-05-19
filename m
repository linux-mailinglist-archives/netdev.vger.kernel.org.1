Return-Path: <netdev+bounces-191537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C451ABBDF1
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E0D17E6E4
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6362777E7;
	Mon, 19 May 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muYJCXup"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF2201246;
	Mon, 19 May 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657973; cv=none; b=DcqjY1zopRZSer6MV6J3xJuo9Ac/7o0XESRdyGmlt959I7Fe/F+ksZZWIFHfNwiX/8HBzqi1aN/Nh6u9s/qGLucY2Z1Q87HWVzIsPB5Wv+Lct7VLlzPqd/34/+6gE4Ltwg+2oh6ZOGqUpvF0K0NC3/yR7qJoP0o/iA4jsZfqE5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657973; c=relaxed/simple;
	bh=dnGUpjpvPnIIq8pfVahqq1mSR6YtP6V2Pb03V+FCKGw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hwh81o4wVPieidrkfD7l9OHdTCkx69nHjsi78E+wRac+8qSgShKmEKAPCZdqQ5X6oYfRrftmMAeaCtwd7zPkIC58siKUQCtB5GXZyXesC/kdqGqzDEmS62AwZW4kJRrN8Ne15/yZbkhrq0d1ygGC3dNrFr0OtE/kO+51vJhNF/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muYJCXup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5AEC4CEE4;
	Mon, 19 May 2025 12:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747657972;
	bh=dnGUpjpvPnIIq8pfVahqq1mSR6YtP6V2Pb03V+FCKGw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=muYJCXuppZCqLkP6vfbQUKWU74VdlhJWhiryj1aPy4AGnH2LYBzPizWQB30pHojci
	 j6c7udKL2judwXeWUDvAHarXzyIw6St8dJ7varjd7P+cXkrsZTB33B91OJ9njWeaua
	 jPlvphs+nGT8E4LOM9j4/rf2rrAQvDM8ISOHy+gBpslbFSo3e7OlFjOmHIfUHHEABT
	 wcnn3EVN5OI/ShUyq6+AEfdQCKdLhdWU5Tgr0gUpFZinjObbY5A2ZMd6aBFfO8rT+X
	 yvrr8lAHq0TNlcsCpQLwt8C/LvBTIY4rgtKlW0QKkZiGc9M0hRqYuBDZknKVlQAz9u
	 3QDRyV4sqtbmA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 14:32:44 +0200
Message-Id: <DA051LGPX0NX.20CQCK4V3B6PF@kernel.org>
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
References: <D9YA4FS5EX4S.217A1IK0WW4WR@kernel.org>
 <20250517.221313.1252217275580085717.fujita.tomonori@gmail.com>
 <D9YO3781UI2X.1CI7FG1EATN8G@kernel.org>
 <20250519.210059.2097701450976383427.fujita.tomonori@gmail.com>
In-Reply-To: <20250519.210059.2097701450976383427.fujita.tomonori@gmail.com>

On Mon May 19, 2025 at 2:00 PM CEST, FUJITA Tomonori wrote:
> On Sat, 17 May 2025 21:02:51 +0200
> "Benno Lossin" <lossin@kernel.org> wrote:
>>>> I think that's wrong, nothing stops me from implementing `Driver` for =
an
>>>> empty enum and that can't be instantiated. The reason that one wants t=
o
>>>> have this in C is because the same `match` function is used for
>>>> different drivers (or maybe devices? I'm not too familiar with the
>>>> terminology). In Rust, you must implement the match function for a
>>>> single PHY_DEVICE_ID only, so maybe we don't need to change the
>>>> signature at all?
>>>
>>> I'm not sure I understand the last sentence. The Rust PHY abstraction
>>> allows one module to support multiple drivers. So we can could the
>>> similar trick that the second patch in this patchset does.
>>>
>>> fn match_device_id(dev: &mut phy::Device, drv: &phy::DriverVTable) -> b=
ool {
>>>     // do comparison workking for three drivers
>>> }
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
>
> Ah, yes, this works well.
>
>
>>> The other use case, as mentioned above, is when using the generic helpe=
r
>>> function inside match_phy_device() callback. For example, the 4th
>>> patch in this patchset adds genphy_match_phy_device():
>>>
>>> int genphy_match_phy_device(struct phy_device *phydev,
>>>                            const struct phy_driver *phydrv)
>>>
>>> We could add a wrapper for this function as phy::Device's method like
>>>
>>> impl Device {
>>>     ...
>>>     pub fn genphy_match_phy_device(&self, drv: &phy::DriverVTable) -> i=
32=20
>>=20
>> Not sure why this returns an `i32`, but we probably could have such a
>
> Maybe a bool would be more appropriate here because the C's comment
> says:
>
> Return: 1 if the PHY device matches the driver, 0 otherwise.
>
>> function as well (though I wouldn't use the vtable for that).
>
> What would you use instead?

The concept that I sketched above:

    impl Device {
        fn genphy_match_phy_device<T: Driver>(&self) -> bool {
            self.phy_id() =3D=3D T::PHY_DEVICE_ID.id
        }
    }

---
Cheers,
Benno

