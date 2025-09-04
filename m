Return-Path: <netdev+bounces-219913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E8B43AF1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330C717CE12
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E2321FF30;
	Thu,  4 Sep 2025 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="spt0oYf5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432EC2CCC0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987395; cv=none; b=sRS1BrLFMX6QmScMp7K+ycwrmfjRuKiRrdQxHy81Dq65gnO6Xs9XG6kptA7HgitBq9w6HiU+ZtrHtsjl2wQboSlyy2p6ATQ17Ha1gCWRI+p0C3w+pvmbeuU/UqY2R4o6DLO/0u1UfFsgFd5ZCsQBlQIuiZ5iIBJFMaeRRaQBH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987395; c=relaxed/simple;
	bh=i9UfGhOa1iW6DEC8AylfBO6/un5P7OWz3kUwkmHbDzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3C3heNpCArxXx5zM07Hvv04V1iSSSqqlHyXghyQ8bvDVXFeDn46qaRjaeeCv3LZy8zdE+pErbqJNj/4X2r5nn4SSnrSQrQRWIA5bDxeEoz/V+ywrk0yvXgGIFHzBhHhLqegfUenNwsFUTR++18srRtP/WryR5t4HWaLGU3A8gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=spt0oYf5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=efota9LAqPgpAyhwmboBsEVa/ikLGxRZyQvGJOkdEI0=; b=spt0oYf5iazE/A7Thhr+XrXH8d
	Z5CP9ZTJqA4iKHrjqzk3s+72AdRkaXFK5lQ6rWcXetHUnOS8Jj3A2ZjLTpGxmYayjF7r4/gyq3I82
	zXHWP4VVsoUVPcc4YO16xvSxTLPQlqiGG0BnxiyNO44NZ4y9wBqSdMnGt2ZtYiOayspfT5KzTWAyw
	tFyPlgIBoTqwLhVdUXba34EIDFqayb+c0IWgT5xb/woG5QRGOTnyeduxpS3Kw1b6Gze/6p7qiGhKQ
	VEDhUNUQhOhntM9gdufpsdla51i30ONZhyKd/VP2OArHUVC6EoNjPPMnyO9+x2Y3+1RJNi0OdwOua
	810RSivQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47270)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uu8gB-000000001wF-2xmY;
	Thu, 04 Sep 2025 13:03:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uu8g9-000000001VK-0vi2;
	Thu, 04 Sep 2025 13:03:01 +0100
Date: Thu, 4 Sep 2025 13:03:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v3 net-next] net: phy: fixed_phy: remove link gpio support
Message-ID: <aLl_9UvW84gurxCg@shell.armlinux.org.uk>
References: <75295a9a-e162-432c-ba9f-5d3125078788@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75295a9a-e162-432c-ba9f-5d3125078788@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 04, 2025 at 08:08:18AM +0200, Heiner Kallweit wrote:
> The only user of fixed_phy gpio functionality was here:
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
> Support for the switch on this board was migrated to phylink
> (DSA - mv88e6xxx) years ago, so the functionality is unused now.
> Therefore remove it.
> 
> Note: There is a very small risk that there's out-of-tree users
> who use link gpio with a switch chip not handled by DSA.
> However we care about in-tree device trees only.
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

