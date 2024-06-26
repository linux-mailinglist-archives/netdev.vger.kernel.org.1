Return-Path: <netdev+bounces-106824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB272917D1D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1211C23349
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F0B16CD3D;
	Wed, 26 Jun 2024 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TSWd9oPS"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89623BF;
	Wed, 26 Jun 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396113; cv=none; b=FnEMNBYC7swvc/Jlxdc3y1eSzMAwKWjihbm0Q0qh77gyJjxApkaO7U97ikT/xOYEeb8nBQGO76vhFgdC52hrmmrz7HVp+3cOTmjbw1ucWIK5/6Fb/N0L/dmD1pbDLMUGNQ+S6EOB9NLRsYO2+fXdumCJLb8kDiqoiWBjewUDoZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396113; c=relaxed/simple;
	bh=ZKYXmi9Zw7EkElH3xVsFfxtx1L1QW7kUwQppZKjbDbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXbpV+dTlUQoisMTsibdkT3qZpqAoHgrYNCfbMO1tH0nkaUt9I63iDdqkesO7NzkezVytAAeAh5cmlLZ00vyYM42XzRN/FJk0cqRhjNlf4DfFOh12o7rr6BJQMwlsqlEkFfQl6M/5+++dLvi20CYLiHrgXcY1mMU3/WwKkT5uo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TSWd9oPS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 821AC1BF20F;
	Wed, 26 Jun 2024 10:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719396103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn3nBMGKGJrDwWGU8hyI8eTzDONmgOWvu3/mio4YDVg=;
	b=TSWd9oPSd5UiaKgEuf2Ms0FVuWUN02Z4wOBC8q9IVC5vKUNYyGhtkhLYAlCdhI70QWcHr1
	2bgDS37b5hu5OiDLqoACB4e4W6cZrrail97ASJcDZBGyF6cKtNmwP30ZH77noa8InkAdfE
	pAaE+a2MYlSNImT6o82/USSYaCL6oPLesw9t4aupuvDaJCB/iPcCwzSFYF4A4D4uOm45zA
	8NgzLU6ZeGj6CnKa5Ip+vHplUUpfJPZszPfKA4kcbAjiQzdXucn5Dw0F2zqak0J3FRWeD/
	7N+IStvXbKBxzWyAFnxq/VZoZQhLwy2Yougff0BaPv0L2tTE6SdPqPyLc80qoA==
Date: Wed, 26 Jun 2024 12:01:37 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>, Antoine Tenart
 <atenart@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next v13 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240626120137.10c2ad61@fedora-5.home>
In-Reply-To: <20240626-worm-of-remarkable-leadership-24f339-mkl@pengutronix.de>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
	<20240626-worm-of-remarkable-leadership-24f339-mkl@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Marc,

Thanks for giving this a test.

On Wed, 26 Jun 2024 11:47:52 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> > # ethtool --show-phys *  
> 
> This creates the following warning for me:
> 
> [   51.877429] ------------[ cut here ]------------
> [   51.882094] WARNING: CPU: 0 PID: 333 at lib/refcount.c:31 ref_tracker_free+0x1ac/0x254
> [   51.890222] refcount_t: decrement hit 0; leaking memory.
> [   51.895611] Modules linked in: mcp251xfd flexcan imx_sdma can_dev spi_imx
> [   51.902493] CPU: 0 PID: 333 Comm: ethtool Not tainted 6.10.0-rc4+ #327
> [   51.909056] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   51.915603] Call trace: 
> [   51.915623] [<c0d2cbd0>] (unwind_backtrace) from [<c0109bcc>] (show_stack+0x10/0x14)
> [   51.925979] [<c0109bcc>] (show_stack) from [<c0d4744c>] (dump_stack_lvl+0x50/0x64)
> [   51.933605] [<c0d4744c>] (dump_stack_lvl) from [<c0d2d2ec>] (__warn+0x88/0xc0)
> [   51.940877] [<c0d2d2ec>] (__warn) from [<c0120ba0>] (warn_slowpath_fmt+0x1b4/0x1c4)
> [   51.948590] [<c0120ba0>] (warn_slowpath_fmt) from [<c0697f74>] (ref_tracker_free+0x1ac/0x254)
> [   51.957176] [<c0697f74>] (ref_tracker_free) from [<c0ae4b7c>] (ethnl_phy_done+0x24/0x54)
> [   51.965318] [<c0ae4b7c>] (ethnl_phy_done) from [<c0acda68>] (genl_done+0x3c/0x88)
> [   51.972845] [<c0acda68>] (genl_done) from [<c0ac9b6c>] (netlink_dump+0x2d8/0x3d0)
> [   51.980387] [<c0ac9b6c>] (netlink_dump) from [<c0aca2fc>] (__netlink_dump_start+0x1f4/0x2c4)
> [   51.988889] [<c0aca2fc>] (__netlink_dump_start) from [<c0acd7bc>] (genl_family_rcv_msg+0x140/0x328)
> [   51.997989] [<c0acd7bc>] (genl_family_rcv_msg) from [<c0acd9e8>] (genl_rcv_msg+0x44/0x88)
> [   52.006204] [<c0acd9e8>] (genl_rcv_msg) from [<c0acc554>] (netlink_rcv_skb+0xb8/0x118)
> [   52.014157] [<c0acc554>] (netlink_rcv_skb) from [<c0acd038>] (genl_rcv+0x20/0x34)
> [   52.021673] [<c0acd038>] (genl_rcv) from [<c0acbd24>] (netlink_unicast+0x23c/0x3d0)
> [   52.029367] [<c0acbd24>] (netlink_unicast) from [<c0acc044>] (netlink_sendmsg+0x18c/0x3d4)
> [   52.037667] [<c0acc044>] (netlink_sendmsg) from [<c0a4b30c>] (__sys_sendto+0xd4/0x128)
> [   52.045626] [<c0a4b30c>] (__sys_sendto) from [<c0100080>] (ret_fast_syscall+0x0/0x54)
> [   52.053496] Exception stack(0xc3967fa8 to 0xc3967ff0)
> [   52.058576] 7fa0:                   b6f1130c 0000000c 00000003 015dd238 00000018 00000000
> [   52.066780] 7fc0: b6f1130c 0000000c b6fb6700 00000122 00571000 00000001 0052a2f8 015dd190
> [   52.074978] 7fe0: 00000122 bec7cf38 b6ea847d b6e1fe86
> [   52.080184] ---[ end trace 0000000000000000 ]---

Hmm I've never seen this one before, but I could be missing some debug
options. Looks like my ethnl_parse_header_dev_put() doesn't belong in
the ethnl_phy_done() callback. I'll see if I can reproduce this error
on some setups, and address that in the next iteration.

> While a "ethtool --show-phys lan0" works w/o problems.

Thanks a lot for the test,

Maxime

