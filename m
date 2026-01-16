Return-Path: <netdev+bounces-250527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F82D31A27
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 510B53007C0E
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E83F24886A;
	Fri, 16 Jan 2026 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qHHHHyHK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8285924BD03;
	Fri, 16 Jan 2026 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569316; cv=none; b=neNFcQQOnXndCY56gOsq/Z1u1G8NoVqx2wJY6heIHu2kFHn34ur3Kr62HoQzhZmxx9t9akmXBeKJ5yblTjbg+ah2efJbGr4pbGde7KeOkElM95NaitCqcCw78mf53Uk2OjHmX+W0bNqssybSL6vfO6TzEK6RwqgwPXWZBW3wczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569316; c=relaxed/simple;
	bh=HNM0aFDEj7xgTPDX9mp/xW9cjC4/7xLMggF38qUP7C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL/SDqAPud1Uo5hgtwqKJGfmbz3yiipL1WYDOQc64cJrpsqhFu0WkE/umIP+bessOxP5n6miShQ9sdnQLo+2mvFwI02xoI7rhMDpondwV11G0VkzQT4/Q/qQ8eBIbbP+zj0FKtwAjcnRnFtn8R3jpPoSrl9jzwc9nQE19hkqfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qHHHHyHK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MIi+xqXrSmMxoa7bCC411gtzE/+5szTyDlWOQqesDO8=; b=qHHHHyHKjnuvGrC2sV3uDo4DNK
	jDtx5czDmpEAy2A4eMrTFcSu77z6I8lU0TRmXA3PCSNQPpWxsNtooWtBi35qJZ5RcRUbPPPrYqgRW
	DMU7DwwRZFgbkS0g6kP+27xEe9kvz+hT6Vv//mKuPMJ/BoCm9xhEzcDyKvvMPztghMjA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgjfO-0034it-2w; Fri, 16 Jan 2026 14:15:06 +0100
Date: Fri, 16 Jan 2026 14:15:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v4] net: sfp: add SMBus I2C block support
Message-ID: <0b411424-27a4-4b10-b4ab-b2c42f0a70da@lunn.ch>
References: <20260109101321.2804-1-jelonek.jonas@gmail.com>
 <466efdd2-ffe2-4d2e-b964-decde3d6369b@bootlin.com>
 <397e0cdd-86de-4978-a068-da8237b6e247@gmail.com>
 <0c181c3d-cb68-4ce4-b505-6fc9d10495cd@bootlin.com>
 <d5c11fec-1e75-46cf-aeae-593fb6a4af09@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5c11fec-1e75-46cf-aeae-593fb6a4af09@gmail.com>

> When I come to trying to work on that, should that all be kept in
> mdio-i2c.c? I'm asking because we have a downstream implementation
> moving that SMbus stuff to mdio-smbus.c. This covers quite a lot right
> now, C22/C45 and Rollball, but just with byte access [1].

It really should be that the I2C access mechanism, and the protocol
running on top of these accesses are orthogonal. So i could see the
code split it mdio-i2c.c, mdio-smbus.c, mdio-rollaball.c,
mdio-marvell.c. But only if there is no replicated between these
files. And i'm not sure we have reached the complexity level to make
such a split.

> Because that isn't my work, I'll need to check with the original
> authors and adapt this for an upstream patch, trying to add word +
> block access.

The code should be GPL, so you should be able to just take it and
adapt it. However, i've always had a good experience asking the
authors, they either say yes, or point out issues with the code that
need addressing. BTW: IANAL.

     Andrew

