Return-Path: <netdev+bounces-192946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2553AC1C9A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 07:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C619D50418E
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE84221D83;
	Fri, 23 May 2025 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dm0+RoAQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05418DB2B;
	Fri, 23 May 2025 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747979302; cv=none; b=gfwO1kPUSwNQBu11VMVS/epN+fCe08iBAfo6fm2CBI+VnkdBVCoBmDUr71pQlMBjcrs3p5PPum25X7AtglFRGG7Ab5C+ItnXuQnBnUBajqg0JwmfibzSvwJFpb9WRqgAD5WVlWqxjzmOdjfopII4cwXuNVdax3Mveov7lYnlYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747979302; c=relaxed/simple;
	bh=bA4p72Ik1c08IvTgBUDVvOx7GV484o3k44cmI3Ciz5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TjtiXgIZV/7VY/T4wF4fOBMMwEksDI2Q3y9LU5Or7wactJqLurMW1mfozt90/BlDHFO7IlBLBJGnszQcW1HTGxbSuo8uhQy7v4rkSQK8f6au76f9QJ0php8ntgJgHWoSb4hS6DIFHZh4WCsSQ4zAC7GUGxGCKA2BBQPLzcJvF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dm0+RoAQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1747979300; x=1779515300;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=bA4p72Ik1c08IvTgBUDVvOx7GV484o3k44cmI3Ciz5g=;
  b=dm0+RoAQtOa/kstGEdpOkhdr6d/3C4QN1Q51vDohYrKkPRVy1h2xqNwg
   Akvz87TE4BDzLa9gdqW56Pb32G8FzZRcQmYuWP+d9gXVNaNbg4R4yGOal
   wTte/LiAIo3RsS/sx0OBjlpTV3djp20MvH4XrEjXUWG7iJaYNWU1VSYMf
   92YqpMlJaqYJkXwOjMesn13PTnziyxc3qAqKL7zBniSXxJOjAZ0e2ehkj
   n3uL6F9uZgh3IYRCmjLnLXZCiW1+cksb4aGIF0SCK3yJoivMn8dlxiyR4
   fQySsFB76m3DT2gT0VDyb74rABjvRdXnTd/vrQjVIxco9+kVZwZOtxKP0
   A==;
X-CSE-ConnectionGUID: LGngJwnIRy2YdRhcTVLYQw==
X-CSE-MsgGUID: 9LuqOcAQQFe67/H7N+Elkw==
X-IronPort-AV: E=Sophos;i="6.15,308,1739862000"; 
   d="scan'208";a="209485739"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2025 22:48:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 22:47:47 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 22 May 2025 22:47:44 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 net 1/2] net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy
Date: Fri, 23 May 2025 11:13:24 +0530
Message-ID: <20250523054325.88863-2-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523054325.88863-1-thangaraj.s@microchip.com>
References: <20250523054325.88863-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

rename the function to lan743x_hw_reset_phy to better describe it
operatioin

Fixes: 23f0703c125be ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 7e71579632f3..efa569b670cb 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1330,7 +1330,7 @@ static int lan743x_mac_set_mtu(struct lan743x_adapter *adapter, int new_mtu)
 }
 
 /* PHY */
-static int lan743x_phy_reset(struct lan743x_adapter *adapter)
+static int lan743x_hw_reset_phy(struct lan743x_adapter *adapter)
 {
 	u32 data;
 
@@ -1348,7 +1348,7 @@ static int lan743x_phy_reset(struct lan743x_adapter *adapter)
 
 static int lan743x_phy_init(struct lan743x_adapter *adapter)
 {
-	return lan743x_phy_reset(adapter);
+	return lan743x_hw_reset_phy(adapter);
 }
 
 static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
-- 
2.25.1


