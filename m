Return-Path: <netdev+bounces-51511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F26547FAF3B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5588B21053
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1F64B;
	Tue, 28 Nov 2023 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wOrTyuob"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77085D6D;
	Mon, 27 Nov 2023 16:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tPsB2hWA3Oc577a+cgExHeE0rQjVhZlCmuxB4d3ag6Y=; b=wOrTyuobaJiBkDDEN+3GnJb9Gj
	khoMngUKyPMKlVGbsfyCinioYWK0Liy4RVI0/Noz7xvcBvdK128h9OAY0vlKvfQpTRb03Oi9dJFK9
	/ppp2Ers5rvwGbJhiODR3FSIcr9/87gXJjP/7n93H5gGoTD/zHSh4MjQ4wDbEHbEfDlY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7mEs-001Oyh-FN; Tue, 28 Nov 2023 01:46:10 +0100
Date: Tue, 28 Nov 2023 01:46:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 3/4] net: phy: restructure
 __phy_write/read_mmd to helper and phydev user
Message-ID: <d3747eda-7109-4d53-82fa-9df3f8d71f62@lunn.ch>
References: <20231126235141.17996-1-ansuelsmth@gmail.com>
 <20231126235141.17996-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126235141.17996-3-ansuelsmth@gmail.com>

On Mon, Nov 27, 2023 at 12:51:40AM +0100, Christian Marangi wrote:
> Restructure phy_write_mmd and phy_read_mmd to implement generic helper
> for direct mdiobus access for mmd and use these helper for phydev user.
> 
> This is needed in preparation of PHY package API that requires generic
> access to the mdiobus and are deatched from phydev struct but instead
> access them based on PHY package base_addr and offsets.

Why is this all going into the header file?

	Andrew

