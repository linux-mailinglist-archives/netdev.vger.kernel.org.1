Return-Path: <netdev+bounces-132042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A29903E8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31942812A2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290D2139C8;
	Fri,  4 Oct 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BKxATugM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD232139AF;
	Fri,  4 Oct 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048033; cv=none; b=TsdaeYhFyanY8BnTaX44d4WMCfB8ClA6NQ8bPmRutAbi8fB5/v83BSqfBh2Wgk1wF/bAr9Gq+DF0qwcglGI1O8O5aLh3qQ6luEPORNYQPpGglOdW5k805UFKcf08dplZjmoN6LRwpVjONApGOp43fFqetrMrztZaD7J5K7+6RmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048033; c=relaxed/simple;
	bh=CgHV7zzECy6AFjL6MoJBT+5hW9Hpgx+yuI+1h+oezOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=APIze7m7Bnz9tF0cSNthQxnairHQWFSVuUiCcprUQR6MWuyVxR5mco/sJO/4XaE/2Gcotcs6fi8ShIiSoBx+qo1qoFd5uF/qBlMoCTR8en9C4FxBpIg3Uhgyqhs7adlwJKAiODI8l8ZlMuYh34iGbhltbtTePKn2glnGPizGhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BKxATugM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048031; x=1759584031;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CgHV7zzECy6AFjL6MoJBT+5hW9Hpgx+yuI+1h+oezOg=;
  b=BKxATugM4k7QKJ71w8qvO7KowkRzSHX3iXNkUGv9xXOY+PAYmjuO7mgy
   pKfpjJoRJIlR1kTp85RLiFYsn7Hcg1vgSP1msu+SA9SQxGbLYY9Aj6Zp1
   64F3T0cLS19sOhpfEcfgtmkecwPYDiHHpvKcKF+t4igObZktg3JO6slxe
   puhsRTTIuM1NO7XCmbdrLblbfDaCcCuOWlnTofpnKc/AYCt4kUE7eIk2V
   s8mokSiMstr6I6+sxEZ5TPjBEekiEI4BsrrE1/ymm/I9HEnv5MEb/9PTg
   MBP0kcT47n4RU903DRSssXtTQFkS4dam5pRy2pXcgJCCW2DdW9kS8by2n
   Q==;
X-CSE-ConnectionGUID: UTORMraqRXG6dgK0XgLrnQ==
X-CSE-MsgGUID: jQK1bQYlRo6NuRifnInbvw==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="35903131"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:13 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:10 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:29 +0200
Subject: [PATCH net-next v2 03/15] net: sparx5: modify SPX5_PORTS_ALL macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-3-d3290f581663@microchip.com>
References: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
In-Reply-To: <20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>, <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x, we need to define the SPX5_PORTS_ALL macro
as 70 (65 front ports + 5 internal ports). This is required as the
SPX5_PORT_CPU will be redefined as an offset to the number of front
ports, in a subsequent patch.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 31c212bdbaae..4988d9b90286 100644
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


