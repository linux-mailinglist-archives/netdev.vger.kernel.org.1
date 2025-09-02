Return-Path: <netdev+bounces-219191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73144B40646
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351C51888A55
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E302DFA3E;
	Tue,  2 Sep 2025 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TpdNDDon"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BF2DAFCA;
	Tue,  2 Sep 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822190; cv=none; b=akNOMvXcV+NC0p3uhnlE96zwBbnGh3D1+5svBFkNabaaRBAA30+hyHJ0RLJ68zmMJ3BrpfAM3NGZl9/XvJqJcoGwSd6RbAw5owkgKVdNeaxzHO2p9JwCPwfF0sa7t4ph0/PL9PoWoYTTqDe6jg+rhVxxazfdurfjdhVIh0XsUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822190; c=relaxed/simple;
	bh=H/cW+LTqVrTEbpC/NOjCOk5rT6x774F3B3uh69487BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWX73/70F+vq9GrTM2juq85nchQfu9RDBlR5YGQ5T9blcERhctT5OI4Fv6yIGQxjVsphsmSkIclZZz1YjTy29KQ+Z9BGW8cUC8K1V/E6Sva2mpv7JyULSBkjxU5O7SRLgzDurZw7j4NEKY61qDzoG7u+7E2ANcRvlzi9tm/nFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TpdNDDon; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b69wlVoTIXKPkRh7Ni7gAalhaMi39nCg5L9jd6Kfgsw=; b=TpdNDDonkbfR9VLsZgsgMoZqf3
	qURvftBMtae/1UzynUQ1U7XwJYYGeTP385czC7sQ9MYdQuZoiTMmXu72aRIstIOhD65d5Y0UrNTi0
	mfSslKJvE3E+9bmJmZxA/QHSaNEUG3C3sMdmY5w+Nr82Emo2PnF0/Ntcfosv8cMoHMlEYzVbzMpg0
	LSVj8Ob9R9oOZl8Eexbi8WbKmx31EGLQzjoBe8u9j/YyU3wFc7La4J1La3pEyLBwKLUVyfiACY/62
	lTfZkkqsSrHZPvPbfeiGoJpFmPpUld6oegPHnCtw8t7GQduh1g51/ExZrR6oiuoDupZW1IQ0O4Jwy
	3mijaq+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53476)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1utRhg-000000007jk-4A9O;
	Tue, 02 Sep 2025 15:09:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1utRhe-0000000082L-3axX;
	Tue, 02 Sep 2025 15:09:42 +0100
Date: Tue, 2 Sep 2025 15:09:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net] net: phy: transfer phy_config_inband() locking
 responsibility to phylink
Message-ID: <aLb6puGVzR29GpPx@shell.armlinux.org.uk>
References: <20250902134141.2430896-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902134141.2430896-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Sep 02, 2025 at 04:41:41PM +0300, Vladimir Oltean wrote:
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index c7f867b361dd..350905928d46 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -1580,10 +1585,13 @@ static void phylink_resolve(struct work_struct *w)
>  {
>  	struct phylink *pl = container_of(w, struct phylink, resolve);
>  	struct phylink_link_state link_state;
> +	struct phy_device *phy = pl->phydev;
>  	bool mac_config = false;
>  	bool retrigger = false;
>  	bool cur_link_state;
>  
> +	if (phy)
> +		mutex_lock(&phy->lock);

I don't think this is safe.

The addition and removal of PHYs is protected by two locks:

1. RTNL, to prevent ethtool operations running concurrently with the
   addition or removal of PHYs.

2. The state_mutex which protects the resolver which doesn't take the
   RTNL.

Given that the RTNL is not held in this path, dereferencing pl->phydev
is unsafe as the PHY may go away (through e.g. SFP module removal)
which means this mutex_lock() may end up operating on free'd memory.

I'm not sure we want to be taking the RTNL on this path.

At the moment, I'm not sure what the solution is here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

