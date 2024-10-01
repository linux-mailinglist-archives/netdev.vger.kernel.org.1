Return-Path: <netdev+bounces-130897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2F198BE86
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022D91F23DFB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063BE1C57A1;
	Tue,  1 Oct 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QRDW9Yrn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625FB1C4626;
	Tue,  1 Oct 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790714; cv=none; b=beM19d6xxQGIQOPBpfydNbS3wbCpBD6hXubYZodVrp6CLNeAmc3Bs5ee30aKEVheaKSpgw8BsOJ9xgP6FIlB9CTwMxFvK9JKw5OVQwtl+WZ6k93PKQDu1gzzUyb+NfJvGzvU7qJP059iDAO70XqvGfy/d3TgtSOk4qH6XvSp370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790714; c=relaxed/simple;
	bh=WxZUw5Iu9ITp1yUHTTGXGxcIvY1n/K/E/kREJ32sbHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Bm+Xw4TJwq0URZMWGEWE8+dU1XUCF7wb5DQopJl10qwA7ya1Qj51cnK3p+Z8IV4X0UEDtgZ90IJtAxxbYuGCRyaCnLIRsoslOTzzkS0vEjWjOnT0KQUi1Pp28BPX7M+As24L2mbcSpM1yB91Dp1CmfdYW6TDebrVVRIj0YnsPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QRDW9Yrn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790713; x=1759326713;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WxZUw5Iu9ITp1yUHTTGXGxcIvY1n/K/E/kREJ32sbHc=;
  b=QRDW9Yrn5oOqiNderrToIbtasZX3QFKQdiCjc4hMSn+N4SHVGuVlRPj/
   oAhcJhTu4NJrmcNuJZg5BwYxZb1w6QCCNAy0hrBA/hU3uSLejGUanl0A2
   LSOZA/0W5z+urC3Tvv2i3sL8uPK1vqA3n4GVT6J1DiGQOJBaDPsJwwYTY
   E2fQe+YWo4dto6k0O0wLMXGIhJDMbhXpghZr8AGzYUcw+4tu6+MjmNQTF
   m3t1Pgt7zmE44/hrervHObMvglhdnA4gQzQxMPUsNhlqcyX+6k910ZF4Z
   qw0JMq/yN2aypI/2efqzCvziWK7kbreStANm5SajakhDd1B1tnhhDEWZ1
   Q==;
X-CSE-ConnectionGUID: PEtbMb/SSnq9y/Yd81naGA==
X-CSE-MsgGUID: PEGk2SV1RGKr3wZBMMnrsQ==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="199893170"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:32 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:29 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:40 +0200
Subject: [PATCH net-next 10/15] net: sparx5: ops out chip port to device
 index/bit functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-10-8c6896fdce66@microchip.com>
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

The chip port device index and mode bit can be obtained using the port
number.  However the mapping of port number to chip device index and
mode bit differs on Sparx5 and lan969x. Therefore ops out the function.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 2 ++
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 2 ++
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 4 +++-
 drivers/net/ethernet/microchip/sparx5/sparx5_port.h | 7 ++++++-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 8b1033c49cfe..8617fc3983cc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -982,6 +982,8 @@ static const struct sparx5_ops sparx5_ops = {
 	.is_port_5g              = &sparx5_port_is_5g,
 	.is_port_10g             = &sparx5_port_is_10g,
 	.is_port_25g             = &sparx5_port_is_25g,
+	.get_port_dev_index      = &sparx5_port_dev_mapping,
+	.get_port_dev_bit        = &sparx5_port_dev_mapping,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 5a8a37681312..68d5a14603dc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -265,6 +265,8 @@ struct sparx5_ops {
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


