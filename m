Return-Path: <netdev+bounces-45231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B07DB9F2
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 13:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B546B281381
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D145CDDD5;
	Mon, 30 Oct 2023 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BLgA0Pjf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3A15E99;
	Mon, 30 Oct 2023 12:32:44 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26527A2;
	Mon, 30 Oct 2023 05:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Z8vMI5lJvsMYU7/u4vk4T0540ofnPUEprRSZx6Jg1bw=; b=BL
	gA0PjfEWw7h3X8pjkiAMLQc7F5wXWHHYKbjwz8ioJH5/mwFYMuQ7irf75/z61mmsOf7fbACfZ1Xhw
	11hfjYHXuxEV+ovMmNb44nfIH3Dy9X0A/W6JV19BMhOGj0gZFQSq0r71h0Wjo9aPwGS9ZIGMKiNsB
	EAET4MSyI1zWzB8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qxRRd-000Vgq-Eo; Mon, 30 Oct 2023 13:32:37 +0100
Date: Mon, 30 Oct 2023 13:32:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, benno.lossin@proton.me,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <213b04fe-26a9-4efe-a9bf-405fd85c89a1@lunn.ch>
References: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
 <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
 <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
 <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
 <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home>
 <ZT6fzfV9GUQOZnlx@boqun-archlinux>
 <c8d6d56f-bd8f-4d2c-a95a-4ed11bf952b8@lunn.ch>
 <CANiq72=_6HsRbMGgWcyKqX-W=xpmw0njGoVRvRRe-c23o7sJyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=_6HsRbMGgWcyKqX-W=xpmw0njGoVRvRRe-c23o7sJyA@mail.gmail.com>

On Mon, Oct 30, 2023 at 01:07:07PM +0100, Miguel Ojeda wrote:
> On Sun, Oct 29, 2023 at 8:39 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > We have probably missed the merge window for v6.7. So there is around
> 
> Definitely missed. We aim to send our PRs in advance of the merge
> window, e.g. this cycle it has already been sent.

Netdev works a bit different. Patches can be merged into net-next even
a couple of days into the merge window. A lot depends on the riskiness
of a patch. A new driver has very low risk, since it is generally self
contained. Even if its broken, there is another 8 weeks to fix it up.

However, for this cycle, the PR for netdev has already been sent,
because a lot of the Maintainers are travelling to the netdev
conference.

	Andrew

