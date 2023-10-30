Return-Path: <netdev+bounces-45293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAB97DBF81
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AF72812F1
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADE818C23;
	Mon, 30 Oct 2023 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cDMu9reU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C128EF
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 18:04:05 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F989E
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ngb1tGQEgFyStSDK6ULr3DVN9Yw14nuVEE4gzJAArFc=; b=cDMu9reUIM+MDHH3AooNmZGfuA
	CENCvOqDkKl1pC6iD678RpzpE3izb+Zge0hWBfgmmRwlK20fgD67RXfu2NpSlnbV4+S3WNbfYNutc
	3NJPWIj7YS5KFnbE6vcsfmasrLbMOM+GJHUxlsTrRkJIA3sVDlI2g5AfCNSLg+bMfFQYTR7QTsCHb
	WyGsFgaJ5pEZm+DpxdptZNtvb3uCGPeg1ojBXzQvsEXEpL8RGme5MlEwPmsx71Ic2IG4m2XzUfTf6
	RFOuwcNtaWVXupqvaQHllRqy+uvoGcG1xnuD9fy/PeRMt5cWx9tzvODVo5KzjfngIlqqbFUDuy4HN
	Qf3QnQWA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44640)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qxWcI-0001y0-2X;
	Mon, 30 Oct 2023 18:03:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qxWcI-0004D2-QI; Mon, 30 Oct 2023 18:03:58 +0000
Date: Mon, 30 Oct 2023 18:03:58 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: [PATCH v1 net-next 1/2] net: phy: fill in missing
 MODULE_DESCRIPTION()s
Message-ID: <ZT/wDmwiwMuGFJYa@shell.armlinux.org.uk>
References: <20231028184458.99448-1-andrew@lunn.ch>
 <20231028184458.99448-2-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028184458.99448-2-andrew@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 28, 2023 at 08:44:57PM +0200, Andrew Lunn wrote:
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index b8c0961daf53..5468bd209fab 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -3153,3 +3153,4 @@ module_exit(sfp_exit);
>  MODULE_ALIAS("platform:sfp");
>  MODULE_AUTHOR("Russell King");
>  MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("SFP cage support");

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

