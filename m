Return-Path: <netdev+bounces-174666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D8BA5FC66
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 17:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6333170CF1
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1264614D29B;
	Thu, 13 Mar 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="texTlXAJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BE2E3390;
	Thu, 13 Mar 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884320; cv=none; b=k/wHzVmZMhl2HTcHnFCjEkJ1rRhk/yWTHywLN/Q3YIjr+KRg+qnrIJtQhnM1QfQND5wi/v/xWzIHsdH65Oyb2bFKR+X8f2Rig8h7FztKeUc7Pl+WdgtXwCCRZvJWhuj+Jw+7OhCugST4Zzytf+SZ4Lh897K7TgByPaUi4jsiB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884320; c=relaxed/simple;
	bh=yXFfDtMWoUYUT3rVGeMfA0Hqrwa2RdSN4+ar6+obYrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G55XbOyRagYtnq//85xHNObFZKxJEHGmrrTXjrPfeUaxmsDrTIBle5qhkt31wRn9itS2pvpCCxLlkwzTE5FlLcYUwlB3GnW2vQphWQzqSn436VKw+21m8bTIBkZCkBdQo/MxiQ+uY1SLmataRxyWDPy7qGF4W02R5OOQYByhHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=texTlXAJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pUaSCl3nFYcy99ntWez+f1XirECJo6Y3EAASNBcW508=; b=texTlXAJn8X+d7N+m+hSLXLLzg
	k5COVHPdihiLw0PO5iIp7gruWR24db/2JiiBmCqIT6p4rZyaVv2pwWDsKE9qBNjMm9BYEOiHbVuqc
	PB5qghhq+UFe1CymupUHCHrKP61q/Kf1F2fHUpAnOj6c5d+waCVOxV0DXv5NV03SIk6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tslg9-0052uA-NV; Thu, 13 Mar 2025 17:45:05 +0100
Date: Thu, 13 Mar 2025 17:45:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Klein <michael@fossekall.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: phy: realtek: Add support for PHY LEDs on
 RTL8211E
Message-ID: <e62af3a7-c228-4523-a1fb-330f4f96f28c@lunn.ch>
References: <20250312193629.85417-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312193629.85417-1-michael@fossekall.de>

On Wed, Mar 12, 2025 at 08:36:27PM +0100, Michael Klein wrote:
> Like the RTL8211F, the RTL8211E PHY supports up to three LEDs.
> Add netdev trigger support for them, too.
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  drivers/net/phy/realtek.c | 120 ++++++++++++++++++++++++++++++++++++--

What tree is this based on?

ommit 1416a9b2ba710d31954131c06d46f298e340aa2c
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Sat Jan 11 21:50:19 2025 +0100

    net: phy: move realtek PHY driver to its own subdirectory
    
    In preparation of adding a source file with hwmon support, move the
    Realtek PHY driver to its own subdirectory and rename realtek.c to
    realtek_main.c.


https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> +static int rtl8211e_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				       unsigned long *rules)
> +{
> +	int oldpage, ret;
> +	u16 cr1, cr2;
> +
> +	if (index >= RTL8211x_LED_COUNT)
> +		return -EINVAL;
> +
> +	oldpage = phy_select_page(phydev, 0x7);
> +	if (oldpage < 0)
> +		goto err_restore_page;
> +
> +	ret = __phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0x2c);
> +	if (ret)
> +		goto err_restore_page;

What is happening here? You select page 0x7, and then use
RTL821x_EXT_PAGE_SELECT to select 0x2c? Does this hardware have pages
within pages?

       Andrew

