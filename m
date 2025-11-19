Return-Path: <netdev+bounces-239781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D862AC6C641
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FD5035E7BD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B8F275AE3;
	Wed, 19 Nov 2025 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XtTFC5zF"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8162222CC;
	Wed, 19 Nov 2025 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763519581; cv=none; b=FKPlFqFSogY3cdShW0JU+ucPHtg7ExRAvtd6mAKffby5++Mx8qAot6XO03c3DlH8WyzSx/ccBRClPBo2JjzRLEXCQ5r2rRI3ztFwLkPRVKej8OTZoZqcIvzqrFy3usAVu+m3KGmfxg2YYCAt549HzXDuVemPiC30fxRtcNiBxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763519581; c=relaxed/simple;
	bh=tSVTmoyW2u3ETCk9aRkmPStk0caBSpdT+r9wPpWC6WU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jxvm6TikWbpMqeA6nL4/KGX0nzjqEo4iqN1crmxueJd9ajELCGy8uh4D7lRlRiqd3k2lOhMJ599UY4e3PEQEmK0pv2IC5wKtlY103Q8ZSOWYq7QkFldsdu3zXY64Qy69GRhMcXPrIq0I8AjsH5YJ2WYrWZ1T1SP3ehRRmBjMwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XtTFC5zF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AJ2WJlV42699131, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1763519539;
	bh=ePft3kaDW3VJdLYSXPvJs+SysoA89Mm2U/Bw7Z3xPsU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=XtTFC5zFRRFWNFqPoCpSP/XI01vEBZTF5p9zS8CPqn/S/67p92eyh6ILHuCDAZUAG
	 U3WFInCRjrf4uwRWEXoyfA5UfSsPQxsdIcN3J8yQajcjgo8GYa2uVccmesn44iezMu
	 +p8RxXcSdjeo8ncg8+oXFNC1igqAN0lo8PrF2HFGMX7iVuOu8oazw3WTG8cPHWswJY
	 dQifuYRs/0pTwvJBhweZwtsWRsxc3OdnmZo3NxgNcRpHzngpfdfyZaYoOpEZIFysZI
	 1eyvFGupkKPSW/D+eo7dUnBwkcOdjOOGWn7BzN2ogIt4PYU7VOJCQJWHe4gp5e0GE4
	 5Q741+BZNYgUQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AJ2WJlV42699131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Nov 2025 10:32:19 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 19 Nov 2025 10:32:19 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 19 Nov 2025 10:32:19 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        javen
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2] r8169: add support for RTL9151A
Date: Wed, 19 Nov 2025 10:32:16 +0800
Message-ID: <20251119023216.3467-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This adds support for chip RTL9151A. Its XID is 0x68b. It is bascially
basd on the one with XID 0x688, but with different firmware file.

Signed-off-by: javen <javen_xu@realsil.com.cn>

---
v2: Rebase to master, no content changes.
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


