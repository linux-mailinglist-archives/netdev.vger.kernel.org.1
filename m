Return-Path: <netdev+bounces-138425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D69AD74B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BC31C229EF
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FAE206972;
	Wed, 23 Oct 2024 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O26TKyKx"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810641FF7D9;
	Wed, 23 Oct 2024 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720981; cv=none; b=LBr+qabRQaZvSMJn6/MpRHI1crPHgwAlEfynMAl6D5i/BC8FdtQ/FV+Q71ieeOlebWoIgSpF7ZUgftmzB0YY78pg65CYs5K+bLf1xRrxgh5Nwl2nw5mhlFfkxcF4ltcwgfxkG7cOMikZ4OC9GZ/b4DrK8T7tmG57XVRTKPc97XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720981; c=relaxed/simple;
	bh=0bLSVHi3wmgkjuXooygdVcmkriLaq4Scp7XshwDEe9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W8G8f3bOj9dMff3mrS8sGLGbDHLmeJt4KRaL5J4zvRcVSaPLl9GY5796ZzdEWH9hkByXtSqLIqgGF1+GLfx1H9Hxf7MSzZ7jrO24vsCfjxDklK1Nsoq0NsqgZ0bTDIXeLpiXrDq7vaS44LJwCscTFaaHEdtjr0mrGLSRn1Rd/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O26TKyKx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729720979; x=1761256979;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0bLSVHi3wmgkjuXooygdVcmkriLaq4Scp7XshwDEe9M=;
  b=O26TKyKx1levDQILbVa6ftwfrNHjur6zorcwMy9Vjnu/BnXGcpTU96eQ
   sbr77KSpLyUBYRtWh7BARiUt43JwVSNbQwI/wPt9yWVZHuoeL+OWoEZA7
   fmZGctDAw6axTSHIjOOIiD52j8tDez3YHmIVKbmkL1P4gXcbUuoH4enDW
   738qlGSP+iyEImLg5Br4qMJtkSxKgsE2AXwkYL58RuMlmGDy4orLyN4OG
   zwWDGgGgRCSstnxvCb23yAHk4tk95RatL9GCi+0852E2HtaVBbr4vkM+N
   lEk/0o6fZqfWDi4ecItzba/XQjbriqhL3r+XdySMNbwt9psgQwpFQJJJ/
   A==;
X-CSE-ConnectionGUID: oMPErp9qRFmiMc0P9W4Bgw==
X-CSE-MsgGUID: YgZYLg6ZTMm8JQNyIr1uWA==
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="264507061"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 15:02:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 23 Oct 2024 15:02:38 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 23 Oct 2024 15:02:34 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Oct 2024 00:01:33 +0200
Subject: [PATCH net-next v2 14/15] net: sparx5: add compatible string for
 lan969x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-sparx5-lan969x-switch-driver-2-v2-14-a0b5fae88a0f@microchip.com>
References: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
In-Reply-To: <20241024-sparx5-lan969x-switch-driver-2-v2-0-a0b5fae88a0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add lan9691-switch compatible string to mchp_sparx5_match. Guard it with
IS_ENABLED(CONFIG_LAN969X_SWITCH) to make sure Sparx5 can be compiled on
its own.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 741404ccd8f5..fde9e06b3458 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -24,6 +24,8 @@
 #include <linux/types.h>
 #include <linux/reset.h>
 
+#include "../lan969x/lan969x.h" /* for lan969x match data */
+
 #include "sparx5_main_regs.h"
 #include "sparx5_main.h"
 #include "sparx5_port.h"
@@ -1050,6 +1052,9 @@ static const struct sparx5_match_data sparx5_desc = {
 
 static const struct of_device_id mchp_sparx5_match[] = {
 	{ .compatible = "microchip,sparx5-switch", .data = &sparx5_desc },
+#if IS_ENABLED(CONFIG_LAN969X_SWITCH)
+	{ .compatible = "microchip,lan9691-switch", .data = &lan969x_desc },
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mchp_sparx5_match);

-- 
2.34.1


