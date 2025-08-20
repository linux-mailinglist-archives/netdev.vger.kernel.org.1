Return-Path: <netdev+bounces-215246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94301B2DC27
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63F87263EB
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AE32E7F00;
	Wed, 20 Aug 2025 12:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F818254B09;
	Wed, 20 Aug 2025 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691904; cv=none; b=DIIEz6iOB6iGWgFWNK6aoRp11SIdO8Fg9GGPQMO6ozAyzjz4I3h7MP6ck9Vnfp7UqkhIaOclhl6ZxtD7RhzW/YSNrgZkRwjr/24L3kdRp70zc9DzYe3ijCWmjU+GXqOcWVMn1ONyL9MMgSqoINK3C+fhtPKgyp42cH1uHWp8Oc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691904; c=relaxed/simple;
	bh=9ISIdJqS58fjRYZ7iO3t2cELTLhYvgp3DA+4cKwtmpE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZoVdSDZ6ZJ8djkkWJiEdSDOFmzfu3gNX49aMj4Mar+ecgvWDq/8gKPURoITK2exJWlBdNeJjI8bFd+JXDQ3EP9Fho2glWQJJjlTO7Vj+2jEy+HYWEsECBEf3OxTy2h68qzNsol2Dm9GEyyJDQoaoP2kBvNrq7zx+HEKyd7OPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uohfF-0000000009z-3lze;
	Wed, 20 Aug 2025 12:11:38 +0000
Date: Wed, 20 Aug 2025 13:11:29 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/3] net: phy: mxl-86110: fix indentation in
 struct phy_driver
Message-ID: <5591a3b638c4d42950375781a76e7e7116bf4219.1755691622.git.daniel@makrotopia.org>
References: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63f1487c3d36fc150fa3a920cd3ab19feb9b9f9.1755691622.git.daniel@makrotopia.org>

The .led_hw_control_get and .led_hw_control_set ops are indented with
spaces instead of tabs, unlike the rest of the values of the PHY's
struct phy_driver instance.
Use tabs instead of spaces resulting in a uniform indentation style.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: no changes
v2: move this change into a dedicated patch

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

