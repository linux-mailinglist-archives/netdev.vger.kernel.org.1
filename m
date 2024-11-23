Return-Path: <netdev+bounces-146898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971159D6962
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 15:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE5A160628
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4F711CA9;
	Sat, 23 Nov 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rCtiiTf3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1636B667
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732370628; cv=none; b=BIwN6wr8Xk9z0awWeQ5taxgkbbEOLdfQ3OPZBxo6y5YitgZnFF1ERLHc82gITPB9SIrfY3rvmTRqGZd9xg8Y2GRUwmlGiG0s2i/xGc/i5aFg4VVRKmguy+KnuLdsogB8kbFevHzcCk11uJ50FqRuaorZ1JAqyDE5q/pJNAG6vxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732370628; c=relaxed/simple;
	bh=SHEuMlJsDLGht/Jrc+kkz/2PbsDyE3iJywqegrV/ZWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZVKQ9gTcGv9jbb1Mtc3vtpV2LGWAqoHxdCTul/PzHM5oBQ8OsCQcJXpWqJQNbWWM5mnfgl9WkWd7P9dpdE4hrvLqU9nvys8HtnC7ijhjxXfjAHxkSvZshKQkTgMZWovjHxl7XOrZ1w7mBEQNv6QrMgsDAJAXaiv8r+4kqtqHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rCtiiTf3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qqzabPGaQwR86bA4seDejR/uclz9D5KMeBEil8HptDA=; b=rCtiiTf3WkK4QsEwZU4uz2L8G3
	hK6CiSacA31AfAhXqZkwTEn5n2RuhwpIy4oGTWbBknvztYpjipUY3A5GL3U3qcS+86U6rM9+QQXVr
	97moszHc+qZlIWxGZ47+gRpL6Bbe6A12ZHt1LYgZQ3cu4En1sg/cAJ54bA1tLyvOXkLe6gvimSPwJ
	rpbtuVF7a1z36k8seL8gMIdGiWCSAuIS6sfVJeMv2Pr8o9XNilIluXflTfZF/7oPGOb8q5HpFWT6K
	B2Fff3tMvcho4gpfNxHmSg2t6b4IXwo02yzIO/thGGgmrwZ5rhU4GKNe4eHWqCr/NLILnvF31ThIa
	Z1ShQfaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54436)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tEqjS-000263-20;
	Sat, 23 Nov 2024 14:03:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tEqjQ-0001dj-0v;
	Sat, 23 Nov 2024 14:03:28 +0000
Date: Sat, 23 Nov 2024 14:03:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
Message-ID: <Z0HgsAJWcJ_JzUxG@shell.armlinux.org.uk>
References: <E1tESfx-004evI-NH@rmk-PC.armlinux.org.uk>
 <f430fb95-362d-4436-8b33-0eebc15333a8@gmail.com>
 <77732422-1675-4e64-a6e5-42e21f2a2caa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77732422-1675-4e64-a6e5-42e21f2a2caa@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 22, 2024 at 09:28:04PM +0100, Heiner Kallweit wrote:
> On 22.11.2024 21:04, Heiner Kallweit wrote:
> > This part collides with a pending patch:
> > https://patchwork.kernel.org/project/netdevbpf/patch/a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com/
> > I think you have to rebase and resubmit once the pending patch has been applied.
> 
> Merge of both changes should result in something like this:
> 
> static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
>                                       const struct eee_config *old_cfg)
> {
>         bool enable_tx_lpi;
> 
>         if (!phydev->link)
>                 return;
> 
>         enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled && phydev->eee_active;
> 
>         if (enable_tx_lpi != old_cfg->tx_lpi_enabled ||
>             phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {
>                 phydev->enable_tx_lpi = false;
>                 phydev->link = false;
>                 phy_link_down(phydev);
>                 phydev->enable_tx_lpi = enable_tx_lpi;
>                 phydev->link = true;
>                 phy_link_up(phydev);
>         }
> }

Thanks for pointing this out - I've now merged your patch into my tree
and rebased on top. Your resolution isn't quite right - the if()
statement should be:

+       if (phydev->enable_tx_lpi != enable_tx_lpi ||
            phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {

Since we only need to bounce the link if the LPI timer or the MAC LPI
enable state has changed. I'll send a replacement patch shortly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

