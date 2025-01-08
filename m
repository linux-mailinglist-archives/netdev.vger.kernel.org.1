Return-Path: <netdev+bounces-156260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC95A05C1B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CC27A036F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921A1F942F;
	Wed,  8 Jan 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rqzuunY8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360B1946C7;
	Wed,  8 Jan 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340770; cv=none; b=Ru3ES9OCeCuvPg4CcWT7FEYkCDJHxHNLqzb7tUC5+16VScAPl0sDUWTNKPLy9E5eQ4hgXEnwhwXIpuM9fr51iVnXT/BC2HaWX+3Jnsk1qX5Tr0iTaK2rp4UHoxGZN+XEvQRinFgPQOnSitI3aquqBEm3YDbGwts58zJLQBwQHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340770; c=relaxed/simple;
	bh=lT8DxYUFuqPTAKXvppqDK0sYD4ANfPqmDXVG0fwbCNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUhbaHJqt8guZhdeyp8yxCN9w2mhM0P1X0+w5aoHIr99QYSJmmJeqobN6J6JgxRiZm6EkbH1PM3QbSRxX5/mGfQMmsAPIjF6wE7xKBcmtei6KO6WQRGjYIOwgE6fG/i7PYbAo95zeL1Jcd0NpFC8fSIp3SNKhqY8/78tjd3qzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rqzuunY8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CsmbqkKtj3BytVi9ck/ZNrCzWPHIJh46NK55puQMHpY=; b=rqzuunY8qrx3Gs+yY8N7J68izv
	cCPJ/HEWUTNZn+cElCS1foEMRyT3HRIll0DOtUJHcG7dBjO7P3EA+8fKSCyZbZGcaB4afEp9pRviU
	u70yIOHij4hdYfctV7/uQGQ1Q78rHkyUJBHUDCtWcDduZ5VttYrxwIbbA5mEScWAVon2Kng2l+ISH
	4SPSwBHxtIoaNVz8N1gE2Dc8jtyOiHyfAzPYRa8ltPg0MPX1+8YSI4Ty1iSIvV8O3lXkMGJnZiMuK
	xoVuT/hIOc7VxWe0OsogJb58oBgaLwmp9VDeZg0d3ku4UWlqS9VsMlobccbdeN2HfdmMDFiyHDkPV
	U9TnAVlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53774)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVVY9-0000dR-02;
	Wed, 08 Jan 2025 12:52:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVVY7-0006JN-1W;
	Wed, 08 Jan 2025 12:52:39 +0000
Date: Wed, 8 Jan 2025 12:52:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 3/7] net: usb: lan78xx: Improve error
 handling for PHY init path
Message-ID: <Z351FwJ7WiimdUbQ@shell.armlinux.org.uk>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108121341.2689130-4-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 08, 2025 at 01:13:37PM +0100, Oleksij Rempel wrote:
>  	phydev = phy_find_first(dev->mdiobus);
>  	if (!phydev) {
>  		netdev_dbg(dev->net, "PHY Not Found!! Registering Fixed PHY\n");
>  		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> -		if (IS_ERR(phydev)) {
> +		if (PTR_ERR_OR_ZERO(phydev)) {

Even though I've said to use phylink's fixed-phy support, I'm wondering
about this entire hunk.

>  			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
> -			return NULL;
> +			if (IS_ERR(phydev))
> +				return phydev;
> +			else
> +				return ERR_PTR(-ENODEV);

When does fixed_phy_register() return NULL?

If there's no fixed-phy support enabled, then you get an ENODEV error
pointer. If support is enabled, then you may get an error pointer
or a valid phy_device structure. I can't see any case where it returns
NULL. So, I think this hunk is redundant.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

