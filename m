Return-Path: <netdev+bounces-222303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3191B53CF8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233C21BC2E30
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA29262D14;
	Thu, 11 Sep 2025 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1/RJF5TS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD7825CC74
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621604; cv=none; b=TJYtCT7IUP8TedU2gQ2pZuh09JeoG/34Ntcw5aYiG0Ms/s2XLpKTY/dlqJO73/+cN5jPks89EAaBOvCccmg/Gt9iMiNE804CLNHU6LQH7BltMGiAw+oK23yJvdusm4w6SD466tLjtOhikjWBEjGZOWuaOKxL79IYtCoUt6p1hcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621604; c=relaxed/simple;
	bh=bsmgyExITDhlmj+eqrvj/Ce2zFrsmBqe7eAAbqYhL0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIPXYet43wAeC+f/AVJ0hAWzAIyOeBZNsNl9J9RYaNx7bhS78ZYmaQfcOiN6HgmyQcTxID2TKa3Z89fTu9CXKge3VgleQf3yGLFPEnxm6QvUG37nafSaWbBoMBCkz+2l+Zt54X7s0HKb/2eXRtsa77dwwZZFIZbndBKsM9fUl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1/RJF5TS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iBNkEJ6453e/k/upuAUzQdsjFSNmnsHhE4fvpW5oCAM=; b=1/RJF5TSteM/HV3/VE4XK4Jt53
	oU3DxymSMzWdypl02hneuRzl8UuRnom+QWQ+gGjERkoCjtaaPbQi0aHNgyMnYbC6KO71gzcInMmCl
	5GAXPhFrzcVGVf/1LEX27VwRaDZTLBFsRcAGhtoUoZdBNfHEOiBKDi2jU8EwSaltFPkGgvYaWMGCv
	ubYDe0rQddVCYswNW84WkEuhjrHa5jQ/kFe5zUiuad348ooPrHimz8h1fZmtSS0VAi03ebWgOAqkH
	Yd8rOSMmWMxl37DOm3STkabSRaoL+xH/M3L8uOP81nRKGzr0Yh5sQP37xba7/mOPSvD4JCsrNbRYC
	VBcTcW6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42352)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwnfQ-000000003YP-2T53;
	Thu, 11 Sep 2025 21:13:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwnfP-000000002eu-1d2Y;
	Thu, 11 Sep 2025 21:13:15 +0100
Date: Thu, 11 Sep 2025 21:13:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] of: mdio: warn if deprecated fixed-link
 binding is used
Message-ID: <aMMtW0AlZ6kkjQQh@shell.armlinux.org.uk>
References: <f45308fd-635a-458b-97f6-41e0dc276bfb@gmail.com>
 <5b3bc68c-fb1f-47ab-a6b0-8980c69fe068@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3bc68c-fb1f-47ab-a6b0-8980c69fe068@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 11, 2025 at 09:19:26PM +0200, Heiner Kallweit wrote:
> The array-style fixed-link binding has been marked deprecated for more
> than 10 yrs, but still there's a number of users. Print a warning when
> usage of the deprecated binding is detected.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - use %pOF printk specifier
> ---
>  drivers/net/mdio/of_mdio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
> index d8ca63ed8..24e03f7a6 100644
> --- a/drivers/net/mdio/of_mdio.c
> +++ b/drivers/net/mdio/of_mdio.c
> @@ -447,6 +447,8 @@ int of_phy_register_fixed_link(struct device_node *np)
>  	/* Old binding */
>  	if (of_property_read_u32_array(np, "fixed-link", fixed_link_prop,
>  				       ARRAY_SIZE(fixed_link_prop)) == 0) {
> +		pr_warn_once("%pOF uses deprecated array-style fixed-link binding!",

Ditto.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

