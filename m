Return-Path: <netdev+bounces-175211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656F9A645FF
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0383B05A1
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08AE221562;
	Mon, 17 Mar 2025 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="C6q9+AMw"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84921D3D6;
	Mon, 17 Mar 2025 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201000; cv=none; b=c5iMsd+vdPpHUpx5XCzxOEO7Lhr/+8CO2OJVEfXwMpCmLsvexnzcdj1AHofSTXLD6VCmgB5TuqahuZM/vclXnfmb7FYy/eI/wd59iJ/ZPBm/jli5yAn39rIkiNFJbgyJ0FHbEdVl+z08aTirFPJqNFpdAm8mB3ikj3rz5s2L5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201000; c=relaxed/simple;
	bh=+UVgE4Lc3SvK3rpMkszxSgihw9t5De4acB7r5eemDqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sG2XB3DhdtmYDo/PPCKg5YfXphcb/rzXThRMXHc3gkSqaG87o1dxr9z7Ca2mrHdSLEiAt1caMmMYMGrGl4u9A9HyTodDXiWvMquX9ZuxopTfHj80vzXEjI9i2Ic8HfXBq1FxSS/WCNPqM+9ou2+G+welyl6/zEGePBgqkXYSL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=C6q9+AMw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52H8gkPD3225789, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742200966; bh=+UVgE4Lc3SvK3rpMkszxSgihw9t5De4acB7r5eemDqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=C6q9+AMwgm8vVtDZtk097zLHGVK4JzPcrZYCzFoXlCSWEYGafyyYDKFlyeiXyJYhx
	 qvnBgt4d0oFB/WIot4lPgGTmBU+bwNyWfTLJbQaNHp58xfZlmmgrEeuvJMneLWQl5I
	 sfXp/6QHWPNskUjePenflSSvAyXW6Mw8Pq5bFLuPEwQBciWXzV6wG5jdQaE80Mqobx
	 j+V+YpexivOKuJJB0bMu8sI1FOiG54FnOwtwPGwH1hFe3mc4pc6OKU9nVPs319Pd7W
	 75+ROXj+THo6bcvIWRo7INrtAr9ctV7osU42dIxVSEcuxhMWcihUIcZZf846ezRnxU
	 pVWSpCo4qwR/w==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52H8gkPD3225789
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Mar 2025 16:42:46 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 17 Mar 2025 16:42:46 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 17 Mar 2025 16:42:46 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next v2 1/2] r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
Date: Mon, 17 Mar 2025 16:42:35 +0800
Message-ID: <20250317084236.4499-2-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317084236.4499-1-hau@realtek.com>
References: <20250317084236.4499-1-hau@realtek.com>
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


