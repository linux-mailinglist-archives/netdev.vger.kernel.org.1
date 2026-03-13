Return-Path: <netdev+bounces-267358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG06EiTds2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:47:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E86280B99
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A9430CD00B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF0C32ED32;
	Fri, 13 Mar 2026 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rph4XBd4"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5330377030;
	Fri, 13 Mar 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395100; cv=fail; b=BzQo1KZRI240LsGDI5YQkOZqEo0YXKipVxQMEph+c0SuwoewFv86TxA4Gl4msZ5YF6zNjch5hDEbSdTjVjqXGU/GgI82ig5kcUV97PM8AXamQkP4yAGSEqNeTSssWTQG2irG2myeDd3eSrdPTtvRK6KVzwWCb97wcuPKZ8ybaZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395100; c=relaxed/simple;
	bh=zZiUwkJ7MyOhoNcPiuIsJHYq025bM2i2HUqrUy5Uze8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Znnf+aosxnSl+mH7MPvAbimkfLEHOpqb86Pa1JvwWZNrJXPCEH4ZKiC7JLL/LcO7KhnoXc1dCHNG+q3nqOS0Amh+1xKXSJwiibwX7AcHRQm2GR1gGieBGvvEitNGlDCIwlrJeULGCanbCmGJY+cwimjx7jCj40SCK2axlw4YbcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rph4XBd4; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi5f87AAxY0r+8p96vI4vwMtfpLskIrLyWdfdsXHzXZEOWR3pO+IvuqVyOi59tQ6E28J9tHcTzzFhHvLwddVgVJe2J9+LrCJ1nGc85R4lb2qDfDtZzqlMvsYJnTp2pjztzlK0Oq9ci7ix7eb4s51MxlM6y1VMu95Yi0b6GRZBHW3toeEsmiutjcfdPQGpQ3TfT9x72/Lh/Nk2eIxyzqD2FUTRn3EhqoDp3TeoYeefxQlcLfPoEoTNAYZdy3rMW2rkaJAVmwTpmcDSwwBz6glvt6eenP5dpSdeJoKJwFz/q8Da4FpmZTIIBl6KZrvvfrtcbIcmlywelX8L2YmuTeXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grMnSIWjCPcp0cqtXY2grYYuVCQY28G+x7EBaFFvKKo=;
 b=ckyq8qwVqRAIoSx72uUMAlQpBO3cie7DtubuZbuRxNrD7/edd2PfzbjSttkHDIsKEuq2OeRvvI8If1kBgWXpsk8V5/gPFyfBqPcDtIH8AXDlJyzciKcw+IP/bG5EWmqE0s5kx3Q94xY13mOy3J2xjjdbluZ8KgcE5OYtjey8QPN5hGgCB+jbssEZj4RrD2D02WWqnQ6stw8qetpUCsqjCABMfXbInMG3cFz/YBEPVWGboWH1rpLNExjle5CbEi+EffkuFwEP89kfBYx1WknKWN88tR1ZK7xamsLFbIUddQhXt3/xy777lSLa5/8yhj2GK+hREb8lHt2XcBUjv2vpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grMnSIWjCPcp0cqtXY2grYYuVCQY28G+x7EBaFFvKKo=;
 b=Rph4XBd4TBpwbCdYFvD2eH7COiFejT/Zk3oRc4jsyC7NxP7G2aXjGWDTGLCUBioHp6BCYI/cXdZGkBKgyBa6FuOfRh0BZb9ReeHP/E8NuAH8YXu/JwDiphkcmUPnzBmlHVyPJQ9/NuW6CaKu6QjqNwt9QeF18HV8XngEaZ34duSGxuVaGT2U17rvAabgNPFSGGFvm1IOwyDgvGxYn6O2esU1ZnvCdlJwTRwg680PNt2dxF410NVwYJ1pNWEUUPu5R0rgc9czUx4b4tyPF/lIcyocFdUVUytSySsynrlf7Toig8dE+ufTBLIX5vMyEuORDhrm/L2kWmfQ0ELylCIdMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB9100.eurprd04.prod.outlook.com (2603:10a6:10:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Fri, 13 Mar
 2026 09:44:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 09:44:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net 1/3] net: enetc: reset PIR and CIR if they are not equal when initializing TX ring
Date: Fri, 13 Mar 2026 17:46:42 +0800
Message-Id: <20260313094644.1132411-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313094644.1132411-1-wei.fang@nxp.com>
References: <20260313094644.1132411-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: ed551b79-1477-4ccd-9c4b-08de80e52f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	T0kLHjYJiY7M93Id3CeqAJleS46DXnUXYNO6zftAvvwUF6eZGLkcNmwoYrDgUYn2Ln4KHGNRbY86pMuOO6Qhn/DtjPSk1/yGMEr0dZvkEhbp+v+AaYMWJgJRVEmWCfl2LoLwf4Q0ZiMzXKTNzvXC1ZihkGLigg8hMIDZodJAyEMRnP9Mdc3SiwqUcD2EzpIBqfkmI2M4xUntnnc8kqWypN6PBmu/F4qVMabxW5TLMKAonTlxsnZ67l9vNMVImjiR6M7GpCBdH82ONyctHj50aXy+pXlYaGE9gpN0fAyZj5ZBsUoCplCVw4bS+cwmi/8hfXM7JFhSLR94iJJ+TfbEKBGnF9QSrpl3qj14jQVhOrG7riP3velYONmZinV+eRo3qeIp3ekTITKSGv+fVE2j2k65jTpSv1hzL523biO3PeHkwFZlYeBbBV2SRqLFza7AMFpXGUAB45jBQSeaGF4iYlj7/7PL2fa+14reUJKPiU4FMuArhCT9/hA65zaZSS95jMLjhtO4B8cdlSgKlQJZmSKudNS7tGphntoPtqbAJ6qC0jrF6klMk8V/hUmwB9jDH761rjOWveV6nD5Z859NR2HXEETNVgJA3yJ4v63Oop6z07w03O9Sx8OFSIvQjQEzI9SMY4W5RwKxJeZDL2DGHox94gYKtTNQEHKs29N1GtrzvwtcnkFPSeClkjtV3jKHH3EvKRxu4daqBEhA2U8Y1bQdRhrP55dzd4QLwMnw/eomya+CflA4D43xqUKOeWtQ7V9uQgkfhFzTmPDq87BJmG9PIWbIIjjeqxiixWJdmBUpWXUX9sFt1x++GCiPRcb5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtxEbu+sY5n/0QlULo6IjDP0n9xrYf8I3ISIiazYEjFjrnpt95MxjbXjnq9H?=
 =?us-ascii?Q?74T2rO8NnsB2BRkF9qL8OmeVNj5JtUwvYND57LlZV2fNU9yNuD4FqU7vE99D?=
 =?us-ascii?Q?IDvhM86epzB8k9WvGmrFASSvYHa1vCzQ3gYBbtxzbhfYhv57CUA93mNC+Yvk?=
 =?us-ascii?Q?gOfPllSexxJUbX3qyW0Ff9vVkKdErDhmaUTjVMAj/EFm/ITmdsa8DQFtMJv8?=
 =?us-ascii?Q?COkWDfPalejASllBOCBbR5PiCEWBnGl1vKwqcV7vZ8/C78gLj5MaISfL63on?=
 =?us-ascii?Q?0BZ12qKRVZQhvRhSj/Zh0aHbWBE4w7mtXejSY/c9X7a3Cd0NqRQJRHQQyh69?=
 =?us-ascii?Q?wwrOaj2elxpOhm9ngfouIZw1sQGmzCG4eAmZcrc/ikN9UQgYNmnp6dluoh2V?=
 =?us-ascii?Q?XazVpUJJs/yIXVQVkTqevgCCkbbPbCncH1zKBQxrShLbXbkTWcqQR/5MPf7l?=
 =?us-ascii?Q?uGcVIKOmuAOw5orNZufNJCFv7IoXB4rfhT/Vfa+8fpjH0yMQ6elipoOGCOkM?=
 =?us-ascii?Q?GvAl5XjYnQ+DEaQxrmWxvAQaVz6z0Epk9754E5BHtDx2dtGPaDvc7UnPO1SC?=
 =?us-ascii?Q?m9Wscf13syI6O9RLLjP0Fly5p2dNHDwT7FaT89SlZfC3mwL4HaH99+gQZwZx?=
 =?us-ascii?Q?X0Tjs94j8W0RjbwINwbDjv0sJWwtosiiBx8Nx4U07kM8asvin4q3jXGrS/v4?=
 =?us-ascii?Q?YqhFGQx/ZBJgb2T0a4pjgcYNAKjVKjAS5GuspJ2taHPtxuifmVrsQlbex6BQ?=
 =?us-ascii?Q?lhX/qVAUwQdBOTQyYITQuCvqEedvec/sb86BOIBW/9nn6AjNvPnQpij5KQSb?=
 =?us-ascii?Q?5IKwnmkz4Vl6M0Jysap00TJ+eWweJJ2lF8kiwWguWWJLOO/0Ht+GWVe5Vidn?=
 =?us-ascii?Q?T42W5Zr/fyXCxxR4mglQu/H/gPA2RadSSZF/p4Mat2N9A6R5tQ8OEriWXC0g?=
 =?us-ascii?Q?o/evjMr7b1YftWo++adVwCgy6um34tNgOQNMGubRxLh330i0nbmijgxkOPUe?=
 =?us-ascii?Q?zPQb6COO41CKnCfkpOz7YkYkRF7G03Y4SLuHtylShV8nlogqA/SNS/ZCuGay?=
 =?us-ascii?Q?URVh9UqQpJfidEJnVt20IvuCRI2y/ptWzE6GLxEQCzPfl8YRHAuXRrWROoLJ?=
 =?us-ascii?Q?nNd1zr6833VwvqluJP5JlP6jXbZjqu8sHybyu1t6gPlR4Cn5Hgw2FB9w4GZh?=
 =?us-ascii?Q?Rs3GeT8dX7eC/zsUJjMKJ2NpGDCWBQcHZ8AprdVReBItt8WGcHOqwd+O9Cbc?=
 =?us-ascii?Q?J9viD/FsYxS92uIcuu+xSTCb6mmQxmAQmXL+yTcKNSqhLZPPJCxXYKpw4Ieg?=
 =?us-ascii?Q?7Pa/K0bdnKMo3MWCDQ8Voq/7E/LlvzH61DIzgv2F+c2KQfACQDtYUmuIVIMC?=
 =?us-ascii?Q?7LJ052eN2U7lY1nqvxvbn8VnBOUW6DagIVNnWYIltELL/+tjpqH7fy75ka7F?=
 =?us-ascii?Q?BVDD7hvm3veQsTOgTzl4GMV6uS3GvN/S0+lq1EdfqJP+fTTTbAteoT7VtAnL?=
 =?us-ascii?Q?5LL2TdgOlSaUIunwt2ACOxjw9DoS+qdmjjUsvO3V5v+QQqSl8wpqeuNRLV7Q?=
 =?us-ascii?Q?CrbayrweS3lHyjWaTLgHHruFG0iNAkD5k1wMhbPofH/drDr2ryS4A8mQQl3O?=
 =?us-ascii?Q?NF5YW/8TBEfqWsXM73IADBYy/fSqEuNc7L/ssjR5DrHis8UHduA6YUZ7wdx7?=
 =?us-ascii?Q?bmsEf9RK4ES49hUt6NiAZB70/bkaluVEXRXIIdVTcVT1fEPHTZ3hWX7EV2p2?=
 =?us-ascii?Q?Hf63w5OMYQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed551b79-1477-4ccd-9c4b-08de80e52f53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:44:56.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYJVh3lxtgyXmzikc9aijHIt7Tz0Cg+2eRhtuVtNMFrFAySnljTQAH4F+qOJlkcOiiawWVErW5p905Czyb20Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9100
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267358-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: A5E86280B99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the driver does not reset the producer index register (PIR) and
consumer index register (CIR) when initializing a TX BD ring. The driver
only reads the PIR and CIR and initializes the software indexes. If the
TX BD ring is reinitialized when it still contains unsent frames, its PIR
and CIR will not be equal after the reinitialization. However, the BDs
between CIR and PIR have been freed and become invalid and this can lead
to a hardware malfunction, causing the TX BD ring will not work properly.

For ENETC v4, it supports software to set the PIR and CIR, so the driver
can reset these two registers if they are not equal when reinitializing
the TX BD ring. Therefore, add this solution for ENETC v4. Note that this
patch does not work for ENETC v1 because it does not support software to
set the PIR and CIR.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index a146ceaf2ed6..aa8a87124b10 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2578,6 +2578,7 @@ EXPORT_SYMBOL_GPL(enetc_free_si_resources);
 
 static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 {
+	struct enetc_si *si = container_of(hw, struct enetc_si, hw);
 	int idx = tx_ring->index;
 	u32 tbmr;
 
@@ -2591,10 +2592,20 @@ static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr *tx_ring)
 	enetc_txbdr_wr(hw, idx, ENETC_TBLENR,
 		       ENETC_RTBLENR_LEN(tx_ring->bd_count));
 
-	/* clearing PI/CI registers for Tx not supported, adjust sw indexes */
+	/* For ENETC v1, clearing PI/CI registers for Tx not supported,
+	 * adjust sw indexes
+	 */
 	tx_ring->next_to_use = enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
 	tx_ring->next_to_clean = enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
 
+	if (tx_ring->next_to_use != tx_ring->next_to_clean &&
+	    !is_enetc_rev1(si)) {
+		tx_ring->next_to_use = 0;
+		tx_ring->next_to_clean = 0;
+		enetc_txbdr_wr(hw, idx, ENETC_TBPIR, 0);
+		enetc_txbdr_wr(hw, idx, ENETC_TBCIR, 0);
+	}
+
 	/* enable Tx ints by setting pkt thr to 1 */
 	enetc_txbdr_wr(hw, idx, ENETC_TBICR0, ENETC_TBICR0_ICEN | 0x1);
 
-- 
2.34.1


