Return-Path: <netdev+bounces-130900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A0D98BE92
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E831F20FED
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B8F1C9ED3;
	Tue,  1 Oct 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mT8MuNUA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF81C9DEB;
	Tue,  1 Oct 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790718; cv=none; b=hBrY3P4qsnNMLI/jwz8UETb471xm6WWdB0qNk3Z0C9L3Nvy3eQBWyltGmoKccqJbKf2HK6f+TwMx9ff6UTS33UX2B6LXmCsejvb5RNkaNIOYYqpxK2DGf8ecbGXUOU+xI469lT+b+fd/BXhjIKmGlSjLFincJZuhxHMkQDgZ8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790718; c=relaxed/simple;
	bh=hZYncEl3PuX7Sc7txgxvih4Nm58EQ3JxK90o7N0HGc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d6DzHrIEyuIffE4k08Y2iEMFFNf95oafaDD24XkviP0xOfJhr/l0muGG79or7UnRtM8U9wEvRGMo5Z+N9xEYwYXvQHLtbmJ8l+mrAvr4ZiPDqrxjmMzKtwcmhD6rFpQ/7v9rt3Jza4nzDE3zruSFV3XWVPUq3srSYlP/nXUyoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mT8MuNUA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790716; x=1759326716;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hZYncEl3PuX7Sc7txgxvih4Nm58EQ3JxK90o7N0HGc4=;
  b=mT8MuNUABNv+9Ltlt2IQADQlPxLoennZsnyStsHUYvRGf5ZQ3sJmcVIz
   p9CBl2ehjhXPHCLge+LHLJQokftX67uqKICdX7RD8JD1pzt+jaFol4eqC
   U3Kgj8ZjR9C7tmZdQ/2Hz8ZHi6sDY0L5FnRWaJBxb6WcZFXQkt0OwZAfk
   gHW8amQ616LwLfZdMk2nmapDzCuxXM0vwu8kUE8/G7pqjTAShxs5gbdIa
   +msd3QsnIJM4Q4/GBhk7mkx5CbM/3RylQ4tbHVeO7RpN+FjXwl8hY9aYU
   cuAsMpW42uJ5eqtvKz8fn5mlS8C0Yym1s0BQQD1FuOWG4oXLnM4FrbOwb
   g==;
X-CSE-ConnectionGUID: PEtbMb/SSnq9y/Yd81naGA==
X-CSE-MsgGUID: ORqmDQhcRqS/k0bgg1X8vw==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="199893173"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:42 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:39 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:43 +0200
Subject: [PATCH net-next 13/15] net: sparx5: ops out PTP IRQ handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-13-8c6896fdce66@microchip.com>
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

The PTP registers are located in two different register targets on
Sparx5 and lan969x. We can't handle this with the register macros, so
ops out the handler.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 4 +++-
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index bcdce23b735f..c5239e547c35 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -599,6 +599,7 @@ static void sparx5_board_init(struct sparx5 *sparx5)
 static int sparx5_start(struct sparx5 *sparx5)
 {
 	u8 broadcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	char queue_name[32];
 	u32 idx;
 	int err;
@@ -723,7 +724,7 @@ static int sparx5_start(struct sparx5 *sparx5)
 
 	if (sparx5->ptp_irq >= 0) {
 		err = devm_request_threaded_irq(sparx5->dev, sparx5->ptp_irq,
-						NULL, sparx5_ptp_irq_handler,
+						NULL, ops->ptp_irq_handler,
 						IRQF_ONESHOT, "sparx5-ptp",
 						sparx5);
 		if (err)
@@ -987,6 +988,7 @@ static const struct sparx5_ops sparx5_ops = {
 	.get_hsch_max_group_rate = &sparx5_get_hsch_max_group_rate,
 	.get_sdlb_group          = &sparx5_get_sdlb_group,
 	.set_port_mux            = &sparx5_port_mux_set,
+	.ptp_irq_handler         = &sparx5_ptp_irq_handler,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 6fe840dbaf98..eb71bba02a77 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -271,6 +271,8 @@ struct sparx5_ops {
 	struct sparx5_sdlb_group *(*get_sdlb_group)(int idx);
 	int (*set_port_mux)(struct sparx5 *sparx5, struct sparx5_port *port,
 			    struct sparx5_port_config *conf);
+
+	irqreturn_t (*ptp_irq_handler)(int irq, void *args);
 };
 
 struct sparx5_main_io_resource {

-- 
2.34.1


