Return-Path: <netdev+bounces-260807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMwKFD+8nmnwWwQAu9opvQ
	(envelope-from <netdev+bounces-260807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:09:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72663194AEB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C78E5302FA84
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A337475A;
	Wed, 25 Feb 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qa4MGJ7I"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388136EA94;
	Wed, 25 Feb 2026 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010393; cv=none; b=NtLXFpzmateT2E7ELAOt07EPUqy5b1BtvC3r91RDh63d1GZpnmzZFiCxe1q80G0Nwn1ohlYvWLHZZe/woFYJQbWG/iXfIoRVc77cXkle2gW0QZ6J0dvIgHfdeUrPtX+sowB5l9t7XMsaXKLfX57xkQX4nyTKJRmK8YZ8U5o9FJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010393; c=relaxed/simple;
	bh=jAVzK5Hc/AzuV81zaf70lHzotLsm9hxK1qHPaNtwaEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ukAc9iMGHPj5tCqEdvTYsGxInrYtpv0lfCyskYlIl1YWwJd2NzY6k/1aEAnH3gZlBmK0KR2tUgZ8irmW2s0r9kjLYmDVoHyg/zEF94qzDrUF7joTvlT+WtW2OPV3M8GJzD35UfB3/fOIuuC9BSuNOdPKq2FrS6TIExJWb/6/eC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qa4MGJ7I; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772010390; x=1803546390;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jAVzK5Hc/AzuV81zaf70lHzotLsm9hxK1qHPaNtwaEs=;
  b=qa4MGJ7IxS4hIAm7mIF66Q0B8tnWEvIp88YnGJjv3xwowBDhFctU5gHe
   yiiCcuWPf0YXs/yNZQhr/H5dwI/ElE4MnqNdP4w0KQo5EMxeYPiGfZyYF
   Spd5bR/5+uGiPXxrmCpfkKkeDYYPZqHhzWH5OQGBQSHsZN6kcqA//JwyP
   uJVLaPrGlonJF7mxynpOksDe9PDMgW9qWom7khed+43uByFo4pXB6crBI
   DzxAaMoDq6rr9X8ryAeG7z/d8e+xfdIolMZd1k1blyy/GSGUuAE3jW07c
   mwIo6bm4s4a31SLOCBOzGz2nBdghtV6K3aUMuUGFin+DhFUqr/e3k8lGL
   A==;
X-CSE-ConnectionGUID: GvK6L9OjSSuGPw39llTOAQ==
X-CSE-MsgGUID: M+9u7YjXSSqJIOES4TKBzw==
X-IronPort-AV: E=Sophos;i="6.21,310,1763449200"; 
   d="scan'208";a="61259303"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:06:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 25 Feb 2026 02:06:21 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 25 Feb 2026 02:06:19 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Wed, 25 Feb 2026 10:05:29 +0100
Subject: [PATCH net-next 6/7] net: sparx5: move calendar initialization to
 probe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260225-sparx5-init-deinit-v1-6-97036580b9f0@microchip.com>
References: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
In-Reply-To: <20260225-sparx5-init-deinit-v1-0-97036580b9f0@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260807-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,microchip.com:mid,microchip.com:dkim,microchip.com:email]
X-Rspamd-Queue-Id: 72663194AEB
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
index 17748854ca48..581f87eb9781 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -740,14 +740,6 @@ static int sparx5_start(struct sparx5 *sparx5)
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
 	mutex_init(&sparx5->mdb_lock);
 	INIT_LIST_HEAD(&sparx5->mdb_entries);
 
@@ -947,6 +939,12 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		}
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


