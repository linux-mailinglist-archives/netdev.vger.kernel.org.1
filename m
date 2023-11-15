Return-Path: <netdev+bounces-47953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC8E7EC15C
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A45C280F1B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9E0168DC;
	Wed, 15 Nov 2023 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="erUUlA6L"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BF168A2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 11:39:13 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4088CC
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4gQqcD7nW3Sf+fy4qCTuJt2uxJYNJCN9decTfi9tMd0=; b=erUUlA6LDGMaSpW77xxX9swKbF
	XDeAJCA9hXJXNjX3hEM15c173edOmwB8qLaGBQoGuNqsC2LDVTI1eiHSju+//eDWCeUCiT058kiFN
	AUcB34p3HkGgISlugeXWqO5WbHVKFfRZOIog/L8Q93Z4tp/SGbLYCBLi9qy997bwawvjUbsCUFVFL
	qU8SAM1oaAYYPiOuJHingZiCpdCUxM5gXL/egbZAAdl/GPU3X5r1kPLU7KKOeBUHEsQH3g8kMOqjt
	jhxokoaDMQ/b9AHjYPxe73jpuFdivjqQlYsuBLSE3xsaBm6Vo58CIyYgjsOcSA5pyOmS/hr6dZbl1
	WtSE0TSg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34528)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r3EEa-0000Zz-1N;
	Wed, 15 Nov 2023 11:39:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r3EEb-0006Xg-7U; Wed, 15 Nov 2023 11:39:05 +0000
Date: Wed, 15 Nov 2023 11:39:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] Add linkmode_fill, use linkmode_*() in
 phylink/sfp code
Message-ID: <ZVSt2e9Z5swJNf+7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This small series adds a linkmode_fill() op, and uses it in phylink.
The SFP code is also converted to use linkmode_*() ops.

 drivers/net/phy/phylink.c | 4 ++--
 drivers/net/phy/sfp-bus.c | 2 +-
 include/linux/linkmode.h  | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

