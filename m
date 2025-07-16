Return-Path: <netdev+bounces-207437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B5B07408
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE30D5056E0
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FF72F2C68;
	Wed, 16 Jul 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1RBl8pnW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC22F2C6C;
	Wed, 16 Jul 2025 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663265; cv=none; b=nya1h738PH90EnnxasqOG4dlC3Tcma9WHzU6PN+urAgeaTtR3YKcGJ9CK4vvBad+K2Frq7sCI/sJ+no8C/GV3QaSvl6FziJKOS2fHTaEO284koZPmtYMCB/F/CJPlsLKeCoRjWWN3adA3eBWJ8MXJWjelXiehNuazcmDLSHTZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663265; c=relaxed/simple;
	bh=Jpo/w3Y0pLV48VjMrLa56ULMc2rwOLRNVxZlakLbVAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EV62pWqz4SHcCjHpY+avLxr6nafarm3r2wVr23wSwrI7qStnZnjLXMsPFkb8IhJ6dmWyNDcQbJJEqQnK85jwG/vutv9n0LHusdBoRRe64w/9LlfVVnhgJGFHJWoJwrn9HJMtg/bCyxX7zcwaZd6VlhW0n3XvYs0usYY816VFdbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1RBl8pnW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/tYfH7yK29tm+Hz7CmxspQzKrDsfZDUrPmEIVZoOY6k=; b=1RBl8pnWbw3cO/+j7mUlL9sUDs
	olb2QFH+5gTCqCbpE+TD5yG7BeLWWvxsGV4OXyfNW9frQK9dyv+yn+BwGL7p20AT73eLoJvpqYK/k
	RRosjYFUxL1aPHYzd6pGb7lO36wMMA7l0M5RzwemXCI2CjtxY3rW0nogiPtPIZTrgtHGI+VPwmf46
	Eq+AdgqebtvOhtM4CuRff+HhGHwIBktOwWpIPFzKS59VYJpDp4ST5ldAn5Cp7kHdZ3KTTbgw8GOWE
	RaUQ3YC6eXILBDFHz7dQAiGpVaCewSFbxJ8sZYJqIVQ1DM0HPeFFnv3roHjetWW/LfmWy9SBqFaD4
	rHM+lCsw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46912)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ubzlt-0007xj-2F;
	Wed, 16 Jul 2025 11:53:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ubzlp-000149-10;
	Wed, 16 Jul 2025 11:53:53 +0100
Date: Wed, 16 Jul 2025 11:53:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: hibmcge: Add support for PHY LEDs on
 YT8521
Message-ID: <aHeEwZaqUd0kNdUQ@shell.armlinux.org.uk>
References: <20250716100041.2833168-1-shaojijie@huawei.com>
 <20250716100041.2833168-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716100041.2833168-3-shaojijie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 16, 2025 at 06:00:41PM +0800, Jijie Shao wrote:
> hibmcge is a PCIE EP device, and its controller is
> not on the board. And board uses ACPI not DTS
> to create the device tree.
> 
> So, this makes it impossible to add a "reg" property(used in of_phy_led())
> for hibmcge. Therefore, the PHY_LED framework cannot be used directly.

It would be better to find a way to solve this problem, rather than
we end up with every ethernet driver having its own LED code. Each
driver having its own LED code simply won't scale for over-worked
kernel maintainers.

Sorry, but NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

