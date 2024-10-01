Return-Path: <netdev+bounces-130889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EFE98BE6D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750EE1F2442E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB31C5795;
	Tue,  1 Oct 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fo9ql/jW"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C91C5783;
	Tue,  1 Oct 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790687; cv=none; b=mDu0FXmi5bd3RmO1Amybckbh6/lx/oT97OD4H3/ubBcUf4lTij5bDrM+hs8mV6ItrGgajWeBQVnr4FMXQWXZ1onbikYaxHI3C6vVYTj0LhEO/aN726URJkYZeb3INSX8MQnIyVRb0aFCYQBsQoQu+AhA//nITc2c6j3u4O21b3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790687; c=relaxed/simple;
	bh=xfk6sO9sDW2Ddsv8scWV99zq1MGaAerIsbhg1d4kARA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UaHL8HgksUzY08cadOzsJqGg2y5HSk/96p5UnxHHbm8YAZZdaIRTb0td2hBWbIb/SAOLXjBM9Uz4sFmGKVBoxfdPoy0hDrL5Mx+By9uwL4vshCaZC40lBlUHBg3n2OPHcKjCD3OipkIc0M84gurryMMWcyXgt2AEIxNu7iiAEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fo9ql/jW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790685; x=1759326685;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xfk6sO9sDW2Ddsv8scWV99zq1MGaAerIsbhg1d4kARA=;
  b=Fo9ql/jWOykpUxLqi90VNL2Cy91uS/XRZsRlwvp6c04qnOR8PgQYm5PB
   HdaNuhWJhj3ddyIok2iWEQDm9JOBAxY5+uF9/rzW6ABZQ8dnn60sHwgjF
   CAKs/ij9IHyL/creW3aa8LXusXuFeAFomyQ3wWSncG3CLKIjcQ4KxxyUN
   ekydsMMce/21rIvShO8VF63UVinui5VNL3sWhQkdxV9Q+WC0meyqLvrvD
   9rnz0FEcsOQkHAm8T9whm0V9gFqDn6a+VE7sX2RRNPyfCZPIVP9Nqel0w
   A6qNHSKyBtorQste2hdDTct1RslMmlbuzXpb30p+2eKN8VNUuth5un98y
   Q==;
X-CSE-ConnectionGUID: +oQdX0lcTd+VPfROt+JSQg==
X-CSE-MsgGUID: Z7fujs2dQPqAvcR6B7HZfg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="33057480"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:13 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:10 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:34 +0200
Subject: [PATCH net-next 04/15] net: sparx5: modify SPX5_PORTS_ALL macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-4-8c6896fdce66@microchip.com>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x, we need to define the SPX5_PORTS_ALL macro
as 70 (65 front ports + 5 internal ports). This is required as the
SPX5_PORT_CPU will be redefined as a non-constant in a subsequent patch.
And as SPX5_PORTS_ALL is used as an array size troughout the code, we
have to make sure that it stays a constant.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index fdff83537418..824849869f61 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -52,13 +52,14 @@ enum sparx5_vlan_port_type {
 };
 
 #define SPX5_PORTS             65
+#define SPX5_PORTS_ALL         70 /* Total number of ports */
+
 #define SPX5_PORT_CPU          (SPX5_PORTS)  /* Next port is CPU port */
 #define SPX5_PORT_CPU_0        (SPX5_PORT_CPU + 0) /* CPU Port 65 */
 #define SPX5_PORT_CPU_1        (SPX5_PORT_CPU + 1) /* CPU Port 66 */
 #define SPX5_PORT_VD0          (SPX5_PORT_CPU + 2) /* VD0/Port 67 used for IPMC */
 #define SPX5_PORT_VD1          (SPX5_PORT_CPU + 3) /* VD1/Port 68 used for AFI/OAM */
 #define SPX5_PORT_VD2          (SPX5_PORT_CPU + 4) /* VD2/Port 69 used for IPinIP*/
-#define SPX5_PORTS_ALL         (SPX5_PORT_CPU + 5) /* Total number of ports */
 
 #define PGID_BASE              SPX5_PORTS /* Starts after port PGIDs */
 #define PGID_UC_FLOOD          (PGID_BASE + 0)

-- 
2.34.1


