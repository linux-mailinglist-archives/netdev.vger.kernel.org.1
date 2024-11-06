Return-Path: <netdev+bounces-142507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C1A9BF622
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB7A2842C7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386CB209667;
	Wed,  6 Nov 2024 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rRGtTFbL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F720821A;
	Wed,  6 Nov 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730920674; cv=none; b=sEW70yo7VU8ks8K+7H/JO7euB5bDj6j0XqvkUE63fTjeab3VTb3Mbps918CaP3EWJiNJdd2Qjf7OTmWkrZ22QtiFX+zCR/5f6B6dadmBYFgzzFa+gD1cwuIlRQdWuZSd1R95j212kxT6TCIBYLh080RhNexY1z3Tzj3qs6RBswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730920674; c=relaxed/simple;
	bh=cgom0XLVb7MaTSRccOyx5KEK7+2ZljOgMuvXNaIHKOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a3H82t8FpO6sSB7gxpy4aXomScE/NY+2X0HkwlI3ULV0ZLo/UAdBxMhcQhyOyQb1rPRfhSU3YQVfoA1BwOwhXgifgjBGpTwmMoHKDDgwLLxyr17BXM4saXV7nlodIXMpq1XJz6nZnjSyMkELOhQqkyAPgcPLob3T//35Uo607ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rRGtTFbL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730920672; x=1762456672;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cgom0XLVb7MaTSRccOyx5KEK7+2ZljOgMuvXNaIHKOc=;
  b=rRGtTFbL6X5vQ/IhYXhtYyKwQEtErcMZbhIk8Lqd+tdOmocFNmUuzQrO
   37UXUK2oLRA4Ll+yYt/3G8jG2lETzn3m1NCcKPEpgxNIO9z8orGRnagbY
   /74Rxam3QyAW83z08rVRjlvUt6y1Em23FKr+nKOvcHAws3fboRNWXuURj
   bEaoDRG9LN97OK6JVmKi+pX2qaNEE9/Ckr383cnGm8QB8EYKN+whDKYf3
   OwDa/RqtrVNSULFX+0KODdxL5Y4FB1VWaURlikg0xoGtZ7nnbjQaxivB2
   E/eOcr8u++Q0TiMTJw8EbC4p6J34d5i3XlO8eGvoWpzCk75kTvilK54PI
   A==;
X-CSE-ConnectionGUID: R5B6jnU1TTWc0t0C0FxLpw==
X-CSE-MsgGUID: w0A8VUaBTi6K7IcrHbqf9g==
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="37447981"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2024 12:17:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Nov 2024 12:17:08 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Nov 2024 12:17:06 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 6 Nov 2024 20:16:40 +0100
Subject: [PATCH net-next 2/7] net: sparx5: add function for RGMII port
 check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241106-sparx5-lan969x-switch-driver-4-v1-2-f7f7316436bd@microchip.com>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
In-Reply-To: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14-dev

The lan969x device contains two RGMII interfaces, sitting at port 28 and
29. Add function: is_port_rgmii() to the match data ops, that checks if
a given port is an RGMII port or not. For Sparx5, this function always
returns false.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan969x/lan969x.c    | 1 +
 drivers/net/ethernet/microchip/lan969x/lan969x.h    | 5 +++++
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_port.h | 5 +++++
 5 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
index 79e5bcefbd73..8ac2652ef22c 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
@@ -326,6 +326,7 @@ static const struct sparx5_ops lan969x_ops = {
 	.is_port_5g              = &lan969x_port_is_5g,
 	.is_port_10g             = &lan969x_port_is_10g,
 	.is_port_25g             = &lan969x_port_is_25g,
+	.is_port_rgmii           = &lan969x_port_is_rgmii,
 	.get_port_dev_index      = &lan969x_port_dev_mapping,
 	.get_port_dev_bit        = &lan969x_get_dev_mode_bit,
 	.get_hsch_max_group_rate = &lan969x_get_hsch_max_group_rate,
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.h b/drivers/net/ethernet/microchip/lan969x/lan969x.h
index 7ce047ad9ca4..47e2adce1bbb 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.h
@@ -51,6 +51,11 @@ static inline bool lan969x_port_is_25g(int portno)
 	return false;
 }
 
+static inline bool lan969x_port_is_rgmii(int portno)
+{
+	return portno == 28 || portno == 29;
+}
+
 /* lan969x_calendar.c */
 int lan969x_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 			      struct sparx5_calendar_data *data);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 4f2d5413a64f..1c12ea0e6fd3 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -1070,6 +1070,7 @@ static const struct sparx5_ops sparx5_ops = {
 	.is_port_5g              = &sparx5_port_is_5g,
 	.is_port_10g             = &sparx5_port_is_10g,
 	.is_port_25g             = &sparx5_port_is_25g,
+	.is_port_rgmii           = &sparx5_port_is_rgmii,
 	.get_port_dev_index      = &sparx5_port_dev_mapping,
 	.get_port_dev_bit        = &sparx5_port_dev_mapping,
 	.get_hsch_max_group_rate = &sparx5_get_hsch_max_group_rate,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 91ae383a5555..a622c01930e7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -313,6 +313,7 @@ struct sparx5_ops {
 	bool (*is_port_5g)(int portno);
 	bool (*is_port_10g)(int portno);
 	bool (*is_port_25g)(int portno);
+	bool (*is_port_rgmii)(int portno);
 	u32  (*get_port_dev_index)(struct sparx5 *sparx5, int port);
 	u32  (*get_port_dev_bit)(struct sparx5 *sparx5, int port);
 	u32  (*get_hsch_max_group_rate)(int grp);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
index 9b9bcc6834bc..c8a37468a3d1 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.h
@@ -40,6 +40,11 @@ static inline bool sparx5_port_is_25g(int portno)
 	return portno >= 56 && portno <= 63;
 }
 
+static inline bool sparx5_port_is_rgmii(int portno)
+{
+	return false;
+}
+
 static inline u32 sparx5_to_high_dev(struct sparx5 *sparx5, int port)
 {
 	const struct sparx5_ops *ops = sparx5->data->ops;

-- 
2.34.1


