Return-Path: <netdev+bounces-290606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPHdJMlrD2qOLAYAu9opvQ
	(envelope-from <netdev+bounces-290606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:32:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 111305ABCA4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 823A53047BD7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4A3FC5D4;
	Thu, 21 May 2026 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="TKYVbitJ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DA3FC5C1;
	Thu, 21 May 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395390; cv=fail; b=kaJVjEyQVhQxK9NbUuFWVHJHNaTyQbZwjWV2QnvMFxwuMdbmRkFXsK8wqawJT9aOc0BZcfzEo247McCBz5TzU9nbdMBDMdG/xth0RI+wtB3p3Z5l0V2HNkAUzgWqyH9o8h1DyfwSBWEGAYR05Vb/BFxiA6QY8N5ZBiviB0a67oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395390; c=relaxed/simple;
	bh=d2TwtUirWr4f3Gno1OlQJuciGtgjQYh5xyYP3KskoXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q80HJUO+VDM4Wz9XbcX6/ITkYWm/JjrR7hyufYML5YC8dyVMJmD/wVpqlBf4XYH3r7h+DG9e9XxHXX22OzEVQ3xZkd0pySJ+nyVHDVoqUipOFMkPdrWlGvZ74cJ0sTMvux505mw+RQa42nlX/MwoDXRk2i7uHigPvc3/DUp/O0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=TKYVbitJ; arc=fail smtp.client-ip=52.101.72.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjHbj9C8AEFHDgufJVnVTEGX03CIxm4dVWiSvXcYiAqRuDoX4I3w0ZOAVBwUryz2KSormoNbs7B1YNLqcwLIxZ20pMnuah3YITViJCNioWqrwJxWhLac3XQ6NVajjjFwo05ie/WiuzD2lz9l3BXp7zZTEHvrVmWQnF39A+xCsJ1q7D9hXff6TxjwNpcYu6fJiXhEX8QhKOhcStDYWD47dePpXfQXFOVjUwe8AmA6QJLXM54DokPHdrYcm4GU3ZMo5Ch6jKX4hAu4sFIWHO9rBlw1TSpQTdJG1Lx6A5woWvyd/ybdcxWspUty+GQv5VwzTKZSL9eVZfLvZ8Sz8fu5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r/HmXPlWui9CHqWxJSkFPhxidm2DtR0Y7zoTStvjeg=;
 b=WrMSP4gTUSd7zYp3Viy3koKHGmmrEoFSohAkep1h0k2e/Q86jjfGXxUI7jPmGfNeMiEPtlsRZgo+00m59ghkry/62yQ348MTGh17SCrn2Va2tIfCPaRUoOeAOv75vsFVKXShKIRZAKuCb+c6RLpk5VQKwWBCqDSnQlN4cSnCMY5XzEziNU2RJtd5N0jzo24BqnZjFp8AGUNOm7v+wUW322KWX24Z4Xccj8/fwYF0x76Kv5dQHBl72XGrYKn8rejZI3KbwZ3VFFC2fqtRN7OYlCxhzezMQzxkW1h78SrBxxmCa+ucZD3koDXDACovh0gGmHBEs3jmRqcdNWVQxLpPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r/HmXPlWui9CHqWxJSkFPhxidm2DtR0Y7zoTStvjeg=;
 b=TKYVbitJfMeiQxGyLu7D+nhBfbTarrDueG6TpEIv3/2FVR9TuilN6sn+LHhn2rap2pBAqsuaM+Yq+HeZMNxpav49rdE87jXBzdue+ppge+60bdA8A7iqn/WiLVPXsn5+RncQ87MMIuYgrmUPwDuCETV0uqG9VFJsvt6yhAuvOEzmqWyEieGKNYQGIxl3Ceq38MSDmX6LTITFmEK+gH67WfwJNRutNkdh+yvcnZFHKTvq+UYaps1zN5N3Vv9L8o0VBo2QaVLA4yIKmL7vw4D/ocOqxWd9VDxmNsDzocibQtKPsRyfnoDaUx9RWZRkB2d4udAWKtTxqldaPsbAgTu6uA==
Received: from DB9PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:10:1db::29)
 by DUZPR07MB10126.eurprd07.prod.outlook.com (2603:10a6:10:4de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 20:29:44 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::49) by DB9PR06CA0024.outlook.office365.com
 (2603:10a6:10:1db::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 20:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 20:29:43 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 21 May 2026 22:29:42 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 3FE8D4020B7B;
	Thu, 21 May 2026 22:29:42 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 2FE031005D6A; Thu, 21 May 2026 22:29:42 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next v2 2/4] mv88e6xxx: Cache scratch config3 of 6352
Date: Thu, 21 May 2026 22:29:22 +0200
Message-ID: <20260521202924.727929-3-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260521202924.727929-1-fidan.aliyeva.ext@ericsson.com>
References: <20260521202924.727929-1-fidan.aliyeva.ext@ericsson.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|DUZPR07MB10126:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd772f3-17b9-41a2-cd19-08deb777b11b
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	i2fOU9FE0sxuphWuiMYm4L6SeSqk7BZtHfOWYtQANtEiavMF0qqDiqyBa9gdvY1aHqgX5wg2fxi9IL+MUxgiSnH5YnIPlrcHX8Xqs5625AvS9wEwK41BQrgaxV4dUecltuKv6jwFScEtkvgAcHuTN1q4QFFaJhfouNVbGXHhTpnfC02zXA2NsCjJM0ymR7sJ/kx2VffUzQIZPierTvCllZtqL/4FyKVTduwVQZcwa+cRf7JwwF8bJQo/kh9YE9Ub9toFcTlO2S0JPHcO8HG/CWxT3Polg912784j6oozepSG1Jpt7S32Z5mjHK6rFClMUd0f8HgWFWU4ruIoNs6qGeYmlbErueAr1OoO99ZNitUlMRbCqTwahMiqJryYD/1Ew8AsbFUStNCZLxXhz+zXu8/09jYXUqZXOSJDaoeR5xxIfBzMm7bPy+PjeLlypIPj3f1ZhPDH0MzZEKkTy7AtzoHxWgMQ2o1lmtKUL7t4p2CiaWMyYJxEjnFhyp7MG60ewz1waVt2Db27QtcRFhMW1FPq6kFtUicFcUFXWNbZ6mRlPqWgsScYTXRCvGKrvzn8arI+PHTPLAKSdsdqM3h3XV5jg8Ar73Ts9StbdmSZ784DJV50rSmcuknDVceScqJ+6PQjZ+uTiKyqAcPdu3JPfsgJuaGzU0dJhx8oZ9DER8hC2R6yig2w3JyEwnCbpHwFeLekPd9tP8iLY0saER8jvX5N+zShBqfjFZ1s8h0cKpI=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+6Vo8rf3tLLROc7DoTvNefWf1Ue9uQYjeS0yUHLR5hGi8R+EZvwnA7a8KzYezHMmQepKiORFANBw3me7jA4DldDKEoOGsCZrFhmfJo3/BvRIw3uFojgGGaPgo4sUDEM43JmJ7+1J5Vh/Arl7dNjz/A35DzGfVgx40bGj4R5wQrrlMgYmK53mDu8VLNSd8Rf743hKeZU5pu3eMBHCGfkmG97Q6HSDMOuZEgl7AFLpivQS0X8PNapPovHI1Eb3u5AsAG25YIDzLF7camSCD1dakqRJFRVNaxmQdJCvMCiXd5yBBlhVmFA2Hfk/6VauGF+cNrqPOLtpsAisSX3iKeFWNd3RdomRQnivT8P6LFmosjb56DIFgZjKWXQmzUl3SsxtlljlPaX3XVJN/xz2nV0zpVj4hyHaWjI+Pv4+M+sODC9sTV8iLUbZTkVx6k1XdaPX
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:29:43.2775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd772f3-17b9-41a2-cd19-08deb777b11b
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10126
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290606-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ericsson.com:email,ericsson.com:mid,ericsson.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 111305ABCA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Changes:

1. Add g2_scratch_config3 member to mv88e6xxx_chip.

2. Add mv88e6352_g2_cache_global_scratch_config3  which reads the
CONFIG3 value from the scratch register and caches it.

3. Call this function in mv88e6352_reset.

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c            |  7 +++++-
 drivers/net/dsa/mv88e6xxx/chip.h            |  3 +++
 drivers/net/dsa/mv88e6xxx/global2.h         |  1 +
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 26 +++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6102b7fd8d44..4ed6f880e02c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3736,13 +3736,18 @@ static int mv88e6390_setup_errata(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_software_reset(chip);
 }

+/* For MV88E6XXX_FAMILY_6352, perform reset on G1 control.
+ * Also, read and cache G2 scratch register.
+ */
 static int mv88e6352_reset(struct mv88e6xxx_chip *chip)
 {
 	int err;

 	err = mv88e6352_g1_reset(chip);
+	if (err)
+		return err;

-	return err;
+	return mv88e6352_g2_cache_global_scratch_config3(chip);
 }

 /* prod_id for switch families which do not have a PHY model number */
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 2b235ac2c5df..d911f60aca10 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -454,6 +454,9 @@ struct mv88e6xxx_chip {

 	/* TCAM entries */
 	struct mv88e6xxx_tcam tcam;
+
+	/* Global2 scratch register config data3 */
+	u8 g2_scratch_config3;
 };

 #define TCAM_MATCH_SIZE 96
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 82f9b410de0b..ff5adf7c9bc3 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -382,6 +382,7 @@ int mv88e6390_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 				      bool external);
 int mv88e6393x_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 				       bool external);
+int mv88e6352_g2_cache_global_scratch_config3(struct mv88e6xxx_chip *chip);
 int mv88e6352_g2_scratch_port_has_serdes(struct mv88e6xxx_chip *chip, int port);
 int mv88e6xxx_g2_atu_stats_set(struct mv88e6xxx_chip *chip, u16 kind, u16 bin);
 int mv88e6xxx_g2_atu_stats_get(struct mv88e6xxx_chip *chip, u16 *stats);
diff --git a/drivers/net/dsa/mv88e6xxx/global2_scratch.c b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
index 53a6d3ed63b3..f2f9e7dce1aa 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -321,6 +321,32 @@ int mv88e6393x_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_g2_scratch_write(chip, misc_cfg, val);
 }

+/**
+ * mv88e6352_g2_cache_global_scratch_config3 - caches G2 CONFIG3 value
+ * @chip: chip private data
+ *
+ * Reads and stores config3 value of global2 scratch registers, which
+ * can be used to determine if the port is attached to a serdes. The
+ * value does not change once the switch is released from reset and
+ * represents the value of the pin strapping.
+ *
+ * Return: negative error number if the register read fails; otherwise, 0
+ */
+int mv88e6352_g2_cache_global_scratch_config3(struct mv88e6xxx_chip *chip)
+{
+	u8 config3;
+	int err;
+
+	err = mv88e6xxx_g2_scratch_read(chip, MV88E6352_G2_SCRATCH_CONFIG_DATA3,
+					&config3);
+	if (err)
+		return err;
+
+	chip->g2_scratch_config3 = config3;
+
+	return 0;
+}
+
 /**
  * mv88e6352_g2_scratch_port_has_serdes - indicate if a port can have a serdes
  * @chip: chip private data
--
2.36.0


