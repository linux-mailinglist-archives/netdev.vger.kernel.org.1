Return-Path: <netdev+bounces-148652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332C29E2D0F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED914282655
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03F1205AB3;
	Tue,  3 Dec 2024 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a0g6zrc6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13EF1F891C;
	Tue,  3 Dec 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257776; cv=none; b=sUqH74iNbLt/JtTmwHxdBvLrNPaBu94puVEEtNJOUdVyylbTEka9WuqBz94aBg7yjl0RAIqRB7NwQcFXSs+CCRsnsZa7XvqiBY1re3Yl1RVT3qu9oi8CDXZgPk+5dnY568blEQSACe9TbzqpAbGeAfluYbxpGQwID+GgHviX5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257776; c=relaxed/simple;
	bh=lBZ1iV0UOIdldmXxtaFONCmOWKgZtuekjXr+B4bOdcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnyWw2VM873zN8ZAr+6Km850FHXQAjVgxlh5ES/bxLvQ6ehqUZfAM7CYARoRF8N4CnZnpdv2tuSOvBUg8Squ5XTFI1O18G9LfWP0aAvGFmAB5GgYxcBSkR3zupSHOVEz+1IWgzpqDzp536RIKf1kyUlyXn9N/ZrjdRU/3n7IzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a0g6zrc6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3DjqniS3uPfJ1D7jPop8dfe08c6bLFSUECp9o+zEPZo=; b=a0g6zrc642tK51ByglaQEfVmpn
	lCsWo1KAT+WFLUTdjwVt95Bq2PHQEWouEfzKwOjiFO/xizOctU7rA/3nBhtJM8PoUSIIJu462IRmv
	6PXj7vPVJzEf1Pju31P39pQicfHkcb+A4PhR7NxbJzh6Alw8WgvVtKYqRZU2c7jhuvdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZWS-00F831-4s; Tue, 03 Dec 2024 21:29:28 +0100
Date: Tue, 3 Dec 2024 21:29:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 02/21] net: usb: lan78xx: Remove KSZ9031 PHY
 fixup
Message-ID: <baf9c0c0-5960-437e-b725-c58c9f0a5580@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-3-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:35AM +0100, Oleksij Rempel wrote:
> Remove the KSZ9031RNX PHY fixup from the lan78xx driver. The fixup applied
> specific RGMII pad skew configurations globally, but these settings violate the
> RGMII specification and cause more harm than benefit.
> 
> Key issues with the fixup:
> 1. **Non-Compliant Timing**: The fixup's delay settings fall outside the RGMII
>    specification requirements of 1.5 ns to 2.0 ns:
>    - RX Path: Total delay of **2.16 ns** (PHY internal delay of 1.2 ns + 0.96
>      ns skew).
>    - TX Path: Total delay of **0.96 ns**, significantly below the RGMII minimum
>      of 1.5 ns.
> 
> 2. **Redundant or Incorrect Configurations**:
>    - The RGMII skew registers written by the fixup do not meaningfully alter
>      the PHY's default behavior and fail to account for its internal delays.
>    - The TX_DATA pad skew was not configured, relying on power-on defaults
>      that are insufficient for RGMII compliance.
> 
> 3. **Micrel Driver Support**: By setting `PHY_INTERFACE_MODE_RGMII_ID`, the
>    Micrel driver can calculate and assign appropriate skew values for the
>    KSZ9031 PHY.  This ensures better timing configurations without relying on
>    external fixups.
> 
> 4. **System Interference**: The fixup applied globally, reconfiguring all
>    KSZ9031 PHYs in the system, even those unrelated to the LAN78xx adapter.
>    This could lead to unintended and harmful behavior on unrelated interfaces.
> 
> While the fixup is removed, a better mechanism is still needed to dynamically
> determine the optimal combination of PHY and MAC delays to fully meet RGMII
> requirements without relying on Device Tree or global fixups. This would allow
> for robust operation across different hardware configurations.
> 
> The Micrel driver is capable of using the interface mode value to calculate and
> apply better skew values, providing a configuration much closer to the RGMII
> specification than the fixup. Removing the fixup ensures better default
> behavior and prevents harm to other system interfaces.

PHY_INTERFACE_MODE_RGMII_ID should be good enough for most
hardware. It seems like USB dongle developers don't really understand
phylib.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

