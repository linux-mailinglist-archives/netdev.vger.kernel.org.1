Return-Path: <netdev+bounces-56810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DED2810E54
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A73A281B81
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74D22EE9;
	Wed, 13 Dec 2023 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X0XimqRa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A63AF;
	Wed, 13 Dec 2023 02:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X7jCbNeUpd9+tcMW9C1JI1zA+HwAYMrCV2BBkKOV7nY=; b=X0XimqRaCith9y80wZOMfHjApD
	tjr/m67IQ3vxncQYOfn182JN0TydAg1uCWqFddK1BNcCs5eRyntjXDQb5yzfnZYjEOI323YCkPHPZ
	p8vObUXlQIBLk1WQ0aoF9MjCY4II3riPqgL5iQXXAa00cy+tY43TDeLh61ze0KT2CK8E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDMPL-002o4G-Lp; Wed, 13 Dec 2023 11:24:03 +0100
Date: Wed, 13 Dec 2023 11:24:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <67da9a6a-b0eb-470c-ae43-65cf313051b3@lunn.ch>
References: <ZXeuI3eulyIlrAvL@boqun-archlinux>
 <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
 <ZXfFzKYMxBt7OhrM@boqun-archlinux>
 <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com>
 <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home>

> > The C side people read the Rust code before changing the C code? Let's
> > see. 
> > 
> 
> Hmm... I usually won't call someone "C side people". I mean, the project
> has C part and Rust part, but the community is one.
> 
> In case of myself, I write both C and Rust, if I'm going to change some
> C side function, I may want to see the usage at Rust side, especially
> whether my changes could break the safety, and safety comments may be
> important.

While i agree with your sentiment, ideally we want bilingual
developers, in reality that is not going to happen for a long time. I
could be wrong, but i expect developers to be either C developers, or
Rust developers. They are existing kernel developers who know C, or
Rust developers who are new to the kernel, and may not know much C. So
we should try to keep that in mind.

I personally don't think i have enough Rust knowledge to of even
reached the dangerous stage. But at least the hard part with Rust
seems to be the comments, not the actual code :-(

	Andrew

