Return-Path: <netdev+bounces-227415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E172FBAEDDA
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 02:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09AD3A6F53
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DDD17A306;
	Wed,  1 Oct 2025 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTXWjDD5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745E22CCC5;
	Wed,  1 Oct 2025 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278024; cv=none; b=J5XEJJyDqIuVtyQt4Hx1+R5jDJqf60eX+7pn8kDHiVn1ZDretpsPEj3lmw5Gg2dFVyl+d/ri95hu0uJcsEV8XEjssmlfENlIYX4d2fprBOCfuYxJb3Jfp4+NRKjmo+tCU7KPobj9fi49YOEH5cYE+CycDMNChTq6wRlcuhMkauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278024; c=relaxed/simple;
	bh=m26ff45+YZIuIweKTgqVfUP8TSAnLz2buJEY7gdOkpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p11uZCc0fjkdB42N5IM9EoJzj+lUey905sjg0VGB3ZOiEr+erB8kCThD7qVkf9Uh6glFpb1ba8FZ6xgKo/6xp+zXAocoXdZ8qfwC+nOG8PEPSPVW2h1vt1WIxjzVlIzkt94YnXPh1nnubX1lIHpSSuYoPnBuN4P+iC0bQyijVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTXWjDD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A99EC113D0;
	Wed,  1 Oct 2025 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759278024;
	bh=m26ff45+YZIuIweKTgqVfUP8TSAnLz2buJEY7gdOkpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uTXWjDD51MSeKOJohAhYHujiMKU3dMzHwPFwjMZCmZDPDtaKT/YGz0LPNp2Kc1FCJ
	 qlCeE8zlY9NPC5tLrrFH6RJ+0BGIMqF84MJW45OLrxv50itI4hawITmuMdNbTXqDmX
	 GBQH0tWqmJxTI8QCZ6bzVNJUQCXpz9qcgcN5zeLF8a1fdyzuGrnhQWxfnqoXXjHmQq
	 dhCCuQklmO3GXCAUniqSLjGvKrCQDsM8s2tEiZ7rxl92QIA/jvJmdICrMWihvcDgwR
	 Ln2m/wcXYJw6+YtM8Z+1e/ADU8dvhJiE9PjMazyW6R91j1az7ROl1xGilxZce/bWpa
	 IxSQvIQGPXeoA==
Date: Tue, 30 Sep 2025 17:20:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Chen-Yu Tsai <wens@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH net-next v8 2/2] net: stmmac: Add support for Allwinner
 A523 GMAC200
Message-ID: <20250930172022.3a6dd03e@kernel.org>
In-Reply-To: <20250929180804.3bd18dd9@kernel.org>
References: <20250925191600.3306595-1-wens@kernel.org>
	<20250925191600.3306595-3-wens@kernel.org>
	<20250929180804.3bd18dd9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 18:08:04 -0700 Jakub Kicinski wrote:
> On Fri, 26 Sep 2025 03:15:59 +0800 Chen-Yu Tsai wrote:
> > The Allwinner A523 SoC family has a second Ethernet controller, called
> > the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> > numbering. This controller, according to BSP sources, is fully
> > compatible with a slightly newer version of the Synopsys DWMAC core.
> > The glue layer around the controller is the same as found around older
> > DWMAC cores on Allwinner SoCs. The only slight difference is that since
> > this is the second controller on the SoC, the register for the clock
> > delay controls is at a different offset. Last, the integration includes
> > a dedicated clock gate for the memory bus and the whole thing is put in
> > a separately controllable power domain.  
> 
> Hi Andrew, does this look good ?
> 
> thread: https://lore.kernel.org/20250925191600.3306595-3-wens@kernel.org

Adding Heiner and Russell, in case Andrew is AFK.

We need an ack from PHY maintainers, the patch seems to be setting
delays regardless of the exact RMII mode. I don't know these things..

