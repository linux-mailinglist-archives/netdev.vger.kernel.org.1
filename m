Return-Path: <netdev+bounces-56811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0B810E6F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8808F1F211A9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081A224F1;
	Wed, 13 Dec 2023 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kKTOYLmV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA197A7;
	Wed, 13 Dec 2023 02:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bsY98aRJwy191LJdmG9yFXAc3BWcDwEIGCAfWwpThng=; b=kKTOYLmVkTSHKplbjBluuIA73X
	sAuj4ysxhnzd9fLEbRp9VgYSTBxRhcdbr0cn+18DiqJsbgdLZeg3YmZPVI9UouFOf6nZTyakBtXqF
	/kU2Pg8A0MO9qp94DiiGzHNpO39Apu7OvzHknrSoalbplRMuYtKbmGGfffglceL9e6es=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDMTX-002o5e-Ve; Wed, 13 Dec 2023 11:28:23 +0100
Date: Wed, 13 Dec 2023 11:28:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com,
	alice@ryhl.io, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com,
	aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <79abc99b-a0f2-48c6-ba68-b72dcf5f7254@lunn.ch>
References: <ZXfFzKYMxBt7OhrM@boqun-archlinux>
 <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
 <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
 <20231212.220216.1253919664184581703.fujita.tomonori@gmail.com>
 <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me>

> I still think you need to justify why `mdio.bus` is a pointer that you
> can give to `midobus_read`.

Maybe a dumb question. Why are you limiting this to just a few members
of struct phy_device? It has ~50 members, any of which can be used by
the C side when Rust calls into C.

    Andrew

