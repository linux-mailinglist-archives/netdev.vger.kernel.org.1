Return-Path: <netdev+bounces-180117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A420A7FA45
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EB0171C53
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE44E265CC4;
	Tue,  8 Apr 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yY0X+bly"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237B264A90;
	Tue,  8 Apr 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105791; cv=none; b=qsTWT8JN8w/8q4lZswMEaKCKSShRY2Uf3e4Byw2gsiihOUB6BuYg1+nMiHwF+ZDxkqT2Iomv7g3UpHZqNnK/fOhVyRAPe2u36G9YZqMX1NeyO5QmOr4Yoiq7N8gFFtETXQFPQxGWDkTyxie9DE5/yAJP5ABiDAStL0Yh53FWM5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105791; c=relaxed/simple;
	bh=bFCnm0GdpJ+8/3SW70uX/rfhSQ34AaKkttnigv8qhE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZid47tF2RMd6GeQJ9tG0K/PwuCCqdcprQz973CSrS60xwwJ75yqEqzQ6UXJ9pOz38yxsQnvsoMuBzaHrcwTZ8GCQgSAWuXmrg8ixZ2rRQYKCHSefQY8TIQ04i6WbsJOJ5iaxof2O1NpoAXP9FWWYbae8k6PBfaoDmX1X6ijHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yY0X+bly; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yNuzb0y3T0Wr9cRTZpqL81gOwuVIgxYtUC+nntQrY6g=; b=yY0X+blypVlqRanJe9AmzqVx+t
	JWcrcd3vYieIy/0O4hHwUoYk9NkjROSPRA5cABgJEbwmyAELET7XOLRFidk44K2hYU3dx/iHazCzs
	RlS+JfOYwfXteVUYGlJWF1NP5jvm4Lj0Xq1Cau4Qwxk3X9Gt4uJLyuANZaPowzZFIkIyqtlXe7yvP
	4zc+IYBvvOMexkFQDu+SMn2dc+1AQRCMrHKD68Ze+S2CkJNvSoK+CS8soDYO7y5YpZnRi6tX2RZr3
	adFICd3IG+tT8XIi9kAazsJGJqPQrTLAwIgzVahoSsIE4W+wLQqj5RKPiAoe3j8Ts5Z+2b/8Oj21X
	1lT/yZag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57402)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u25aH-00075W-1p;
	Tue, 08 Apr 2025 10:49:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u25aD-0001K4-2M;
	Tue, 08 Apr 2025 10:49:29 +0100
Date: Tue, 8 Apr 2025 10:49:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for
 changing the MAC termination
Message-ID: <Z_TxKajbkVFOdPvq@shell.armlinux.org.uk>
References: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
 <20250408-dp83822-mac-impedance-v2-3-fefeba4a9804@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-dp83822-mac-impedance-v2-3-fefeba4a9804@liebherr.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 08, 2025 at 09:45:34AM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> The dp83822 provides the possibility to set the resistance value of the
> the MAC termination. Modifying the resistance to an appropriate value can
> reduce signal reflections and therefore improve signal quality.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

