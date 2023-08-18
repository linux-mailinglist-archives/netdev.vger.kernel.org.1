Return-Path: <netdev+bounces-28665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B878035B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FE11C21589
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC2E633;
	Fri, 18 Aug 2023 01:30:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536362C;
	Fri, 18 Aug 2023 01:30:30 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447D6A8;
	Thu, 17 Aug 2023 18:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ie9+uKvTby5fgVHsyoluTS9SFHIBizDQXGtK2CyhqKw=; b=0FeLFgs1HUOqJ6GxRgwrnzBcdX
	9gNPFxu0WbNV48leQJk0ZhrKqbYNf/QsONgKQ2cvJKyNQpc2IhX8WqD0AXQ6q09oj7/8VAcraGNu+
	nmkzYZBxXoydxWla9OVBcg1X7VsonhR92fk5wIgsadu95/BcJAO1que20Lo7ZJUgZQ7g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWoJR-004Rrk-P7; Fri, 18 Aug 2023 03:30:05 +0200
Date: Fri, 18 Aug 2023 03:30:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Davide Rovelli <roveld@usi.ch>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Michele Dalle Rive <dallerivemichele@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Davide Rovelli <davide.rovelli@usi.ch>,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
Message-ID: <0ba551eb-480e-4327-b62f-fc105d280821@lunn.ch>
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh>
 <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
 <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
 <CANiq72=3z+FcyYGV0upsezGAkh2J4EmzbJ=5s374gf=10AYnUQ@mail.gmail.com>
 <bddea099-4468-4f96-2e06-2b207b608485@usi.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bddea099-4468-4f96-2e06-2b207b608485@usi.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Correct. I work with Michele, let me clarify. We are a research lab working
> on a low-jitter networking prototype implemented as an internal LKM (our
> last paper: https://www.usenix.org/system/files/atc21-jahnke.pdf). When
> trying to convert it to Rust, we noticed the lack of socket abstractions
> which Michele implemented.

I guess i need to read the paper, or wait for the code to be made
public, but this API on its own does not make much sense to me. Or my
assumptions are all wrong.

So you have an application in user space wanting to use this
protocol. I assume it is using BSD sockets to communicate with the
kernel and the protocol. So you need an API below sockets to get this
traffic, i assume a whole new protocol family? But you have an API on
top of sockets for TCP/UDP. So i guess your protocol somehow
encapsulate the traffic and then uses the API your are proposing to
send over TCP or UDP?

Which makes me think:

Why go through sockets twice for a low jitter networking protocol?

How do you avoid deadlocks when you connect the bottom of sockets back
to the top of socket?

    Andrew

