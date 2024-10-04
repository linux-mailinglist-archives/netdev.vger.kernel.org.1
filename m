Return-Path: <netdev+bounces-132045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5539903ED
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA731C21F38
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB9215F54;
	Fri,  4 Oct 2024 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1ZO/sqoY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282872141D4;
	Fri,  4 Oct 2024 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048037; cv=none; b=ui0NvhXHKkwk7dK1nJ0ogmr27436FeADbYoKY+NRIrUDGvj0ZXKNekc2dgnThlgwIknAhVfpsvUHmThkaxIzgROaWkowZW/vjT9Pl4jKtq2O5BjSPAgIpamHLrORPnDY68NFAsHNeyPjre24h1VI4u5ShL3l3sf3Sy32lGb1SsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048037; c=relaxed/simple;
	bh=RG/qutaeH8Fc36ZlPYAKYZKB0GYK5VaA7rCS0Tha6nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YGNfUWNJFZnCAllAQVbYISikg4zBny+J7cdbeTNwHZ/D6VbF9ID0mW3dE8o9npIna5en6s4SWST7X6Z2IDBEmwOMX52TR1PKuvD02ZC7bwUpwY+V+y7CZS3DBlC+IQG1YcDaY+9v8i9ie1uOl6ZPKAho1CU4SA+QeVNOEBDWRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1ZO/sqoY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048036; x=1759584036;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RG/qutaeH8Fc36ZlPYAKYZKB0GYK5VaA7rCS0Tha6nw=;
  b=1ZO/sqoYQaZVSTw2fwb1tg9UEmSdfamY0kERgPQGo3hiH3Zk9ahqApcy
   l0b8efgAiAWE78AlwP24nbNsvCQYZe7+Pp06QeNcCM3LtTOKE3ikutb37
   gDdl/lYaIbi1/59/qZFgNnwkQ957xh4VRLEkZkCCcLNuiVHsyeINhbdYx
   QNiXY8UyjzhmyisZg0JcQG2hmM+Wpf5t8vv6JrNdBTVECgKwqrjDBdsih
   NhsFmJieaLLrLr6vOv9P9VTGtUOp0q+r2maTRwvXx8ACIs9WBaf5oA9i2
   6zZPWZbcQmtTKl+K8Zvxkr5/sRk8jiPfNGXNQaUG5WB6tnGQXTrHU3f2A
   g==;
X-CSE-ConnectionGUID: wYEhTCIITtS2MLde76jJ4w==
X-CSE-MsgGUID: XhSwcXWCTze8IoO5+B5+lw==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="32602246"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:20 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:17 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:31 +0200
Subject: [PATCH net-next v2 05/15] net: sparx5: add constants to match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-5-d3290f581663@microchip.com>
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

Add new struct sparx5_consts, containing all the chip constants that are
known to be different for Sparx5 and lan969x.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 21 +++++++++++++++++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 9a8d2e8c02a5..5f3690a59ac1 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -953,11 +953,32 @@ static const struct sparx5_regs sparx5_regs = {
 	.fsize = sparx5_fsize,
 };
 
+static const struct sparx5_consts sparx5_consts = {
+	.n_ports             = 65,
+	.n_ports_all         = 70,
+	.n_hsch_l1_elems     = 64,
+	.n_hsch_queues       = 8,
+	.n_lb_groups         = 10,
+	.n_pgids             = 2113, /* (2048 + n_ports) */
+	.n_sio_clks          = 3,
+	.n_own_upsids        = 3,
+	.n_auto_cals         = 7,
+	.n_filters           = 1024,
+	.n_gates             = 1024,
+	.n_sdlbs             = 4096,
+	.n_dsm_cal_taxis     = 8,
+	.buf_size            = 4194280,
+	.qres_max_prio_idx   = 630,
+	.qres_max_colour_idx = 638,
+	.tod_pin             = 4,
+};
+
 static const struct sparx5_match_data sparx5_desc = {
 	.iomap = sparx5_main_iomap,
 	.iomap_size = ARRAY_SIZE(sparx5_main_iomap),
 	.ioranges = 3,
 	.regs = &sparx5_regs,
+	.consts = &sparx5_consts,
 };
 
 static const struct of_device_id mchp_sparx5_match[] = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 549c04b1f2b3..6e6067568f2a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -238,6 +238,26 @@ struct sparx5_regs {
 	const unsigned int *fsize;
 };
 
+struct sparx5_consts {
+	u32 n_ports;             /* Number of front ports */
+	u32 n_ports_all;         /* Number of front ports + internal ports */
+	u32 n_hsch_l1_elems;     /* Number of HSCH layer 1 elements */
+	u32 n_hsch_queues;       /* Number of HSCH queues */
+	u32 n_lb_groups;         /* Number of leacky bucket groupd */
+	u32 n_pgids;             /* Number of PGID's */
+	u32 n_sio_clks;          /* Number of serial IO clocks */
+	u32 n_own_upsids;        /* Number of own UPSID's */
+	u32 n_auto_cals;         /* Number of auto calendars */
+	u32 n_filters;           /* Number of PSFP filters */
+	u32 n_gates;             /* Number of PSFP gates */
+	u32 n_sdlbs;             /* Number of service dual leaky buckets */
+	u32 n_dsm_cal_taxis;     /* Number of DSM calendar taxis */
+	u32 buf_size;            /* Amount of QLIM watermark memory */
+	u32 qres_max_prio_idx;   /* Maximum QRES prio index */
+	u32 qres_max_colour_idx; /* Maximum QRES colour index */
+	u32 tod_pin;             /* PTP TOD pin */
+};
+
 struct sparx5_main_io_resource {
 	enum sparx5_target id;
 	phys_addr_t offset;
@@ -246,6 +266,7 @@ struct sparx5_main_io_resource {
 
 struct sparx5_match_data {
 	const struct sparx5_regs *regs;
+	const struct sparx5_consts *consts;
 	const struct sparx5_main_io_resource *iomap;
 	int ioranges;
 	int iomap_size;

-- 
2.34.1


