Return-Path: <netdev+bounces-56651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5CE80FBB2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AECEB20AA9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319420E7;
	Wed, 13 Dec 2023 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BRwfQ9bQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73C4B2;
	Tue, 12 Dec 2023 16:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702425730; x=1702684930;
	bh=/KuvqxdpxOh+ImzB+epNeV1Z6AsoGYNl6JUZwWEGme0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BRwfQ9bQpbIli5DBRPJpkyD4pxbBHw+qjzBONodaVDmNNbQUjc3hRk8oAb2GNqMi2
	 i1WqRUrOhLm9VhQl2tpuv2LUhV64m4LT4VbmRzgt4QF6n2ni1IjXuG2N65TfJghhvn
	 cpcHBXdIpUvln8hebp8gu+2xqVmRipWBktQCqEEo+aYrd+wGd0gfZqy0SnScPYbPO7
	 6gz4Kzjcgqh1p1izSEQSZ8OrAyIWfStboYqpVPMp6t3+PoT9J83m6xmNr/fw8g8oWu
	 XYuCzvnnJSz5iaHsvfW+SJ9jnx67Y0fHB/KDeo3h98/6B1F/n5KJH02SlBitBSZvfs
	 bBl6TJlgsg8aw==
Date: Wed, 13 Dec 2023 00:02:02 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
Message-ID: <49f97e63-b2c9-4adc-b0cd-695689444c03@proton.me>
In-Reply-To: <20231213.082749.16210309490355798.fujita.tomonori@gmail.com>
References: <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me> <ZXjBKEBUrisSJ7Gx@boqun-archlinux> <e9997f99-7261-4e9e-b465-e3869b6f4a6f@proton.me> <20231213.082749.16210309490355798.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.12.23 00:27, FUJITA Tomonori wrote:
> On Tue, 12 Dec 2023 22:40:01 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>> Actually, why can't we just use the normal `rust_helper_*` approach? So
>> just create a `rust_helper_phy_read` that calls `phy_read`. Then call
>> that from the rust side. Doing this means that we can just keep the
>> invariants of `struct phy_device` opaque to the Rust side.
>> That would probably be preferable to adding the `TODO`, since when
>> bindgen has this feature available, we will automatically handle this
>> and not forget it. Also we have no issue with diverging code.
>=20
> I wasn't sure that `rust_helper_*` approach is the way to go.

It is the way to go to avoid code duplication and call those
functions.

--=20
Cheers,
Benno


