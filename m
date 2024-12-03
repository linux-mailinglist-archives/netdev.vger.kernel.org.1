Return-Path: <netdev+bounces-148651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EC59E2D88
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F1B26AE1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A5C205AB4;
	Tue,  3 Dec 2024 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ljXk21QP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE51B0F09;
	Tue,  3 Dec 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257599; cv=none; b=SgqDhHdBwbdYOSIUTQC4CH60QgDzDzc6rdZy2Y5Vsq7qbc8Iw2DC7/0eAi0jWH10Q0B+mkTaDvhXetH1t9M1B45JNg0zPv2R/PhDp2TdQSxbdqYZAAw+I+mjukhTWqM8AP6abWtkbwW03lqXGmQtRvoG3wD1HBVC2hKTp2YSRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257599; c=relaxed/simple;
	bh=62FGdj89Sxt78umBMCRkvM4YUdCIKpA2B9i67nQQzWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbISajfycBQfo74KAc84xeDKg63Vlq6y18+VoC6gZ8+MVnnzFwbnmdxgvYK8k/xCONa+NHtchah6mm79oo0nCKBeqcrt4bXEVpK0Wp5VLgLcapwp9WXIejBtJO9Nm0YauSe9b7hbjShr1r7TmViMd9LA/qYHVkzoB+2ECTfM6Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ljXk21QP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MgboeHSqQp6/IluBIsDw2q9e1F3qAshf0GDnZunVBts=; b=ljXk21QPRZAWDZ6BR0OWMC3cnu
	IWCkt1lKE5fU+1qKsl+niqDtHBp28kCbK0ZTurlPkAGVnMZvvjyLYW9bJaf9+TbmpOROQT0aJcRCE
	SbSJGHsjF2j33+jG8W73rgNgytSxmoHJEnR4ETpEq4n+s0QnCoRmjYxZNUkn6hN/GvXw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZTb-00F81g-9M; Tue, 03 Dec 2024 21:26:31 +0100
Date: Tue, 3 Dec 2024 21:26:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 01/21] net: usb: lan78xx: Remove LAN8835 PHY
 fixup
Message-ID: <e8022d59-4dff-4286-90ca-4cf693c39d84@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-2-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:34AM +0100, Oleksij Rempel wrote:
> Remove the PHY fixup for the LAN8835 PHY in the lan78xx driver due to
> the following reasons:
> 
> - There is no publicly available information about the LAN8835 PHY.
>   However, it appears to be the integrated PHY used in the LAN7800 and
>   LAN7850 USB Ethernet controllers. These PHYs use the GMII interface,
>   not RGMII as configured by the fixup.
> 
> - The correct driver for handling the LAN8835 PHY functionality is the
>   Microchip PHY driver (`drivers/net/phy/microchip.c`), which properly
>   supports these integrated PHYs.
> 
> - The PHY ID `0x0007C130` is actually used by the LAN8742A PHY, which
>   only supports RMII. This interface is incompatible with the LAN78xx
>   MAC, as the LAN7801 (the only LAN78xx version without an integrated
>   PHY) supports only RGMII.
> 
> - The mask applied for this fixup is overly broad, inadvertently
>   covering both Microchip LAN88xx PHYs and unrelated SMSC LAN8742A PHYs,
>   leading to potential conflicts with other devices.
> 
> - Testing has shown that removing this fixup for LAN7800 and LAN7850
>   does not result in any noticeable difference in functionality, as the
>   Microchip PHY driver (`drivers/net/phy/microchip.c`) handles all
>   necessary configurations for these integrated PHYs.
> 
> - Registering this fixup globally (not limited to USB devices) risks
>   conflicts by unintentionally modifying other interfaces whenever a
>   LAN7801 adapter is connected to the system.
> 
> Note that both LAN7800 and LAN7850 USB Ethernet controllers use an
> integrated PHY with the ID `0x0007C132`. Additionally, the LAN7515, a
> specialized part for Raspberry Pi, includes an integrated LAN7800 USB
> Ethernet controller and USB hub in a multifunctional chip design, and it
> also uses the same PHY ID (`0x0007C132`).

I had a long frustrating discussion about adding yet more such fixups
a while ago with somebody how did not understand the implications of
adding another one. It is good to see this one being removed, with a
good explanation why.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

