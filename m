Return-Path: <netdev+bounces-212482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85540B20D07
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D782A3139
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F12DEA7E;
	Mon, 11 Aug 2025 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0E29eYqX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786D2DFA46;
	Mon, 11 Aug 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924572; cv=none; b=CzgJ113AqPDQLnX+VPxvA6DJwv76Z4pcc5RitslY/jmirBl5ZueQFmKl+Hixdr82D2hDhDgpawfQ4MXktGuvoDej4Lo4DUT+BMdygk5vMkc3Rs9kW2G2IvtSbSZ5tcGgtwgwUgt+qXerQwZJmkAzO6K3XTTmxFoCFMBsZzKlUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924572; c=relaxed/simple;
	bh=e/p54uWOp+0aPODcNitVWt2JrT9F6fOffEf9xNUvB+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHTinLxphtr+HJ3rIpm7RLXz1b2rtAP9X0jSbQ+us/1ngPdDgCAghMo4KcyMYlA6OBuSw0rrHZrw2lwFMOV3/gCGuYC+fuOCaj3wAkmK9MwOQzaBXM8Ikh3RHjf7II2LBw3FdHzjAgVlNkhdmhneuoU7vrGQlr5lY9P/Dqz4BmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0E29eYqX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5aOWOcqPqE2rZ4m0l7Xjh7QyXcqH1veSo9zVpsUF7EI=; b=0E29eYqXFLy/QCyEmnThJLyb7x
	d8aUpLSMu29XmScPpBPSx3BbepO8NRI83ExpWnYiDSVMR3lkBHV1QEsJEvxsjsnARHHwWtC4QC+Bq
	cOC/7n1eI3df41sZJ5ITH0RQkQBLIpcBR8RopmY/r2iI/PENs+LHe0fZBoC0r7mhHGkBLmWNk24Mn
	p4Td5w50FT2HNg6WHx7fo//ajoth7bYRILP9O8QU7Uvx/aLIkijU4bKWnx9nJ327Th/vUCwvK5mWZ
	SzKevRzUPKxiVp26nd161/hjE/HRoFMoizA0p/NL/WYHy6KlLdYBSWlHyGE4CeFKgXJ0YNRAvh/6C
	S1MgcoDQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45626)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ulU1c-00037H-2N;
	Mon, 11 Aug 2025 16:01:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ulU1V-0003ms-1W;
	Mon, 11 Aug 2025 16:01:17 +0100
Date: Mon, 11 Aug 2025 16:01:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, Frank.Sae@motor-comm.com,
	hkallweit1@gmail.com, shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: phy: motorcomm: Add support for PHY
 LEDs on YT8521
Message-ID: <aJoFvcICOXhuZ8-q@shell.armlinux.org.uk>
References: <20250716100041.2833168-1-shaojijie@huawei.com>
 <20250716100041.2833168-2-shaojijie@huawei.com>
 <7978337.lvqk35OSZv@diego>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7978337.lvqk35OSZv@diego>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 07, 2025 at 11:50:06AM +0200, Heiko Stübner wrote:
> > +static int yt8521_led_hw_control_get(struct phy_device *phydev, u8 index,
> > +				     unsigned long *rules)
> > +{
> > +	int val;
> > +
> > +	if (index >= YT8521_MAX_LEDS)
> > +		return -EINVAL;
> > +
> > +	val = ytphy_read_ext(phydev, YT8521_LED0_CFG_REG + index);
> > +	if (val < 0)
> > +		return val;
> > +
> > +	if (val & YT8521_LED_TXACT_BLK_EN)
> > +		set_bit(TRIGGER_NETDEV_TX, rules);
> > +
> > +	if (val & YT8521_LED_RXACT_BLK_EN)
> > +		set_bit(TRIGGER_NETDEV_RX, rules);
> > +
> > +	if (val & YT8521_LED_FDX_ON_EN)
> > +		set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
> > +
> > +	if (val & YT8521_LED_HDX_ON_EN)
> > +		set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
> > +
> > +	if (val & YT8521_LED_GT_ON_EN)
> > +		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
> > +
> > +	if (val & YT8521_LED_HT_ON_EN)
> > +		set_bit(TRIGGER_NETDEV_LINK_100, rules);
> > +
> > +	if (val & YT8521_LED_BT_ON_EN)
> > +		set_bit(TRIGGER_NETDEV_LINK_10, rules);

Sorry, I don't have the original to hand.

Please use __set_bit() where the more expensive atomic operation that
set_bit() gives is not necessary.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

