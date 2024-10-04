Return-Path: <netdev+bounces-132049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F69903F7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5522817ED
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FB621B426;
	Fri,  4 Oct 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ons91XPI"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4821732F;
	Fri,  4 Oct 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048041; cv=none; b=kXz/l0iRyL+hkoW9NNhdMFzwPtwPXQg53a/M5JuPNV+nco26HEzXnNMJfcyH6vzUr8g0TqElahLj05ebA09NNITyyrX5MaIddUvNuwox8aZqz60Wdz/9u9C6Qk0Hg1Q8lL1D/DvJdmv2UuBeE/xjX9s4cMkrWNj9abim5yCLe6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048041; c=relaxed/simple;
	bh=f0xO0nf2oD9tsdpo4G0Qf8+9ZHsGHAnov16+K59bY3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xybvo+UAL/s71Lb1IoSgHiWZ8xTiRGDQiU4suifyZ5xFamdOUdXe1HnwPdmZwz+xTyOE+Wc+b8xzRZ1N9KMwoLdeu7SA3nMqAbVFUV7gUhNIx5ysGCxOVraLum6QGb7zy5Wg1CSc2aLekKlmTIKAbcSy/Fovna5e/FVhyKD8kNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ons91XPI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728048039; x=1759584039;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=f0xO0nf2oD9tsdpo4G0Qf8+9ZHsGHAnov16+K59bY3s=;
  b=Ons91XPIc2JUuLYZJg1NMmbymDsx0GBbOi6ml7OTFYiH9iYa2gTl35k1
   zbD4iHX8MLB5SwXSB9xy7hv/OnGZgxhdOp6e3S3oP6MTWXo70tJdFkOXj
   VGMkXqHNP/piHsCxVozeTjOOSPa1J3LffKSXtTPlsMKOKDVoQwvz9vFXw
   EbPn+vKX/EMNlDVfc5QtVcjcEcrgBSPPCGjWralyIwSYsRCm3lO5LQLGj
   8B1wQj/HrGpIYZy838fuoFbG8qOYsw3y+SnB1HYT22PNnkdp9aW+RnTOt
   91jXvwxCC5Pq5tJBldwN3qVNS19p5oefPCH88xPWieNRsC3lKoRxxr6X9
   g==;
X-CSE-ConnectionGUID: Ejn4MYkwTnyyTXQz7FKjZw==
X-CSE-MsgGUID: LnSuuUdBQgmQFOkqvcRZGg==
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="35903140"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2024 06:20:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 4 Oct 2024 06:20:33 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 4 Oct 2024 06:20:30 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 4 Oct 2024 15:19:35 +0200
Subject: [PATCH net-next v2 09/15] net: sparx5: ops out chip port to device
 index/bit functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-sparx5-lan969x-switch-driver-v2-9-d3290f581663@microchip.com>
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

The chip port device index and mode bit can be obtained using the port
number.  However the mapping of port number to chip device index and
mode bit differs on Sparx5 and lan969x. Therefore ops out the function.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 2 ++
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 2 ++
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 4 +++-
 drivers/net/ethernet/microchip/sparx5/sparx5_port.h | 7 ++++++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 77abb966b6b5..c30ccca72c78 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -988,6 +988,8 @@ static const struct sparx5_ops sparx5_ops = {
 	.is_port_5g              = &sparx5_port_is_5g,
 	.is_port_10g             = &sparx5_port_is_10g,
 	.is_port_25g             = &sparx5_port_is_25g,
+	.get_port_dev_index      = &sparx5_port_dev_mapping,
+	.get_port_dev_bit        = &sparx5_port_dev_mapping,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index f3716bd2f9a2..f7e1b7d18f81 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -263,6 +263,8 @@ struct sparx5_ops {
 	bool (*is_port_5g)(int portno);
 	bool (*is_port_10g)(int portno);
 	bool (*is_port_25g)(int portno);
+	u32  (*get_port_dev_index)(struct sparx5 *sparx5, int port);
+	u32  (*get_port_dev_bit)(struct sparx5 *sparx5, int port);
 };
 
 struct sparx5_main_io_resource {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index c5dfe0fa847b..49ff94db0e63 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -847,8 +847,10 @@ static int sparx5_port_pcs_high_set(struct sparx5 *sparx5,
 /* Switch between 1G/2500 and 5G/10G/25G devices */
 static void sparx5_dev_switch(struct sparx5 *sparx5, int port, bool hsd)
 {
-	int bt_indx = BIT(sparx5_port_dev_index(sparx5, port));
 	const struct sparx5_ops *ops = sparx5->data->ops;
+	int bt_indx;
+
+	bt_indx = BIT(ops->get_port_dev_bit(sparx5, port));
 
 	if (ops->is_port_5g(port)) {
 		spx5_rmw(hsd ? 0 : bt_indx,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
index 934e2d3dedbb..9b9bcc6834bc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
@@ -62,7 +62,7 @@ static inline u32 sparx5_to_pcs_dev(struct sparx5 *sparx5, int port)
 	return TARGET_PCS25G_BR;
 }
 
-static inline int sparx5_port_dev_index(struct sparx5 *sparx5, int port)
+static inline u32 sparx5_port_dev_mapping(struct sparx5 *sparx5, int port)
 {
 	if (sparx5_port_is_2g5(port))
 		return port;
@@ -74,6 +74,11 @@ static inline int sparx5_port_dev_index(struct sparx5 *sparx5, int port)
 	return (port - 56);
 }
 
+static inline u32 sparx5_port_dev_index(struct sparx5 *sparx5, int port)
+{
+	return sparx5->data->ops->get_port_dev_index(sparx5, port);
+}
+
 int sparx5_port_init(struct sparx5 *sparx5,
 		     struct sparx5_port *spx5_port,
 		     struct sparx5_port_config *conf);

-- 
2.34.1


