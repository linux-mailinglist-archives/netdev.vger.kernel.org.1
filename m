Return-Path: <netdev+bounces-219785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D003B42F7F
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28924680F3E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9371E3DE5;
	Thu,  4 Sep 2025 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jej/3PHh"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08841E3DF2;
	Thu,  4 Sep 2025 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951929; cv=none; b=SR7ZT1kAftgjmrPqEKWvDWAi6RhTPmXTvCgahRWbishhQQYuFpGj50Fy7fS7XXRPpJo2LN1goWnmI8i4hd1KIH/RZWU1z4++Y4NwokvfzDQ3luKK4ESuohJV7uWjhPnMCL72AR7yLIIQBZJuw1IYw/qSAdeXLiF9DrvmiOF3/Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951929; c=relaxed/simple;
	bh=elo34a7kXzxnuVCXuHUnNsz4xvsXFb4e0AwTQYIPjqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ukj39bTOE4oDQD0QU10tWr1rsqr2xrgPROUaQgtPzmxEJJKAjQ5rCGOYsKK2vPYX2X4XmTu2VDzURE9ps2tC/oVVKh+u1fewjiRVmPGQyf437Cyb0QywOX7IvfejMehH3/DBk1MHBUXQ5PGoIjrDGqsuv1tUdGR1ED8dViRShaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jej/3PHh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5842BSx043060713, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756951889; bh=4NjR6lrJbCSVIfVV84b0NexDgbOS+5WtG1RVDA5wIj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=jej/3PHhWcaY2tKDD5pMvjnIP7N0IH8yDuocuclZL9VxkO9tJeENHFx3OdnVRAY+Z
	 eIg4i+HUVozvaKXbq7kO0rmtesTnyP7jmhjGBIF311N/VxPhrCj7/KJnPnZxueStsK
	 VgIZQmbl4B24rz1P4yEJm/Xu9rf88Qpxk+XpjR95zK2KEbq2NxfCSsUgvilNgIDkk1
	 x0Tm8blS2Kn0uVJumxkPC9pYGyEMe1tCQE5lJFHxMvEnPl9lBcFF5WDQ+nIrQ/kPP0
	 /YDvnbl2QWsm0hFbFlOOqMI3AYipgV+REn2r4JbThzBQoIxoed0JiSPio01p4LOKcv
	 /+fXoYsQOPFgw==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5842BSx043060713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Sep 2025 10:11:29 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Thu, 4 Sep 2025 10:11:28 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1544.33 via Frontend
 Transport; Thu, 4 Sep 2025 10:11:28 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next] r8169: set EEE speed down ratio to 1
Date: Thu, 4 Sep 2025 10:11:23 +0800
Message-ID: <20250904021123.5734-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

EEE speed down ratio (mac ocp 0xe056[7:4]) is used to control EEE speed down
rate. The larger this value is, the more power can save. But it actually save
less power then expected, but will impact compatibility. So set it to 1 (mac
ocp 0xe056[7:4] = 0) to improve compatibility.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9c601f271c02..e5427dfce268 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3409,7 +3409,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
 	}
 
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
+	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xe052, 0x6000, 0x8008);
 	r8168_mac_ocp_modify(tp, 0xe0d6, 0x01ff, 0x017f);
 	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
@@ -3514,7 +3514,7 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
 	}
 
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
+	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
 	r8168_mac_ocp_write(tp, 0xea80, 0x0003);
 	r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
 	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
@@ -3715,7 +3715,7 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xc0b4, 0x0000, 0x000c);
 	r8168_mac_ocp_modify(tp, 0xeb6a, 0x00ff, 0x0033);
 	r8168_mac_ocp_modify(tp, 0xeb50, 0x03e0, 0x0040);
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
+	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
 	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
-- 
2.43.0


