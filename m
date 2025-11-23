Return-Path: <netdev+bounces-241075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A37E9C7EA5D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 00:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBD143450B1
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 23:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA065269D06;
	Sun, 23 Nov 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pqrdJAx/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B2EEAB;
	Sun, 23 Nov 2025 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763942187; cv=none; b=f7grz4DXP+kQiXZUwgbGaMSJ6l1Dr77fkV8f6jebJsby3cyOurmmQOYL3jKnyj8BxKiCGb8JlKwttIZPmdhN0gkhwAe7eKfPsecGmWOjTMdePS0sTfh10hsYsgYzfBk9OoM3K0NpRJWAKSfDDiPNdkYnO4JZcaLbcSs5qzZr1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763942187; c=relaxed/simple;
	bh=CsLMfGDWRguroPi6P60x8swhBoS5eKu5s5MU53/fjig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5/4J4ZIqBWyBuNkD3Hb0YaXM2gJFGITI7g6vMkMoiODFw01od/Uc14XiTv4YJXWl8YGZKvt7imVJYBhqOcaJORCD2qNPvFj7vZGCtqnWGTHU6+yr6KIHz8CHA18anBa6p0M5831WXgqLjRCbRJomY7oO7UDibWOynwwkfx2dpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pqrdJAx/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+FVKXGlrlxpzbfrPQr5zytA72KjXST3kXJrMsuZIlOY=; b=pqrdJAx/JjoxwwXcZ/EBIbJScS
	MRIPmNKuVtA7vRQo9x462xwFpKX1t+jkgiqu8RxGGCB8Zg2Q0U3cN3VQR36VAByDYAWNs+HUWRAO8
	/25ou1AgugWVQSb1/Bg4P/rMMDWvwKO3sVq5NK1EsswqUCL2/gb5sBsRBQ5QPp0T2J5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNJwB-00EroG-J0; Mon, 24 Nov 2025 00:56:11 +0100
Date: Mon, 24 Nov 2025 00:56:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: phy: mxl-gpy: add support for
 MxL86211C
Message-ID: <c4463d7c-5dab-4090-819b-43abd6e46b44@lunn.ch>
References: <cabf3559d6511bed6b8a925f540e3162efc20f6b.1763818120.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cabf3559d6511bed6b8a925f540e3162efc20f6b.1763818120.git.daniel@makrotopia.org>

On Sat, Nov 22, 2025 at 01:32:15PM +0000, Daniel Golle wrote:
> From: Chad Monroe <chad@monroe.io>
> 
> MxL86211C is a smaller and more efficient version of the GPY211C.
> Add the PHY ID and phy_driver instance to the mxl-gpy driver.
> 
> Signed-off-by: Chad Monroe <chad@monroe.io>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

