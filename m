Return-Path: <netdev+bounces-261864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJJTHCaxoWmMvgQAu9opvQ
	(envelope-from <netdev+bounces-261864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:58:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DB41B957B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73042300E4B1
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951B42E01C;
	Fri, 27 Feb 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZrJxVxvc"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99642DFE1;
	Fri, 27 Feb 2026 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204252; cv=none; b=p3vUsKzGNo2qBYNaDxEJz8QFQNFC5N/lCqnv3L33da4Bbb8X1N+W/jvgL4ODS6U/Tl5CEi0tyN39g4PdmcV0pO15nP/spuiviqTGnK5aJyIaxwhCXpjFSiwLk8ZJku0NKkCmCQvMIWFSjPGGVUsbw3Xmq8KPH9ZRFEsgrmpgyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204252; c=relaxed/simple;
	bh=RQO7SOnyMSiFimAVkR4/LqCQgGBb+zZjAdqVt9ehHc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UUl8CN+1l/f1OnM/Al7OIK1fDt2iqW2ymJu92qjWUSPCKdskTSLCYy52S33BHUhTWT+Q5mATOGkGzzSOYS9C3WKVKCqWMu/XQIdThNCkZU6v/gUse5fNrcapqO7+CatTehDykqqtlM2Vb4g6NNDNbCjQuPtVYUTCdIy4y6/y3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZrJxVxvc; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772204250; x=1803740250;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RQO7SOnyMSiFimAVkR4/LqCQgGBb+zZjAdqVt9ehHc0=;
  b=ZrJxVxvclHJUobWVyXOB42egQQjV2rIkKfti2ayD0MY0nX99c0BscgEw
   dPep26ItwaBsCEX9YznipozTXEFHH75ifOlHGFYAzNJg6Q8dfqQgiSBXm
   6Hwsq3rlH+Z8n3Jvfoy3e6IifTB7jY99yfQNviiictXUZi/gplO13GVz2
   AGdhoKUGAfNiKxGye5wBkQf5fIwns7+2K2hWZD6KRtRu1ukdw/UVfmZga
   MUgR8RPRHueamPKvb+Iam6AMMaX1xCIFO3STpa94Ac8vhXaCoodhsxyMA
   C1bBa3DLOqthvAQGB/5ZUZIqiLXcWcaAeNhXLxP/92hFWbFCQ4r7S2qPp
   w==;
X-CSE-ConnectionGUID: wgI98+BBT5OZU+rH87zgwA==
X-CSE-MsgGUID: fAnVqOe3R9CLic7WyNqizg==
X-IronPort-AV: E=Sophos;i="6.21,314,1763449200"; 
   d="scan'208";a="53970562"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Feb 2026 07:57:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 27 Feb 2026 07:57:11 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 27 Feb 2026 07:57:09 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 27 Feb 2026 15:56:43 +0100
Subject: [PATCH net-next v2 5/9] net: sparx5: move calendar initialization
 to probe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260227-sparx5-init-deinit-v2-5-10ba54ccf005@microchip.com>
References: <20260227-sparx5-init-deinit-v2-0-10ba54ccf005@microchip.com>
In-Reply-To: <20260227-sparx5-init-deinit-v2-0-10ba54ccf005@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <maxime.chevallier@bootlin.com>,
	<rmk+kernel@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261864-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com,bootlin.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:mid,microchip.com:dkim,microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87DB41B957B
X-Rspamd-Action: no action

Move the calendar initialization from sparx5_start() to probe() by
creating a new sparx5_calendar_init() wrapper function that calls both
sparx5_config_auto_calendar() and sparx5_config_dsm_calendar().
Calendar initialization does not require cleanup.

Also, make the individual calendar config functions static since they
are now only called from within sparx5_calendar.c.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c | 15 +++++++++++++--
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c     | 14 ++++++--------
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h     |  3 +--
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
index 5c46d81de530..4ec95590a3c6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c
@@ -151,7 +151,7 @@ enum sparx5_cal_bw sparx5_get_port_cal_speed(struct sparx5 *sparx5, u32 portno)
 }
 
 /* Auto configure the QSYS calendar based on port configuration */
-int sparx5_config_auto_calendar(struct sparx5 *sparx5)
+static int sparx5_config_auto_calendar(struct sparx5 *sparx5)
 {
 	const struct sparx5_consts *consts = sparx5->data->consts;
 	u32 cal[7], value, idx, portno;
@@ -578,7 +578,7 @@ static int sparx5_dsm_calendar_update(struct sparx5 *sparx5, u32 taxi,
 }
 
 /* Configure the DSM calendar based on port configuration */
-int sparx5_config_dsm_calendar(struct sparx5 *sparx5)
+static int sparx5_config_dsm_calendar(struct sparx5 *sparx5)
 {
 	const struct sparx5_ops *ops = sparx5->data->ops;
 	int taxi;
@@ -610,3 +610,14 @@ int sparx5_config_dsm_calendar(struct sparx5 *sparx5)
 	kfree(data);
 	return err;
 }
+
+int sparx5_calendar_init(struct sparx5 *sparx5)
+{
+	int err;
+
+	err = sparx5_config_auto_calendar(sparx5);
+	if (err)
+		return err;
+
+	return sparx5_config_dsm_calendar(sparx5);
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index bcc7b895fad6..a58c79a6e873 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -735,14 +735,6 @@ static int sparx5_start(struct sparx5 *sparx5)
 	/* Enable queue limitation watermarks */
 	sparx5_qlim_set(sparx5);
 
-	err = sparx5_config_auto_calendar(sparx5);
-	if (err)
-		return err;
-
-	err = sparx5_config_dsm_calendar(sparx5);
-	if (err)
-		return err;
-
 	sparx5_board_init(sparx5);
 
 	/* Start Frame DMA with fallback to register based INJ/XTR */
@@ -957,6 +949,12 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		goto cleanup_ports;
 	}
 
+	err = sparx5_calendar_init(sparx5);
+	if (err) {
+		dev_err(sparx5->dev, "Failed to initialize calendar\n");
+		goto cleanup_ports;
+	}
+
 	err = sparx5_qos_init(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to initialize QoS\n");
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 97d53e229ad6..6a745bb71b5c 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -504,8 +504,7 @@ int sparx5_vlan_vid_del(struct sparx5_port *port, u16 vid);
 void sparx5_vlan_port_apply(struct sparx5 *sparx5, struct sparx5_port *port);
 
 /* sparx5_calendar.c */
-int sparx5_config_auto_calendar(struct sparx5 *sparx5);
-int sparx5_config_dsm_calendar(struct sparx5 *sparx5);
+int sparx5_calendar_init(struct sparx5 *sparx5);
 int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
 			     struct sparx5_calendar_data *data);
 u32 sparx5_cal_speed_to_value(enum sparx5_cal_bw speed);

-- 
2.34.1


