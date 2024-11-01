Return-Path: <netdev+bounces-140941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F07399B8BCE
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7261E1F22696
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 07:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5327145B3F;
	Fri,  1 Nov 2024 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OK4UBul+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD01527B4;
	Fri,  1 Nov 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445033; cv=none; b=OJJRL25Ff03cIJhmb+XOHCz1icUkFiBvzltJiPdVM9viU4O7hlH0Yv4NYVlksaPVdcR0LIpp1h22xY2RCLGN1FgC13zZ4zQNASBQGxAR4OubaIska3d3mN5aK5x/7c6PwNkR2NCictJDlakc7dxjMpzsAj6fUqIU/jw5UKnTKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445033; c=relaxed/simple;
	bh=NO8D57jjFPDxrbgYyw5Mvi+zlor1VX7LknLSSD3o+GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iYn0xD27mVM0nfZ1AjFiV2+0sqK63cHArI4B27Kuz3V+DWt4QAnkUTRZPPtwdBl7ljDdIbFah/WXtjkql2DWnoKHfH65hby3RHoDSHKyJjBJKQdlBqrFvhLSyN8WS73tUmwO1sMwqnZB2iByjdcqWRmkDLV0I7FcUWRzPqRXfvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OK4UBul+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730445031; x=1761981031;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NO8D57jjFPDxrbgYyw5Mvi+zlor1VX7LknLSSD3o+GY=;
  b=OK4UBul+DFFWwugnCO8jwoc5wHDMlsb1B3ueWB2PN5k67RYhtWMwz5Xa
   c2I5RwMehtDI869yOze5zfXhqU4x4XNIbD5K3OhkUxGAeEDv+ZPH6jEOX
   eIINRuK5MbNNdBAtbn2cZmOtbhjndy2eiPVZw1UAyeAcuhrxyW4e7lzr5
   clBzjNTLMMGE/r5Qw88h0yv+lcr9V8ZDhSo2xnrVtfJ9GzSuGVINUg7C3
   KzkezyqlPQkpiIpFebcbmAhaYO3NePJefP/DfDtN/SSL+anmWoC42ftAa
   0jDNKgRMgqLyGoSocC9zyAh1Mo5rEmLewx4rUbyRWsEpF1Pqu7vNCCvye
   A==;
X-CSE-ConnectionGUID: j3YBXS8JS+qztkz9gl3BFg==
X-CSE-MsgGUID: t5VuQJaGQ7qXXZt/aEIsqg==
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="264868811"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Nov 2024 00:10:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Nov 2024 00:10:00 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 1 Nov 2024 00:09:57 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 1 Nov 2024 08:09:09 +0100
Subject: [PATCH net-next 3/6] net: sparx5: add new VCAP constants to match
 data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20241101-sparx5-lan969x-switch-driver-3-v1-3-3c76f22f4bfa@microchip.com>
References: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
In-Reply-To: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>, <christophe.jaillet@wanadoo.fr>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

In preparation for lan969x VCAP support, add the following three new
VCAP constants to match data:

    - vcaps_cfg (contains configuration data for each VCAP).

    - vcaps (contains auto-generated information about VCAP keys and
      actions).

    - vcap_stats: (contains auto-generated string names of all the keys
      and actions)

Add these constants to the Sparx5 match data constants and use them to
initialize the VCAP's in sparx5_vcap_init().

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Reviewed-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c        | 5 +++++
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h        | 3 +++
 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.h | 2 ++
 drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c   | 6 +++---
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 4f2d5413a64f..bac87e885bf1 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -30,6 +30,8 @@
 #include "sparx5_main.h"
 #include "sparx5_port.h"
 #include "sparx5_qos.h"
+#include "sparx5_vcap_ag_api.h"
+#include "sparx5_vcap_impl.h"
 
 const struct sparx5_regs *regs;
 
@@ -1063,6 +1065,9 @@ static const struct sparx5_consts sparx5_consts = {
 	.qres_max_prio_idx   = 630,
 	.qres_max_colour_idx = 638,
 	.tod_pin             = 4,
+	.vcaps               = sparx5_vcaps,
+	.vcaps_cfg           = sparx5_vcap_inst_cfg,
+	.vcap_stats          = &sparx5_vcap_stats,
 };
 
 static const struct sparx5_ops sparx5_ops = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 146bdc938adc..d5dd953b0a71 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -303,6 +303,9 @@ struct sparx5_consts {
 	u32 qres_max_prio_idx;   /* Maximum QRES prio index */
 	u32 qres_max_colour_idx; /* Maximum QRES colour index */
 	u32 tod_pin;             /* PTP TOD pin */
+	const struct sparx5_vcap_inst *vcaps_cfg;
+	const struct vcap_info *vcaps;
+	const struct vcap_statistics *vcap_stats;
 };
 
 struct sparx5_ops {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.h b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.h
index 7d106f1276fe..e68f5639a40a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.h
@@ -10,6 +10,8 @@
 #ifndef __SPARX5_VCAP_AG_API_H__
 #define __SPARX5_VCAP_AG_API_H__
 
+#include "vcap_api.h"
+
 /* VCAPs */
 extern const struct vcap_info sparx5_vcaps[];
 extern const struct vcap_statistics sparx5_vcap_stats;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index bbff8158a3de..25066ddb8d4d 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -2053,14 +2053,14 @@ int sparx5_vcap_init(struct sparx5 *sparx5)
 
 	sparx5->vcap_ctrl = ctrl;
 	/* select the sparx5 VCAP model */
-	ctrl->vcaps = sparx5_vcaps;
-	ctrl->stats = &sparx5_vcap_stats;
+	ctrl->vcaps = consts->vcaps;
+	ctrl->stats = consts->vcap_stats;
 	/* Setup callbacks to allow the API to use the VCAP HW */
 	ctrl->ops = &sparx5_vcap_ops;
 
 	INIT_LIST_HEAD(&ctrl->list);
 	for (idx = 0; idx < ARRAY_SIZE(sparx5_vcap_inst_cfg); ++idx) {
-		cfg = &sparx5_vcap_inst_cfg[idx];
+		cfg = &consts->vcaps_cfg[idx];
 		admin = sparx5_vcap_admin_alloc(sparx5, ctrl, cfg);
 		if (IS_ERR(admin)) {
 			err = PTR_ERR(admin);

-- 
2.34.1


