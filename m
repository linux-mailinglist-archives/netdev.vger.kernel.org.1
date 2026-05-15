Return-Path: <netdev+bounces-288479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCtwBFWhB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:42:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 686C6558FD1
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4CEF3053EAA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946403F5BE0;
	Fri, 15 May 2026 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="opOwKifD"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3DC1DED5C;
	Fri, 15 May 2026 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884682; cv=fail; b=YNZgK0aso+FVg9pxTt4odqK9qZ7nnMDl8SZkfMhlkTGu25jRVnz6AOLPTGr02e9+kX4YCuEF5bzQHBuKM/2uNafUN+fGX+Yh8kLWNpmWrdHATT6oeE5Ugi+7eP94eTDbj9+Oa19Cz/3ngjZ5DMI03zgTMUB/O7D4ATbCAcMmXjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884682; c=relaxed/simple;
	bh=f+NdB16pjGQT5gPgsHKAOsBChoSP6NXsmfVcSiXjnYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ss+NS2mdwEGzKds80aLHA1mPMGTECQRM6yVt6Wjdi797cE9SM5IFxmroSBuu2qxDj8LmzJ/exIjzWftcnxxInVdAmlHXjAJjKX6J1dZrlQlMbody38te9Sq7Fu0qIMiN31wsgEAe4urFPb/AAXrGsLrgI2dIg2p3HODfyjRTJI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=opOwKifD; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVfpLtqIsGsuH2o4RqgT9RztZtWWvXmPuPOWApnJy0b5kvz6C5OIQb+/eTC6oihFlosplUgLxpJQnOkaebfcbi4Cmou3WOqV7JkFsazHH2GE5BhhEFy5hCPKMewzUgfMnly44W9zLfSzUDUF4MQMhl1jGEMiYguPZyUBl+F25Jnw7XmIOKjH+0Kdh3Z4rORiqf8ZPHr3TS9foQ8pcIYbZ9hPNJc3P19aYWLTduy3xOjLx5FQKVrBLVe0fkitaFjAk4qkx8L9I3Ht6c+nFU/UgAUpf76c4entXK6zH4bls7y8GioEtLnxS2Y4RX9A5DBXMm9wbalDBzlI4AY2fBplMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgY191dv/rk2IYksD2Emet8ob0K7o0cnwsh3l5pvQiU=;
 b=KtkURXk6D+MANUxAJprQYfqTyN4TrbS95xAOnXY9xVF3xpuHprlbSh18XLirKVW1aZG/Q5wg/yHJkyB1ld/hyfvGNgLgmi+KNt+aG5Crxt/qVj4t4P6iMxVJljJ/BUcHPcdGxCZzfjy5O2SJMIV3Ttnut002LeVdi0e3TMoowXYeNPQchSFTz7SfbgcmPN/e8tTndtRPYccbwnOCRT8Ir1yqVlPYhF2EdOI3girveEwHJk5toFgjmMyQKB0MVknVOIqkYJKl03/Wurt7Sr1dP47pxbPkNBNAE5+gWnPh7O7DOdDKKJi29se659E6EXXZ8kZI0V/Pkxtkxt3kND5r5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgY191dv/rk2IYksD2Emet8ob0K7o0cnwsh3l5pvQiU=;
 b=opOwKifDoh1Q4aDx1Zhbry+FUex2goocU0dc1xgKvM5/g28NY1davTBr+wepRx4+uVNfIUkPKFI4onOm3sE33IWknmY3XxVEzsKLlqxT+wzgTckS9NwxYMxHLabpOxEaGZOkjAIexi2wFCnB4P8WbfXtYG5uRkvGKxfGvsNBrC+LfWg3VaXMp3+EG+5bcSVHdGJmmZe46R/tkslivmBpt8CInFWq1zgzruMzK+m438GTfTJT7tAEjQbNOel2EaEJebjTFf35hBDTsYVroZXNDtLAQCHWURZrUDYOUTPpOyr8QQ1FBnvn2bR59e5+NZ41VTu/WJRtLJAeW6WP09TPLg==
Received: from CWLP123CA0169.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19b::11)
 by PA1PR07MB11426.eurprd07.prod.outlook.com (2603:10a6:102:555::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Fri, 15 May
 2026 22:37:54 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:400:19b:cafe::84) by CWLP123CA0169.outlook.office365.com
 (2603:10a6:400:19b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.21 via Frontend Transport; Fri, 15
 May 2026 22:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 22:37:53 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 16 May 2026 00:37:52 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 2BECE4020840;
	Sat, 16 May 2026 00:37:52 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id 18A631005D6A; Sat, 16 May 2026 00:37:52 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next 4/4] mv88e6xxx: Remove locks for 6352's has_serdes
Date: Sat, 16 May 2026 00:37:07 +0200
Message-ID: <20260515223707.1026325-5-fidan.aliyeva.ext@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|PA1PR07MB11426:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf53ec6-d9aa-4725-5e2f-08deb2d29a3d
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|4143699003|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2kPoqZqofwzwzCaKhp/YXBFe4NdORgAJ4mcNA7fnJ25OCc/JOmtrXFgHLVz1y5TmBTeNmo9q2D2kaJFKOejYY/Dpd2ZxNERskSJUG5iNZP21kueExNszz1gn+R56WHtGUaN6JQorgYF0NTqSmSRV6/IqIad3UAbSTIYzWc/+bxL04+D4k8joAIhAtBJXmgdEg9hlYrqeAAWGsP9JoJPLxMjElJIuCvSFMl7SmqJX1wUhxCi65yGmWcjp8DIvZ1hyDvpKy+uGlk56/Soy58bKjNL3FXgnIWa1FQIxmZyHE3dHYqfSZjr2uK700umnkf0Y+BdWL0wi+WyYcMraOo3rL0T8NKPuI+xsImSvBoziowzxmHrkXxypF7KyJwNkpQ2LhHAsXuTTdxrth74PDt6B3TJfRvQOWX/2wenvlW+QcxNP/h8vDVGd6DtT/i/GXildua5tP9xx4Tw3uvT1a81VAMmMX0Zt5BjgvBXqyOE6dgTL1hfZAIh4SXQKcqy/OHb40drW4j4FJ50hJKi/bZgBooNTulVQm3Al3x1htWSIyOKfU9UKO7H31DjcJ8DooYXphbfow7gcNfBdySu8vH9iDO7JqDH5q2LZYpD2uFtMgblHTn6427mImnMRa70dna6hEc8P6CXoZUYW7evR/wtjwaZ5wZkHPI6AUfyb/536w8SmPshLwiVfVLJ3PdTG8mSwQ+mQlS8Hr8h1sS6MbnPwoHkmWNF/vnTCAn0Bs2X3/BM=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(4143699003)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rfv7achK8quOfDrDbSjzbltnZ2Araac+AWDAsvGVeK5NxGtzBtaFRIu0FAm7ef3XsC4QKf5dU/SLBFpdU6NUkH4WGUQJYB0JeEOGF7mi4h8KTLke7ydtR6XNJ/2uih3hIqE58+YZILRedo3+e95ku6DenqMyGHsv2aL+5iNE3SRuRf/PtQ2Qp12sdNuwFVNppvlbDqKg/4/hhHdtqF3ysll17rcf14BwpsKN1Y7oglXAIddTbOLXCrYBMcKE5rQHZz7Y1Jqr1FXYv7GIokpXrXZtUNJiz97AqTT8MD023dtM1mZqxiBCJX6tWpvMCqFZlBbqihBGz6SVbkCRdu1BYHIXrWDP514IOp8AnbWuBeuY2Z5sx185dKgTq8bqLv+ptZdwlllxbhJ6OzUl1mVRMJSpHCDvN++o4AxDtszZB194tfeMiBvrWanI+d0XRuPW
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 22:37:53.3176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf53ec6-d9aa-4725-5e2f-08deb2d29a3d
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB11426
X-Rspamd-Queue-Id: 686C6558FD1
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288479-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

There is no register access anymore in
mv88e6352_g2_scratch_port_has_serdes. So, remove the locks
surrounding the function.

Co-developed-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Thomas Eckerman <thomas.eckerman.ext@ericsson.com>
Signed-off-by: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
---
 drivers/net/dsa/mv88e6xxx/pcs-6352.c | 2 --
 drivers/net/dsa/mv88e6xxx/serdes.c   | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-6352.c b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
index 9ebf0f89f817..308655d72d52 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-6352.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-6352.c
@@ -326,9 +326,7 @@ static int mv88e6352_pcs_init(struct mv88e6xxx_chip *chip, int port)
 	unsigned int irq;
 	int err;

-	mv88e6xxx_reg_lock(chip);
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	mv88e6xxx_reg_unlock(chip);
 	if (err <= 0)
 		return err;

diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index a936ee80ce00..d3d3c121a32d 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -202,9 +202,7 @@ int mv88e6352_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port)
 {
 	int err;

-	mv88e6xxx_reg_lock(chip);
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
-	mv88e6xxx_reg_unlock(chip);
 	if (err <= 0)
 		return err;

--
2.36.0


