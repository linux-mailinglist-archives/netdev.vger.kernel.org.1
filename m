Return-Path: <netdev+bounces-45005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E717DA7A6
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19E51C20958
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693D15AF5;
	Sat, 28 Oct 2023 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M7VMSn7M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2A8F79;
	Sat, 28 Oct 2023 15:00:59 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82B5CC;
	Sat, 28 Oct 2023 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=P0WIR46xGD0VkmUZan9VV5KmHH/pDARsFc/IdndysxI=; b=M7
	VMSn7MpWwpIctjG5mdCOqdukwUEG7FzpLGWcjnpw8ZVpiutU89WjR8MCbg6lm6rpbtaAE+Mnpslmg
	+tBqnWOUJl1JitMm2ZJwQFp6A/1x1hDY12EFJ10QZGoeEXV0jX7P2W2cxw6Tn04l0FrSSmbeC6kXf
	wwyMjGLSf2mpWK8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwko3-000PKI-LJ; Sat, 28 Oct 2023 17:00:55 +0200
Date: Sat, 28 Oct 2023 17:00:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <ada8d010-52ac-46c1-b839-8d3b3ed59ae1@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
 <CANiq72mDVQg9dbtbAYLSoxQo4ZTgyKk=e-DCe8itvwgc0=HOZw@mail.gmail.com>
 <20231027072621.03df3ec0@kernel.org>
 <CANiq72n=ySX08MMMM6NGL9T5nkaXJXnV2ZsoiXjkwDtfDG11Rw@mail.gmail.com>
 <ca9fc28e-f68a-4b80-b21f-08a3edf3903a@lunn.ch>
 <CANiq72k4MFe2qL5XrweObo-bxT9qPA6+GAF4bSwLzyQJRX-mJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k4MFe2qL5XrweObo-bxT9qPA6+GAF4bSwLzyQJRX-mJw@mail.gmail.com>

On Sat, Oct 28, 2023 at 01:07:43PM +0200, Miguel Ojeda wrote:
> On Sat, Oct 28, 2023 at 12:55 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > You will probably find different levels of acceptance of 80 to 100 in
> > different subsystems. So i'm not sure you will be able to achieve
> > consistence.
> 
> I would definitely agree if this were C. I happen to maintain
> `.clang-format`, and it was an interesting process to approximate a
> "common enough" style as the base one.
> 
> But for Rust, it is easy, because all the code is new. All Rust files
> are formatted the same way, across the entire kernel.

I would say this is not a technical issue, but a social one. In order
to keep the netdev people happy, you are going to limit it to 80. But
i would not be too surprised if another subsystem says the code would
be more readable with 100, like the C code in our subsystem. We want
Rust to be 100 as well.

Linux can be very fragmented like this across subsystems. Its just the
way it is, and you might just have to fit in. I don't know, we will
see.

	Andrew

