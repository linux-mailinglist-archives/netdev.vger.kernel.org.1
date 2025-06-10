Return-Path: <netdev+bounces-196077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351C6AD3720
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC27517A4F8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D9299AA1;
	Tue, 10 Jun 2025 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MDb4lpEQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345821018F;
	Tue, 10 Jun 2025 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559100; cv=none; b=BPTOR6xRw8L8uHiNNvPIHtzKeqLQNPWOM7KpPO6/yzz5vT1gWKz6iJI1geBXkfG0Pna6OIAy5iKSyoFgnUb3CGOygBFFBKQDeEQXOUoquuuy3VZy/7GOhhhQBbuSNldZA2abzC83v8nn3EiAdI+QqCG0zWyrf+J2vLP4wt1bOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559100; c=relaxed/simple;
	bh=EBCsI4iB29l0k5Z7TwnRIqFF2iIS4G21xB697Bz3640=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVYzxMwcxCzA0G6/Bu7OfDfQUnsuTIUTvN+KB3ZfzDrcJJlyqo24QCa85082R0o3FKyCdeN9mDWE0Gsp9swGFJvjE22TN/lkD6zilxDqbzRWD3uJdped+n401Mn6bD8cLQnrK7X3aErfqiJ8ruA/oPA+eZt4daK1EfOjnkBClQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MDb4lpEQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=YFH9RhTZ6S+SUmxUwxl/TyWv3H+/qbxWHT4CHobAxOQ=; b=MD
	b4lpEQKBotu41Rsuk/5kHZwTg8VmKbO5eJ2r1bPCnKrN/YYImR4yAi36naX1YEEK322y0th+/1DAL
	IUvKxlnF+gAHB03a2LErz0RI4JrRK8/e2P08Egw0+z9ztI/GwSS6SLgQVYXGAWRhGYNIw837cVl8+
	S3gsL52o1qXXI90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOyF0-00FGL6-Uj; Tue, 10 Jun 2025 14:38:10 +0200
Date: Tue, 10 Jun 2025 14:38:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/3] net: phy: micrel: add cable test support
 for KSZ9477-class PHYs
Message-ID: <2da14336-66ae-4079-994c-a17597f13255@lunn.ch>
References: <20250610091354.4060454-1-o.rempel@pengutronix.de>
 <20250610091354.4060454-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250610091354.4060454-4-o.rempel@pengutronix.de>

On Tue, Jun 10, 2025 at 11:13:54AM +0200, Oleksij Rempel wrote:
> Enable cable test support for KSZ9477-class PHYs by reusing the
> existing KSZ9131 implementation.
> 
> This also adds support for 100Mbit-only PHYs like KSZ8563, which are
> identified as KSZ9477. For these PHYs, only two wire pairs (A and B)
> are active, so the cable test logic limits the pair_mask accordingly.
> 
> Support for KSZ8563 is untested but added based on its register
> compatibility and PHY ID match.
> 
> Tested on KSZ9893 (Gigabit): open and short conditions were correctly
> detected on all four pairs. Fault length reporting is functional and
> varies by pair. For example:
> - 2m cable: open faults reported ~1.2m (pairs B–D), 0.0m (pair A)
> - No cable: all pairs report 0.0m fault length
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

