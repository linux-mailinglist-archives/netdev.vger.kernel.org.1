Return-Path: <netdev+bounces-190773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F0AB8AAE
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650093AB576
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2CE2135DE;
	Thu, 15 May 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ReiLIYZR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987611F3B9E;
	Thu, 15 May 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322640; cv=none; b=CS97Y+Yho6qU3+D6LzRhWOrG6egJNdMGFvOpJW/uB4decQdBn7KfooIwVGR58JrD8RxsSZJbof/Num9xsmi8tbybC8U/F5xkiuzhpPBNtnKp9uVq7tMemyCOuHs2Ybb05+VIAorbvDfG+IcZj5i/Y9GgB4D7EP2jc86pB/t7rlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322640; c=relaxed/simple;
	bh=v2HfQZ3VhF03fUGk2y+I4Sa+laWkNSv1FTtKhS+DyGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNCjAOBzr4swR5B1U48ea6ewrxBiq5lUK41zZTP9SLzXK7XefYC63gyLSYI8adubNRhphAGshmuZSAPbmpGZgfeNvABFwlpw7yhkP47wvojxM6deSPWUf8L6n6HU9+BOrFj0d+iv7gWNJ/kINkidJdLgTlrQSwl/p5QAXP7rAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ReiLIYZR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X8GHgMcSkYhFzbpbGkQox21VK4XEjLp0YiSHjxgJDZk=; b=ReiLIYZRlAR3PEb4tkAwFIuQ0i
	pVIsu8sFGjOp6jdY3NWz44JUw2akR/TXeHC5qjgC59ff68VAI6LBKQtiDYWnMjles2QBHOiyq8hZT
	e11K213yn6Wk7/0ZXGFVevQqov/YaycnKZFyIjhn9bqIv3DPJOo0SeyGbpR5iRq/IKZw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFaR3-00Cg8q-7W; Thu, 15 May 2025 17:23:49 +0200
Date: Thu, 15 May 2025 17:23:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: microchip: document where the
 LAN88xx PHYs are used
Message-ID: <40b8d7b7-08b6-469f-99a9-68ccd44d8cde@lunn.ch>
References: <20250515082051.2644450-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515082051.2644450-1-o.rempel@pengutronix.de>

On Thu, May 15, 2025 at 10:20:51AM +0200, Oleksij Rempel wrote:
> The driver uses the name LAN88xx for PHYs with phy_id = 0x0007c132. But
> with this placeholder name no documentation can be found on the net.
> 
> Document the fact that these PHYs are build into the LAN7800 and LAN7850
> USB/Ethernet controllers.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

