Return-Path: <netdev+bounces-237502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5AC4CA90
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEBE18841EA
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B92DAFD2;
	Tue, 11 Nov 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="JdqREjat"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAE74A01;
	Tue, 11 Nov 2025 09:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853374; cv=none; b=gFzzwLuA5g9K6PXSmAfgcNR0aSwAXv+PfSVheA8xmu3KpZ7Ltud/dLk0HCCDYi3W2x8SAHff4YXhyJp12uI4hbGUa42gTcKsjDnpRBJDEvwGy58Ouz/VvjHsOP/PLBEbB887T3XDVgAoExoV3/D6BqOsP+F3S7/kcm8lIagRUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853374; c=relaxed/simple;
	bh=ne5yh8ZC2GODRrvuJFNe9SQwcT3vPtcEL0MEUpvQol0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lp4I90TippBouztIsttykFqLVJGia13+ry5okhKjeQPZQOa/El4I6kS2MRuPSPt4fWP+9F9pFIoMve2GleRp61rSVMkHJ/Y+42vXRrbIgOxACe6I4dMGrTL4nDWDh6d9/XQ7NELE1ugu6UOd+eG3Fhuel/QOo0N+IgL4X0bpdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=JdqREjat; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB9SrFQ23457237, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1762853334;
	bh=qWl0dddmwIBBcOBnbKE9nqFnSO6m1/0E7BD0OMtrhrc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=JdqREjatnGtMqp3Y1ci7NUfTpPTXFR9uRLUuSmje0nA9LcRACLPLdAACFcJg43255
	 znhXWO1BOIrQXF6rKc8TVJWaGv4fz4nIVs3OxbYyV1WO96tfcBVtGf8wDXVNkYDu4d
	 euZKSlFHRqu7u9wrVqi4gRJw+ECQ49QlWwb6V9A6jRE2cqyJpC9JZjmlQrkPaqsZ/P
	 28Y7GnmJjbNKSX6mngDSpeRIl63fGQTj7OwZ8K+PjRt7zUQm0Wam87JN2xDzbEkAc/
	 Aa5IQzCr2K4fJqkb2YYqcsPL6asC4hktaisK3SpjmhqZvTZPbDStFivP1cslbapSP5
	 9Q3tEw09x+mfw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB9SrFQ23457237
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Nov 2025 17:28:54 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 11 Nov 2025 17:28:53 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 17:28:53 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        javen
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2] r8169: add support for RTL8125K
Date: Tue, 11 Nov 2025 17:28:51 +0800
Message-ID: <20251111092851.3371-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

This adds support for chip RTL8125K. Its XID is 0x68a. It is basically
based on the one with XID 0x688, but with different firmware file.

Signed-off-by: javen <javen_xu@realsil.com.cn>
---
v2: This adds support for chip RTL8125K. Reuse RTL_GIGA_MAC_VER_64 as its
chip version number.=0D

---
 drivers/net/ethernet/realtek/r8169_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethern=
et/realtek/r8169_main.c
index d18734fe12e4..eda3af907127 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -57,6 +57,7 @@
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
 #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
 #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
+#define FIRMWARE_8125K_1	"rtl_nic/rtl8125k-1.fw"
 #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
@@ -110,6 +111,7 @@ static const struct rtl_chip_info {
 	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
=20
 	/* 8125D family. */
+	{ 0x7cf, 0x68a, RTL_GIGA_MAC_VER_64, "RTL8125K", FIRMWARE_8125K_1 },
 	{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_2 },
 	{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_1 },
=20
@@ -770,6 +772,7 @@ MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
 MODULE_FIRMWARE(FIRMWARE_8125D_1);
 MODULE_FIRMWARE(FIRMWARE_8125D_2);
+MODULE_FIRMWARE(FIRMWARE_8125K_1);
 MODULE_FIRMWARE(FIRMWARE_8125BP_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
--=20
2.43.0


