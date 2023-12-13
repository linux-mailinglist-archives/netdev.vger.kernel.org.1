Return-Path: <netdev+bounces-56974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D38117AD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C63286112
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBB2381CE;
	Wed, 13 Dec 2023 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c8dnyjZI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3922EBD;
	Wed, 13 Dec 2023 07:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V2/nXiv4v7lZNvd19AcVKHw11tHI264Ey5PLbyX7ph8=; b=c8dnyjZIbB1+dwNVE4Tq+a8PMQ
	CvUpoBCjzYJ4dnChicYJOMAD3HmeeLWFsoc+xVG9HB2vh/sjuJNz9nvi3F4wEA4bxWgC61LoDREGs
	xObZLzHRNBXtOGcjIFQSCJQpmfKXtCMnFq6jWFea8Z6EJ4+9XYbWc1HwMqfZE9WbF1XDKna24mze4
	tx9mCu1FMQPnNBMm2DE5uuXxmSX9EZdG0GXWKbpRgvOLw7QmV8e47YgcyTeJNTWfDhWVa8pH7Bjr7
	aDl2SljV+KcEmgx7OUGvKrtn+ASKLlolvTUuXYkbzeEL0iFiGkQPC81nmk0nHnLpV+BZK2YDA6hyT
	1yg1CvFw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47664)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDRI1-0000AI-2z;
	Wed, 13 Dec 2023 15:36:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDRI4-0001bR-7K; Wed, 13 Dec 2023 15:36:52 +0000
Date: Wed, 13 Dec 2023 15:36:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add support for the DP83TG720S
 Ethernet PHY
Message-ID: <ZXnPlPGVWWGB9VyM@shell.armlinux.org.uk>
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
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 12, 2023 at 06:41:44AM +0100, Oleksij Rempel wrote:
> The DP83TG720S-Q1 device is an IEEE 802.3bp and Open Alliance compliant
> automotive Ethernet physical layer transceiver.
> 
> This driver was tested with i.MX8MP EQOS (stmmac) on the MAC side and
> same TI PHY on other side.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

