Return-Path: <netdev+bounces-45011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517287DA81A
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 18:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D0A2B210FA
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B99455;
	Sat, 28 Oct 2023 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Okm4VtjS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8C168B6;
	Sat, 28 Oct 2023 16:38:06 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE0E5;
	Sat, 28 Oct 2023 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698511082; x=1698770282;
	bh=fRSFyiOLkK6B3P8cY3NNFYg4XR+tS5wvzFwTik49HSA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Okm4VtjSXtZo8ZDgP0kmnqy0JRix+aa2TvB85UkIvpjG0+8YI+1sBfRdDI6YR+Wnz
	 7ypMtneTaNTxlomsPX1wLt0Zu5uf9mjlFZQ1K5NrOJS+qBbu4ocB1WOzY6PYTulJUj
	 4Xs73H9zrxmu3zfggKL1yVN1lEGLObQvK+Oh2T75FVlJSfEMa6ivaedhuFPafTtORt
	 loDvbtjeL2LQCjyoLIfIKpE1bqobqhsFK3V4MkNnaJN4iUdhNq/JIE0nFDNE3WZxvX
	 vTnFJBm6QmuPEJY0ztyhBWqBFpxguRT1FBlXB0xqzn6iymRG+WBBBweCmDM3HuYu2l
	 BhRoYO1pnk8ng==
Date: Sat, 28 Oct 2023 16:37:53 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
Message-ID: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
In-Reply-To: <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com> <ZTwWse0COE3w6_US@boqun-archlinux> <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me> <20231028.182723.123878459003900402.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.10.23 11:27, FUJITA Tomonori wrote:
> On Fri, 27 Oct 2023 21:19:38 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>> I did not notice this before, but this means we cannot use the `link`
>> function from bindgen, since that takes `&self`. We would need a
>> function that takes `*const Self` instead.
>=20
> Implementing functions to access to a bitfield looks tricky so we need
> to add such feature to bindgen or we add getters to the C side?

Indeed, I just opened an issue [1] on the bindgen repo.

[1]: https://github.com/rust-lang/rust-bindgen/issues/2674

--=20
Cheers,
Benno


