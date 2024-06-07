Return-Path: <netdev+bounces-101714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0C8FFD73
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF50E1C218C0
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9DA15A864;
	Fri,  7 Jun 2024 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="BD/wuHLT"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD461502BE;
	Fri,  7 Jun 2024 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746552; cv=none; b=pOgbEJkr69teFc1u8xuVS4POHm2DU1iu6Vcizqc52X/8RW4MiUy50OBcDe2TLOdpuRNSDDI0NBWMGmlU6SdrEaalw8gpjkt1ktDy/8v0hc3l0JtaFNimDQ0/0NyRm8Z3qA9N4iyeCCCeiwO+ADr9boyx+ng6DVr18Y6fanY/skE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746552; c=relaxed/simple;
	bh=xZWu/NogJC3RxPFHDArEqKEkVRgZjWbA3apIKj3gW48=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HPQstKOBuVctnL1uJa8GUx8D8fLXShRM+KTKQKgQDoj0d0vudtePGQZYes3htnSr3CtKnYcGoRDpDmLNGPX4O12mVpUk+f9JPPP9CM33zbmJVuP4BaErtVmnOnEZVkgBsCdEs0ShFQYrTqEC2wNsWqqVJAYR5sns/iMUw4hH+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=BD/wuHLT; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DFE06A0A9B;
	Fri,  7 Jun 2024 09:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=g5MlsUd6+2avonM+wjOiDCn9g5MLzJxI3u4nNsFggUo=; b=
	BD/wuHLTH60HAn+UoL7pPGk5/mqRGVZ2tcerdfUwdCQSrsPvmavOhhe7uF4xnPuj
	HYmA2e5/Zv0YnooV+H+gAnaC1B2yQLhAbDy8dkH51UGswqlTalTxbDZBGUzbp/dg
	TLqmu7Sce+/jZB4CAfn+XhaPj7U5JAhgJqX/aGhn2AwJmRJXoDQgnH6VZy93a34x
	k2uTGGITfSyibov9p0AM2BRZg3HRAUfKPBTlxWXVPOAK3kO7hziW0MnVfHffp3AR
	lBsd2Tji8a8wyrMwfD94QfKfwZXSddjHuahwRP3F7S16E29JlP0RUUiVhvINXDL2
	MjLkHQTuhxoRrJWPgjOb3XifIaTQgEVbr4lF64imClsBcmynZQZTJuHe0+Npdutl
	J6M9kdDSga8ULJh02J06H5ROFp0/cIjSgu5UH6S7DysupQbnGmpkkq7pc3Rp4pvl
	00ADGsyS0WvE/QnWlHHCWRoiwNChH4jaHqr6dOQ64UbQi0cIp4qVp1+OLuT71Gkj
	X6eu0ql85kM5aaRC/2uy84MTpUDpvz4TdqPh9sDsoLUk1+6xIlc5KVNasf7pabyN
	JMWxhPbTbrTB1Wu5oaJ2O8FWKFVXlmWcGXwntYOxTXa7j9p/7IXnZT7M2PJ0rO20
	n64AD8vYnmH8Gg79/xQusCUw1nTM82MkMdyV8q0vN+M=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	<trivial@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Subject: [RFC PATCH v2 2/2] net: include: mii: Refactor: Use bit ops for ADVERTISE_* bits
Date: Fri, 7 Jun 2024 09:48:29 +0200
Message-ID: <20240607074829.131378-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1717746538;VERSION=7972;MC=3831874360;ID=410158;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B54627061

Replace hex values with bit shift and __GENMASK() for readability

Cc: trivial@kernel.org

Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
---

Notes:
    Changes since v2:
    * Replace BIT() with bit shift, as the macro is not exported to userspace
    * Use __GENMASK(), exported into userspace in 3c7a8e190bc5
    
    (yesterday I accidentally sent v1 again, this is the correct v2)

 include/uapi/linux/mii.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 33e1b0c717e4..3fbc113a0f70 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -9,6 +9,7 @@
 #ifndef _UAPI__LINUX_MII_H__
 #define _UAPI__LINUX_MII_H__
 
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/ethtool.h>
 
@@ -69,23 +70,23 @@
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
+#define ADVERTISE_SLCT		__GENMASK(4, 0)	/* Selector bits               */
+#define ADVERTISE_CSMA		(1 << 0)	/* Only selector supported     */
+#define ADVERTISE_10HALF	(1 << 5)	/* Try for 10mbps half-duplex  */
+#define ADVERTISE_1000XFULL	(1 << 5)	/* Try for 1000BASE-X full-duplex */
+#define ADVERTISE_10FULL	(1 << 6)	/* Try for 10mbps full-duplex  */
+#define ADVERTISE_1000XHALF	(1 << 6)	/* Try for 1000BASE-X half-duplex */
+#define ADVERTISE_100HALF	(1 << 7)	/* Try for 100mbps half-duplex */
+#define ADVERTISE_1000XPAUSE	(1 << 7)	/* Try for 1000BASE-X pause    */
+#define ADVERTISE_100FULL	(1 << 8)	/* Try for 100mbps full-duplex */
+#define ADVERTISE_1000XPSE_ASYM	(1 << 8)	/* Try for 1000BASE-X asym pause */
+#define ADVERTISE_100BASE4	(1 << 9)	/* Try for 100mbps 4k packets  */
+#define ADVERTISE_PAUSE_CAP	(1 << 10)	/* Try for pause               */
+#define ADVERTISE_PAUSE_ASYM	(1 << 11)	/* Try for asymmetric pause     */
+#define ADVERTISE_RESV		(1 << 12)	/* Unused...                   */
+#define ADVERTISE_RFAULT	(1 << 13)	/* Say we can detect faults    */
+#define ADVERTISE_LPACK		(1 << 14)	/* Ack link partners response  */
+#define ADVERTISE_NPAGE		(1 << 15)	/* Next page bit               */
 
 #define ADVERTISE_FULL		(ADVERTISE_100FULL | ADVERTISE_10FULL | \
 				  ADVERTISE_CSMA)
-- 
2.34.1



