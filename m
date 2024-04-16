Return-Path: <netdev+bounces-88494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 663758A7772
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC691F21A37
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477D6EB59;
	Tue, 16 Apr 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kWSLtw4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F538FA6
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305260; cv=none; b=F4EPad3+rPyf09Mgr7dz5O9tJQ0CUqt2iMmSsZ+u1403Itz2H4Glnu3kAnHCuxN+N0ripcjBHWd/ezpzB4HWvyxOQNC5xZLYEnUhCuk6eGV6cWnR+wf01Hxe9CvHA9eTqJXgvbZNgSbuxn9T9Z91mh1WgLkeGaT/MWJDLKXfdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305260; c=relaxed/simple;
	bh=cYGVboTlIfqElffrNlKni+yFnpS+35l9+bJ/YL6PBGc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xh9FbVIbaDp7GigQu8a0vv1j/odIib4hyEOLG/+7nVgIqrL6IKRkVCjlS9RpHRsNC51eA4RoPtFtsL8WQQOLEiOPb8lghvZrosREtG7LSWNRn8D9ez5bY3qotDNX1IQiPl2Eeu65+ns0DHS600QqAEvQxcXOadCb0xg2wGAT0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kWSLtw4H; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=emox6spn4zeddk32fj3u476rna.protonmail; t=1713305256; x=1713564456;
	bh=PjHGitF/8tyOooreLZws1UPxqnJB/DnU8P0pBnlRMJE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kWSLtw4HvgFsnzlpnxOjwMFUtMxAATyUF7lCWqI+ZHRTUq1eb3QpsQGA0E/OcaIS5
	 6mnI+MT0uwcNHMMTnvgZSEMWQpFI95Ppc2mqOavByCOL32mSwqNAnf5UtwF/noSv3U
	 eNRwjkppMmhR3JvrDACipeUdU40sfWHUzgqB8OG7xIG7lC4k5JtSiF50vn4z56nkw7
	 oYYSkvgvOBQuXa6XnHkRqWSnsNfREKhcoO5kxroe3bHfX+72CVH3SsocDVuZCBsy0r
	 5pU+ibizJEEuuukweK78GcaQupE80/Wqz+M13iXtxn4oRqPMJo8BWGbcI8O0Yv/7CX
	 9zKDudJCv9peg==
Date: Tue, 16 Apr 2024 22:07:26 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, andrew@lunn.ch
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
Message-ID: <b03584c7-205e-483f-96f0-dde533cf0536@proton.me>
In-Reply-To: <20240416.222119.1989306221012409360.fujita.tomonori@gmail.com>
References: <e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch> <20240416.204030.1728964191738742483.fujita.tomonori@gmail.com> <26f64e48-4fd3-4e0f-b7c5-e77abeee391a@lunn.ch> <20240416.222119.1989306221012409360.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.04.24 15:21, FUJITA Tomonori wrote:
> Hi,
>=20
> On Tue, 16 Apr 2024 14:38:11 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
>>> If I correctly understand the original driver code, C45 bus protocol
>>> is used. Adding functions for C45 bus protocol read/write would be
>>> enough for this driver, I guess.
>>
>> Now i've read more of the patches, i can see that the MDIO bus master
>> is C45 only. At least, that is all that is implemented in the
>> driver. So for this combination of MAC and PHY, forcing C45 register
>> access using C45 bus protocol will work.
>=20
> Thanks a lot!
>=20
>> However, can you combine this PHY with some other MDIO bus master,
>> which does not support C45? Then C45 over C22 would need to be used?
>> Looking at the data sheet i found online, there is no suggestion it
>> does support C22 bus protocol. All the diagrams/tables only show C45
>> bus protocol.
>=20
> qt2025_ds3014.pdf?
>=20
>> So this PHY is a special case. So you can use wrapper methods which
>> force C45 bus protocol, and ignore phylib support for performing C45
>> over C22 when needed. However, while doing this:
>>
>> 1: Clearly document that these helpers are not generic, they force C45
>>     register access using C45 bus protocol, and should only by used PHY
>>     drivers which know the PHY device does not support C45 over C22
>>
>> 2: Think about naming. At some point we are going to add the generic
>>     helpers for accessing C45 registers which leave the core to decide
>>     if to perform a C45 bus protocol access or C45 over C22. Those
>>     generic helpers need to have the natural name for accessing a C45
>>     register since 99% of drivers will be using them. The helpers you
>>     add now need to use a less common name.
>=20
> Sounds like we should save the names of c45_read and c45_write.
>=20
> read_with_c45_bus_protocol and write_with_c45_bus_protocol?
>=20
> They call mdiobus_c45_*, right?

I think we could also do a more rusty solution. For example we could
have these generic functions for `phy::Device`:

     fn read_register<R: Register>(&mut self, which: R::Index) -> Result<R:=
:Value>;
     fn write_register<R: Register>(&mut self, which: R::Index, value: R::V=
alue) -> Result;

That way we can support many different registers without polluting the
namespace. We can then have a `C45` register and a `C22` register and a
`C45OrC22` (maybe we should use `C45_OrC22` instead, since I can read
that better, but let's bikeshed when we have the actual patch).

Calling those functions would look like this:

     let value =3D dev.read_register::<C45>(reg1)?;
     dev.write_register::<C45>(reg2, value)?;

--=20
Cheers,
Benno


