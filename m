Return-Path: <netdev+bounces-229310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ABFBDA6E5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 848B9508EB2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21D313539;
	Tue, 14 Oct 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nfzFH+ti"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE03112BE;
	Tue, 14 Oct 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455573; cv=none; b=XSuUtbgbjNhsYipw1H1f/5C3eK0Cg30Lae6gAvS314/g4P+njcVn67UzABseVdKNXnXqe0H4GCIP76d8ZT+NSIIEALlnop3rgimWWOaqk9rKEEXG2Is2FVUdBpDBhQRP8rERDfWou73ZdhnCewQ6X02CHLYVd5UXseX751n+7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455573; c=relaxed/simple;
	bh=daqNnbJvOoWaZMt1KagjYQgQlBMZN4Rtv7ePvENPDp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SViSQfetVpgvY22Mh5GIXkWtFh2PtiS28+V1aW1JWr1B+OYaDzSYl1ZiSaoVBbXmNma+iRb7DxAUaWwqztmfRbzZMYS3/v8RJpG/WohACl20Fb5VzIkKyJ1uK/ltvV9IpA0PRexfgntLsot8CginAStmP8wk1dj3QIusyWYgPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nfzFH+ti; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 01D881A1382;
	Tue, 14 Oct 2025 15:26:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CC4DB606EC;
	Tue, 14 Oct 2025 15:26:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CE52102F22B2;
	Tue, 14 Oct 2025 17:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455568; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=M1AcoK2TtczTj+DPA0wk10MM2f8FjIDLYFnHi82ybDI=;
	b=nfzFH+tiTS1caP5GYUvZffzR4NS+kRhsxtGYe8hIvU8gCVN1rWXZwCKfyOm5+EwNVaY5qH
	bWgf1C0699/iUqQGrv3LOo4sJBOL29X7WKBuKeFoxAYEObh6Z5YovLMkrM7y2QOuug5XdD
	dSY4VHqchJxZMeNASPmelRn6Yi4/rozOEsrEslFCYOQw57ZY3B1gIHqGMQh+YEjOuT13rf
	gfBifnDHon4O2Yi2rzEj0wSprpFNdoEF3lAE9S4+3zBlv7Xngys2whMCOs2sAe3OsII4UT
	SOj9Ki7JZKw5Fon2AmNiYTqO6nhw9iN5SzWtI3p72MdtnD+5g4e+hhQ94bufQw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:16 +0200
Subject: [PATCH net-next 15/15] net: macb: sort #includes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-15-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Sort #include preprocessor directives.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 37 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e15fcdd43d778c685dbb927386904362b8dba8b9..214f543af3b8fd4230d2be8095b26c3915dd9cfb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6,36 +6,37 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#include <linux/clk.h>
+#include <linux/circ_buf.h>
 #include <linux/clk-provider.h>
+#include <linux/clk.h>
 #include <linux/crc32.h>
+#include <linux/dma-mapping.h>
+#include <linux/etherdevice.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/inetdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ip.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/circ_buf.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
 #include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-#include <linux/phylink.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
-#include <linux/ip.h>
-#include <linux/udp.h>
-#include <linux/tcp.h>
-#include <linux/iopoll.h>
 #include <linux/phy/phy.h>
+#include <linux/phylink.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/ptp_classify.h>
 #include <linux/reset.h>
-#include <linux/firmware/xlnx-zynqmp.h>
-#include <linux/inetdevice.h>
+#include <linux/slab.h>
+#include <linux/tcp.h>
+#include <linux/types.h>
+#include <linux/udp.h>
 #include <net/pkt_sched.h>
 #include "macb.h"
 

-- 
2.51.0


