Return-Path: <netdev+bounces-269522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJo3AGUhvGnQswIAu9opvQ
	(envelope-from <netdev+bounces-269522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:16:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C30A2CE954
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195FF31F6866
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06D93E929B;
	Thu, 19 Mar 2026 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xh/rPwNg"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D83E3D86;
	Thu, 19 Mar 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936263; cv=fail; b=lWqnSuEjv/3V/ynr45TKRGxu+Qx33ArMxCdBU1dd68euyP52aWYxbOS2lrd8KDchQHDFx66ZNeHTGCdmQpH4ZH/oDfKEO5XVEHswL3rY5xK4qaH8THrh14m01cs4ULP5ktON5YcGT1xI+8G9ihmD5FR/2RNu23PiqeAE8qUCRL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936263; c=relaxed/simple;
	bh=9uLu0RGKc1rOujloirBU2FePYsRg6l0u7Db5mnLnDsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cY/hHVELeufpZWEsEFLyY2y6pZZIPRRPfz5wpwbPfG6iWpAw8RJeV6ZijFpw9fWRUF4qJDg3XNRgP/OE2zypZufRPYHQVyDZMcx7UaivfqXkfB/TZZPAhrOzE7fGsTDIewpBe/VWEGD7WplDLuZizjaeZyX1cQwXiSCvipAE4Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xh/rPwNg; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8C2kjQcel37pC+ny4eIW5hzdR+OkH1lcx1RdjNhbZTlYY15bkJ5/7qL7FSFQcIjSx7pTbVIAxKV7SIh0wSYOLYF95vDtHE5WQPdP949AdNXbJ37k+UcZSl/yCwz6BQyv2hBzPkhtAuYzikl0LPO3P13pYmrT8+iXXAhhdMq7TowpHTd3x2nkoahMrNe2aTleQvEBpPo4UynLvpnyGZj9ULa5BOed7vIaZ9WVoTHrpqWNbgdVare/p/8Xl4VttMa9rkj2sFh3YvI/GCgt65TO0RSztrJqzoXWQYq1EYaAlBPmx3Ev8F5Mez/p6U4l/y8qpAVU7PBOchQhmn0S/9QXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUJEJ3HZy5sK1yyEW0dEFrsS9PCtkAVaKHw9vYStkYU=;
 b=Xl4nDByQxVjlDg7F8Q38PXshv4Y4vVys/84J7jpJhMdegbXT+mbqDAn0FdhPfk0zPzZIqfcMqZXZO3T3DygPLWMJpGydjGkq7SG7Gl5o0SKQqpF28j1Ve+OHdYBnadtQuN+srSCgzfknZMiDt5qCDtSqSDzodx3qkwa+iUtMEwU67JMW4/pgRZnA+0ylnHWsNiO3RFSaZeol1ZQMMy6fBX4XU/iAINHvDm0doHz80mMQa8KL9jZxLDKVSpMRsYUJ0hKToSXyGiQVQ7jXmg7GvMKNZlyUz5/Gu94wv1L7NF6CJ7Gafz6r8Cjmng7LkTDWE+fDzdOl2ABw8cdkQelAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUJEJ3HZy5sK1yyEW0dEFrsS9PCtkAVaKHw9vYStkYU=;
 b=Xh/rPwNga8gFAa27U8ca3tdxDMqmw4qetFnKsuyQnacU5/vQuFCXVr5hQ7mecuIzuaiUNj2NGqc0hucQngnfoOts95cA/SI2TmSECeRJDR2AHy3vDxaV/1s2130ZdPhXgVXOUBoSLjXATuu6z+1prvxf1IXQVsvyzTWA2KR9/LzWYThzrEZ3/LfnFF9ep4XHlp4Dnfpinh8HppNtiXyM5wwMQEIsUViPOPhUiDdpZNmxsfRsVN9nIV8lV4esHSSjf6syZpKHav1lLK7bPGQdyIugfK7dw2VsoX4wlAmUErdkDw8RgU6xXdNNXTctcYGOX7M9VgCn/cRHUekVVpLAuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by AM9PR04MB7505.eurprd04.prod.outlook.com (2603:10a6:20b:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:04:13 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 16:04:19 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	petrm@nvidia.com,
	willemb@google.com
Subject: [PATCH net-next v3 1/9] selftests: forwarding: extend ethtool_std_stats_get with pause statistics
Date: Thu, 19 Mar 2026 18:04:02 +0200
Message-Id: <20260319160410.2515105-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|AM9PR04MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: edac44c0-4b4a-4c32-b9bc-08de85d12d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bkIkj+lyRJmgIRQSWaQ3F0pis+CQaGbAMvnAsVElHVuWM97p1scFkerYtkjq4lGO1J+iUeApxs0KkdFe56OZ2sSLHBvGRk2uYd0GSUlSrRKz0O96A27ioQnlgGXw9PG2pETgtRFNH1iokD9NleAQxUaLItMxQC/P4JdpsMjB/MKZw07+iqs+8FP9vt9a/oltLTLvgc7m1lEaL1J17UbRVWQH43MIuD34Z1b6ntknT5tEQJ1kc+I/zD9oYivWoZFoiLvhrtuKdDXVpEhrGiZKVtcph34a9fErGw5wCXVVPxydrRSOG/ysmBWVxkrHKvUK4T2g6Od2mJXK1NsDZvMhbUrjaHFoloxiEAszCWIB4rc9GvKfr2XJZe1AVboZpNedCnwmM0rQcsoFOcR7iayaasbvhKC67UGhfixD3w3MRwgLN/iD+SCmcX1jHX6KM6lrxZtCNvFiqsDFyW7wZVkWBwtJJsYnEtV5gOdAMnGveytktUl/17Sm/o0zUtiFM6eVwH5zU6Yc9sLlpl8J4BTFZXWHgfaLBZ8lpRe7/IBEszy6hSd2eNhINP1Es2ca6vlrExEVjzXrdkQHrjx5iJb65TBglj+J4izEFW2pDdr5dd7DO+4DAKXcBngy42z+SSb2I5NC6a/Nmj6CkuhWpE0nZx2gZ/nIpocR0gy2PDr1K9c3g7IqB1CK6h9dZ6v/3erCWjJXUAhjKyMPM0JR7KD71KCb6FENEjt+8SwYC9Utlao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khl+edEhceo7s26lCbDu34qtKA3QrVAQUXhRcJ+dDQPVt2Kpu43bQx2mOuPr?=
 =?us-ascii?Q?zbh/XbxZneCBx0pZfRb5w64DVwTXV7MJ8FSgl0i1iOzrUaRjamuRxkbKrUZT?=
 =?us-ascii?Q?Nxpq12ONshAlooGwK8YiQW7PZRV8JPmvafcVuL0fBgoDkzDl+Mja8iFsjupf?=
 =?us-ascii?Q?1ZWi/dkPzWCVd3CEaJcRnCTzY1M/tpzFOS8rR6jWGd/07TFKf1vYQ2wEJ1yw?=
 =?us-ascii?Q?Ef3iHHj6iNVn9SUHKgqKGpNHTw6gmYULPCCUlURK8ZFo2QNDyKYWA36b4isV?=
 =?us-ascii?Q?221dZbZOULWnwDv1JX4njgnVU3Gn4DCl/ubQNGWvnLz5o8Y7+QvUlnW0gEN0?=
 =?us-ascii?Q?ti3WzrAKtOFOEaxsma7rdKsqmkuMzDJJLZd71cta1/KDARK8K8wwPzyIWz9v?=
 =?us-ascii?Q?sMEhhCqXQ6GYFi5i1HOrrm5StC+I1xNjE911TnbwZqU2Ck8h2W22I0gw50lL?=
 =?us-ascii?Q?ON6/78z5geR3vQFd4QCcldwhBLWncJqFLxNGYHt9djzDtvtsaHA4tbu+E9XO?=
 =?us-ascii?Q?mM+PtTgm6DNiIcLw3OXxEnB14mGmNr/xCv47VZ0D0K2Tr7ORkz9xmejKBHrK?=
 =?us-ascii?Q?geRw+hfqEp4i+iX52ZZEWv6eth4aLLW5Hk62JUe+iG6ykKn/pvlD46Uuo+ye?=
 =?us-ascii?Q?96dy/f8ZBTl93RD8vUJuuJdKNAHjFjNrw2er/Ai3eJLDPb2D9PaRKMv/oCb7?=
 =?us-ascii?Q?SXQlSE/Y06j1UqgXqOrED+ErzAD+HYl2Zl7f2HExpnkVvV82iUAs4Zz5+KK9?=
 =?us-ascii?Q?ledr+yMJOwX5hxE1TcuIQPg/rnJxnkA6BIjgSvl353JBGBYtMvV6g1sogDl6?=
 =?us-ascii?Q?SGgJLXVmd00+lqguhwsrKm2n2SKc317gLFcmGoIFCSwV8C+QUt9pocyiqIEa?=
 =?us-ascii?Q?d9htJow7lAJLEHQGgJxY8TOeEXrzD35+ZLPaPavFR1YBXwupGznnaIfNMhu8?=
 =?us-ascii?Q?czWbGu8sRlLGZpAnPvblf3comtZHPb5GE33NZV9oM3VAiAJqNY8WUhduU4f0?=
 =?us-ascii?Q?MIw+2S0Vm+mUNWrMLdXZNo5YaUleiQsuoYf6cZj1Oi9LTWDYTcnU3zFlbcfM?=
 =?us-ascii?Q?oUtORbvjT9NeMhYFCcFNGsoexfmfPJt444EpE6tGlZG5LP3UjFqREhgZqcSp?=
 =?us-ascii?Q?p+xZZoTfz9im3HYkXMbdkBb9ZaBYA6yaRt9FgtR32R6dtLEaA+iBl89QB1Gl?=
 =?us-ascii?Q?Isf+tdgiIi1YpDDRLiaBcTUwn1GElXYRxOP1FasdQw1PdDfoYDVGmm3a2UMl?=
 =?us-ascii?Q?68fMftd8dQWVYxfqlwA2fR7NgyjVI4CVy0HNsD/UNfeFWxaP/VkFdMasL0De?=
 =?us-ascii?Q?rJKBEnBs8HkLUKxRtq1nqYFJ3kFXMEpEKvZRV/FKnri3g9ciTIRDVkI2zHRW?=
 =?us-ascii?Q?/+7KUgxwASEOtzcoHjZgToRKsFI5iDCWZifsshTNNMJveDod6tcMN5wqHHDN?=
 =?us-ascii?Q?vxw8Gxl4o+9BuXlSXGvbviHyFOuku7lAk8+lGY+3AT+XSeIcBQ/MkFNFNXAd?=
 =?us-ascii?Q?gcFZKq2bDQvkvq0NpqdB/5thcMMuBjp4Pgc7KRvm6+wT5/ufaEuC1fEh0YZw?=
 =?us-ascii?Q?2QgRUVwMWArK02/3FE7z6HsR7j9mlrf4puN+u4GEZ9Z3otXPjAzMC2dPt8xf?=
 =?us-ascii?Q?cWCxmuu0cjolAEjOQuMtjn9Uea0u7U++eRpNqsIeLQvfkfledJixl1L84Oy8?=
 =?us-ascii?Q?llbaeeiU6kAeAvu/UItdeLMfYnz7QhAhv6yY1l5uGqqzCDjMc9/W+kQ9D6pq?=
 =?us-ascii?Q?n010JpOFVg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edac44c0-4b4a-4c32-b9bc-08de85d12d86
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:04:19.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/Tkr6c14FzwFWvr+GJ79a19S21z9y8Rw6j2WbnuCtKL2RSpeCjGsFjxsLnnKo7BxsSE5YJcxYxw+F8+W8PuoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7505
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269522-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.974];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C30A2CE954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Even though pause frame statistics are not exported through the same
ethtool command, there is no point in adding another helper just for
them. Extent the ethtool_std_stats_get() function so that we are able to
interrogate using the same helper all the standard statistics.

And since we are touching the else case, convert that as well to the jq
--arg form in order to be easier to read.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- convert jq to the --arg usage form

 tools/testing/selftests/net/forwarding/lib.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index a9034f0bb58b..cf40cb766c68 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -831,8 +831,12 @@ ethtool_std_stats_get()
 	local name=$1; shift
 	local src=$1; shift
 
-	ethtool --json -S $dev --groups $grp -- --src $src | \
-		jq '.[]."'"$grp"'"."'$name'"'
+	if [[ "$grp" == "pause" ]]; then
+		ethtool -I --json -a "$dev" | jq --arg name "$name" '.[].statistics[$name]'
+	else
+		ethtool --json -S "$dev" --groups "$grp" -- --src "$src" | \
+			jq --arg grp "$grp" --arg name "$name" '.[][$grp][$name]'
+	fi
 }
 
 qdisc_stats_get()
-- 
2.25.1


