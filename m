Return-Path: <netdev+bounces-174811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAE1A60A2C
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E018A17C00D
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DFE18CBEC;
	Fri, 14 Mar 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="t+lD91q5"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCADE16BE17;
	Fri, 14 Mar 2025 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938121; cv=none; b=YCA2atRxCJqdghmfvgnJPDMqrl/BjFpSHfnYDBlKNbKLR9OCE4zfce9PTyVAJxkEiqGRtJ9bdtDgqrJrE8nm59l9RdlqhX0+0bKMxAhDyGkhKK4qEd4F9cO1lwRCCWn4LqUK2NipFlK+CGCZGOp0holI+s7ZVt5mX5bk58fzzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938121; c=relaxed/simple;
	bh=+UVgE4Lc3SvK3rpMkszxSgihw9t5De4acB7r5eemDqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtY+nj0jHWl+4KMtqUUPRkA4uDJxK/jaNVfd7Jml7W+GIjJbxOxgc93x768n6iZxmBCDdxQNEpUyNq+53FpGgW/ulHVBalL1INOamCLoTFPB8FVhUERMxCC5lLR9F6xt8HKOg0Feyb/hhhryNhmFQTRXLORxy2Z+aKeeHkKv8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=t+lD91q5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E7ffgH72708350, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741938101; bh=+UVgE4Lc3SvK3rpMkszxSgihw9t5De4acB7r5eemDqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=t+lD91q51sB9JhgNoXAxSCBcAe0D1/JUhbq3DmUEA3nXlBcSouNZNfv4TW4Fhrdsh
	 ui8JVDmxPKZdUVvObpgU0sgtqJZJFgnZ95J9b62ERvej2F22h0nBfrnu+TkULrSwJM
	 jIpac1ZoadhsCLgufirZTZzWkjd5qmlqluvpjZ3BNz+jBpbV3cynd35haRldbNeQW3
	 1GNd/mrZEdvigLHkgondEjvpq7IjA5HS7z0uE+pnRkMTFdBg0Hx/lKFThHwFRNCbWe
	 /i/yrtsZPn7Pt9mVw8g5iscE1Eu0ZJPX6hV7glDCZufQ6LMJgxd4obf9jp1atjM7Yu
	 nqZdmh6984tHQ==
Received: from RSEXMBS03.realsil.com.cn ([172.29.17.197])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E7ffgH72708350
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Fri, 14 Mar 2025 15:41:41 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXMBS03.realsil.com.cn (172.29.17.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Mar 2025 15:41:38 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Mar 2025 15:41:38 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next 1/2] r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
Date: Fri, 14 Mar 2025 15:41:28 +0800
Message-ID: <20250314074129.2682-2-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314074129.2682-1-hau@realtek.com>
References: <20250314074129.2682-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch will enable RTL8168H/RTL8168EP/RTL8168FP ASPM support on
the platforms that have tested with ASPM enabled.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b18daeeda40d..3c663fca07d3 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5398,7 +5398,7 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
 /* register is set if system vendor successfully tested ASPM 1.2 */
 static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 {
-	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_46 &&
 	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
 		return true;
 
-- 
2.43.0


