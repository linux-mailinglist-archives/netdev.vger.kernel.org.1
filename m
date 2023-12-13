Return-Path: <netdev+bounces-56819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CC9810EEB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 11:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD96B20AA7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 10:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BFE22EE2;
	Wed, 13 Dec 2023 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gWh5QOyL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D5110E;
	Wed, 13 Dec 2023 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4p/ejF8x5RgeHwRMpzH/KTdUk+y5N88xT15+4KyH3ks=; b=gWh5QOyLCyNilaGjn96hPqRv0y
	hzAJkB4BW6Td7/HZ//4Nc16c9oDPYc6tvN9LSsQHqsJI5LCGgp2BU6i+5J8xPu92ZaByu9mjpyqLl
	7oKickMRNWUW2Yv3hF22cgF67Svl7GQhSUJtwLqjYSi446AOMG4C3urv7xmvObzhrUHk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDMpP-002oCI-BY; Wed, 13 Dec 2023 11:50:59 +0100
Date: Wed, 13 Dec 2023 11:50:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add support for the DP83TG720S
 Ethernet PHY
Message-ID: <5a2c3ef5-fe5b-452b-a1fe-93c0cd710eb2@lunn.ch>
References: <20231212054144.87527-1-o.rempel@pengutronix.de>
 <20231212054144.87527-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212054144.87527-3-o.rempel@pengutronix.de>

On Tue, Dec 12, 2023 at 06:41:44AM +0100, Oleksij Rempel wrote:
> The DP83TG720S-Q1 device is an IEEE 802.3bp and Open Alliance compliant
> automotive Ethernet physical layer transceiver.
> 
> This driver was tested with i.MX8MP EQOS (stmmac) on the MAC side and
> same TI PHY on other side.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

