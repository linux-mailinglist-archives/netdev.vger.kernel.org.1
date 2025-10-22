Return-Path: <netdev+bounces-231664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51943BFC351
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FB5254526F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63C348895;
	Wed, 22 Oct 2025 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GlLCGWYi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A5347BC2
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140074; cv=none; b=cPGdfqT3h8oyUN2mBQf7ZjIbrhRzuIxkf2XSHgBQ6PW/JUZmyB2nm3C6gSRJPf8Q1PLXlkewVHcMMlvJPyG7qjdHcWMDU2ThX3vSzm8nIRu8Re/cb/8Wnxh0nDHjgUCZ6Sg7YSjwaoljv3yTKm1b7V+rSlgVuihYyz5BywQJY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140074; c=relaxed/simple;
	bh=l0vWUvCO+iSRq/i45f5BYYNbXn3dtaBqlDLMAiIK5gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5DjQolgX9laZPZfK53fXGFIjLdNVmd5++96XmOiJH+YwXqwRYGJAgrCKOAHPtgy4bbj2i9SAWxR57iBMJOG1xzO4q1bmd8CSQQU1xFbWJKcDpZYM0tTIplK+WA8TtLI6Jard25dYz7pqvtiPfjXWGl5I7wkhmG8Ea2vTb1cbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GlLCGWYi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C342E1A15C8;
	Wed, 22 Oct 2025 13:34:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D83E606DC;
	Wed, 22 Oct 2025 13:34:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D361102F242F;
	Wed, 22 Oct 2025 15:34:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761140067; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rkViBGu74KDxz9qDROM+0Y+EYcnboJC0J4JeqwsrGfw=;
	b=GlLCGWYivjHGhUt5UODhGa9mb++fg96pBZX0r044UV3KnmUGCn8/IVIiJoBTybhz4peGdy
	gdPWSBp/m26CR680XAnYDUjFnrPv54dOpLD5kS2pm5YHGQGoH/T6LuC7RYckY5V+6q8iKK
	D4C0K1aTkN9/x3Rxs6MdPx59TzRARq/MFhxp5ZN8JdinR0cF6JsoPDSqd0/PLVRi1jefkr
	U8F+cCMCFnjK4bt+ZJ8mD78OCeVKLDsvddhGwXe7z3QZJaTFsgFTp/TZQzOZrX+AvTCV6r
	NgY/fmcEmKNMpB6ktQQVpYPzFptSymM9UmJNwxHrKiqhEPR4vnZyMX5T0mo5gg==
Message-ID: <1e4d3ec3-2e20-46a3-95d3-d3e3c22db4bc@bootlin.com>
Date: Wed, 22 Oct 2025 15:34:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net: phy: add phy_can_wakeup()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCJ-0000000B2NQ-0mhG@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1v9jCJ-0000000B2NQ-0mhG@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 17/10/2025 14:04, Russell King (Oracle) wrote:
> Add phy_can_wakeup() to report whether the PHY driver has marked the
> PHY device as being wake-up capable as far as the driver model is
> concerned.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  include/linux/phy.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 3c7634482356..3eeeaec52832 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1379,6 +1379,18 @@ static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode
>  	linkmode_clear_bit(link_mode, phydev->advertising_eee);
>  }
>  
> +/**
> + * phy_can_wakeup() - indicate whether PHY has driver model wakeup capabilities
> + * @phydev: The phy_device struct
> + *
> + * Returns: true/false depending on the PHY driver's device_set_wakeup_capable()
> + * setting.
> + */
> +static inline bool phy_can_wakeup(struct phy_device *phydev)
> +{
> +	return device_can_wakeup(&phydev->mdio.dev);
> +}
> +
>  void phy_resolve_aneg_pause(struct phy_device *phydev);
>  void phy_resolve_aneg_linkmode(struct phy_device *phydev);
>  


