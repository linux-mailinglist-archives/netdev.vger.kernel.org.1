Return-Path: <netdev+bounces-119489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46833955D6B
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 18:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3C9B20AC1
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BD714431B;
	Sun, 18 Aug 2024 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WD46usPt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516212F2B;
	Sun, 18 Aug 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723997821; cv=none; b=brRumdLTL9BrLZXth9MTA0VwJoQ+GFuz3gZ2wD+ullyq/arHvhWLj9NMu9984w+pbehTUiTugRONhTY/Pc2AI9V/+KeaOQHOhvgnsYkNHD02N7MQc6LU/fKBSGriaaTFs/Vid4F+RjI1WUJ61XH8hDLYA006goL9o8g1Pte1rWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723997821; c=relaxed/simple;
	bh=RkwSHKejoAQPnezFiyyWDoJti35gIex6IIlTXK6qEtE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjDDFY6EqtmCr0CLndWkoQC/CY6lZoDCusvjEfsIHXB5xyhDZCjpLdoQpJrusURwHog3+98i7Yd2WBBFHqPjSojl7GIp6JFg6brPKRHhpqHylLgoM2Mx2rN/QSE4xNyGW50Ficwf0fNgpsOD+q7iegSUufFdH5M+rOcYmo1/AhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WD46usPt; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723997816; x=1724257016;
	bh=XtxRPFsHxF9Zht1sZqvfaixka9VS1n74HNnfA8l6sKk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WD46usPtgaprK1BlAn77TVjKpVEpYRVB4ohqgrx3JRMGXnDjxhb8i4DI5W5kGV0iB
	 VnYQ6BmsRDhiqTyC/ZuC42IHBBgIRMP/rwNnjRHe7kyIibhcXxyePQbAjJ4lGgknpE
	 DISW1SDz+YdanwfeSNnhiCDTJFdOz5EBmaDriAaHzp0aRvpLU6SNrGiL1aA5cyWp7d
	 yVOuetx50nsmX6VEbzguCZm3pqRdfXBQVHll5e+xjdIBBtMpqM10ZAfQ/ctkhjjT9Z
	 yfO2yBQamq6tkP7QljOA6w7bUBsvO9qJ4WuGjvd/S/wwxAmuMPNLCMexuEjfFpttt7
	 GVIWOa6+myl0g==
Date: Sun, 18 Aug 2024 16:16:50 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 6/6] net: phy: add Applied Micro QT2025 PHY driver
Message-ID: <0797f8e8-ea3c-413d-b782-84dd97919ea9@proton.me>
In-Reply-To: <1a717f2d-8512-47bd-a5b3-c5ceb9b44f03@lunn.ch>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com> <20240817051939.77735-7-fujita.tomonori@gmail.com> <9a7c687a-29a9-4a1a-ad69-39ce7edad371@lunn.ch> <7f835fe8-e641-4b84-a080-13f4841fb64a@proton.me> <1a717f2d-8512-47bd-a5b3-c5ceb9b44f03@lunn.ch>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: af6c945b30717d31c2603391eb52f5f4e6b74330
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.08.24 17:44, Andrew Lunn wrote:
> On Sat, Aug 17, 2024 at 09:34:13PM +0000, Benno Lossin wrote:
>> On 17.08.24 20:51, Andrew Lunn wrote:
>>>> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
>>>> +        dev.genphy_read_status::<C45>()
>>>> +    }
>>>
>>> Probably a dumb Rust question. Shouldn't this have a ? at the end? It
>>> can return a negative error code.
>>
>> `read_status` returns a `Result<u16>` and `Device::genphy_read_status`
>> also returns a `Result<u16>`. In the function body we just delegate to
>> the latter, so no `?` is needed. We just return the entire result.
>>
>> Here is the equivalent pseudo-C code:
>>
>>     int genphy_read_status(struct phy_device *dev);
>>
>>     int read_status(struct phy_device *dev)
>>     {
>>         return genphy_read_status(dev);
>>     }
>>
>> There you also don't need an if for the negative error code, since it's
>> just propagated.
>=20
> O.K, it seems to work. But one of the things we try to think about in
> the kernel is avoiding future bugs. Say sometime in the future i
> extend it:
>=20
>     fn read_status(dev: &mut phy::Device) -> Result<u16> {
>         dev.genphy_read_status::<C45>()
>=20
>         dev.genphy_read_foo()
>     }
>=20
> By forgetting to add the ? to dev.genphy_read_status, have i just
> introduced a bug? Could i have avoided that by always having the ?
> even when it is not needed?

The above code will not compile, since there is a missing `;` in the
second line. If you try to do it with the semicolon:

    fn read_status(dev: &mut phy::Device) -> Result<u16> {
        dev.genphy_read_status::<C45>();
=20
        dev.genphy_read_foo()
    }

Then you get this error:

    error: unused `core::result::Result` that must be used
      --> drivers/net/phy/qt2025.rs:88:9
       |
    88 |         dev.genphy_read_status::<C45>();
       |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
       |
       =3D note: this `Result` may be an `Err` variant, which should be han=
dled
       =3D note: `-D unused-must-use` implied by `-D warnings`
       =3D help: to override `-D warnings` add `#[allow(unused_must_use)]`
    help: use `let _ =3D ...` to ignore the resulting value
       |
    88 |         let _ =3D dev.genphy_read_status::<C45>();
       |         +++++++

If you want to use `?` regardless, you will have to do this:
    =20
     fn read_status(dev: &mut phy::Device) -> Result<u16> {
         Ok(dev.genphy_read_status::<C45>()?)
     }

In my opinion this does not add significant protection for the scenario
that you outlined and is a lot more verbose. But if you're not used to
Rust, this might be different, since the code below looks more wrong:

    fn read_status(dev: &mut phy::Device) -> Result<u16> {
        Ok(dev.genphy_read_status::<C45>()?);
       =20
        dev.genphy_read_foo()
    }

But I would keep it the way it currently is.

---
Cheers,
Benno


