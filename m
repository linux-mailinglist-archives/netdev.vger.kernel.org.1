Return-Path: <netdev+bounces-214379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CCCB2937E
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3893C4E7AAC
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6182E5B38;
	Sun, 17 Aug 2025 14:31:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67062E370B;
	Sun, 17 Aug 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755441102; cv=none; b=KlLA9N+5DPK5+SpOQ6/o8AltpfZEKQO9/b3EJazbiCIid9c/ukLoa+/Tcehw/9ACaxqdlNNRd2bz6ZEhZtduBuqrpfXntYeOB4GkrRUeV2eSE6mkYyJdFcbFiZml6JqA7kfL4CgBryuY7SXNuG98YfjZp4yYBY341BkL+mGtxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755441102; c=relaxed/simple;
	bh=KeUbcjtJj348skm2UmSe4iC825TlrygUJIcmzctHdwY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eDnnPXYH4Byi5k0dWHuee8Aquc6N9k2KmlfBoAD/nHsUl+3eX/6Ihv0tzEr+fBKhNae5Zl2KM83Wbkjq3d1JqGE+fNdZruhkrnnuoUINrLz9z3l+OAshurmYQfdlBTfVRL/buhsVJK5xea/hwZauKLGkYe+cJgrHGoAYYkWgs7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uneQ1-0000000010m-1Jfs;
	Sun, 17 Aug 2025 14:31:33 +0000
Date: Sun, 17 Aug 2025 15:31:30 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: phy: mxl-86110: fix indentation in
 struct phy_driver
Message-ID: <aKHnwkdt8XPhHZrA@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The .led_hw_control_get and .led_hw_control_set ops are indented with
spaces instead of tabs, unlike the rest of the values of the PHY's
struct phy_driver instance.
Use tabs instead of spaces resulting in a uniform indentation style.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/mxl-86110.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
index 31832018655f..47e2fe81842d 100644
--- a/drivers/net/phy/mxl-86110.c
+++ b/drivers/net/phy/mxl-86110.c
@@ -663,8 +663,8 @@ static struct phy_driver mxl_phy_drvs[] = {
 		.set_wol		= mxl86110_set_wol,
 		.led_brightness_set	= mxl86110_led_brightness_set,
 		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
-		.led_hw_control_get     = mxl86110_led_hw_control_get,
-		.led_hw_control_set     = mxl86110_led_hw_control_set,
+		.led_hw_control_get	= mxl86110_led_hw_control_get,
+		.led_hw_control_set	= mxl86110_led_hw_control_set,
 	},
 };
 
-- 
2.50.1

