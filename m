Return-Path: <netdev+bounces-137501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F62F9A6B58
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FAC1F21F8A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385431FB3CB;
	Mon, 21 Oct 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oIgP5jjm"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9AC1F4FD6;
	Mon, 21 Oct 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519215; cv=none; b=Buzyxg3VXg9Mvx65zBookDnOOwsWZZ/226x6C6IqmL3JD/llvctoyRFkb4KJ8XqlmuxPcYtJlieMDIPTkp/OUjWnfStpEsdRr+4XYTPBCt9HSTVoJ3J2PK47R5A//6mrbnh5UnVGHGH8pPV/IkYgPFP7jT52HEGqtXYz0QufOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519215; c=relaxed/simple;
	bh=cq20QVgmf+caAUdUu3G3tTGfVF4nRPxA3Fl16nAkawc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CZD7OC8jxSdiv4yOY0WrYVp72w9Fdsqwx6GlBzwDBZYjN4puE/kzbrEOBfF+WsCkoAdYP8dYUBLl8OMrq11G/3WaZ0ePdM0Z8dmHQn48PPqlqfkEr7irq5iiWW8nPe6Os/pERlw3cdx4LIwHBKGk5UYEXs+Pl7ztWEM4CCY5zu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oIgP5jjm; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729519213; x=1761055213;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cq20QVgmf+caAUdUu3G3tTGfVF4nRPxA3Fl16nAkawc=;
  b=oIgP5jjmarjFM9k/x1knX7GJGIYC7+986nFTAh3XRoq2qiV2PAf6nKO8
   tX2F4Bawdqg7YnerazJJelY0Yx1W5njccd6FPGkUeQEef8R4j6WBfhL2n
   MQa92uKUjyC9LWXByM5vLNxQqLVcQEYHzGPeoisS2sIfdU8MzkWWhbc50
   j+gRMi3DiGFFZVEeOUPG6L0mVZX9+pImlq9jFZvw8B/gPrIK+EgeQba6k
   99jHUaAFj0/i4e9BA7livIPQO9dM3CRXteJgxzcCHIDLdyeVvsVgktEVv
   DZpLGeXxDmbpcT9IDD9lKJ2DWGv+vKEXAn+agjNwN2UO3vcI5N5pMFCt5
   A==;
X-CSE-ConnectionGUID: wjlJ/ymcRaqntxTcHXMHhA==
X-CSE-MsgGUID: Eftfl4+fTkORAV5y3h6lbQ==
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="33285729"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 07:00:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 21 Oct 2024 06:59:43 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 21 Oct 2024 06:59:39 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 21 Oct 2024 15:58:49 +0200
Subject: [PATCH net-next 12/15] net: sparx5: use is_sparx5() macro
 throughout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241021-sparx5-lan969x-switch-driver-2-v1-12-c8c49ef21e0f@microchip.com>
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

Use the is_sparx5() macro (introduced in earlier series [1]), in places
where we need to handle things a bit differently on lan969x.

These places are:

    - in sparx5_dsm_calendar_update() we need to switch the calendar
      from a to b on lan969x.

    - in sparx5_init_coreclock() we need to set the policer update
      internal (pol_upd_int) to 820 for the new core clock frequency on
      lan969x.

    - in sparx5_start() we need to make sure the HSCH_SYS_CLK_PER
      register is only touched on Sparx5.

    - in sparx5_start() we need to disable VCAP and FDMA for lan969x
      (will come in later series).

    - in sparx5_mirror_port_get() we must make sure the
      ANA_AC_PROBE_PORT_CFG1 register is only read on Sparx5.

    - sparx5_netdev.c and sparx5_packet.c we need to use different IFH
      (Internal Frame Header) offsets for lan969x.

    - in sparx5_port_fifo_sz() we must bail out on lan969x.

    - in sparx5_port_config_low_set() we must configure the phase
      detection registers.

    - in sparx5_port_config() and sparx5_port_init() we must do some
      additional configuration of the port devices.

    - in sparx5_dwrr_conf_set() we must derive the scheduling layer

[1] https://lore.kernel.org/netdev/20241004-b4-sparx5-lan969x-switch-driver-v2-8-d3290f581663@microchip.com/

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_calendar.c    | 21 +++++++++-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    | 24 ++++++-----
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  | 10 ++++-
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  | 17 ++++----
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  3 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    | 46 ++++++++++++++++++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_qos.c |  3 +-
 7 files changed, 102 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index 64c5ed70cc6b..5fe941c66c17 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -531,8 +531,18 @@ static int sparx5_dsm_calendar_check(struct sparx5 *sparx5,
 static int sparx5_dsm_calendar_update(struct sparx5 *sparx5, u32 taxi,
 				      struct sparx5_calendar_data *data)
 {
-	u32 idx;
-	u32 cal_len = sparx5_dsm_cal_len(data->schedule), len;
+	u32 cal_len = sparx5_dsm_cal_len(data->schedule), len, idx;
+
+	if (!is_sparx5(sparx5)) {
+		u32 val, act;
+
+		val = spx5_rd(sparx5, DSM_TAXI_CAL_CFG(taxi));
+		act = DSM_TAXI_CAL_CFG_CAL_SEL_STAT_GET(val);
+
+		spx5_rmw(DSM_TAXI_CAL_CFG_CAL_PGM_SEL_SET(!act),
+			 DSM_TAXI_CAL_CFG_CAL_PGM_SEL,
+			 sparx5, DSM_TAXI_CAL_CFG(taxi));
+	}
 
 	spx5_rmw(DSM_TAXI_CAL_CFG_CAL_PGM_ENA_SET(1),
 		 DSM_TAXI_CAL_CFG_CAL_PGM_ENA,
@@ -556,6 +566,13 @@ static int sparx5_dsm_calendar_update(struct sparx5 *sparx5, u32 taxi,
 						       DSM_TAXI_CAL_CFG(taxi)));
 	if (len != cal_len - 1)
 		goto update_err;
+
+	if (!is_sparx5(sparx5)) {
+		spx5_rmw(DSM_TAXI_CAL_CFG_CAL_SWITCH_SET(1),
+			 DSM_TAXI_CAL_CFG_CAL_SWITCH,
+			 sparx5, DSM_TAXI_CAL_CFG(taxi));
+	}
+
 	return 0;
 update_err:
 	dev_err(sparx5->dev, "Incorrect calendar length: %u\n", len);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index f48b5769e1b3..5c986c373b3e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -532,14 +532,18 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
 			 sparx5, CLKGEN_LCPLL1_CORE_CLK_CFG);
 	}
 
+	if (!is_sparx5(sparx5))
+		pol_upd_int = 820; // SPX5_CORE_CLOCK_328MHZ
+
 	/* Update state with chosen frequency */
 	sparx5->coreclock = freq;
 	clk_period = sparx5_clk_period(freq);
 
-	spx5_rmw(HSCH_SYS_CLK_PER_100PS_SET(clk_period / 100),
-		 HSCH_SYS_CLK_PER_100PS,
-		 sparx5,
-		 HSCH_SYS_CLK_PER);
+	if (is_sparx5(sparx5))
+		spx5_rmw(HSCH_SYS_CLK_PER_100PS_SET(clk_period / 100),
+			 HSCH_SYS_CLK_PER_100PS,
+			 sparx5,
+			 HSCH_SYS_CLK_PER);
 
 	spx5_rmw(ANA_AC_POL_BDLB_DLB_CTRL_CLK_PERIOD_01NS_SET(clk_period / 100),
 		 ANA_AC_POL_BDLB_DLB_CTRL_CLK_PERIOD_01NS,
@@ -729,15 +733,17 @@ static int sparx5_start(struct sparx5 *sparx5)
 	if (err)
 		return err;
 
-	err = sparx5_vcap_init(sparx5);
-	if (err) {
-		sparx5_unregister_notifier_blocks(sparx5);
-		return err;
+	if (is_sparx5(sparx5)) {
+		err = sparx5_vcap_init(sparx5);
+		if (err) {
+			sparx5_unregister_notifier_blocks(sparx5);
+			return err;
+		}
 	}
 
 	/* Start Frame DMA with fallback to register based INJ/XTR */
 	err = -ENXIO;
-	if (sparx5->fdma_irq >= 0) {
+	if (sparx5->fdma_irq >= 0 && is_sparx5(sparx5)) {
 		if (GCB_CHIP_ID_REV_ID_GET(sparx5->chip_id) > 0)
 			err = devm_request_threaded_irq(sparx5->dev,
 							sparx5->fdma_irq,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
index 15db423be4aa..93483337f84c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mirror.c
@@ -24,8 +24,14 @@ static u32 sparx5_mirror_to_dir(bool ingress)
 /* Get ports belonging to this mirror */
 static u64 sparx5_mirror_port_get(struct sparx5 *sparx5, u32 idx)
 {
-	return (u64)spx5_rd(sparx5, ANA_AC_PROBE_PORT_CFG1(idx)) << 32 |
-	       spx5_rd(sparx5, ANA_AC_PROBE_PORT_CFG(idx));
+	u64 val;
+
+	val = spx5_rd(sparx5, ANA_AC_PROBE_PORT_CFG(idx));
+
+	if (is_sparx5(sparx5))
+		val |= (u64)spx5_rd(sparx5, ANA_AC_PROBE_PORT_CFG1(idx)) << 32;
+
+	return val;
 }
 
 /* Add port to mirror (only front ports) */
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index a94d9a540bd3..1d34af78166a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -64,16 +64,16 @@ void sparx5_set_port_ifh(struct sparx5 *sparx5, void *ifh_hdr, u16 portno)
 	/* MISC.CPU_MASK/DPORT = Destination port */
 	ifh_encode_bitfield(ifh_hdr, portno,   29, 8);
 	/* MISC.PIPELINE_PT */
-	ifh_encode_bitfield(ifh_hdr, 16,       37, 5);
+	ifh_encode_bitfield(ifh_hdr, is_sparx5(sparx5) ? 16 : 17, 37, 5);
 	/* MISC.PIPELINE_ACT */
 	ifh_encode_bitfield(ifh_hdr, 1,        42, 3);
 	/* FWD.SRC_PORT = CPU */
 	ifh_encode_bitfield(ifh_hdr, sparx5_get_pgid(sparx5, SPX5_PORT_CPU_0),
-			    46, 7);
+			    46, is_sparx5(sparx5) ? 7 : 6);
 	/* FWD.SFLOW_ID (disable SFlow sampling) */
-	ifh_encode_bitfield(ifh_hdr, 124,      57, 7);
+	ifh_encode_bitfield(ifh_hdr, 124,      is_sparx5(sparx5) ? 57 : 56, 7);
 	/* FWD.UPDATE_FCS = Enable. Enforce update of FCS. */
-	ifh_encode_bitfield(ifh_hdr, 1,        67, 1);
+	ifh_encode_bitfield(ifh_hdr, 1,        is_sparx5(sparx5) ? 67 : 66, 1);
 }
 
 void sparx5_set_port_ifh_rew_op(void *ifh_hdr, u32 rew_op)
@@ -84,19 +84,22 @@ void sparx5_set_port_ifh_rew_op(void *ifh_hdr, u32 rew_op)
 void sparx5_set_port_ifh_pdu_type(struct sparx5 *sparx5, void *ifh_hdr,
 				  u32 pdu_type)
 {
-	ifh_encode_bitfield(ifh_hdr, pdu_type, 191, 4);
+	ifh_encode_bitfield(ifh_hdr, pdu_type, is_sparx5(sparx5) ? 191 : 190,
+			    4);
 }
 
 void sparx5_set_port_ifh_pdu_w16_offset(struct sparx5 *sparx5, void *ifh_hdr,
 					u32 pdu_w16_offset)
 {
-	ifh_encode_bitfield(ifh_hdr, pdu_w16_offset, 195, 6);
+	ifh_encode_bitfield(ifh_hdr, pdu_w16_offset,
+			    is_sparx5(sparx5) ? 195 : 194, 6);
 }
 
 void sparx5_set_port_ifh_timestamp(struct sparx5 *sparx5, void *ifh_hdr,
 				   u64 timestamp)
 {
-	ifh_encode_bitfield(ifh_hdr, timestamp, 232,  40);
+	ifh_encode_bitfield(ifh_hdr, timestamp, 232,
+			    is_sparx5(sparx5) ? 40 : 38);
 }
 
 static int sparx5_port_open(struct net_device *ndev)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index 57fa9ff9dfce..b6f635d85820 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -43,7 +43,8 @@ void sparx5_ifh_parse(struct sparx5 *sparx5, u32 *ifh, struct frame_info *info)
 		((u32)xtr_hdr[29] <<  8) |
 		((u32)xtr_hdr[30] <<  0);
 	fwd = (fwd >> 5);
-	info->src_port = FIELD_GET(GENMASK(7, 1), fwd);
+	info->src_port = spx5_field_get(GENMASK(is_sparx5(sparx5) ? 7 : 6, 1),
+					fwd);
 
 	/*
 	 * Bit 270-271 are occasionally unexpectedly set by the hardware,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 0b38b4cb0929..1401761c6251 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -476,6 +476,9 @@ static int sparx5_port_fifo_sz(struct sparx5 *sparx5,
 	u32 mac_width  = 8;
 	u32 addition   = 0;
 
+	if (!is_sparx5(sparx5))
+		return 0;
+
 	switch (speed) {
 	case SPEED_25000:
 		return 0;
@@ -921,6 +924,20 @@ static int sparx5_port_config_low_set(struct sparx5 *sparx5,
 		 sparx5,
 		 DEV2G5_DEV_RST_CTRL(port->portno));
 
+	/* Enable PHAD_CTRL for better timestamping */
+	if (!is_sparx5(sparx5)) {
+		for (int i = 0; i < 2; ++i) {
+			/* Divide the port clock by three for the two
+			 * phase detection registers.
+			 */
+			spx5_rmw(DEV2G5_PHAD_CTRL_DIV_CFG_SET(3) |
+				 DEV2G5_PHAD_CTRL_PHAD_ENA_SET(1),
+				 DEV2G5_PHAD_CTRL_DIV_CFG |
+				 DEV2G5_PHAD_CTRL_PHAD_ENA,
+				 sparx5, DEV2G5_PHAD_CTRL(port->portno, i));
+		}
+	}
+
 	return 0;
 }
 
@@ -978,6 +995,7 @@ int sparx5_port_config(struct sparx5 *sparx5,
 		       struct sparx5_port_config *conf)
 {
 	bool high_speed_dev = sparx5_is_baser(conf->portmode);
+	const struct sparx5_ops *ops = sparx5->data->ops;
 	int err, urgency, stop_wm;
 
 	err = sparx5_port_verify_speed(sparx5, port, conf);
@@ -993,6 +1011,13 @@ int sparx5_port_config(struct sparx5 *sparx5,
 	if (err)
 		return err;
 
+	if (!is_sparx5(sparx5) && ops->is_port_10g(port->portno) &&
+	    conf->speed < SPEED_10000)
+		spx5_rmw(DSM_DEV_TX_STOP_WM_CFG_DEV10G_SHADOW_ENA_SET(1),
+			 DSM_DEV_TX_STOP_WM_CFG_DEV10G_SHADOW_ENA,
+			 sparx5,
+			 DSM_DEV_TX_STOP_WM_CFG(port->portno));
+
 	/* Set the DSM stop watermark */
 	stop_wm = sparx5_port_fifo_sz(sparx5, port->portno, conf->speed);
 	spx5_rmw(DSM_DEV_TX_STOP_WM_CFG_DEV_TX_STOP_WM_SET(stop_wm),
@@ -1144,6 +1169,27 @@ int sparx5_port_init(struct sparx5 *sparx5,
 			DEV25G_PCS25G_SD_CFG(pix));
 	}
 
+	if (!is_sparx5(sparx5)) {
+		void __iomem *inst;
+		u32 dev, tinst;
+
+		if (ops->is_port_10g(port->portno)) {
+			dev = sparx5_to_high_dev(sparx5, port->portno);
+			tinst = sparx5_port_dev_index(sparx5, port->portno);
+			inst = spx5_inst_get(sparx5, dev, tinst);
+
+			spx5_inst_wr(5, inst,
+				     DEV10G_PTP_STAMPER_CFG(port->portno));
+		} else if (ops->is_port_5g(port->portno)) {
+			dev = sparx5_to_high_dev(sparx5, port->portno);
+			tinst = sparx5_port_dev_index(sparx5, port->portno);
+			inst = spx5_inst_get(sparx5, dev, tinst);
+
+			spx5_inst_wr(5, inst,
+				     DEV5G_PTP_STAMPER_CFG(port->portno));
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
index d065f8c40d37..e580670f3992 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
@@ -367,9 +367,10 @@ static u32 sparx5_weight_to_hw_cost(u32 weight_min, u32 weight)
 static int sparx5_dwrr_conf_set(struct sparx5_port *port,
 				struct sparx5_dwrr *dwrr)
 {
+	u32 layer = is_sparx5(port->sparx5) ? 2 : 1;
 	int i;
 
-	spx5_rmw(HSCH_HSCH_CFG_CFG_HSCH_LAYER_SET(2) |
+	spx5_rmw(HSCH_HSCH_CFG_CFG_HSCH_LAYER_SET(layer) |
 		 HSCH_HSCH_CFG_CFG_CFG_SE_IDX_SET(port->portno),
 		 HSCH_HSCH_CFG_CFG_HSCH_LAYER | HSCH_HSCH_CFG_CFG_CFG_SE_IDX,
 		 port->sparx5, HSCH_HSCH_CFG_CFG);

-- 
2.34.1


