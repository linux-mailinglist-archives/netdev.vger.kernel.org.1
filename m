Return-Path: <netdev+bounces-175468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE132A66050
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542D216ED4F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072141F8ADB;
	Mon, 17 Mar 2025 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VFsEwAzK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A21F1934;
	Mon, 17 Mar 2025 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246244; cv=none; b=Hr82wwzQE+H9/YbI77XXhDWAGN98Yiv8QfCqdByLILY9oMaOZl52FFmSwjXR7lWuGf3C3ZB73A96tpyPZvbsbmxNwLiBzFdd62Sbi3i7F7vyeO+xj2ayfpnOh28lcKEMNA4FYhs2vPDCZSjcT+o3kRnyldOTCzItQ4cGKJgjDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246244; c=relaxed/simple;
	bh=AhuNXOClJp+HEiCevhvQABx+Y2H7f15GPg4jNyqYiyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLXxhoe823IbtjQ+gpBBo28y2vLZ4SqVLJglGN50LeZw37JCQCGuIpz95rSvx5kOlgmyBKwIyKdsgAQ2IxG9akhBGubkg7oLaQu9Ctg3u9ey7JoauJrH7gwRDY7kuK7WPTrFyBG7yeT5B2mInmuZKcuHWwCj16ZbOA5sF4WPEto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VFsEwAzK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fg+hPke6K4wOXBqUji6DjB8wFbyYq2c3YR5VbleUfu4=; b=VFsEwAzKeYJG9k2k5DXrjFZD0o
	4oAhwBf0mrIWIMS2efoxIMq3xShJFihl4jkbOFow5ZSXKXbg11tJTOna6o66gL3UuYgttCK5FqPlo
	1E53MP+llxgBTyUZYwrZmyMzKEg5FYoBf8Noy2F45BpbEkDdtCaI5SCXhuPM2GLiv8fA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuHpi-006BN3-58; Mon, 17 Mar 2025 22:17:14 +0100
Date: Mon, 17 Mar 2025 22:17:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: Add dedicated entries for
 phy_link_topology
Message-ID: <e0cd1666-ab61-492d-a72c-dbd418633f3d@lunn.ch>
References: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313153008.112069-1-maxime.chevallier@bootlin.com>

On Thu, Mar 13, 2025 at 04:30:06PM +0100, Maxime Chevallier wrote:
61;7991;1c> The infrastructure to handle multi-phy devices is fairly standalone.
> Add myself as maintainer for that part as well as the netlink uAPI
> that exposes it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

