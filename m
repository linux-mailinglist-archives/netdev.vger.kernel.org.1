Return-Path: <netdev+bounces-49265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D727F1569
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBEC28244B
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC27E1C284;
	Mon, 20 Nov 2023 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="viEl7Sol"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A124310C0;
	Mon, 20 Nov 2023 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1KXRgmYRxW5+3L4vy5arJONvjrQOwYRqCY6SPBeESlw=; b=viEl7Solsdw91e7g/lISbLukAw
	IOvV67oUjCdTeEVGxLOkUj7YUGJz0VsIeGhKXxwlhqGu9NqsfVj59c853IfNHFmJCUjmSYNxwLRF4
	LIHqlhTspYxtueXXHQ7QwQiHRWSMegPW/910vCmJnKX1sVeKwjJ0XyFHVqshAvhk7uzc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r551f-000eP1-M3; Mon, 20 Nov 2023 15:13:23 +0100
Date: Mon, 20 Nov 2023 15:13:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, boqun.feng@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver
 macro
Message-ID: <bfee014a-617c-49de-9344-b7d511cdf58f@lunn.ch>
References: <7f300ba1-44e1-4a98-9289-a53928204aa7@proton.me>
 <20231119.182544.2069714044528296795.fujita.tomonori@gmail.com>
 <8f7a7fe0-bfd3-4062-9b55-c1e18de2818a@lunn.ch>
 <20231120.225453.845045342929370231.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120.225453.845045342929370231.fujita.tomonori@gmail.com>

> The Rust ax88796b driver doesn't export anything. The Rust and C
> drivers handle the device_table in the same way when they are built as
> a module.
> 
> $ grep __mod_mdio /proc/kallsyms
> ffffffffa0358058 r __mod_mdio__phydev_device_table [ax88796b_rust]
> 
> $ grep __mod_mdio /proc/kallsyms
> ffffffffa0288010 d __mod_mdio__asix_tbl_device_table	[ax88796b]

I checked what r and d mean. If they are upper case, they are
exported. Lower case means they are not exported.

My laptop is using the realtek PHY driver:

0000000000000000 r __mod_mdio__realtek_tbl_device_table	[realtek]

Also lower r.

Looking at all the symbols for the realtek driver, all the symbols use
lower case. Nothing is exported.

Is that what you see for the ax88796b_rust?

	Andrew

