Return-Path: <netdev+bounces-298048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WmvaEDaFKmqfrgMAu9opvQ
	(envelope-from <netdev+bounces-298048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:51:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB367095C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:51:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ti.com header.s=selector1 header.b="IvxR/5Zc";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298048-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298048-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ti.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18FBE307A1CC
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F1A3C7692;
	Thu, 11 Jun 2026 09:50:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C43C7E15;
	Thu, 11 Jun 2026 09:50:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171451; cv=fail; b=YdCZQ/9p1YOwgTvRZ/DWbMUL+mAsVdWIxDCp+2MQ/fZ32WSwc3yyqWX4lysy5ozLfBFMtV3vd8uHzjvQn1Wn9dBp5xRohcoaPtezfAH7qg2235gWwLVzU9CwIeSpQ1rUtMq566xvYc9XVc6laRcJMyGbnpEKpXK/vwpgZGyhwkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171451; c=relaxed/simple;
	bh=q23tTpcbts98h9vrxq9s5YNEjm0zJ2RrGi0MO1moz14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcJfkNtuKbn3Aclslx+r0H7lAsKphdPNbuhhx3oi/OLftm4uQLyNP9ckBrMufCOeFxKo9vPcwCjK0FxFFAppC+elJuL5cpbUf6FjdpdjJ2QzwHruhRLbHp+Srq4KTAB1HX6DzBWUmVYFnMumj6jczDKfXgRfwU19nUWta9TJejA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IvxR/5Zc; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr0YeN4JlUgdFJrf2w3/aKqypgyH/Xh0qstXQHD/mIxVjNJBg0TirOTW0dROiEwOHin19iJ0REnuzpAfLJbaJ8XSLKeQWB2aSOz6Q0T0DdCup5wzb+dJK3D1a/IJBvCZVcSxFM846+fMU5w8tyBIoh7xxQQJpshvupYEF1dHdQfFLodFj4+n1/dPho7bD1YkG7bOcKjnrZC5HAa9gMpR3hB5XNT8wOOccc8wEJjTQrfB3PjDo1mWW0fgi29eH+L/v6fQ22FC3IgksF3U/u/MDIiwv/1Zf0LuRR2OQGkjJb0zwcjnAwCcHmKXMSCje4tcvefbf8BeZpTh7WA7xwEIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAc1xAuqrqBbaNGTCiUioRckoU10tWBV0WzMjQokYxU=;
 b=NZIKU3mghruES33sQTK9Rh/PBviqK4N3jhbQI5bqKhdwTw12fqVsnRNaDP2eLJMMQDVKr2ivsPpp5ssy6XptpBjL1qj9P9iX1tgJXeAzEZYEOey8EfClzKr4tnt3Id+aD19bT0cu4YwFW7snnO5/rdSHxhxLBNCF3vStKfCdxu+dro0Ni4KLQvmYPqSI380O+unqtqqc8x0twkF5JD7tRk//oDyY2/fn1UYGF1gPckt1VGK12bHNIAbWhoBO4xb9yr9KmTXXRMJkzKZW4UveUKOyKE69Tsz8nmfHKr2bmh4qeKNJOLW37dpIc8kZIZS711GKRsy79AcfBnZFIHznJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAc1xAuqrqBbaNGTCiUioRckoU10tWBV0WzMjQokYxU=;
 b=IvxR/5ZcDxYYJWtVirZehZpeTBtPVq+7mAMTNr/91DoTvb45vMXcIqmQN4GtDiKYIOauBX1XYEH5l2hpo/at4ZVrwmBOAEPcLwY5WiJKyqQx7Z9TR6+BU6f6Khw2lT6O0ijNNo5br2GEXXmcs+N3CHOET0J9IqoPMvs5agCAJZ8=
Received: from BN9PR03CA0987.namprd03.prod.outlook.com (2603:10b6:408:109::32)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 09:50:45 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:109:cafe::17) by BN9PR03CA0987.outlook.office365.com
 (2603:10b6:408:109::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 09:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 09:50:44 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:50:44 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 04:50:44 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 04:50:44 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65B9oir9091847;
	Thu, 11 Jun 2026 04:50:44 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65B9ogTL014470;
	Thu, 11 Jun 2026 04:50:43 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, MD Danish Anwar
	<danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Meghana Malladi <m-malladi@ti.com>, Jacob Keller
	<jacob.e.keller@intel.com>, David Carlier <devnexen@gmail.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, Kevin Hao <haokexin@gmail.com>,
	"Markus Elfring" <elfring@users.sourceforge.net>, Hangbin Liu
	<liuhangbin@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>, Jan
 Vaclav <jvaclav@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v4 2/3] net: ti: icssg: Add static_assert to guard stat array counts
Date: Thu, 11 Jun 2026 15:20:34 +0530
Message-ID: <20260611095035.852370-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611095035.852370-1-danishanwar@ti.com>
References: <20260611095035.852370-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d075ca-1a8e-43f7-b11a-08dec79ee861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|921020|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2OLlC1Fj+bFbLIrPdqQd314tDPCKhaW1KQkm2VwYeqHu89hQAxKVUkJFFNbXSAxmSb6do0w86KMvF4pUZ92DiYBKVPf/qnGgoRNXQAT4oh1cSaI9cQxENDlmdaKhMoGnrv4ZBNyIHeMNhQOJTuI8OXUikafQPQhYD5vN1BAyGKD9OwErWw8DuoWF43887Ww1/VLGzXlDwUhSycYNY1/zNXlotXsPi9I62JXPXY1sadnA6kugPQX6RHbSbt3lsdOcgvvWdKpGkJ7HRv8dd2wZcsnQE63GKd7R34OiLsnTvODrcv1iMkrMRL0eg5aRPN7vuStoBCnd/zAy91XB6ZvlYKqoxr3VgNGWOfh3c9c/lsNQhqaGfA+dwBO5d7UdDJ59XJfn1hnrEKQbWZm7sVENCHy6M58uSZFBzqC8rncO4vKzwWC1dvJipMW8tx08T03Sojz3hRxSRhIiYLK5xzIozC8ijsjtpj4nHwasWGHrqTwH9SVjBXLa1MgN2qpX2RGVUegVlo8fcboTbIUsN5V/CzyQm1/5ZL5dcs4vD9jxejDCu/U6e0aaLXo2GsvK6Bo6JLnfI2CAXNdZAwg4yVz5IkGPaQuSiBe73Xtfi73Yf0UhHn1bxc8CbRsYGH8CKBaIs7ZE6p7JaPaHl5T/X7HcJ+FoaEyG9fWRcSQz9AyeFr3irwhfWv8o0xbj/9tsDgaXXLYYscUyXoxoQu+tOJcDOFeRAEDy52bgjOaJ7mq/oDpzwni8UZr7UXG4GzC3twpaY2Jyg18+jjYDTvVQp0avJw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(921020)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6Imi1F9GrBG8amyXBkC8lStWxBMyvCZGLXt2TX7WJLrh8nuP3QITBeus8uqi6TbtjPoqujdkjgJPWby9Ldu64y9YTsQMNANkblWkrhns/LUXONb2CCaAjrPmsWmkTsr5QsSgs36+XrwFNkVQZeUeEeFc7GRwoU7LMEueJI0gjBRl2lHwCDvOTBrGqskfHisuh4Ys1zQ1q2KEklyvhwoeKC4d5nB0ISk5rd7XOQw2jKMXq365r8/OssIJ8IbHQIeUZ8ADJhccaA3BR+THOSCi34eULsEe4zngD5V8Mm+b4U/+wg+ocMzpLKqsR+GER4f1z8FDxRYVC8u04RQtArtivP9olod3HWo939QEx5c5/2T/smV7meFQguvX8T4pFwXMBmmZ5dUVUl7UNKTTnUF00tGdQ4sr+0h7SwEkpeauQ5LM8iSEuIfF0c02JlZM7M5Y
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:50:44.9429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d075ca-1a8e-43f7-b11a-08dec79ee861
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:danishanwar@ti.com,m:rogerq@kernel.org,m:andrew+netdev@lunn.ch,m:m-malladi@ti.com,m:jacob.e.keller@intel.com,m:devnexen@gmail.com,m:vadim.fedorenko@linux.dev,m:haokexin@gmail.com,m:elfring@users.sourceforge.net,m:liuhangbin@gmail.com,m:fmancera@suse.de,m:jvaclav@redhat.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,ti.com,lunn.ch,intel.com,gmail.com,linux.dev,users.sourceforge.net,suse.de];
	FORGED_SENDER(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ti.com:dkim,ti.com:email,ti.com:mid,ti.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298048-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7EB367095C

Place static_assert() immediately after each of icssg_all_miig_stats[]
and icssg_all_pa_stats[] in icssg_stats.h to verify at build time that
ICSSG_NUM_MIIG_STATS and ICSSG_NUM_PA_STATS stay in sync with the
actual array sizes. This turns a silent miscount into a build error
should either the constant or the array be updated independently.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_stats.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67d..6f4400d8a0f61 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -155,6 +155,8 @@ static const struct icssg_miig_stats icssg_all_miig_stats[] = {
 	ICSSG_MIIG_STATS(tx_bytes, true),
 };
 
+static_assert(ARRAY_SIZE(icssg_all_miig_stats) == ICSSG_NUM_MIIG_STATS);
+
 #define ICSSG_PA_STATS(field)	\
 {				\
 	#field,			\
@@ -201,4 +203,6 @@ static const struct icssg_pa_stats icssg_all_pa_stats[] = {
 	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
 };
 
+static_assert(ARRAY_SIZE(icssg_all_pa_stats) == ICSSG_NUM_PA_STATS);
+
 #endif /* __NET_TI_ICSSG_STATS_H */
-- 
2.34.1


