Return-Path: <netdev+bounces-88200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54118A646D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 08:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F04281730
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 06:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D126EB75;
	Tue, 16 Apr 2024 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BL5y1MbA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21486BFCF
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250733; cv=none; b=gsY5iGtxDGpu2BNGetrUmZRjueDdqQIiA13CsqZD7BmDz+DUZ1U5ssKVt7t0ioq+K2Kp16LthMhTuW6Tk+KKVJBg7ig9Gbvbvypnq5tM1eQgr3Luxnx0ok+NRPOfuu45Q3n4f+o83rIYHnkiBAzAcLCgbinmMv1cE/I+C1/mFFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250733; c=relaxed/simple;
	bh=NBjs8grZwXaIcR6/LawdWIa5WJtS66VB/KOhrlHNB4E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M18idDhc5Goe7HLoG6GxnTg+ZCfIUkvbcJge7/FBOnPtsWOA2S8oiK6MMsz+pg2Cf8UZuzRx8mPqCEoLPW2vnBYTdBI9zuy4cDR5NuKg5MmGZm3T2H3POdT7bZjebFPrKPM3bLNsLoU7vPB1AH5pRjka4ZKz61tL7QzrPfyXVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BL5y1MbA; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1713250724; x=1713509924;
	bh=1tsbvR7Mtdi4p5PcUPkcPg2hEiKtva5OvOJQGQYO5kk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BL5y1MbAdjYj6P+ZqzdtKfJIRk6nCj5f1IWZ3FGLHrurcez+Vg8/HA1z+3LtUf8c4
	 PFhLObzdPrdu34hGp0A5t2Xr02ubo67+EmWpqISxn1kvDy4ct7lb7hWS5EhDl/WDVZ
	 ES2uBbTVq8iS9obMSXZ/rs9VT0Q/yGheD+VKFHbf3olggGmlWzcVFU12Ljf4r15NaP
	 xmnkvTxD7kROdqL8ROOvBTSdE1F1ESNZSbN8HpxmWIR8LX1zhmt5y23RICjRB6xK7S
	 ilcGWHIc1sKRojyGhfy8qbdpVP0nv5qQmSTDjDxhf37n0drqCOkn+fih5O4rSFLkDI
	 OdJSAMQZp/SqQ==
Date: Tue, 16 Apr 2024 06:58:38 +0000
To: Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY driver
Message-ID: <89f6cd1e-2e3c-4fc1-b9a5-2932480f8e60@proton.me>
In-Reply-To: <CALNs47v+35RX4+ibHrcZgrJEJ52RqWRQUBa=_Aky_6gk1ika4w@mail.gmail.com>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com> <20240415104701.4772-5-fujita.tomonori@gmail.com> <CALNs47v+35RX4+ibHrcZgrJEJ52RqWRQUBa=_Aky_6gk1ika4w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.04.24 06:34, Trevor Gross wrote:
> On Mon, Apr 15, 2024 at 6:47=E2=80=AFAM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
>> +struct PhyQT2025;
>> +
>> +#[vtable]
>> +impl Driver for PhyQT2025 {
>> +    const NAME: &'static CStr =3D c_str!("QT2025 10Gpbs SFP+");
>=20
> Since 1.77 we have C string literals, `c"QT2025 10Gpbs SFP+"` (woohoo)

We have our own `CStr` in the `kernel::str::CStr`, so we cannot replace
the `c_str!` macro by the literal directly. Instead we also need to
remove our own `CStr`. We already have an issue for that:
https://github.com/Rust-for-Linux/linux/issues/1075

--=20
Cheers,
Benno


