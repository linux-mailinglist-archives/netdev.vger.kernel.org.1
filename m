Return-Path: <netdev+bounces-179845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002DEA7EC03
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A3A17ADF0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8323A56B;
	Mon,  7 Apr 2025 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="VPPzyJxC";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="mH0hK0/h"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CEC230BE5;
	Mon,  7 Apr 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050149; cv=pass; b=NamjCACoUWV1JFsyGL1w3bJz4U2pJjuq1KQOaBFT/t6FmumNCClNhcf7NgJ2hdjKRdGvupbV0q4EPpQ/CE+vTk2DLY0K/w+RalEXUPj7xnHHDG8voniQBl6+Z1Be08cndphF+Tm7qpFPa7gtljvnOpF2i1F3D4WNCauHpEe0V+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050149; c=relaxed/simple;
	bh=pWwN1fHpqKDNb8P33HMUlglgT5oRXv79Ga1dRUm3KX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sATMnGsOnDAFNrZiu2KodCLU5y/jWIii8uY2+NtWD8yH/1f5eyKMTS3pbZ45xmlSbpZp4/kITMJ1BgIew/oeg3WAS+WoXcuT4/nWpLWCQRWdyt+r2uQ6xWweZxqj5PB7O70qli6HhBxkbxPiC9TAlmnMuAJW5MaSv1CUxbHSXJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=VPPzyJxC; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=mH0hK0/h; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744050142; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J3nZn0/ssvGT2rb4ODirIya8Hh87hXPua+MSamVJqb5TUX0E8EGLG2VQMXSicogNUY
    3WnYq+zAbntuaGsON3P8y5x7M6S9hg8zm0UEScq6ceWv8dF0jEABExVgJOOfomVfYg2Q
    +4kWuy/C7Zlf9kqC5Q+qauFwOpZkKpXBTW+oKkIpP5CI3I3I62juIbiLt1ZYe/y0gTPQ
    OA4Xwr7czxKMb+tYcfBidjmHYAjuQ+jLEtg27wFRTlsfQmTi1a+jGIxIJJbmP2aj3PX8
    O1Q2bgxtwDsW7c56+7l00oj4h3TQAHhFFxG6ZcZlc5GkyZH3VrT6rBm+PrL5bl0IfhDU
    FUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050142;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DRQWVNflVTSKFHFB9UYyJnOIp+l42TmftpYogCcmRdw=;
    b=HBegFbrtBL2Zth/bUEi3Cg4GPRZFJL/3J4WTXfWZTSrwpM93YSxoMqgrppDkwPvBQD
    76vU+ibJio8LzagzHAR+9fTwc/1VUg5GDwSAVx2giELtW2ZJVjC1J2ZlUnYxqRxtegXb
    pNnL+JDDW2eemoJkR2vqvLq/tk6LD2GyEmIdYmvS1MaTrrhri3S6CwyckU1ffQGQY+MD
    M6NZ/DRlEeX0PqzYHGS18z0yT16pl+ibt02zqoNzGkyopuB9uFF95nNp5nseMgrZRGOA
    /hSZMd9ZuCYPWVhbvoS1DM/ZtUn8Xdx7HQI7r3h7QbRMM5j340H49NR769AvoQAY5JaM
    /t/g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744050142;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DRQWVNflVTSKFHFB9UYyJnOIp+l42TmftpYogCcmRdw=;
    b=VPPzyJxCbwj3qt6R9AKL1OHfNAi0T65pGaebY0lGC8iEjNFE2ezByJUxvO98md8z8R
    XGZqsjRkaJ3uBCfQgI/Ytq61EsDHgpaWE//5AYNJkH3nIgdUvZ6W+ahmW9azvZXLqYWF
    cDuSTTKmr2rjCF7l00Br4EnIDkljDla/4jNYMmK2Oj6jSDq1/wKS9/ggTaUbvsS+5k5H
    YQj/Zd7Cd1PY9Tdyq2NFxpANad2nm47E7DkzyDNCKWVd3MkWqZUglUY1m4mALVISyOJE
    4VXFQ431DPvdMsWXQT5mEjtKpVqd9YjYvZOIvvBaKIfXlHDYLU1X1Dp16CLI2JdTkzQ2
    qsoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744050142;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=DRQWVNflVTSKFHFB9UYyJnOIp+l42TmftpYogCcmRdw=;
    b=mH0hK0/h0xoYAHdUZzGE0V7m+gxE10u/KwiuMBaXBCY2g2vYUl+lDPab6/0yNAjVEL
    6OCSK+1gLAt9vHec41Dg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b35137IMMyOo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Apr 2025 20:22:22 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u1r6z-0003xq-2Q;
	Mon, 07 Apr 2025 20:22:21 +0200
Received: (nullmailer pid 15036 invoked by uid 502);
	Mon, 07 Apr 2025 18:22:21 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND net-next v5 1/4] net: phy: realtek: Group RTL82* macro  definitions
Date: Mon,  7 Apr 2025 20:21:40 +0200
Message-Id: <20250407182155.14925-2-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407182155.14925-1-michael@fossekall.de>
References: <20250407182155.14925-1-michael@fossekall.de>
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


