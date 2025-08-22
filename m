Return-Path: <netdev+bounces-216115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96050B32197
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E41AA041AA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D903218CD;
	Fri, 22 Aug 2025 17:38:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10261D88D7;
	Fri, 22 Aug 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884327; cv=none; b=infbmfZNSrLidCgGO/qZo8ob2l3RaVzrn2Kf/zUH9myduVbfvosLp9p+0weUj/QU1xqZ0r7ZE0sjU+tdhvN/qNMymwJ63vho/kvgPl9ZABCygP5rjLjco25E7sq/SmZWQAsklLtyFctsqKCmAm2MoKnmAEKS+ODHJhWbUuRd50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884327; c=relaxed/simple;
	bh=ddQHci5zAQyL5MAfz4E/AWrO0MJG6jsUS31fHG0GCfw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJaGPXgWykLyGCDtK/kJybost5DvTncYOXx4jBapzWmNhO+NbszghYWy1Zo+z0YloWvBgRdhec1lubO9AZnuGHN5A9rLO0DhYfH6DuxW5A96lBCqgevJV1xOTTr/1fkTlpalcJiRIFR4TFzzBx/+y6YJbZg52DHaydwNesfTnwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1upVis-0000000077i-0it1;
	Fri, 22 Aug 2025 17:38:42 +0000
Date: Fri, 22 Aug 2025 18:38:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] net: phy: mxl-86110: fix indentation in struct
 phy_driver
Message-ID: <b9b7336ae309facc5e73874c62e64492fd749cc6.1755884175.git.daniel@makrotopia.org>
References: <58eeefc8c24e06cd2110d3cefbd4236b1a4f44a2.1755884175.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58eeefc8c24e06cd2110d3cefbd4236b1a4f44a2.1755884175.git.daniel@makrotopia.org>

The .led_hw_control_get and .led_hw_control_set ops are indented with
spaces instead of tabs, unlike the rest of the values of the PHY's
struct phy_driver instance.
Use tabs instead of spaces resulting in a uniform indentation style.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v4: no changes
v3: no changes
v2: move this change into a dedicated patch

 drivers/net/phy/mxl-86110.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
index 9ef2a8d7f514..ba25d5b01780 100644
--- a/drivers/net/phy/mxl-86110.c
+++ b/drivers/net/phy/mxl-86110.c
@@ -662,8 +662,8 @@ static struct phy_driver mxl_phy_drvs[] = {
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

