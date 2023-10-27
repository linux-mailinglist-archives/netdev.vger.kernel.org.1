Return-Path: <netdev+bounces-44899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A467DA3A3
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D774282504
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08269944C;
	Fri, 27 Oct 2023 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lwD/UbZu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4175405EB;
	Fri, 27 Oct 2023 22:40:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD0E1;
	Fri, 27 Oct 2023 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GZjWe4udUXJVLcs9FG4/FnnTIzmtU1tHZIIy9AGH4uA=; b=lwD/UbZunIFPJ1wlEnkOpojnAg
	qxwYzxDwtoQlkS5mjBfoCPV2owQFdt8fqIzoxwhTrpt9yh6gooj7yfoy9QLjMLv4M/EVs7NTl6fZr
	Bpt1wq/ItOV5jT74v7z2N3bv3D2/qij6zmeDDWTJArH+XJIGgcB1Lbw9N+PRyKW/w7lo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwVV4-000NWf-7W; Sat, 28 Oct 2023 00:40:18 +0200
Date: Sat, 28 Oct 2023 00:40:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ae1987a4-b878-498a-a06e-2db16d9f2056@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <ZTwWse0COE3w6_US@boqun-archlinux>
 <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>

> I did not notice this before, but this means we cannot use the `link`
> function from bindgen, since that takes `&self`. We would need a
> function that takes `*const Self` instead.

After the discussion about mutability, i took a look at the C code,
and started adding const to functions which take phydev, but don't
modify it. Does bindgen look for such const attributes? Does it make a
difference to be binding?

	Andrew

