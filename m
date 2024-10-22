Return-Path: <netdev+bounces-137876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A79AA434
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5A31C212A9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E4019EED4;
	Tue, 22 Oct 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="YDo+/ZlO"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC319E97A
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604651; cv=fail; b=g26tJMEASVSHWIqWnowdnyQWVn1l72ngXP1O0Of3WO1uHW6cdFyjSBQBbpTCQwUInwfQpmyZgPvbx0k3hYDRxfiwHrF8pO9FLU0iwivigFK5nbgNsNdyx9YFZSjqH4mPhXGd+t3I7wSnl0IBff3eXtrLxu+lCH/FyTXCCsOoW04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604651; c=relaxed/simple;
	bh=Zo4lWdC90BiUcyHjNrZkCXVRKTCz8HIVW2bMI+t6ZRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFhhi3mCYoC2TS2wK3LQQ2RaHsQ8OI+7A0odz3tKdH5nkaI2/XW7kjo9MERDS0/0MjrLw78g/sNHISJuHhl3B2SwHdg1F4CSrKCDDaBLSzTpzTAbIpM0zephtkoJjWROJoQbMeeni4L0TfPWI2CfaWTWU9TOpJ7WXmbaCGB7uL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=YDo+/ZlO; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 489BF480065;
	Tue, 22 Oct 2024 13:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3geVBIqvgSvXhx1p2qzmLaRmVPwmTuy01nhbXx2E7nFxFfOCW8Ge8Gg6qVHolxUJfPJJ6GsObyTypsUFoiuUxmwVjdU86Iirg8rzlmbVyeCgb2WVMk0haGtOENaFBOytxVCbGlq3qRfRKmNMottkT2NzvcL81NLSi5nr1oJ63RNJgQCkt6Il/dnHGRhtdSG3t82bOymmSsFs/NSowKaX/lSTVFFED6cQA4Vfk56IofEb4DmbD188o9cob1tozaReYKbGvsfhuZvM/F3pBGV5PeFMnVb87cb4eOnwTHHOvL3XrKNtB47ns5pUA5ktfXJzBVhP9ysdhMs3hB2bCReGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHp/unJ4ay0NEuM5eBhoP6ZDDlzcKP5aZQ9HI9wX2Go=;
 b=H3FVeoXjxcb3PpaG95y7spiFoLg4LbvyB7UMTfDT5fznVAKKNGVg0DaMndda5xiK/V21Wf59+Hl/lJKlCuuWS59wOWeQLacGptniiZas62dIal8kEqcFGUw7UaHrIet0xykcz4o04VLIbcKc2hh2QVEYctNUUESvsfiGW9SBimgZ8UXIlTbf0zLZaQwga4jFNHKnAoHCOGQ5Kjb7a+hs5Nd4+euWl2NljKR2fO7DAiq4iGkEj6Y6A6GVBAG1DDN/vE1aZ+zRwTEWN/YmpdGfA50acmZgfA6s4lvlBs4EMA497jbzr6Vyz00LTI+3Ik4W16xo9m9y4SuSIxnrcG24DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHp/unJ4ay0NEuM5eBhoP6ZDDlzcKP5aZQ9HI9wX2Go=;
 b=YDo+/ZlO/CKIGOc1RbZ8FA/5ZDyBf77Q/qAycyQo81gBvgJCPb6RGe9pLL7mWAMVNTTVjtIJPFpKzLu1BSR18tLuHHMBYqqTCM2GVfYLT3h1Xt3jIxLwTHbbP8FXXCSYW62kdrm+FZxoAidnntXZG8yT1YZKlMX0vtaHFzEXQ5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by GV2PR08MB9928.eurprd08.prod.outlook.com (2603:10a6:150:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:43:56 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:43:56 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v7 4/6] neighbour: Convert iteration to use hlist+macro
Date: Tue, 22 Oct 2024 13:43:39 +0000
Message-ID: <20241022134343.3354111-5-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241022134343.3354111-1-gnaaman@drivenets.com>
References: <20241022134343.3354111-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0192.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::36) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|GV2PR08MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ea71a3-f3fd-4640-4d2a-08dcf29f931e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?atRNM2jMYISi4o9qTHrgzs2nkb/7gcO3JORlxLgv6idut1cTxvl8uV/y6VcS?=
 =?us-ascii?Q?EVq1hs9ycQ6GNK08Oed0cwNoaozLm00K0OdunTheP5fXtNtmBcJhuAs0gs1W?=
 =?us-ascii?Q?GCQwVx5/KcnHamtj9Tfh5s9aFFyHfG2HzdBcISqRIcRqIpV5LTMPu+DYsP8I?=
 =?us-ascii?Q?2LpqQyMFpCQWGcbt3OwrENowMaCxksl8X+ADpZjFSiucBwlKOcoBbECRbCAb?=
 =?us-ascii?Q?/ZJbt19JcMZP4jdleZOMloPqYEXsxn2iw+ZjSUpcp8mSuWVBedGWhNVDy5Z4?=
 =?us-ascii?Q?PjDhYDzGaMC5tmArTNVYSwtVHVGmq1Pr0WbBVN0xMs1vN1KZ/oUdPJd+I0j8?=
 =?us-ascii?Q?aJMC/+gOUeG8IkHrqTZDYB7286IWWf7KcIwGgLxC2hPMJAs2Y1vn9093wJs/?=
 =?us-ascii?Q?1VYcs6dcBvwE9aoXSb+uz7pswJFGKOIytPzcfa3omw5qLtaoK+Kt4V0dFDHt?=
 =?us-ascii?Q?tKgsQhq5LdobhkEwOZid+/aYQ6UqQOG1Vh+xJZqcdCJDU/lrSTMISzyBjuRv?=
 =?us-ascii?Q?6c/u5gC/MoFn9mxRqj4sMSEYvrtgGJH3/1AEnS2/+mlzpySDaGD7mqwPrfIy?=
 =?us-ascii?Q?10dpd/kNFigKsh7kU8Iv8xZnjYoXxqtEB5vTe08zpUF+TZumQ2c++Q6MWb2k?=
 =?us-ascii?Q?Ah9PttrbjUufyNtnAHP/w8bykbidtsCvs+/1Mc0c7VcLffB76pRAI4F69hWI?=
 =?us-ascii?Q?MeTSit85ZN1A9JDgbEF/na0nzRWm0sr0ZcXcTDSR0YQuVPmT3R5rQvO1hydt?=
 =?us-ascii?Q?Tay/0GPf73GuWMbRO5kQL7AMl6UsslvTpzryc7DwNwGv4db9VECkSeLeKumJ?=
 =?us-ascii?Q?8nztLjUib4A6kcUQyxtPrTMV23duqv5L8hzRr7xuxga4W9Qwa9vqSTCuRdWm?=
 =?us-ascii?Q?5Ogz+ZuUSNPESXZ3yfArqyJbpy2q9eGdGRDGNC32rtp0iBZd+7/Y2huj5GQv?=
 =?us-ascii?Q?pLpQVNylCA2osIzBxa5dyFh61OqzjfU6cK8r6dODjTdixSh16ReMuTYXgjmj?=
 =?us-ascii?Q?do/M5DHdGhV0MUa/88/qyb4hnIF1obaZuVEp95boJrlfpVf48XdUpps0J94c?=
 =?us-ascii?Q?qBIBjhyBNFJ+vxmf9KFruI384UMhXgLuVFhUVQpgyW1TaXgOhDm5a6fcFJKT?=
 =?us-ascii?Q?vzRV7om95VeOYDqyef2nMoF9n93JUXbVqQoJ51nEZKVtSYnF4ewejXH56HHV?=
 =?us-ascii?Q?SCI4pqoVqD/8+t8BUVWyO2/8uoUBZYg2iIgTZ2ab8TzbTps1a1b28bTKNx/W?=
 =?us-ascii?Q?hjHqmYTGp6aXBisnQ/OQoa/Jw4pJTPWmZVi4CUlPv7ARYXQvlcdcrHmFUiic?=
 =?us-ascii?Q?Yw6epL/d4QZQdSgJMYMlsJoDPQloSDOsFfvUb9yDpVkuo0T8ntZbS6thmtrb?=
 =?us-ascii?Q?ZqtX2Ps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mT8/yp/6cG8lLb1bsXaMIb1iuE/JyO4C6/Zz8Uia1dpb6o6zF45QJpEWIsLv?=
 =?us-ascii?Q?/nFmhtwprAhFYr5VBXxX6lnQbySepb6K04MM213Q/jNMYpUPkbGW9uezOrih?=
 =?us-ascii?Q?YpKlDTFqbeU89qzQ5Zxq0OxFoQj0IUiZOVEEVOgNVZIESHLBxdJ4U3JluIwR?=
 =?us-ascii?Q?b0sCUMqYs5atq2FlfGKtxzLMJXxYFaduaaZy1NYOX4e3a38MgwrTdHRmUlTz?=
 =?us-ascii?Q?7vmaP40RJD5d3ZsZkKT8tj+PA749pGKMVD1NzwE+cgaeM/4K9lLcPGtYljA4?=
 =?us-ascii?Q?H/n2BsG3wii46ArXUjlIfjKKgHtIG/pueWPR4J0os8Cp+zMcs4NBdwnLwItg?=
 =?us-ascii?Q?/SBeudG9n+uvK4/CwW5nk/dkkpfVHTaveqvLN1PRh0n1KE99AVIExDgkPehx?=
 =?us-ascii?Q?fXUEPCyMIlgcHQ6uEOujwkoEp1UXdGXP2suwvdiCqa1V+ehdU7EatgvedfRe?=
 =?us-ascii?Q?B3Vvf44rcNtbN04D2Hj30HfSrnfjaelUxqMIW1jRNuknypghE3yf9ZwJIZ8x?=
 =?us-ascii?Q?eUJG631jwnWY1jHMxHUTdv9BI4HzW6Z7yY3WuC5VxjWCvULCopDWXJUYJO4q?=
 =?us-ascii?Q?eJmyeCpt9Sys4uhxVT+uNb7iarVOUL1yPb6oYDNQGgZzDfZiKG7BZIKr/8Uy?=
 =?us-ascii?Q?9xaJyFtrwE2FZzMStZbkpvVSKJtF8HqJNs8Z1vw48Zt1qdpHrH+uuUEgVi9W?=
 =?us-ascii?Q?+q/Wut/JFFnZ3tgyPuAq1OWGdo39lZMfddx4BVWgr0ZIREFr1nQR/7PeM0Ot?=
 =?us-ascii?Q?s28nJN6GfxWf4VO081kWkPvKkiPLF3kqQM4SNCPcBx8L6mlwPhawfX3dN5Wy?=
 =?us-ascii?Q?kQ44oCPVJ68F6Vtt6sUmnQg3BHnFoPCuGjv51QTdeNJvf5cIs46FrPaZcUc7?=
 =?us-ascii?Q?Dp+0iOeDZqwc6D8ZAB44p300WXluQn1LGlxtH+wPajJu8avpybE8Uu3jske8?=
 =?us-ascii?Q?e/O48e2+CZ2ypqbkT9AxhZ8It2UcAHJEVDDFc9MXUouYHwXC32gEUahem4x5?=
 =?us-ascii?Q?9Ke5xyOsBWd2/m9n5HtR3oiIh9TDzkhX+EsNt7nDwfEkTbQKpykjvtQ3eSoC?=
 =?us-ascii?Q?0PDevMv2XCjAX8ytdqQ3blASHU2CoIBEKeTzj8ZHMFA6EMIcX2cP24yg1PmG?=
 =?us-ascii?Q?1KU1dv1mnLfiT+8LOIlr+X/K4qwNJEHpSJevbr5r/VOUq1epwiUsSJWEX/fI?=
 =?us-ascii?Q?v1audBn2yVu/5Bq75Ng3KrQTVaL556GLynqd+/JUnSa5BXfmmvqa0n6rfypB?=
 =?us-ascii?Q?4GY0uy5YFz/F24K5+FQJvGXpttU6u6dLAaGPUzGaiy6CfzVU6G4UdP7a5Cxs?=
 =?us-ascii?Q?nZj4W3sEdi+gSKQHmz8c217f8Nn9OINcGaV98qRCqNLhJBcLGZ3EhESu+s+5?=
 =?us-ascii?Q?PpeKpvHYdp7KEQQtF8NsxeUUGi4uhx6GpfT7KQ9eg1SaWlx7NOgE5ElJmWTF?=
 =?us-ascii?Q?ECoGqqe8Hz0orn95AEDtwrnuThD3Q3BTwWIeAMq/2/ugcW9zwM5DEo9hCccD?=
 =?us-ascii?Q?0nLAML1LbfAGibATNuew/1vCSVRTaKKlu2aWy+jiR+6dj4URGYdEUvjSRif5?=
 =?us-ascii?Q?DmyqjGq4b3OcBEfd4zJHFJo1xzHa7mod05RKS8vI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kzxC18TYhjniV/ciPhQh3PAS2YsJZJavd0OrIsdoeIjzBHnD35AE/LPiab+ZZ2xsFFebOXvGqokhVOvsBI6ka3V2KoqS2Ckd93QibhNEbEOPYDtdvbfI+k7EmJkhcWWKbf1C+kLQNbZpoadZFICpPGZT17FEvmHoHk1sLXFHBmCIbsbbcuWGucY5SxLc4YEffQuE+SXCCdfKrlQpbkb9L9Qx4PcrdGSZGK6Vn/0iLoh11rbv5jAkYBXUeeiFHKtA2bQET7dBvjmFodtTHGzqb/efb6ioi5/VuxKYvnXAUDBRJzVJ42b1gSySu2fdUHis6nzVFsPOXQ5SCeH3PWqTegtlTdAClaEOGPn1c90+TWVhQe9MG8a5RV774mmF22Xc+drXJFr4fQrFRckTGIj0Yc4jg4MNdTBoz0fRUQ3805GoXW6Q5s9cTfXBbc+t2V/gNkgJ710VNPMxdabPlUdf9cFKCqvJoCyR7/7gt37Et9lYoPwYi8QQxv+yt0Xr4u49v+qNsZy9qlCFZ2jvh8RTNBGX+nt+0tKZNr9krZGa06idpKA549tiCzUna4vULl/AQR0eV2xeVmL+8OI9uTyGCIEq9ZUfmz8MAMAo22y196HLhPfsknTk8U8wF4CrO1ky
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ea71a3-f3fd-4640-4d2a-08dcf29f931e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:43:56.2938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huMRhTvtzH47gKUN0UDknPhjJvkZow0VUlmOQhnpcnAN1yTL9vawKkKeKtCltug8pKl/rqcsVtKoaOV293Ev4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9928
X-MDID: 1729604642-Rt5JxVeV5kXi
X-MDID-O:
 eu1;ams;1729604642;Rt5JxVeV5kXi;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove all usage of the bare neighbour::next pointer,
replacing them with neighbour::hash and its for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  5 +----
 net/core/neighbour.c    | 47 ++++++++++++++++-------------------------
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 69aaacd1419f..68b1970d9045 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -309,12 +309,9 @@ static inline struct neighbour *___neigh_lookup_noref(
 	u32 hash_val;
 
 	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
-	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
-	     n != NULL;
-	     n = rcu_dereference(n->next)) {
+	neigh_for_each_in_bucket(n, &nht->hash_heads[hash_val])
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
-	}
 
 	return NULL;
 }
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 80bb1eef7edf..e2f7699693f0 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -388,11 +388,11 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					lockdep_is_held(&tbl->lock));
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour *n;
 		struct neighbour __rcu **np = &nht->hash_buckets[i];
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			if (dev && n->dev != dev) {
 				np = &n->next;
 				continue;
@@ -620,18 +620,14 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 		return old_nht;
 
 	for (i = 0; i < (1 << old_nht->hash_shift); i++) {
-		struct neighbour *n, *next;
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
-		for (n = rcu_dereference_protected(old_nht->hash_buckets[i],
-						   lockdep_is_held(&tbl->lock));
-		     n != NULL;
-		     n = next) {
+		neigh_for_each_in_bucket_safe(n, tmp, &old_nht->hash_heads[i]) {
 			hash = tbl->hash(n->primary_key, n->dev,
 					 new_nht->hash_rnd);
 
 			hash >>= (32 - new_nht->hash_shift);
-			next = rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock));
 
 			rcu_assign_pointer(n->next,
 					   rcu_dereference_protected(
@@ -726,11 +722,7 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		goto out_tbl_unlock;
 	}
 
-	for (n1 = rcu_dereference_protected(nht->hash_buckets[hash_val],
-					    lockdep_is_held(&tbl->lock));
-	     n1 != NULL;
-	     n1 = rcu_dereference_protected(n1->next,
-			lockdep_is_held(&tbl->lock))) {
+	neigh_for_each_in_bucket(n1, &nht->hash_heads[hash_val]) {
 		if (dev == n1->dev && !memcmp(n1->primary_key, n->primary_key, key_len)) {
 			if (want_ref)
 				neigh_hold(n1);
@@ -982,10 +974,11 @@ static void neigh_connect(struct neighbour *neigh)
 static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
-	struct neighbour *n;
+	struct neigh_hash_table *nht;
 	struct neighbour __rcu **np;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 	unsigned int i;
-	struct neigh_hash_table *nht;
 
 	NEIGH_CACHE_STAT_INC(tbl, periodic_gc_runs);
 
@@ -1012,8 +1005,7 @@ static void neigh_periodic_work(struct work_struct *work)
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
 		np = &nht->hash_buckets[i];
 
-		while ((n = rcu_dereference_protected(*np,
-				lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
 
 			write_lock(&n->lock);
@@ -2763,9 +2755,8 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
 	for (h = s_h; h < (1 << nht->hash_shift); h++) {
 		if (h > s_h)
 			s_idx = 0;
-		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
-		     n != NULL;
-		     n = rcu_dereference(n->next)) {
+		idx = 0;
+		neigh_for_each_in_bucket(n, &nht->hash_heads[h]) {
 			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
 				goto next;
 			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||
@@ -3132,9 +3123,7 @@ void neigh_for_each(struct neigh_table *tbl, void (*cb)(struct neighbour *, void
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
 		struct neighbour *n;
 
-		for (n = rcu_dereference(nht->hash_buckets[chain]);
-		     n != NULL;
-		     n = rcu_dereference(n->next))
+		neigh_for_each_in_bucket(n, &nht->hash_heads[chain])
 			cb(n, cookie);
 	}
 	read_unlock_bh(&tbl->lock);
@@ -3146,18 +3135,18 @@ EXPORT_SYMBOL(neigh_for_each);
 void __neigh_for_each_release(struct neigh_table *tbl,
 			      int (*cb)(struct neighbour *))
 {
-	int chain;
 	struct neigh_hash_table *nht;
+	int chain;
 
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct neighbour *n;
 		struct neighbour __rcu **np;
+		struct hlist_node *tmp;
+		struct neighbour *n;
 
 		np = &nht->hash_buckets[chain];
-		while ((n = rcu_dereference_protected(*np,
-					lockdep_is_held(&tbl->lock))) != NULL) {
+		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
-- 
2.46.0


