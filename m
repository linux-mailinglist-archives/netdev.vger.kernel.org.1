Return-Path: <netdev+bounces-216317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF06B33159
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 18:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF343205891
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603E7275865;
	Sun, 24 Aug 2025 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="I9dnLdtt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AF1EF363;
	Sun, 24 Aug 2025 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051724; cv=none; b=qQNHp+wQGLq47fo5F1rJZ4pUxj1x8AJex3GklzvjD+RjVigxslxSKJXG2kQz8pxajvRU4pu3Lnwu66eFM2PvVN5dqZkWREK6383Dv255hukIgG3Yj0hT28I12Qd0/0czLzW3GdbUZAazwgueqhbVzR8gFoUWc8l806u8rgxkduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051724; c=relaxed/simple;
	bh=tYVtQ90FUZLrnT2oh3X5l4TGmdk4g1ruv0Av/TFvsDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNsEzZvgfJZqhHWA4zZm5Ll36wHRIzLhH5s8+iAiGOMVNzuS+cMBO4zCRchlavZDQpL6hx5S8QIBznI1OHyBMF7RiUwEgliRo3QzrHcXKu6JDmzySytgKcOHz8mXvMhR3rML7DyzjNuPMpR/2/LgBiLkEPn2D0HykqB4CTaILR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=I9dnLdtt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Euz8rVLqjoF8tF0APwmu+7XgM565CXuJLq9BHbcW/Cg=; b=I9dnLdtt2UgbFjcIDmByjlAafM
	/nv+O6qY/QBYd9W94B8z0PEFgOCkM29O/qaZ/9iji91Fonf6SkpCZd1LjdNvSVBkM81klWrVzfZ8p
	0pojBi6XzNOeH3A9iYDGcj7fvtvaat0hVKAUa7J9SFfE92gVC9+nhNSmWqYmhqYkSqRQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uqDGk-005qOo-Uy; Sun, 24 Aug 2025 18:08:34 +0200
Date: Sun, 24 Aug 2025 18:08:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 1/2] net: phy: introduce
 phy_id_compare_vendor() PHY ID helper
Message-ID: <d440416f-103b-49a1-a077-c6003be9f80f@lunn.ch>
References: <20250823134431.4854-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823134431.4854-1-ansuelsmth@gmail.com>

On Sat, Aug 23, 2025 at 03:44:28PM +0200, Christian Marangi wrote:
> Introduce phy_id_compare_vendor() PHY ID helper to compare a PHY ID with
> the PHY ID Vendor using the generic PHY ID Vendor mask.
> 
> While at it also rework the PHY_ID_MATCH macro and move the mask to
> dedicated define so that PHY driver can make use of the mask if needed.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Hi Christian

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

> +/**
> + * phy_id_compare_vendor - compare @id with @vendor mask
> + * @id: PHY ID
> + * @vendor_mask: PHY Vendor mask
> + *
> + * Return: true if the bits from @id match @vendor using the
> + *	   generic PHY Vendor mask.
> + */
> +static inline bool phy_id_compare_vendor(u32 id, u32 vendor_mask)
> +{
> +	return phy_id_compare(id, vendor_mask, PHY_ID_MATCH_VENDOR_MASK);
> +}
> +

broadcom.c:	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
broadcom.c:	    BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) {
broadcom.c:	if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM57780) {
broadcom.c:	if ((BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
broadcom.c:	     BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) &&
broadcom.c:		if (BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54210E ||
broadcom.c:		    BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54810 ||
broadcom.c:		    BRCM_PHY_MODEL(phydev) == PHY_ID_BCM54811)
broadcom.c:	if ((BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
broadcom.c:	     BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) &&

It looks like there is a use case of phy_id_compare_model(), if you
feel like adding it.

	Andrew

