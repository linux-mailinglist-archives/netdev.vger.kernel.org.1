Return-Path: <netdev+bounces-39089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B457BDEFA
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7F71C20A5A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D951A71D;
	Mon,  9 Oct 2023 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EnoUjvw3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA1F1A5A4;
	Mon,  9 Oct 2023 13:25:02 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548ECB9;
	Mon,  9 Oct 2023 06:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Rtpu33a85jklnpGWW4R512/Kxg9ofCgvrA/q+Q+LQ7c=; b=En
	oUjvw3k7t25sfZfxG/SbLqJNx/4sNRdVVYWCqzPLrlI8k7prMJAzrlEX+VhO9Z3bwLVcpwG3VaLUX
	ncC10hbzgelAK4CcQa7KI9CDypq6qTsH47f6GYF+Kt/RtKfUKSFBpDHBdoICZu+5Vy9B/UkiXqFBK
	J4dnLd3UjRa1xU4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qpqFn-000t1x-0H; Mon, 09 Oct 2023 15:24:59 +0200
Date: Mon, 9 Oct 2023 15:24:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, greg@kroah.com, tmgross@umich.edu,
	Andrea Righi <andrea.righi@canonical.com>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
Message-ID: <9a23f2da-8f98-4ca2-8ca7-bb264ea676dd@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch>
 <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 02:53:00PM +0200, Miguel Ojeda wrote:
> On Mon, Oct 9, 2023 at 2:48 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > Any ideas?
> 
> That is `RETHUNK` and `X86_KERNEL_IBT`.
> 
> Since this will keep confusing people, I will make it a `depends on !`
> as discussed in the past. I hope it is OK for e.g. Andrea.

I really do suggest you work on your kconfig. The expectation is any
configuration that kconfig is happy with will build. People like Arnd
Bergmann do lots of randconfig builds. We don't want his work upset by
Rust code.

And as a Rust beginning, i find this pretty unfriendly, in that i
followed https://docs.kernel.org/rust/quick-start.html but did not get
a working build.

    Andrew

