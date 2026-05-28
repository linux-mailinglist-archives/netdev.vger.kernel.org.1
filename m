Return-Path: <netdev+bounces-292849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LgHIGuvGGrLmAgAu9opvQ
	(envelope-from <netdev+bounces-292849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:11:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F55FA4C9
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352E93094B10
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8AE3546DC;
	Thu, 28 May 2026 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="vomtHsFz"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83894351C02;
	Thu, 28 May 2026 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002237; cv=fail; b=BRnbVhHOQBy5OB5cGFZm/uMmutnGV12wjhsEzmU5Pf1yaX4rTUoKETUUTqFfNfSrNtdE4Q0OwGVcgUOVto150BddIP18DSVHusDw+WcHX5NNIpTuwpZRaEfJMEJCMxYnV7D5HNN2pYhdG9XvtWjc6Y6oY5suw+bpULQldzCSa8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002237; c=relaxed/simple;
	bh=LlfJ+aT9jaN+amu7OnDI4qyOXw4b8SnijIg9/uJJvWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVaVVvDvSYQxod6RvNO3CaAhAmE2kQZ7OrihbovuXm7n/tFPnPwYySIaoOh9RUdNBQkjVeK/zhati5D8qV8alWgCw1IXlNczgOTxjgevOWA1kntJF0cBwWCKJMb0nJKD/iWY2MEXgDywB9lUNBAngksMcv7Ce86oawQXWFMBMUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=vomtHsFz; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSJ9fLaQmYmkRORsowaAH9YzmEoO/otrXM9OB8H2iS7fQkcb03WRdj3bLOunovxvaj//MxwYGnLf7oaPiGcRCJAA8LAHnIGOXQCZKJOvvlchOz0SH+IcN6KjfKUZM3yDMtBhqFQoUb2P+KX7Ye0gScyAFdRvY0t70JYmbzIMDq1poa1bSUk/OCxg3fD8h1jxXKs6SiSOwFgWNCEBwiao1mQuJBbfYTFV6MQ9shJW1QxnGjWx0gcDXcXSSvUqT7ylAqdyNDbNB2MWqXVkZ+D7L2RqDNg7eQG6MMSYUHFD3o+j+7WQMNfLJL7SlHrLhyJHkBR13iGK7kQ9RcGpZPwMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbUAfyusoSUT9uPAyq/p6PrHrW5kzzmOyg1G7IjLHNY=;
 b=CQAkMeUE6sIu7HMjKROoiaCIlrjVcs2w1LBjf2IVpQe1+MuwWmveUboemf2RivIcjJfYIGOoz6QEq+URhbBPOrT11YQoIOCxtjsNRDPQEC/KwNJCW86HMTcy+PS2dKznjtlbKNyr8jhuSBIzJlgXa+ejuq9hEdDm9KeYC5HMelNAUyjmc5vcJLsW21PWimyOWNv9gFfww8ZkxrBTT8Kscr8TzJicrcQug5b6b2ybFztpbVQ1/i3r83m2fFspE/JRm/ezW0GX/fvgOsYaVi8U+3m2bQRLRiC2EgLlNWUdPK5kd+FMky1aF+y4G1XhfOg8tuLiA2Lt2M4lVbZ/11+clQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbUAfyusoSUT9uPAyq/p6PrHrW5kzzmOyg1G7IjLHNY=;
 b=vomtHsFzQlnxS4BTVQUyk1j9ZUDfNjKg8ukolqvJan6CP3Ghhfg+pO15rCzuB07qb9fHfoc8o8dONyponMw8p6gnNvDUPQaxduQRXagxx8D+qvbnBxfZj3jgriBIXHwbcrWRJJMB7VWHH1EpKSjINBMT1HLpalpSvDFeger7PILIMce/um5yrAHO4tabqezn+E1mcfCk4zG7tNGhewh9xrSZXsxjXHHiMxOtN+qRYzigkJor5brwDO1F+FqGLbGeFxhgyzrAYtnY5NBKL/0JXnthGoY17Ls8I8L9qEgntrMF53lL5WCnbPm2MiuLrwvMMkWNcbX4Fl4LE+5n00w+vA==
Received: from DBBPR09CA0025.eurprd09.prod.outlook.com (2603:10a6:10:d4::13)
 by GVXPR07MB9918.eurprd07.prod.outlook.com (2603:10a6:150:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 21:03:49 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::4c) by DBBPR09CA0025.outlook.office365.com
 (2603:10a6:10:d4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 21:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 21:03:48 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 28 May 2026 23:03:47 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 69C7F4020B4A;
	Thu, 28 May 2026 23:03:46 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 5B63D1005D6A; Thu, 28 May 2026 23:03:46 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next v3 2/3] mv88e6xxx: Refactor 6352's serdes functions
Date: Thu, 28 May 2026 23:03:09 +0200
Message-ID: <20260528210310.1365858-3-fidan.aliyeva.ext@ericsson.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
References: <20260528210310.1365858-1-fidan.aliyeva.ext@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|GVXPR07MB9918:EE_
X-MS-Office365-Filtering-Correlation-Id: b09ee3ff-d730-46d3-28f4-08debcfc9cee
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/IM8Gkov2keHLKg3HZ3NHcpqWBQtooa7zH2Uinxn1sdcZzlt9yfhgHPKuPMAOHbOiqTVvsBiy9FGOdNzy7YrYw3VwCparQPo0l/JbrZkKz18oFPLMNuvu2A5YOrZHsi+I+D+69TIYfriEuTl7xkx2BqpndTr/f61cjy190mAgIplJfI7g94cUfqWcB0DHRI8sa6WkwHWtQMXU7hHM3xK+200F40UQzMOzdacyJTd5p0vv3NseL/9Fq3Awew8Hn19EBDC3tUjoyw/JGjepPl93taa2kSIywggoEOO0s2L8rz+DJ9XJNcP7CH4F2dlSSm6u7Zaq4iAa0DSrrll4cmjOVPiOfc7vuHXioPFEaKnqvYuTDkADGucq6JwWCWO4hvwn3nfHez+u033JXUNu3cj9POJa/kTbhAVNrl77aMuZiUjfZ2GcNDE9w0s3Dhaiub3YzNC8fXRz4IEXQUuGQFmcWe8ahnJcjxilqwpdrl80mU/XF6bXodB3DmhGSZM9xRpXNmXQAdZ/nmXblDxXZITnNdiavXIVq5ygnOICd24AeFtYr3meb24/z2rL/7kuGVE4OsB+aBr9fHuEcYH2Sj5TDNnmYFCCwjU3dREmKJbf8CHZADPKIbtj1MRAWWuAwSqYQSbMzw2f+XUIDUDZjq9mrkSTethUL7UCQBqAKJ1PpIagxXdW082w6jyVZ4GDNP/yj6PLYCHlz42kFXFmeZsQ6K5/rN/SUKsjf6M+QBRSvs=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vYf9dl+lLBF7ALvAx7mI5Qh1U4ttHmjMYo0OM/JbqcQ756mgTAft0as9m0Anq35V3QiCF9N+m//fBDH6tbl+77f3rg1Tjsdb+ISSAKTKJvsaTYjPwRORAoa2+9/cY2lWEemUKqb7UU0dak2Zr+iRSHwSgj8eBXHmdFQ3kJFvY9LDSScdNcKcTqgKETXgfotvuM51AThzwhYYyjQVuvKW+S8pChwtCsenVX6Ck5xcQ6iFcB/00nCOKZ9qot0Dzhlo0pgYscztuECtge5m2YoWBG/9FtzAmJp9iALRAP88cyIxScgHB408JNNRCSJWU6hDQPDYasJiK1agFTeZWR0zqp0e8XjbJKXfkEIlPCXmunmgU64PnNJvMf8l0YyvwNyKd5KYTZNYbifz/YxMm5J+g2Ia9M28VWG1yAk+asll+aWlAAPuaDFAOn44+waoTcho
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 21:03:48.3034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09ee3ff-d730-46d3-28f4-08debcfc9cee
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9918
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
	TAGGED_FROM(0.00)[bounces-292849-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fidan.aliyeva.ext@ericsson.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ericsson.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1D1F55FA4C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Changes:
1. Replace serdes check by mv88e6352_g2_scratch_port_has_serdes in
mv88e6352_pcs_init function by mv88e6xxx_serdes_get_lane function making it
more generic.
2. Replace serdes checks in mv88e6352_serdes_get_* functions with
mv88e6xxx_serdes_get_lane making them more generic.
3. Add lane argument to mv88e6352_serdes_read so it can be reused later for
6321.

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/pcs-6352.c | 10 +++---
 drivers/net/dsa/mv88e6xxx/serdes.c   | 53 +++++++++++++++-------------
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-6352.c b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
index 308655d72d52..4228ae5bb9db 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-6352.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
@@ -324,17 +324,17 @@ static int mv88e6352_pcs_init(struct mv88e6xxx_chip *chip, int port)
 	struct mii_bus *bus;
 	struct device *dev;
 	unsigned int irq;
-	int err;
+	int lane, err;

-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	if (err <= 0)
-		return err;
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	if (lane < 0)
+		return 0;

 	irq = mv88e6xxx_serdes_irq_mapping(chip, port);
 	bus = mv88e6xxx_default_mdio_bus(chip);
 	dev = chip->dev;

-	mpcs = marvell_c22_pcs_alloc(dev, bus, MV88E6352_ADDR_SERDES);
+	mpcs = marvell_c22_pcs_alloc(dev, bus, lane);
 	if (!mpcs)
 		return -ENOMEM;

diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index a23eb3d50b6e..48db9932b989 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -17,10 +17,10 @@
 #include "port.h"
 #include "serdes.h"

-static int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int reg,
-				 u16 *val)
+static int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
+				 int reg, u16 *val)
 {
-	return mv88e6xxx_phy_page_read(chip, MV88E6352_ADDR_SERDES,
+	return mv88e6xxx_phy_page_read(chip, lane,
 				       MV88E6352_SERDES_PAGE_FIBER,
 				       reg, val);
 }
@@ -126,11 +126,11 @@ static struct mv88e6352_serdes_hw_stat mv88e6352_serdes_hw_stats[] = {

 int mv88e6352_serdes_get_sset_count(struct mv88e6xxx_chip *chip, int port)
 {
-	int err;
+	int lane = -ENODEV;

-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	if (err <= 0)
-		return err;
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	if (lane < 0)
+		return 0;

 	return ARRAY_SIZE(mv88e6352_serdes_hw_stats);
 }
@@ -139,11 +139,12 @@ int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip, int port,
 				 uint8_t **data)
 {
 	struct mv88e6352_serdes_hw_stat *stat;
-	int err, i;
+	int lane = -ENODEV;
+	int i;

-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	if (err <= 0)
-		return err;
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	if (lane < 0)
+		return 0;

 	for (i = 0; i < ARRAY_SIZE(mv88e6352_serdes_hw_stats); i++) {
 		stat = &mv88e6352_serdes_hw_stats[i];
@@ -152,14 +153,14 @@ int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip, int port,
 	return ARRAY_SIZE(mv88e6352_serdes_hw_stats);
 }

-static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
+static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip, int lane,
 					  struct mv88e6352_serdes_hw_stat *stat)
 {
 	u64 val = 0;
 	u16 reg;
 	int err;

-	err = mv88e6352_serdes_read(chip, stat->reg, &reg);
+	err = mv88e6352_serdes_read(chip, lane, stat->reg, &reg);
 	if (err) {
 		dev_err(chip->dev, "failed to read statistic\n");
 		return 0;
@@ -168,7 +169,7 @@ static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
 	val = reg;

 	if (stat->sizeof_stat == 32) {
-		err = mv88e6352_serdes_read(chip, stat->reg + 1, &reg);
+		err = mv88e6352_serdes_read(chip, lane, stat->reg + 1, &reg);
 		if (err) {
 			dev_err(chip->dev, "failed to read statistic\n");
 			return 0;
@@ -184,11 +185,12 @@ size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
 {
 	struct mv88e6xxx_port *mv88e6xxx_port = &chip->ports[port];
 	struct mv88e6352_serdes_hw_stat *stat;
-	int i, err;
+	int lane = -ENODEV;
 	u64 value;
+	int i;

-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	if (err <= 0)
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	if (lane < 0)
 		return 0;

 	BUILD_BUG_ON(ARRAY_SIZE(mv88e6352_serdes_hw_stats) >
@@ -196,7 +198,7 @@ size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,

 	for (i = 0; i < ARRAY_SIZE(mv88e6352_serdes_hw_stats); i++) {
 		stat = &mv88e6352_serdes_hw_stats[i];
-		value = mv88e6352_serdes_get_stat(chip, stat);
+		value = mv88e6352_serdes_get_stat(chip, lane, stat);
 		mv88e6xxx_port->serdes_stats[i] += value;
 		data[i] = mv88e6xxx_port->serdes_stats[i];
 	}
@@ -211,28 +213,29 @@ unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip, int port)

 int mv88e6352_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port)
 {
-	int err;
+	int lane = -ENODEV;

-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	if (err <= 0)
-		return err;
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	if (lane < 0)
+		return 0;

 	return 32 * sizeof(u16);
 }

 void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
 {
+	int lane = -ENODEV;
 	u16 *p = _p;
 	u16 reg;
 	int err;
 	int i;

-	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	if (err <= 0)
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	if (lane < 0)
 		return;

 	for (i = 0 ; i < 32; i++) {
-		err = mv88e6352_serdes_read(chip, i, &reg);
+		err = mv88e6352_serdes_read(chip, lane, i, &reg);
 		if (!err)
 			p[i] = reg;
 	}
--
2.36.0


