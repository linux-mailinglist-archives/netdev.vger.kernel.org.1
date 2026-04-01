Return-Path: <netdev+bounces-274205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPBxMghWzWk5cAYAu9opvQ
	(envelope-from <netdev+bounces-274205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:29:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1CB37EAAA
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 19:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECA4A3098A2D
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E30847DF8D;
	Wed,  1 Apr 2026 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g8hWlTJf"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED747DD75;
	Wed,  1 Apr 2026 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064183; cv=fail; b=RCQ16RtpphhUcChGay5Bbe/1QT3hKDGmoGNQH/iVW0N6JEIKcF4e3JnU+8sJXln6hTo+lCfcUwH5Yf4qFvlDgqFUUhp+2TB74klI3HNLmbCf4QuB/7GYrTKlfe07mbrXkcq7e16uyOdoRN3+8lhqGEpSnnGq3ioCwDGZIlLnZXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064183; c=relaxed/simple;
	bh=itzMffkY5uwSIpbB2hUxdYBBlYX9EfYKmC5Cl6em1hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCGa1SY9oOdzcrq72I9dTsa9nflbQAPrD/UHK4QNHvHK7dyREUIg8X9tKJJ9eNkfmmNNxbqhLEjunQilJpshGh8xieGxltLSy1B/Kthga6HKLyc5qQ0nYWb1X3kA0xL/ot/iZZY+5RIgyyxQuZf+hKsP5KD6FKTUml3O2SoSiis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g8hWlTJf; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRs9xYGgy7eCq2h8d+gQq4a+WqpilNEd8NpTrIJhYA6MQ8aQt6sLl7gzvC2QPjN3uMkDbhpkBqtnXf8cQjJyPxEZTspHhF0iJ+0j3iZGUDdjELOx1FcJ/5yaydmEsOLHZqU0kYYk8K9DK/8i1M+CTjzIQC8hqXYEBvKj1x0t3xL+9h4QomH9iP/g6SZbjnKgeijZahrmP6MKDOP1capOnuBT2awDIOwB2NhHZZPK3FtG3eLKZFcOojzIZiy4q5MLfsq2XbB8Y2EDskbKwLdmmHh87L81GE8Xs330aem91SwHyNFMHng0rs/Nm6rHSLT4nXa5dCC7NUwnuRmfF4GL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcGtrsVmcwbZKQ92ZFUdKSpAPbkQa17m1eIlMZsdCSU=;
 b=i2AdET5o+xZsO0ASDjbSKpeT9F30/uC3bEr8xpvHG5FNM7p96d/P0TwJWN9ZeJdczgliq2qbhQYQVj5MXAtpeW4WDfu923zsCe2+BVT/mQuTs0CGoVmt0i0jvHjPhzYRf5gK0stqJRF1lKWR8Kex38ByEf0U45/i/qYEH65DEWb3zE0mvUA4pV2ECgeXTSl+J/AfHn03DhruqMCeZ6yEKXqqrEqj5l0Z9gokmogFAZpKxReU7dicuOgY4DMNoxCrD/5gItRWt3ke6KSLeZLfRCtl5DS6+hkmhjtfmgqgjTH+TuLmJIrBNpZdKJOMP8UlU+AYkUw9gN2l1pvNMwoToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcGtrsVmcwbZKQ92ZFUdKSpAPbkQa17m1eIlMZsdCSU=;
 b=g8hWlTJfBQcLioQGoLtz2jIIyOt9tXp2ETzBcYa05Osd7TDWQ50vOZSsj6ZtFJFd6LgnPPl/6l7yOe8vFdhcK+q1TeUpYOieK2TGR8g66p2xh4LlmPlnR1TSSly4jrC6+mwfXxbJspogyZ8Yruolk/aadI1WPcnAmMGCjtiPmUsVAmtqJMWX58RycnVvuaFXaA6ICQaxrrbHIj135fw3wbBWcHVi6MRFi3kweEY3Udnc4mg9HDni1fkXAGUxVfiwbQvZS1moot2V7IoSY7mvHSlGDfaqf+SES4tZ4y87eqAxiymcz4hYCeTkkDsdIP8AIneDgBwWYbfGI+sDZFxYzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:23:00 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 17:23:00 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Zefir Kurtisi <zefir.kurtisi@westermo.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: enetc: pad short XDP frames coming from devmap
Date: Wed,  1 Apr 2026 20:22:46 +0300
Message-ID: <20260401172246.1075883-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401172246.1075883-1-vladimir.oltean@nxp.com>
References: <20260401172246.1075883-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::8) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b38a8d-ae4d-481c-b873-08de901352ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|19092799006|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KfMBX7q4VwhkxtBn5NpK4U9r4obxjbqOAKD/uDYEjtSp5vPZ+tBsMbf0ZJYt9vyStEulGHehV4sciT0fY4QFXLS/MhhIRXc92S0F/9+P5qit5sR+9P4zEg5g3jiRg670DoqOnkb/iv5qS8vy5CmkqVFMv28rQoI6eelRcbtWq9+HB/S17dZ9j+YxbDM80JBHqMh2uG6h86CvEDjqkCvcX6uGyDvXGaRtKOCpDZe9ZwphFrlGH8aZvBRBgQyaBF2OFuR6/eICg//nB6EZL6hbgvMa7zNjGz1et8Vv/xLNeaauGns9aDsIohvB1cwp1EKmKGFNlIxFmX1JeL4MzRgTkBGI7VT9u59TYF/vP59XU2aK7QkOGibKeuLNQHVZuT7ZcVTgHmBf6ZM2vHdFFcxy9oOl+6SyIGbShs4RaGn55fvukCYVihWPRecsX3ROQfUTMtlKqeo4OgyNAUN8CphAiWMwzCEZ31F+nVxlp/UXHaqavc0umY5/ilHxQZYIw+sB6EjrKeXNwQAoCVGRHAFMLI2CMrhRJ//ZBjhT9qVfnSn5pKcN2AdRu0ygg6YblcYQtQ+tCLjnx7xbmoWCAm78aW/dlFtzZ5um1PPsYlLGo6J1zk6byfabCrFnNDMIWa2G70/2bvc5ZzHZKEsYXotGlVADhATTXHiTsPi/7/nvPv4MyvNyfdX4pYI19ioA+abQaMhXvdeE1vg/SGWQFSM5gEbVh2uun0pr+ZuOE+QOGeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(19092799006)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oE7kI87xDGSwl4lAHSuI4LVcVaCzGDJ3LiblXFXQDsUgQIZMXS8zJ1cMEk+B?=
 =?us-ascii?Q?TrJutCAkXKnHBExfGjW3pSBsw9lLR0f/MMpS4Rr5wRmdfrUVz7UWkys62IO9?=
 =?us-ascii?Q?nTKxNbI1kHmSni4YD8ZljOdRNZnVISLenOcv4Rcy9Fq8SLohOSdoNFR2uEML?=
 =?us-ascii?Q?UpwkZZnTmIRMzxAZBmN4UrpQoR/mfuVu/pbMgmUnEhEEwrB0jUwI+o4HKdQp?=
 =?us-ascii?Q?cHmXxQvg5OwKfVkrrP5rs9eTscNz6O3cswskX9OdoOUr6aJ/1hSciQBJgmH3?=
 =?us-ascii?Q?uE8nhaK4l8f44QMwcWcV35P3p1iEFgGgcFr1B35+Ca5uYAAD3UdGFUmGU+oc?=
 =?us-ascii?Q?8qzcSiNm49aLvtqLNBW3upEbEztBYCf86ShoLDbFF4ji6wwTXFIK3N3hOe4B?=
 =?us-ascii?Q?fJAjps84MbnZ6EEo3xYHVmT1M7Kx2bz7TOXF4OI/oXGtJj78xjGEGnfKYcyw?=
 =?us-ascii?Q?gaRxZH+9xVeq88hCjtvptr+dRgTWqa11WGfjueduStVn5+Ya6lSbdUkW1yMd?=
 =?us-ascii?Q?abDJFG9G+wSu2C2aRIwxaIu3LPpuL5RL07W/ME8CJ6HIXqwMZGPuIwcer+4F?=
 =?us-ascii?Q?WpduVrhCIc0sE3SzleGgEYocRICpLs+71dHY0h28H8wwtbk6k8zW/aC5yOl8?=
 =?us-ascii?Q?lzGxJxKEWLNYN2MeT8TPOzFnbzRTpn7YxgbTDieDIFx+QShQbhKWbrUuqcGX?=
 =?us-ascii?Q?CWopEmGHqlroReSxeZfVHD5vM42SUHQMInaR8SnJSNi9hC//DEWP6TgJUSnX?=
 =?us-ascii?Q?aQ1EX+szS1Us3JdcQl07h/IhcotfWfSNIUqyv3ltoT5nzVn4BAylOsNXUIXP?=
 =?us-ascii?Q?cE3Pq4Xk75Pja9PuaGvss42RzDf9w0V/Zs+sVkPwnqt4+yRNz6GPWLz5gIEW?=
 =?us-ascii?Q?/KWn29SDUuQIt5tw+w3S5PgXRm9qDRZ8flT6dICQGyO7WMVkYxzjxDfpakAU?=
 =?us-ascii?Q?+5P4UF37PIa+KoYeLAwEt0xXIx2ImDJpJZ/PyXnclPT85xELYcJuaSvbGaQi?=
 =?us-ascii?Q?gHwlT48LYaOO4Bdu3UH5OOSHnW90PD3GAhnMTUDNPem47E6+JtvSwKxapGqc?=
 =?us-ascii?Q?5daAG0g07a64xoiF3MpDR3tfqVFFlg+8ILrU6wpvN0/T0CzCgilttYyOMVsL?=
 =?us-ascii?Q?A4SKYHWJnyNwUrkTlxt1WKBPHosHr4ryhFKAnpNs7Y3jeyU9AnKAJt9nRy+t?=
 =?us-ascii?Q?GJk0JnXPuZog3rK+WwfEkbssCnTRgvykHi6LP2IbEzPGejPFXxw4844MGjGZ?=
 =?us-ascii?Q?8oqzF9I9Uy8pQWLHqNxevwaa+OtiW95FBoAh2NzHzjyFzpdpk4aAPft8Cxua?=
 =?us-ascii?Q?vYC9OtiK18deHncUr11Nt4Fgd3TLkr93THsvBeH7nr9zt/LWTYrgc20MA+td?=
 =?us-ascii?Q?mKkux/gtM+wwSi2fs6Q7uMZ4aA1PesmwlZMwM0X9ShPDB3V8zXRSjKjMNc4e?=
 =?us-ascii?Q?vzlMzh+SGoVF06NxVcdzfGCXIobuGrebqyejXfwr6prAJKeyy7AOuaTJFSGs?=
 =?us-ascii?Q?4EFilHYAR6mzayJU42a/bPzIkNLuVq4aeJlO2mLbAG5BtlDeDJjPBPVcClLS?=
 =?us-ascii?Q?7iEOoSLmqbwm+hXpfHdUjZfZE4YlGCNgiPfLkFjYrpgrYtjc3UjOfi8THK3h?=
 =?us-ascii?Q?LkyRZsbVWyig5+Clrdn1+1wD6qbXdOEP+RTlp7PSggjSpkKqUnwbOjJ/pU+5?=
 =?us-ascii?Q?66+Fgs+G7EM+q9UwPT8Xl3wx0MF97rtII2c1MbXC0lfjooTpdqeBqyR3F43P?=
 =?us-ascii?Q?+PjKrTFv7LtfIYc6exBrgvEO1mCIxgykpCp0uw3p0Qtq/6ZadEkAooLexgEF?=
X-MS-Exchange-AntiSpam-MessageData-1: jMc6LTqK7tBHweh6M1Eobv8pemdOFgn6t5M=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b38a8d-ae4d-481c-b873-08de901352ac
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:23:00.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 867uX0MRWO+s+TGQIi18qJcLJ6J70OniZsBBy1Q3eU21rUFgU7y4P2e+qgbmUELe9U4S+hXfKsMghbbBv6TQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[westermo.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274205-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 3D1CB37EAAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to the skb path issue explained in the previous change, ENETC
could end up transmitting short frames coming from XDP.

The way in which this could happen is a bit contrived, but it involves
XDP_REDIRECT from a veth interface pair.

Introduce a xdp_frame_pad() generic helper and call it from enetc's
ndo_xdp_xmit() implementation. This should be safe, because
ndo_xdp_xmit() is the hand-off function where the XDP frames become the
responsibility of the driver, so modifying them is fine. AFAIU, struct
xdp_frame doesn't have multiple copies.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c |  3 +++
 include/net/xdp.h                            | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 4b87fbfde0d6..3ceb9dfd2316 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1801,6 +1801,9 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	prefetchw(ENETC_TXBD(*tx_ring, tx_ring->next_to_use));
 
 	for (k = 0; k < num_frames; k++) {
+		if (unlikely(xdp_frame_pad(frames[k])))
+			break;
+
 		xdp_tx_bd_cnt = enetc_xdp_frame_to_xdp_tx_swbd(tx_ring,
 							       xdp_redirect_arr,
 							       frames[k]);
diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..0cdeb23c6bd7 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -477,6 +477,23 @@ xdp_get_frame_len(const struct xdp_frame *xdpf)
 	return len;
 }
 
+static inline int xdp_frame_pad(struct xdp_frame *xdpf)
+{
+	void *sinfo;
+
+	if (likely(xdpf->len >= ETH_ZLEN))
+		return 0;
+
+	sinfo = xdp_get_shared_info_from_frame(xdpf);
+	if (unlikely(xdpf->data + ETH_ZLEN > sinfo))
+		return -ENOMEM;
+
+	memset(xdpf->data + xdpf->len, 0, ETH_ZLEN - xdpf->len);
+	xdpf->len = ETH_ZLEN;
+
+	return 0;
+}
+
 int __xdp_rxq_info_reg(struct xdp_rxq_info *xdp_rxq,
 		       struct net_device *dev, u32 queue_index,
 		       unsigned int napi_id, u32 frag_size);
-- 
2.43.0


