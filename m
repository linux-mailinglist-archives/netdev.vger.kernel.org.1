Return-Path: <netdev+bounces-49975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408A7F41E1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BB0B21090
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0ED1E536;
	Wed, 22 Nov 2023 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XiML8zb5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109D2D54;
	Wed, 22 Nov 2023 01:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EQ4smjqMqmMfalcMGUhJfWa7OYmkCqYHNTOX5D4CJKg=; b=XiML8zb5vTPJVbD1Yp652UL5fn
	G+HecxK3KyFjdQ3dQeJv0tduaxjhSD0O6UQtIu5px+GhiQxt53IyMHOMQq2w+RhZ6MHzJRJbM1ZWU
	JzA/VxQoKj7UheMYljEMkH9BNJ/GMpsQvI3TzXK2HS81DZ9nEYJP8knlwJ5EUX2htVlG3rFWq8XDI
	Qnd3JpoeD0Ic9ruBosaH11UE1Wr062SegIFXufj24oq4YCcy7KQnzNl5mlh2Q5E/4yB/86NoSv9vJ
	jfbRiUCC12OYmSHA/ufO6scak/zE+QIETtw9NeGBQu0xr7Z+NhJKrv9MGT5gaNMm3/VA85GK7mVD0
	JjF8sDUw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56008)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r5jkV-0008Gf-0D;
	Wed, 22 Nov 2023 09:42:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r5jkW-00055U-SH; Wed, 22 Nov 2023 09:42:24 +0000
Date: Wed, 22 Nov 2023 09:42:24 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Simon Horman <simon.horman@corigine.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v5 2/3] net: dsa: microchip: ksz8: Add function
 to configure ports with integrated PHYs
Message-ID: <ZV3NAPB/MX3R4b2q@shell.armlinux.org.uk>
References: <20231122092545.2895635-1-o.rempel@pengutronix.de>
 <20231122092545.2895635-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122092545.2895635-3-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 22, 2023 at 10:25:44AM +0100, Oleksij Rempel wrote:
> +	if (duplex) {

Unnecessary.

> +		bool aneg_en = false;
> +
> +		ret = ksz_pread8(dev, port, regs[P_FORCE_CTRL], &ctrl);
> +		if (ret)
> +			return;
> +
> +		if (ksz_is_ksz88x3(dev)) {
> +			if ((ctrl & PORT_AUTO_NEG_ENABLE))

Too many parens.

> +				aneg_en = true;

Simpler:
			aneg_en = ctrl & PORT_AUTO_NEG_ENABLE;

> +		} else {
> +			if (!(ctrl & PORT_AUTO_NEG_DISABLE))
> +				aneg_en = true;

Simpler:
			aneg_en = !(ctrl & PORT_AUTO_NEG_DISABLE);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

