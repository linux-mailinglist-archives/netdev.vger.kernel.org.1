Return-Path: <netdev+bounces-46075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B68E7E114E
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 23:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C65D1C2093B
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 22:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3810E26280;
	Sat,  4 Nov 2023 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="PoHTuiA9";
	dkim=temperror (0-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="tJNjF4Vj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F4250FE
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 22:17:34 +0000 (UTC)
Received: from domac.alu.hr (unknown [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6F810C2;
	Sat,  4 Nov 2023 15:17:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id ABFA960177;
	Sat,  4 Nov 2023 23:17:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1699136248; bh=bgYsDOH8vAjgaF3fpqAueO5QntvX3E+mh5LIX35R/qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PoHTuiA9Ky979UbYfZbOKwBg4AGwmHyuaV4M2znNZghNap5jTrrTITD+DcvJ1eWaL
	 sAXSe0L3ViiyCXfb1LpsJ2tMz1t1PBM1SSeyG8p1wdEnTiCD44nCoj/mzSt4z9hhXd
	 cHMyFdRR5ghFOZ5QOdX2ktpDXKdDPL+cFQ42EZ/LbxxHydvvDSy0cQjRmgqBDXi4l5
	 YmM4t3Joite/II4/mYHkn2Qkb3MfmEJ5u85XVaCorGLg4XJm8AUHp+obicZtU9cVb4
	 RsofAL66iRSmyCrTDSudW1xOeWzWh4fZo66V8BRs++1tkNaudCb6BF3WYuTI3GXKwY
	 OCI+qtAIF3IKA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ji-5XQDSBRDM; Sat,  4 Nov 2023 23:17:26 +0100 (CET)
Received: from defiant.home (78-2-200-71.adsl.net.t-com.hr [78.2.200.71])
	by domac.alu.hr (Postfix) with ESMTPSA id 50A446016E;
	Sat,  4 Nov 2023 23:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1699136246; bh=bgYsDOH8vAjgaF3fpqAueO5QntvX3E+mh5LIX35R/qM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJNjF4VjBtrjiWFy9NDlj73n9zLLTMs56ynXMkC43lQqzi/maAwBxaxP0JErC75TQ
	 7SxWnYvABr1cg21C7ArrRu4npD16vgKh3AZ/09n7nPAEmMMF86qZt+xcBOikh0m/8y
	 IyZTWxl7RtkLuAHGwMMtwOy9TodgMgw9qoSBStZ7+Ig0GxJPza6X1Fzj6kVHc8dTr6
	 tgnsnnwE4Towil3OZLhhQ4m9Qmq5dLjwAo/XL0IkQZQyZFKwkgIGCBMVI2+ArN/OBm
	 2Caicj8g74G9b2f2ksktcPGCjGYdnLvKfVSRJ62ov0fY40ePnYMGZ/PcnUxFeAOaWE
	 co4XhRu8wyVNw==
From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Marco Elver <elver@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v6 3/5] r8169: Coalesce mac ocp write and modify for 8168H start to reduce spinlocks
Date: Sat,  4 Nov 2023 23:15:17 +0100
Message-Id: <20231104221514.45821-4-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
the startup of 8168H involve implicit spin_lock_irqsave() and spin_unlock_irqrestore()
on each invocation.

Coalesced with the corresponding helpers, r8168_mac_ocp_write_seq() and
r8168_mac_ocp_modify_seq() with a sinqle lock/unlock, these calls reduce overall
lock contention.

Fixes: ef712ede3541d ("r8169: add helper r8168_mac_ocp_modify")
Fixes: 6e1d0b8988188 ("r8169:add support for RTL8168H and RTL8107E")
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: nic_swsd@realtek.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 26 +++++++++++++++--------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5515c51b6e3c..0fb34d217205 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3227,6 +3227,21 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 		{ 0x04, 0xffff,	0x854a },
 		{ 0x01, 0xffff,	0x068b }
 	};
+
+	static const struct e_info_regmaskset e_info_regmaskset_8168h_1[] = {
+		{ 0xe056, 0x00f0, 0x0070 },
+		{ 0xe052, 0x6000, 0x8008 },
+		{ 0xe0d6, 0x01ff, 0x017f },
+		{ 0xd420, 0x0fff, 0x047f },
+	};
+
+	static const struct e_info_regdata e_info_regdata_8168h_1[] = {
+		{ 0xe63e, 0x0001 },
+		{ 0xe63e, 0x0000 },
+		{ 0xc094, 0x0000 },
+		{ 0xc09e, 0x0000 },
+	};
+
 	int rg_saw_cnt;
 
 	rtl_ephy_init(tp, e_info_8168h_1);
@@ -3267,15 +3282,8 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
 	}
 
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
-	r8168_mac_ocp_modify(tp, 0xe052, 0x6000, 0x8008);
-	r8168_mac_ocp_modify(tp, 0xe0d6, 0x01ff, 0x017f);
-	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
-
-	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
-	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
-	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
-	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
+	r8168_mac_ocp_modify_seq(tp, e_info_regmaskset_8168h_1);
+	r8168_mac_ocp_write_seq(tp, e_info_regdata_8168h_1);
 }
 
 static void rtl_hw_start_8168ep(struct rtl8169_private *tp)
-- 
2.34.1


