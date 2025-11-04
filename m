Return-Path: <netdev+bounces-235439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD73C30862
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 11:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FD23BD5EC
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34298318136;
	Tue,  4 Nov 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1Gcxs1tt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC5316199;
	Tue,  4 Nov 2025 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252170; cv=none; b=cDCoqPczK2UHZgeyuYVMu69hkcCDMMjlilUZ/b5PmPG+0SqDhqNPUfY80uaHqTp/9I8R6Sc/w0AW5o+bR/RxKpvh2wuXdmNJa7fXpEBUgtQqTRsQiNDmuVBhy6qgKBYepdY5pRnVFeWPAFGaWN7ZaLeGFcAg0J1G6wy2l6CS82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252170; c=relaxed/simple;
	bh=kifZlPCKxYvvqUqvG1gJERfEBvK6kx+T9JxGrCjLHuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1NZCLDS0+7qKu27yPwKsquJRAtPDXYKYockj5zATQKdDoK3uypOrP71Fm/WePW+6broWfBivbg7GGhUFT+Suh9fDJMkq+w7gwDkNd/OuqiInc/o0zp1PbtemsebNYgY0lM4qqtzVAXVY4pNHBQlBv21qiyGATrDtEtpgB8PFro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1Gcxs1tt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762252168; x=1793788168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kifZlPCKxYvvqUqvG1gJERfEBvK6kx+T9JxGrCjLHuU=;
  b=1Gcxs1ttvp0gB5gAZwcJzMUWaZuRrWs2JZeYmia2WCubvIMPnvDVw5ay
   cMKxMFuvdunUT4IJll/5ZE+fJ3MynViFopGO0u2CVcSuoq0BT4IW0aQN8
   misaVOOVqG/bEeIEAmkuuPodefk8+XMFiHkXq+sxuW5DrcEy/bRGvyuev
   2D5n68tJExijkqGYNY3dsjC/KVcPT4g81Z3PotGezdCxAmtG3XfgbLbpO
   MTVif3UwEy8Axntvxgo2Lk+QIOp7UyshRsj/THUDjgGBhF1LCQKniexeu
   23K3Wz+pf/SG4S+26Z3v5KCYQ/rW2bEtPX+ZO2/vfcpDUGqM1IuLZ/N+6
   w==;
X-CSE-ConnectionGUID: 54f3n6OUQHWzRkAOn9QkBA==
X-CSE-MsgGUID: sdEznaHiT7eJ2IiGBP65AA==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="49163545"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2025 03:29:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Nov 2025 03:29:03 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Nov 2025 03:28:59 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 2/2] net: phy: microchip_t1s:: add cable diagnostic support for LAN867x Rev.D0
Date: Tue, 4 Nov 2025 15:58:42 +0530
Message-ID: <20251104102842.64519-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104102842.64519-1-parthiban.veerasooran@microchip.com>
References: <20251104102842.64519-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable Open Alliance TC14 (OATC14) 10Base-T1S cable diagnostic feature
for Microchip LAN867x Rev.D0 PHY by implementing `cable_test_start` and
`cable_test_get_status` using the generic C45 functions. This allows the
`ethtool` utility to perform cable diagnostic tests directly on the PHY,
improving network troubleshooting and maintenance.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index bce5cf087b19..dd3de712c9d4 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -573,6 +573,9 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
+		.cable_test_start   = genphy_c45_oatc14_cable_test_start,
+		.cable_test_get_status =
+					genphy_c45_oatc14_cable_test_get_status,
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
-- 
2.34.1


