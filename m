Return-Path: <netdev+bounces-176929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED8A6CB50
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 16:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35E47ADE4C
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE8E233705;
	Sat, 22 Mar 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aapKtsWW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1768233156;
	Sat, 22 Mar 2025 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658645; cv=none; b=biPbgtAq7IEs6B2PpPwQ/yi+yzNLjjsTPYxcYSQzQ1mq3Rj6sOPRwW2H7zBno3PdS6RDmqT9jwnfzR7wGL2Pqw2wTr+v38aLe+VL5YO3ZCO5YXJyIxPhG/YyzOZ197jF5OcdipWnmw6CpjiAltlCn3fxlkDKRRsDD1/m/1XGFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658645; c=relaxed/simple;
	bh=r708+bDehZAlnvff5apG+0cdzeXDjHhFIagoBz300to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG0ZUlR5n0N7KxeAHKrz+XYYeCIPnWZk2SED2EjmmtiEmFnkbD3Ilr6+5VW/EWJb9QbhWPYb6ZQyaq0C/d+ZQhLJ9yNVZXSvlAq3QFNhhB1u0dNzb8IVUh0AfJOPUUbg17zyfistSlppRH+qtQwdMnHLz0ZIc44lKeY98D8FTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aapKtsWW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=57cVkPdZmwPqKzfwekx1kG5RZEmFx6XcHaEzEx4IKns=; b=aapKtsWWHO7pfZLI65rfMMSuTZ
	2QE6MQM5bW/z+0OZc4lVIqGxXx+zp/7yAQu+1NvfimIdKIyXrfRO7Vy0HGo5PdzD13Z3XllILyiKt
	Ogr+xnySvr2CvyM8E0a3547UG+Cn2joSKMjjOVCemxCUJNEWCOPgsnoIDPobMn9r5IeU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tw17K-006jda-Ip; Sat, 22 Mar 2025 16:50:34 +0100
Date: Sat, 22 Mar 2025 16:50:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 7/7] net: tn40xx: add pci-id of the
 aqr105-based Tehuti TN4010 cards
Message-ID: <287fd184-1153-4716-b85e-3a76699f8173@lunn.ch>
References: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
 <20250322-tn9510-v3a-v7-7-672a9a3d8628@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322-tn9510-v3a-v7-7-672a9a3d8628@gmx.net>

On Sat, Mar 22, 2025 at 11:45:58AM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Add the PCI-ID of the AQR105-based Tehuti TN4010 cards to allow loading
> of the tn40xx driver on these cards. Here, I chose the detailed definition
> with the subvendor ID similar to the QT2025 cards with the PCI-ID
> TEHUTI:0x4022, because there is a card with an AQ2104 hiding amongst the
> AQR105 cards, and they all come with the same PCI-ID (TEHUTI:0x4025). But
> the AQ2104 is currently not supported.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

