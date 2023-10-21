Return-Path: <netdev+bounces-43253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFBD7D1DF5
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 17:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF5B1C20963
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7718AF8;
	Sat, 21 Oct 2023 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cmFeUT+c"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FAF154A1;
	Sat, 21 Oct 2023 15:41:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA14114;
	Sat, 21 Oct 2023 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NBm9jJmu0YFgPEm3ScQ+R22nQJjgZGdjqTlRBs47DZk=; b=cmFeUT+cOF+hbGvTiWIB5015UZ
	gyWvAXx2K5kNqCZ6yoCSQ8fiSQTD5FwM8dVsiLSOpdw9z7J7/mF66CTxOpWI5GjR4/I6yuPZCiG8x
	gP2K9qAaJcro/0eg8RZQRig77DDkPdCnJJZYSxvbn2vl1DWjRtg3TmxGcHvC6tYLU+lU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1quE6p-002tlp-Hp; Sat, 21 Oct 2023 17:41:51 +0200
Date: Sat, 21 Oct 2023 17:41:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <460e7d2f-2fd4-475b-9156-88d61c9f7347@lunn.ch>
References: <4e3e0801-b8b2-457b-aee1-086d20365890@proton.me>
 <20231021.192741.2305009064677924338.fujita.tomonori@gmail.com>
 <fa420b54-b381-4534-8568-91286eb7d28b@proton.me>
 <20231021.203622.624978584179221727.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021.203622.624978584179221727.fujita.tomonori@gmail.com>

> Qemu supports a virtual PHY device?

Not really. I wish it did. Some MAC emulators have very minimal PHY
driver emulation, but they don't make use of PHYLIB.

Having a real emulated PHY would be nice, it would make testing things
like Energy Efficient Ethernet much simpler.

     Andrew

