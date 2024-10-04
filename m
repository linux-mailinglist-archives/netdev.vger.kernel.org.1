Return-Path: <netdev+bounces-132125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF4990858
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBCBC1F219CB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE6C1DAC83;
	Fri,  4 Oct 2024 15:56:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629F1DAC80;
	Fri,  4 Oct 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057408; cv=none; b=gY9xbzLAL0YSDznmSAcOeNmwKnG5kBwvQ6B56tmmJkYjTMIfiKCKgFebIi0Lyag2Pk0tuZkZXgsaTXQlXKHxPeUtMdepTouclhvC2WN3FxL37JrL6dLShbrORyAxLHZ9mjiVAFSQ5QXu07gR+xFZte5VG+5EaXATt8I6PhBfgqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057408; c=relaxed/simple;
	bh=um+QDH7sgjmz+IlxAZXNHu0dywaWN03s9cyWnMxV+0g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aEpN7vfshreQym4SEBw5qkODlhddtT/rJ++JI2NG6RBoUs2Mn1A5TJwIBM89GnZy2k3DjbE4O88fwb2IeKITxE8brlfh6YprEwzDFHhfpqM3RA6XJYPOX9hcDs4XLDTcxXYseIAeRBHAGiIgLEWlRRTrmp3kjQnm48CyhDs8wQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1swkfZ-000000008Ju-1pQL;
	Fri, 04 Oct 2024 15:56:41 +0000
Date: Fri, 4 Oct 2024 16:56:35 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: mxl-gpy: add missing support for
 TRIGGER_NETDEV_LINK_10
Message-ID: <cc5da0a989af8b0d49d823656d88053c4de2ab98.1728057367.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The PHY also support 10MBit/s links as well as the corresponding link
indication trigger to be offloaded. Add TRIGGER_NETDEV_LINK_10 to the
supported triggers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-gpy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 6279f88c4979..1c9cd00c7bee 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -897,6 +897,7 @@ static int gpy_led_brightness_set(struct phy_device *phydev,
 }
 
 static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_LINK) |
+						 BIT(TRIGGER_NETDEV_LINK_10) |
 						 BIT(TRIGGER_NETDEV_LINK_100) |
 						 BIT(TRIGGER_NETDEV_LINK_1000) |
 						 BIT(TRIGGER_NETDEV_LINK_2500) |
-- 
2.46.2


