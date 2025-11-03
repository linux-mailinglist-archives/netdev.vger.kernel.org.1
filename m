Return-Path: <netdev+bounces-235244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA86BC2E3DD
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC9724E224B
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E2A2FCBEB;
	Mon,  3 Nov 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F+RWfLyE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1EC1509A0;
	Mon,  3 Nov 2025 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208377; cv=none; b=WO3fkp2Wr6f9qSGSiFcc9efrnEdbsgtTi53OGzRRxMHdeVLeYr/kBTYUw6eOgydSudb0v1RYPL6Btzkgj+EpJrQzesJpg7XLaZhVWfnJW4l0YFabmo4BkomzESLgLqXI+3puw/8R0fXyzlWEJ0/JBqwiCDqGTlgjiaLTOJ98TdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208377; c=relaxed/simple;
	bh=CGH05ixCVuNtpVCDpIMlLwAOqtoyFKQSnKd5letD1P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueYx0TH7JKl/U1pF3L81tModOacBzRJcGkR6CRRlHAyVmcbwREu0CGwdXp6QPAZZTVqOp7ssJ+VwighjUIzt6vQRZ0kDjTRv+u4hwJQC410f1xh9n5C/62bbYd7kMsFUS4WY0MpQYxfF4ES3Q8XHUtTMgqHXghEj0rcPIcvqG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F+RWfLyE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dIJMARzyVViXUOdIpxPXhNV9G7s34lw7SBR4l1S5/6w=; b=F+RWfLyEb745gXppsCJqM+Hq2m
	SyHk9fLklV9/3jSYN2yc/EhRQJXqcRElQeVqhvWTCjLnBJcc+L/TlTQXRQK8nnDI0CQKDISZ9Q8et
	JXp9yKb+DyvLOEhXNIf6I4XHV7tFoHNCFxX5HxrxdeVkEENuV7YFkPruFXUGXBVbzYuU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG2tT-00CpDQ-BM; Mon, 03 Nov 2025 23:19:19 +0100
Date: Mon, 3 Nov 2025 23:19:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	Doug Berger <opendmb@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Antoine Tenart <atenart@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: bcmgenet: Support calling
 set_pauseparam from panic context
Message-ID: <f9a32e33-9481-4fb7-8834-b36d88147dc2@lunn.ch>
References: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
 <20251103194631.3393020-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103194631.3393020-3-florian.fainelli@broadcom.com>

> @@ -139,7 +141,8 @@ void bcmgenet_phy_pause_set(struct net_device *dev, bool rx, bool tx)
>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->advertising, rx);
>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->advertising,
>  			 rx | tx);
> -	phy_start_aneg(phydev);
> +	if (!panic_in_progress())
> +		phy_start_aneg(phydev);


That does not look correct. If pause autoneg is off, there is no need
to trigger an autoneg.

This all looks pretty messy.

Maybe rather than overload set_pauseparams, maybe add a new ethtool
call to force pause off?

It looks like it would be something like:

struct bcmgenet_priv *priv = netdev_priv(dev);
u32 reg;

reg = bcmgenet_umac_readl(priv, UMAC_CMD);
reg &= ~(CMD_RX_PAUSE_IGNORE| CMD_TX_PAUSE_IGNORE);
bcmgenet_umac_writel(priv, reg, UMAC_CMD);

	Andrew

