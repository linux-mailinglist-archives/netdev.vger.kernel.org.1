Return-Path: <netdev+bounces-241851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89161C89636
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA98E34455E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375442F547F;
	Wed, 26 Nov 2025 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BDZ3D/ED"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C14284B29;
	Wed, 26 Nov 2025 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764154229; cv=none; b=r4+5FVQEzxlMhPLoD491QHR1LDMlByA38XHLiu0ha6QBSBoVRj92vfcjrjAFv/UG/F6SXe/xjSqB5Xv9v2NJtQjPi0wac/wbq847/Q2mXpyn02s7go3foRqo4oe86/fij0nz8u201rYlfybabXIPN9c5/tyRLuTPrlVyKaDDM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764154229; c=relaxed/simple;
	bh=9u6G1uRxPermdv4TCk/mWsUbTEfeHI/uhloFW7LMPPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQdzoMZ0YnNldYTID4YVaGH/xXmYrSiiZisjhebJiMdusWYvgscAS5m73tsAOBnup8ee6SlqMd9t6f32AtA/SMt8vrSDkRd3bEgI2feiD7xyg67kswJ7tuf05FMwmNpxf7LS8abC4VTpOZHKazogCiyEZoSGC88SIdqvfq06QCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BDZ3D/ED; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1764154227; x=1795690227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9u6G1uRxPermdv4TCk/mWsUbTEfeHI/uhloFW7LMPPQ=;
  b=BDZ3D/EDxoDSyoyimDF/5E5ucMg9Jlu7fNNs+ySNi2nvVegWBz+A+jDQ
   S22GbB3jtWhTUNeLKI2+RU+L5UncUIOViEihsYqjmnweeVKIJnlEllsXN
   /J6Np55pQROeeVPxWzoy+6AKzybx0IsaJCujUCjCfvShia7OZLmZ4l6nu
   1Z0xM/RdmNrtplTl1Gp8mTHywJ2dE1OsDouXvfnBFXxZ9BERXzZMOk8PQ
   Vj4KD7Y2aFzX8Ft01UMUTUvSsyLndgqy9lfbvLI85b++3rWAVjDwG86qy
   HbLkFiyL5u3YigzKm+NOZl/7inZ/Z0xRja4Jb214UrkHEeBpae/LpMQnd
   g==;
X-CSE-ConnectionGUID: l63WIjQnRRK4cytCXFRZKw==
X-CSE-MsgGUID: MxdnahnoQ6u4l8g+l88UGQ==
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="49716434"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 03:50:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 26 Nov 2025 03:50:12 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 26 Nov 2025 03:50:08 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <Parthiban.Veerasooran@microchip.com>, <piergiorgio.beruto@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Parthiban
 Veerasooran" <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 2/2] net: phy: microchip_t1s: add SQI support for LAN867x Rev.D0 PHYs
Date: Wed, 26 Nov 2025 16:19:55 +0530
Message-ID: <20251126104955.61215-3-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126104955.61215-1-parthiban.veerasooran@microchip.com>
References: <20251126104955.61215-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for Signal Quality Index (SQI) reporting in the
Microchip T1S PHY driver for LAN867x Rev.D0 (OATC14-compliant) PHYs.

This patch registers the following callbacks in the microchip_t1s driver
structure:

- .get_sqi      - returns the current SQI value
- .get_sqi_max  - returns the maximum SQI value

This enables ethtool to report the SQI value for LAN867x Rev.D0 PHYs.

Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 5a0a66778977..e601d56b2507 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -575,6 +575,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.get_plca_status    = genphy_c45_plca_get_status,
 		.cable_test_start   = genphy_c45_oatc14_cable_test_start,
 		.cable_test_get_status = genphy_c45_oatc14_cable_test_get_status,
+		.get_sqi            = genphy_c45_oatc14_get_sqi,
+		.get_sqi_max        = genphy_c45_oatc14_get_sqi_max,
 	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
-- 
2.34.1


