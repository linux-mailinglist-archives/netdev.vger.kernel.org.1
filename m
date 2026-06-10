Return-Path: <netdev+bounces-297719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6oxiE5V/KWrYXwMAu9opvQ
	(envelope-from <netdev+bounces-297719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:15:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921B866A9B2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:15:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=dazfvZ0H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297719-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297719-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56E3930A6E13
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5C1426D03;
	Wed, 10 Jun 2026 15:09:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DD423A88;
	Wed, 10 Jun 2026 15:09:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104185; cv=fail; b=AstnIQmtp6fpulmDO6vM07bVKjB3g3sprkacOAuEZZ/U3wPH36ATkc0YI/8GeVd/b8ZWsSfPUB5YoISTlyIEVgrZm0j44rZdF7GjeLupY2T8zAoTSeiQboKc6eWADHf8lL6XxOx3hlQwmxIMvNJZUvSeNqtlvMjMVEgaqeOmtL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104185; c=relaxed/simple;
	bh=YN9gCbmR466q4/54Ou2uoVg2T2L7c4NlhBehKe5DQSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LetRq9mQjZ1OorWrf3I4tgR9Guv/UGgOq8lkfeJxKwz7h1tdcV42nTNZPGIk7KkU8TdjnBZ5OIaRnYckepRJw3mkOFHfsFamDwCMtKmuAJPoYfxEtON95dX/mbb2DUEH72jIXaP1bwMpFlfWla2DHGbfSzxALIRW25ra/+uTEWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dazfvZ0H; arc=fail smtp.client-ip=52.101.72.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvATK3jKvePorQVziEGDrq3VFfQMl4EDl1jklbPbFXUNImWUee1ZFI6TfDtonVpTJUlQNt8iM8DFqUEIgQwaS9MtQwtnIpcdK3WohJ+ZNNvxV7WuZBR9NZNV4Y6l8RMeZ0yFjbknLw/DjicKtcYF2GSVk2QfAcKWDJZK4aGFa16nVXrasJNw+1rs7DyWt6XqmSrTnIBCH4Ml3123lKUHKsLOIo7gWat+WXum/OnW/ZKZjtcQMs0L00o5ImvoKg6EyjlD2SAGAGM+jByrWrWgb92Xv/m05/gO4UI+kZisltazIKK4TPLMyzUxaKyBS2UYcaR/Y/yYw/V8ySPBRCOWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJnEsORoGOYbNVZO5XiRWXCyF7qQ1Sw4cDquk0VLcWU=;
 b=bHAWhmmHTuumbFn+ZHNOqXgmBYv7QBURD6cJk148SNYLsSuR839gJVnZ/TTIpn1aWN3kSI3saE/qnQk6netAduVS7rJFnHSdekivkJfazjIap+SZFZzQBgZ3sSU0w/Kv+arBLYx5PoWkG215vKBtiCh5+q6HjipW/v19pSiwtgJ52QAQrqTYTRYp+33PdbGZImnE+4+TiDoW8ifJTpd7/H01+phm4DwyAM00PWertw7CO4+Sy3w6kXaxOv1GzDbDIYSpK8dNckHyU2BASQzbnTDarYEUGwBgS6o6s88TmZLTG48q+AsFWAtTrRwuEkiNDBruXnmCKBu46XjCE1MRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJnEsORoGOYbNVZO5XiRWXCyF7qQ1Sw4cDquk0VLcWU=;
 b=dazfvZ0HR+1mv92+vwpLjwdv/AHlVQlhnwrnH4b0R/ogSIgYINPfwM3JsHgFMuwNnKv6IVNdAy+WIP373rOE8xMIXq0Q2Bb1kk118f5TVi5GNoKki1golHkp3+rj/NH1gEGxUfVm90HXJZZVFnBLnMKugWB7xTm6xtdGy0CMhzsmcS77PzD6mV4JufbSbReWehyJzxpBAL78LwCPYwSr3ELID4qFaDgUchCe3yD6vDgEa63vhTuncY2sNBPoLIA60FbkSOgl8j3FQLV9sVV4HG7ugc4XRE1OJloyy4aAx4d8wzFMl38bV4iz1yjwRKSMJqS8kZifAZ+aqeix2GEKXQ==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DB9PR04MB8268.eurprd04.prod.outlook.com
 (2603:10a6:10:240::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.16; Wed, 10 Jun
 2026 15:09:35 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:09:35 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/5] dpaa2-switch: change dpaa2_switch_port_set_fdb() function prototype
Date: Wed, 10 Jun 2026 18:09:08 +0300
Message-Id: <20260610150912.1788482-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
References: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To GVXPR04MB12290.eurprd04.prod.outlook.com (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DB9PR04MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b00da0d-3b5b-49d7-2c6f-08dec702487f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wwCBJDKKABW5qZZXKrZUtDsbWGlvqTkqqkFB+0ujEcOorQdfhcIam8J6FeZXBCAakv4d6aCabymrh38jceXHqNteWeNielxggVwRtxMASOLhojfCDK8tTDUcTZ7tmMCd74AqGCiyB/lGarqCRtKXAkAI5KziR2vZ8HDXNcxND50J7/lVOwLfd6zGpNYacVcX3hGk+6K7IxbEl25DXb7Mgjt7wA0iHbk8PONIu9fEr/0256ixbrA0bFtASdTwi8ZrTe37+oSbphO2uS8Be+QRahGkq7t+r0sALOeE+l89DboSk4GFS9A57gq/flGawt85uqYuBQFGluBaqRNeBHDLsWp5HOHR5fFU3gSmC9u+anZcorRtWS5Cvm/fMmHZJy9Yn8utgvEMtaj0e0pIU6w++sF7x99mx1eZmnu1GEJV8rlRNUScweyI7V1tm8shsCLByZ9QVgpI71NMv94dpGo/lZRU3UR9SfJTinmzx7meoq1cXLu3XCGo/MNNasoUeRXMIXMO99uZBUz2b20aoDoIep9QgJsOWTQonL/ja1waMGYXFKIS/FhRLlhM2AGsHIKiaaL02PMBya+ArZgRiM7MU1FidDRy13WMDFXP/CZR1zw6aY20WeNUgSKZNB0eu5I+ZoFEO24tTWyBUubZaaHMtUSjax0nOZgJasorpi6igUTGlMy2fSsFyvdpfws8LoAk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Z1LwE9cZAMsEYoevn5FIbt3S3/qVZ/W7+FRTHDLivv2/IhqyB9u1KIZ/FE3?=
 =?us-ascii?Q?YyIY05MILFS7gHk77CYd2sqSwEw1oXyqhzUgv6/2ybvqDO41rywAx9rNZw1s?=
 =?us-ascii?Q?sASOFYWY6SFJvpakq4VAYOxL7qxOfYNDs4e2eECA6GsxHEWf6hpRaKvLAdfV?=
 =?us-ascii?Q?xnURYllO0K545TZwkIpsrUiSzoqBlto5RFxDfyqj63RINC1fZNIprnqGNTmg?=
 =?us-ascii?Q?153IegANntfnbLysWHzbj4rx5qCTG+oc9bwpC/act578UsjzfP79/H6GREfS?=
 =?us-ascii?Q?0lYydYXN72n9ECe4OVJbXD6Gkg0Dn2s8uo04VwSxpScXfhyn41Sc+xDY75mu?=
 =?us-ascii?Q?NX8e1sqTsQD5wt2u8Ni9nE0bvQYuMfHDq7l1xwBMC0w6kg45BxRnWjzYao75?=
 =?us-ascii?Q?V0gbA96v1PVa3uJy0xlh3TJ8p16B/wO0voXBqfp9WzlSmsxbSKfPY/aWPNXD?=
 =?us-ascii?Q?KL04dUShqfzxfscjsE3M8Wi0R6sl0fB313oumTJmRuU7kx7CDDxE1qY4Bgvb?=
 =?us-ascii?Q?PaLMKawMz40sGqLl3lMqnR793KYoblzxCLhLn6pa9x/GDo1a7KEGz/evqcrc?=
 =?us-ascii?Q?8wJIw4I5Ft21gl9ylodoXjxhi7H4sg6LDdSv+NotRA8JXyVTtDPnSrn28Va8?=
 =?us-ascii?Q?aUCXUODDgIKcoj2le5qOz31knWzMul85fq8ydxiUcXzlmlF2eQ3mSluYl+En?=
 =?us-ascii?Q?/i7fhqK2K7usFsvVEO78ar7ysfhwNwa0K19w0r0QbXhR324Qt2DqWAcs0Ogq?=
 =?us-ascii?Q?vYyEt4l36VPkjAyceyJdqCFIeNyEFxiG0hEKRHuq8S2evD5ssgCXKUdbQ2vI?=
 =?us-ascii?Q?UT1G93L/xJ9pvZaslr08rXvSSBZZmnJSnUTZXYrIjlsF+xc/KmJ0FDzN89+3?=
 =?us-ascii?Q?JoOlPsT5i4MQiSyPGK4eHIZAnCB6sjOk4w3PuCoogDCAyTqzEYLi1vlIp3Pa?=
 =?us-ascii?Q?Btdq7Vs1Cys6QpkqGVrXbbe9vjbA3te53MZBv2vy+1XTjiRoiSlutj8/ib3i?=
 =?us-ascii?Q?gdfCUeVxGyjfNGicGesTKG8p60l7GD1ktzOqRoaeldRmbXD48VWsDAsIzcNE?=
 =?us-ascii?Q?d/I01Wuq9SxzBOKaaFQ0obCkBjVOrg59y8PYWcCdKhHl8zM9AdMZJh9t0j7G?=
 =?us-ascii?Q?C/w30Nqi8dFo6r3ucSV36XCglLdyXxIPWUB3WHFzkS1PddTLBlV/AGsa+mb6?=
 =?us-ascii?Q?bUR/8ZMB86iOAyYOpSPZZXTA68WHyNtOZ9cfMA0r10Uydv/3HAGD1FieWCa2?=
 =?us-ascii?Q?KVeaZ3uC1x1jwQRThQXlP/BPFah0P0pmQ/ljPU6jJpRwbTLNpJQ7jGxv5Owj?=
 =?us-ascii?Q?5u/zP2wmrxkbykAXGrRHOL7mUN7nhgQLMwzebWJIQ4cGonZaRi7qD5pByCEf?=
 =?us-ascii?Q?dXbcDXFSyfeENJtLi6m8DxSpiGaui+X+P81hTFC/5Bju9TLnrHpyRi3G+5TA?=
 =?us-ascii?Q?z9nDlYD79XE0mvXtNdpj8XcH+f1+VL0TTwGk3Zc1hFnEp78hXLEGYJ7Ax2o9?=
 =?us-ascii?Q?vBaAgNS9Sb2V5Za4r2MRb2HB9QDcqmL2yXbGqVjD2xYBF8IMN8bWUW6G0MY7?=
 =?us-ascii?Q?eBd+OjTnXnqfYGpVvSXrc/QHZqREHybUTTG3NQw4mRycrXN0/DehCDmdwMyV?=
 =?us-ascii?Q?Rr6Ci4ftzMgM2lUcPmVCBfS/Y24DPhY6Eugv9I0UTXc152oR8iStxuQF00q1?=
 =?us-ascii?Q?oYQ6tZVwwwm71DJlN0yodZ12miHjIZI/QjDothsyeIsquZSltEiHWtWNfxGD?=
 =?us-ascii?Q?ddp78bHQIg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b00da0d-3b5b-49d7-2c6f-08dec702487f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:09:35.4658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0xIOz7mWAmPQbw8pB8PWlNRwU94bXwzm3Oqjs47rjXE1u3VOD9wlohF44hv0Xw/DV6jBHAxxEnr5aX6iVrbxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8268
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297719-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 921B866A9B2

Since there dpaa2_switch_port_set_fdb() never fails and its return value
was never checked, change its prototype to return void.

Also, instead of determining if the DPAA2 port is joining or leaving an
upper based on the value of the 'bridge_dev' parameter, add the
'linking' parameter to explicitly specify the action.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 29 +++++++++----------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a0bf5b50aae5..6ac747b4264c 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -51,8 +51,9 @@ dpaa2_switch_filter_block_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
-static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
-				     struct net_device *bridge_dev)
+static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
+				      struct net_device *upper_dev,
+				      bool linking)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct ethsw_port_priv *other_port_priv = NULL;
@@ -62,10 +63,8 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	struct list_head *iter;
 	int i;
 
-	/* If we leave a bridge (bridge_dev is NULL), find an unused
-	 * FDB and use that.
-	 */
-	if (!bridge_dev) {
+	/* If we leave a bridge, find an unused FDB and use that. */
+	if (!linking) {
 		/* First verify if this is the last port to leave this bridge */
 		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 			if (!ethsw->ports[i] || ethsw->ports[i] == port_priv)
@@ -79,7 +78,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 		/* If this is the last user of the FDB, just keep using it. */
 		if (last_fdb_user) {
 			port_priv->fdb->bridge_dev = NULL;
-			return 0;
+			return;
 		}
 
 		/* Since we are not the last port which leaves a bridge,
@@ -90,12 +89,12 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 		 */
 		fdb = dpaa2_switch_fdb_get_unused(port_priv->ethsw_data);
 		if (WARN_ON(!fdb))
-			return 0;
+			return;
 
 		port_priv->fdb = fdb;
 		port_priv->fdb->in_use = true;
 		port_priv->fdb->bridge_dev = NULL;
-		return 0;
+		return;
 	}
 
 	/* The below call to netdev_for_each_lower_dev() demands the RTNL lock
@@ -107,7 +106,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	/* If part of a bridge, use the FDB of the first dpaa2 switch interface
 	 * to be present in that bridge
 	 */
-	netdev_for_each_lower_dev(bridge_dev, other_dev, iter) {
+	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
 		if (!dpaa2_switch_port_dev_check(other_dev))
 			continue;
 
@@ -133,9 +132,7 @@ static u16 dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	}
 
 	/* Keep track of the new upper bridge device */
-	port_priv->fdb->bridge_dev = bridge_dev;
-
-	return 0;
+	port_priv->fdb->bridge_dev = upper_dev;
 }
 
 static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
@@ -2051,7 +2048,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 	if (err)
 		return err;
 
-	dpaa2_switch_port_set_fdb(port_priv, upper_dev);
+	dpaa2_switch_port_set_fdb(port_priv, upper_dev, true);
 
 	/* Inherit the initial bridge port learning state */
 	learn_ena = br_port_flag_is_set(netdev, BR_LEARNING);
@@ -2077,7 +2074,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 
 err_switchdev_offload:
 err_egress_flood:
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, upper_dev, false);
 	return err;
 }
 
@@ -2124,7 +2121,7 @@ static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
 	if (err)
 		netdev_err(netdev, "Unable to clear RX VLANs from old FDB table, err (%d)\n", err);
 
-	dpaa2_switch_port_set_fdb(port_priv, NULL);
+	dpaa2_switch_port_set_fdb(port_priv, port_priv->fdb->bridge_dev, false);
 
 	/* Restore all RX VLANs into the new FDB table that we just joined */
 	err = vlan_for_each(netdev, dpaa2_switch_port_restore_rxvlan, netdev);
-- 
2.25.1


