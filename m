Return-Path: <netdev+bounces-44626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB47D8D3C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 04:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F0B2821CA
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 02:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77DD64A;
	Fri, 27 Oct 2023 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V3ul2WeT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38719C;
	Fri, 27 Oct 2023 02:47:21 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA232C4;
	Thu, 26 Oct 2023 19:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ePutOWB0IdYzMU/QyiXTZPgLpmM6M9qUvOK+z6Zfa5Y=; b=V3ul2WeTxEPKe7dmSt9m5HmSIB
	e+liYFtT5BOT4M+E73s3ilWMhGB2Ig9V1kERKuxLLO+rYbSVjVCqr1jwMNLtOkBLmq1cMM18jHdPo
	ybmpuTz7/4Jy9/7MG1HzyobyFGpjj5I2fdVGb6YIz9zFPN1yD4tUuOdllDE0a0LQMTlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qwCsX-000Iap-9H; Fri, 27 Oct 2023 04:47:17 +0200
Date: Fri, 27 Oct 2023 04:47:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
 <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>

> I wonder whether that actually helps, if a reviewer takes average four
> days to review a version (wants to give accurate comments and doesn't
> work on this full time), and the developer send a new version every
> three days, there is no possible way for the developer to get the
> reviews.
> 
> (Honestly, if people could reach out to a conclusion for anything in
> three days, the world would be a much more peaceful place ;-))

May i suggest you subscribe to the netdev list and watch it in action.

It should also be noted, patches don't need reviews to be merged. If
there is no feedback within three days, and it passes the CI tests, it
likely will be merged. Real problems can be fixed up later, if need
be.

	Andrew


