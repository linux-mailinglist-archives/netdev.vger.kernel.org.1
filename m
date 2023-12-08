Return-Path: <netdev+bounces-55395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FDD80ABAA
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFBB1C20C81
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799246B99;
	Fri,  8 Dec 2023 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QNvfORhD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6C11985
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 10:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=uh47j3qctneedg2modfafjadhm.protonmail; t=1702059089; x=1702318289;
	bh=eyYVy6h961wBZxlPCiDYNFZbn9WyVULjj/c64DRuiCY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QNvfORhD19ahFqoh1z0V+HDnjKjtezCOlyGbHU8Kr/cXElJjc3M8eQBVMs/s9ZUmU
	 QZIGA04TyiYebTzmXWgdN8mTWWkYKKcHL+JqbuaxgGNFgrFVSIpXSyJd1zpUngJy1w
	 lmR6lKmFFtKdzV+b0gOeZvh2xjR2W2x3GISAODX0279aymzXaZUeBopf6uelZqnJim
	 qrxv+e7ByLXaeRq/lTVuMr2x8pVdYihjwfbZETW3JZ/xaSD/PXkWcDiTosTleuCX9O
	 fRws8zojrYtkubbADf+km4q5iuBubPp6vp2MQKdG3yzC77lkxVpIgn/pTKsFdZsb4H
	 JFu4yG80zUfvg==
Date: Fri, 08 Dec 2023 18:11:22 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v9 2/4] rust: net::phy add module_phy_driver macro
Message-ID: <e067e0dd-a8cf-413d-a6e0-8515e9b494bf@proton.me>
In-Reply-To: <20231205011420.1246000-3-fujita.tomonori@gmail.com>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com> <20231205011420.1246000-3-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/5/23 02:14, FUJITA Tomonori wrote:
> This macro creates an array of kernel's `struct phy_driver` and
> registers it. This also corresponds to the kernel's
> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
> loading into the module binary file.
>=20
> A PHY driver should use this macro.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno


