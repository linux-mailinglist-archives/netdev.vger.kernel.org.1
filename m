Return-Path: <netdev+bounces-239417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E3EC68131
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 9ECB02A00F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55AA2F49F4;
	Tue, 18 Nov 2025 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="vLcBVoVx"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962921E2614;
	Tue, 18 Nov 2025 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763452386; cv=none; b=nDyMMvhUGgeOemuGtvn/jj8NxKddgkoF0wrLjHJLFfjuBM84EiI2cjhe/WlXtuVzgUFr4Mj6bW38PKsxH+ZMHbccx2yjxL6SEwnMXY+v8T13GMimepMPV1R9I889GnQK1wh/n1ugZaYxVEvmKHvHEi9Vy1tymXUZa7WInWMsbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763452386; c=relaxed/simple;
	bh=CrCOz/n7EhDzopuM4Jj8UKmOJnk248V2J/pBSXsf5/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UCNJvJ6R+aYT9AGacGwtvCvvT6Y1G66MgkPuIaCuqYyUGJNhUJlCFUwJRn1h6KQlUEp966tpEH68l6ztHafminHMWGeTk4dDMVIMz/24nDNJAfPvqmN3cTSbmMlv6gnLML8vjBb89xSLSpAXC+zkoTLY3oqfEg7w9N4CN31wEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=vLcBVoVx; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI7qLvX51082773, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1763452342;
	bh=wb0CBWIL5vk9uqWAFeMWV+aHh1MSnhIRcxnohUMADvk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vLcBVoVxmlEw3B+mM21qWI5zsS8iCfqwcmK81h71VZTxsF90Jq4g+nSP5FalQoa4u
	 dWoFm2uy8AWxfpVlkcRVqk9o5I4lVyuZDV0u4bHye9RmmzoDN3s5ArYi1XKjyYGE2V
	 +5g1LbhtP9xQRJRaAFCbXSAKLnddN4YuN6vz0rQWn/xT4b+a6vtWBLbunt3jEttxIX
	 0lI3l6o9mGg6svPCpxnKMoX6Am6vPMx6ug29+55fgzDp1abAFCbOAiLb5tZTR7xn0V
	 KsN1fb2LGo0BoTJZAX2Ch1x3XlpjVGFcG+j6DZjijWwEYbUdol45E1QpYU32VrXxeo
	 qjcYvDgULqvuA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI7qLvX51082773
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Nov 2025 15:52:22 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 18 Nov 2025 15:52:21 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 18 Nov 2025 15:52:21 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        javen
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1] r8169: add support for RTL9151A
Date: Tue, 18 Nov 2025 15:52:17 +0800
Message-ID: <20251118075217.3444-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This add support for chip RTL9151A. Its XID is 0x68b. It is bascially
based on the one with XID 0x688, but with different firmware file.

Signed-off-by: javen <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d18734fe12e4..dfc824326b16 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -58,6 +58,7 @@
 #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
 #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
 #define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
+#define FIRMWARE_9151A_1	"rtl_nic/rtl9151a-1.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
 #define FIRMWARE_8127A_1	"rtl_nic/rtl8127a-1.fw"
@@ -110,6 +111,7 @@ static const struct rtl_chip_info {
 	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
 
 	/* 8125D family. */
+	{ 0x7cf, 0x68b, RTL_GIGA_MAC_VER_64, "RTL9151A", FIRMWARE_9151A_1 },
 	{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_2 },
 	{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_1 },
 
@@ -771,6 +773,7 @@ MODULE_FIRMWARE(FIRMWARE_8125B_2);
 MODULE_FIRMWARE(FIRMWARE_8125D_1);
 MODULE_FIRMWARE(FIRMWARE_8125D_2);
 MODULE_FIRMWARE(FIRMWARE_8125BP_2);
+MODULE_FIRMWARE(FIRMWARE_9151A_1);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
 MODULE_FIRMWARE(FIRMWARE_8127A_1);
-- 
2.43.0


