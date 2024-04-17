Return-Path: <netdev+bounces-88604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFD98A7E0D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0CF81C21EBD
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD277D3F0;
	Wed, 17 Apr 2024 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nAM/4NC+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0B6F066
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342060; cv=none; b=T/XONwrsXfab9BlUu5YHE36g8LcVar89T/VPHoYrtXhxeSxW/0SMS+qEpJf5S3exD2r1RyohEZ3dgm8hgzTz5HGaEC4vHzsIC8xOJ/54Et7xOZmnq3/SJOic6rZoU6MBbWSqlbdmrVbIDJEwYsgfR0qV72Drd4GeEvlZnZrrYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342060; c=relaxed/simple;
	bh=5MJ4ULJtiT+NtD9quXQLg5e8ZoTj/dJm+IRRRJYsaW8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTfkD4GbN/zG+8/ELNZWs7GJn6/khw0/NbJYIgdOUwxz+BlSQT8M5MNVeSLeG+tjw0yO8wiKSo4GBiZvqVkUB4lzNu+R4lO2mYGu+Dbl4QW1YOOYLDrqM0alDTMcapOkLDdFktISseiEKkwtUmVFBPgM4XuY9o9K0cEX5CxVxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nAM/4NC+; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=t4f7k7zxxzff5dq6yi37iz4tsm.protonmail; t=1713342050; x=1713601250;
	bh=oSROv3Iwo6bfEF+7tLKAC5SiM8qWLf03xQ+IXBGe/uU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nAM/4NC+NjUFFV3Bidlgy49rHmBWC+gjfVUqA6PzjJ5c5yvOKdSsoBI5fApd4i3vp
	 9Q+N5nHEloE9+CUgB130mlGckg28sk087ZsZDd6IWIuig67rfgSqyVqjJNVpGHNKHF
	 W+9tF6djcev8OSHiKK0A2xFBStFVFA0lzhISXcEk7cEBdiFEojBcGyeuNZP5m0PomL
	 356b2Yb6DaEwiju+no3ZdqdWUvcOw38+qiUp6TxtvKyUo5i6a/7GY9XVHezM+5w1/F
	 vEVYetW2u4CXTnnv3xixsJ0yGtbLDU6NG+abhl+NlzRG6o3OYyqwK7NptfGIigngSq
	 NHoAWZTSduwSg==
Date: Wed, 17 Apr 2024 08:20:25 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
Message-ID: <92b60274-6b32-4dfd-9e46-d447184572d2@proton.me>
In-Reply-To: <f908e54a-b0e6-49d5-b4ff-768072755a78@lunn.ch>
References: <e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch> <20240416.204030.1728964191738742483.fujita.tomonori@gmail.com> <26f64e48-4fd3-4e0f-b7c5-e77abeee391a@lunn.ch> <20240416.222119.1989306221012409360.fujita.tomonori@gmail.com> <b03584c7-205e-483f-96f0-dde533cf0536@proton.me> <f908e54a-b0e6-49d5-b4ff-768072755a78@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.24 00:30, Andrew Lunn wrote:
>> I think we could also do a more rusty solution. For example we could
>> have these generic functions for `phy::Device`:
>>
>>      fn read_register<R: Register>(&mut self, which: R::Index) -> Result=
<R::Value>;
>>      fn write_register<R: Register>(&mut self, which: R::Index, value: R=
::Value) -> Result;
>>
>> That way we can support many different registers without polluting the
>> namespace. We can then have a `C45` register and a `C22` register and a
>> `C45OrC22` (maybe we should use `C45_OrC22` instead, since I can read
>> that better, but let's bikeshed when we have the actual patch).
>>
>> Calling those functions would look like this:
>>
>>      let value =3D dev.read_register::<C45>(reg1)?;
>>      dev.write_register::<C45>(reg2, value)?;
>=20
> I don't know how well that will work out in practice. The addressing
> schemes for C22 and C45 are different.
>=20
> C22 simply has 32 registers, numbered 0-31.
>=20
> C45 has 32 MDIO manageable devices (MMD) each with 65536 registers.
>=20
> All of the 32 C22 registers have well defined names, which are listed
> in mii.h. Ideally we want to keep the same names. The most of the MMD
> also have defined names, listed in mdio.h. Many of the registers are
> also named in mdio.h, although vendors do tend to add more vendor
> proprietary registers.
>=20
> Your R::Index would need to be a single value for C22 and a tuple of
> two values for C45.

Yes that was my idea:

    enum C22Index {
        // The unique 32 names of the C22 registers...
    }

    impl Register for C22 {
        type Index =3D C22Index;
        type Value =3D u16;
    }

    impl Register for C45 {
        type Index =3D (u8, u16); // We could also create a newtype that wr=
aps this and give it a better name.
        type Value =3D u16;
    }

You can then do:

    let val =3D dev.read_register::<C45>((4, 406))?;
    dev.write_register::<C22>(4, val)?;

If you only have these two registers types, then I would say this is
overkill, but I assumed that there are more.

> There is nothing like `C45OrC22`. A register is either in C22
> namespace, or in the C45 namespace.

I see, I got this idea from:

> [...] At some point we are going to add the generic
> helpers for accessing C45 registers which leave the core to decide
> if to perform a C45 bus protocol access or C45 over C22. [...]

Is this not accessing a C45 register via C22 and letting phylib decide?

> Where it gets interesting is that there are two methods to access the
> C45 register namespace. The PHY driver should not care about this, it
> is the MDIO bus driver and the PHYLIB core which handles the two
> access mechanisms.

If the driver shouldn't be concerned with how the access gets handled,
why do we even have a naming problem?

--=20
Cheers,
Benno


