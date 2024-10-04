Return-Path: <netdev+bounces-132052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09059903FF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F092814C8
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E847721C179;
	Fri,  4 Oct 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m8zEbXrA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68022219485;
	Fri,  4 Oct 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048054; cv=none; b=Z1qv+V/N5xkIJqmZlisN026UnZ6CLtplrZA+x7xYoU9wc186jqONcBo6eZZNdVIFUAYYFptDPjKhyB6q9uElOyAqOJ6OK4nh8DPoxOLcQGgBbltPQShoB4u/qaIHSbKAcqFpXgf4fDIT4hFIBqyUDw+YVljSAoqXOtcsZyhCJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048054; c=relaxed/simple;
	bh=hfzpNQys/id9m01aF8z14rGWYggvryDo1BAUlakEWWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BkizvG8g719SHEiHSIit+Jbi0b74iW0eLCMP90/QBFkTIZNvh9KPaM1j7amoefa1HYZdQ1kvILig2cgCZPfFe7BFOPmwjKp/FcgVuYG6fIRllKQW8qBO/dL+eWer1/EcF0hmVGiVFkIhc9cGb54oxg174BQ2n9BbwWsVrh7deyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=m8zEbXrA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048054; x=1759584054;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hfzpNQys/id9m01aF8z14rGWYggvryDo1BAUlakEWWA=;
  b=m8zEbXrAs+eEPfmZehJR9OmhT1aE4p6rcyIr8ax88iD4NQYxt2Cox2iH
   fyzDmQ0AGp4V2J/isgtOQc475JFW5po8uf33xREp7f7UBQdJoRA2f8rUu
   zbfcy7wwlKeIcS/VKirKptinENbN7bCnsaQg7btoaTsLjHI3ggJaMh0UB
   eLWwpE3N1fME4/12zrTX0h/1ALnDe+vSPvz0AHHQe007oDVsprn0/sMPT
   588MfUanAcUCnRxMVWFp1zsyml0oL498fD7u9C9bAaqwIYr6yI8SpNCtU
   g1nh82NX4ERlN1iWiC/qzETJ1C7tDM4mpWeaYPZVkChZOphkE+SWaZqFW
   Q==;
X-CSE-ConnectionGUID: ijig+GXpR1+FjNkYwRnQGA==
X-CSE-MsgGUID: Qa1+VJJHTv2SB7pwn3rPdA==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="32602259"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:43 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:40 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:38 +0200
Subject: [PATCH net-next v2 12/15] net: sparx5: ops out PTP IRQ handler
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-12-d3290f581663@microchip.com>
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

The PTP registers are located in two different register targets on
Sparx5 and lan969x. We can't handle this with the register macros, so
ops out the handler.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 4 +++-
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 33d89461f0f4..393ee5116004 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -605,6 +605,7 @@ static int sparx5_start(struct sparx5 *sparx5)
 {
 	u8 broadcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const struct sparx5_consts *consts = sparx5->data->consts;
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	char queue_name[32];
 	u32 idx;
 	int err;
@@ -729,7 +730,7 @@ static int sparx5_start(struct sparx5 *sparx5)
 
 	if (sparx5->ptp_irq >= 0) {
 		err = devm_request_threaded_irq(sparx5->dev, sparx5->ptp_irq,
-						NULL, sparx5_ptp_irq_handler,
+						NULL, ops->ptp_irq_handler,
 						IRQF_ONESHOT, "sparx5-ptp",
 						sparx5);
 		if (err)
@@ -993,6 +994,7 @@ static const struct sparx5_ops sparx5_ops = {
 	.get_hsch_max_group_rate = &sparx5_get_hsch_max_group_rate,
 	.get_sdlb_group          = &sparx5_get_sdlb_group,
 	.set_port_mux            = &sparx5_port_mux_set,
+	.ptp_irq_handler         = &sparx5_ptp_irq_handler,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 8d985dfb65eb..cc8ab91d9805 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -269,6 +269,8 @@ struct sparx5_ops {
 	struct sparx5_sdlb_group *(*get_sdlb_group)(int idx);
 	int (*set_port_mux)(struct sparx5 *sparx5, struct sparx5_port *port,
 			    struct sparx5_port_config *conf);
+
+	irqreturn_t (*ptp_irq_handler)(int irq, void *args);
 };
 
 struct sparx5_main_io_resource {

-- 
2.34.1


