Return-Path: <netdev+bounces-132051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EF99903FB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1031F218B9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A2219482;
	Fri,  4 Oct 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t/SDnhVR"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6021C169;
	Fri,  4 Oct 2024 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048053; cv=none; b=Qd+bIzjhYLxDpf+hLMm9cw6Cc22MS9H+YUoQQNpr8miYQyPq6UcqvTZYYOhoMDPzuJivGXmBBcoQI0h9dmdFnslvwS4UzpLWO+lRB8BMehZ+Y8e70pdYR+GI3qigYw8O47LskpYFLZbH8/vgsrleoYQu6zG4igyB7eYcMSRCLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048053; c=relaxed/simple;
	bh=GtT8dIXkCRQoalYMW20XchQAzYWReesIgKy2fhfGmEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HMPb+yjnPQfpdiN7KUyKTzdzfGx7lq+UO89HsFqzcinkRniAV6QUkTTmrY+LTqrHNpomnjyMkyGIJjhJSPsGx3Ks+Z6OJ+ZyRVkF5GM7MxYqrxnbUSujFqqGQRhmO8HsmKK665rrNnLfOmHlySzfeb58CcapOCAgkIubHEb6hXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t/SDnhVR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048052; x=1759584052;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GtT8dIXkCRQoalYMW20XchQAzYWReesIgKy2fhfGmEQ=;
  b=t/SDnhVRSqqQHx+uui552vX/NRbevHIBqty2v0Ki4K6o7cCQPDipbvJr
   90xLnCRKQq2SSXeSoXDHGtOCnrsPf6b+HdNYw/slG1jQunaN6EGrB402E
   SKtlRlci7rWzJvIZ8GCYrntwLBxCRmxGygxN0yBGMc4w5lwh6iY3JL7S0
   Aw+GGrJm4wwES/XcGbUEpsHYA+VUD6MAP1fvDI3tpgUf0H05d6G6G+Yj6
   VxRCbIKYNaS3uYH7UVUnORNO1TsFF5tH6PkH1PGPxUE7C5SMm1+S1bfvN
   fZdSjganE2CVDHdXN0W0zCLGaD4KbEadK2LpPx46AyTJYCNWnlzTQmlx1
   w==;
X-CSE-ConnectionGUID: ijig+GXpR1+FjNkYwRnQGA==
X-CSE-MsgGUID: 4W4zuG/XS2W8bpR3zChhew==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="32602257"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:40 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:37 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:37 +0200
Subject: [PATCH net-next v2 11/15] net: sparx5: ops out function for
 setting the port mux
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-11-d3290f581663@microchip.com>
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

Port muxing is configured based on the supported port modes. As these
modes can differ on Sparx5 and lan969x we ops out the port muxing
function.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 6 ++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 7 +++----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index fb677a4a58ee..33d89461f0f4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -992,6 +992,7 @@ static const struct sparx5_ops sparx5_ops = {
 	.get_port_dev_bit        = &sparx5_port_dev_mapping,
 	.get_hsch_max_group_rate = &sparx5_get_hsch_max_group_rate,
 	.get_sdlb_group          = &sparx5_get_sdlb_group,
+	.set_port_mux            = &sparx5_port_mux_set,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index b6abbae119c2..8d985dfb65eb 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -267,6 +267,8 @@ struct sparx5_ops {
 	u32  (*get_port_dev_bit)(struct sparx5 *sparx5, int port);
 	u32  (*get_hsch_max_group_rate)(int grp);
 	struct sparx5_sdlb_group *(*get_sdlb_group)(int idx);
+	int (*set_port_mux)(struct sparx5 *sparx5, struct sparx5_port *port,
+			    struct sparx5_port_config *conf);
 };
 
 struct sparx5_main_io_resource {
@@ -485,6 +487,10 @@ int sparx5_pool_get(struct sparx5_pool_entry *pool, int size, u32 *id);
 int sparx5_pool_get_with_idx(struct sparx5_pool_entry *pool, int size, u32 idx,
 			     u32 *id);
 
+/* sparx5_port.c */
+int sparx5_port_mux_set(struct sparx5 *sparx5, struct sparx5_port *port,
+			struct sparx5_port_config *conf);
+
 /* sparx5_sdlb.c */
 #define SPX5_SDLB_PUP_TOKEN_DISABLE 0x1FFF
 #define SPX5_SDLB_PUP_TOKEN_MAX (SPX5_SDLB_PUP_TOKEN_DISABLE - 1)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 49ff94db0e63..0dc2201fe653 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -516,9 +516,8 @@ static int sparx5_port_fifo_sz(struct sparx5 *sparx5,
 /* Configure port muxing:
  * QSGMII:     4x2G5 devices
  */
-static int sparx5_port_mux_set(struct sparx5 *sparx5,
-			       struct sparx5_port *port,
-			       struct sparx5_port_config *conf)
+int sparx5_port_mux_set(struct sparx5 *sparx5, struct sparx5_port *port,
+			struct sparx5_port_config *conf)
 {
 	u32 portno = port->portno;
 	u32 inst;
@@ -1039,7 +1038,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 	pcsinst = spx5_inst_get(sparx5, pcs, pix);
 
 	/* Set the mux port mode  */
-	err = sparx5_port_mux_set(sparx5, port, conf);
+	err = ops->set_port_mux(sparx5, port, conf);
 	if (err)
 		return err;
 

-- 
2.34.1


