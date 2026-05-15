Return-Path: <netdev+bounces-288478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE9KIFyhB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:42:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FE558FD8
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AB3C301B4EB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2423ED5D8;
	Fri, 15 May 2026 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="bsiMu8ti"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B23EBF02;
	Fri, 15 May 2026 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884682; cv=fail; b=mwAyxn0kq1XS3CDLsWH0lno9B4qgmlgeBOnPbbVykT2yxABm0C1QFL77dd4pnL7EfF9heR2i7tCHO7BJVFPQDxLOv8mAt7B9q2C090TNL0ol7F7TLgEKW+BUlKLjiERJfBXFmTcBD9kpFlR1vt8GTmFAcsd+/x+yP6Gpp2q8cAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884682; c=relaxed/simple;
	bh=cq9AmFrYOwwFyPaNOUaULCadhIkpmQBSV+akpibNQqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHntl8zkDoGvoltw8FQEVnHUtdgHeHLfGEitxbjQjXVDr6ybpUCLa3VvwGgPlPwW+QiO/UcT7+gU6clOk604TUdo+43HKOqcJZqiU5BSRjVRQi7/LirRwI1VJX2t+L3LlES4vEvBHMHPg4cqbaiKWl4QUmkYXorQCWLWlr2XaEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=bsiMu8ti; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YONr7AKToYkAjWwYsE+xT3lnSorR+BtzojBbDK+n0iZFY5/7MtES9boRMt6spLSddt5v9OwdjSNLNVgzwZnF1VS6IlaZSHhCCJDJe85vsphNgwPG9dydpGWpPI/b6+t8aM3iBP2paxLNDo8EVcj4GFmAmDJASm79QsxfWVDBbIh0kARbwKm6LFsEw1aN2XPO9TXZmoN4bWSxy8c16BV3csGe1RAzQ+A5Jf3tO6/HlZ9rtwgDHtTHcEWSTzGmFMQSd22vi9B1KfD1NwKpA1wUa8yb6g8Sa8gTT4yajDWT4KFSmUbePkECS2NUdWLoxZ9wsH/6g52UDRE2QLtlY215Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1g5UvKW9+jHTEN5xHVqXlO9PGhkJlVhXkI22zY6aNSY=;
 b=CNr3+X29bUlgpTPuhzRuUayVgI2fX4NPQexeZp7y1IStn3EjVQNbaONb4cPcocaczP0vFsj1bkFwDzPOteEidlNDbFQrvBLO8KixdulMHQaO7CRkvYUpZXnplaQYpR4pYM2GeHj0yHUoJ7ZA4yht4SVnabo6AlgBmTgB6Sdfl+ATtm+row14varUt3mKOOu5ImUUunl8YxLkVSVL7vkbjuNJgsaZQo8CjrjuH6mkkigGr7JXdm11mcBJCBg/ajCLXbY8KVzQl4W1RtBq7L4JZFG/2THQPnRkQYIqbY/7TDQ+Jv5NJShHCz1p9bx6lF7qrWPTgyfGZfgd/MFutR/0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g5UvKW9+jHTEN5xHVqXlO9PGhkJlVhXkI22zY6aNSY=;
 b=bsiMu8tieIE/QTWTwbkKOUT2WGc23LhP50FQmTQ1LPj7sl1pP4O7sMF/BMx9kvFFBHL9OhDy0vMCZ2UTPLrlogOchhX4UDT3MeKnOwDq6Vzbc1QT+OxcLzprcOH+NyjAcgXdqX3yhGJsBnKQD4r5Py3vyg9FizIULhmWjQUsA9UzpU+l2sp2OsdD6KNWU25nzQzfUQKPQYanzBydaPy94swwLSNcj69/FUqoEO5/b6nbg1XHgXUySRWRcPO6zf8FOcD3h4KOFDYHmeyYvBoBguTHqruXEAwkVSIC6gtN54NphhEciu6c1GDAD02u4npjKCKcz9NdVJj2Zfaa5FryjA==
Received: from AS4P191CA0049.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::8)
 by GV4PR07MB11630.eurprd07.prod.outlook.com (2603:10a6:150:2e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Fri, 15 May
 2026 22:37:53 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::93) by AS4P191CA0049.outlook.office365.com
 (2603:10a6:20b:657::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Fri,
 15 May 2026 22:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 22:37:52 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 16 May 2026 00:37:51 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 1045D4020840;
	Sat, 16 May 2026 00:37:51 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id EF1CB1005D6A; Sat, 16 May 2026 00:37:50 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next 3/4] mv88e6xxx: Use cached config3 in 6352 has_serdes
Date: Sat, 16 May 2026 00:37:06 +0200
Message-ID: <20260515223707.1026325-4-fidan.aliyeva.ext@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|GV4PR07MB11630:EE_
X-MS-Office365-Filtering-Correlation-Id: eca369ba-6685-4932-f2f2-08deb2d2999f
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	R97Rd7EOFKNXK3GQwns3LWLmo0j8KDnmY80HLQqtUvm3SoCpBpN+xayyUOltgPfEH/JikNTEByvkRKKZzTBqKsbqqiWcuCojGBt8Ggmnlzy9tWJi1UdOMZPDYTXPqtSy7QdgfLQ3SxUaZQ0MitK7wT2XerExGPd+b18qrX/Y7/dGJQ2pfSCC7Sd5Vmcpl+f0aaNrWOfb+JUWbfimAx+/5bmR8DE3z/g+IP+JODg/ea1BGf2C4kkV7W+WSXPLlE13cAR/rbknq8uQT5dOgvPP7i9qEsqeOh446FPiwEcZJVUcDNaySFYbAiQfy7vQ/P+0P5Y4QO+jlhtL+GL/8ZJnzpBM2R/+i3ULUMISoHcWS3IaxN+4Mckbw+8Mi6A2x0S7UAHYREyAxhouiI7ngIbsNc4eAZtL3I14sGhWO9JuoUYsk3BIflZNDUpiCG8CW6YMLj6oQAh3/s2fgfHHnV/3BzIykzilt1a/1Yh8TdenHOV5ffeDarPE2Zw6lZ1+/xAAs+/TYploaiAi01n6VqiTI7QRFTcxf90PZ9pTpBKU/xWfehvm8V44actBsDoackt7P0A1wH50pQnwUtRDwcI4x3T/ew5zOTwqRFEfOVMhHxRQ+M9yxhJebOoPdquzk6tz4+ERUBKyo2wrV0S1WNw1JnrSVwXmHbwJ6P3byXr08G3yDe5PEKoDHeWAgR8n5mlzhpdAbagL3sNViqdz6rz6xbTNMGplbmj+etc+HGAauKM=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4A7Ox3my80JhvLhLgIXhCexaYoBAhwS8iD8/tENKLKyJa9PmshgrcbIvFsl5YVVPFGzVci79Ygdmg9trPc929NyNXEdB1Jr8r+5coX1bZRh52Wvm27xZHD/YRQB7ppphR0lXRMTypQB3u4t1NeR759euPvWyjh9KmU0jTZfPI95r6iugU6+741y2TVb1dX0PR3Vn5Gi2F6Rh/9k+B1aGAjeiSNZXFSFxLEwxWpMQ9szzOYD0rr3iYM1pQX6q1C24b9N+y7An5lzsNZ/m2312yutyfIv3CnNem+FasVvnSrw55tNQ+xERTRg7HYRPoprE5NQONAw2QOyC5n5COTmwtFgL/+MWZuViOE4pSUPe7Jre+l85YD5MYIqD+b9o2Xmtg/85JozBOAjv/aN279i3VxuC2LXGocV61YqZJTbkB9rY+t9CBuqLluDtzCVtMNcO
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:37:52.2875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca369ba-6685-4932-f2f2-08deb2d2999f
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB11630
X-Rspamd-Queue-Id: 824FE558FD8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288478-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ericsson.com:email,ericsson.com:mid,ericsson.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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
index a2c09bbdde17..7caf3d45177d 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -347,26 +347,20 @@ int mv88e6352_g2_cache_global_scratch_config3(struct mv88e6xxx_chip *chip)
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


