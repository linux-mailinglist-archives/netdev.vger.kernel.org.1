Return-Path: <netdev+bounces-196065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E3EAD3639
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A979189908F
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F129346E;
	Tue, 10 Jun 2025 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eUHZl1AM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B9C292932;
	Tue, 10 Jun 2025 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558715; cv=none; b=bEPvhkcapYgOXXYpXiR1EwK/tRNuVI7BuEcAHWT6Gnj3xTpUP55tCHMKi9qE1zbCD2TLaarOD5esUlqZiMB3chbAtidK2th9WYAfcuAtEDmjmn2e6E6QQWuJpWTBbDEymOxL7Y7EfXmA9ySVFqPl47AkOvGP3Mj1QWzMFXnDEwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558715; c=relaxed/simple;
	bh=koeY9uoLs/ZvMsMdfIMuh6LpTZSKhSwh4VL/afru0XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkCQSOJ4hOf2E5mbLAfq9FcZqTG+zMdOqsYlQOrdDHjQ3AUlKVNpAP/mBHWjggBEh6d6TyyDFT0F4nQk5aIMKGrjTBXORl8oiyw7aNOjtP3Vv+QFyLQN40cSECkA7rtE6YZe9qkehkHpUErQdSwySpcXB8mLLr7flk3vQI5qUH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eUHZl1AM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P9HzlQndl86kLps3EDkcKl0zZR/XXTA+ye1y//toSvk=; b=eUHZl1AM6Dmgzf8B+/WFEjhLru
	ycjzw/jFYtfW/XNLnDma2/0c7ssHbk7j4nsy4s5pXAMgKCx8WL56SomELsmbM8Pjz/jH6zVAd0JGy
	qjvRw5PONZ4O+RzhLjP9jYphNeoykfI76KuJ+qttAx464AKXmjYtbZMk/HjYxEm78EM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOy8n-00FGBh-3H; Tue, 10 Jun 2025 14:31:45 +0200
Date: Tue, 10 Jun 2025 14:31:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/3] net: phy: micrel: add MDI/MDI-X control
 support for KSZ9477 switch-integrated PHYs
Message-ID: <6597c2fd-077a-4eac-945f-97b43c130418@lunn.ch>
References: <20250610091354.4060454-1-o.rempel@pengutronix.de>
 <20250610091354.4060454-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610091354.4060454-2-o.rempel@pengutronix.de>

On Tue, Jun 10, 2025 at 11:13:52AM +0200, Oleksij Rempel wrote:
> Add MDI/MDI-X configuration support for PHYs integrated in the KSZ9477
> family of Ethernet switches.
> 
> All MDI/MDI-X configuration modes are supported:
>   - Automatic MDI/MDI-X (ETH_TP_MDI_AUTO)
>   - Forced MDI (ETH_TP_MDI)
>   - Forced MDI-X (ETH_TP_MDI_X)
> 
> However, when operating in automatic mode, the PHY does not expose the
> resolved crossover status (i.e., whether MDI or MDI-X is active).
> Therefore, in auto mode, the driver reports ETH_TP_MDI_INVALID as
> the current status.

I assume you also considered returning ETH_TP_MDI_AUTO? What makes
INVALID better than AUTO?

	Andrew

