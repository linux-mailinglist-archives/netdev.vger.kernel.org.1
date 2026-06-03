Return-Path: <netdev+bounces-294785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b5AeL0hEIGoUzgAAu9opvQ
	(envelope-from <netdev+bounces-294785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:12:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15818638FCA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:12:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=f3kBDizN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294785-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294785-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FEC3333FACE
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E33D75A2;
	Wed,  3 Jun 2026 14:37:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3643D647C;
	Wed,  3 Jun 2026 14:36:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497421; cv=fail; b=jINp8qnN/OHCMzRpJ9/0aGtrh3ktw+RH6Js0bXnuTGwdq8iwg9Q4Zv9jO6p6tynUuqf+ZORbSz3YF/Xs/4gyaL6UXHUu+FpI2VT/jRNSIDoLiR0+Lj3hcoFbOWBz56iQIgILalxfWIgTqKcpisCxSFSd+FjuzxmEgge4fDtG1Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497421; c=relaxed/simple;
	bh=rp+/TUGqXE2dr6aC8gz8oprku+qHq9ch5AeB8kXrRYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+r8NkUvKOUfw/fWIs5PMsj7sS0MDc6J4MNYcmaVwJY5LsErKFtN1HuPunNhkC0GLKS+Q0NVDmpvcJcNdoE8Nm5qEJnmqFL9Xv1AAdS70RCiWr1/zyDJ5hE9jVZE3jgjZyeVZHR9V+6VB1PJXwKwOojgTuW0FLHYfv14+MwtZxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f3kBDizN; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYXFSgtriYWANfGweXt8D4bIrBxLtcLHCkAfM0MZP1JI14M9nHykJkaKcyX24jjBgnVZ3vYS1SXpEnfqlR3QsmFSoEQyzuR9Bm0HQ6P7VwhNX6k2O1k0EaGA/g3X1FhiP2R85CAQq+OXBLU5uKPzhtywLEUFIPZbb3ZM5Q1oiPEHxaJ1iy2VEvduWH35CSlnHIkEgn8v821d4V2C5eFJ1yQaH2tYjJ+qJk4iNyD0xxFSaRo1Ww3RuSG9UdNXdYzjtHodQd+DrYj8zfxwM+kdcMsJcDM6wG8QMxHCXxl2197uIHlWvHbF1qMFJhZ9sCbGkHAIRNkoWeV0ktvk2EuZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbWc1uVzjkijeJf88La4hxlE1aSpJy04x65awCLh/uA=;
 b=GIlCFeAZbU1yF6JGTmUravdWF0Axy6anyrRFRtSkGkUnEAuJpLLdi0qy6beRZXpLEgAGzy2g36IQA8ZpUi3GNSmyq2EHaYLpNblMrrOs3tLSVCHM8QXnPlx31r0duh0804F06OXvKRH0QVHIuoleyjpPugMaQMOy+VIhODUNFAJk7spueVUQvkW6Yf+4zUHZXOEv/zRMrVzgIjwyPoUqwGEG5X1CHL+gIgaG4t7ury5yPSTIByta+b46RZy/XcN/9GCOdxoWFBG73WEVJBJ1UAlp5EFuF8DG7kZSHjyDsWRuGWKgHe4mt45DDectNpRIP5eCGL+FRwF0XIOf305YYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbWc1uVzjkijeJf88La4hxlE1aSpJy04x65awCLh/uA=;
 b=f3kBDizNnit3/gXNkXQNAgvhmSGE2kpJ25bJfRFxZbiTAytnE7Mp9rUHEwkRb9Tz9K2CzxoAawc9LLwAJBLH5oEar6vQ0vFWFTy0OXCiB1PqpreLQ3tMyinavl6mWjojHf6cnhKqNrp2KJq9OSRggV6et2gMm9pcikVE57BvB4tk4a21wU89nFUAtW9UiB4vuL/3XhhDgFVfdrJ12y+zevJfNne6Sp1y/0MkkUDUbdARqeRmz5P03CTT4iRt0mclDc4IyVr5U1elC1TYmOIGTvX0TRfLObzslfWqt0WspAWh6CGnm/jMC2430foYePgeDRTPDmv2b02noPblymaPVw==
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10615.eurprd04.prod.outlook.com
 (2603:10a6:800:26a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:36:57 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:36:57 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 08/12] dpaa2-switch: consolidate unicast and multicast management
Date: Wed,  3 Jun 2026 17:36:19 +0300
Message-Id: <20260603143623.3712024-9-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
References: <20260603143623.3712024-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0275b185-c38c-4c79-80bc-08dec17d90c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7Ke0rX+VF533nJnul9cxAh4EaflNA1Leu7GMTw75fKre1Ss5ztvGoY9cyEx02Fi785kphdZ/BHxRYVZxQUwl6aMmVi3LPy/mNAxqh7bQafAIkmvuXWTZb4Hj/lC0I5jsfvgVgdW7Aq1yBYlnRLk1pt7Xd3SlBOmvRQOtZi/5jzIqxx57K5gxSA3bVMyZrYqoqsNj2JPif/hkxhbR0YM06ldXhHb883OnJTkGtg6ueDNqiJ0KBaiSw32neymHxKOdTQirz8Vp/xO5J5qJdy44Y2JnX+/g5iMpi+BuPEQWujjZtkWWJfvATb1ryivNbZHlOKIcDK9By0/j+aGYcLx3SqF53GURjfF279whzJ8+s4Mkg+MsFn5zzvlzUgyg3gFwbq+xhrZaP3DLnZ+Pa2LVXvK8WK973bZs3vJOyPgrdspY7+NxpshNHT+Tlt/7LKP+E+jwNf9ezYVGRIecx36eStWfF5SP8EW43ObfG8tPhyV1vFSY+gJ/IPuaLxmkqtfzJkFCZSuAYsl70oN+BRibScpXuyqistL2QXaJJ9zI7F/vkRv0tEnBUxcRJNG5S4OSAFnsTCxXl6uAXpFN0dfcCA9YIega1E3WgeOqeCQvgbf3GVZsc/oTXfstW6tJ9O53Pwb9ohVK5urRN86FbY67RHuhW3woOVZ8iZ5wOe2XssLi+7FG1CZU4/sohKDY6QKk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O2SbgLL9/8+CsWuuaN5IkFinzrnGv3Ypu2OPADVMPsIFS3OoCwa4sPq4bt/R?=
 =?us-ascii?Q?dM3r6WWS3IH89aKkydNsP2SqWTCRgp1II9uDOcrGU71cYAB1pTBRpI79EyL+?=
 =?us-ascii?Q?4BNa2wQ90Trvff5u3PgNTr4aPYYVVxa5E9/LzHod4u+1umTV6373JuRzttVl?=
 =?us-ascii?Q?j8Bpb6t/CbNmNWQbDgvNbRT3oVNVblU+vQNkA8jpV/1GZ171BnHuqIaYzn0w?=
 =?us-ascii?Q?UOkaD4OknLnvUKM5rDE4hDnL3KCYUOb0OIwdSCDevV7MON4UgVfbtN+1Rzc9?=
 =?us-ascii?Q?lKIbiFjpBaXORwDhET45arBjdxJLDz5BsWot5JIvn3O1v5B2JZZTzj9vUqju?=
 =?us-ascii?Q?Y/QnHpJClFY5ASy6hpiQcjz/72TdxhZMLQ+dalg7GacxSw86526TWZKOItJL?=
 =?us-ascii?Q?d6w8uGkUKxUXBE6LkBnKWRB9nmLR9wCNjWcHrtOkg0ULaOt2yNSbWKmJUAmz?=
 =?us-ascii?Q?AFsXu5dbi6AjGJneJFGyY4dmcY2B81dwWLE3W5qDIzxhcQV9R1LvOYnJEs+g?=
 =?us-ascii?Q?0vbLOG5QV3R9snQmCIdew2UPygtj/gLxM1EEXwuj7IZEiPB22E998mT/vKyI?=
 =?us-ascii?Q?s7J1ng6SId83s3jh9K43etQojGRftvxZOZRHHtuFmUbINwl1POJwF3AXIRDn?=
 =?us-ascii?Q?LVdgMcBo5o3eYv5NiT/5FTh/HsPGpDr90Y/QvnCiweJzAqotyP3hiLeL3nXQ?=
 =?us-ascii?Q?bgv8Ov6Fqfny7Zp8zuRCCoIq8BfMGnpmydkTj4gV8K9b1PgNBCl4GNfhW3VE?=
 =?us-ascii?Q?P/Wj3cSf8YufTkoszwGxN8cOVFtP7gn5bnEEyWLwp03mZwH+A1G6+XGnaKEv?=
 =?us-ascii?Q?Fk5JkaiEuVv3kJ5cDUJhdv2pWbpeTSnGC+QVwIOxDh4gE5GAW81WKqjh6Jsx?=
 =?us-ascii?Q?BQC66cJRqKuiMPYyg0Vx+Nj/uzkewPpPHlMJ51crp65/YE6e5O66WWV5Hmkj?=
 =?us-ascii?Q?iiAiPeEH5bewSwalx9XNTftx2tPbO/k+kg/IdSpKHUm28mms0c40Vgzl5VtT?=
 =?us-ascii?Q?RPNQddgqr0ZAvGy2yU/okFyt3wHLHd+f9TlmDz+Hvctm8wZX/8aLJ8YigLj4?=
 =?us-ascii?Q?epP/7lZv36zZ8UJNJAPrCFJV60VRHhS/Kw+DXoxwd5uklgxMM5QnaN81Ddxd?=
 =?us-ascii?Q?e9ghAsuO75jne1cgmGDFJy26GGA8JPwM1tagbdNItBcZz+k8MKMhORD88rO+?=
 =?us-ascii?Q?Z46AYo4QF3C0cUVnUShLxFoLZr0f8Ro52bthO3aRpcQHf3KgAqqARFDzZu65?=
 =?us-ascii?Q?KGCu4isHHPlebKSFxiYbhCTzvxbZQAgwWcECjMTKaWX6trAVzVb/IBOpAiiF?=
 =?us-ascii?Q?W9tqYDgpzd9DrTcj7zEWwV2Pj6V1k7gr+i430R89Zw23PqsQyVHuBH13v2Jz?=
 =?us-ascii?Q?Xvm6glyDSh4jhGAje/1+P/w/9Te3xZvPKCLrGYNy7tHa6HxsY/veDYcwPWAq?=
 =?us-ascii?Q?wHhflD/ef5askBqxqOCR5a4QX83akLRy1Qeaf3bo5/S43S8O9KfmYOAqR6+h?=
 =?us-ascii?Q?FcT6G+m16s+CjccfVuDr21D6DfYEs7zgf13CDauuk1MW6XA3s8D4IsfrTYxC?=
 =?us-ascii?Q?IzwWBu+schVjhyYJMJR9Prc1yGdgqGOktaBHX3zRvbumabZOwi4S9VvZtD5n?=
 =?us-ascii?Q?sEEj5ZMB2XDgu8XO48Mj/0v9D6zD5+dEHhguBxBIT1MSBYQ2CFeW2SCZrB3A?=
 =?us-ascii?Q?PXNn7rnct3vtYnrJ3fijstkMShLjLo0DaPQ6zwUhYxtoxRkSjdiT0Sn3F/BL?=
 =?us-ascii?Q?vdrMTxZoyA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0275b185-c38c-4c79-80bc-08dec17d90c0
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:36:57.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KDL1hPhVkUgkNPY8Vu5qjOAMmPzssVEbufkK4fZenFiQcRYg+VW6BZP+NjK2MGXMsVNvHugWk6pcVfNT+2QRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10615
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
	TAGGED_FROM(0.00)[bounces-294785-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:dkim,nxp.com:from_mime,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15818638FCA

This patch consolidates the unicast and multicast management by creating
two new functions - dpaa2_switch_port_fdb_[add|del]() - which can be
used for either uc or mc addresses. Having this common entrypoint for
both types of addresses will help us in the next patches to streamline
the same addresses but on LAG ports.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none

Changes in v2:
- The rollback in dpaa2_switch_port_mdb_add() uses the newly introduced
dpaa2_switch_port_fdb_del() helper instead of the _mc counterpart.
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 41 +++++++++++++------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 1b3dc7b4a741..fb754dae8069 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -594,6 +594,28 @@ static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
 	return err;
 }
 
+static int dpaa2_switch_port_fdb_add(struct ethsw_port_priv *port_priv,
+				     const unsigned char *addr)
+{
+	int err;
+
+	if (is_unicast_ether_addr(addr))
+		err = dpaa2_switch_port_fdb_add_uc(port_priv, addr);
+	else
+		err = dpaa2_switch_port_fdb_add_mc(port_priv, addr);
+
+	return err;
+}
+
+static int dpaa2_switch_port_fdb_del(struct ethsw_port_priv *port_priv,
+				     const unsigned char *addr)
+{
+	if (is_unicast_ether_addr(addr))
+		return dpaa2_switch_port_fdb_del_uc(port_priv, addr);
+	else
+		return dpaa2_switch_port_fdb_del_mc(port_priv, addr);
+}
+
 static void dpaa2_switch_port_get_stats(struct net_device *netdev,
 					struct rtnl_link_stats64 *stats)
 {
@@ -1944,14 +1966,14 @@ static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -EEXIST;
 
-	err = dpaa2_switch_port_fdb_add_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_add(port_priv, mdb->addr);
 	if (err)
 		return err;
 
 	err = dev_mc_add(netdev, mdb->addr);
 	if (err) {
 		netdev_err(netdev, "dev_mc_add err %d\n", err);
-		dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
+		dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 	}
 
 	return err;
@@ -2062,7 +2084,7 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
 		return -ENOENT;
 
-	err = dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
+	err = dpaa2_switch_port_fdb_del(port_priv, mdb->addr);
 	if (err)
 		return err;
 
@@ -2850,12 +2872,8 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 
 	switch (switchdev_work->event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		if (is_unicast_ether_addr(fdb_info->addr))
-			err = dpaa2_switch_port_fdb_add_uc(netdev_priv(dev),
-							   fdb_info->addr);
-		else
-			err = dpaa2_switch_port_fdb_add_mc(netdev_priv(dev),
-							   fdb_info->addr);
+		err = dpaa2_switch_port_fdb_add(netdev_priv(dev),
+						fdb_info->addr);
 		if (err)
 			break;
 		fdb_info->offloaded = true;
@@ -2863,10 +2881,7 @@ static void dpaa2_switch_event_work(struct work_struct *work)
 					 &fdb_info->info, NULL);
 		break;
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
-		if (is_unicast_ether_addr(fdb_info->addr))
-			dpaa2_switch_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
-		else
-			dpaa2_switch_port_fdb_del_mc(netdev_priv(dev), fdb_info->addr);
+		dpaa2_switch_port_fdb_del(netdev_priv(dev), fdb_info->addr);
 		break;
 	}
 
-- 
2.25.1


