Return-Path: <netdev+bounces-276294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kElABFL11Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:27:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C363B78D8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B9243064675
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80DC3644DC;
	Wed,  8 Apr 2026 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kMKrRqw/"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982D364924;
	Wed,  8 Apr 2026 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629476; cv=fail; b=FXoFvA+k7SU1S3cTF0sPcurYrSvpGmp7SsSAIaOpvoNTcd0fwKKyQrmofSRaz17MSvjwIrJHyce9cB4NIdXK0sv5UfCwjUxP45drxti4GeTZb326U2kQYZq/tazEbfkN/S22uNN6+MKd4ibbjZSX+VIBvEHyB/b1B1FkiG3hZAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629476; c=relaxed/simple;
	bh=yMScTWqvf3YtP8lTev0Y1TSMV3ZXtuLfwV6uJVCEo/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9fH8yNZg5APInL4ow6+uZwA7kSLK9mwLlnrPPc96NLS3fL+PRyNHt5hydSkeKi2opz/peFuDQPKpFDFAnUEcwQ9M645yV7S/+01Opbh1TQTQDoGKv39tZyhG/1uurYN8UhAfjEiMYTe+rN6vdpuyyNt5nr12ZKm0SYKiayMnrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kMKrRqw/; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6NTV8LsdGuLzNGKD3mqWt/lYezVLGcztUhiGPkEBjAGzQ0wTLqoovlO1XCVyI/XMOz9FnOlyQmkzTcQk2a6c8ke2uGl12mwQj3+s7tEPtUAb+1vFZyvCwcAGvnVD09zRO89BtB9/882ce/LYakZWJIVfeV011npyFk55as0aiRb6J4zeYREuimkuCSBd9fUUEqjGWWalHCTLpuxlCNHEO8UX9R5wk9FLyO4oSd6Do7NCaM+UaizVIMeVN+NfGtd0uqg86su7PMeg9GJipca9DuiXn17n66nMeEJSUMX2i0iyuDeuWSnZdJnzJ8dUHuOVeafG9U9oSWgUSzgDxNF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkceZbyPN87Fsk8CewAMDdkUoHRm9brz/YMgeTnGObw=;
 b=eVjfNXPNwVkZRZ1IMTGpJgn6Sozmq3pHQoYsw0f7LN8EGEV7NjDZ7bN+Z7KVWPpdvl5tqDae/T2IqLsvlj1/u3zhfBBVjpf1wVbNJWe64DHrJUjBCQ1df2k7EpkInhK651mc/JHupnyEUt9A1+i9FCMXKFzCkEs7mPHWP90jNhnOz/01Y1jZG3oSHd34EHy21JUGcKLTzwdq2N0XHh5s6zRgTUcvPWbaIsxP/QUpoafMlW5Iei47toWo3s0vonQmPE2Aebs/d4Q/vpd7+SsU0JXcw5dK5H+EyGeWrdt6y+5giIMGA0LPD5dXT1ELPKJfahBgILl3nJBfYmLr57Mf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkceZbyPN87Fsk8CewAMDdkUoHRm9brz/YMgeTnGObw=;
 b=kMKrRqw/O8A8Gbk9/7iW922uhkARHOaYtFs+TqbscshkxX3yjdvFSnLM7PW5eAGKvPklFhxiRs3uswqmNXF8/y6myUU0+dnTz8s8LxTAoNhORLg9mQZjZ7gWPJe4u0N5vK8713IkqMLk4MwKxr1oV53HexV1fyAfB3oEeUkEvH4D/h1mty/4M4ElqtIF2tRxDc3h161J1ymwVq1Q7Jxwy46Mbqtlm+XFePeW2ueq976i7flw10nNZN657IwlqwEc6sDudvZZqfvHa6ReZfIUmPVoiczIoDDJK4AdYUldfm/sESJYc4OUzR7ZT966w9WdO7uWeu7yRgZHnDbJ2sAitQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 06:24:31 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 06:24:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 4/5] net: enetc: add unstructured pMAC counters for ENETC v1
Date: Wed,  8 Apr 2026 13:58:48 +0800
Message-Id: <20260408055849.1314033-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408055849.1314033-1-wei.fang@nxp.com>
References: <20260408055849.1314033-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0043.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::6) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 2214ca2b-ec54-47c4-71f4-08de95377e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	g1oajUZygt6TVELUux0NZe7CzCcspeokA/clIl3mK05WHrDpn13vgVYLbw6wrMAEO7D5Zio6J6nCFXflkgxsAiGYwMW1EoZhMYMtbvItv1R5w1Jx3YS0ahiQEBi8OJ9BFxRsNZi1gBScrBCU46Of6xTNT7K2nDMRiSk/U41eXa/WkXRgp/E9dEUKiyx3K4V6EYJ7ofJVUUsJdik7GqhRmNCPloeMyabZNp0J9o5VDjKrXUu6YAWUKzjOUanmVT1cyvzZ1aribmYrLXLcZiHz8tmtfFvJ55y4J4MG0JjF+VpEzR6IaulEADWAQu+J+/1cyGlsOIWiPsus2MN/pTvloWxo29KyCMhXQjSKTlvSVWE/fmYolxbXyVYFOd9VAKM5VvgRNIjBI0xZyC79Z+kTIEWHb3N5/6WFGZvy6IkLumCjwHrdCIdZTOKfkjJoX+Jx8dULg0cDDWpjK0bX0vgUgDe2+d19yUVryOnF5gOyk9xo0pgPe0SBALttdO27dUwD/TvHrfVQzFkz5ZBTmVhzW1NV2vlHOqkvkBn33IO+WYo5DU1JW3rNy3Z3oVjfAOpOaElL9wEHsJYTYFmD/TQwgrrpCwTvtanPhT9ux5h6bLSSiQha3GSHOkdu/9BvBN6Jq/AHS3X053o1OU+0RAqwZhLkLJRRn/3GAH6BkvXXSYjZtzRnRwkjZGWNB52+6K9eC4wnKFq5wvt6CVazHeP7CuYpVvlo1ahzuuId7wRv1xn5aFWsPQIKCcXWV5DO3jdO9CeJ4ox2zwAr9qk1DRhRrzZcpgujWSKqxt7i4wdIZjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cJFncn2TvybyDzggIC7Gr6+uDMSESxXDq0e4AHJ7tyuelg5OKe8I870OMjIW?=
 =?us-ascii?Q?vc7CkWwGvgigeFQuAJiwLaBYNCHwX1i+WMkAwvyvDr6k0SoN+oMEysumozUn?=
 =?us-ascii?Q?sl10KgjzhLyhi5aVIcrEcAX1qp87rOsGWAbfRgsWEDWywUbe7k1wlC6tr5Sz?=
 =?us-ascii?Q?BCtrFmxLNTZO3iYn+wbNlDlNJk3bFIHZGo0hJKvrE7OXLfJPIr1rDdo/2IF7?=
 =?us-ascii?Q?OA6O510JXBo9oURVGbovFCWX+yYy1OFlGC+Uf/P8hOTW3XkClD9zZtLyYiKe?=
 =?us-ascii?Q?kuJcOh+JNKO3pNxM2xH6Lh+KlGB2gjWMrdIaozRIKtku1NPDJEdyvbTZIrU3?=
 =?us-ascii?Q?kvu184CdNSLIeEbfF/9At+9vKuA/KvZK8HJXBiU1safGbKRQUcIN4P0ECME0?=
 =?us-ascii?Q?mPKWMlQHQuiZLeH1VJE+/ChvYCxiSmyeBI9LMW0y/DBwb/Qm1jo3JSA8dKEE?=
 =?us-ascii?Q?/5V2tD+LThsa4pmQC6O9duId3NnTHnvQs8DdpFiXobXI18Bq4SZzArTWJQv7?=
 =?us-ascii?Q?EKdYbnHLscmnHublpeZN0ocnItINh1/cJtm/gAcNq4u44HudhrG0RFFCvdOt?=
 =?us-ascii?Q?5ok2IvwX6Oi3L94Jp3Fxl/kYAzCOasHBE5XaTcAljRyeHG/t7q/zKgck3jum?=
 =?us-ascii?Q?gGKtU2x2tp6F1zNXsQlu4WgQqdX9Uyj1+hvX1ob/HypVTMjzZynf/ZJPcNZB?=
 =?us-ascii?Q?+n+g9VhM6C6tCaNb7fkzJLLcaFbSInwQSrjHQclT4jhpZajLJgC1nwU+2leh?=
 =?us-ascii?Q?7TSrJX0yT7abbMfqBEgAgMIRtX7gLZApXEPerjbxBAYV8PqX9pmeWwF0riEu?=
 =?us-ascii?Q?4WZ+EkG+zGOHqPwdTGuMHwQC7trazuks+nOd3Wbno/ntHhZyftRC1+2BRo6e?=
 =?us-ascii?Q?j2f1wfB2jky3bWvmEdBnYFBlBAW8nTpBhfaA1JNn3IDoD7cXr9yhOUvuZEL4?=
 =?us-ascii?Q?31u4BsmAd2LxLON3Qs0n07A4cbtTG2cF+ajsb4t2E394u8IyZ7WUvou4nTx6?=
 =?us-ascii?Q?cfcUcIQ0jqKSXJjZ9sUyzcZhsK9fkh1kInJqB4CP6JI6w+q6ubGoKhkr29CA?=
 =?us-ascii?Q?mFFGCKS+yQlO8lMluJHQLXrNCGVgZmQOCn80JBh7WqvrvjLkCUkUQenvrSWt?=
 =?us-ascii?Q?YPIebzspvcoaNrOWUNRIrquZQdNoQEZNBSZgBNhIoF+7s93qc2vDM/FbRyCV?=
 =?us-ascii?Q?yDYx1ZTzQE7DNTG52YNwLLM+y/fI2QYOpubMfcMtVJTu5b22Df5oDkk1fT49?=
 =?us-ascii?Q?XOdsuRQayf/qVdwdZAH54hQPsBX0rfkBUajfpQhoKM5p3OJcBJjdvI+HegnB?=
 =?us-ascii?Q?LMLCYI5P/a0jouqGUmRDG2G7SjBhzeSUaaDXZKD49RLe7OHeyijj4gzl90iY?=
 =?us-ascii?Q?/VgbQAjJaX+P6qHFzzF5Bu2u/55xh3nRQ0MCQlxsrV+EI1S++u6JwCJIYljl?=
 =?us-ascii?Q?AU47h/e04qBO5Lwm/7m6OzxSvJV4+Sv4og+lVPQttAX47OctL7r9o1RGE+kz?=
 =?us-ascii?Q?MVGv0TdhVwSpjasjWqI0J38/zIUS/ISz7OsaHfJcoB8dKoC5MVKIDiJAw3cl?=
 =?us-ascii?Q?n7DIfwRwNLnlKjZQgW/FmXHzBtTolUpiIGpuneEKpWWMFMMsbX0dujntSJOl?=
 =?us-ascii?Q?tqZgkr4OeNr7Q8bf20gMYllFDWwyJN5nMLl9iw0UwgeZHuda9VzuKKfvVn/k?=
 =?us-ascii?Q?/JhFr6RGi6/egjwoFf0MKMo7gZ6oM9zos3jj/9h/r7A3r+gFIXEUXPo6ftK7?=
 =?us-ascii?Q?OqN/75GPAw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2214ca2b-ec54-47c4-71f4-08de95377e66
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 06:24:31.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTeZ0PGmcdbn/ZELm1yC0Up1t01h4LDnRzTFlgIRkbQYdgK6cpuhdFKI44EkFuAfYRaMriHWceYc3QZzCt+8BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-276294-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80C363B78D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ENETC v1 has two MACs (eMAC and pMAC) to support preemption. The
existing unstructured counters include the eMAC counters, but not the
pMAC counters. So add pMAC counters to improve statistical coverage.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 77 ++++++++++++++-----
 1 file changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 504def405489..bdc5916e4400 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -129,18 +129,35 @@ static const struct {
 static const struct {
 	int reg;
 	char name[ETH_GSTRING_LEN] __nonstring;
-} enetc_pm_counters[] = {
-	{ ENETC_PM_RVLAN(0),	"MAC rx VLAN frames" },
-	{ ENETC_PM_RERR(0),	"MAC rx frame errors" },
-	{ ENETC_PM_RUCA(0),	"MAC rx unicast frames" },
-	{ ENETC_PM_RDRP(0),	"MAC rx dropped packets" },
-	{ ENETC_PM_RPKT(0),	"MAC rx packets" },
-	{ ENETC_PM_TOCT(0),	"MAC tx octets" },
-	{ ENETC_PM_TFCS(0),	"MAC tx fcs errors" },
-	{ ENETC_PM_TVLAN(0),	"MAC tx VLAN frames" },
-	{ ENETC_PM_TUCA(0),	"MAC tx unicast frames" },
-	{ ENETC_PM_TPKT(0),	"MAC tx packets" },
-	{ ENETC_PM_TUND(0),	"MAC tx undersized packets" },
+} enetc_emac_counters[] = {
+	{ ENETC_PM_RVLAN(0),	"eMAC rx VLAN frames" },
+	{ ENETC_PM_RERR(0),	"eMAC rx frame errors" },
+	{ ENETC_PM_RUCA(0),	"eMAC rx unicast frames" },
+	{ ENETC_PM_RDRP(0),	"eMAC rx dropped packets" },
+	{ ENETC_PM_RPKT(0),	"eMAC rx packets" },
+	{ ENETC_PM_TOCT(0),	"eMAC tx octets" },
+	{ ENETC_PM_TFCS(0),	"eMAC tx fcs errors" },
+	{ ENETC_PM_TVLAN(0),	"eMAC tx VLAN frames" },
+	{ ENETC_PM_TUCA(0),	"eMAC tx unicast frames" },
+	{ ENETC_PM_TPKT(0),	"eMAC tx packets" },
+	{ ENETC_PM_TUND(0),	"eMAC tx undersized packets" },
+};
+
+static const struct {
+	int reg;
+	char name[ETH_GSTRING_LEN] __nonstring;
+} enetc_pmac_counters[] = {
+	{ ENETC_PM_RVLAN(1),	"pMAC rx VLAN frames" },
+	{ ENETC_PM_RERR(1),	"pMAC rx frame errors" },
+	{ ENETC_PM_RUCA(1),	"pMAC rx unicast frames" },
+	{ ENETC_PM_RDRP(1),	"pMAC rx dropped packets" },
+	{ ENETC_PM_RPKT(1),	"pMAC rx packets" },
+	{ ENETC_PM_TOCT(1),	"pMAC tx octets" },
+	{ ENETC_PM_TFCS(1),	"pMAC tx fcs errors" },
+	{ ENETC_PM_TVLAN(1),	"pMAC tx VLAN frames" },
+	{ ENETC_PM_TUCA(1),	"pMAC tx unicast frames" },
+	{ ENETC_PM_TPKT(1),	"pMAC tx packets" },
+	{ ENETC_PM_TUND(1),	"pMAC tx undersized packets" },
 };
 
 static const struct {
@@ -181,6 +198,7 @@ static const char tx_ring_stats[][ETH_GSTRING_LEN] = {
 static int enetc_get_sset_count(struct net_device *ndev, int sset)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
 	int len;
 
 	if (sset != ETH_SS_STATS)
@@ -190,11 +208,14 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
 	      ARRAY_SIZE(tx_ring_stats) * priv->num_tx_rings +
 	      ARRAY_SIZE(rx_ring_stats) * priv->num_rx_rings;
 
-	if (!enetc_si_is_pf(priv->si))
+	if (!enetc_si_is_pf(si))
 		return len;
 
 	len += ARRAY_SIZE(enetc_port_counters);
-	len += ARRAY_SIZE(enetc_pm_counters);
+	len += ARRAY_SIZE(enetc_emac_counters);
+
+	if (si->hw_features & ENETC_SI_F_QBU)
+		len += ARRAY_SIZE(enetc_pmac_counters);
 
 	return len;
 }
@@ -202,6 +223,7 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
 static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
 	int i, j;
 
 	switch (stringset) {
@@ -215,14 +237,20 @@ static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 			for (j = 0; j < ARRAY_SIZE(rx_ring_stats); j++)
 				ethtool_sprintf(&data, rx_ring_stats[j], i);
 
-		if (!enetc_si_is_pf(priv->si))
+		if (!enetc_si_is_pf(si))
 			break;
 
 		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
 			ethtool_cpy(&data, enetc_port_counters[i].name);
 
-		for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
-			ethtool_cpy(&data, enetc_pm_counters[i].name);
+		for (i = 0; i < ARRAY_SIZE(enetc_emac_counters); i++)
+			ethtool_cpy(&data, enetc_emac_counters[i].name);
+
+		if (!(si->hw_features & ENETC_SI_F_QBU))
+			break;
+
+		for (i = 0; i < ARRAY_SIZE(enetc_pmac_counters); i++)
+			ethtool_cpy(&data, enetc_pmac_counters[i].name);
 
 		break;
 	}
@@ -232,7 +260,8 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 				    struct ethtool_stats *stats, u64 *data)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_hw *hw = &priv->si->hw;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
 	int i, o = 0;
 
 	for (i = 0; i < ARRAY_SIZE(enetc_si_counters); i++)
@@ -256,14 +285,20 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 		data[o++] = enetc_rd(hw, ENETC_RBDCR(i));
 	}
 
-	if (!enetc_si_is_pf(priv->si))
+	if (!enetc_si_is_pf(si))
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
 		data[o++] = enetc_port_rd(hw, enetc_port_counters[i].reg);
 
-	for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
-		data[o++] = enetc_port_rd64(hw, enetc_pm_counters[i].reg);
+	for (i = 0; i < ARRAY_SIZE(enetc_emac_counters); i++)
+		data[o++] = enetc_port_rd64(hw, enetc_emac_counters[i].reg);
+
+	if (!(si->hw_features & ENETC_SI_F_QBU))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(enetc_pmac_counters); i++)
+		data[o++] = enetc_port_rd64(hw, enetc_pmac_counters[i].reg);
 }
 
 static void enetc_pause_stats(struct enetc_si *si, int mac,
-- 
2.34.1


