Return-Path: <netdev+bounces-290607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GAFFfBrD2qOLAYAu9opvQ
	(envelope-from <netdev+bounces-290607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:32:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1915ABCB4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940B6304D24B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A34E4218A1;
	Thu, 21 May 2026 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="bQAJuXKt"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE48C3E172B;
	Thu, 21 May 2026 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395391; cv=fail; b=M30MeeCrK5RRE+aberrFEh44mpyiGuaFczQ+rbrbcUvcBv1UIxXwIRdBXufgR3xF+VrXE5qc83DgFgrC7GRVji12OM9YfNoSbJqvQtmh5GSDE+F+x/l4ltzP+MUCvrvePeBRvPyNzd/woWoEUUPa4bOmuncIOgdBwayRxjTqmK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395391; c=relaxed/simple;
	bh=oUFyVCW+OjwRjF16ZkMy0ScmFKVu3UBQg8iolpxAKPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeHjrVyiO41wY0bPQXJwjOJ3tLMFmME1k9s1r4cutj27Gs6vWvcUllsyZRUIySNr9Ue4iYFhxMZUO3rJXvKykwSY6KK3EID4Gn4f7zUe23WHywgIZ+1y20l4XoL+J2H2M/cR1g4r38VGUgKHxhxHndrlGpYz5kkZJBhWpGujpJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=bQAJuXKt; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU7ASBreBjPnt8ZVhmZZwYYR8qKfHhxIVVMc/5wWF9dRlrObHfPauJpPQ1IJ1yjr1+Jc9YGd3Fr5vUPZJNrIHufIAajnTMdwsqntk7KQjWP7kRnDztndqNjRiQerpHqZzW5bO/DTjVZQkQPEhuz/a4r+YfFsJ+BZU8BKs/zxGUS+K89tM85oEIt8SqX7F1d4oHgtYS2AO+9mgn4vT/bJ7K+iSu+7Jn21doWG9R7fUXi1lbvAmcLWmLRr243pv3TJyc77UQ7nC+M1UidSi7NFqL9m36bZlr/+WB+pnRIbLyb6jzDB0YbyRm3Qw4hlqM2blpGkFpP9GLyn8SWKOFXcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH/jULfdgyeACxs/2hZLkX18zgNZg8gQUfU6Az8XTEA=;
 b=l15QSqccZsDiKRozIcJMBT+J+z61Fv5filDVEqIBqC83QcX9KghWbAks9Fdas5GdLeMhT0FdtrnMHekuejE5j3edtFaIu4TBnniFBcLttG7JpXvXUGGWb0Osc65TW7rZGQE8nBpzYW5KaCjt5D7aNRlIXrufd5Nl5dIKzYV6/B1UYwPOmS1gW0+1ca579tmOpq7HPxZTeBXqG5mtY/pKHdYd7nnAVIMdbvkz+57jUl/8fAmuqMr/nORnQUXwLtDpyKzDRb9K0YDnIB5m9fwSFo3i2FnHiw6Sg1TIdlENVg+pf2/HxOyLpULX9pQN7NtPC+63XB4UGtkeLe1wP9zUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH/jULfdgyeACxs/2hZLkX18zgNZg8gQUfU6Az8XTEA=;
 b=bQAJuXKtQkXw1XbUbdEeg5FavxwWfXVdrjHIa4Mapg0FZQW/ww5SuOcgoGvx63tva53nND68YN2GgNpE33OpWSmruikZ/vp9aVwW1DXXPzj47m5gP1Zqs2MyT9RWFgtXkCgQU/W8TPVEmRqaO+Hvd913vlXklx6lMoVwWK77IHmApTb6AvSrVR36InqTWVf2x7N4mrmylEGuCDcamkZxRyiaMaWG3VJ4dUShpwRIInbxBPNatBD0HKP/zHkYW/fTlr1qJospp8/ny46vLTwVMeD+xlsqONcYcmvvrlP4W1GxcU48e7XJgy8ebcstR2a1lcyupDQovIutZ1yhiQbWsQ==
Received: from AS4P250CA0014.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::17)
 by AS8PR07MB7160.eurprd07.prod.outlook.com (2603:10a6:20b:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 20:29:46 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:5df:cafe::3e) by AS4P250CA0014.outlook.office365.com
 (2603:10a6:20b:5df::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 20:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 20:29:44 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 21 May 2026 22:29:44 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id E16FD4020B7B;
	Thu, 21 May 2026 22:29:43 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id D0FC51005D6A; Thu, 21 May 2026 22:29:43 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next v2 3/4] mv88e6xxx: Use cached config3 in 6352 has_serdes
Date: Thu, 21 May 2026 22:29:23 +0200
Message-ID: <20260521202924.727929-4-fidan.aliyeva.ext@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|AS8PR07MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e371019-aba4-4c57-6a04-08deb777b20d
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qZFE9TC+1qEIGewE7P50prfv/pibjsRSaijL0Uuwz9e1o3vlziDDElPgbcBOeyu7jZ8wQZZMopoPq+9zMmn6bpx5/AN4Kyhe+wxDIRjSzMlaTUTB8gidQqqAIYxBRypNQ6PR0e5oe938fUny+59fwk4IHeO+YfCRUUOcxCiUeFSddo5w9vXgRbJlG06fPgBO3x+yGxQP0uirkMMNzk14IH3/T6TCjxBE1Up0Zpltnr3Y0i68GAcXs7RcOL/2HIbmX+2uMDS4EKv+JIS3IBzzESJ5trMH9RRb3JtIu9VTxI0iDNTILQJzgL7HdkQzqX0Yt+foE0dQdhr+j1mNV44j7XZ7hFKxs0h56h+srRFLjnJS4Ity69C9iGBbeX4LIcdyOvCPDJBPNcdtMTDzPd2ZpvSCwctS0/xHs/xyAGQ+W0KijjWriTHg91o2IHYthoxogjirNoSpZl53mvaa0wkAX56Mvr2evOe0j8Is8rugNM7l1YIbX20ANUqlpAGMIErQHJLlN8sL6kGtmW2zbI7MPylMDyO7+6l+sX4SvNNg/u9CH9Q4dKJQ3UNcv7HSU7BmxSPYnI4DPu0QYrmGINci3j4QVH+RppzKImuxO1Cxafere3qAf26KdAIuZC76GWReg6AFA+6V8L4W0GBm+7Aic/5hFuBl4jgW8IETf98iflXVy6Nvo1rX1sHll1wqJKB0Fbun+c+pZxahJt/8iBpKO4MavOM6+1uUo7OC5SX9O04=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rTdohKbDleZoc1BPyDn4It5srgVOUhWUgTbyOis2VZ4Xs4qn5c+ym9KdGVcx4H4w+Wv3pS3Vt4kw1KVlAvhVMZt4R/IUnNnGB9ZcqZ9MRMm6gOFye6GNSZfIQ18bt3tSs4ruI5RlhqmTRaJclbsRr+Y+Gjvgj6ZWUC7qroBtsaWa6CzJOy42sJyLNkhUuK0cf9Qxov8Kz5VUHPPBZi5VhYPjrtU3JDej+3YH42st8ILbrxXEJ4/IjCcJm1pCdNeseLQg77iJsJCG/K7ziiuUiFM1KEhdyMsxYd28Ci8shCeWzonzww/ZHCTemlgk7swDMWy2K2EnFFeI3LuhuHqA5UyAqLoAL5hIetR1xrmac3ZIXe2ZNyI3E8fPg+iDQSNPonzJSQB9dWo0VVal5iBQph4s55dJ6t6PEeqNleSX7TlLEw/NfrZ048xQwmWuTjlP
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:29:44.8806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e371019-aba4-4c57-6a04-08deb777b20d
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7160
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290607-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ericsson.com:email,ericsson.com:mid,ericsson.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: AA1915ABCB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1. Refactor mv88e6352_g2_scratch_port_has_serdes to use the cached
scratch config3 value instead of reading it everytime.
2. Remove err<0 check from mv88e6352_phylink_get_caps as it is never
true anymore

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c            |  3 ---
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 18 ++++++------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 4ed6f880e02c..63cdcce3d8c7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -685,9 +685,6 @@ static void mv88e6352_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
 	/* Port 4 supports automedia if the serdes is associated with it. */
 	if (port == 4) {
 		err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-		if (err < 0)
-			dev_err(chip->dev, "p%d: failed to read scratch\n",
-				port);
 		if (err <= 0)
 			return;

diff --git a/drivers/net/dsa/mv88e6xxx/global2_scratch.c b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
index f2f9e7dce1aa..f292ee4db113 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -348,26 +348,20 @@ int mv88e6352_g2_cache_global_scratch_config3(struct mv88e6xxx_chip *chip)
 }

 /**
- * mv88e6352_g2_scratch_port_has_serdes - indicate if a port can have a serdes
+ * mv88e6352_g2_scratch_port_has_serdes - indicate if a port has serdes
  * @chip: chip private data
  * @port: port number to check for serdes
  *
  * Indicates whether the port may have a serdes attached according to the
- * pin strapping. Returns negative error number, 0 if the port is not
- * configured to have a serdes, and 1 if the port is configured to have a
- * serdes attached.
+ * pin strapping, which is cached at reset (scratch config3). Returns 0 if
+ * the port is not configured to have a serdes, and 1 if the port is
+ * configured to have a serdes attached.
  */
 int mv88e6352_g2_scratch_port_has_serdes(struct mv88e6xxx_chip *chip, int port)
 {
-	u8 config3, p;
-	int err;
-
-	err = mv88e6xxx_g2_scratch_read(chip, MV88E6352_G2_SCRATCH_CONFIG_DATA3,
-					&config3);
-	if (err)
-		return err;
+	u8 p;

-	if (config3 & MV88E6352_G2_SCRATCH_CONFIG_DATA3_S_SEL)
+	if (chip->g2_scratch_config3 & MV88E6352_G2_SCRATCH_CONFIG_DATA3_S_SEL)
 		p = 5;
 	else
 		p = 4;
--
2.36.0


