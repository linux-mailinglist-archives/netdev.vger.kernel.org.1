Return-Path: <netdev+bounces-56649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE780FBAD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436EB1F215B2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D578A41;
	Wed, 13 Dec 2023 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lHurQAAl"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 23148 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 16:01:36 PST
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF14B2
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 16:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702425693; x=1702684893;
	bh=3x51AzWsJ59PFrlgGbN+RTbEalkmX7aq48wqQb6pGI0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lHurQAAlgssL0HO0Kt75e4difzN0RITCRmFbGKQ4nHfGB/022WlZPOlX2F5RbQYWT
	 e4WBltU/Meq3t40B5YLaEoCHis3vHLcxpYDWwfr707HDID6zAAUUNllWuA4U0w0V0l
	 WgpBrfFLPbS9fOZsKvF4x0Iv2L9wYCd+Eu6Z+h3RDjxSVVQKICE5/PwonmHFvBSobK
	 ecuAsdcPrA0xaTV7nPrIkjYyyes2GU8zGVRj+rllrclmI7x1bf1Fa4Z8xc1YvkZj+F
	 bMk6H4E5nLYBGCeO3jXPjqms62SxteLRqx3yFMz6sMr4Pcmal7OjovzieefhOANf/G
	 QOR62ZO3RvwDw==
Date: Wed, 13 Dec 2023 00:01:15 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
Message-ID: <e633456e-dc97-48bf-b204-0003b51a38c7@proton.me>
In-Reply-To: <20231213.083109.2097548498951503416.fujita.tomonori@gmail.com>
References: <20231212.220216.1253919664184581703.fujita.tomonori@gmail.com> <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me> <ZXjBKEBUrisSJ7Gx@boqun-archlinux> <20231213.083109.2097548498951503416.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.12.23 00:31, FUJITA Tomonori wrote:
> On Tue, 12 Dec 2023 12:23:04 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
>> So the rationale here is the callsite of mdiobus_read() is just a
>> open-code version of phy_read(), so if we meet the same requirement of
>> phy_read(), we should be safe here. Maybe:
>>
>> =09"... open code of `phy_read()` with a valid phy_device pointer
>> =09`phydev`"
>>
>> ?
>=20
> I'll add the above comment with the similar for phy_write(), thanks!

Why don't you use the `rust_helper` approach?

--=20
Cheers,
Benno



