Return-Path: <netdev+bounces-49001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA23F7F057C
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 11:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA9D1F21213
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92EC8F3;
	Sun, 19 Nov 2023 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="i7nMGOrZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF615E6
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=4ii2ajbsjncplfoh4zjopy23oy.protonmail; t=1700391301; x=1700650501;
	bh=jqLDmMfO2TElLbR8M69auYqNvBWjiwEp3/3lVXJ49to=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i7nMGOrZIzrSpkwXAxFjmbxf48nYCAjX8gvgKQTWfsGZcGjtqWp0TSCVL/g9y9PGp
	 cGJTWiQBH9O3ssuo0RD49uDNpH5dDHJaWMB4Kafvk8lkcB4FE8v8J+HV7ky5wLbtz8
	 MZ4GX/4QJSs38Q+GdZgQClM2soD3Ylyxstu0xlmaH+X/kKbg2mqxSc9dh5A5oYDT+r
	 RUmRyoiALc/Tw93GqQ8DT93Qfj6ZbW+ea2WHNskjvTM97SXlsLjs4d01N/J1O/PRT2
	 ScznKsjlI0QA2Fys0mrR9gL4wjMOAxWxGTGwkS/t9WcBG4V5mGqzmebH8SYzdq0AeQ
	 eoGharf+Pllvg==
Date: Sun, 19 Nov 2023 10:54:40 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, aliceryhl@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver macro
Message-ID: <0a1889c9-938c-4be8-946e-c330112e1ed8@proton.me>
In-Reply-To: <20231119.195035.2131772627066676234.fujita.tomonori@gmail.com>
References: <20231026001050.1720612-3-fujita.tomonori@gmail.com> <20231117093908.2515105-1-aliceryhl@google.com> <20231119.195035.2131772627066676234.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.11.23 11:50, FUJITA Tomonori wrote:
> On Fri, 17 Nov 2023 09:39:08 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
>>> +            ::kernel::bindings::mdio_device_id {
>>
>> Here, I recommend `$crate` instead of `::kernel`.
>=20
> I copied the code that Benno wrote, IIRC. Either is fine by me. Why
> `$crate` is better here?

When I suggested that, I might have confused the location of the macro
being in the `macros` crate. There you cannot use `$crate`, since it
is not available for proc macros. But since this is in the `kernel`
crate, you can use `$crate`.

`$crate` is better, since it unambiguously refers to the current crate
and `::kernel` only works, because we named our crate `kernel`. So the
code using `$crate` is more portable.

> Also better to replace other `::kernel` in this macro?

Yes.

--=20
Cheers,
Benno



