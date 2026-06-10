Return-Path: <netdev+bounces-297722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z1p3KLF/KWrjXwMAu9opvQ
	(envelope-from <netdev+bounces-297722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:16:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057466A9B9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:16:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=mxg9eFRu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297722-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297722-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCEF1313FA1A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B13E120E;
	Wed, 10 Jun 2026 15:09:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E9425CD1;
	Wed, 10 Jun 2026 15:09:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104190; cv=fail; b=RQejTgVBSyPMyA5vx69Clev0c8z2L8/HbcOigGj3ZB8EmVhGyYOqj99DEM+6eDdTzyxHezmJBGqMLQ3/YmPesVbJMwhEgW52CNsmsUEZH8z2ujXCYUa05ioHKcBAHb2sv/CAwH9vtkuqW7xdzHPBCnoXFBz/LJbgeefumNHbMcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104190; c=relaxed/simple;
	bh=m+UmhTKDlEvp6bWTSvIawXy8BEWdqM9xeN/1fhFsJtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gjanKHrZreHma4kWzLiiEFjaZEqUWPov1d+rNyOGxAc+1Q1lEuIwxtomYVp7Irj1oMvAKvWJ8JUqnY85Qw1kwQHqdWa16UAsDyIyXwczLcQgLCzGH1bnycYXRa0ykwY57AIKQGnFhWX8TODSUDsgVlJPGsg8wC7bHOWpbPNLLRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mxg9eFRu; arc=fail smtp.client-ip=52.101.72.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phk9omYBbwhntolvroByHAw+3EijyGplH3K6czNc1oir8CE4uBxTOYHRJho9NCgT3qsBNKLkVWhzLdmbze+Zz50Joyrn13XZ343YbSq7xjwQcAcdwxmvsvG8Mra8JPHh/dOtWHR+HoThPaLWrCF92FqHRWJ/ux1ylz5Y0g0C4V9jiQRQBNVYSGTvKgLjjh5hh1P7V2fD9VH28mxeB3jHyrtAmAERtw2yrSm56pY5vjsJQK/4i2xL3Ek2JHTHO1TDflsSBFDktAf1OJdAKMitFDM/kkyiyB68CEDTCTeNEITTwzpGtaNJ2UPhZznI4I9kAto2b0yNNFzmfxDxQSY3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGBarFCIseVvHeKUCH8JAscD1xliQ7W9sCJjg+otzYA=;
 b=Vz07wKNKLcDX5rbLkBzfzPZgte78ZCOPld3VcwTPTF4iBipkoC312pVYjAvkrARxYdBiIeneyZoSmgXLBhEbAe+lvQzMfigoNVJYxvEHv5/8GocNNklww/3ntOOuOvjKcQrFQndzl7U0j0nFAJ+bf98jgny4UzryLu4rk3tBCI+UE0BkcMLSt3B8ijoQlalEn1HKJUL0r2zUk+Dh1BFqw/4VIcFvdf/+FP6gyCHNGuYL0/LAHlCEQ7dnCX37ZOAtnYXHPQK+e8/MeMZ9Hd9t2Ab9xRXJPkpHTHwMVXu14DnNjTozj81plrum1OHspPcgNqrk3Jlou1N7TdMuSO+dWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGBarFCIseVvHeKUCH8JAscD1xliQ7W9sCJjg+otzYA=;
 b=mxg9eFRu9AYTWMad2TQSfN95q5q6e+eebeKCswwlyyVJxaDNqFWeHuQlGMxV/MkN0a8t4wwcS8354zHhcn38qxJHH7saIrpUsY68sJRoUDmqpJ44PeIOvd2gmPKw67x3D8V6wZpVSGHO72QJkGtmTSllRWrsipe1Mj9BRv+yzZm/3nLgV18g1rGbsO5/Mm6fLlbsVLT74pForZblv7GbqGDlXMWXpDQIviUc20uDOPeswiBuRi1myrPJ9L8TdaNZwn8mnmdgfD/Ny89jWSb0c4L3jU3Fk31rFbCqID+znTP3blMh42ZsTaIUDtYCkc9Rbreu2EZSe/uUmARdWMnLmg==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DB9PR04MB8268.eurprd04.prod.outlook.com
 (2603:10a6:10:240::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.16; Wed, 10 Jun
 2026 15:09:38 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:09:37 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] dpaa2-switch: factor out the FDB in-use check into a helper
Date: Wed, 10 Jun 2026 18:09:09 +0300
Message-Id: <20260610150912.1788482-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
References: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To GVXPR04MB12290.eurprd04.prod.outlook.com (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DB9PR04MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: b1322aba-07ce-4048-450e-08dec70249f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	IgZZl2zNhAmBP8AoLI5z+CJOd2stLculDIYs8YNl7BVudTRSZtnyH73Uxn2ZCANe518eALCOOv+N7ztVCpmGwgU6lwyfA0MsWNqaQO2jEHg9XpVWKtdKKpgTO8NAhseVSdywOyWBgLF1f/YMhMfbrk6qmT2J6G18jiGOZcaoGZ9k6l8zAu4Ftbvv7nu4oykDbqfA4bogdOsyM/NcGdN1ewSBhN1tBaNaA565gfHIVHe2ItYu1C7b+BYsbskqAYQh73QWts828GTf3bGGMpN+fk+ssFuWTGClRDaw9xNYNYYSDLDG47mu95pNwigEv3E2HdRANChhCVJUy4nEg1K4/9NDwtz75Lof+9QC74RmMVKw4pS0QrUp8Zvf9TrWG4XlXWINDGr2ZQtY7Z9JHVSMRnvGqajtRYf3ADOZWJNGiN7RcWQePZtOLfGU2UfyZNGJAMxI9daTwVefsynBhOPCsPdVX0CPdLtKs/PBk3S9Bg6HPETeNYPLn/SkhZdcVRQZHDXfgD3gBwloc3PFa8mcH9Is+5ed66tdrpHtCN44lS69BtXgl2Y8CfgAar56/US+FRcLrNDC/+HAjOk5+lmQHERA4hNzjp2b9LKTlmTzrqcuHV91jIuiqNsJtODOA8C63PRC8DyJKTCVf3rOpJphUNiCsKPTC7r8xPzgY9AnleRSCWLtmDsRtLIC1jERb7/n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0Bf9pzP0AnEGGs/bmmbGJp+paAswjvAvW1RY8tN38XkFGIXYYwPxowAT9gv?=
 =?us-ascii?Q?xeUPSQYRFNAV/4ShUfWswm3ixhZuyzf2icgrm7/Aa35Cy4tGUvKNEgUpu74F?=
 =?us-ascii?Q?dGyEF6YGWKPpZ/2JAzh0eQ4dx3rhmQzmAZbFY2AdvO8ah+Vsd7kpQkKiORl6?=
 =?us-ascii?Q?WkpHJbqufiOEacCz5za4VJoz4sGaJWO7PZTBuHY33aLHp+lBA8Uzm0+vHi36?=
 =?us-ascii?Q?K2Hl/LiM5izhQKVhSlMkMqHdeQrM212rWg3TKRkQTe57nf8UhhQ+59PauvY4?=
 =?us-ascii?Q?82oLarfYAnNeOxZ4Q5hgtuZNACHAfssvZNMqPkmQG3u3cQzOAJJXQ8nrtjiz?=
 =?us-ascii?Q?YZkfVMkfQR5vOrsfc2EL+AfQe5U4t6VkYdrjsMx0lsvDLnBSfLcs911dK6kE?=
 =?us-ascii?Q?Jue0bsVMetX3uZMGwaw4Xi4iIVhX6m5yJjZaEGnOpCm4JS8c+j7r6V8xouOf?=
 =?us-ascii?Q?rAncAbV9wXuoXavtQMIMGAKFqDbwvnavTHGxL2+jS3F6SYqjgh/3Sc88H6pG?=
 =?us-ascii?Q?9Tg/1TLpEAPoNTbjYtMebHc3R9uxtmUMo5IFBWm+6AqrJsPj65IG0OfoLmnH?=
 =?us-ascii?Q?mqQfDG5DzraZ3UsnKe16pZXiCY0Hk1w6b0Sg1hBe85hWiZMl9PeTRD1HjUhN?=
 =?us-ascii?Q?2ILGkl2Yub/m/5AOAu0ntCIZzhzm82bjlJ7DE6RoHKE+wUmJcXE8l87Aq6n4?=
 =?us-ascii?Q?rjDpq+aPgbeS529QKmvDpJSBjTvR9fO8IgC8XPlBMT5Dr6KardyVJI/AMNto?=
 =?us-ascii?Q?qc4TF76difY0UBVucJ03Q1qcPzFZmGQCN3z644QS0P7nNTr09zkpfVha/8jb?=
 =?us-ascii?Q?EoC0A2h+88D/1cFXiPKlthyX1nUvccUEsJpZJjPh2eBjUCT+o9KyxkNAsikV?=
 =?us-ascii?Q?tqe03UJjvWh5SWZMQ0hsQaVXN5/4vLhiVkVkM12EAWoxcCA4eFQTMZbMCfiQ?=
 =?us-ascii?Q?wq1TME0cQItdCNjPJ5fqtphwTbce2qGAGAqo0q5gRZCJkKaWKEXhSfzp8JIo?=
 =?us-ascii?Q?JzCCxY23sCuO1/ZdEx2yDCtc6w6y7WGgGBy2CtimPcIKhTn04X9LScWoMW+w?=
 =?us-ascii?Q?8we3MYGDa9uuXCNGUOYn74MBcRfy5wRQUR85jbemQVHc7fp5t0T1Tc1kw/qc?=
 =?us-ascii?Q?oAJ64+MPuxl7AA0InLisqQEZFvxvYz0mfsmOD+swXbA70/adQ8FQUaOpfEsH?=
 =?us-ascii?Q?z3QZixy5AOhAEIFAl3/mssPupUi1/0hysTVbT5WPtlOl9CL2NEJUZd5QbQbb?=
 =?us-ascii?Q?BGfeHD8S6RXUDZyjJdVKv+1hAXQXkrEN96iB8l4uqFq5QT4X8mVZDezKQSh6?=
 =?us-ascii?Q?o0N1OjdSLCcnKIkOLq+7yfkyfQwA4ykoYf8p2BZD1Y9rxv1Mg48rYsrjfGxQ?=
 =?us-ascii?Q?VQrionmODzVwkQord+kqNQNpkLnMhQ5fgV7RpkS7gXQA8yqneI6KfFmG++Yj?=
 =?us-ascii?Q?SNu/bnDzMtJJehYGhbk789enEYSbIpggckanLJGb0FCIpnHNk71Hp08IFWx5?=
 =?us-ascii?Q?g4enwc8JzYjzBGuBiETfX6+NW+dRop14eYR0AD9KntD1Xum2abVhZHkpY1IK?=
 =?us-ascii?Q?HGAYMR09Uiv0fmmZBSM/T5Y+rJyk1qCw5r9dVRT76etGV48VXAFULa/564hi?=
 =?us-ascii?Q?aagJEHSPZKA26QHwwiMLg0569rsTxvPc1h+2W0EO3LGN/sU/0o69llSIdyCr?=
 =?us-ascii?Q?PFdGIa417hdutODH+tRMWhY3SmmpczyZWL+DwOuqCwK4dpckwhScclLYUNlf?=
 =?us-ascii?Q?MlFO9TmVFg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1322aba-07ce-4048-450e-08dec70249f1
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:09:37.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqIrlLxy4Or9FvYIrZu23dzO0S3SwpljOdrMGq1Km60ltS9bv20RslEy3T3oU8F1cqWQZVUCQ/PSNkJj0S5bug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8268
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297722-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0057466A9B9

The dpaa2_switch_port_set_fdb() function is hard to follow and
open-coding the in-use check into it makes it even harder to read.
Factor out that code block into a new helper -
dpaa2_switch_fdb_in_use_by_others().

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 31 +++++++++++--------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 6ac747b4264c..3052a1c63c2d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -51,6 +51,22 @@ dpaa2_switch_filter_block_get_unused(struct ethsw_core *ethsw)
 	return NULL;
 }
 
+static bool dpaa2_switch_fdb_in_use_by_others(struct ethsw_core *ethsw,
+					      struct dpaa2_switch_fdb *fdb,
+					      struct ethsw_port_priv *except)
+{
+	int i;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		if (!ethsw->ports[i] || ethsw->ports[i] == except)
+			continue;
+		if (ethsw->ports[i]->fdb == fdb)
+			return true;
+	}
+
+	return false;
+}
+
 static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				      struct net_device *upper_dev,
 				      bool linking)
@@ -59,24 +75,13 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 	struct ethsw_port_priv *other_port_priv = NULL;
 	struct dpaa2_switch_fdb *fdb;
 	struct net_device *other_dev;
-	bool last_fdb_user = true;
 	struct list_head *iter;
-	int i;
 
 	/* If we leave a bridge, find an unused FDB and use that. */
 	if (!linking) {
-		/* First verify if this is the last port to leave this bridge */
-		for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
-			if (!ethsw->ports[i] || ethsw->ports[i] == port_priv)
-				continue;
-			if (ethsw->ports[i]->fdb == port_priv->fdb) {
-				last_fdb_user = false;
-				break;
-			}
-		}
-
 		/* If this is the last user of the FDB, just keep using it. */
-		if (last_fdb_user) {
+		if (!dpaa2_switch_fdb_in_use_by_others(ethsw, port_priv->fdb,
+						       port_priv)) {
 			port_priv->fdb->bridge_dev = NULL;
 			return;
 		}
-- 
2.25.1


