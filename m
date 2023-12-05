Return-Path: <netdev+bounces-53725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA14C804459
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833E428133D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7321C15;
	Tue,  5 Dec 2023 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bABY5rAJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164BA1870;
	Tue,  5 Dec 2023 01:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691CFC433C9;
	Tue,  5 Dec 2023 01:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701741292;
	bh=nL8p60Kfd/zHwtuFBXIg+neqGev8z9/K6Czpoo0++AE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bABY5rAJSn7frAEvCbiOlBN+YS31OXneBwLbShTiwNZ4O7en/BIXQwSWHh/6M8ir4
	 UbL5jgMytcjfhHidC/FAOv1ZXEU6EbIZHelQSzQUCCEcTbppQ5YNZ/vrOe7U7kKnpo
	 9yvWFWb2r7Mra500aEJq0Gl5iS+JgkZ64E4xA4PgUjjz0GhTZdVA1sx2/0xAkxfwuf
	 yZbzdD4nPfiWHUV1+uJ4K50qoTQGTgxFKZkMYKs+owjJNHc3JjJDWerA402UBs0oK6
	 aiDHsVDPqZmXlDVFEED1I6TCIONcbUxIQi69kqkVzMkfJBZNhzfV+ToJYCm+UyTLUE
	 hvFE3l6oR+z3Q==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Dec 2023 03:54:48 +0200
Message-Id: <CXG0XVG6V0TS.1MXLVYIPU58QC@kernel.org>
Subject: Re: [PATCH net-next v9 4/4] net: phy: add Rust Asix PHY driver
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <netdev@vger.kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <andrew@lunn.ch>, <tmgross@umich.edu>,
 <miguel.ojeda.sandonis@gmail.com>, <benno.lossin@proton.me>,
 <wedsonaf@gmail.com>, <aliceryhl@google.com>, <boqun.feng@gmail.com>
X-Mailer: aerc 0.16.0
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-5-fujita.tomonori@gmail.com>
In-Reply-To: <20231205011420.1246000-5-fujita.tomonori@gmail.com>

On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
> This is the Rust implementation of drivers/net/phy/ax88796b.c. The
> features are equivalent. You can choose C or Rust version kernel
> configuration.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Hardware-agnostic feature must have something that spins in qemu, at least
for a wide-coverage feature like phy it would be imho grazy to merge these
without a phy driver that anyone can test out.

BR, Jarkko

