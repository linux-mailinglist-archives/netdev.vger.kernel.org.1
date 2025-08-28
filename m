Return-Path: <netdev+bounces-217797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB473B39DB6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97437A9726
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D432D30FF3B;
	Thu, 28 Aug 2025 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YoqGbb6E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0930FF3C;
	Thu, 28 Aug 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385334; cv=none; b=fr89ugskKcfiR/je8t54ET+Pm6Fpi2joyxdAc6CzdlLrM2NyVFWfoznXqiwgc3pX9vE/NUYZTboOpavDplV15uzsga2NbXmBHNpi9D441dyCj5WH9SzsvPZuIWt2lNxiMi88sOMkjSPvXoUmt804cIqYme8qKRUGi1YLwdqicl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385334; c=relaxed/simple;
	bh=CR0R6ItLoxt0OxOpuGVaGemsulcbpOdmg0rGG95VYYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0tKsNGl3wnqRu+Q4pG9wfRuq5B2e41r4wBNpGuhgq7bkSAI+tIcS0CYcAWfoVuKWazSOtAfZpqkXyBIv42QJyQNtLu5RZiEWa9Bo98bP2H/kzq5aijXZZhhrGrIVRzE1sKsd0fqZ/mP0i5RodeObzUn4Y+siZjTn+LaXo+fMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YoqGbb6E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ww1mMHJTUFQq7kOMMxuh0Lh63akpdC5oH5c10iJvODk=; b=YoqGbb6ELbuyx9+DujpftjEe07
	UUqwLHdNyzN7sYVbmWFv0zNLfguQB2aMdh/3WsokE1RLEYf2BsMGMIrIEBaNRIy2eSuMT88Wqb91M
	4meRPxHKcrrKGoP6wL9HGYbHVzeuys12L2sfMwHWojGCoh2Y2aVjql8MxRsB3xatJh5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urc3Y-006Lh8-RV; Thu, 28 Aug 2025 14:48:44 +0200
Date: Thu, 28 Aug 2025 14:48:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] microchip: lan865x: add ndo_eth_ioctl
 handler to enable PHY ioctl support
Message-ID: <da9cd82e-e3f0-47a8-815b-024bab5e81d3@lunn.ch>
References: <20250828114549.46116-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828114549.46116-1-parthiban.veerasooran@microchip.com>

On Thu, Aug 28, 2025 at 05:15:49PM +0530, Parthiban Veerasooran wrote:
> Introduce support for standard MII ioctl operations in the LAN865x
> Ethernet driver by implementing the .ndo_eth_ioctl callback. This allows
> PHY-related ioctl commands to be handled via phy_do_ioctl_running() and
> enables support for ethtool and other user-space tools that rely on ioctl
> interface to perform PHY register access using commands like SIOCGMIIREG
> and SIOCSMIIREG.
> 
> This feature enables improved diagnostics and PHY configuration
> capabilities from userspace.
> 
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

