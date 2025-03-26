Return-Path: <netdev+bounces-177844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA3A720B1
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670A53B918B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6512261396;
	Wed, 26 Mar 2025 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="rqH8yA98";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="TM72ppF0"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219123AE79;
	Wed, 26 Mar 2025 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024101; cv=pass; b=O7PxjmRwXbTzgbf7zjonscdPOSmnUg5bkSvgKdDOxTz9IWzCIlIFnnq5sgeVRkSUl7l8O41fILUpJJARiE6/4AZ5LDL890CUBotc10bDQLrMlwGgWDHMiy2MXNJjoK+3YXN54wKv2KUPXeHNqP0MCQ2b1ucF5ItnJ75LMLOLFR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024101; c=relaxed/simple;
	bh=pWwN1fHpqKDNb8P33HMUlglgT5oRXv79Ga1dRUm3KX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgYY84fhl2tDaNnj/yUsHYaWtUmIInXSpCkVBVuH++WXcmL+yKtVi+BTJNfO2nqizxSpzMsXTB2EUStMU9Hs0bSYWZPvH7aExUV+5ZGCX6Sc3uTbF2fHn0ezJEoLdZx5O7ypBSqL5ZggKJDaKRUZSh3B8sxV99knOZLdzZyPUKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=rqH8yA98; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=TM72ppF0; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1743024090; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IgU6YfFYT1FnmQNQFV4aSMVRJgb6nnSPR2Xt5xLnG/Pc0wTgGdL9gz/rmy75GX+9tv
    Vj/lNbEFcWvaz/FZnyQHXe7WiNVgnU4deKph1xr7A2gSJVZ6DWONs9omd38u816j22z6
    FFCRIK3AysLM/fWMjH1SaDTaDVCkDM27TY877dvbR6Fse7hS3oUqtYxgsuCimnX9MnwA
    vj4/4926uqep36bvJAeszvOVlKVORwzpsBRa6k9Y3EdsiVcss2E1l8KZmoviIA24gTY5
    s0A11wSw4mfjyge6oVeKwhhx4yxvQZxvvEjn//2GUv/lqKrrmpzCaG3i/bZTXloWYUd4
    uMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1743024090;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DRQWVNflVTSKFHFB9UYyJnOIp+l42TmftpYogCcmRdw=;
    b=UCihouW8TeHkbkggDKHdRo5x1YmdvRxWNtiXLmj67IHwYEviOeMuBoJ7sQA+u2XgM+
    ovgknh/Mqs29iSc0YsNCQ7yrrZJEIB3L6DZHgjeSXtXzFsrg4opZO0EvWqWW+OUYH0SZ
    4A5KEihjfYmezxccH7AfBlQIDAVPIeDyjaABV+qSDvZohM6pU15PSRPJqb7SmUuqV3Sf
    Q9Xf+Aza25VvDgsEDyeEzsFoQpFpVkidNfucZ4uuG3R9tKlw5Lq+JGwtqKxzfZtchWWz
    +ZMLb1XmOt1dAxdx7mR7ht1xarPIpF/sWY/x81E0CW7xDlxqR8+dw1pLJIl28kOC6VBb
    6v/A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1743024090;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DRQWVNflVTSKFHFB9UYyJnOIp+l42TmftpYogCcmRdw=;
    b=rqH8yA98e93pKOxJSdvN57PXbZ230fTB25qqwlBbL3i5K6jvH68VkWFV0mqH+9WVsL
    E+XhWuPwklk4HLKvrRaIKkinYKeCNBktwmg20Mok5rX5NAW1XZUCPGvpIMUD188DcBSc
    u2vVuOf4hZyqTi7XIR+MegkEowp060TwlkmN7KH2AJVJOpQ6xij3WFy0BurXnpAcl/DH
    09bK4EZHZ3WXHGd2bxNEk3ijr3AdhiigzvlC5aEX2u5TtepSBvsYUP9d6ZMKUNOeHoG/
    ui9xM5RQYLhW3/oPBp4tL6/hAd9elrf6OoWHccYaXb7hGaoopMxGbdhzrehsyz2FPwrU
    LHDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1743024090;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DRQWVNflVTSKFHFB9UYyJnOIp+l42TmftpYogCcmRdw=;
    b=TM72ppF0Jt4aJodxAr8EVMXDKw32JGbPB4X9EtU0oIESniVfLBqh2M48sKI0AAxKGX
    ryL8Hwwu9HGyHV+pfGAQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512QLLU1Hy
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 26 Mar 2025 22:21:30 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1txYBl-0000hv-0t;
	Wed, 26 Mar 2025 22:21:29 +0100
Received: (nullmailer pid 100268 invoked by uid 502);
	Wed, 26 Mar 2025 21:21:29 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v5 1/4] net: phy: realtek: Group RTL82* macro definitions
Date: Wed, 26 Mar 2025 22:21:22 +0100
Message-Id: <20250326212125.100218-2-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250326212125.100218-1-michael@fossekall.de>
References: <20250326212125.100218-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Group macro definitions by chip number in lexicographic order.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 drivers/net/phy/realtek/realtek_main.c | 30 +++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 893c82479671..b27c0f995e56 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -17,6 +17,15 @@
 
 #include "realtek.h"
 
+#define RTL8201F_ISR				0x1e
+#define RTL8201F_ISR_ANERR			BIT(15)
+#define RTL8201F_ISR_DUPLEX			BIT(13)
+#define RTL8201F_ISR_LINK			BIT(11)
+#define RTL8201F_ISR_MASK			(RTL8201F_ISR_ANERR | \
+						 RTL8201F_ISR_DUPLEX | \
+						 RTL8201F_ISR_LINK)
+#define RTL8201F_IER				0x13
+
 #define RTL821x_PHYSR				0x11
 #define RTL821x_PHYSR_DUPLEX			BIT(13)
 #define RTL821x_PHYSR_SPEED			GENMASK(15, 14)
@@ -31,6 +40,10 @@
 #define RTL821x_EXT_PAGE_SELECT			0x1e
 #define RTL821x_PAGE_SELECT			0x1f
 
+#define RTL8211E_CTRL_DELAY			BIT(13)
+#define RTL8211E_TX_DELAY			BIT(12)
+#define RTL8211E_RX_DELAY			BIT(11)
+
 #define RTL8211F_PHYCR1				0x18
 #define RTL8211F_PHYCR2				0x19
 #define RTL8211F_CLKOUT_EN			BIT(0)
@@ -47,6 +60,8 @@
 #define RTL8211F_LEDCR_MASK			GENMASK(4, 0)
 #define RTL8211F_LEDCR_SHIFT			5
 
+#define RTL8211F_LED_COUNT			3
+
 #define RTL8211F_TX_DELAY			BIT(8)
 #define RTL8211F_RX_DELAY			BIT(3)
 
@@ -54,19 +69,6 @@
 #define RTL8211F_ALDPS_ENABLE			BIT(2)
 #define RTL8211F_ALDPS_XTAL_OFF			BIT(12)
 
-#define RTL8211E_CTRL_DELAY			BIT(13)
-#define RTL8211E_TX_DELAY			BIT(12)
-#define RTL8211E_RX_DELAY			BIT(11)
-
-#define RTL8201F_ISR				0x1e
-#define RTL8201F_ISR_ANERR			BIT(15)
-#define RTL8201F_ISR_DUPLEX			BIT(13)
-#define RTL8201F_ISR_LINK			BIT(11)
-#define RTL8201F_ISR_MASK			(RTL8201F_ISR_ANERR | \
-						 RTL8201F_ISR_DUPLEX | \
-						 RTL8201F_ISR_LINK)
-#define RTL8201F_IER				0x13
-
 #define RTL822X_VND1_SERDES_OPTION			0x697a
 #define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
 #define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
@@ -112,8 +114,6 @@
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 
-#define RTL8211F_LED_COUNT			3
-
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
 MODULE_LICENSE("GPL");
-- 
2.39.5


