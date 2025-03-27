Return-Path: <netdev+bounces-177920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1512A72E8A
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78E43B77C2
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2A211474;
	Thu, 27 Mar 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WqKOpCJw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A26211261;
	Thu, 27 Mar 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073659; cv=none; b=KbwbV+dbO3kJAuAQQd5RFoNEmqPfoiI08t9HvHj8YMsbe1QFV+ZrZNdbLTysikTz0kjb8uvfEvIBplfVY9qsV9ZNBpJdGu/QsgO+5qjActVUAB2wx8Rf322PlcyJMEO4v5QCYxmPBoSpPU3REamfSvRpvERj/oO0FDG+eDzKk40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073659; c=relaxed/simple;
	bh=iUwlzKQcSJXS8+bcSJdrfEtFRAl1OnhjN9CsrsWizcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlsZJCOS6KgpudfWyvTgYgoDjjDk7mUP+QIhdFvf8PjA92dA5SHgHq2BeBmKcJUgBA9agfuKbl1JymO+o/der0Ka1YlnCuvZBqnw3HTFwc9hgYiVKd3A4RIyNmbYxDk0U/8eFyb//6OxVTak4Gq582eq+3jnBU065sBPO3NAHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WqKOpCJw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WZqb+6ZduzORjFqfT2budPi5gkMW/3J6mbS3Z4qhKJI=; b=WqKOpCJwUCCRxAWTzc+Zhf8/ag
	qvEPB2pNoyfOnLwCRl4aTnPj2AnLckChSlAsqqOusG7XqUB4i2FOMVXO9hYO7+LfHb0bPjJWiYMyh
	1na9SHYDsUrGTjkVw1T0I3DEwos1Lj8CNB18qpWAh+qIPMr88+5U9/BegR90MxQ/bkhrfhidZ4sKH
	rBQarEIl0lC3f19L9k9nhMnqp6p4GzcZ3TphTWrZbe/nLacCEl98CftWI5Wj6c3THpTiRLuF3whi4
	Tg+U2zaSuNflYbDsSf1pREbhXcVs/Whw4In2gRlw+7/uuAPxT087Lzab9gai4/weVc0boQ0B2bWxV
	3XzYlkvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1txl4z-00078z-0Z;
	Thu, 27 Mar 2025 11:07:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1txl4u-0005Zf-2Q;
	Thu, 27 Mar 2025 11:07:16 +0000
Date: Thu, 27 Mar 2025 11:07:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 1/4] net: phy: pass PHY driver to
 .match_phy_device OP
Message-ID: <Z-UxZMJR7-Hp_7d0@shell.armlinux.org.uk>
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
 <20250326233512.17153-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326233512.17153-2-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 27, 2025 at 12:35:01AM +0100, Christian Marangi wrote:
> Pass PHY driver pointer to .match_phy_device OP in addition to phydev.
> Having access to the PHY driver struct might be useful to check the
> PHY ID of the driver is being matched for in case the PHY ID scanned in
> the phydev is not consistent.
> 
> A scenario for this is a PHY that change PHY ID after a firmware is
> loaded, in such case, the PHY ID stored in PHY device struct is not
> valid anymore and PHY will manually scan the ID in the match_phy_device
> function.
> 
> Having the PHY driver info is also useful for those PHY driver that
> implement multiple simple .match_phy_device OP to match specific MMD PHY
> ID. With this extra info if the parsing logic is the same, the matching
> function can be generalized by using the phy_id in the PHY driver
> instead of hardcoding.
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Please also update the email address in the suggested-by to match the
one in my reviewed-by for the next resend.

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

