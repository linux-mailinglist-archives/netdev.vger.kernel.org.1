Return-Path: <netdev+bounces-119452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609E955B11
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 08:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B797D2825A3
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631588F6E;
	Sun, 18 Aug 2024 06:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OX+Pcs8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32007C8C7
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723960902; cv=none; b=txO4sIz2aGWdVe1yxPsDVKZiC5xFpvHPL6L6PCro4pRaFG3CKXkGE4dLv5SJ2yaDxMLzESc1Ho2I1+NkOOFB9a3/7Wt5u7hbYWiTeCKJlher2qpTRTy3JVr1nANUaBETN3/aM8fIAbNTdTPTgkmfwZC1OpGx3fgXzrHnpYsYtis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723960902; c=relaxed/simple;
	bh=sSay9UZZv++fsQuYsHiT010dJFApXiutB6PF3gfAU/o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+UT0NjPy+puwIwkfvj8mo3JEBKWqKisOJYwUF7j5vRENMrQFU61jibI7qDxTqll/4yhf5bvf8fH9pRp1ZGaOp0edl66dZ47HfMi2Iq/lpDZ5l9hJQyk3aWvDovPfLYkVIpyOSvgHxuCEbfavyO532D+xZDvHmTQOLCLIZ7J6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OX+Pcs8v; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ytpmxagfazhtrdthaxiyxwyfn4.protonmail; t=1723960891; x=1724220091;
	bh=uErhKUnuf2w4pZHhrUJvKyqnd0PRYAkmVl1xgi6xWhA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OX+Pcs8vCi//W3TGmuoe7DPvkM47kur/wPgiELw324f9erI3YgrNAJWzCH1w361eV
	 tHDnZqrnUjJ6lbvgpkHHdQ3HtLjNDBW3h8rUlUcjYGygSee7urly19eqFksk1mw0yS
	 jIw2ZAoQC0VUpDalu1oZ0+0/9xkm3j2458nVwZUBEr/box2DCUbsyFiP41uX7SwbH/
	 NrNon8vIna2iRrZv2w6pXmJuFcMhOQgCIy4YMuPT4m5yWtw1dYDqEBWRvOXUNwG1QI
	 eOUsB7l01okLx4MmLtLDFajLPpJruG10JPmOevJcPD0zcnbV859GRGtEXZ3x0Jz87a
	 olpm3pDeoRtEA==
Date: Sun, 18 Aug 2024 06:01:27 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Message-ID: <9127c46d-688c-41ea-8f6c-2ca6bdcdd2cd@proton.me>
In-Reply-To: <20240818.021341.1481957326827323675.fujita.tomonori@gmail.com>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com> <20240817051939.77735-4-fujita.tomonori@gmail.com> <a8284afb-d01f-47c7-835f-49097708a53e@proton.me> <20240818.021341.1481957326827323675.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0476a788e0ce4bb5922cef960aa049dd69b721a8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.08.24 04:13, FUJITA Tomonori wrote:
> On Sat, 17 Aug 2024 13:30:15 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>>> +impl AsRef<kernel::device::Device> for Device {
>>> +    fn as_ref(&self) -> &kernel::device::Device {
>>> +        let phydev =3D self.0.get();
>>> +        // SAFETY: The struct invariant ensures that we may access
>>> +        // this field without additional synchronization.
>>
>> I don't see this invariant on `phy::Device`.
>=20
> You meant that `phy::Device` Invariants says that all methods defined
> on this struct are safe to call; not about accessing a field so the
> above SAFETY comment isn't correct, right?

Correct.

>> ---
>> Cheers,
>> Benno
>>
>>> +        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev)=
.mdio.dev)) }
>>> +    }
>>> +}
>=20
> SAFETY: A valid `phy_device` always have a valid `mdio.dev`.
>=20
> Better?

It would be nice if you could add this on the invariants on
`phy::Device` (you will also have to extend the INVAIRANTS comment that
creates a `&'a mut Device`)

---
Cheers,
Benno


