Return-Path: <netdev+bounces-137881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7159AA48D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830131C217AE
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA401A01CC;
	Tue, 22 Oct 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="dCfVThR4"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E339919F40E
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604653; cv=fail; b=VNCe1ApPHvYGIXCPkjUn0YE9D9qEAaX6dXtrEnUmM+kHD37N7EJPFQ2wsNcdngT2burKI7Gj7iS4yPE76MrHxFc4kA8iTQosAFrIlijvxySHJQWlf/7rWIDwRfbxeg264pWd2giNeIQ/Q7LFK4hl9NsVpiK8c4NTwJYVXUncfSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604653; c=relaxed/simple;
	bh=Y+lnkF8Ve+oTlSHG5xFuCthjiO7GIaGyaQcjdB9ch/A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qISW5Xl4ZM8MI/oCHWFQAJnXvTolu9E3Ea9+kgMowrESuiZ2oSjAQwHKuukupnH2dD9gu6dPMa7Jyk1h4wDpPGDi1Rnf4KtuqEzSbMLD09oItLEMk3NQ3iCwxRTfLkHcFM/moqU2UKNk0fqyBv9z59LhjpZe2S+tTTK9QN/JfCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=dCfVThR4; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 747B934065A
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:44:10 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03lp2239.outbound.protection.outlook.com [104.47.51.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 366F1200058;
	Tue, 22 Oct 2024 13:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5Pdv9i54TB+x44920twLdl6URg0nEvZU8n41Di2Gx8LiuETyrPehLt02KSxYVuIbBW5phVuD3ZtmwJuJb9LV/6UBPvXtp3pS539+y7jLVDFtLw4vBvRRDDVl7vOnpUlALfS4ZvETkvXkr5TOMdSgF4Gn7QtKQ+Jwa950OAPr9qeSGnSbPsFftAw4XQ6c/rQp30BBn1+J2HAeFHqEcgAFpaBw12eLzjfAyziGIQe+rxM5BB1WBpXfRFWHFSiZxFswPVG4pQ7g6Y0LG/z3kB2R4E+hr/Ldg0x43q9Ouo8oBUCgbJtmmMH7fxS5qFRu4hTKGIynY6mxN3ssmDkJ2Pz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vS1sCcx1vulNQRGkxZjg3vZRSvrG5RUNHXaL7zukBM=;
 b=dWC8odFPlIclVAI6TAvPYyuvXuC48az8whBDV7/YKkN9b8BknY+sxNHycsxBRjMfoOVhqQn0h6Fjhn+bTpi3qXEUZttdULbVXP1+e0Q8o2t8z+PqSBc3bPPCTnyaSD4Q2fgRkvs8rIfO2B1TZPL23ObVk53UHaqOYOl8iTxQ+2kpEwpvoaCHeGbPlz1GOHNI0rTfSjXrIsC/RAT57DMMB5Hzis0VnZEitIfXdWXhHMD6oi2p5g20WpeniXW30AtVqIFGGMRTHipEBRqqOhClcIjIwFnG8NteSYuMq9sf8TvZIf6eoXNgoFYgmqOSgbJ1K4zy5wdyD563t4MPmQK6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vS1sCcx1vulNQRGkxZjg3vZRSvrG5RUNHXaL7zukBM=;
 b=dCfVThR4E63G7SwMxgBMBScnlG115iZKVg5jQdjDQELeWA40IiwzaFAKtx2zayJ1v7VPAlNy3udZsuzBy+PBNnmQ7kr1E8YXjtzAB60fpiMs/U13zhKIREkjElT7ci14BFA1da3/VjvjwhFf78jMEiKxco9KI2g8QGlXqc5wFyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9077.eurprd08.prod.outlook.com (2603:10a6:10:471::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:43:51 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:43:51 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v7 0/6] neighbour: Improve neigh_flush_dev performance
Date: Tue, 22 Oct 2024 13:43:35 +0000
Message-ID: <20241022134343.3354111-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
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
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 805aa6c7-eca4-41a6-a13c-08dcf29f904a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wfyoX9Ql/9QvNVrTlFPCIzOuaUYw9MjeC7D3isHJDp77Ve8Otvu8NanMZk1i?=
 =?us-ascii?Q?KC55l5bMuL52T2EWCR0UF5cA9wCFenWKEeNPLC0xJOsrb72nkN7ONGo0QQ3K?=
 =?us-ascii?Q?S4QFAAXs/NoMyZChVRZPqOiwbtLUbAPXUyA2Lg+NOmr4XUJeohNebYO3AUuD?=
 =?us-ascii?Q?Ak+XIvsd+Ic6MUsdpA6u+pn0SUmjIJkM1LRR7kIDYZs+SIRNXncFap9gukvS?=
 =?us-ascii?Q?l7l5r91mOUOhqfToRjS/vlbKvayCpNOVnk7h7qGxm3IheCtsvsUdJ1AeX3RW?=
 =?us-ascii?Q?3p8ck2ssomh+g/G3TEQnana4W2LQuxrZANWTTJW5VMp/WYSG6pFI7rJ2xndl?=
 =?us-ascii?Q?virc1ICmR/7QikYSh9cnKlTuut2QQodYmIXjXMPdA4p9z1u6+OSAaPE9bnh3?=
 =?us-ascii?Q?cijJQkP0ZQEaYO1SR4ufUnUz7JCPg5ZSBNKMBI53qMtdIDV4niZXTmkZ7MAR?=
 =?us-ascii?Q?926XLAP1uTtQfLe1laZy5mXbGVaM7DBe2ObzZI+YKtDs0InGTq54bWyw5azU?=
 =?us-ascii?Q?mXrz8immz1uMCdI6L6IHqhVSvupA7IGyw12rTJZeq6CJcmapgfGv46oXyWPc?=
 =?us-ascii?Q?x3t0ZskDgfzSDPAIDNG8yLTuBjRt85gS9mCtiHrGm+14mUXsGpeu8YtDehoP?=
 =?us-ascii?Q?JJNJtu0Ze0K1JVhvNpj6wgAVOnpq0HTfY9HTRGgap1WGS1nBBF2QjeqgTPOP?=
 =?us-ascii?Q?UW/8kTYAk/auV4kOgdfW1ecGydutw4xrGY2VOZQx2N57ivZflLsxsPQVqRIj?=
 =?us-ascii?Q?769ZKS+SUaSN9BX30dBi2c3ObsnEnN+YaFfvYxLK3iydHnPDHKZ7tgRdTCiO?=
 =?us-ascii?Q?CqweZq7D19/PgrWEaDEgPc6Kly4C3n8Pvh0lS7iwED98i7Cg/hU6nhE/a0Bq?=
 =?us-ascii?Q?8VR9gh6zjcQKj2i8qAdorG0FDjRIuLYdQcDJiiUQSPbvArp3hHUeMCgoQOSP?=
 =?us-ascii?Q?x3NxHTxN2/IBVAVeszOyIVfVLsEy8d2AWnnk/yGy0Hz/7vy+haCH5p11v3/u?=
 =?us-ascii?Q?CKQspf3Rtf9dCA0/UohIBVH2BXSUPo1PymKX6o+Qpc5s+YFylbZHB4LCvwuA?=
 =?us-ascii?Q?aSBTo/7ZylgcDjy11iAzfHU91O0sgz0skP+ylEE9Uto8fLP85P1y1uFflwdz?=
 =?us-ascii?Q?UGZvrJrGJX/14VDq6RkA9RrTy9dv+XMeBhEN+gaPHm/0yS+WMonv8yifl2OM?=
 =?us-ascii?Q?t4HycAoX1gTWCfg35F9zYCMLqyGOi2xlkWkHrM7aaCpck7NBxYUvwBhDk9ZR?=
 =?us-ascii?Q?RdnA8I1sMVs52wCFOzI2tNT117BCUmbBQ/LWYQkgchJavw5RwaV3c9p7U798?=
 =?us-ascii?Q?ZCT7znHGQZ9XFAJEe1FrJqd6AVZ6c4gqcTDmDsLEBeaOx3fYsqyEO5SpzhTj?=
 =?us-ascii?Q?LYBBkN8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RGkuGQshpaKBSzjU7WDR2NL5hQVxcKs1sNxos2dpGz1DwW3Yb7A6pW6ADJWs?=
 =?us-ascii?Q?0VEukr3QDbyy4GTcuI/CifrhR74FJ0j8hbDu1nQaWK9dO+l6jesluWFPC+yv?=
 =?us-ascii?Q?Cr2x+hKry4sH3Bmw5+invn3T+8/0nLxRfvJkIK1+FFLwhsnK/lrdhTprOaHb?=
 =?us-ascii?Q?0PyvpNNQezBUunVMyRhZQrZ72HMR2mVNJsVGqMIzsFi67KlVG3HRPeoXatJM?=
 =?us-ascii?Q?6eFcDJrQA0K9qvvYWyrQQxiYbJxeU43HMPSXTnj7nakLGaelmMUqtHJ5NG0g?=
 =?us-ascii?Q?Nj9f6IJptu1WmQOkVav+tPw4qSI/VR5LeH8wppxxCgMXm8s2/Xf7mtCS/TCt?=
 =?us-ascii?Q?+Ly3oHjC7mNivGe4asP9Ki6g+eChsjfC0T70pcVzAW5KMhuqDWfJeHUn9idj?=
 =?us-ascii?Q?3pYmmf+aPqMenLPEOw4QBV4/H899FkOTvRvkLfqGaZbur5eyxjLH2rT+C63R?=
 =?us-ascii?Q?zyjcJi7AwALnP8gdgORkXXcPVk51+rlCJjHnkxCggu9A0bGdGjL9jkSXeHik?=
 =?us-ascii?Q?BcoupQp/8RVUP8UICgYGGf8ulpbSkdI0cDylzvslXITVX3/8dSVp1dxFx+ez?=
 =?us-ascii?Q?EUwScdQU/QVmsOzn/3oivCJZGREecC+NsC1uihfefWkjkjSq7wOy190G43C9?=
 =?us-ascii?Q?nI486dtNHPEdMgXylmvGPrAWRtm3BHtAe1CktWWZVCGx3tnpbg/BidyrH8Q2?=
 =?us-ascii?Q?WjkgKqdQ1CkMhlQ5yc8tMohBRV5NJkhjhrDaz3gEnJD3pyFXWLLu1dp3hmD3?=
 =?us-ascii?Q?TvVaaP5FPdS0QVaKOzK9JFOBaHFP8KPKUfJIzhYDEOBFCkOfpvf+p7ABsEZI?=
 =?us-ascii?Q?BNPmkQi/FEHEJ8wLoOmW0cTLL8fCq7w0QLJNmglg9KENBhv08js9pj/dCjTo?=
 =?us-ascii?Q?EkJRtwc+2jpHWdfaDOzgiR6XB64f9BJ0rgCBukdfQcRzubWs+GKt1j0e17x8?=
 =?us-ascii?Q?Fb+PydrdD/jZ4aIB6PTzxvMJ7s/oGysa8mEU1MLzKowt8F7XP2yi7yZRNUgf?=
 =?us-ascii?Q?DCFOsGf0WI83m38+BF1BnR9GVYNek7mgCdcpiVu5l7FeJ1neIPrw52V6V+Pd?=
 =?us-ascii?Q?fZS+dL2S72TdX87sVIAwxrwhMZMZMowQd1x9ZsBh7X/+zkbaQeDwf9XP28xr?=
 =?us-ascii?Q?wwBb+5We/8DfJjN/TifxWWYth2HVjNcbGXOySWZRmNEM5crg15qQAdtf5kXV?=
 =?us-ascii?Q?Anp0IChaqtK35HmVyoh9N27+teSbgnp+eZ8ESXJVgO5w1VQUgx3dGOT814EP?=
 =?us-ascii?Q?7zCipLPHBqU+PP5huUINGa7WRfI0RLRrhC1W5Z3ncYiRIARZDg+SpAX0OXou?=
 =?us-ascii?Q?EYX3rUPLeQCNuiaeUbK7DtgadJ+0wsf2zZBL5FPgyO/XY3z+OuPhKab/yVLs?=
 =?us-ascii?Q?j1p4yrJvRE5k5RY+m6QrXkQBU+u7Kfd2ZHJn7uQRsZ2GUtzmDSuvKu/XyKSD?=
 =?us-ascii?Q?IyFtMFW8KGQGetwkqWCcfyushlNPYFkbbAFtBBuNMT2R+ESR3FJI0PuzGuhf?=
 =?us-ascii?Q?sKR1njppajK+XNxctWErVpqrK2KBX1t699Aes40iq8yunSbnutaYvuSmkub3?=
 =?us-ascii?Q?F/k1yvM8mdmbZsaxdOJNMcVwgdS0Orj0aOkfoxha?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JHh0Eg5asxx1R7V4seF5f4LiWklkmJM/9kkh7fKLEVRKwyEk73aXBxV5E/+bCIzGTfQT9Bbhg8vJ1b3XgiBhRpMJwyhMczc7v35zxyF1WBK+RjS7tdImlFORXlq0GsTFgt23gdR5Ej6t8Q9XXXOXRwvL6WphcpgUp0yJ9H+j82/TpyAkZJIxdqk9Gq8Z+ipefEtVMD66d9+WVAGciZwNbuflqDzcQkI2ey97fWufILI0vldt5omrL6nC7HhfYUG7NG20QoEvmgrErhRS2U6xe0H96t80h5AzTYylvMuIUpkwBB0/MIn2WEO67rAw338Uc9yJ75d1poFGa1P8HagF78AmSK/OD9towaOlIFLFuR7Jy2Lrk8tev1bYXlxAn+t6bhE4lI3+TpYwSlMay1jc5BWjKKLKP5Jgxzbh/uvg3RSfFyVeethDGvwVXL4joEASHhjZpF8NEQ749M9XzpHKeG33nOlCnoc6opA3jDScZuKF4pNcMDe/ETGaYkZ+Bn8VAXj5Z9LPA9C3mFD0fXpPkaHEkSp4ecBzG2RThR041VjeaZWWjHeraryaBqD+KUP5/jXp2eMLLjPbP6U2C8zLA2qSsD/WguORNdd2grmvppHAALbzzyxHcjCNVeJK+9SR
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805aa6c7-eca4-41a6-a13c-08dcf29f904a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:43:51.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5Zv9fJmlGad64U0TSvCgljIJhMMTXOOHwsC+0UDEw8Sfq/50S0Tws/9Ty5o5umtP/hhmhNE47+R1+Rpxmkw1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9077
X-MDID: 1729604642-1mFG9iPNUuRm
X-MDID-O:
 eu1;ams;1729604642;1mFG9iPNUuRm;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

This patchsets improves the performance of neigh_flush_dev.

Currently, the only way to implement it requires traversing
all neighbours known to the kernel, across all network-namespaces.

This means that some flows are slowed down as a function of neighbour-scale,
even if the specific link they're handling has little to no neighbours.

In order to solve this, this patchset adds a netdev->neighbours list,
as well as making the original linked-list doubly-, so that it is
possible to unlink neighbours without traversing the hash-bucket to
obtain the previous neighbour.

The original use-case we encountered was mass-deletion of links (12K
VLANs) while there are 50K ARPs and 50K NDPs in the system; though the
slowdowns would also appear when the links are set down.

Changes in v7:

 - Fix crash due to use of poisoned hlist_node
 - Apply samx-tree formatting

Gilad Naaman (6):
  neighbour: Add hlist_node to struct neighbour
  neighbour: Define neigh_for_each_in_bucket
  neighbour: Convert seq_file functions to use hlist
  neighbour: Convert iteration to use hlist+macro
  neighbour: Remove bare neighbour::next pointer
  neighbour: Create netdev->neighbour association

 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   7 +
 include/net/neighbour.h                       |  24 +-
 include/net/neighbour_tables.h                |  12 +
 net/core/neighbour.c                          | 337 ++++++++----------
 net/ipv4/arp.c                                |   2 +-
 6 files changed, 174 insertions(+), 209 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

-- 
2.46.0


