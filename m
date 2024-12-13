Return-Path: <netdev+bounces-151776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483C79F0D75
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9FB169FB5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D11E04BA;
	Fri, 13 Dec 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mMjTNnxM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC431E00AC;
	Fri, 13 Dec 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097292; cv=none; b=i6mefinTyXNivwChVJaAoOjFLZGctFmS8FO6cKcmrEzYA1a2gcimvsePTagGhr/Y07f3gw8gvl3xX79SU3CCorO6fkR7VG8Sw/PkqYJiezmFLz2PS+NNIDDsFl0ic3iThs08pe9UwRVxOHTuDJQnr2KqsXm4h0Wn+DWrbMIxlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097292; c=relaxed/simple;
	bh=Sd0oI6XCPca97fcgsJXxgyFTXR5Wx87gDdH1RGxijHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jRmUav8DkKSGYbaeaKHrq3w+x0CV3xAq5deFZasZgPMozZtmf4WQnod/HtR/ohBdrRGw6Y3z9NV6/MPmR580XbiT/sSR/zC/wo4wCPOiomujUL7btlEc+nN751IclwSkqcmuoLZF91RtlgdvZpzYFa100saarK2v76T++YGqLGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mMjTNnxM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734097291; x=1765633291;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Sd0oI6XCPca97fcgsJXxgyFTXR5Wx87gDdH1RGxijHI=;
  b=mMjTNnxMEtesUyoTW2ERMemXdI3OlBgIPUkBLj5U4+KxUrttBIlcZNMo
   Jz+zhHjNBMN66yzv+E7+zrxObreXOByaLYq1PmaJs6gDr7HFclqFAsrlQ
   kmkwT4CP/2nvR3LcSWY0zWYeMjetNtAPB+osQXjuZP91OM1s+2iS460zm
   BUl6SfxlrMj1lQVcVrR/DN89YZo3iCrrnrthbIL/C2kPmwJkWZ09QIQZr
   sgBlAXpngDs5nl4PUb4zU8bYNz6rSNPmiZkwBLwuYIjoJJXEvbMxtUMah
   8kdz7kDvP9lzNsrOQk2zy0YtQZGW1LjsMsxJ/10ngTGph4DzAPdD8WDys
   A==;
X-CSE-ConnectionGUID: +Dz6lc3EQgqK8+CPf2Bkrw==
X-CSE-MsgGUID: pU7JcS+VTeC2GojpRg3jIw==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="202965471"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 06:41:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 06:41:22 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 06:41:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 13 Dec 2024 14:41:01 +0100
Subject: [PATCH net-next v4 2/9] net: sparx5: add function for RGMII port
 check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241213-sparx5-lan969x-switch-driver-4-v4-2-d1a72c9c4714@microchip.com>
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
In-Reply-To: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
	<jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<robert.marko@sartura.hr>
X-Mailer: b4 0.14-dev

The lan969x device contains two RGMII port interfaces, sitting at port
28 and 29. Add function: is_port_rgmii() to the match data ops, that
checks if a given port is an RGMII port or not. For Sparx5, this
function always returns false.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c | 1 +
 drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h | 5 +++++
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c     | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h     | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_port.h     | 5 +++++
 5 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index c2afa2176b08..76f0c8635eb9 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -329,6 +329,7 @@ static const struct sparx5_ops lan969x_ops = {
 	.is_port_5g              = &lan969x_port_is_5g,
 	.is_port_10g             = &lan969x_port_is_10g,
 	.is_port_25g             = &lan969x_port_is_25g,
+	.is_port_rgmii           = &lan969x_port_is_rgmii,
 	.get_port_dev_index      = &lan969x_port_dev_mapping,
 	.get_port_dev_bit        = &lan969x_get_dev_mode_bit,
 	.get_hsch_max_group_rate = &lan969x_get_hsch_max_group_rate,
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
index 2489d0d32dfd..4b91c47d6d21 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.h
@@ -59,6 +59,11 @@ static inline bool lan969x_port_is_25g(int portno)
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
index f61aa15beab7..4be717ba7d37 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -1072,6 +1072,7 @@ static const struct sparx5_ops sparx5_ops = {
 	.is_port_5g              = &sparx5_port_is_5g,
 	.is_port_10g             = &sparx5_port_is_10g,
 	.is_port_25g             = &sparx5_port_is_25g,
+	.is_port_rgmii           = &sparx5_port_is_rgmii,
 	.get_port_dev_index      = &sparx5_port_dev_mapping,
 	.get_port_dev_bit        = &sparx5_port_dev_mapping,
 	.get_hsch_max_group_rate = &sparx5_get_hsch_max_group_rate,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index d5dd953b0a71..c58d7841638e 100644
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


