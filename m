Return-Path: <netdev+bounces-53720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32E804435
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E151C20BC7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBECE1FB0;
	Tue,  5 Dec 2023 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea/eWJtA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE901FA6;
	Tue,  5 Dec 2023 01:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220EFC433C7;
	Tue,  5 Dec 2023 01:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701740635;
	bh=rdHwo/nithK25teoh6suv7EyaOdh87sdCVg3X9cbNxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ea/eWJtA6WP532SkccblCXJofpp4E1SecQMhiaOxma6sSHQWPw8GEdWgC/IOGUsMv
	 VZGEe3UXsSaDfX/FGZ7SdcAs9//WyOKF2p2JoyUM3zVLXGj3efGerZiwLhC7FqxQrV
	 PdyaKZnMZBP00oh77nWgvtmdbza/1IUH/hqScbD5AL8eYXZtyFzWk7wpy1Bn8P6KQ/
	 arj6jasXOOc5JvNIuie+J8AYfLjK/mH7zSl50obZ71oAKQQuQZ5/Mt31wX0r8dOJrw
	 nfnXTyhncMwiCPSGqntJLHMRynJsro7B/hRzzxGjrdUOfU5zEG9NejVhXbtYSXuwDY
	 Mb7tobCD1/LUA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Dec 2023 03:43:50 +0200
Message-Id: <CXG0PHF8SB5K.1LNX7D7LCN0W0@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <netdev@vger.kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <andrew@lunn.ch>, <tmgross@umich.edu>,
 <miguel.ojeda.sandonis@gmail.com>, <benno.lossin@proton.me>,
 <wedsonaf@gmail.com>, <aliceryhl@google.com>, <boqun.feng@gmail.com>
Subject: Re: [PATCH net-next v9 1/4] rust: core abstractions for network PHY
 drivers
X-Mailer: aerc 0.16.0
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-2-fujita.tomonori@gmail.com>
In-Reply-To: <20231205011420.1246000-2-fujita.tomonori@gmail.com>

On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
> This patch adds abstractions to implement network PHY drivers; the
> driver registration and bindings for some of callback functions in
> struct phy_driver and many genphy_ functions.
>
> This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=3Dy.

Just a question: is `_ABSTRACTIONS` a convention or just for this
config flag?

That would read anyway that this rust absraction of phy absraction
layer or similar.

Why not e.g.

- `CONFIG_RUST_PHYLIB_BINDINGS`
- `CONFIG_RUST_PHYLIB_API`
- Or even just `CONFIG_RUST_PHYLIB`?

BR, Jarkko

