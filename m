Return-Path: <netdev+bounces-100980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C453C8FCE29
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6125C1F2B200
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52349198E6D;
	Wed,  5 Jun 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FrlEfbik"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7FC19414B;
	Wed,  5 Jun 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589904; cv=none; b=DwoG+y6o3sye2M/qE9pUjBKHCPr/OhRiyiYdDJDM+58KqazKmnJLasjS6aHLPPG4gpQFJ5jUVLA2TtiWbuyiVrU3O/3pFnYlGdLEVxnKUDQX/61vuTyIjqejwx2BHyLMrFnPEV4Umts+3wbHS6QYhn4zrfbiRR/PAAzmxYr38H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589904; c=relaxed/simple;
	bh=EZqbdxvyWHkfWITBhc3qYG5VY8IworrlYeNQmutn4DE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LYoAZq95U+6JcHG4kEw2gsNHD92i7BsL30jD7gSgU/ySR/QzEphEqtiE7NcxQMVKTNE/voySJ2gmi3oKLWKMJwTMB+C5Pe+xZp2nTymYJ9l+oxJKXWQ3vbvQFIPtTsCNcsBLbItZFb8jW3SrK71QlpfRxyq9EQHLgm3w6mr46r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FrlEfbik; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C8B9FA0790;
	Wed,  5 Jun 2024 14:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=NfXb3FDjqc2kToQ5LauVJ+CD6lfQnRMJDwKJwaYPvEc=; b=
	FrlEfbikr9dn+YBMi1RjfcRht5ctgzWoduz45MQ7plpOLt0tAKutzlZVQOgoUmuH
	eR9j8rVUv+JA0LebENyy3oxxxwDhtWH2GMosl8cS8q4S2cWxbA7i9IhLlHSPe0ah
	gS1WYcelVLhHqOALpcpulBw6fTTp4tDA9y4lwiVuLM0QvZF5v1dWSKZlhZO6qi07
	eZ1tOHVZQcM0mK89LBDz/LNwkG8oa2XG8N3cPk4Gjq4ohFcu7v2ulrEhXvmyofBj
	PKgF5CY/twTDaT2yOZUMqfAFxQ1vxjjj1nXRrnnp8JmVbmjsiUBrlrwHyQKLPZRx
	tOwdQs/WVQNePiJjS+1NLSHWeDsfpItdUpopyL/ABbY9Zok6+4BCB0v28zFmZjP4
	ffHehoguPZ6w6z5SJ+hLO+Gr3ZFsapEiqV9Zcdi+tbqFHtptCqltCUfuGNQhtk25
	H/QaxdZfNfBxQ6ryP72bUU7PUizui/L3MoPeal1Srw12R3ePbjUr13T9UocF5ppO
	cZYtK/PHk1sRZmA3Bsy21e1N1mBfmPzlWywAJiwVbzeaDsKrIjA80kAfhJuEoDpa
	2wsI9C9T49SpPwp8Uy0rCYVUTNEqG8Hv6lymfJTdrkwmNZhVdqVpFPhdvSIz8mbp
	UFK3wPInTcPdAqYLUAekWcj5EdS/XVH0TkCoW+53Dqg=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	<trivial@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Subject: [RFC PATCH 1/2] net: include: mii: Refactor: Define LPA_* in terms of ADVERTISE_*
Date: Wed, 5 Jun 2024 14:16:47 +0200
Message-ID: <20240605121648.69779-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1717589896;VERSION=7972;MC=3101850431;ID=387142;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B54627663

Ethernet specification mandates that these bits will be equal.
To reduce the amount of magix hex'es in the code, just define
them in terms of each other.

Cc: trivial@kernel.org

Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
---
 include/uapi/linux/mii.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 39f7c44baf53..33e1b0c717e4 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -93,22 +93,22 @@
 				  ADVERTISE_100HALF | ADVERTISE_100FULL)
 
 /* Link partner ability register. */
-#define LPA_SLCT		0x001f	/* Same as advertise selector  */
-#define LPA_10HALF		0x0020	/* Can do 10mbps half-duplex   */
-#define LPA_1000XFULL		0x0020	/* Can do 1000BASE-X full-duplex */
-#define LPA_10FULL		0x0040	/* Can do 10mbps full-duplex   */
-#define LPA_1000XHALF		0x0040	/* Can do 1000BASE-X half-duplex */
-#define LPA_100HALF		0x0080	/* Can do 100mbps half-duplex  */
-#define LPA_1000XPAUSE		0x0080	/* Can do 1000BASE-X pause     */
-#define LPA_100FULL		0x0100	/* Can do 100mbps full-duplex  */
-#define LPA_1000XPAUSE_ASYM	0x0100	/* Can do 1000BASE-X pause asym*/
-#define LPA_100BASE4		0x0200	/* Can do 100mbps 4k packets   */
-#define LPA_PAUSE_CAP		0x0400	/* Can pause                   */
-#define LPA_PAUSE_ASYM		0x0800	/* Can pause asymetrically     */
-#define LPA_RESV		0x1000	/* Unused...                   */
-#define LPA_RFAULT		0x2000	/* Link partner faulted        */
-#define LPA_LPACK		0x4000	/* Link partner acked us       */
-#define LPA_NPAGE		0x8000	/* Next page bit               */
+#define LPA_SLCT		ADVERTISE_SLCT   /* Same as advertise selector */
+#define LPA_10HALF		ADVERTISE_10HALF
+#define LPA_1000XFULL		ADVERTISE_1000XFULL
+#define LPA_10FULL		ADVERTISE_10FULL
+#define LPA_1000XHALF		ADVERTISE_1000XHALF
+#define LPA_100HALF		ADVERTISE_100HALF
+#define LPA_1000XPAUSE		ADVERTISE_1000XPAUSE
+#define LPA_100FULL		ADVERTISE_100FULL
+#define LPA_1000XPAUSE_ASYM	ADVERTISE_1000XPSE_ASYM
+#define LPA_100BASE4		ADVERTISE_100BASE4
+#define LPA_PAUSE_CAP		ADVERTISE_PAUSE_CAP
+#define LPA_PAUSE_ASYM		ADVERTISE_PAUSE_ASYM
+#define LPA_RESV		ADVERTISE_RESV
+#define LPA_RFAULT		ADVERTISE_RFAULT /* Link partner faulted       */
+#define LPA_LPACK		ADVERTISE_LPACK  /* Link partner acked us      */
+#define LPA_NPAGE		ADVERTISE_NPAGE
 
 #define LPA_DUPLEX		(LPA_10FULL | LPA_100FULL)
 #define LPA_100			(LPA_100FULL | LPA_100HALF | LPA_100BASE4)
-- 
2.34.1



