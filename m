Return-Path: <netdev+bounces-123854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BADD966B02
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34FCB20AE8
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800A21BD00B;
	Fri, 30 Aug 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m1hF70Ml"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75815C153;
	Fri, 30 Aug 2024 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051321; cv=none; b=QcE73V5jmyrPsrpGNZfTobXWO07nLbHTNO2wX0d6o7rzfGugL75bKwvcXmsw7DqNbsdcU3sBa6fRy+O/kmxuqsGFHYkYP8OqHe0jRLiT5q0/JIn/R3ByMRMfhMgxitBu4SYJzx9KQMsqfYz/yKo6ERqrfg+s5v2y1Otz+hCRWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051321; c=relaxed/simple;
	bh=eRy/T0dM5d9sN8CcvnEOCZI63rDlZpxyYwoxQyXHJs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjaD/XqUBVmhhRh+W4Z0zqxGu8mixCvvRCcAInLMsH2Sclx4S72nV0+tQEdr2zPrqcBY8Az3XnbGAkjucemxthe/qCyB42olKB3poZIMirOR+GqtkbT70u+u4qeP9bKUGYkdnZfnxE2E2XSwxg9gb2XoKOV+qP4pMSZqzJnNhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m1hF70Ml; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZnjFPUJoVaR73vzgtYuu5vl+6599xEYO9CADh+mGU04=; b=m1hF70MlmiFd06xmIyt8t3rrlX
	hm1279LbqcB9jY/f+7anVA6OLU6GZZeSMG0h8ijY9SSWDGEj85PzE6cg6hxcAGf0eOAW3BizzmzU/
	eDT5kzCMQnf0EvXCF0IizH9wjHshLihZDy0EQLjaDQGoJNBdX+JNb3lLukYAFBrkLbis=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8eE-006ACN-71; Fri, 30 Aug 2024 22:55:10 +0200
Date: Fri, 30 Aug 2024 22:55:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux@armlinux.org.uk,
	kuba@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, Bryan.Whitehead@microchip.com,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V4 5/5] net: lan743x: Add support to ethtool
 phylink get and set settings
Message-ID: <9f74455e-45ec-495a-bc8e-1c61caab747c@lunn.ch>
References: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
 <20240829055132.79638-6-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829055132.79638-6-Raju.Lakkaraju@microchip.com>

> @@ -3055,6 +3071,10 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
>  					  cap & FLOW_CTRL_TX,
>  					  cap & FLOW_CTRL_RX);
>  
> +	if (phydev)
> +		lan743x_mac_eee_enable(adapter, phydev->enable_tx_lpi &&
> +				       phydev->eee_enabled);

This is wrong. The documentation says:

/**
 * phy_support_eee - Set initial EEE policy configuration
 * @phydev: Target phy_device struct
 *
 * This function configures the initial policy for Energy Efficient Ethernet
 * (EEE) on the specified PHY device, influencing that EEE capabilities are
 * advertised before the link is established. It should be called during PHY
 * registration by the MAC driver and/or the PHY driver (for SmartEEE PHYs)
 * if MAC supports LPI or PHY is capable to compensate missing LPI functionality
 * of the MAC.
 *
 * The function sets default EEE policy parameters, including preparing the PHY
 * to advertise EEE capabilities based on hardware support.
 *
 * It also sets the expected configuration for Low Power Idle (LPI) in the MAC
 * driver. If the PHY framework determines that both local and remote
 * advertisements support EEE, and the negotiated link mode is compatible with
 * EEE, it will set enable_tx_lpi = true. The MAC driver is expected to act on
 * this setting by enabling the LPI timer if enable_tx_lpi is set.
 */

So you should only be looking at enable_tx_lpi.

Also, do you actually call phy_support_eee() anywhere? I don't see it
in this patch, but maybe it was already there?

   	Adrew

