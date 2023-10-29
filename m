Return-Path: <netdev+bounces-45098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF17DADF5
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 20:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D09B20C9E
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 19:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F210A03;
	Sun, 29 Oct 2023 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RREIpnKL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E83D2E3;
	Sun, 29 Oct 2023 19:39:50 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A5E9B;
	Sun, 29 Oct 2023 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oRVVqSOTof9H8bPDmz4Hcyr5UUkAKhHeyVygab/6wAE=; b=RREIpnKLmD1tyIaRcYuMOl5Yzr
	FhMtQ1FrPfmcVYr0nxUybxcDp/ZoFwLiRXOIzH4Qx+NqZTy+9JgymrqxZhez42DBlEkFYdugBWTuM
	jnUS+Rm74ABOeGRFwXAkKj5+DQgS2Cj68JTtHFnyBkH/kLiHNNHmXAQ0+48sD/3ZPGAY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qxBdQ-000SaV-98; Sun, 29 Oct 2023 20:39:44 +0100
Date: Sun, 29 Oct 2023 20:39:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, benno.lossin@proton.me,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <c8d6d56f-bd8f-4d2c-a95a-4ed11bf952b8@lunn.ch>
References: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
 <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
 <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
 <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
 <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home>
 <ZT6fzfV9GUQOZnlx@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT6fzfV9GUQOZnlx@boqun-archlinux>

> Of course, it's not maintainable in longer term since it relies on
> hard-coding the bit offset of these bit fields. But I think it's best we
> can do from Linux kernel side. It's up to Andrew and Miguel whether this
> temporary solution is OK.

What is the likely time scale for getting a new version of bindgen
with the necessary bit field support?

We have probably missed the merge window for v6.7. So there is around
9 weeks to the next merge window. If a working bindgen is likely to be
available by then, we should not bother with a workaround, just wait.

If you think bindgen is going to take longer than that, then we should
consider workarounds. But we have no rush, its still 9 weeks before we
need working code.

Zooming out a bit. Is there any other in mainline Rust code, or about
to be submitted for this merge window code, using bit fields? I assume
that is equally broken?

	Andrew

