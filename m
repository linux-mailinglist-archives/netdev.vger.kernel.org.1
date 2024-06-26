Return-Path: <netdev+bounces-106744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D00191769B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 05:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7E51F22E31
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA6522EFB;
	Wed, 26 Jun 2024 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Np+kSYra"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4CF14AB2;
	Wed, 26 Jun 2024 03:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371213; cv=none; b=bz1eAbv1zlseWEalMXCyE1gAQv7hx9CIGqEtzw+/qDVhCZGQSfN8d3Enbyxlx6/5i9xEKuln2FaNKUOEWW+hMybauiXC4lsPOiyhwj4Fr2SbyzxmihvIfYW+XgfE2IENR+QNqGg8oMvYCL758boXjWjwlY51GEsiVcQZmVx2yis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371213; c=relaxed/simple;
	bh=u+tIap+eprn6eWlri7ixrb6IeHRzQCXib9N66LPcxPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4y3PQGntveDhsrbb2OUDJp6qEJM+dOWahVm9lM9f3UGJE4/RdjCzHNUhf6RwT1LJrfkBlUZeqOsh30k8E7X7d/9k7QcfRO0G7bFlr4KbTsAe+UNJWxAOaCPYlAciEagOvlDOuHK7xLhirRsdZFNVeExwTuLJ1yeOTXqkBexkD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Np+kSYra; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0D03F87F64;
	Wed, 26 Jun 2024 05:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719371209;
	bh=ZrXR2colZ+wepO5VfYnztVKwTpljRf4TuW6QZVMpQlk=;
	h=From:To:Cc:Subject:Date:From;
	b=Np+kSYraSlxhJ3icxo3yNJAG6LKlWYZ6922lpbi+nXutcqgtkJHMfnPxu4fFhOXvq
	 cMHDAlU/q+xYiIFVvVWqgDWrTYtBcGdx1cMOaIFZnnFYo+wUo03eUkwPti37cXQBee
	 Mjk4DSCxg68M7uNwTG+IC84FAj+FLVpU/5PTpaUxsrLmma+jhE3qx930rRjB+aui5l
	 ikbFqfgETZE4bkw1E1PhVzplJNPjvfipY3DdSFR9w+Scqy5gxV+82kg4LIerGLn2Se
	 1DeMFpOdsefO02mDLDAoLrKBa+BSQq88bsuIQ1RQPCsGYCY6CjIhiEmGY/zNDMBTOX
	 Fg5rf6I7jSDyg==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: phy_device: Fix PHY LED blinking code comment
Date: Wed, 26 Jun 2024 05:06:17 +0200
Message-ID: <20240626030638.512069-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Fix copy-paste error in the code comment. The code refers to
LED blinking configuration, not brightness configuration. It
was likely copied from comment above this one which does
refer to brightness configuration.

Fixes: 4e901018432e ("net: phy: phy_device: Call into the PHY driver to set LED blinking")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 205fccfc0f60a..bd68f9d8e74f1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1119,21 +1119,21 @@ struct phy_driver {
 	/**
 	 * @led_brightness_set: Set a PHY LED brightness. Index
 	 * indicates which of the PHYs led should be set. Value
 	 * follows the standard LED class meaning, e.g. LED_OFF,
 	 * LED_HALF, LED_FULL.
 	 */
 	int (*led_brightness_set)(struct phy_device *dev,
 				  u8 index, enum led_brightness value);
 
 	/**
-	 * @led_blink_set: Set a PHY LED brightness.  Index indicates
+	 * @led_blink_set: Set a PHY LED blinking.  Index indicates
 	 * which of the PHYs led should be configured to blink. Delays
 	 * are in milliseconds and if both are zero then a sensible
 	 * default should be chosen.  The call should adjust the
 	 * timings in that case and if it can't match the values
 	 * specified exactly.
 	 */
 	int (*led_blink_set)(struct phy_device *dev, u8 index,
 			     unsigned long *delay_on,
 			     unsigned long *delay_off);
 	/**
-- 
2.43.0


