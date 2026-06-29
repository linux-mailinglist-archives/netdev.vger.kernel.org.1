Return-Path: <netdev+bounces-302576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NpNDEH9YQmqe5AkAu9opvQ
	(envelope-from <netdev+bounces-302576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:35:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E59E6D97F5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:35:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b="JCN4/Erc";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302576-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302576-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA09308C30E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C93DD523;
	Mon, 29 Jun 2026 11:23:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF43C9456;
	Mon, 29 Jun 2026 11:23:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732212; cv=fail; b=X9sccT2oOCj3ltl6o7ZmdaoUy7TZrCOLMz+3kt8e7NgnsjQPxIG/JFtTgUKvWkiMU5XzEnrIvFgYGHff7tner324/B5e9XVUuNTudckTMtVz4sVr1+vJbMuD5Cw2iQBVPL+KyqgkJ/R3wzBXB3kHD8PMz6V6b918xSYEnTZZcZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732212; c=relaxed/simple;
	bh=40y2MpWQk9cJg8UY3+V1FBdCUcVnWIApXDQW2ylDFyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RnnEmq8XGHDW61RCHuAMCkibnktByjmNKVaPk4RpqrN2lEM5qGCYodlSKX/bkuTmy80uCPDrbz6JNP0QitJanE92bMmsfN7j7zuDiWqi1hn3alp5X7ALpwspuc3O99vxFTNRCgOxivBPkWHC5cLN+QHynEXjlvkFinQoj63I+EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JCN4/Erc; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CR4NobDOKbsPkah3vwYdpA8S99qangBDZn5+NHdjmadjZ1mM4eRr44vlNhLk0oyZ4UIqYE8/btqPYQpiELNYIJkKdd3g7SKOAZIVDqrCW3uKmmfEdnEKQEIpr7AeP1rP4UkGaf7Fr/SVTc2241uqlT7exHCyc47xaWSgt8xKiThe4A7shmu7Ah7BYsvGe8VLXZL07jmnKdva5ogeQsigCfX9mWnjNgfGgAE4cx6OrKa5VZCYQy6QLdwOOQYEUG5gwWn8Ew6YLxkEbxZCQMzxnaIMoIoUkEY9hbWlw1iGXKgrTMx1EnuSYNtR0TwtPJloOJlIHDgToLqinnj+EzH2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc8SlY3Xp3aqyl25Ot8AAI1/WwJUbFu6cOHt9cHVSc8=;
 b=JEJE4szEv7p48fouKnCCEQ+6Zun63a75st8ki/NvzDofwqR6RONLMYMIsl3emEkUpr78DKncyVgi0MbFtCsY8nf82DhNuVuB+SLmU/N8/jufmyej5OWsd5z7INICH/68ZklT7Qhzf/0mLzHXjopNuey3Al193zSIDTHjIPOYehk7xHmJFLvI8aPzfC/PTNaH4NKxe53/1anxrsHZ6V65dSroORJbJ4+sR7kv7SXOWicul4u7DdaxQRqiWN8uXZ0szqqe3Pr43fay+IL4nfKqkVMToe7JmJn4KsrAs7LdI63mwNC2c3EV8XkMLCVS1DNUAQtRxIKgv+f0yTfFeemozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc8SlY3Xp3aqyl25Ot8AAI1/WwJUbFu6cOHt9cHVSc8=;
 b=JCN4/Erc+EHTgAZ6UAmiKZVK/4VpKz10tsgo8bZqfuxFvu4YPJYZIBZUN84hax9h5I1jO5sd5nfk63qnlEpRY9t30ysujf1Q5t/MLQW17jYe6jFoMjAweNQTdB3iFwZfpzJxfnvw7DyvBK8tc6kdGpY7KSlvcZaYpmVcL67Q5GtT+xmp27o7XbWK3ne9weVJ941lpjx5k4shAoJCqsglXwPQPQFuvecPWI9yjSW9JA5nNRoNs4LWX5p9pP7f3DHbdUOSYIybpUq0naNuDmAoDZIagSIg6Vu+isfA1639mcaKNCCI0SuUf9H7YRs/MNOERGd9/VA/JgEvrkRzVfp6Ow==
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:23:24 +0000
Received: from VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b]) by VI0PR04MB12302.eurprd04.prod.outlook.com
 ([fe80::d68d:e9b6:88fa:9b5b%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:23:24 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 01/13] dpaa2-switch: remove unnecessary dev_mc_add/dev_mc_del calls
Date: Mon, 29 Jun 2026 14:22:57 +0300
Message-Id: <20260629112309.154328-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629112309.154328-1-ioana.ciornei@nxp.com>
References: <20260629112309.154328-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::17) To VI0PR04MB12302.eurprd04.prod.outlook.com
 (2603:10a6:800:31c::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12302:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8284e543-ee6e-4a81-70fd-08ded5d0d567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P/6XcBm1jH6h46fSW3UsEdktberF6AvNpreWAKSH0a/PqiwMsnA1DBDYrCM1nEtKRTUuobQYy57EmHWwQZkhPfUCBbw6C/6Q2MoEP/mJfR/9zyHygXZm9O7tud6Gkn9HhXOhzxb8DIHsmHH48XvQEX+0RYKlV85ZpBnPeBs7NZpWZ0VbM2kmPUR9jCPUNvtxKVVl4N/uSkuXzoYaXAGSdoxem5rE+sFc4ai3lO5A7dtZzNGeRPo0O2xya2Tk29PM5J1dBz2RwOIyI1KJYWEYqH3mGxEDd9J+NAk9sD8CxE5Kot66NI8ndutjpRm2aro6LGLVGZAHZEuNvQfccLksCcVn/+rP+HibntY35L8l+xCI6hn+TowzF8rdKSvQEO4OxcGIrlE3xaZTB3dixfXNMkc1fo3sSRV1ElS36VerUmk0pLdKi28ISSavGiW8ntupvwuWNQD5VguopqZw3w+UxO34i60kU6TbCRxe3dI6mXserIKkImvGzQdsiChWjubORqNDZ0XCGLuqPFtiOpJtn5BmCrHfASGJSDD5wOH4SDx/S3KthNrOVzJnP3eXM+gvsf7HKD4U9k6B8YnGuf48T9hoTa3KBY/i4PlzrzwvMPsbNEW1G8BHQwDkVtWuWtxpA6CsCbc03eb+r1eVMiCv2XN5I82DAdJ8Yb1iTvpxUxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12302.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wa/oYqbvj88uKQmCbsFeEG5kvOiRHSuvRqolqG9eMnFmPgmh559ea9FODnns?=
 =?us-ascii?Q?oUQhTzqd5TztmhWOLRrRDAtcPEkZ2WBfoaPVeTYfrp2mJxfhTeJPr1eFdaky?=
 =?us-ascii?Q?bjAp/cpr4bQ2h6uLVXfB8k6Tm5aXg22ippi4qCvyZh42OSPxKVsgaM2yvPDj?=
 =?us-ascii?Q?J6EiCZNBY2OAk+WonSd3unq5rEmCun988Otd6T3UyKNLzcuVVmtvU5YruFEF?=
 =?us-ascii?Q?iQaXF2y9zvMExk5x6wl/Xg+NpdbkmqWRpAwk47FgqEyW+cb7i8bDWzcelspF?=
 =?us-ascii?Q?zv+a5YQw0YzVIL82E8IU7WZz2qEUS6c0x16+8u1bzU5AR0lQztMAxPMRfDu4?=
 =?us-ascii?Q?ybRy2FByLcjcmWFPZaY1cdXrxI8PPvbI6tM4E0oYdqTvhZrwU6A5XWuqGzCo?=
 =?us-ascii?Q?neAlSXnI3aFZyCOnnU7UuihnDofzperPQko9ToEn0D5VB7Qdw97CecFJyYt7?=
 =?us-ascii?Q?VWQhI6veqpiKjVbO8rV5qo27NRtL+LMQPFWnTtvTHoDihF/wDM9h5dUXAkNY?=
 =?us-ascii?Q?LeqzEGA+GilTTZxxPMihckxlI9x4r68VlMu02Og/0xuIkq1tGpuzXq0hl/06?=
 =?us-ascii?Q?g3z2KSH8CtWquJnVkrrvYxMY2I5+clTAc9217wWgl/ThfyW9PVfXv6O3ol+c?=
 =?us-ascii?Q?q4V3e7KjuTCYuOfbGXUb9ENBWVm32LAzlbxR7RGMv21wzBzUHXtRc9soKZna?=
 =?us-ascii?Q?KMlo+GrCs6gl+eIn6CbD6orHUkdlnG5Ao+CmayJD1hpJx+76XV+dBT93eymu?=
 =?us-ascii?Q?wpGtY03zSmKND/ySc3c4tOGeP/B1zGX4Y8+9owIrWexYgCpSaszEgfKZ/DEL?=
 =?us-ascii?Q?noPnqtF1GSQy7vg7ObD9XxoCNGnPKMB2s8mh3IVGNoUB/Lr7IA6WmSv5mrla?=
 =?us-ascii?Q?+cT3kh1ieJu2LUkWvqdDrQpSHNIDNPDBtxwnVYRJMVjufxz1LpdW/2KVJb9K?=
 =?us-ascii?Q?F5bCFKsn46UBVnH5A+nt6DbiniaRSOCb6SjaPSSvwNhLCBrtVa3O4mcEufcQ?=
 =?us-ascii?Q?Q+1MudlLmHwGax9NUU8xJsQigrxAVBCZzPhlGgVDfBl5ra34Z42Jzd/bAeeJ?=
 =?us-ascii?Q?JEivBRpWKjmPV7WD5I+LvOvR+QiguB2YH1oSCEpMk8BfWVfQcOenzjN8NodQ?=
 =?us-ascii?Q?aP2r7vAqX6SUzR/FGoAgZCv0iUxoAA6N6SXoYSb8xUwBIUueNs32kcBM/xhE?=
 =?us-ascii?Q?3yQIeeb/22rnpqHezLKmfdLtKyKZGij9pjioEaxmeUQKSTUsLgUVmkWLrVdU?=
 =?us-ascii?Q?JHySD8zVD1uYu6xga0/EuqVlKawMkAexAZHZ7y7aZDbirw+AG+GgXMc1r1xc?=
 =?us-ascii?Q?V8J4aT+DunsmDhphbv6AcQNDgCv9D/MgO6lGzMUM8o1nmyOAasVk6oYpOwmt?=
 =?us-ascii?Q?F5l52H6/ByyVbkKNYfCXyIbrwQGqK8CwpJWDLCFUlX9pj8Ha1qUZzNVZtQ6u?=
 =?us-ascii?Q?DiRxEbY7ZaUsTNUwu06BHV2rjWH39/GwlNzrxhq9fhatszJWjuww7ZiZJCAy?=
 =?us-ascii?Q?s5sBAbN1mkFMCXEC0EkjU1jqaBxPhAB/XQSjR3AwsQ2XhwwAqDq764ODWJws?=
 =?us-ascii?Q?I19JRg4av2sgnfZXevWZxNE1H4zK1rFqNcRxC6GQgF5jDCAuTis6PqZqpwyR?=
 =?us-ascii?Q?MQE0G2zX49ous0lgxWbzuX1l6zoVRzU5euLBMEup6s0fMIOZ30oEU5038Ek9?=
 =?us-ascii?Q?VARNy5SWfsp2GPLHz4VVCa01wNIMRe12sjcctH3wQL9MmGcudUwna+Bt2IJN?=
 =?us-ascii?Q?u/Cg0zS1Jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8284e543-ee6e-4a81-70fd-08ded5d0d567
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:23:24.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCK3gtVl00YFBB+kXp1fvo3dqld2kzPs35qojsM8t+VkwCDUYHSTlNdYl9aTxUU+hNzYf3Sk5TB/QRhg/w62YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628
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
	TAGGED_FROM(0.00)[bounces-302576-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:dkim,nxp.com:email,nxp.com:mid,nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E59E6D97F5

The DPSW object does not implement strict address filtering thus any
call to the dev_mc_add() / dev_mc_del() is pointless. Remove these calls
from the dpaa2_switch_port_mdb_add() and dpaa2_switch_port_mdb_del()
functions.

And since the multicast addresses no longer reach the netdev->mc list,
there is no point in keeping the dpaa2_switch_port_lookup_address()
function which searches through that list to verify if the same address
is added multiple times.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v4:
- new patch
---
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 50 +------------------
 1 file changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 858ba844ac51..d70e6f06ac15 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1860,44 +1860,12 @@ int dpaa2_switch_port_vlans_add(struct net_device *netdev,
 					  vlan->changed);
 }
 
-static int dpaa2_switch_port_lookup_address(struct net_device *netdev, int is_uc,
-					    const unsigned char *addr)
-{
-	struct netdev_hw_addr_list *list = (is_uc) ? &netdev->uc : &netdev->mc;
-	struct netdev_hw_addr *ha;
-
-	netif_addr_lock_bh(netdev);
-	list_for_each_entry(ha, &list->list, list) {
-		if (ether_addr_equal(ha->addr, addr)) {
-			netif_addr_unlock_bh(netdev);
-			return 1;
-		}
-	}
-	netif_addr_unlock_bh(netdev);
-	return 0;
-}
-
 static int dpaa2_switch_port_mdb_add(struct net_device *netdev,
 				     const struct switchdev_obj_port_mdb *mdb)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-	int err;
-
-	/* Check if address is already set on this port */
-	if (dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
-		return -EEXIST;
 
-	err = dpaa2_switch_port_fdb_add_mc(port_priv, mdb->addr);
-	if (err)
-		return err;
-
-	err = dev_mc_add(netdev, mdb->addr);
-	if (err) {
-		netdev_err(netdev, "dev_mc_add err %d\n", err);
-		dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
-	}
-
-	return err;
+	return dpaa2_switch_port_fdb_add_mc(port_priv, mdb->addr);
 }
 
 static int dpaa2_switch_port_obj_add(struct net_device *netdev,
@@ -2000,22 +1968,8 @@ static int dpaa2_switch_port_mdb_del(struct net_device *netdev,
 				     const struct switchdev_obj_port_mdb *mdb)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-	int err;
 
-	if (!dpaa2_switch_port_lookup_address(netdev, 0, mdb->addr))
-		return -ENOENT;
-
-	err = dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
-	if (err)
-		return err;
-
-	err = dev_mc_del(netdev, mdb->addr);
-	if (err) {
-		netdev_err(netdev, "dev_mc_del err %d\n", err);
-		return err;
-	}
-
-	return err;
+	return dpaa2_switch_port_fdb_del_mc(port_priv, mdb->addr);
 }
 
 static int dpaa2_switch_port_obj_del(struct net_device *netdev,
-- 
2.25.1


