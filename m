Return-Path: <netdev+bounces-137498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E39A6B50
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338AA281287
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6581F9410;
	Mon, 21 Oct 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XYSwdHjC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0941F9A9E;
	Mon, 21 Oct 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519204; cv=none; b=Zfk90O3oWsCNPMMJRbKUEYgUsuRH5Fc0i1tuCHLzfYyY0lLjAinEFxl6R/sxqmE2Kaco9yqMEvum9bveinCosayHq0qrDvZe8OX6EBMCTKgW2lkHyatavAcMA1EerY6gWl0fQv1pGpCLu5sAr5DoXPvMASgnVDBJkncxO7HsU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519204; c=relaxed/simple;
	bh=qCUw2Dd7QJE+xRfWyqSza2PuSZTFa/9FFRKw2IFKsQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rkRymZ7yJWl2zVExxXEPXeY6XvGCv/NmRVJQvg2CSg56OgJHzzhvIPs8GzGQ8yknXPMZ+76r9hRjY/AqPM6zGmWQpptDbGa+qpjjloDpm9YkmnX4JJ00T4MUsnPA2lsYBHCD83V40mqFPB5mue7Mm1dhUC5IFDMHlCBfzSHYKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XYSwdHjC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519204; x=1761055204;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qCUw2Dd7QJE+xRfWyqSza2PuSZTFa/9FFRKw2IFKsQ8=;
  b=XYSwdHjCeGRzTQENeVEGpMA+b4gwGahKJktaHJqfHtB1fCY6dbA++cAw
   j9fOBQ4GR8Ok5DtWsrbkbvL9+O2/eu+GjyvNtjFoEs/7pzZxA7KzjQZza
   KQV62uohzZCwsC6GMkHy6uBabQaKhT9aXYhSZwBNeQoUnAJycIvJ2ExBL
   h1re7FP7njaYMdDXqhdiSYK9+wF2DmksaHU9xPiJcG8MI3M4eUc8F4aaE
   jXXcpPY0gZIjLbPytkGiTeyUdz25wDW7uPILuLpg6G39kBQF30gpzZ//S
   q2168gftfm4dgQkGvAfLvIw6bUE5Zwr124vymAyttMtGDLnufatuErF39
   g==;
X-CSE-ConnectionGUID: pvCRZgD5R42wSDtWHihNlg==
X-CSE-MsgGUID: 2lkdilmOSRCAXOMY8Hf04w==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="264379125"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 07:00:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:31 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:27 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:46 +0200
Subject: [PATCH net-next 09/15] net: lan969x: add lan969x ops to match data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-9-c8c49ef21e0f@microchip.com>
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
index 0671347e2258..c92f04647f12 100644
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
 
 MODULE_DESCRIPTION("Microchip lan969x switch driver");
diff --git a/drivers/net/ethernet/microchip/lan969x/lan969x.h b/drivers/net/ethernet/microchip/lan969x/lan969x.h
index 9059b0dc954c..36a19de7faa2 100644
--- a/drivers/net/ethernet/microchip/lan969x/lan969x.h
+++ b/drivers/net/ethernet/microchip/lan969x/lan969x.h
@@ -22,4 +22,32 @@ extern const unsigned int lan969x_gsize[GSIZE_LAST];
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


