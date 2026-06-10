Return-Path: <netdev+bounces-297723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H3JnOx2AKWoRYAMAu9opvQ
	(envelope-from <netdev+bounces-297723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6E66AA04
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=KWp+voqR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297723-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297723-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FA133150C78
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A864266B1;
	Wed, 10 Jun 2026 15:09:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB7426EB8;
	Wed, 10 Jun 2026 15:09:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104193; cv=fail; b=MnoHjN/fl1MUWtm3YdjONafJ3DCgF30fnvPlkgCOROUEEqlEmE4mqW6SNVKP+O3pwiERla1z/kSYx5bDg5v4koo+/1SjtCXy1hyI1bk4r+TCAhIgNm0BbjOGKStvi1AyEDwW4atXSlI6Kzhsb3KTAupmdo+Z+SsCPLQNdUIsoAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104193; c=relaxed/simple;
	bh=lqFu7RoqSyrXmUS3vT/caXfB6zPdFw5WiLPg3nOQpSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q58PKioUN+cuUMW4nJCW8AEz2PIACX9HdIuXYuycgRhj3IAHTmsZFtjC0yedOf+hRFSjEQQN05xwNqWjeZ2P+Lr8poUq+Z6Wz9Gg3ciI5A3VLHv8AHkM4gEQjMJGeiBNI0nTA+PWNtDIWX6iZoY0bWdPEeiPDG5TXLVJbZ6Ka7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KWp+voqR; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/nx5PqFj9r2IhPNPxSAnACV5niNHz2KeOpkYlzitreFHlCy2UYSGTrkRHSmIAPhRj90yP/1zFfPImDotwMLIU4XuyXzXtXBkQlJ+9EtfQI8/8/bttq7zUOT7e/DisizyNCvnd4t46NzLKCPNYm7Y1WMPx/YSjOzWGQhvJBAm248YpeucFxf98gfmdjsOij4xnKz+GnE+GI30yMSxpa5/mwnFLH89Up242V6JcddEQuuu8+ghShe2Fz2tyzeLNx/vTGMX6rVel/kVSsf9m1SLe7+pOBX/toZOVpJlv0v1lldRpQSLSeuA0zJMKiaXfe0noUBHJAMkSU2bfjRk2mifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqA4+29OxShoRXG3K++bZu8YhNHPGnsPRHxD822qU2Y=;
 b=lq6YYbWxPgmubyzDL7i8GpiUPs3tscoR/OAf5IHN40BQndpZpzw9qqfdDENAAofb4cPA7JeaAIGqY1YiLT7uaXrQCkc4gAOhtIRp6Mi7eLsHiTVNCkubwDN4XVbSR/Wblay6uiM3eLVOEz7I28EMn5cxRnmx+eAJF1iZb2ZDsIz8yG5lRotDSkSVGQx2PNcye3VsS2L5jzZ6M8bWbe4WYA66ZQt2R5EnGqtLvbLXHj92iHr5/4F4NPiccTFicmyM1EI1pFYMOdXAY9aB7zGEpuBPY3ddC/gv+0Efkn2xENtkSpWJ1g5A9hhPsnghJAaYqepCSawsJdMA0j9uxQrVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqA4+29OxShoRXG3K++bZu8YhNHPGnsPRHxD822qU2Y=;
 b=KWp+voqRbSCZltq9SxMU2b5NFZFp9C6iinKzgD34ZkMJ58MWgdzRizo0pvmT6c/PhWIu5f21onqm1LYfd0++fUtYoZtHjhvubihf1EkTr9/aXVi8Q04lya1Hdjo90yC6w+hmgxsq/Lac0fe91E3Rt6DcvqfnqRha0ksAQqhoiDIQ/M5IdTJVSR9Rk8g9D/kXSAWU5cjGZunDoYC3R0o2fQEi0DtB/sNIomG3uRft8Vb5fhKlb+7RrffmiKNCeRbhLrUkN+ubFtyvpYAo/p+6a+JkVoLKCwSe9tIwf5WkTEt5+DkirvtpTB7s6wSgutLvkZHFWOmt7sg06scGgSn1Ug==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PAWPR04MB9815.eurprd04.prod.outlook.com
 (2603:10a6:102:381::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 15:09:45 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 15:09:45 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] dpaa2-switch: unify the FDB update logic in dpaa2_switch_port_set_fdb()
Date: Wed, 10 Jun 2026 18:09:12 +0300
Message-Id: <20260610150912.1788482-6-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
References: <20260610150912.1788482-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To GVXPR04MB12290.eurprd04.prod.outlook.com (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 450a7abc-b964-4925-f87a-08dec7024e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4/IHIMSo5ibMc+7q1x2UKZDMkVR8X7m28OIbEkoV4chBU2YoCwssVL4khgN8kCjZZ9e0DOHGjfm8YkHMtvf9SrD4lKIEd0W7/cwIvuvZULiYyM1NxbeuF1S52DoW67wyOWVy9U/IwuyMikC+FTbsKpPGesGaCVZzJUS0q3zSyMrm2yFfiPb+NShyF8hkPFmGbTZ2fK7O7hdR68Kr7NwQSETecrPp+KvuxJMk2/VFQsBerPvfJ8uPIlTnZGcFjaBKlvu6PkpAW31CnNN2CT3WeJIGrpuT/oLPNPVaUrX1mBBP91sqVg0TocFPbPK067ioresnT7jqvd8wqNqPVv9AP+bHWcDFy12G3GMa+sY1fQByXfza/1aOobf83CyMNcnKNyu/WYD84eVY6XmZ7UX5RmJGYFh0x+/u8PPHcX/FA6KLbl0S3nAP9JLPHYVw4YN1zUVXMkPAj+YQ4qeK+gY5I4s6gBqPy9hJL1W9jMcAuZX42AzK3TrXNaZBoq8uHuCAwGi131deekuq9YJOBrGY5eycRUKgkxmEx2Gb0OF+T58XLq/isRpWPefRZZ7z7LlesxOb5FbrTsYIvB417tw2qwbeGXG2phWTRkkXf//PyXl45jKGNEx2Bv6CTbRYiVQyxQAD8qqY5/X48dMkdH3d4dnGbj4lK2uj+4rr6hTfdLbwxPcCMwLD8WYa/qdAqgzs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q34TqWmH3azggJjmab5NZ0TzdLhAuvE/qdOGPe/cGprDuGkSbOsRFtDB7W5u?=
 =?us-ascii?Q?Be1e5EMHPyCheu/aDMs5Om9WHH6xe1NQZ2QPyYOSCmGvtZgTbzLF3n0i8y91?=
 =?us-ascii?Q?EMzcTxFQAzBBhcG3ysh1AbJ3qazVP8qyqL5F6/yZtaBmWRkCdTgSckBC1iaW?=
 =?us-ascii?Q?UcNQXCxjaSl346nHk08wt2AibCiKIGzX0oSAfIFbsAPso2FggrafCpD0iTgD?=
 =?us-ascii?Q?+aieC8M4eVVuhe9v2CdsaFspY27XnuOddkTO4bbYUbqJrh7HB4eBlXmObXvo?=
 =?us-ascii?Q?pu4FibHnF/0fjG0wtysRmxpVP4DhfmHt2ROslxnoKh3FPpjMUJJert+0mfjT?=
 =?us-ascii?Q?tRhzpOtMmlZqsh/VDDeKRnvw/h3NS1oOVfatl3OklNKvR7sMM/H6pzf99LJe?=
 =?us-ascii?Q?OQgRguqbywbPHGwYvOnsEUqhOUVKK6AS0UYltVcpV8So0svXuTSUHHI6qzz4?=
 =?us-ascii?Q?8jK4BrIU7h806EPDG2J1Hoplmq2fEUWaCI6/nc857bNv9zTWnWKylYNf03G5?=
 =?us-ascii?Q?FtzOwH+biS1XZdz3f1kWvm4916kNI+TC8Ull/6SMWZjXpLRI0E69et0T/Xwb?=
 =?us-ascii?Q?UB7lnuKw7osJz1kYZZ4ncQox59AYiiBTaL0M/0RiLXM2QGwDuv0b49vMZFsP?=
 =?us-ascii?Q?D6qhPVEiC14ZX3ecoaWLPZ5UiELr4gssm0mhl/Hz7yab7NejuUNYnnqE7HTK?=
 =?us-ascii?Q?c8KluvcYdnL0v/mLRhURQRRAyS/ffdkK7FsAM8NUWqVBXXOsC3zfpCR0ouxn?=
 =?us-ascii?Q?Nn8BFQIz3MkQGY4MU/91y5TsnH11faMSWW0uMy9mZ3tTfwwTaytOx+QnLHyM?=
 =?us-ascii?Q?dHLwPpru9M/uylLjXmyUwwANffpBf1RLljNEa5x5gx5S7zPVdLBRGTSLn6Mv?=
 =?us-ascii?Q?HNRurCdlkVVtib0jMArXAVguANmsx8x+FB9DGTevmIMcjuJVhjsit3AKuV3m?=
 =?us-ascii?Q?wQfW7Wm/NckILXUDlmF0ib5g9FFljZSekXH7X9GnOm6z8unzWaB+tu92kmAD?=
 =?us-ascii?Q?PPzMhYm1bvhjzPkWMh3J+9rMcltmHFIqYVQ1pfiHQ2DlxKu3Xa55j6nu/AYj?=
 =?us-ascii?Q?Fgkfjc50BbIrVunHAAdmIS3PbYO5sOtzu55Qj5XjTWClwq4EYXCeQR1S5qeC?=
 =?us-ascii?Q?cWPD1Sh198ZCc4R+JjEdnrYK1EKZIT1XkQvuA6NSX5aIziC2meItVK4Ip/vS?=
 =?us-ascii?Q?H6V+5LdMcJjeu/jKwIbIrYvoW3xQZ4hzkTmKtcGlPuEkGH/mDyUzeDIrr/FF?=
 =?us-ascii?Q?zrs6lobJWxX+zpB5qMLij4Ax1TJjILJGBfYCcdEQNGnmUQuglxwlkvtGKog2?=
 =?us-ascii?Q?qwR7qB7FNebioAPySKvTQK7IUbPXUemBLUQKFHeFwdNhJMZt3L6X9U2YMHyt?=
 =?us-ascii?Q?Eq15lmeuCX7/CDJOW8lQr37U3So28tNFbNYQY5wU8IDn+RycDpPWEYDoFYEF?=
 =?us-ascii?Q?IIspH5+y/VbFYeWc42JTVV3Yosnex54bwxXKGFirPoYLF8RUtN32YNplvAtJ?=
 =?us-ascii?Q?n7H/So1IXfq3dzASUydOAsIp8E0cIzt7cetTMNgQH3jBmpVTd/tcra1GsNhb?=
 =?us-ascii?Q?FT8EHRaLwe4SWPrbXKSV0Z02Pc1SbOaago88DdBT0hafhe2Ajib7aReQ1j1F?=
 =?us-ascii?Q?cPGvEy/2KXYGse+VAB7wqP73Wddm7O778nAQYBJzCnsuej+x8Iy0ZPUbBOMq?=
 =?us-ascii?Q?EuPQTWiDUH7zndPVj6xAXPhhI6d+4HI5K9kwHpl6E687w6UqMML8zTAm+t8n?=
 =?us-ascii?Q?giWAylZ2eQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450a7abc-b964-4925-f87a-08dec7024e31
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:09:45.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vha47V8tJfDnmvO3YeX3tHJJelzdsXnPUCL46biDAUJftZq0HooZqRkaj0J0ZLaxlHQEAEiHMUaH7u3Sazue5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297723-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63F6E66AA04

For both the join and leave paths, the logic goes through the following
steps: determines which FDB should be used on a port after the current
changeupper change, populate the private port structures with the new
FDB and, if necessary, make as not used the old FDB.
Instead of having two distinct paths inside the
dpaa2_switch_port_set_fdb() for linking=true and linking=false, unify
them. This will hopefully help in making this function easier to read.

No behavior changes are expected.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 50 +++++++------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 09604c84a614..45f276c2c3ec 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -119,47 +119,35 @@ static void dpaa2_switch_port_set_fdb(struct ethsw_port_priv *port_priv,
 				      struct net_device *upper_dev,
 				      bool linking)
 {
+	struct dpaa2_switch_fdb *old_fdb = port_priv->fdb;
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct dpaa2_switch_fdb *new_fdb;
 
-	/* If we leave a bridge, find an unused FDB and use that. */
-	if (!linking) {
-		/* The number of FDBs is sized to accommodate all switch ports
-		 * as standalone, each with its private FDB, which means that
-		 * dpaa2_switch_fdb_get_unused() must succeed here. WARN if
-		 * not.
-		 */
-		new_fdb = dpaa2_switch_fdb_for_leave(port_priv);
-		if (WARN_ON(!new_fdb))
-			return;
-
-		if (port_priv->fdb != new_fdb) {
-			port_priv->fdb = new_fdb;
-			port_priv->fdb->in_use = true;
-		}
-
-		port_priv->fdb->bridge_dev = NULL;
-
+	new_fdb = linking ? dpaa2_switch_fdb_for_join(port_priv, upper_dev) :
+			    dpaa2_switch_fdb_for_leave(port_priv);
+	/* The number of FDBs is sized to accommodate all switch ports as
+	 * standalone, each with its private FDB, which means that FDB must be
+	 * valid here even on the leave path. WARN if not.
+	 */
+	if (WARN_ON(!new_fdb))
 		return;
-	}
 
-	new_fdb = dpaa2_switch_fdb_for_join(port_priv, upper_dev);
-
-	/* The current port is about to change its FDB to the one used by the
-	 * first port that joined the bridge.
-	 */
-	if (port_priv->fdb != new_fdb) {
-		/* The previous FDB is about to become unused, since the
-		 * interface is no longer standalone.
+	if (old_fdb != new_fdb) {
+		/* The previous FDB is about to become unused, release
+		 * it if we are the last user.
 		 */
-		port_priv->fdb->in_use = false;
-		port_priv->fdb->bridge_dev = NULL;
+		if (!dpaa2_switch_fdb_in_use_by_others(ethsw, port_priv->fdb,
+						       port_priv)) {
+			old_fdb->in_use = false;
+			old_fdb->bridge_dev = NULL;
+		}
 
-		/* Get a reference to the new FDB */
+		new_fdb->in_use = true;
 		port_priv->fdb = new_fdb;
 	}
 
 	/* Keep track of the new upper bridge device */
-	port_priv->fdb->bridge_dev = upper_dev;
+	port_priv->fdb->bridge_dev = linking ? upper_dev : NULL;
 }
 
 static void dpaa2_switch_fdb_get_flood_cfg(struct ethsw_core *ethsw, u16 fdb_id,
-- 
2.25.1


