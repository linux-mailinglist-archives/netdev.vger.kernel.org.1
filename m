Return-Path: <netdev+bounces-193344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED36AC394A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182BC167F22
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 05:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD41AF0A4;
	Mon, 26 May 2025 05:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ISj6TBET"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7DF8488;
	Mon, 26 May 2025 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237737; cv=none; b=Ym2AWkPau7kxO9ZLhZdyZ6fHGlRaRe1vq/FtkgFBY1o5tX//7o2liWrvW/lFOYDHFoRZOw+HB2oS0G6w80VUhHLGKswPEvODTPExrVFK5/3vVOPg4aC/Hih4wsesap6UWfWfwi+bZtdhL6c1huUlIyFoU9KfVKDxX8ILilInPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237737; c=relaxed/simple;
	bh=Ybxf2SQDsOqgKipFq8b/1RSY2RK6Zk63VEp6uukSrgs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XC6fzWY2J40B1hqs0St8QBiekmWQuVAgimlkeobpXBHRHkfFhUDdxk9qqFSjG1/dA9AR29duwWvNGf5B/ty5w9zTDZ9IcuUqgdSy0sEwUcCQFKf3VTuCBUKVKs7rcDgQcDMbaLy0/Dvg/A653pJEHsKOK7HT2BnkEqXNUbsYg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ISj6TBET; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748237735; x=1779773735;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Ybxf2SQDsOqgKipFq8b/1RSY2RK6Zk63VEp6uukSrgs=;
  b=ISj6TBETZT9PKRMrQIycLGo4z0GNGHHTXkilCxdasGDhp6hz70hE9v41
   zfkoJBhWtNegKOYPI7Fp1o6L2bOVhULtozQCewxs05lBPxM6+kK5onBw0
   cehJAEznWse4gssU6Dmi5rh/lwJrKCS3ephVG6U22a50y8vQW7YjybHuL
   7SbUwpU+LHnZ38ifck6wAuanUHYppyMQaz61p0hIfpr43lWpQDXMr4E2H
   X2RlZZ/EMuFVzMgPWabWG01c0uWWzSNDezVirm+O4LrTiz2Vj2Q4HlzjI
   MjHWDEMT+N4zL53qWSm9ejBb08LUnQv3knc9v6GZn8hqqFPQRbbmD+KT2
   Q==;
X-CSE-ConnectionGUID: ZIY/Wzj3Q22sZWvgvBPVZg==
X-CSE-MsgGUID: SpW3N/6dTNq9Unp+XepaDA==
X-IronPort-AV: E=Sophos;i="6.15,315,1739862000"; 
   d="scan'208";a="41602082"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2025 22:35:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 25 May 2025 22:35:03 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 25 May 2025 22:35:00 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net 1/2] net: lan743x: rename lan743x_reset_phy to lan743x_hw_reset_phy
Date: Mon, 26 May 2025 11:00:47 +0530
Message-ID: <20250526053048.287095-2-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526053048.287095-1-thangaraj.s@microchip.com>
References: <20250526053048.287095-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

rename the function to lan743x_hw_reset_phy to better describe it
operation.

Fixes: 23f0703c125be ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


