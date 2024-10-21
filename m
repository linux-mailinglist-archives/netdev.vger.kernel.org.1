Return-Path: <netdev+bounces-137495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6787B9A6B45
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75861F220C7
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C11F470E;
	Mon, 21 Oct 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WeUDp6bz"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AE1F131C;
	Mon, 21 Oct 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519173; cv=none; b=Fmd7l3RltM0ywEkJkc9C18D+pqIibI0Ruax97pazIQ+2aFndwyDTqjsu9hpPo4REwxJ4UKtSZOgF26l2borlVzsRJdVKLRrbIrKTQvYEY04AIbW1T+HoKW4SXfgUshXhIj83lbE0Q3krerS/U34Q9Km+9D8I7yQ+7FZlL/Bwi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519173; c=relaxed/simple;
	bh=5BP7V8Lac3ajJdEEbTR+FHyuw9d1rUOtkz4eBPIA48A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ojQ1B8EaZBtiZS5fXOehMBcnw3Lgm3YltywRbqQGpV6QlnN3fKMYP1Eh80lg1cFMZGg6YNHJlG0ZwAcvNywUPODcHhfIDibPIcmjTooh41pc4ogbqPMiB6x4IVkRA4ICyGXjjuU34NrVBl7ZlC4Bu/juqs/aQ9gPpET5e9RcSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WeUDp6bz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519171; x=1761055171;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5BP7V8Lac3ajJdEEbTR+FHyuw9d1rUOtkz4eBPIA48A=;
  b=WeUDp6bzvRQONgQyMc1/1/J2ZBBycIrsQMxBFP6qZa16J1dmtPZ2T28D
   xntWiZCMojl7+dJAyBHdoY6a9Igsz+MyI1t6lnvCvK39oiP16jXl7SLMC
   yNVHy9BNn+p7T8kmHwNGeOstczibMt0axhwDZ1ppE/8xLA/P4JQczAHEL
   WDbsYC0RoRSZp70bgeHs1rM6J2FEAHfBYAYnfCELY5xeoT9+LDuAbQD5n
   /fcyXUHmWoKn/MtJtihzJ/M/n+IdwPGkTSIKyf1cU2ym2WLvqdJuWVUUj
   iGdUXNjKPZejfY4DFvjGO39HdouZb/7JzdwFo/Ng+oid/mrmFFyFyqpd+
   A==;
X-CSE-ConnectionGUID: vy9idxw6SZC3eWQLplrmOQ==
X-CSE-MsgGUID: s9v7KZqER1mceKI9uLtLCw==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="33285679"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 06:59:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:27 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:23 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:45 +0200
Subject: [PATCH net-next 08/15] net: lan969x: add constants to match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-8-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
	<ast@fiberby.net>, <maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add the lan969x constants to match data. These are already used
throughout the Sparx5 code (introduced in earlier series [1]), so no
need to update any code use.

[1] https://lore.kernel.org/netdev/20241004-b4-sparx5-lan969x-switch-driver-v2-0-d3290f581663@microchip.com/

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan969x/lan969x.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
index d99c1396e16a..0671347e2258 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
@@ -103,11 +103,32 @@ static const struct sparx5_regs lan969x_regs = {
 	.fsize = lan969x_fsize,
 };
 
+static const struct sparx5_consts lan969x_consts = {
+	.n_ports             = 30,
+	.n_ports_all         = 35,
+	.n_hsch_l1_elems     = 32,
+	.n_hsch_queues       = 4,
+	.n_lb_groups         = 5,
+	.n_pgids             = 1054, /* (1024 + n_ports) */
+	.n_sio_clks          = 1,
+	.n_own_upsids        = 1,
+	.n_auto_cals         = 4,
+	.n_filters           = 256,
+	.n_gates             = 256,
+	.n_sdlbs             = 496,
+	.n_dsm_cal_taxis     = 5,
+	.buf_size            = 1572864,
+	.qres_max_prio_idx   = 315,
+	.qres_max_colour_idx = 323,
+	.tod_pin             = 4,
+};
+
 const struct sparx5_match_data lan969x_desc = {
 	.iomap      = lan969x_main_iomap,
 	.iomap_size = ARRAY_SIZE(lan969x_main_iomap),
 	.ioranges   = 2,
 	.regs       = &lan969x_regs,
+	.consts     = &lan969x_consts,
 };
 
 MODULE_DESCRIPTION("Microchip lan969x switch driver");

-- 
2.34.1


