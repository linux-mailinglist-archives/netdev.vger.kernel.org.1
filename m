Return-Path: <netdev+bounces-217230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C864AB37E1A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B8C7AD9D1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877F2F1FE7;
	Wed, 27 Aug 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="08XwWJK9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699701E520F;
	Wed, 27 Aug 2025 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284477; cv=none; b=flxCPrV/vOtd2FHY429APKo7jKzQuR9c5otUiLZzdC+3TYN/OzphSfxuxHaqBwvYc6OicITez14HMVhYQWo2QHF95cZTg1ggwj+0tIxYmH5ao+zcsmhHMURRoIXU1nHC9MIo/ctYE+P9fTzuZbXCx1vaM6u/RgKSH+yfyJuxQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284477; c=relaxed/simple;
	bh=3La7ZruIM39k9yATZBjNuP6LYmJSdGNKCPSZR/7EuMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEYe5oYwLWAcMmES5tEPXOk18LR7KKt++dOn3JIofKPl3D+30fEtSFYy/a0ras1IXya203wjnbkGMPSUEK2iTSnCvsHwTs7kuGJGg8Pwskeh9YiDIszEMrXhO8MkekyLCY72RcTPdI+esqXESyFBqqGA43NswK0ahDWvUkDOcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=08XwWJK9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tnzvx7h8fFQ2+qqO7+1UO+n9yvNn4jENB+MUqSVUa5g=; b=08XwWJK9dMNa2m7wW74lyE8JW+
	W0VRR3L/nlHnyY1xYTx3aSlhAKbR8oPvW0bDVKw/fJEQGA/1bB2BGjw/3MM31alzZL5fg1u9d/zkh
	sFQcXv7hS0GFyARLhc0sxnp0K4sRU/oQ+i4PEyKXpKJLwkxwwGM8qOsAazwbZPUZT9w71z7n5vcQu
	ElEaBMWYuskUToxWPIAN7ThyODjrPYSTehhWOfeNarrqMrGmXymUkJcT6KGl0jDMOB4SjNi6i5Yo4
	eN1AYog/bg9QIOQu2qNy9H1T8cCp8JUaTkenIp8dgADwNz/1hAi/EENyrpuWI5JffaPyI+aZvdXnI
	JKmnnpuA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1urBos-000000000Fk-3In4;
	Wed, 27 Aug 2025 09:47:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1urBor-0000000023Z-0hms;
	Wed, 27 Aug 2025 09:47:49 +0100
Date: Wed, 27 Aug 2025 09:47:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
References: <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Aug 27, 2025 at 10:41:11AM +0200, Alexander Wilhelm wrote:
> Set to 100M:
> 
>     fsl_dpaa_mac: [DEBUG] <memac_link_down> called
>     fsl_dpaa_mac: [DEBUG] <memac_link_up> called
>     fsl_dpaa_mac: [DEBUG] * mode: 0
>     fsl_dpaa_mac: [DEBUG] * phy_mode(interface): 2500base-x
>     fsl_dpaa_mac: [DEBUG] * memac_if_mode: 00000002 (IF_MODE_GMII)
>     fsl_dpaa_mac: [DEBUG] * speed: 2500
>     fsl_dpaa_mac: [DEBUG] * duplex: 1
>     fsl_dpaa_mac: [DEBUG] * tx_pause: 1
>     fsl_dpaa_mac: [DEBUG] * rx_pause: 1

So the PHY reported that it's using 2500base-X ("OCSGMII") for 100M,
which means 0x31b 3 LSBs are 4. Your hardware engineer appears to be
incorrect in his statement.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

