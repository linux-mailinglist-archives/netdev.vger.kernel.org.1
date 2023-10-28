Return-Path: <netdev+bounces-45002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A38527DA6BF
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 13:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BDE2822C1
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671B6125D5;
	Sat, 28 Oct 2023 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="V1zbv65b"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92151DF57
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 11:42:00 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4EDE
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698493315; x=1698752515;
	bh=nJ/RLhSQQxDJCV667FIlY0OXMJZ66uaeodg8xQv58WY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=V1zbv65b93CQqEroRlIFjI0OUXxNYiG9oElfQdkXZkQgKB2gZDChum2+8nInmRsed
	 lpnRkbnnZFN1qx2R6fSInNmjsePNuD2PpcHYUD7Ws0fjIRN7ow374fM5DPMR115E9t
	 5e+yz9y4bUNrV8teV2xFKYBWXrirsZW5XagBYguU7GJkOBUXZ7lSkoNz8an0Va4Ta7
	 UII0pwCOe2jCjhkukP+CvbTnN5DbZf+lTnA3IUtIXSrym7CNVcPPpMcdUVFOGZSRgu
	 wleOt6RVqWshRqWQljehcA45+tIsx68NS5Z8sSEaueFbPCFht9ymxMfoLaMrzq8/EY
	 qw4fYqKoAxsOg==
Date: Sat, 28 Oct 2023 11:41:52 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jakub Kicinski <kuba@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <1e8b5a62-047a-4b87-9815-0ea320ccc466@proton.me>
In-Reply-To: <CANiq72k4MFe2qL5XrweObo-bxT9qPA6+GAF4bSwLzyQJRX-mJw@mail.gmail.com>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com> <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com> <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch> <CANiq72mDVQg9dbtbAYLSoxQo4ZTgyKk=e-DCe8itvwgc0=HOZw@mail.gmail.com> <20231027072621.03df3ec0@kernel.org> <CANiq72n=ySX08MMMM6NGL9T5nkaXJXnV2ZsoiXjkwDtfDG11Rw@mail.gmail.com> <ca9fc28e-f68a-4b80-b21f-08a3edf3903a@lunn.ch> <CANiq72k4MFe2qL5XrweObo-bxT9qPA6+GAF4bSwLzyQJRX-mJw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/28/23 13:07, Miguel Ojeda wrote:
> On Sat, Oct 28, 2023 at 12:55=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
>> It should also be noted that 80, or 100, is not a strict limit. Being
>> able to grep the kernel for strings is important. So the coding
>> standard allows you to go passed this limit in order that you don't
>> need to break a string. checkpatch understands this. I don't know if
>> your automated tools support such exceptions.
>=20
> Not breaking string literals is the default behavior of `rustfmt` (and
> we use its default behavior).
>=20
> It is also definitely possible to turn off `rustfmt` locally, i.e. for
> particular "items" (e.g. a function, a block, a statement), rather
> than lines, which is very convenient.
>=20
> However, as far as I recall, we have never needed to disable it. I am
> sure it will eventually be needed somewhere, but what I am trying to
> say is that it works well enough that one can just use it.

We have it disabled on the `pub mod code` in error.rs line 20:
https://elixir.bootlin.com/linux/latest/source/rust/kernel/error.rs#L20

--=20
Cheers,
Benno



