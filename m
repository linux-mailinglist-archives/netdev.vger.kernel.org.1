Return-Path: <netdev+bounces-138420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095369AD73B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA48F284B27
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2AF201024;
	Wed, 23 Oct 2024 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q1ePmOIa"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13101FE0E6;
	Wed, 23 Oct 2024 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720962; cv=none; b=QhCBkkSvtEJ7kqZX9PXocu9V+Xv0ZyFGkyyw4bXIeqbu9r9Fz3kFIybEYVki9vHOy/hl2QpeDF/YyrT/4jrjDHTBRf25zBd2Nrtf9rrJxAFb09QAX9wyA5O2BTS3hMjAQOEm6RMSXDXUfdsB4A9NGryeDkM+v6VhH8kJBMRDgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720962; c=relaxed/simple;
	bh=vwMgBh8rF4YruDkEUaNvk44Eb8em21K29W9Ne4EAcnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jGtuC0PDwIYtEkKQ8h+/PpUQh2iVMSb4TAzOXh66CkjQnM7yDpCHDXjA3EcFPlykoFNdt2TGjAU6h+SL/GmSBqMNQ5Yi9QL++IdzRP/T82AVERPItAJ2xVQeSo3Q8Sm+H/YEEHCfDR8UZvbeS09BobMqnd0bPdtxM/ujsYgxYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q1ePmOIa; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729720959; x=1761256959;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vwMgBh8rF4YruDkEUaNvk44Eb8em21K29W9Ne4EAcnA=;
  b=q1ePmOIaEQZOlEimH/rsUKiFXR0ZDjTRNPfb06S8can5AiB6yB2gFxCJ
   /A9zEhuF9VnRlsaIIBDNd0FHdCCDilt6df5c5DbyLaixEHsiAaR64ZaNo
   4K2nICUFIuput/1NySeG5EhNkA//JymOFRXvmESdEDw6+0+iyHDgwXJA8
   ITlN5rkM85WgOMpGM7zyN11lzktc2Y+yAyGvhMKCUPySiqrQb9AeZKsOH
   z4BJQp2ovtDldD/VoD0cojTm7zy5zkIOrcbBJBNI+PSFCqa3Ur0jW/6LG
   ugHRHPTSwJ9J07ZNAoyQnwkkxticnwiqZsCwW3ORYWoOdvFxYrNvSrC0t
   A==;
X-CSE-ConnectionGUID: wd8IJW4NTJ64cR86gqDN2Q==
X-CSE-MsgGUID: uCehCdvbSU2XvHM8M6WRMA==
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="200831271"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 15:02:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 23 Oct 2024 15:02:16 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 23 Oct 2024 15:02:12 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 24 Oct 2024 00:01:28 +0200
Subject: [PATCH net-next v2 09/15] net: lan969x: add lan969x ops to match
 data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241024-sparx5-lan969x-switch-driver-2-v2-9-a0b5fae88a0f@microchip.com>
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

Add a bunch of small lan969x ops in bulk. These ops are explained in
detail in a previous series [1].

[1] https://lore.kernel.org/netdev/20241004-b4-sparx5-lan969x-switch-driver-v2-8-d3290f581663@microchip.com/

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan969x/lan969x.c | 122 +++++++++++++++++++++++
 drivers/net/ethernet/microchip/lan969x/lan969x.h |  28 ++++++
 2 files changed, 150 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.c b/drivers/net/ethernet/microchip/lan969x/lan969x.c
index 19f91e4a9f3e..2c2b86f9144e 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.c
@@ -6,6 +6,9 @@
 
 #include "lan969x.h"
 
+#define LAN969X_SDLB_GRP_CNT 5
+#define LAN969X_HSCH_LEAK_GRP_CNT 4
+
 static const struct sparx5_main_io_resource lan969x_main_iomap[] =  {
 	{ TARGET_CPU,                   0xc0000, 0 }, /* 0xe00c0000 */
 	{ TARGET_FDMA,                  0xc0400, 0 }, /* 0xe00c0400 */
@@ -92,6 +95,112 @@ static const struct sparx5_main_io_resource lan969x_main_iomap[] =  {
 	{ TARGET_ASM,                 0x3200000, 1 }, /* 0xe3200000 */
 };
 
+static struct sparx5_sdlb_group lan969x_sdlb_groups[LAN969X_SDLB_GRP_CNT] = {
+	{ 1000000000,  8192 / 2, 64 }, /*    1 G */
+	{  500000000,  8192 / 2, 64 }, /*  500 M */
+	{  100000000,  8192 / 4, 64 }, /*  100 M */
+	{   50000000,  8192 / 4, 64 }, /*   50 M */
+	{    5000000,  8192 / 8, 64 }, /*   10 M */
+};
+
+static u32 lan969x_hsch_max_group_rate[LAN969X_HSCH_LEAK_GRP_CNT] = {
+	655355, 1048568, 6553550, 10485680
+};
+
+static struct sparx5_sdlb_group *lan969x_get_sdlb_group(int idx)
+{
+	return &lan969x_sdlb_groups[idx];
+}
+
+static u32 lan969x_get_hsch_max_group_rate(int grp)
+{
+	return lan969x_hsch_max_group_rate[grp];
+}
+
+static u32 lan969x_get_dev_mode_bit(struct sparx5 *sparx5, int port)
+{
+	if (lan969x_port_is_2g5(port) || lan969x_port_is_5g(port))
+		return port;
+
+	/* 10G */
+	switch (port) {
+	case 0:
+		return 12;
+	case 4:
+		return 13;
+	case 8:
+		return 14;
+	case 12:
+		return 0;
+	default:
+		return port;
+	}
+}
+
+static u32 lan969x_port_dev_mapping(struct sparx5 *sparx5, int port)
+{
+	if (lan969x_port_is_5g(port)) {
+		switch (port) {
+		case 9:
+			return 0;
+		case 13:
+			return 1;
+		case 17:
+			return 2;
+		case 21:
+			return 3;
+		}
+	}
+
+	if (lan969x_port_is_10g(port)) {
+		switch (port) {
+		case 0:
+			return 0;
+		case 4:
+			return 1;
+		case 8:
+			return 2;
+		case 12:
+			return 3;
+		case 16:
+			return 4;
+		case 20:
+			return 5;
+		case 24:
+			return 6;
+		case 25:
+			return 7;
+		case 26:
+			return 8;
+		case 27:
+			return 9;
+		}
+	}
+
+	/* 2g5 port */
+	return port;
+}
+
+static int lan969x_port_mux_set(struct sparx5 *sparx5, struct sparx5_port *port,
+				struct sparx5_port_config *conf)
+{
+	u32 portno = port->portno;
+	u32 inst;
+
+	if (port->conf.portmode == conf->portmode)
+		return 0; /* Nothing to do */
+
+	switch (conf->portmode) {
+	case PHY_INTERFACE_MODE_QSGMII: /* QSGMII: 4x2G5 devices. Mode Q'  */
+		inst = (portno - portno % 4) / 4;
+		spx5_rmw(BIT(inst), BIT(inst), sparx5, PORT_CONF_QSGMII_ENA);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
 static const struct sparx5_regs lan969x_regs = {
 	.tsize = lan969x_tsize,
 	.gaddr = lan969x_gaddr,
@@ -123,12 +232,25 @@ static const struct sparx5_consts lan969x_consts = {
 	.tod_pin             = 4,
 };
 
+static const struct sparx5_ops lan969x_ops = {
+	.is_port_2g5             = &lan969x_port_is_2g5,
+	.is_port_5g              = &lan969x_port_is_5g,
+	.is_port_10g             = &lan969x_port_is_10g,
+	.is_port_25g             = &lan969x_port_is_25g,
+	.get_port_dev_index      = &lan969x_port_dev_mapping,
+	.get_port_dev_bit        = &lan969x_get_dev_mode_bit,
+	.get_hsch_max_group_rate = &lan969x_get_hsch_max_group_rate,
+	.get_sdlb_group          = &lan969x_get_sdlb_group,
+	.set_port_mux            = &lan969x_port_mux_set,
+};
+
 const struct sparx5_match_data lan969x_desc = {
 	.iomap      = lan969x_main_iomap,
 	.iomap_size = ARRAY_SIZE(lan969x_main_iomap),
 	.ioranges   = 2,
 	.regs       = &lan969x_regs,
 	.consts     = &lan969x_consts,
+	.ops        = &lan969x_ops,
 };
 EXPORT_SYMBOL_GPL(lan969x_desc);
 
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.h b/drivers/net/ethernet/microchip/lan969x/lan969x.h
index 3b4c9ea30071..ee890b26ea79 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.h
@@ -23,4 +23,32 @@ extern const unsigned int lan969x_gsize[GSIZE_LAST];
 extern const unsigned int lan969x_fpos[FPOS_LAST];
 extern const unsigned int lan969x_fsize[FSIZE_LAST];
 
+static inline bool lan969x_port_is_2g5(int portno)
+{
+	return portno == 1  || portno == 2  || portno == 3  ||
+	       portno == 5  || portno == 6  || portno == 7  ||
+	       portno == 10 || portno == 11 || portno == 14 ||
+	       portno == 15 || portno == 18 || portno == 19 ||
+	       portno == 22 || portno == 23;
+}
+
+static inline bool lan969x_port_is_5g(int portno)
+{
+	return portno == 9 || portno == 13 || portno == 17 ||
+	       portno == 21;
+}
+
+static inline bool lan969x_port_is_10g(int portno)
+{
+	return portno == 0  || portno == 4  || portno == 8  ||
+	       portno == 12 || portno == 16 || portno == 20 ||
+	       portno == 24 || portno == 25 || portno == 26 ||
+	       portno == 27;
+}
+
+static inline bool lan969x_port_is_25g(int portno)
+{
+	return false;
+}
+
 #endif

-- 
2.34.1


