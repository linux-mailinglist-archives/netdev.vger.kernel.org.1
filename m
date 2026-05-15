Return-Path: <netdev+bounces-288480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AbXM6ehB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D450558FF6
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4108D3061EB9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625D3F6C2A;
	Fri, 15 May 2026 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="vCUj/fV9"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480C3F6C30;
	Fri, 15 May 2026 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884683; cv=fail; b=h4r4W0+pC0NMl9guecLuWxG9JUKneeQ3iDEA2npfnVUsAfDUdYQNce0nF5jYX7L66tKCU5KQJUUkyJcwOgN9fvI9qhGoRerPC3p5OtCkRHPL9iKrA8xqaNnap7SXSjktK9e9tKz0tjNnX9RJK8nUexjdMeBcq8nSGznssQ/5O6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884683; c=relaxed/simple;
	bh=7wMtSMlDRWMfdbDc4etO+2X4CuFo9KF4KwXGCPIl7Bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTqq2A+zG9QhNFt6MZHfzvl2nw0kPP3WoEtjhQk/veLt10LUDMcUHOm9ChfUIyaj9vP+dWkDbPc8Jm03Oz+WonuPZzuWZIECujFReuCuBjI6cWVh5UuZx8YC7Bv9GNXIkxR7syim8rAowS52CkgcOH7n4pcvSDXSN04fPKqtvaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=vCUj/fV9; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gfxf8r28xt4ic7nDxPplUYDO9CKUOdZWoivW5cx++G1d+QvqiqFCi0bwBBFI92oUKjhm0JJdmP/QCpZb2HY9A4TpFTZpbUljB01+1J7FusWl90cOMak6F2bpg9yFhIJFqfoydwK1JetHrgyL0DbGaBBn5XsWuQAaAlMCdIXo4WMMPS+iO5YmLuHh2ZWHBWiELbA4eCSg5dQOQSe6jnN096/cvq2cWTUPnKyzvo3Geb6Z52OZO9yB5jNdbODRKZ6gj+ycwMWolXQ/C40yDGGVONfTXtu648yCrfuR3iNtPL2/z05YKvUiDif3wMYq0wVm7ZDtGp/ZTvjLY+14nVwsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnC+VuNMzMX7tXdeR1qFOY7e9A55/ofZnanFKLfef9U=;
 b=ep42Fl0HY5IMvh4M8W31QUfoEbVYFU3RZFv3cZ4OnLKyq9Ck2jmlQbNtyUSy9qo55bet3ysas6ElxbyrsXUvMCk72C5q12KXClZwhwDAhLgSffvkEq9fBQWGz/xBPcvz5fhPs2y3jTF9cuk8Xzu5Rdp/Su4MrLYuNuCEvw6SWF31F+Q51TOiBcZMTwQkukrcfoXFXkvWouw09MOBSmxzK16FI9d6zwLR12gKub0WLSB3hibCgCBFFardjk2VBH/9bcSMlU82gzyBHXRsUAZS6FKP/pRJQtqx28t8kUFhEWGrrn7/P2mOas9+hugMM1Rgy2xUpN/VviErnH+BrRDbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnC+VuNMzMX7tXdeR1qFOY7e9A55/ofZnanFKLfef9U=;
 b=vCUj/fV9mG69Af5HZhyPCYeSiSg1sTn7WSBg0hOBz88KoBHOCHkF++d/eODyAdR7C31JFhnkrHOa3HpTpw4gi5FqS82s3sSNI+Sk6cEnDmPQdVAnvZIi5xcna0G0wfNrCKRoH+v6bJKDQm/4vKEt171OYoa3o+KPZgA0wo/jvMJ0iHEtwgXG5oYWO7NRWDWVQLtwmO/CwMfpL22afe30uzGhKMYe7FLOpWoTXC2c/8r+WOsqF1LDF4Ub1Y9Mn3oykHLCfV5X2AeB1b61U7TS+z9kIgEdExMt2YzgNOYhh3YvDZ5WGkQhSb35IJjP7Orseij1rluuSFYAgGTOldqJoA==
Received: from DUZPR01CA0337.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::10) by GVXPR07MB9943.eurprd07.prod.outlook.com
 (2603:10a6:150:11e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 22:37:51 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::3c) by DUZPR01CA0337.outlook.office365.com
 (2603:10a6:10:4b8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Fri, 15
 May 2026 22:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 22:37:50 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 16 May 2026 00:37:50 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 824E29569E;
	Sat, 16 May 2026 00:37:49 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 709DC1005D6A; Sat, 16 May 2026 00:37:49 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next 2/4] mv88e6xxx: Cache scratch config3 of 6352
Date: Sat, 16 May 2026 00:37:05 +0200
Message-ID: <20260515223707.1026325-3-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260515223707.1026325-1-fidan.aliyeva.ext@ericsson.com>
References: <20260510213429.2044612-1-fidan.aliyeva.ext@ericsson.com>
 <20260515223707.1026325-1-fidan.aliyeva.ext@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|GVXPR07MB9943:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e131f8f-7320-4e45-3b34-08deb2d298a0
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003|11063799003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	N0OJMdSI8jrybZAI/U3gpzmIKpwc8I6jIUWQBPRe4Q78CD8TpPA54Epm18G2Tzy7dq1sItCIKSYAehNRjLFCDAJzkq+VbkWbWdYtVlo2P+uxarUftmna/YA8qZkdZsIVqXeLpAu29l7PIBbkEZQGAyskGCnz0vpALGkIWTcB12FpbER5lq+pg92zgIUlr8iZv425n65jKYDmlEuHgymLFPQA8kvJqkPD+tObzZvfzL4lt8nWxbmZ/fVn32zNTLOROQVHnDC+1vaoomsQTmfTPv0TyfvkL7zph5+I0a582wqeC+s18FGaS/cfH5usNaSrWtGtIAlj6GBVifvraMXYSfmTdb5dGtOQ7+yoxZ6nkHy2kLVnZ6+ygeG5RjUD/IMqtACfXWQMQZpZmTz59tILd+fMSKCsbLAMMe2X7HHrAkgsmbmhWiDIxncXrnJCDLwxK5WLokxfR5kVE+AxAWmjDzD9N0Yk/g8gKtn1Xo07bNiWCH/PgDJugZPw8+bOnksdfFILI6waHvXpT+fUOyQbR3Nx1c38TJz1itXgKiM1ZdWlVrLPCTZW6C/d/dZ4ocdipZlq62vsK2D6vtTU9MmtFH+aO0shG/okaxnSZWZpbNAW0wgU1qMWMh4PXQvDDCxnOuRUPA7A1MP1QQ9ASnsa44GPZSq2B8m+S0NdMKrw6DKJjRy5mvLFWzctTLMQ6DLQxxGob8u+rMFmlt0bHTixzxVoc2TB0BBuPTVUgT0AkPw=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(11063799003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g3HAiQBNKpprO3I/b3ZzkfNi6b8W4qsLhUPWl1FMAt+eOv1oYfcO3ViBmhHAnUWYXs+qFErFHohavbLPr5Vf4M2QfelL7Blc2BHLnBLq+QH9SVheECYSZZlW73M33X6MiGHpHEIL/joV/fEhJoGylJdkJUMuyOy0U9MAIqrSebb12AgpV33yH+SpD1PiAS3v84fMH4H9gTy5Vde2RjTlUqvqUYazfvVdx6Jh6Coau+10dpg3vvO16N3oMN+rfn5rEvnzV/ROpRCD1Rl3LP5QAF+8ML92nyWvJ7VUN+3BM/GJ0f4gpSPMoD93B798l2OVTNtxxqabzLG9KBBhfaZSFCJalcK6UrVSONfGc5lthYsktIfNNLlp61e+GsCF8d47iEDPH9EfEuEPCJHfmHdeSx7p8WQ7xFohfJ5BOrBh8W0iI9ZWns6olt+pyfRMoNT3
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:37:50.5917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e131f8f-7320-4e45-3b34-08deb2d298a0
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9943
X-Rspamd-Queue-Id: 3D450558FF6
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288480-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ericsson.com:email,ericsson.com:mid,ericsson.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 25 +++++++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

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
index 53a6d3ed63b3..a2c09bbdde17 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -321,6 +321,31 @@ int mv88e6393x_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_g2_scratch_write(chip, misc_cfg, val);
 }

+/**
+ * mv88e6352_g2_cache_global_scratch_config3 - caches G2 CONFIG3 value
+ * @chip: chip private data
+ *
+ * Reads and stores config3 value of global2 scratch registers, which
+ * can be used to determine if the port is attached to a serdes. The
+ * value does not change once the switch is released from reset and
+ * represents the value of the pin strapping. Returns negative error
+ * number if the register read fails; otherwise, 0
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


