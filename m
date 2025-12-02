Return-Path: <netdev+bounces-243298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CECAFC9CABB
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 19:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92B9F4E37DF
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA372C21E6;
	Tue,  2 Dec 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="HR26SpDx"
X-Original-To: netdev@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78B28C00C;
	Tue,  2 Dec 2025 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700903; cv=none; b=Qz5f+MLe8fIWIbFYkt5ReOs3adcK8wV3P1ErIBRAq6XB3C0+2wfwxj1cwDCAf05JWqIjaS1tcYD1s2zK6VPObFndBhrnn7+6kRDoBlIyzYZ/v41YCLnJ7IJYEq+/IsCB+Kp3zXzV3wL4kgkhaiKbv54Tmp+lacYWHl8f2+Cnjic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700903; c=relaxed/simple;
	bh=xe8+SCG9fbE0rTY/KZIU4S7K3W0qhSWTO1m1+a1bRrg=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=DXtUGf5uLtztDWZvM07baRV20HcInMnsIhZ04wkCr1UCcQD52PeHe0TFNd9Zaaye6ZKMSSmp5mO+HQafzzjyAGs5vat57RSxqf5eST/eVL80+Z8KsAR4jiImqJxQKHGi/mxr4JKgbve3xXJw2ro/wxKYJILxUnPNSo//20dvRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=HR26SpDx; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=6wN6lAbzhC54/AW8Afd+o3YWEQ45Do1ZW8p89JEmqoo=; b=H
	R26SpDxJCjMyrxeBbS7cIhUHcJ7XCgqwvTk2ITmZ72Y5piQJbnFHLbvKQ6T+QcgcDnVjDJ86DsGXJ
	ZFYXyzNKVUyW5ibh5fU5b61WqC+5p259/TWk5Cy5pbJkx1an1S5fc6ePCgLmAfAurdW0pb1ahI1LD
	6Vz38ueOBRhFHhNbGak6a5yTDTDd11nf//JCZYJ0IIvoIko9pa+ETUbpkBdTC3/gcjDpdBCU8dS0W
	lBrvc0/uZmOwv9rJ075Hbo9IwgYHcK94RTXntKlEKc5XvxdoXTjXnnWygoRZA3YZooxHBkdwo7xFk
	yi1Lcr1A59hoLVhrrexnXxp+cLwqpgjXA==;
Date: Tue, 02 Dec 2025 19:41:37 +0100 (CET)
Message-Id: <20251202.194137.1647877804487085954.rene@exactco.de>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?iso-8859-1?Q?fran=E7ois?= romieu
 <romieu@fr.zoreil.com>
Subject: [PATCH net V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Wake-on-Lan does currently not work for r8169 in DASH mode, e.g. the
ASUS Pro WS X570-ACE with RTL8168fp/RTL8117.

Fix by not returning early in rtl_prepare_power_down when dash_enabled.
While this fixes WoL, it still kills the OOB RTL8117 remote management
BMC connection. Fix by not calling rtl8168_driver_stop if WoL is enabled.

Fixes: 065c27c184d6 ("r8169: phy power ops")
Signed-off-by: René Rebe <rene@exactco.de>
Cc: stable@vger.kernel.org
---
V2; DASH WoL fix only
Tested on ASUS Pro WS X570-ACE with RTL8168fp/RTL8117 running T2/Linux.
---
 drivers/net/ethernet/realtek/r8169_main.c | 5 +----
 1 file changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 853aabedb128..e2f9b9027fe2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2669,9 +2669,6 @@ static void rtl_wol_enable_rx(struct rtl8169_private *tp)
 
 static void rtl_prepare_power_down(struct rtl8169_private *tp)
 {
-	if (tp->dash_enabled)
-		return;
-
 	if (tp->mac_version == RTL_GIGA_MAC_VER_32 ||
 	    tp->mac_version == RTL_GIGA_MAC_VER_33)
 		rtl_ephy_write(tp, 0x19, 0xff64);
@@ -4807,7 +4804,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
 	rtl_disable_exit_l1(tp);
 	rtl_prepare_power_down(tp);
 
-	if (tp->dash_type != RTL_DASH_NONE)
+	if (tp->dash_type != RTL_DASH_NONE && !tp->saved_wolopts)
 		rtl8168_driver_stop(tp);
 }
 
-- 
2.46.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

