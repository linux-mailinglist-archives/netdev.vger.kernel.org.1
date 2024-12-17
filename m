Return-Path: <netdev+bounces-152665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D89F5229
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473B91703B9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C781F890B;
	Tue, 17 Dec 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mh+32zj2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347A1F893C;
	Tue, 17 Dec 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455616; cv=none; b=Nj7zk3Bm65DLre/Tix89S0ESRkBwW63N5eQ+1jwwUnA5MBghEB7kq6bZM9P8Uf9fEYx4vEemMU8JAwBc/BefrUssDHvcQubj2dOZ/+Xc6GSG7Objkdi0kAbwTQ1/kLrEMWh4pkVUmgmWDuzknUyhnkskz8RZeo8ghEdnofGV/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455616; c=relaxed/simple;
	bh=NQIFuZ2w8wBywiVkh0UxxQCB2JhNO2d1k9CVUOotSt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI34xd/7ny5a7cXRc+qRJuq1JZUXCJuVTPCxI0XA+M67Rlo8sc/0dEiaRThANBwqgbkuEfVNkwSmlb7FTxIHN7zirzLxMvrWdhOhK18xe1EFFTUFjuADTz2RVSabyC5uDM3gPap8pH8iflBNz0nStwwHgOYruLrscZ8ikoZRCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mh+32zj2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OwvvlQsYTx0tgG6sjUD5o9s0h+RyVyrmKa+xFxpm5LY=; b=Mh+32zj2yAJ/IVktXG48OACcDL
	YWCy39aEXY10lJo9QiBWR7wgWqhQ/1zNpXAHV/N1KM2FdKndF0RqLnU5QCrHJhEZ1TLn8yZhtLK2G
	bbYY0v6WAj4I2Ltmjs1s+ID3JKCW3doXD7QqXzS3c3m8+D+q3Y+TwmIJQapREioc8EZQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNb8P-00116n-TV; Tue, 17 Dec 2024 18:13:25 +0100
Date: Tue, 17 Dec 2024 18:13:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <1a7513fd-c78f-47de-94d7-757c83e9b94c@lunn.ch>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>

> +static int dp83822_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				      unsigned long rules)
> +{
> +	int mode;
> +
> +	mode = dp83822_led_mode(index, rules);
> +	if (mode < 0)
> +		return mode;
> +
> +	if (index == DP83822_LED_INDEX_LED_0 || index == DP83822_LED_INDEX_COL_GPIO2)
> +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				      MII_DP83822_MLEDCR, DP83822_MLEDCR_CFG,
> +				      FIELD_PREP(DP83822_MLEDCR_CFG, mode));
> +	else if (index == DP83822_LED_INDEX_LED_1_GPIO1)
> +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				      MII_DP83822_LEDCFG1,
> +				      DP83822_LEDCFG1_LED1_CTRL,
> +				      FIELD_PREP(DP83822_LEDCFG1_LED1_CTRL,
> +						 mode));
> +	else
> +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				      MII_DP83822_LEDCFG1,
> +				      DP83822_LEDCFG1_LED3_CTRL,
> +				      FIELD_PREP(DP83822_LEDCFG1_LED3_CTRL,
> +						 mode));

index is taken direct from DT. Somebody might have:

           leds {
                #address-cells = <1>;
                #size-cells = <0>;

                led@42 {
                    reg = <42>;
                    color = <LED_COLOR_ID_WHITE>;
                    function = LED_FUNCTION_LAN;
                    default-state = "keep";
                };
            };

so you should not assume if it is not 0, 1 or 2, then it must be
3. Please always validate index.


    Andrew

---
pw-bot: cr

