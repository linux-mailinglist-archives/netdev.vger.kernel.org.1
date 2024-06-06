Return-Path: <netdev+bounces-101290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0388FE092
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 10:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938DB1F25131
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 08:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE3513BAFB;
	Thu,  6 Jun 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mBL0lEfL"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464EE13BACE;
	Thu,  6 Jun 2024 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661349; cv=none; b=Yx95ra0KttzZZiLUo31mgvaxxvRwG1cMcnspMuXWxYsqsq1gdFw1lg44z7wHITvcZ6QyaVKm+8euv54A3qCByhHYAvKdaJICTXYZIVV26RFGzjv0ao0SRuT8+kg8hHgeKrtzUFQXA2e1l1dOcp3EGRIHANGKJ1xcqWCUnqYGWj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661349; c=relaxed/simple;
	bh=8DZvqrIExiDGlNTQIZ70xfDwsYQlZo74CWV6y/G47dI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NsaVtB0Or9MAtc+MHKxtBcFoTpQP6FWzrxgqCeDE4Gqo7mv5iwP3kKl631ukeOB/QvUP7e4Xo5Sew+gLbllWgxMmlFmevKzXAehv65gI/mHAeguln+2CpNYuPR8rEScAOPe56/0ah1hp81e5V5az0AAhVxUIuXb93Rd+civDvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mBL0lEfL; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A27ABA0748;
	Thu,  6 Jun 2024 10:09:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Ej9AvbdmuG6OY/rM5mr02/VBWUAX37e/AaK0xJ/MhCo=; b=
	mBL0lEfLcjF9Du1KIu/uTM3ywQxviFLZ1i1vkXPTJ8Gq+SrSw6BfBrWH2uxHkT7Q
	NS4ToX08UN0ZVk276+FgRiepj4CYPJ2bXYu4ZZcVfaEki3mrGK7YzuHZxbc93i7L
	GJW1dFuE92+/KYS2EPN2l0ESfkxl2j64PHbMvyrTGN1pn4cbJGAYLvBByz3HGAi0
	l7+TyL1R/2HTToBUYe/o1c3jNpmdgJjzCGtmQ8la430pKtFj6XDK2QUCfZeFCo9M
	ZUdHculLf2XaefILfgCPgYHET5o/SSy1vXmy/tu1C5AQXr7WlH01YLdYi6VEgpu5
	TFrTZGpMwWpF41SHSmtTHIAka3bbWWmMAjdnDYR+xu+rCi2SZhBKO3gGfd/KeYaU
	Xnun4EpafeGfHRMPDsCXMb0WZrFDjfihgbLnh6oRABYgSpWI42j+UpWK1xBIK2EW
	rCT0agw8Ht8jPmadQFo7Z63BKmh+dZ7vBCpfzvedTkxtvoKVkES1XUMmVDqmeu0l
	cuD5MywyXx4/gaWQDlC3dOVUXvOt63YK26qgAIYKzZKi1fdGC7zXVUDA4fbpL9Zm
	X0FnI0YO5PrQXgRLfFYXoB5Mtcs3mK8Jz3PtVTRBpicLEeGWCZIQRGKZQrdi8GbS
	k2MlvbMN2WoQKJFBXF8hKbHDJV/wHZ7eGOflBC05CA0=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	<trivial@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Subject: [RFC PATCH v2 2/2] net: include: mii: Refactor: Use bit ops for ADVERTISE_* bits
Date: Thu, 6 Jun 2024 10:08:37 +0200
Message-ID: <20240606080836.121056-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1717661341;VERSION=7972;MC=1665352353;ID=397362;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B54627163

Replace hex values with bit shift and __GENMASK() for readability

Cc: trivial@kernel.org

Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
---

Notes:
    Changes since v2:
    * Replace BIT() with bit shift, as the macro is not exported to userspace
    * Use __GENMASK(), exported into userspace in 3c7a8e190bc5

 include/uapi/linux/mii.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 33e1b0c717e4..f03ac3b35850 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -69,23 +69,23 @@
 #define BMSR_100BASE4		0x8000	/* Can do 100mbps, 4k packets  */
 
 /* Advertisement control register. */
-#define ADVERTISE_SLCT		0x001f	/* Selector bits               */
-#define ADVERTISE_CSMA		0x0001	/* Only selector supported     */
-#define ADVERTISE_10HALF	0x0020	/* Try for 10mbps half-duplex  */
-#define ADVERTISE_1000XFULL	0x0020	/* Try for 1000BASE-X full-duplex */
-#define ADVERTISE_10FULL	0x0040	/* Try for 10mbps full-duplex  */
-#define ADVERTISE_1000XHALF	0x0040	/* Try for 1000BASE-X half-duplex */
-#define ADVERTISE_100HALF	0x0080	/* Try for 100mbps half-duplex */
-#define ADVERTISE_1000XPAUSE	0x0080	/* Try for 1000BASE-X pause    */
-#define ADVERTISE_100FULL	0x0100	/* Try for 100mbps full-duplex */
-#define ADVERTISE_1000XPSE_ASYM	0x0100	/* Try for 1000BASE-X asym pause */
-#define ADVERTISE_100BASE4	0x0200	/* Try for 100mbps 4k packets  */
-#define ADVERTISE_PAUSE_CAP	0x0400	/* Try for pause               */
-#define ADVERTISE_PAUSE_ASYM	0x0800	/* Try for asymetric pause     */
-#define ADVERTISE_RESV		0x1000	/* Unused...                   */
-#define ADVERTISE_RFAULT	0x2000	/* Say we can detect faults    */
-#define ADVERTISE_LPACK		0x4000	/* Ack link partners response  */
-#define ADVERTISE_NPAGE		0x8000	/* Next page bit               */
+#define ADVERTISE_SLCT		GENMASK(4, 0)	/* Selector bits               */
+#define ADVERTISE_CSMA		BIT(0)	/* Only selector supported     */
+#define ADVERTISE_10HALF	BIT(5)	/* Try for 10mbps half-duplex  */
+#define ADVERTISE_1000XFULL	BIT(5)	/* Try for 1000BASE-X full-duplex */
+#define ADVERTISE_10FULL	BIT(6)	/* Try for 10mbps full-duplex  */
+#define ADVERTISE_1000XHALF	BIT(6)	/* Try for 1000BASE-X half-duplex */
+#define ADVERTISE_100HALF	BIT(7)	/* Try for 100mbps half-duplex */
+#define ADVERTISE_1000XPAUSE	BIT(7)	/* Try for 1000BASE-X pause    */
+#define ADVERTISE_100FULL	BIT(8)	/* Try for 100mbps full-duplex */
+#define ADVERTISE_1000XPSE_ASYM	BIT(8)	/* Try for 1000BASE-X asym pause */
+#define ADVERTISE_100BASE4	BIT(9)	/* Try for 100mbps 4k packets  */
+#define ADVERTISE_PAUSE_CAP	BIT(10)	/* Try for pause               */
+#define ADVERTISE_PAUSE_ASYM	BIT(11)	/* Try for asymmetric pause     */
+#define ADVERTISE_RESV		BIT(12)	/* Unused...                   */
+#define ADVERTISE_RFAULT	BIT(13)	/* Say we can detect faults    */
+#define ADVERTISE_LPACK		BIT(14)	/* Ack link partners response  */
+#define ADVERTISE_NPAGE		BIT(15)	/* Next page bit               */
 
 #define ADVERTISE_FULL		(ADVERTISE_100FULL | ADVERTISE_10FULL | \
 				  ADVERTISE_CSMA)
-- 
2.34.1



