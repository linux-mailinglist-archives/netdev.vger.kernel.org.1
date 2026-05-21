Return-Path: <netdev+bounces-290608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGEcIW9rD2qOLAYAu9opvQ
	(envelope-from <netdev+bounces-290608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:30:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8FB5ABC6E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13C0830185A3
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737E840757A;
	Thu, 21 May 2026 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="A/Lmh3E2"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1E7408000;
	Thu, 21 May 2026 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395399; cv=fail; b=pAmofupEoTe27KFYLBbi5Ng5M7NSWRniGP8FrP7u/aGxTtIng/v1s92X2MrKy9kEf3IPkIA1igDV9IxfSnxEpoNTPLZ3DjLwa3P8/eTGKpNumDaOfhX0kOVjvBXlptiFHbeyMC9Qbs0rrP6QLY8EYQLtcEzgd/scK5b4PEdE2Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395399; c=relaxed/simple;
	bh=f+NdB16pjGQT5gPgsHKAOsBChoSP6NXsmfVcSiXjnYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/XECJb0P4UYGC4iQdFCpZXCfuJF2LGaDiFEWoqxA23M1FLDzAud2edSWyyCV2XaDViliqb79lZfFW5R8ognv/zlaOlQ/4mvmKGHXVeK25U172BbTdjKgBlSkA5x+pRSQWaHo8lFHuFI0vg5tHwckUTU5OyP/OTkWZqQcTiOCts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=A/Lmh3E2; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CakVQcVEItaqmmBn30+3fLY+em7xYD1+pjAyNFSJyxphHRGxpgMqjqGkRkzAvGcdgXUho8jXmfswQkO70GoJq5IjMxiR83kp4ujzTrhLvFy/sPG2gE7USJQI4sTeC7BSWPe897P/ZgYAei2Td4uYm5tk1QKKCAY0ekXghFIfT+XaeppGMDIrOyOhwz9O3SLQQ6koJIPb4BItIY13NhcyCIbNudnpxAgVfGxevpVZkOgwqZDrj0I4mu2GEnDzA23ni4EIQHju3oHZJfOXa3K5IVey7m+kSY3s7Xww0Rg/Dz1Dms3fp83eDaZp2cuGZSmthnkTR94EgMmZOUuKSCD2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgY191dv/rk2IYksD2Emet8ob0K7o0cnwsh3l5pvQiU=;
 b=FCyzthSeLm0h+WR18LhjWkSry+ArbasrWuUzjnfoVRsjNdDswwHB3UBEqGfJV7sE2tXlm916Ly9170miqK3HCgCA/qkQsTXncgrVb4Yny38IHFWzYvts2b7H/j00N3/IS5O4Atwk8/kTspFnzeywiberiv7Fo6Vi0uFWzDaBcOiRtxrxPY4aVicJLviy+Asj+R1qgHXc9Q9fTlo85P9OaRzbKYaYn/GRk7FFmeU57XEC35Ssq4tjsasRsvBkqX5LQtzUzTCc0vrd4OayJRnRSyp6Y5QjZmYA8kiplLQYFgWEdF9WGWDxO07kxT9AH1JjnxKR/lM6l0Z6fCslK0URoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgY191dv/rk2IYksD2Emet8ob0K7o0cnwsh3l5pvQiU=;
 b=A/Lmh3E2zRjNYi0Weqzz6XcqMltaaBWVwazSzl3X3ewdloys5uKX4xPDpdhGymwNQdbnaWpeun0WnTR3aRa71AjJw2Zt8BxOTpTmzxz5GPAcF6CBiVsG6Enp9+eL01XfOTBwIgVOJg+RTlAYdSNclk+T2AsJ5x8/8M/b1FOsgOBmJczif51FvNNXhPTOUDX9TIsLfrYCNLs425qB14yI7+eozSUm1j1Stuws8r5dZ8Zr0tN9KGrMeyaQf6dEsMMkyLASPbMZTNf9GRX452xR7Khwe1o7KkrgeSu9w8v2nLLNf/jhVtEY7jEFqJy1n8WFERGmfEAYYjENjiyyUeYfFw==
Received: from DU2P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::6) by
 AMBPR07MB10761.eurprd07.prod.outlook.com (2603:10a6:20b:6aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 20:29:51 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::56) by DU2P251CA0011.outlook.office365.com
 (2603:10a6:10:230::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 20:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 20:29:49 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 21 May 2026 22:29:48 +0200
Received: from seroius06448.sero.gic.ericsson.se (seroius06448.sero.gic.ericsson.se [10.117.92.228])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id E26184020840;
	Thu, 21 May 2026 22:29:47 +0200 (CEST)
Received: by seroius06448.sero.gic.ericsson.se (Postfix, from userid 7434092)
	id CD8491005D6A; Thu, 21 May 2026 22:29:47 +0200 (CEST)
From: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marek.behun@nic.cz>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<fidan.aliyeva.ext@ericsson.com>, Thomas Eckerman
	<thomas.eckerman.ext@ericsson.com>
Subject: [PATCH net-next v2 4/4] mv88e6xxx: Remove locks for 6352's has_serdes
Date: Thu, 21 May 2026 22:29:24 +0200
Message-ID: <20260521202924.727929-5-fidan.aliyeva.ext@ericsson.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|AMBPR07MB10761:EE_
X-MS-Office365-Filtering-Correlation-Id: 3567d085-edde-4862-d2dd-08deb777b4e8
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	qhkGyZLtYb6M/H6l5NzAKRKhJPZV6M5R2Tbfoy+9XVwJzhy2jMBoWgfMcygp+mEDWlZjSawHN1a2dnXV9dHdNiYFpDIxr3zf4zN6yi439+d7eMrZEbRC0y5bIIEICbJJfjqZd0myME1VMhEV+r2j6qa54PWnzEq03dCqU9ACbFTlvkC9/77I0Zs7J4YA9Xqtj+6OOxPDChyUGbXPMZY5Pk4U68wHAE9TOYk/sfeerFXJBiYZrlQung7ZIGg4KvZugR1Kem+5h+2JLAHmJ2tScwy2kAZkbZN5WLaolw2dwddnThB0Kq8t8W4DtYRuiS241jmqHOvU7fmA76uM+5Pd//KxjpHFpwpOS9Ag8ASrzObDpIEoqkAuGqVGN6aVM/AZokBK3Zj8fhLAoV4yDl9XF75RpCowrB+TAqJK3VF2wnW6vpQu88gPQrRU+LWOm/Ix+WL5Jr6CzFb/M169sBLzOSnI7lt7/aGRsz1SlY7m2thf+B2BpFaBbLtXFEP3ZI5u/TUJh3MYvW6fF+5Xa+FKrbAH7wOKdOZJjloufdzXdSi+EC23CApDgUdYHAuG648Xn68GnS50Jc8YtwwTPdUvmmNBM9geKV/aMG3q6hb00DRyPV5cHdC94cV1zydDIz6V4W92qxfK5Ii977kWG18QBbSr5JN+7virUFj4GYxipW2TN0DNRjmn0RDTjiSTw66B3Gbw0OLBTmelO/7udhY9/RXOiE4zFeBTPNuazXZhcKM=
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YnE5u8/vPDCmJzEtGN5AkVeY6/MDwcM62X4Gs4tbZ3Mv7243+2TYs4FuzgsHvNSQ7Bb7F2K3Ewa6ldC0k2zE+K/1n4AgkPn7BGVDAhh0ooNW7ZVgHsLUhkzEpNIW767sbrPMngRyx91OTZyME2PJjlOKiTSnOIlhqC8eGApo4UVngvx1HLWkjWC1YURw965UUKaSX8bjewN2cahKVsYIMr6wUNwZXjdTdeVBA4oOpu6hczVmf/5I3/jZH3mWwt7ko+qMZq7frS3s6RH4kB1w6L9qMYr7MFXHzEXokzElXGR2nY/0jOqZQZab64Vv8B7av8yfP+vEPfokqlMnadRagFup5pshJRFmRTjadF2u6tGggjXQDq4GphNobEG7wnQEufiL/UVQniCPAc7SC8dFLLQ7n3B8Td910+lwEUA6oioFXmft+ZHkK9U0lN9ypG/E
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 20:29:49.5827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3567d085-edde-4862-d2dd-08deb777b4e8
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB10761
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290608-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nic.cz];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ericsson.com:email,ericsson.com:mid,ericsson.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 3A8FB5ABC6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


