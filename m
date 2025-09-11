Return-Path: <netdev+bounces-222302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFB1B53CF7
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE351BC3519
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB4B257820;
	Thu, 11 Sep 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WV+zpExR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284101D9A54
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621588; cv=none; b=qTjzO/AZ76WAEO4zc4rNxMcOvxZnbPZzKq7XUR4H68xUKM+K/VBEZtf54nS5oVOsewCQSR3TPEZFWi8ox5qnCgiWm0/NPcTfAB36yUTstok38/DuXatuEaW7/+u2QhWSHbF+sifMhEEf8kGNIUT9qTirX/mZjmyCitDxIpbeqxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621588; c=relaxed/simple;
	bh=Qomg2fTuFrBLofmYVnGyH+3Pp3BjHNsUM3GjkCM/M+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc/niV3cTl52r64awBbkDyNI8gdKRBWm/idh/9aKBAGWtKY+nbLKftidku2m1b/bPNJLLikXMr6Dylcbs4RUIlFRzNqu++fgUZqHsbMTiJvMzafUo5tZPl+dnybVYRkNMU8XxWxLAIwrkYw1SD0RV7b4jDFmxXCifeXAxJllEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WV+zpExR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QQso3Fy1ouhk1usuIYDLXldUdK7jwDc1j95UUviMUVU=; b=WV+zpExRq82avfi1DW3/0FdUaj
	eONagadz68iYPwq2CvTIbhMB6G/3Rxek+o7C5Yk/UCxJnobPLfbiKpIwPOTfD2zK1abMYV3+EYUyW
	Hnr88qKgruvqXmxpi/naGQ9aUaTDbzmc4GJY4pHJNMxYqMhOzBcQCfQ3uhZd25O0/8CKbkRQwosHH
	7ic/QWKpH9vhnzvKxeQeKP6aW9eH60hXa/7Nomd5PsCbfo867grjkWd/hnNfVxXdgW3hgKuWH2uXo
	1gbG/MZmvPlninsr97Q8U+04haqaxbpxzBh8ubKd0E5hN2ToOYdr8YeLDo3eI5VvtfT9BX8hL7DRB
	PbG0s1QQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58514)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwnf7-000000003YC-2yYj;
	Thu, 11 Sep 2025 21:12:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwnf5-000000002em-1NvA;
	Thu, 11 Sep 2025 21:12:55 +0100
Date: Thu, 11 Sep 2025 21:12:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 2/2] net: phylink: warn if deprecated
 array-style fixed-link binding is used
Message-ID: <aMMtR-Rxv4ZIHqUE@shell.armlinux.org.uk>
References: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
 <3b6ea0f8-6cd2-4a57-92ab-707b71b33992@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6ea0f8-6cd2-4a57-92ab-707b71b33992@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 11, 2025 at 09:20:48PM +0200, Heiner Kallweit wrote:
> The array-style fixed-link binding has been marked deprecated for more
> than 10 yrs, but still there's a number of users. Print a warning when
> usage of the deprecated binding is detected.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - use %pfw printk specifier
> ---
>  drivers/net/phy/phylink.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 1988b7d20..0524dcc1b 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -702,6 +702,9 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>  			return -EINVAL;
>  		}
>  
> +		phylink_warn(pl, "%pfw uses deprecated array-style fixed-link binding!",

\n at the end of a kernel message string is normal.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

