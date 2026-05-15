Return-Path: <netdev+bounces-288477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH4LDbGgB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:39:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D9558F8C
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E97D30374A7
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181193F5BE2;
	Fri, 15 May 2026 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="ScVsnKoK"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012033.outbound.protection.outlook.com [52.101.66.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328093F5BE4;
	Fri, 15 May 2026 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884674; cv=fail; b=U4mNCEq3prujghVGgYlILglTCLWgEXR+XDPGhQUZ3bn+rAbynGPNKBUBtp6SuL3XVlttjDbB6N0hXRw+Mqz2rn1RX8pAuqsOYX2mM8diyTbIEXEXaMEku6eR4wU9NXTnk4RuKNxGy8L7lMG25T8j/5TPxT46TQNfETDc/AOWk9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884674; c=relaxed/simple;
	bh=Hq/sOUFo6NfRXo1CJAUy1PPGFamAJHIpVq0bhhcvMPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmQY7HtdmNqM8PAKAf14GPj/r/rjWb2ZN2SaT5OP8EZn/wWrjK1hR4nRYpfOsfrYH++Puj/Ib3lVNKiUErOZIOYzfyWvGzTbFIVRn+IIrFqNybqVhSs61/HvdGiiRcOAP4cvB75TQ4LpWW2fRSHlpiubt+PX8/zzivIWrcpbXA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=ScVsnKoK; arc=fail smtp.client-ip=52.101.66.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBqpD3rGoKgE2u9JcrdHt2TFCCgCOwoAmnWG+dEPQIhIA61l1ACaAL7cBGyZeZiWUtzdM9z9txfMkhgW1IHz9GbhPdQiMvyv6vE6eaKS75lHio51cSSvlAfqQ0pwZiqu5H1ho7zvn1tJwL9XWPPrmzUFAcRlfnwMC7h6qs1m+NH1oW/D0CB03RDLGNC+FP3Bmx9lx1WZSxZrpvUw3XRm/302EyYVGt7hbU6aKfixALivPKhnCPwhy4qXpJ0/W+580VSy7dnqyGc6qTtWD8FbNSns4o4Pu6jXfGFwtGo7mVPyM5bJJjHQE8PqlW0ifPPfkYKH5XM+/nDuvt8ab8T7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXIZlVo4hiOJRVR5Lrn7RVvgrMnrBi6KHIQnuvF/Ro8=;
 b=LwQ6KvV9Bla/9pm1c+uXWUQe0ge87BaeuC1r9zWJS7xEj5ziFghNBpnx8g70Pb0TyJvjWHmrwWjf6uwoazm/REybPAjwp0BO9081omrRpK7yGiQImpnmlsDQH5P6hK6EQ9036EFrpWtaD+sFFkq7GVInK7HP+1ILoLJyqaE836WQIxkJaIy0DFR1q1Oox6tK8BwKNVs0H0BwW/LOIdvbxv09BTvw1mSIzvy/Cd3XRqO7JzGA1BhN85sD92w1uvyAeEcG4Y1je73QTml30NMXDsZUfCoT0grn7kQE8bsmfBHNPsmMMM072qJZ2OxwbkQBz1yRXIcfOF8K2EGwLKcV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXIZlVo4hiOJRVR5Lrn7RVvgrMnrBi6KHIQnuvF/Ro8=;
 b=ScVsnKoKq0W0CR+FvTLYa5Ay4ymIBQIU7E75vko7BCaXZzESqkl7j83nZfqswpvVYp5ftpt86KlK3Rp4ceW27FIoapmcnEGPOg3RuCOmpozueHF1tC2xy1NVhol7pwv2XeXvUAU1NP447QAyeHh2LRkF8Eafr6GJA2+qwF4ulAnTR8qj94uSEoguwxwcf2+rklBl6xUCz6/fQx5lP8MzsqVfZ46p8uiarh88WOL4RBl7xCV6JFN7HDRpMslzB9+sh9mMzqbWDjY8B8oYCYBwGcfVvQSB2o+80yAFKy08kLOEfc8mvbOq9CkGVfMlUTfKxQebV97+mIdFkT/XRSwvVg==
Received: from DB8PR04CA0029.eurprd04.prod.outlook.com (2603:10a6:10:110::39)
 by AM9PR07MB7268.eurprd07.prod.outlook.com (2603:10a6:20b:2c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Fri, 15 May
 2026 22:37:48 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::c0) by DB8PR04CA0029.outlook.office365.com
 (2603:10a6:10:110::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Fri,
 15 May 2026 22:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 22:37:47 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 16 May 2026 00:37:47 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 8158E4020840;
	Sat, 16 May 2026 00:37:46 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 6CA231005D6A; Sat, 16 May 2026 00:37:46 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next 1/4] mv88e6xxx: Add mv88e6352_reset for 6352 family
Date: Sat, 16 May 2026 00:37:04 +0200
Message-ID: <20260515223707.1026325-2-fidan.aliyeva.ext@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|AM9PR07MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 02af9c91-b457-496f-6049-08deb2d296d5
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|4143699003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Hff6z7qWRX/QDUYyHfMkc++3jKO6X6lNj3O8n5H6hP0OQ4AyaPpegUCqNWlwmkTVo2gML6TWLxB3ua8oHucVF1X0INRni3P5QdUqhJojal3bxoEfDXQIVMi43GXRRJBoQvg2dExklZaKas+KCKjgkJvMWygpv/CHZhjstSLQRp4kwyuFq1Fhx6HqZbP/JJTcC4ciltDRUTQEjf1hJg8lvJWRh9MCggi/oNV5D/zldZG/mF5QC8luvoOplizj0AA63uHvnXmmjkxRGmfR5/r9WkAwNY8hsxFDb80Qz62grR7nx5y2v8tU/zJA+VN0BniT44VzkzX2WKJPzzI5DrT5pNF85WS/T2ABn4JLYODFIzGX94rZNosyjxv3VZs+QF7vTkEPlir8/y0JYYwuOqvAYlbQRWq4or0xbif/AnbBtUWC1pbH3yy3cOk6E+LoX8v4Mnkh5R8/GmulLbUMSSt1goLgb4CTivHQZOaJOOhWJUk0CvGdnZ13+t8W6lhyOUtKbE/Ud26+8H7g3llBj7TUJykrkg6A+YTSxjJBAZrQEWdetdyWCJEKN6HU3qEDu4SbbAf069Kt3HU2ybqmySABPD8PROYYTu+28x+VqsBINbXoXMBfrmml6B3FOmnEtpdafGVDsCgtgahSfKmy8V7ZZ0z1L72a5RSyqY+fGTFSMzSyHxI2rDTxs9TPAfSyxVn1lPm2vWteDw9mu744iG7xHs4RkuMirVWDHZ+AAwNp6Xo=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(4143699003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	80fwX+cD8owb40SPFbcpK98+yA0XfVnBhSqcnqvMFm+gBtXQ59Cq2b/zJCzRGeHOnjzquK7cMVmMwgUNWgWv67/OSF8to2VK4Md96kAq/twZL4Q23n5R14MRgXjvS/oxS+8o8xicUeSb2VCTS+u27zZEltIOScukzZrLMKJY6yHq6+xZFsBRR1jD4jcsfUOkD42xpBvFgKqj9ipIX8kf0K+4E33cVzwZjug8rXOvWICzXe06nfGxZ0Whon3SfGAoJF0gQ3nTMWQpV87p35sNWqAbDTwz1U00DBFBoNWckqiSoCMVUt1UfG1vXXcOShNFXvww5Ivg3ylpjpKUgwF+cQvMJFlOQfTcRZ2YlolwtqpBAt8rDAyqzsUWekW7sezlRbyEtkByHSm8uj/A43YAZYS5/1dZgPckApkZGaCUY2FkDwxCcLXRCzJdzv/7pZoH
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:37:47.5827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02af9c91-b457-496f-6049-08deb2d296d5
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7268
X-Rspamd-Queue-Id: B04D9558F8C
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
	TAGGED_FROM(0.00)[bounces-288477-lists,netdev=lfdr.de];
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

1. Add mv88e6352_reset which calls the previous ops->reset function
 - mv88e6352_g1_reset.
2. Make all 6352 family use this new function as ops->reset

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8ca5fd40df92..6102b7fd8d44 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3736,6 +3736,15 @@ static int mv88e6390_setup_errata(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_software_reset(chip);
 }

+static int mv88e6352_reset(struct mv88e6xxx_chip *chip)
+{
+	int err;
+
+	err = mv88e6352_g1_reset(chip);
+
+	return err;
+}
+
 /* prod_id for switch families which do not have a PHY model number */
 static const u16 family_prod_id_table[] = {
 	[MV88E6XXX_FAMILY_6341] = MV88E6XXX_PORT_SWITCH_ID_PROD_6341,
@@ -4654,7 +4663,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
-	.reset = mv88e6352_g1_reset,
+	.reset = mv88e6352_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
@@ -4757,7 +4766,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
-	.reset = mv88e6352_g1_reset,
+	.reset = mv88e6352_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
@@ -5032,7 +5041,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
-	.reset = mv88e6352_g1_reset,
+	.reset = mv88e6352_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
@@ -5463,7 +5472,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
 	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
-	.reset = mv88e6352_g1_reset,
+	.reset = mv88e6352_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
 	.atu_set_hash = mv88e6165_g1_atu_set_hash,
--
2.36.0


