Return-Path: <netdev+bounces-219614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D196DB4257A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AD93B0D33
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B28025DB0D;
	Wed,  3 Sep 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fu87r0cU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACC32609D9;
	Wed,  3 Sep 2025 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913204; cv=none; b=dCGcsef10ilGZtVATA7Zk30XyJoUr0XLRpXs/8JfMj/HVcx+fo8E+MNzyNjviTkQt/FX8bPW9qgWYo0X3gk4Ax/ScuFfAzUCld6Vm+o2j1AcWV6UovdYYBWPvEWGXX/JB7eTMzoabMEU9kE4O5sMadjauTyM48wCWW6I9Tl6cKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913204; c=relaxed/simple;
	bh=FtnarChabRbjN/eAsXGGEa3ZDi6iTJ3YN1f2gls4cM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+WY8mmg9+sSwJ8JISPbW5mfjdKtcdMEmEan/RuoI6ZqGbpBnguGi1wXYUihkkB/KUYoWmF585tYm75YcgroIiTzQtbZ+ZPtzH+p0ZyXojxqf2nZFY6o6DPwhB3+Egx1RKlQtcDMNAbImzrdmjkIX8PsbO1b28o6fYQGGMmdgd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fu87r0cU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DpewNfBwL/DylheUDqzo8Y5cWg7w9pSgpdI04ZxbrGE=; b=fu87r0cU6UbKLZ63R1igqI47iH
	Ep9dtTU5+PQXTIYPbcODrjppN8YHE/cXISREFL3CKA8dze6RXH2Ctj90bPApE6XZzWdAQrLs21gkc
	c8ztq6cWNEaaoAQkZJZeIAckjcTyqAc2anlV68KOkDyGoECfReegSTIVgEKF0351MJSmnMn6cRyKw
	8bN0APjS7ScOHsU97VfBXU1C5wN618g7nCm/MgzefWMWIj4xgpJd9gxl7uNPTa4f/iVVQJP9dbOb/
	T4gWqlKzUhAvtkS251GQk6wlnt+dlgalil1rxjJIO9cd1P2WyhhyUBjPKvXZm6E4hfC/suF9EYn0P
	yD2kiImw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53874)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1utpNe-000000000iO-1aQM;
	Wed, 03 Sep 2025 16:26:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1utpNb-000000000ds-41F1;
	Wed, 03 Sep 2025 16:26:36 +0100
Date: Wed, 3 Sep 2025 16:26:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 1/2] net: phylink: add lock for serializing
 concurrent pl->phydev writes with resolver
Message-ID: <aLheK_1pYbirLe8R@shell.armlinux.org.uk>
References: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 03, 2025 at 06:23:47PM +0300, Vladimir Oltean wrote:
> @@ -2305,6 +2314,7 @@ void phylink_disconnect_phy(struct phylink *pl)
>  
>  	phy = pl->phydev;
>  	if (phy) {
> +		mutex_lock(&pl->phy_lock);

If we can, I think it would be better to place this a couple of lines
above and move the unlock.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

