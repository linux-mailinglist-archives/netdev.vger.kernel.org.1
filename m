Return-Path: <netdev+bounces-190605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F063AB7BE9
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 05:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B333B12B8
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 03:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648825B1CE;
	Thu, 15 May 2025 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="SfAivCxz"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3F269839
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747278092; cv=none; b=BjXW3ybuT5M9wDXaIsfDYzQsgJXr1V0PjEUWQZbR6kDfwmT7LAVUvpE1yC6KaRw2SUa1RXvirAdNGP+/HDf3Ylkwa/eh8wwsi5UevBch3D5VcA+2LQdS8eDIG2kJEjjPmS5qaoV1B3VL2iD6gbVr6XkWJWZi7YFukw/bHSulKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747278092; c=relaxed/simple;
	bh=aj4jjT4Gem8VYFAtmvD9ooXIuJNfF43vLkad1jb9fl0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hsfdu+evGIrW6nw+mgv7ixuLY8p2P8AqKDnCAiVPEVRAFy/DEgqAs67sGLEtn945RyrFukH1c8GBJ0bsBKOhm6wuDnmlwyzMEtaNKm+WsoN1QtMazdKLDqejLdjVKuWy9SHhmSK0UwKzacu5YEHinuuBSkWI07+80/kYLuOMhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=SfAivCxz; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54F30Vd142844183, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747278031; bh=aj4jjT4Gem8VYFAtmvD9ooXIuJNfF43vLkad1jb9fl0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=SfAivCxzswCuee7Craf+7HhTaRQ+RXJaZEg+bDE9e5c0EbjSZMfrfQH2VAtccUeSK
	 C7Ducc4b32gLyArBD8E8nteZGA4jnMG5a1lSJWVQrFOGrxVf39lPq3OeB/PZWAFMny
	 WpphfYOIpzA+uORu/JjcmLkBT6VhXHAObkn+tcf5bhLjYR2Vz3V66IfMtdAGlucd0S
	 c/2Lmk/8mbFMjiihV2D0tQSmY2yWwlG86YFjeNDPk2iJwdpKC8lqy7rnz5yilF2Stu
	 RERLfNVSabqE1Tiq1UlumAqTnkYoSq8o5HDNB5pvxAGZEomThUdWBH0OcukWL+gPHC
	 hepLUyA3evDTQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54F30Vd142844183
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 May 2025 11:00:31 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 May 2025 11:00:31 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Thu, 15 May 2025 11:00:31 +0800
From: ChunHao Lin <hau@realtek.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, ChunHao Lin <hau@realtek.com>
Subject: [PATCH net-next] net: phy: realtek: add RTL8127-internal PHY
Date: Thu, 15 May 2025 11:00:22 +0800
Message-ID: <20250515030022.4499-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8127-internal PHY is RTL8261C wihch is a integrated 10Gbps PHY with ID
0x001cc890. It follows the code path of RTL8125/RTL8126 intrernal NBase-T
PHY.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
 drivers/net/phy/realtek/realtek_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 301fbe141b9b..b5e00cdf0123 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -158,6 +158,7 @@
 #define RTL_8221B_VB_CG				0x001cc849
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
+#define RTL_8261C				0x001cc890
 
 /* RTL8211E and RTL8211F support up to three LEDs */
 #define RTL8211x_LED_COUNT			3
@@ -1370,6 +1371,7 @@ static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 	case RTL_GENERIC_PHYID:
 	case RTL_8221B:
 	case RTL_8251B:
+	case RTL_8261C:
 	case 0x001cc841:
 		break;
 	default:
-- 
2.43.0


