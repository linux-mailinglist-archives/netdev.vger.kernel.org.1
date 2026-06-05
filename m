Return-Path: <netdev+bounces-295684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c/uxNU56ImqGYAEAu9opvQ
	(envelope-from <netdev+bounces-295684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:27:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74577645F57
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:27:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Z2NyoFic;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295684-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295684-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 892EB3045B45
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D4478859;
	Fri,  5 Jun 2026 07:23:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032343E4B3;
	Fri,  5 Jun 2026 07:23:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644191; cv=fail; b=UbExC1k37Z70HIfCR0O08k3j/qQ9z64Pkf63iZk9pLUtLhTTQyaGkKYu2VwQHPTM4UTmkvl8rdgbEGubPB95GHjnU39NREi+irwZp9keqWr6Vo6JegegghHCA3q2Z/FHS5WQEj+kpIGMEn29n02XO8mB85m+GbBBvAQE6ZZ4bow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644191; c=relaxed/simple;
	bh=drqwuG2rg6f5mQCt8J5C4kcQtPUIPRXr8XzT/BcONU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e34nZUpI/uJkvEK6xQLKG33z/RsQ4wWVt7dsnkjqRgW2UbMYBjLJYZ9Br0M1O8U2sILF9c3mkyj4Tt4ETb+DVopp/6IRqJ2rLv64NygLR3yRjbHa5OuUtgQIUt88fKZQZvZQKuO3LGfmo5HZcwTYyOE7W4pDBKFCVrV5+FSXOd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Z2NyoFic; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lO1TVvI8ZN8wlv57z5WEeCjzFrhg6U8Yn7qmLlgXh/bK/nuGQYebsqKmIKdt2CstmNWqRMNW/svAMwTe+B92eBzIJQxQumPbHlC40JisoCKbnKJgUeED+j0DY5ADAosNxn4AJmyHR9AdGcpWUCCd7R6MxLB7kWisHs6EDt0Kf/aUb8m1T4MwtGzfouM8WclVRWD8Gssi9hkR5x1bwnfeGwTx9tztpzuQQUSGSgf5WR08g/WeptakV9Zte3kGURmFew81GlDshTGAWBbIo0pKXsdmwg786fuNNFqt35KzY9UU8WqAfN5SeCK3QjAXSbKtuC8pXIr/tNNF/TbjoFFMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7kE91qn3DhHIdjY0//AX+LL2DRch3DMBVm1XwAkxAU=;
 b=ZU274JGAoHLFSe85DNml1XJMDinc2nEW//TokqeiBVNe3sUYZoQqrsxLV7X0n3ilGLfZlxoEZCshgMeauXYKBiXrt/2mBWfXOP3uniSvVoUVLWcMOASJletr1jti0UToU3UBf9NwSxSaidZpEC3N+x/1nh0WuOP7qd7J/c7XlMCjcs8RQDU5P55l9QIL+6LeU5xNfPPekfQIV0dblY0gDnDkgHRdFzKed8ZKh4U2CtbrouPyLeNVzuugUxJmlyzH7W9potULIf4ia6S2CjsxvrmulGA3sgzg2KZQj3eSXpsQqRtirsz88KFGxxjzrUKrUm4+yFncrXqsSnuWeVIHeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7kE91qn3DhHIdjY0//AX+LL2DRch3DMBVm1XwAkxAU=;
 b=Z2NyoFich7kclcn8SUrU4acCIFyPH3RXqZz0way2ZyYFRz0jf+CPYCuoOyNI7Kxx2W1L/DSIGCVknC0fA8MNPS/VH1x9yD+lvRaS4BJ65WCfmn/UDrDEABWKfSCrzQvSqGrx5WF2d+XDgYWtnl1KzK94HVImBquW9TTIvQVXXHJFFhHcSll2deCNg0eBDjd/N9qxB8UJhmhrNX6hA4x9BVeqh/Yjpbp/JYrdQ8rtbcorEB3BLYH5moSj6E3qwNjaaztITPJA987zGd5X/k5vD6MkWtlaWV3/IL49RYvff5DTuayda+Oy3xrxfT0vEkFLHFHW5ghiwBBXhvsNadWSgg==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:07 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:07 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/15] net: enetc: move msg_task and msg_int_name to struct enetc_si
Date: Fri,  5 Jun 2026 14:55:37 +0800
Message-Id: <20260605065550.3038579-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: cb44a6c7-fa0e-425f-5177-08dec2d349ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	aOj5znSX7eXnHuZWBd/5EtzNZeEB2N1lckhnjmnAo3ORwfY+f2QZejD7DVNi43W73phQh3CRLQ+BkvGEHdXFSUQUqgwIFTb7ivhRkhTmeNYNutpcF/JsqlF4mxj5cqD+6z6JQmTtJVJT4nGRjiCK1YjYXPHqLY6icggLj6VUvdHKp7NUDRVs502SNcT1STT2WWveBrxVbtz9mglqLT9jBkRuM7PQZRyBvn/N/j3Q/+VxHZXIDDmHTzJa30IOeF9m/7zhrfd6DhOoPnMsjHMGJbI9ncVsihC6i7YZ/YmxhIAk8oYalMRXivdz5E3X9/VE2E4j1nIK86gthoRg+fa7wJUxJFYJ7m22gYuelKNHOUy68jqD8MCVWGFiH48S5BZtoFFKXs2sKmzWKzNV8QqTk9ulec7xlwxsmTbaQIMPn4agil7i3r53iSsRSX/cm6odTeYsbYxMbL9XxoJq9YRRQd/2XR8OUmFrHLm1g3oBgQle41rzEKU2ZtRzAv4fecGRy2CS0l8x2VA7HC9zUcbDiCNBpjnNtLaSrN9XF6OuxHDeLjPgvL9mXeggypT69Fkrt4gutkiT14+UH5e93X/spC+Y5i9QdhI7O8/ZACh7KdKYY7JtoqRLOrHxEwQYpu1rett7crRosAv/7bDOdb+vstluRxrU8Py6ln7uu36zea5G4W0UyyMLz3DNuRVhecLmFHSiQLl7OR+0Nolt1SasZ/XNnGbSEu+HC4wIieyT220=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OIMK2+QfMzK0TgGLP5EVQ87VXTgaqNTkddvja3HYmNPoA4H5cwMV/OMiUrB5?=
 =?us-ascii?Q?Q8WnvzfPlj4kA55Y6wFxX3l/yICiSUf5oXjjkeLQoNFIhkKlakgvR5fOiXN3?=
 =?us-ascii?Q?6Mnopl9jgo7qLNMlJckce7njVrcWaiIrDtuApqmt83YZS6m56HOBldw5W3Be?=
 =?us-ascii?Q?vnYT0vZ1yh030rqohqvpdRxhux6DN4zaAswGX9bVsSyGvEYi1KfnMEgCrxQE?=
 =?us-ascii?Q?1KSUrukBQV1L+BwIxnN0/degZ7UGnHhn4euZLiOPYvNMywDHUDMdFcuT275b?=
 =?us-ascii?Q?yHOAwDH0ZGYo+QLkd/71OGIUQzfFp0Ng/VnGg5WYcJAOF/qQQ4rJP7UH8YCq?=
 =?us-ascii?Q?w/x5QWk7MAs5XS48mkcw/bkrfTVvpbPR/uCABmAk4p3q270wZPfDVmdcJc2y?=
 =?us-ascii?Q?cPkJAEZS5SQ2Z8Ki8TbFoAjzfORGDrrObwi8aj4JFB8ktIQSUpWVxYpO/5ty?=
 =?us-ascii?Q?RQSkvYYnzH41aR8rwfN5SlxJwSgBuvGwzkmfo6m7EnOSFW5ad9Jiz/SKn4qx?=
 =?us-ascii?Q?YPddVJsWyyQSuNX0d6KkWIovDo1x2j5s3aDMr3z6gAzubQYYoN1xFAdrcIFy?=
 =?us-ascii?Q?LlAM8k1riP192/zGHzNrgHpPe1lYRfeXHUJR3cbJmfOkNdyiRbUXgZQWAYPK?=
 =?us-ascii?Q?zFxaE3Mk8c4xtHMSLc+E7+dy2HmMCzffh+SfB4vR2DgY3hT1UUgO8UyIhyFI?=
 =?us-ascii?Q?JKFdORL/MRo2g4luxbza+OYAz0qcvue5DGjnnpk7Wntvw2LIQXc9oKRx9hxz?=
 =?us-ascii?Q?dmA/ZyppINRUD7CgEo5HAbm3AQ39TwGjFuMc+XFkVC5HzsRPDC8Xm/P98J59?=
 =?us-ascii?Q?mKE/hP3AA2QSZbEPzgFKrvwNXSQVU7cR4oTpDKCljJpadaECs75eetJdvhoO?=
 =?us-ascii?Q?aCzTZlfOyLsrCa9CNJpllGyV1zYGvt+Uy/zLwsUUuqeM/9aEHvCgtava3Rxn?=
 =?us-ascii?Q?bNDwntDydHGLpSc+mJjaSUYg/E3Jnp5JLDdD23fhMTrrZksvPToAq6zfWDi3?=
 =?us-ascii?Q?3OJe4f0mIuiUHYKqPRGAaNe/y599JpSfAhHhsLi/34fxl+FPfi1ewq0bXBzJ?=
 =?us-ascii?Q?izsdoS5kSYB6w62xs6A/t+x6zI3szw/XPZOrcjGHLIatepUYKz/Bo1UllKf2?=
 =?us-ascii?Q?FWvID2FuMijlVGMKMej0YW6lG0WP6S6YnBUrF4ZjGf3EwV5mUVnjcwOJ/G6v?=
 =?us-ascii?Q?arLyAwInr8dfovdOiTQnj3NfwOIPmdpmCeGMW1x/PzGzDMjhogVKgARvbuXM?=
 =?us-ascii?Q?lZn1gak6SsFC+Sd/O598ZIQCFx0fdl8/kO/2gpwgf4prjTbI0cFodb241IGs?=
 =?us-ascii?Q?0QarpGLyMFxSoe1GGISE7hP34ganUkTpp6oODu6KeKkzA9rfjz0+qro5sgF5?=
 =?us-ascii?Q?z0z8PliO6w4WFA9y0pbeC9xA5AZoQw1UPFl4wvDOHkKO6upcyxT9i/BA2z6Q?=
 =?us-ascii?Q?r9aCiJxKk7fe1Tls4zJMjv+obAV/hbY/9MS8bTgAZhMDa8uo4Gy+qtItH7j/?=
 =?us-ascii?Q?4nxNZnUjbYkg1OvvZkneMIVlQfZJuz5Lh8b7mf7QAcV690by63ozXuSec8bX?=
 =?us-ascii?Q?soW8ud6iLYNcs9ItgunVognaA14u6ebZ+kz6yOUa6HKAgLgapH+rCBJ3EKjq?=
 =?us-ascii?Q?hSO+lnQN6SJlr0IgUm/gQI+XqOl6NycJ5A1pUSzMlki6LAdD3y2r671g3efl?=
 =?us-ascii?Q?7fqFvCiFjOXhT+LjvyJMSJ5BUrd+UaZ+u5eezEetyX7nCMV7AiZCO70Tb8IJ?=
 =?us-ascii?Q?aJbIMVGgp33G5NqHdtnMD9VgKveohxu5p2KxGv/KOQvcfnSOttZI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb44a6c7-fa0e-425f-5177-08dec2d349ff
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:07.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaYR/QlqVHfjqs+S72Set0HgfS73N4GaB1I5xhoAbyf9QeJtmognR0dxppTVOA+cHHSDBVDjAExuhPlVk26D+n5oz58HTUAMQ/qb8FxaJRzqTAnMMFL14JcwC8eNlOPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295684-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74577645F57

From: Wei Fang <wei.fang@nxp.com>

The ENETC PF currently uses msg_task and msg_int_name in struct enetc_pf
to handle VSI-to-PSI mailbox messages via a workqueue and a dedicated
interrupt.

PSI-to-VSI message support will be added to the VF driver, which will
require the same mechanism: a message interrupt and a workqueue handler.
Since struct enetc_si is the common structure shared between PF and VF,
move msg_task and msg_int_name from struct enetc_pf to struct enetc_si
to allow both drivers to use them without duplication.

Also relocate the ENETC_INT_NAME_MAX macro definition ahead of struct
enetc_si so it can be used for the msg_int_name array declaration.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  5 ++++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 19 ++++++++++---------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 ---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 04a5dd5ea6c7..2cd035773aca 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -25,6 +25,7 @@
 #define ENETC_CBD_DATA_MEM_ALIGN 64
 
 #define ENETC_MADDR_HASH_TBL_SZ	64
+#define ENETC_INT_NAME_MAX	(IFNAMSIZ + 8)
 
 enum enetc_mac_addr_type {UC, MC, MADDR_TYPE};
 
@@ -328,6 +329,9 @@ struct enetc_si {
 	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
+
+	struct work_struct msg_task;
+	char msg_int_name[ENETC_INT_NAME_MAX];
 };
 
 #define ENETC_SI_ALIGN	32
@@ -369,7 +373,6 @@ static inline bool enetc_is_pseudo_mac(struct enetc_si *si)
 }
 
 #define ENETC_MAX_NUM_TXQS	8
-#define ENETC_INT_NAME_MAX	(IFNAMSIZ + 8)
 
 struct enetc_int_vector {
 	void __iomem *rbier;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 156333ef26bf..8d4d0689807d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -37,7 +37,7 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	struct enetc_pf *pf = enetc_si_priv(si);
 
 	enetc_msg_disable_mr_int(pf);
-	schedule_work(&pf->msg_task);
+	schedule_work(&si->msg_task);
 
 	return IRQ_HANDLED;
 }
@@ -215,12 +215,13 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 
 static void enetc_msg_task(struct work_struct *work)
 {
-	struct enetc_pf *pf = container_of(work, struct enetc_pf, msg_task);
-	u32 mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
-	struct enetc_hw *hw = &pf->si->hw;
-	u32 mr_status;
+	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
+	struct enetc_pf *pf = enetc_si_priv(si);
+	struct enetc_hw *hw = &si->hw;
+	u32 mr_status, mr_mask;
 	int i;
 
+	mr_mask = ENETC_PSIMR_MASK(pf->num_vfs);
 	mr_status = (enetc_rd(hw, ENETC_PSIMSGRR) & mr_mask) |
 		    (enetc_rd(hw, ENETC_PSIIDR) & mr_mask);
 	if (!mr_status)
@@ -303,13 +304,13 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	}
 
 	/* initialize PSI mailbox */
-	INIT_WORK(&pf->msg_task, enetc_msg_task);
+	INIT_WORK(&si->msg_task, enetc_msg_task);
 
 	/* register message passing interrupt handler */
-	snprintf(pf->msg_int_name, sizeof(pf->msg_int_name), "%s-vfmsg",
+	snprintf(si->msg_int_name, sizeof(si->msg_int_name), "%s-vfmsg",
 		 si->ndev->name);
 	vector = pci_irq_vector(si->pdev, ENETC_SI_INT_IDX);
-	err = request_irq(vector, enetc_msg_psi_msix, 0, pf->msg_int_name, si);
+	err = request_irq(vector, enetc_msg_psi_msix, 0, si->msg_int_name, si);
 	if (err) {
 		dev_err(&si->pdev->dev,
 			"PSI messaging: request_irq() failed!\n");
@@ -342,7 +343,7 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	/* de-register message passing interrupt handler */
 	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 
-	cancel_work_sync(&pf->msg_task);
+	cancel_work_sync(&si->msg_task);
 
 	/* MR interrupts may be re-enabled by workqueue */
 	enetc_msg_disable_mr_int(pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index eb977da2be71..07bb9aab89aa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -43,10 +43,7 @@ struct enetc_pf {
 	struct enetc_vf_state *vf_state;
 
 	struct enetc_mac_filter mac_filter[MADDR_TYPE];
-
 	struct enetc_msg_swbd *rxmsg;
-	struct work_struct msg_task;
-	char msg_int_name[ENETC_INT_NAME_MAX];
 
 	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
-- 
2.34.1


