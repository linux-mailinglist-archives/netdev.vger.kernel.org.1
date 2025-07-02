Return-Path: <netdev+bounces-203252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163ACAF106A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12BDA1899004
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3ED251799;
	Wed,  2 Jul 2025 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hmlYkAu7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6924CEE8
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449490; cv=none; b=HUEqvC/ZkVHTNexPUQITpOKvItNFabhlrTPd9z8yJtU3Nr3v+I11RuoFaIfdnLS1rHuPotjWVB3wVTm8FUubJru0vF+JLD5N24KNn4DbAYomb6wji4lJh825qJ5jaRDEiTltKUBgEmGQSXaSL91g8zhadZjNh/EMYOhj5TV/kSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449490; c=relaxed/simple;
	bh=H3X+tAalFg6xL5vqc5Q7nWUH/kXb6a4Kghua/xziHwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ubiIpmfwqXv3kjKmp8mL2gxLjGFrGPLIS8zfKuYBuVu0z46htCK1fRqf9QXcUe9OHEPV0WVplDf4gKs+Upj4mY51Gwd/5WjRelwOkiXSn72jVAq8T88DFivkpUKSxCXOYzPkJKuMSV3Yxs0RUFcs9eUe5Qx9nUlxG13gFSg3mcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hmlYkAu7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bujz/0okQveJaKmeJriq5TUUq4HkJpp0sZ50YUhfRRk=; b=hmlYkAu7N5uGJhqYFKth8JlpPh
	UVUllVEV9pWlsp7R8QekH761BsCr5/ejZVW6has8I3+VL3v1sO2GQXxIY+8zHNiWZd8trSmg6X6tF
	+mQUHTmXpKy3F+Y9SRpUICKtkhyLfAIA0I1r1BgSru95WbyzBpVoa8pO+9ZkwNLZDXosNhKjyQqNn
	tP28+OtdH6iHxPxXKFVfBQCxvlHah+rvSMaF+7r00GnNboW7eirrtbTL+brhMBGgAz8C5TPZ9v03o
	suPp7C7SrhjaQ0jBVlCojEiybfhR7RQlzQZa1OHNfhFjWn62mvX4Hx/Q4VZIG3Xa0Nxa6tk2jhhmc
	eM59DaDw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42972)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uWu1B-0007O3-0b;
	Wed, 02 Jul 2025 10:44:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uWu18-000403-0f;
	Wed, 02 Jul 2025 10:44:38 +0100
Date: Wed, 2 Jul 2025 10:44:38 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] net: phylink: support !autoneg configuration
 for SFPs
Message-ID: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This series comes from discussion during a patch series that was posted
at the beginning of April, but these patches were never posted (I was
too busy!)

We restrict ->sfp_interfaces to those that the host system supports,
and ensure that ->sfp_interfaces is cleared when a SFP is removed. We
then add phylink_sfp_select_interface_speed() which will select an
appropriate interface from ->sfp_interfaces for the speed, and use that
in our phylink_ethtool_ksettings_set() when a SFP bus is present on a
directly connected host (not with a PHY.)

 drivers/net/phy/phylink.c | 60 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

