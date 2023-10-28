Return-Path: <netdev+bounces-45015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C287DA87B
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 20:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5329B281E78
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 18:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DCD17754;
	Sat, 28 Oct 2023 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sq5V4RLC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EBF3C22;
	Sat, 28 Oct 2023 18:18:47 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720DBF;
	Sat, 28 Oct 2023 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JwxW4sKNB0igYH4hPg8CjMjH2S2gXylQEy4Lji5WqeM=; b=sq5V4RLC9q14UblN6ipiCgDxaQ
	rL49A6fU+TyAJFlGP0X4g8GfRksq76x4EzmzMmCJagts1OYSH4ne3ZBLKlKwZ+gE7u9MDRjBIcuHS
	LhqJgiD/vpqxl82RwPQDynhYc0/pTC0TCZtyGEEtqC3iH8rzkV7MdRrnBYKqv5mAQSpE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwntR-000PoL-Vu; Sat, 28 Oct 2023 20:18:41 +0200
Date: Sat, 28 Oct 2023 20:18:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>,
	Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <26fad7ef-0564-4250-ab8b-e8263c3d7dbf@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <ZTwWse0COE3w6_US@boqun-archlinux>
 <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <ae1987a4-b878-498a-a06e-2db16d9f2056@lunn.ch>
 <CANiq72mOt3yvr_07Gbjnz80ExODYoNvXbqERmCOpZYFmGmAVRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mOt3yvr_07Gbjnz80ExODYoNvXbqERmCOpZYFmGmAVRw@mail.gmail.com>

> But yes, it makes a difference in the output it generates (if we are
> talking about the pointed-to), e.g.
> 
>     void f(struct S *);       // *mut S
>     void f(const struct S *); // *const S
> 
> Being const-correct would be a good change for C in any case.

I have a patchset which changes a few functions to use const struct
*phydev. I will post them next cycle. They are a bit invasive, so i
don't want to do it now, this close to the merge window.

      Andrew

