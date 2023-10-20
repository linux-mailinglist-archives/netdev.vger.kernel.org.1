Return-Path: <netdev+bounces-43083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D27D1548
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97397282402
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9D4208B1;
	Fri, 20 Oct 2023 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UjGxl25L"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FC2032F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:56:35 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B65D55
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697824590; x=1698083790;
	bh=k33+/p34dbe/7wIvgqR0uJAbAz0eZCxXH/bmotNqR3Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UjGxl25Lt+JNfpT73ZnYXl2qb72Y832itb0ZR/e1my8f/hBaLgCNsZqNaZKI6x9C5
	 lLrdTSwNOE9b72ZsXRgxAnUxk5g4n1LNc8XIgL97zmCE+cn5u28MuNPFOcAx4/iptV
	 pzZ2IhYoPfNrFV9esMQsfOGDKutrLfG4ICDRsbAogIwwpKWTSUmMxRrGe3BX46dyJH
	 EBit/aLbDHSrBDfzM2xSL7amTkDKmBlwTXcnxQQPl6i6KWXxPqxkEJgPWuLggYKVDM
	 PdiOtlqX9LnJkEGm6Z7k3hnzVWAfguTgOorgtB6KRuFamjAQRu1QeZfYmXqBMHGzi/
	 vM3Xs6uEg3F7A==
Date: Fri, 20 Oct 2023 17:56:17 +0000
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>, FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <92fca611-a87c-4994-b2fe-bda146ca6c5f@proton.me>
In-Reply-To: <87sf65gpi0.fsf@metaspace.dk>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com> <20231017113014.3492773-2-fujita.tomonori@gmail.com> <87sf65gpi0.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.10.23 19:26, Andreas Hindborg (Samsung) wrote:
>> +
>> +    /// Overrides the default MMD write function for writing a MMD regi=
ster.
>> +    fn write_mmd(_dev: &mut Device, _devnum: u8, _regnum: u16, _val: u1=
6) -> Result {
>> +        Err(code::ENOTSUPP)
>> +    }
>> +
>> +    /// Callback for notification of link change.
>> +    fn link_change_notify(_dev: &mut Device) {}
>=20
> It is probably an error if these functions are called, and so BUG() would=
 be
> appropriate? See the discussion in [1].

Please do not use `BUG()` I wanted to wait for my patch [1] to be merged
before suggesting this, since then Tomo can then just use the constant
that I introduced.

> [1] https://lore.kernel.org/rust-for-linux/20231019171540.259173-1-benno.=
lossin@proton.me/

--=20
Cheers,
Benno



