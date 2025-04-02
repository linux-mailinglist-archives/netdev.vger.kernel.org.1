Return-Path: <netdev+bounces-178861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1A3A79395
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E1A3AFB4E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0E618732B;
	Wed,  2 Apr 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Id8tlO4+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DED199FA2
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613389; cv=none; b=BzVBjA2iEmpjsqFwNJwNIfEQQhFPhwzIP0mRBHm5bKF5oWuyylLdjIx+stPGWFL/K64JhYOs4I0Aen80fkRcxWcCHcPtZtQnI8NWLjQ1lxq9I7eWIKIRVjxECFy+pkXDXm2xZ0lczQEJ6b6Vk6sK6TePfH3EurrjXSmNeed4CHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613389; c=relaxed/simple;
	bh=XpnxqARefrz0ZlGwM/4n8sz9qdFvUpEih2I9i1mPuZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz45yKaWYS3YQvnlGqiukV1qphdl+2WRfOvDmIunW17YjrudBlyfqCKCSP5Tzu0A5syI2g724EylAR3k2nCa0PnnNcn9YgK9s2805QVtl5ptCx3WaSx7FrJ2R/9T3abPLc8otPEFynx5Gri0k4mFbeoJw+kPfuB+76t1tIy0p4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Id8tlO4+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y5t986op0u8yQvI3s0g+XhnyTuCqWkXVsYY33px580c=; b=Id8tlO4+dCTTixpQfuQfc78kM8
	IWx3jFaXKKSciyy64Ytp39lxblwex6/jXysLkui62awgZes19IgmnKTlnYbbOK2rQghx++tU3YjFT
	MEmdM/myHjIU+bJLd5GXWZL1TzeaND5zXj8uJyaLtsZ4RDP1Iy0rtbKa1y+Azz0aErvKJQX48SFwP
	UaJi3eo72fL8NORxMxIwzFE6NhC7bdLa3HhM5j0grUtO6qn4nK3P0GxFeM3hMSUqtNOt7tcvsCJVB
	WfPgijqkCQTfcsMnj2sAP/48T3atRx2f1LFNyjnSbYZdu88QFsTvFkgTUosUfhiagzBSAdaFkKCe0
	cl2GeqKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50636)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u01UV-0007vi-1v;
	Wed, 02 Apr 2025 18:03:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u01UU-0003ru-12;
	Wed, 02 Apr 2025 18:03:02 +0100
Date: Wed, 2 Apr 2025 18:03:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH v2 net 1/2] net: phy: move phy_link_change() prior to
 mdio_bus_phy_may_suspend()
Message-ID: <Z-1txga-muXcuqDU@shell.armlinux.org.uk>
References: <20250402150859.1365568-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402150859.1365568-1-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 02, 2025 at 06:08:58PM +0300, Vladimir Oltean wrote:
> In an upcoming change, mdio_bus_phy_may_suspend() will need to
> distinguish a phylib-based PHY client from a phylink PHY client.
> For that, it will need to compare the phydev->phy_link_change() function
> pointer with the eponymous phy_link_change() provided by phylib.
> 
> To avoid forward function declarations, the default PHY link state
> change method should be moved upwards. There is no functional change
> associated with this patch, it is only to reduce the noise from a real
> bug fix.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

