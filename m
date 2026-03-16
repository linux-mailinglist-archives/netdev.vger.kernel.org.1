Return-Path: <netdev+bounces-268068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH9FC9LQt2n0VgEAu9opvQ
	(envelope-from <netdev+bounces-268068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:43:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A1297411
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B99923009090
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C638E126;
	Mon, 16 Mar 2026 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="STpXYc6Q"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352838CFED;
	Mon, 16 Mar 2026 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654082; cv=fail; b=hej337970MsP31oKkeEvdrb1F9DAVYEbfPYxqq9IyXfQKnj0ZtUzYlHYsoW52MhrvN3sXkXr5aJPEUfQBdDgR9PXMX/3NnE1n1KTkJgk5C170jY3dFuKEY1C6Whn/XFTME0r9xz1lc0C3o/4+L2zH7WAFFes5mUog6K9EeJHa1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654082; c=relaxed/simple;
	bh=FRtxd9aeqYJeZAuh03s+GyKudvpeBTkR1E1Wqoo4+Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0A0WgI/rI03OVAdeVlKI0eBjaAGvbUv/QQzxfmBVkamlKctv8x3ddrfYHZy9dlJrRZzqPkwMrP+J3OoaY1vdYH7tcOzx0wjQRBYy4AsX8qywc/U1zucuKPDiXlPjpDDM3xoPpeebTb/FZKp6DY0g28gLMAG+OxWAtEjzpybt50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=STpXYc6Q; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VI3tZXQ2/1S5wcB+oKtPwV7VQ3J4wAWaZc6EEZqhJr59pQl6sa4TDBXyiUu9UunOOrrYUINPGJMqZ51Ob1oJUr+QwgM4eaaA/Ua3ynzJ68UiWeHbZWiWWdmDSyckPSDNLoqXn36dOy8p2+yvnwzI5N689Y/Rs4SERoemcFixyR4dbW/kq+TOCrhgNAZbknZuawxSJfepPiR0ytV2/KPUoCusV3mpy9GRVlQyQcNqRSdUA/DulsLDW52xFxB2y1AJd4vhMBjGa9P3y0hJZ8u2b+Y/QxNMbfFXYyXimAQy7q6XjdTEOwJ5viR+wJHWxnHH+PNLbGqNBV1mehgCGcVfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiccWykfC2GKn4Jtd4zudkaY3B6aZvQ8oBlCSZ5vtdI=;
 b=qGvJRzhbWoKF8xR+SiDi9Sjx09Pd4ifuU0hGiMLdGR5qOTMBYfoaUpcmVR3jaq0qvQHorC/mH58PJ+j/UZYYV9ODRk2ew3dYyPe81z1nlUzWs0MR6FcbNMOb3SboozR53bR0l09uXBdrSxBJ5MmdbPV4ZXR4Qx51e2W2GXul5wXYRb2WaIyvKB4p2fli2ewBTDQbzauQ5jrCvgT5U94OqDQYJ988UbdKcpZIjtYrhKuhGWTavl16nucsG7E3U/Clwbqx/QPUjm+iVpQpYyRTkFmtXJjJoaYNjYJup6JfyJUfO+zZ3XmMESFFpWs2Sd2qYClPDgPx8GtlTiyKmOBYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiccWykfC2GKn4Jtd4zudkaY3B6aZvQ8oBlCSZ5vtdI=;
 b=STpXYc6QK0SMK3Pw3J7m26JSQSOYdMJDnBHswcRFj9S03Omeyy9b68c/WvRHX+ph5nSxXLzzdjfdBT8Ol8bvYZ99B4o7k9xOZRzN1B2QnWWldCVSXQWlsl595tb17xr0lib2JPFMskEpL9RHK8rdcpoxiyBz3gX+jUCW9uEEiUGok2hRUPee8aZ6X3LHnaqP18pyZTeD3HbEdGmy51fkX4YcMBeKdqcoOcQiBrKOjKWydyApOSKVZe/vc41hDI64LrO22al65JK39kQwihYS2APFSj5xfjjOFV6yBGlwM1OG2AoQjfCbLC3jukMxIBa3RmwNvijmh+BTN9cxfwVpyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:40:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:41:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 08/14] net: enetc: add multiple command BD rings support
Date: Mon, 16 Mar 2026 17:41:46 +0800
Message-Id: <20260316094152.1558671-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316094152.1558671-1-wei.fang@nxp.com>
References: <20260316094152.1558671-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8d2d0e-2b40-4a1e-95fc-08de83402e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|921020|38350700014|18002099003|56012099003|22082099003|20052099010;
X-Microsoft-Antispam-Message-Info:
	E7Hqt9OIhQMTTVYPa3/8YSM5gp1013ba3JQE+vgbS7V4Vck1ZkCOAQsQC6e22sUJTOIRcoNXXVKJabYIo6rxJR9j3tkEsTOjCwRnQ8/aO7G1SF9kkzWJn+iESAeDcEadFHfclJl4L4rtNPlGodwd8zGhiy5dkCQeTPiaRiv9vHdREQ4qutv+7FmxgmrpsyCgoDHdWW2v+NCTr0H096wNE8VxMbI0V2v4XsrE5txUCdvDGutBmtlnlZa/YfRYrxR6ZDmXd6QZetXCURAewrYhlsTnyz+q+3m6L9SaN/rUzw7MHfm0JS+rv+4JyYhNQl7YLpOhqQfNiRj275CyH4RZvi+i7dCG5EOEw4JszohdJ1MUnTqzEeV757BRjyxTl5g9ENltLSd8rwma1bXXI480QH+4LBu14JJ04V1IqRDXr/xN147vk+rTPdfWVYZugIouZfkYEKc0mcbac3hNDr2XxiKEuqxtYOBe5Ci4Ru66wpQdb3WxRV1lRIk3t7jrvSekNDIZtGK8Br9X28JcCFdIzySt8qtXuXm75PVDMKd7lyhzvA4Z4REIA+IQZLAsLSZ7IKCu0V85O1mTpN3WHmn/Xt4x/r8o3LMHu+AxXKRR1ul601XvXuEXbBW4gXxe5gmnHwxAwn1Pld6/QHLLrWoGHcGUzl1eW6eb0AF2edU9vs5KuIgfP1xlMg66SwWCAhkrvERKIgGZ65K68W7H4yjglaZmBhBVw8TlSQdXLTi0JRA7tfGj3dk03Xa3rlZGZlcvM/mijQretOHff+3reDHcW4qlD7dN49yjVZi1La15HCHpVWhcOM8PP+o9neha4aYu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003)(20052099010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RMEKpzXEEAaRPhgIBTTEIt0b+SGvGUgCoRnrS2kZqJoYBjC5ekpxLgTDmpGP?=
 =?us-ascii?Q?v7Zf7dxYZqi+e0A/nTyOUbWyTzsqQViszd9RY53uD7R6H0bkqSj1pWc3ywN9?=
 =?us-ascii?Q?QxwCfEdG7bCtvWsk2uLfw9IyNRovRec6YURGf5j5Qi7bHaiHuPQSxW2YSxQl?=
 =?us-ascii?Q?/k3J1HXEVuvrm3JjLpUKJoHtvUTTw0epN7XJwGs9tmSnjSxcGWk+tgM7Rn+2?=
 =?us-ascii?Q?Vg1DIVlW5FEdppN4MS8Uj8VZwT09UUb/p6kkhpO3f1Mh2kGMBZecnP7T2cGc?=
 =?us-ascii?Q?/YXsgLs7VcagVJv/aai3qAioKgt/oL17bsHTIz/bkt/wxvlpySU0lq+q0u9q?=
 =?us-ascii?Q?HzZor8R9quHMaz8rnUDLNwZ73mcCQlwTxe2LSkZdvq6U8IIERRpf0a+6DVJF?=
 =?us-ascii?Q?FPfl1DP/7mbKLKoyRs3rZnnpRXjDFy5HpJxMZnvpXIAmtMSVG1HYBiwZrQip?=
 =?us-ascii?Q?U95/60zJ2Vg6TvrAIcQm5lE+pUjA4b8lYq/iC/2wLd9e5+2ot9KByuT5XWer?=
 =?us-ascii?Q?UlPF/K/QoZWBdLMvZve8HmG80QmsPD2bZZV1e71venqaFN0InyBHR520Kvlt?=
 =?us-ascii?Q?tTQMrrHHz4vDV6h5+AXHngJekuoBDR1ubqT9hZsyynVj5UHmCRdvytAgoIBn?=
 =?us-ascii?Q?rVoKQ6irxIeygvK9nQgarB7Ct0eMeVGbGGI5FCPkrUXqAzqGYOFPOhyOT4XC?=
 =?us-ascii?Q?NDXFLvXJqU7c5u80iJKo4OI0Q5koHvJTrKX473x4/XK2PNRC/ZTb0v3IYVmt?=
 =?us-ascii?Q?rk2P3ua3BkSLpPsLKP0GruxmXPy4A2t1p3+2RiaLWG9K0FljaludZH3JO8qb?=
 =?us-ascii?Q?Ve1shzy1/bjWSpKGTBV2NIWe7gkNdd77dYOXU8ctI/pVaKmofakON+HQQWtY?=
 =?us-ascii?Q?1NXZviUnf41gBlXeMq9BIGpc6hccnh86u18GrkO3ehURFvz9TeXLxB5KT8K8?=
 =?us-ascii?Q?vMPOUtszsc0sFLnuas20gye6T1093QWNK84fOtg5kDjSm+W7tg5UKDyWpQnr?=
 =?us-ascii?Q?PinRagHMvv3zeUhS5JqAGguxjbMJz2yJOYbTax8KzXQx1GHRliUXLbGoNI2t?=
 =?us-ascii?Q?476lEkK+SYyw4hcagTDylZjmK9pscXLnEcjdhDCX4LvsA3Aug2yy00dBu5+x?=
 =?us-ascii?Q?q+MjhFCFGQzquszjvGdl9gMGhfvYYLuW9f6N0w3HdLCLaZ16UVUnHUd/btem?=
 =?us-ascii?Q?BdpnMGN3sgxw+EbtcO7aJFB4AQadC87T1bcUQZd4JaaxeNpw2b6UBdWO5nW/?=
 =?us-ascii?Q?FfR3sMNOzV5jFu7vhuRts0RBDnUF0bm/GTQJ8feMnW0lh/H2IrXdpUWOWifD?=
 =?us-ascii?Q?RlK4/w4Dd6AxwvZfQzUolamIh0PZUM1aHe6X4v8zWQ18QtMpUJCzYwgImWDM?=
 =?us-ascii?Q?wX0YUl3BHudmPPPCrVMbXQgVQknXnXr0r7bcxABsKa5v+bRoffX3VrRvPo5c?=
 =?us-ascii?Q?CUbH4b4ATbytxjWM+8ViKCmJDM9yKygkwYSSkBYepk4tt2gjK1/lyJNa5Xt9?=
 =?us-ascii?Q?x6Gqomd+LBUbt9HnOe6ZwuXMgK+3L5DBcpzXPGeTcxqr2MqVF2ciaWHFeS2l?=
 =?us-ascii?Q?m6h1nmmU3lIwrVfn29Or6+XGpGS/Rc6rZ/EI2b2qey3ovrFIEi/6xowVWRtq?=
 =?us-ascii?Q?29exN3fUera/U0n9Zy1Hjb7lRE0FTsC/tqlJcQ5KRChCcsKc7ecW2k3V6qN8?=
 =?us-ascii?Q?qe3zijVxwRxyhL5I4yCHGrzsZdD64RTRxUMqg/R2MgsLMpsj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8d2d0e-2b40-4a1e-95fc-08de83402e2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:41:21.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrYnSf7uFWIOtr1DZrk5qLJZIyoQ0Cpcdir0lfivZ7nmFn3AuHo7kH0Fvn3MfXDQy+dJrKPjv+6uNOz0eF6+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268068-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: C89A1297411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All the tables of NETC switch are managed through the command BD ring,
but unlike ENETC, the switch has two command BD rings, if the current
ring is busy, the switch driver can switch to another ring to manage
the table. Currently, the NTMP driver does not support multiple rings.
Therefore, netc_select_cbdr() is added to select a appropriate ring to
execute the command for the switch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 27 ++++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 9fc3422137fc..e23a32946762 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -117,6 +117,25 @@ static void ntmp_clean_cbdr(struct netc_cbdr *cbdr)
 	cbdr->next_to_clean = i;
 }
 
+static struct netc_cbdr *netc_select_cbdr(struct ntmp_user *user)
+{
+	int cpu, i;
+
+	for (i = 0; i < user->cbdr_num; i++) {
+		if (spin_is_locked(&user->ring[i].ring_lock))
+			continue;
+
+		return &user->ring[i];
+	}
+
+	/* If all the command BDRs are busy now, we select
+	 * one of them, but need to wait for a while to use.
+	 */
+	cpu = smp_processor_id();
+
+	return &user->ring[cpu % user->cbdr_num];
+}
+
 static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 {
 	union netc_cbd *cur_cbd;
@@ -125,10 +144,10 @@ static int netc_xmit_ntmp_cmd(struct ntmp_user *user, union netc_cbd *cbd)
 	u16 status;
 	u32 val;
 
-	/* Currently only i.MX95 ENETC is supported, and it only has one
-	 * command BD ring
-	 */
-	cbdr = &user->ring[0];
+	if (user->cbdr_num == 1)
+		cbdr = &user->ring[0];
+	else
+		cbdr = netc_select_cbdr(user);
 
 	spin_lock_bh(&cbdr->ring_lock);
 
-- 
2.34.1


