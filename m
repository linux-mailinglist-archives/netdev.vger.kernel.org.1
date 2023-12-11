Return-Path: <netdev+bounces-55908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E9B80CC7A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7CEB21350
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1F2482D6;
	Mon, 11 Dec 2023 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0T7OMB/A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C5F3;
	Mon, 11 Dec 2023 06:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3lSnL8uvBeA4AV6Ywgmq37nYOceo3gVzdnHuyj44eCg=; b=0T7OMB/AVoyPdiycJCqbDQqlGB
	txr3s5nkFNyIeVzRUSTVCh07N2RyrD0B+6ayRw4cVXShUHIMsGdoF/4b9uVaS9/U6yNrN44FoN+5T
	DTwowUB7MxS7U5W0C6A6P2HuIlNsNqTZPE8cYOuM96t0bHMrSDE4UByrcehSm8wFPdoY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCgqp-002cmG-To; Mon, 11 Dec 2023 15:01:39 +0100
Date: Mon, 11 Dec 2023 15:01:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com,
	boqun.feng@gmail.com
Subject: Re: [PATCH net-next v10 4/4] net: phy: add Rust Asix PHY driver
Message-ID: <d7e3b4e9-fad2-4033-b79d-de812f88ff7d@lunn.ch>
References: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
 <20231210234924.1453917-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210234924.1453917-5-fujita.tomonori@gmail.com>

On Mon, Dec 11, 2023 at 08:49:24AM +0900, FUJITA Tomonori wrote:
> This is the Rust implementation of drivers/net/phy/ax88796b.c. The
> features are equivalent. You can choose C or Rust version kernel
> configuration.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

