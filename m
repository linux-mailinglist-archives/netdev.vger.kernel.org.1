Return-Path: <netdev+bounces-44200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA9B7D701F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A09B210B5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3AA28E28;
	Wed, 25 Oct 2023 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LE82qEIg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2562869B
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:55:05 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F613A
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698245699; x=1698504899;
	bh=HgfdZA+aX6ashpUW7mR1qIlhX8QoSG0tj5NOpoTVPHI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LE82qEIgmePO6sG/GOgBuqn9SjRCKaVeaGA/PRPr3bp/YS4c/A8QTWCHB5uOB/QaH
	 yepMu8tGnuCurN6BTOh+pEXESkprwDF3ksfB4ph0mYc7t051oMT3ORAIpGcLJ5wdP2
	 gRlaFeBxXQ/cFPRrNk9twFT6nb5CMZ8mUGsr0s5g4PqFTrSXwSIp09NAS7Lnp87HHa
	 PYzkSx0nATke9gcjulqcX8rTY5AOJhVvHy0H4mQkVoz7QKZXAdR4TGcMZRYMYGZMVS
	 lq5tV1TxJjqfVZbOsMUQ1gjhH3zuhuAJTBT0WLJEWv9QFCIshKz8hNaCi7/qc53u73
	 YyMMu8ujvD9HA==
Date: Wed, 25 Oct 2023 14:54:42 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 1/5] rust: core abstractions for network PHY drivers
Message-ID: <f99c8f3b-95eb-4e68-af25-62a5a0a8de64@proton.me>
In-Reply-To: <20231025.195741.1692073290373860448.fujita.tomonori@gmail.com>
References: <1f61dda0-1e5e-4cdb-991b-1107439ecc99@proton.me> <20231025.101046.1989690650451477174.fujita.tomonori@gmail.com> <46b4ea56-1b66-4a8f-8c30-ecea895638b2@proton.me> <20231025.195741.1692073290373860448.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.10.23 12:57, FUJITA Tomonori wrote:
> On Wed, 25 Oct 2023 07:24:00 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>>> /// PHY state machine states.
>>> ///
>>> /// Corresponds to the kernel's
>>> /// [`enum phy_state`](../../../../../networking/kapi.html#c.phy_state)=
.
>>> ///
>>> /// Some of PHY drivers access to the state of PHY's software state mac=
hine.
>>
>> That is one way, another would be to do:
>=20
> This looks nicer.
>=20
>> /// PHY state machine states.
>> ///
>> /// Corresponds to the kernel's [`enum phy_state`].
>> ///
>> /// Some of PHY drivers access to the state of PHY's software state mach=
ine.
>> ///
>> /// [`enum phy_state`]: ../../../../../networking/kapi.html#c.phy_state
>>
>> But as I noted before, then people who only build the rustdoc will not
>> be able to view it. I personally would prefer to have the correct link
>> offline, but do not know about others.
>=20
> I prefer a link to online docs but either is fine by me. You prefer a
> link to a header file like?
>=20
> /// [`enum phy_state`]:  ../../../include/linux/phy.h

No. I think the header file should be mentioned for the whole
abstraction. I personally always use [1] to search for C symbols, so
the name suffices for me. And the documentation is (for me at least)
less accessible (if there is a nice tool for that as well, please tell me).

[1]: https://elixir.bootlin.com/linux/latest/source

--=20
Cheers,
Benno



