Return-Path: <netdev+bounces-149499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE79E5CF4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7600167D96
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF02C224AFE;
	Thu,  5 Dec 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="L9xCbrRd"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB10224AFB
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419231; cv=fail; b=DH8SXNty2FgWHN9x/VZ9AM1tW00f8xdh/bDO9zydqkCzYiWKi75HKq5E/waYVY0eqhODWeeCE687zmbBc7DVXheR+LRKZsDljWmiO5RoS7U3NuZ1cOE9VoOCjEXwTAgBD/CcToxUwSufn9VuorH/apOfXHZuSOdFGrqifRwNHS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419231; c=relaxed/simple;
	bh=0yoooPkGov1rEm0QfPb+5DfsZ35XHtpxMi1AhemcLgk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sOqGnyk61JpSSeim+NLcL8m3DVNv90QRKRdpXy3Zl0ZpP744zwai9zvsck3NDaRDkAghimfgN2ccCTKeTQ2GSmE3xnrVZAvBC7ZFDBOljM4nlQMNKhy0zVrNn6SEzve31Fja6nAWhXHhzu2XnFCwrXaJ0xZSN+/Ci7PDVe/Xwkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=L9xCbrRd; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D9CC7342940
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 17:13:21 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp17012031.outbound.protection.outlook.com [40.93.64.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 74E731C0062;
	Thu,  5 Dec 2024 17:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/ByceVXpjHbdJgWVBLNzxnT5Vtb0Yg1042ZHghUsBbzE2r19tpKm50cP5HBEmrXaer+MZCfto2YqaI9MmNXIvzL1ABfUZbQAl1n8cOMQ/u+sKJxgEB2IeZ/4qN5zSPOwJiIrTYR/sQv15YKq+6uTscAHaTKHiZlxESmIaBuQzokaGauZcI17EgCAIxFW98cpdcgfb7MeZ6/0A4EvfR/ubbLTJ86Uj79PSKW7YZy27j7ZdHBfMENoVoUZoaWTXVAaNbgPO4bI6HdEfCjxkjCEvBWG39G9jErwOftofixMn5372yt4xqYvi0/SxJqUuTJ1/vg5t0UUDbe6BH52b81zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq3RCU1QH7duiIUmDru6xFZasGiCtRtq1AgLmGPcICw=;
 b=El8al7wTltP0uB/24PPLDcrDdPZvHNt64dyXfrLh81+fLBXxgl+d2iCaeKQasjNV5iiN5A8ynAKzIwWpnmwuKu0xAYJlVeabZ9ggos0pDbhRM/sU98GLwKZdgdtkja0HP7j1Kqy3hfptoj0OhWtb0qEYLRET74+somilQtvUeyYKojvzQjjoMJF6JlNGIK1M6CFQVxKoSG3ZZ/K5mNc/z6yP2Jq+p5kDli7Cbrfh9ZaAXuBJsRk2QPPhvIN+8rvClpJdA4j0WGLK89LmDcLKJPgfHhv5mNzwi2/ZWLrJBTqep98uKgLWNZrnlB9LgQcPwpCYoPndx0KthI4N/q34BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq3RCU1QH7duiIUmDru6xFZasGiCtRtq1AgLmGPcICw=;
 b=L9xCbrRdbN3GpyM46KufYbWjw/5LR3W+ODe4EnDRVgXYaX3tzJ1WTi1DXnnyAmDM9LTmQ4BICPXjfNnntxZjCQCbmeMDgSK95Xgi0dFliP+eh5/TNRyEiCqS++iW0jIVBIM1W+98mNwM4DXwcNa7rbSr0iVsw6+ktdv5mcKRu4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by PAWPR08MB10120.eurprd08.prod.outlook.com (2603:10a6:102:365::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 17:13:05 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 17:13:05 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v2] Do not invoke addrconf_verify_rtnl unnecessarily
Date: Thu,  5 Dec 2024 17:12:47 +0000
Message-Id: <20241205171248.3958156-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::7) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|PAWPR08MB10120:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af1fef8-abbb-435e-683f-08dd15501538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cPCdYxufBVPI3wEQeBW1/V3SJ/0iOsbNu2LL4nQ2i7URwFhX66ERHbqt/91x?=
 =?us-ascii?Q?mikXaSJugFTkQ4+zJgWPLftCdZP4lDhXT3Md5ncTNKiog6T9TezXbDfGiNTR?=
 =?us-ascii?Q?cENrIXhOPqJorBnQpW0U7N9wVO8LbDGHfM6r73Y/tlxqpeFmVrSnEhdpFNqX?=
 =?us-ascii?Q?1Q0imE3Tkjew7KZhqM989bZyHEKrwWASVcRnPnQNVvKWw7GIOxd+Z6sUUqYs?=
 =?us-ascii?Q?bbBxeC1YqLdF/iWRnfUZlHNi1Nvk9LzTf+zv48Cm1IczjvJ3ptlvhASAdntt?=
 =?us-ascii?Q?t/CB/N6bSyjbn1js1PLGQUgUiALUrt6Ou7OnSm/BFcMiRTiGxxSZRvXkfn8I?=
 =?us-ascii?Q?shYQkCgFGaUa16+TBHTljCZbRiEy51cUiExhB0sl3fz4iDmSPkF2KPcesAyZ?=
 =?us-ascii?Q?n331LE7rmuDyu9Bf1WSQFh3w7sAcN8gY8IdSr2hwA+qBnEw+g5lHjWX1VFZk?=
 =?us-ascii?Q?7IyuRtg0T9jWWk8HAqCvzXkuO8pRlcUFu+zB+WRJurx9brleBf5+I51niveN?=
 =?us-ascii?Q?dYi3LaPsfbcdZTVVMUgUEENIAQlj8hvCD2qS3qkH17nNFKvJvORlqnDW2jp9?=
 =?us-ascii?Q?8TaQ+udLCb6Z8Ujr6KQqB8esDpv1KTy9N05BdKtr9bEQx+5O9cG43628RnvB?=
 =?us-ascii?Q?8XwoEfI4BXPM0zAd8Ll0KHeijsGmm0HqsMVthuaqHCBexlsFjdxjPPI6aS4U?=
 =?us-ascii?Q?G8vPBMos6zJwSaz++1s+Expnx0WlYJ/PQES4h0hubkCP/x5hxgy8hfzrIGcd?=
 =?us-ascii?Q?vsaPBbvrFQ8Skb46AWn0O4vIwQK3+oWfH+uckFCf0V99F6LlxKQ4AwcDfVQ1?=
 =?us-ascii?Q?W5ICKHpyDRcX5EpmhWgqqPxIcHzPeaOtM+gbc43ULR9TIeA7TpIkaT7mGmrU?=
 =?us-ascii?Q?27nXevpU7cSnpuD7NObn/X+xin8vLJyRd+unXZPN7f3rmJl1SF+J4yVeCMIm?=
 =?us-ascii?Q?m4wxTKQXoFhQqrzKr6Mt9Xbv1N4UvGBdbj5HC/ojHDG5B2/0ja6NMldDiCsN?=
 =?us-ascii?Q?I1+SyA+OiHJMdkfK0Ekonnkffvg7kR44qzFNI4mXOMq0voRf2p4+zgVvOnzS?=
 =?us-ascii?Q?ifilMkQAqcj+eFGTV+3EJCmd7hdISlVhJevwzzZ6U/HYYMirkAkITsTAdZ1U?=
 =?us-ascii?Q?y66D7upYMV7Vh7jJb4ECEF76bowwYDw/QG2u/VBlD2t1/Pg5UTXZmQUIo20j?=
 =?us-ascii?Q?fkavTtNWnTJfqZN2ehW/UOnjRuagL6YPkMU3pkqaCCzEdlP36z6ySDETOK2A?=
 =?us-ascii?Q?6SWwpRdF21CMarg3QisHcIb3ffOB6+EBUufTb/AcGtpm1BKcDUm0llwqJWLO?=
 =?us-ascii?Q?JjKZPNMam9lRZHejY7rylBJz5qiI6YCoZn9guIAVkIAses5yFbb5Lvb5ZGF4?=
 =?us-ascii?Q?pxwBpBMT6qULLJqB0H0IuwTtTTg1lPaRDxgi+mIm/VQU3WVNZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?peWid1VXC7YR8lD5cVevevJ5hN+z8idpsj6R2zbdrN3B9tH8nLV+FZjPX+dU?=
 =?us-ascii?Q?MUJJoOFYtd1Yp1MNBe+PNHIG8ObhTmHLJit2wEYVMX3R/d+yihQgae6YQtym?=
 =?us-ascii?Q?yA4N46+vVdpFYG9kH8Bloe26pCn+dGayFxoUporwQ9vxJ7UX1Hh8SUxiN5j1?=
 =?us-ascii?Q?FZ98sSIYnzX8mtYLDLaWesfQxyTAPe8C3Ji+zkoRwVh1MOBj6EKJ6Hb0p2TN?=
 =?us-ascii?Q?r12yyLNxHL4ApYPbWymnJmutwdoXOWpkTJtw1ssZVI1rXKZzh8tT82IBZLLp?=
 =?us-ascii?Q?16+wF9HLIzc+fPQzUimFUPNFWrzw0Vld9mmF1xMOIOrn3MD/JoeY2dtuKK57?=
 =?us-ascii?Q?7JBQlXhnw0TqTbVEYAIqs1KPO/cxrtDBF6dk86UcRdwqmRh4VjqwycFk5HHg?=
 =?us-ascii?Q?fkjofBW5Py8xGBNM0+CsM7dCYysVfbTkFFlXANPIgZsdr2I56CB3m+gYSnJ0?=
 =?us-ascii?Q?QtU/UsHcJcIkk7VtyLbGK6eGurAxBPIAHQ4Gzhnir/sPjg2h1xtaEu8x7Cil?=
 =?us-ascii?Q?9J0doj9ROJrgcpKjTxqsTgbLc49WZTrGqEpxyzOZ2o1Fb3Pfxj2XO0LG8OmX?=
 =?us-ascii?Q?e0Yke5EySlGPjjoL1qk0TSf3M28i7fvQt7sKr7r3Acw+A1cH4DuynZfNCf2u?=
 =?us-ascii?Q?QYs4hrhU6cqTa1+WIz1JJzbtvxbNHqPXwBAmlboVZ0Iz57v9XgvreS6OR7OJ?=
 =?us-ascii?Q?pNUIuurayj76Fw2Z+hqobJg6mnRHWynmBrVpEVAnOWfbKMzvyPhfrQFO+GjG?=
 =?us-ascii?Q?+v/GiZSoDHZUaa0uzHdNahpaAwDqRTM8SDaHzJpA2tUZHTTCWXgGRVIeFeNI?=
 =?us-ascii?Q?+vsP+nC0mj8BXJZ6PLx2JjLMr27eGb1jtQrva9v3ksPysNbbdHSRB3k/jAD8?=
 =?us-ascii?Q?JaTqCwr3xhYM2DSBN5rOQbrrj2nXMgBjGCaqB3KunX4lIujXQ5aBdXZJikH9?=
 =?us-ascii?Q?J0vPm+E1aWudqd8nThfFVZEN4vhqDG1TZuZ+qYuYhNxB1dvRhtqC7t8UfQuo?=
 =?us-ascii?Q?3+TeiQfFp2RZOh0PUyO5L29eOFATKGan/ju7sL4SxF2S6X4lzPMkK0sSeJct?=
 =?us-ascii?Q?vGk79mZRSdQcmNxNsJcSm8gzD7U6JBoeXLHjPX5RLj/b69WLTU6aXckc4qAB?=
 =?us-ascii?Q?1aZyi/fa+IU5c+OaQEBSoUlN2hGE0FmFb59fchE5JbwVWi6NpIyX1kAdzm7P?=
 =?us-ascii?Q?u44Wf6KFFCCCGqq6jD4w493KuORsH+4GYc+4B0+K54oeAJT0MIaGiDG4LGah?=
 =?us-ascii?Q?GNqJUHcgN2FCnXxrlHWJlCokJ8prDCdhbU+fbteZyanbAQUQHe2tQkGIXcRp?=
 =?us-ascii?Q?Z3FPOsYWsaOyBxUJr0d8Vu8psQZoCbkTOQrWivcJBHIeH35TXoGDEf/toZrP?=
 =?us-ascii?Q?L0b9HZ28JsuNfRTiCRaoXKPscuS/9ajkJ4VEsdnwjgcpv+Q4ntNWMDvy7+AJ?=
 =?us-ascii?Q?H2zQ2ltBopReT1yepj5FtTpR3QI2xXNdn/QHvcDvoxiaxPu0/2C7LkIe2QDM?=
 =?us-ascii?Q?0t9Yi9BcLRdVweRwob7G9BmEMdIkT4gdB5hgtYAYhCmZV1rtqBs93Z48cb+O?=
 =?us-ascii?Q?IkVNJR1epdjbL+CThgTknG2Olit2JnscNgsWoAMsrntSc6zZlMwYLLDLS0bR?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i6eR3fzeg6i1nWe6sn8nozh4nLIbeJEhSxsT6O6bgMiqbCWHYrIPYaBHhoSCwhE7I3LWZcNiav5luAL3Wdn2mA7MipKuZBrKb/T8bpB0nrGKdED7JqoAUc1QKxq/MhgA0TYMdTrCQkTYQELrvLuSL3bz7tqeBttbakBaOj5ubL0Cy2HNpudAoihYPpZnWEdYDpxp343rhUCaRZvhnk0Ue4F99mj24gPYxwHck6ZiLVzlU/gBGHqLLMYpjBwzTzOnhBrJHGzsRdoDdH9TLrRx/Y+QUINnd42OzLHz4/Q0NxQse8H6JC3rnA/HkvJmH/MFFcqDKviqqUldqO6uBfDkhMN1g/zbZ1p3vft8Gf7CIpwk9w3/SXPHrDTI40ySu1WdUmYyC6TiLbNsXOwk4JHBell9IM5Wsxv1CMbPHiESZkD5rNvrM7Nhg+Mm4/NTm6Fpm5aZigjlSrkSh+G+yo0u2HWjK+Yvg9UBUKT1AlOYq/PJz/2ro6QcxZ1CEssxSQWUeMj5fx1ugE9XCB5zhYqmuSHT+FsZ8eqAb+g+rX4OqhEFuMV3pBWYH9xxeU5e2Q0riL8AY37pyPSgA1woRlSkdYy7OqEQapl6enFusVxyudq1bDSrKcV1cwvvDucbEior
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af1fef8-abbb-435e-683f-08dd15501538
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:13:05.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYw3uBARmUgDINjW+8JMB7U7ZwOJ51sAbuVsgjZK4QlXIaTDtsplZUo4Qsm0FSRNR4UaDKByjENXnCN5FG3FGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10120
X-MDID: 1733418793-D0g8dDL5seBc
X-MDID-O:
 eu1;ams;1733418793;D0g8dDL5seBc;<gnaaman@drivenets.com>;489d0494e21146abff88c0d96984588f
X-PPE-TRUSTED: V=1;DIR=OUT;

Do not invoke costly `addrconf_verify_rtnl` if the added address
wouldn't need it, or affect the delayed_work timer.

For new/modified addresses, call "verify" only if added address has an
expiration, or if any temporary address was created.

This is done to account for a case where the new expiration time might
be sooner than the current delayed_work's expiration.

For deleted addresses, avoid calling verify at all:

If the address being deleted is not perishable, and thus does not affect
the delayed_work expiration, there is not point in going over the entire
table.

If the address IS perishable, but is not the soonest-to-be-expired
address, calling "verify" would not change the expiration, and would be
a very expensive nop.

If the address IS perishable, and IS the soonest-to-be-expired address,
calling or not-calling "verify" for a single address deletion is
equivalent in cost.

But calling "verify" immediately will result in a performance hit when
deleting many addresses.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 net/ipv6/addrconf.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c489a1e6aec9..893502787554 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -310,6 +310,16 @@ static inline bool addrconf_link_ready(const struct net_device *dev)
 	return netif_oper_up(dev) && !qdisc_tx_is_noop(dev);
 }
 
+static inline bool addrconf_perishable(int ifa_flags, u32 prefered_lft)
+{
+	/* When setting preferred_lft to a value not zero or
+	 * infinity, while valid_lft is infinity
+	 * IFA_F_PERMANENT has a non-infinity life time.
+	 */
+	return !((ifa_flags & IFA_F_PERMANENT) &&
+		(prefered_lft == INFINITY_LIFE_TIME));
+}
+
 static void addrconf_del_rs_timer(struct inet6_dev *idev)
 {
 	if (del_timer(&idev->rs_timer))
@@ -3090,8 +3100,7 @@ static int inet6_addr_add(struct net *net, int ifindex,
 		 */
 		if (!(ifp->flags & (IFA_F_OPTIMISTIC | IFA_F_NODAD)))
 			ipv6_ifa_notify(0, ifp);
-		/*
-		 * Note that section 3.1 of RFC 4429 indicates
+		/* Note that section 3.1 of RFC 4429 indicates
 		 * that the Optimistic flag should not be set for
 		 * manually configured addresses
 		 */
@@ -3100,7 +3109,14 @@ static int inet6_addr_add(struct net *net, int ifindex,
 			manage_tempaddrs(idev, ifp, cfg->valid_lft,
 					 cfg->preferred_lft, true, jiffies);
 		in6_ifa_put(ifp);
-		addrconf_verify_rtnl(net);
+
+		/* Verify only if it's possible that adding this address
+		 * may modify the worker expiration time.
+		 */
+		if ((cfg->ifa_flags & IFA_F_MANAGETEMPADDR) ||
+		    addrconf_perishable(cfg->ifa_flags, cfg->preferred_lft))
+			addrconf_verify_rtnl(net);
+
 		return 0;
 	} else if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
 		ipv6_mc_config(net->ipv6.mc_autojoin_sk, false,
@@ -3148,7 +3164,6 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
 			    (ifp->flags & IFA_F_MANAGETEMPADDR))
 				delete_tempaddrs(idev, ifp);
 
-			addrconf_verify_rtnl(net);
 			if (ipv6_addr_is_multicast(pfx)) {
 				ipv6_mc_config(net->ipv6.mc_autojoin_sk,
 					       false, pfx, dev->ifindex);
@@ -4645,12 +4660,7 @@ static void addrconf_verify_rtnl(struct net *net)
 		hlist_for_each_entry_rcu_bh(ifp, &net->ipv6.inet6_addr_lst[i], addr_lst) {
 			unsigned long age;
 
-			/* When setting preferred_lft to a value not zero or
-			 * infinity, while valid_lft is infinity
-			 * IFA_F_PERMANENT has a non-infinity life time.
-			 */
-			if ((ifp->flags & IFA_F_PERMANENT) &&
-			    (ifp->prefered_lft == INFINITY_LIFE_TIME))
+			if (!addrconf_perishable(ifp->flags, ifp->prefered_lft))
 				continue;
 
 			spin_lock(&ifp->lock);
@@ -4979,7 +4989,9 @@ static int inet6_addr_modify(struct net *net, struct inet6_ifaddr *ifp,
 					 jiffies);
 	}
 
-	addrconf_verify_rtnl(net);
+	if (was_managetempaddr ||
+	    addrconf_perishable(cfg->ifa_flags, cfg->preferred_lft))
+		addrconf_verify_rtnl(net);
 
 	return 0;
 }
-- 
2.34.1


