Return-Path: <netdev+bounces-53734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E337B80449D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6371C209C5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDC46AF;
	Tue,  5 Dec 2023 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lCYmsG+5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F5CCE;
	Mon,  4 Dec 2023 18:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=avQIdgb7Wcdafp4yfZ6kuA2OSaG3FJ0wg50oUbHTKe8=; b=lCYmsG+5kyPZQGs6XIazPXY+yC
	YE+ZIWrqzxR+QGyw+VdJanshYmU70Qi6itf6Gq8ON9pFJjYVeTFynPvbRK4MXYlNecFHLxh4xISE7
	ruZohY/uZIDCpMe3l25WZyp2v47EFPlryLR7Sap/QC6QPOyHVfrAawp5hlApLeArcRHI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAL6Z-0022aP-Bu; Tue, 05 Dec 2023 03:24:11 +0100
Date: Tue, 5 Dec 2023 03:24:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
	wedsonaf@gmail.com, aliceryhl@google.com, boqun.feng@gmail.com
Subject: Re: [PATCH net-next v9 4/4] net: phy: add Rust Asix PHY driver
Message-ID: <7968e369-0769-428b-8fc9-dcb2af1f08b6@lunn.ch>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-5-fujita.tomonori@gmail.com>
 <CXG0XVG6V0TS.1MXLVYIPU58QC@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CXG0XVG6V0TS.1MXLVYIPU58QC@kernel.org>

On Tue, Dec 05, 2023 at 03:54:48AM +0200, Jarkko Sakkinen wrote:
> On Tue Dec 5, 2023 at 3:14 AM EET, FUJITA Tomonori wrote:
> > This is the Rust implementation of drivers/net/phy/ax88796b.c. The
> > features are equivalent. You can choose C or Rust version kernel
> > configuration.
> >
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 
> Hardware-agnostic feature must have something that spins in qemu, at least
> for a wide-coverage feature like phy it would be imho grazy to merge these
> without a phy driver that anyone can test out.

There are no hardware agnostic features here. PHY drivers are pretty
much thin layers which talk to the hardware. Take a look at the C
drivers, what hardware agnostic features do you see in them?

People can easily test this driver, its an easily available USB
dongle, which will work on any USB port, with any SoC architectures.

    Andrew

