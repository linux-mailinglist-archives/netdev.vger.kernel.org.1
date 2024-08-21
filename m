Return-Path: <netdev+bounces-120423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D3795944B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 07:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5052C2854A6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 05:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940AA16BE16;
	Wed, 21 Aug 2024 05:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vUT6q02E"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19E8248D;
	Wed, 21 Aug 2024 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724219973; cv=none; b=G3ZBKur19fIBRV7qvyOC4jTZ7RVZzCPqjkS6pnDK0iC/oCR3nAK2rdWY4Fn8CcFU7JhV57Co6O2EOZ1FhPfMveFuQw+KnpwJeNbjFwbR5QOyH9Tob/7QVEPhkf2lDBt1hufBP1rwbK0M6qokmGU7ZDXDFdHR2t/Q0H469B0tqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724219973; c=relaxed/simple;
	bh=F4uSpGBjyqtODydI7+3cmvBUHxugdmb4gEUjWgBPkrY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIchu5QyaLz3gUOVePmMseuxXoFH7Nk1uHKQRcdI8EjZUqmRhwBWKZYG9qwGeQHSqIDab+Z2B91q/X4lkkicaKnOx201oTtC39GXLRldx4RgJmydywJlLmzSQ/HgbAA711NBnqj8AGVUynpwZXvLaI4dwX6QruiN4jBPgBToCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vUT6q02E; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724219972; x=1755755972;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=F4uSpGBjyqtODydI7+3cmvBUHxugdmb4gEUjWgBPkrY=;
  b=vUT6q02EsmbKBJwPdv7AoD+w9QjjajhzD9CSxb6d0YLlu081K8++pYwC
   KyfMhZ969qkBg8Zl0qGjZnUj6NjYEAIl3FnxNEzljVpEsDtj9t0uLdjmR
   FsWvGlGIfIVyK5r3fa3pNBz5jzG0wiZ2sU+tzcn9f5USMArDgEYjvlAzd
   XUxSBJEY1xpF2r3Mqw9PzkAIHoC52obG4qhooDHE66v3bbBZ6ZDjz9Cm3
   gRJo6O6ucA6b8qfxzUara+AoFpowC4q3Y255rxK4U6uc7DkrmKVhuDqqq
   HSCffYs7lLrKl8702nioy7JVeMHRaKIihGPsAtmT+51Q0NakZjYRiKmZ6
   g==;
X-CSE-ConnectionGUID: m4LuvgPcQx2UcMduyJ7hNQ==
X-CSE-MsgGUID: d0+FTfpoSkCtkPQfushpSA==
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="261650688"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2024 22:59:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Aug 2024 22:58:16 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 20 Aug 2024 22:58:12 -0700
From: Divya Koppera <Divya.Koppera@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 1/2] net: phy: Add phy library support to check supported list when autoneg is enabled
Date: Wed, 21 Aug 2024 11:29:05 +0530
Message-ID: <20240821055906.27717-2-Divya.Koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240821055906.27717-1-Divya.Koppera@microchip.com>
References: <20240821055906.27717-1-Divya.Koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Divya Koppera <divya.koppera@microchip.com>

Adds support in phy library to accept autoneg configuration only when
feature is enabled in supported list.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/phy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 785182fa5fe0..cba3af926429 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1089,7 +1089,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	if (autoneg != AUTONEG_ENABLE && autoneg != AUTONEG_DISABLE)
 		return -EINVAL;
 
-	if (autoneg == AUTONEG_ENABLE && linkmode_empty(advertising))
+	if (autoneg == AUTONEG_ENABLE &&
+	    (linkmode_empty(advertising) ||
+	     !linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				phydev->supported)))
 		return -EINVAL;
 
 	if (autoneg == AUTONEG_DISABLE &&
-- 
2.17.1


