Return-Path: <netdev+bounces-142896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E4B9C0ACD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A323B23281
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D145215C7E;
	Thu,  7 Nov 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="FIEM/RnW"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37541215F6E
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995520; cv=fail; b=AjpdWeIXK7rieD2nWfoxAQBd9OARMtXoayawLFbaV+ygHDweEQ9CzhW130dwHf2J8IQ4Xqx7ctn7IwX3ldJHIHfzT51wNXbh9gaBOSJ0jIYIPD249V0fWbNixe7y15y3TTpQBSoJJIh+LI1u6J1JgIkmTcXQn7LiRQZNCNqzb4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995520; c=relaxed/simple;
	bh=LbUnsF6+cSEKF8WJE0dSdqYPxwxIglpSCavQdi8vcos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIKjt9A0mSarYp3bVr2Z9+8MAvLod/0m1gPp/ki7sct1J9NigUOR674nQfisAz2miluTF+2fqX6iGjOYNaF4ZbbxYf1Lz3IatQZg96V9DtkHVtiK2gMif7YbYz3PUNgrhAa5VWSPPx6M+Cdp46CuF+xdVxwwZZV5uPJFN/20QbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=FIEM/RnW; arc=fail smtp.client-ip=185.183.29.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BCFD21C0056;
	Thu,  7 Nov 2024 16:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7LIRJEVfUJY4Fat/9ZFRhS1+itmmeHctefF49yV8MkZkNrsr1DApkAMWraQ9uqplgr67WvdNgwdBc0p/zyYU6bo/V1m+YnavYJqX0HlmQ7srgIrLplHMo8tsNvRSg06Pw96+CnEskeKlJ737B3gDmIkl1dw9b7UotU1Zi52YIpjSYDCw33RG/0Cw562HYjxYTGHqv7crCV9p8O3P2esLQpmP9woCSO0EiJ9gn9qhFoByKQG62fKy96kc20XGOj7L0YgbXsG+I3WHQbAR0KKQe8XhYwnVxCU+Q+mvEtHftAYeTKmVLHimctSJ1N89DBhkKOQYrpt3t03Pjn80Vjggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RnCufkdkU39jH7/GK0/s+YLEM+e/LYbD9PDDHP91bQ=;
 b=Cl2mi8pbYcD71zHhZNmzoDnfrF5gUx8p2/UqaDEASzZ2/MpGUsgJaTrxxBNDVmI0t2VQzPcW0ybF3EfUf5BmDf8KEHhI7iBp+pWnl7WragVD309fpc+BjVcUCmNfkyaMVg4zS24VSwSVINW72+eVeOo094qDDFxmczH1/HQhs1VjPMeqVJP/L59SBDnfXHthzZpHYc7YA3nhtKvj9S8n0J1Cj1+iZJeinfQQrMwj6pxCFeRy17emDQP2p2drBVCA3xqN5rfsFDWvc5r+1Xqr4T5Mxa3mISbaDYECG/PV+IW96aXE2Mfi3Xre1nmV43CfxfFl0CAzI7StX5ZIPkVGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RnCufkdkU39jH7/GK0/s+YLEM+e/LYbD9PDDHP91bQ=;
 b=FIEM/RnWGB3eE0MGjGevRq17slt0DSUi4jtXCwDE9obJg7au7EHXfarzFG0MlhGGMXW2hsABTiA6DZQ9H5W80CSR6P8/09zCob7OY41HJgHNb4fn6cMKDv6VUtHN9NVybiT1diuw0gjjXuoCaZpece9wuYg2s8YKWgvdKYN+dww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS2PR08MB9296.eurprd08.prod.outlook.com (2603:10a6:20b:598::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 16:05:08 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:05:07 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v9 5/6] neighbour: Remove bare neighbour::next pointer
Date: Thu,  7 Nov 2024 16:04:42 +0000
Message-Id: <20241107160444.2913124-6-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107160444.2913124-1-gnaaman@drivenets.com>
References: <20241107160444.2913124-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::13) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS2PR08MB9296:EE_
X-MS-Office365-Filtering-Correlation-Id: 26260af8-845c-4602-b8a9-08dcff45f332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1yiJc+WjDSD934PTaj7ZPjkZDwvSSohUvtpcfywtHqTecgEbVBjhBO6Nghz?=
 =?us-ascii?Q?aknlYGlUvTo0rkPWRY99EJiHBfk7FMsBdqvsZcsOrD/XajQFLwpc74pd2sKR?=
 =?us-ascii?Q?jYxUFGfRO0n8hAfLEQPuC1W1YZHKP+CIt3PWH4U7yI7neMjZOxSl94g//mtD?=
 =?us-ascii?Q?QX8TKLFF3h2s51ApDucX35zrx6eWWGxsM5+xR8G9vIfpL/veR6jISRR0/jZk?=
 =?us-ascii?Q?ouu284OU/5DNpzRfeK/XCzE/xFyXD4O5i4sT/rNG7OtSUD4fk7Dm8c7Ht/NX?=
 =?us-ascii?Q?xd78m895tOaM7MNjkpcfrxQBUuT4PSIxsQh6l/c5UczyIyPJuHo5XgEPEX+H?=
 =?us-ascii?Q?7Si5REue0xvxgkp3mZOLZy0yILo5ZWLd15QAtIs8lnBBz6ZTACOI6MAFyNVz?=
 =?us-ascii?Q?idnQsbVufZ29UNdV/a+uYYe4Sjzr247PJAYwEMrPeqp7OnEg52kIy7KAkO2D?=
 =?us-ascii?Q?Lp/ojfhqzxitEazJG15ABNsN/Vy01EyYWXsXx2OnwoCGAilfQ+9RshAhQiOZ?=
 =?us-ascii?Q?oivo9uYF9A8XT0VoLG2Q7/ASKRaFJaxvGViDX/0ofJJuTt2KXeLozw51yBq5?=
 =?us-ascii?Q?imYk+IdzbGo1FbV61SxyuP9dvV43drCTm3FrdcjuaEt21858T3b83rdjgdpq?=
 =?us-ascii?Q?1uG+VDdPMMj3Gqqel5D6E6HDG1cYOpb+tusNAmwWGfRf7RIBDGSQeZkcshW2?=
 =?us-ascii?Q?HqIRmb5Hp0XTF31evaaAmJOe9lFh9yjdXtoMiF2h6QlF2FRp4Bt6jeKJICqq?=
 =?us-ascii?Q?i4aQIA0XkTYkpfyz0uxfnFQk27Vv8tUK/avSAuWZN4OiG2vgU8t3/CWi58EJ?=
 =?us-ascii?Q?Z3/FMn789nOq92zJ9rahf4wgVboRiO4hn6yzsxsPjClI3wmUvHggUzbp824P?=
 =?us-ascii?Q?2twwEBvCOosyCM+fHHhQM228JGFwTv0Bvy8InxQe9aVdSr46ZW6oyTuFBVZS?=
 =?us-ascii?Q?Y4pX/DVEandMjKv/mzRfjjXaLiW7DJvSWZTTKjKNJdxDvBKsXpp7M7wUCiQW?=
 =?us-ascii?Q?3WxPJc94ZwdRWr5dZ3skAsNsEjIXgUXivtsqAoxVf8TqQ4duxhgi5o2r0/zV?=
 =?us-ascii?Q?uY5Kr5cyfSrV7MbjhEPFuPHmU5Dpt2yEVqlKFASC7qOT0AZEw0ZeNIA9mavQ?=
 =?us-ascii?Q?gjx7qJqkZ2E7O/5BBiFF9DXGRUoWTkqgbC00VG7/L3It2elIWLDFNIbWeSpY?=
 =?us-ascii?Q?l/9bbxTyVwBQx5bPWGAxNg+a/3a7l6uBnA2wQP4GrWUDyIxSejTVXloVYhwj?=
 =?us-ascii?Q?Vit2WSpHRCHLCkUuCw3yBAXHTlkZyQjbpC0HwGxHCYghiVxVrOXofv9ho//d?=
 =?us-ascii?Q?3FRifKvn8M+eVKdON7c2WM/7q7Q6P+ZYiWaE3jaHK61gC4aSUvTpBoezvNEL?=
 =?us-ascii?Q?V4xz1YU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EOYlhf6lTHi7Q6cZ+Oy9in8jq7Wmf7FPnKFW5L3ZH2pPU4B1bvmhoDnFyU3D?=
 =?us-ascii?Q?G1G03AkbvE+32zW3tBjor3Yfu1SFAbfDuz/Od4YPjJsNAgAMAZZ6Rue43beE?=
 =?us-ascii?Q?YgzzpunCxnE/nDOkdx0tdyob7l4wxmr4wDOD+YQYOJ5aEyXOwxCUlHYfY5El?=
 =?us-ascii?Q?Lfjw7oVkZsxOw18dm3fCJQZFz5hG53sp33s19AyUWIN+Tzh+eBSvhYM1yQG4?=
 =?us-ascii?Q?u3qUts2Cwvx1J26/TMuLTNrnAa+TtArj+1x7SptsPtNd0pDN6b2Rs0YWyag1?=
 =?us-ascii?Q?bFq0QBrNnQgJ+QlNTZ8ChKb/eGGWr0UlLejAn9zAT3q5FdS1f+ZHFo54Fwbv?=
 =?us-ascii?Q?ZduVjzq3HZx70JtE7gIXc0hI4Y0EGJijLsFjly2UxBei0DisQ8ZHc93jsPqt?=
 =?us-ascii?Q?D+gUyopCi5GlPRVypOfcwuZ5wbUyFzKbCS582GE2CLmyBB5p0fktPYmcyOm8?=
 =?us-ascii?Q?Wwqdl/PmIPqkgTxkbW1OitGhpNE+kYj/MBrEHRjI79q5VoQU5a+2ApwCmVcq?=
 =?us-ascii?Q?ehhg3gdbuTFsyljMKNeoMmvChv8UQJpFugo4rFkpA7bC0r4dIvAvtfw7SChD?=
 =?us-ascii?Q?ub3R5Coe2Y3KZA/bS3Ww34IgoE+B0AoYuCv5AI2kznlto7fgDc1KURFIgavT?=
 =?us-ascii?Q?A80HF3MBbSXOk9Ebr9korjyM5O01VD5bkJoAnkxwxYdFOUaTlUnYNDChLAb8?=
 =?us-ascii?Q?OLUSe6M+aDBx24UyYEjC5s/YlyKx4WSPRx8wgTp7h+yOhxC/mpMXcs/HiPzX?=
 =?us-ascii?Q?knSFenqKeoHpnP3B4fX2g2QBbI/rVTfmy/FX4Sda0WUKaXLLsN07yM/RFIwW?=
 =?us-ascii?Q?dRmHYYtvXP4lHTEoFSe2qHUZqQ9Dzk1B3eTeQLAE/8Ou2IojwQ/vBnIE093m?=
 =?us-ascii?Q?6OhVtjknAf5wqsmIjT4sTt+3WQHvISQExpVcTWoviFha75iDPE17oM+9TfNZ?=
 =?us-ascii?Q?CcO5LJkk/K+EzdLNwwe64/64OKANusXEDJvrnTan3gyqXCbYs0IZnjQVfQm0?=
 =?us-ascii?Q?BOmxq6zorwmfF8I+Ssr+0tsjH0OiuvbVQDdNnsNX4YnYc+ijX/B3erZt7PXq?=
 =?us-ascii?Q?FZD88/BLJf8YeNJSaWFQwZNRm89+4gtLfzUlljGGPsCK8rZc1T2R2SrMUyF+?=
 =?us-ascii?Q?5yTLf0cAi/jTrLW8KHwNkKskwApCXSL3R5qWzsqOkqrs6pxb2H0qyt7WQ2pL?=
 =?us-ascii?Q?klOI1FwHITCF3Pz8d4oKxZkYGsT+7rjo8lF+cvBUa6hjQ/BP3Qu+AAvnPzl6?=
 =?us-ascii?Q?bk6zd9L8qjF4YbI6MZ4GfBzG2/Duz8RXud1yuyti6fLu/S4KFKwxmx3LPsot?=
 =?us-ascii?Q?8RQWibbZoKRIaZR2uDRoJdxNfV4PfempnNRSIjr456snVoTiXcIECcCJEMoc?=
 =?us-ascii?Q?Pn4n54Guy/DzaHbIxPd4YlVa8rZC8psFjPBZUQ0ph4gpoV4/H4QTIcv2UuZx?=
 =?us-ascii?Q?b+nCszzpWHOrBJ9IvSK3FabcrSbLsRrxfaYVTdC94ZVKVR77lNh9WoIEkhRu?=
 =?us-ascii?Q?3QjjEITRomAoQ6VKMLotIrKX64eEXNLMzfPab+yM9u7g0EGoajU4ol2e7N0u?=
 =?us-ascii?Q?euoDAs6UaLPNHNfUh2qlFjVpmvu/ieDD5x05KuEr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VLkSZtIAD0KFAcUXs3XDZFtorjy6jlN4RReZBMGjupjl+Ps1EZQl8TNDOwOu0cDlHwxMLqZBPidLnuRHE7ydL7yu3ECh/9hrO2ALV1H75EqKUpfnU4NqnfT/B0FkY7jgPkGecPbISyjTP1QT2SMuZCyB1tCufZfqLRBQQNarXLilvhRjIDtLC0+O1sAJU4gDFGYJj2V3HgqP+reEDylVEsPROBfVtpLXKRLwrUrh8gC2XYFXWZexdhX+OLXaKg1lphPjXCWSAoi8KR1wAbqkb23qZ4sOawul3Lz5J5lnOZix5sBRZ/2V+CXrpPvFDbOPYb6Af2TxbpHB4ikZjAsoUvlfbc1HiQuW+ckh9I7c5Ibqu4fcr0AinQvqMMe3vz6vaXByVNzB9OgZlPFnpremzJVrVp4wLtjeFv3HPY4aaK0eUVnPguY9HtTuUOpALxQyDL/623k5FqnrAxq96wr3Z9Pu1r6OdoFDPqBTrkuc4Pm/NuIAf91NtsY/exCyfh4Dkv5wtlnDjngHGP5nFLDhuR2WbfWFerQm3LcC+F8JcWQK3hIj998TMCH+Bh1huEYqorqEIKdaMWopkobtPBXPZpq/I6Qc5ZMmXb0f8SeaZrSQpBt6al2Zj2cgf6V8HmQY
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26260af8-845c-4602-b8a9-08dcff45f332
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:05:07.9284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6YC+HqPx+a8/w/B12EjbaRfLOIL3zAnr1vMirYkLITlKN4lgqZh8V/I1eOoo4Zsy5OAf3N/Ol/AZm6c+tRqHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9296
X-MDID: 1730995510-eohI4hK2qLR1
X-MDID-O:
 eu1;ams;1730995510;eohI4hK2qLR1;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Remove the now-unused neighbour::next pointer, leaving struct neighbour
solely with the hlist_node implementation.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/neighbour.h |  4 +-
 net/core/neighbour.c    | 90 +++++------------------------------------
 net/ipv4/arp.c          |  2 +-
 3 files changed, 12 insertions(+), 84 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 94cf4f8c118f..40aac1e24c68 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -135,7 +135,6 @@ struct neigh_statistics {
 #define NEIGH_CACHE_STAT_INC(tbl, field) this_cpu_inc((tbl)->stats->field)
 
 struct neighbour {
-	struct neighbour __rcu	*next;
 	struct hlist_node	hash;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
@@ -191,7 +190,6 @@ struct pneigh_entry {
 #define NEIGH_NUM_HASH_RND	4
 
 struct neigh_hash_table {
-	struct neighbour __rcu	**hash_buckets;
 	struct hlist_head	*hash_heads;
 	unsigned int		hash_shift;
 	__u32			hash_rnd[NEIGH_NUM_HASH_RND];
@@ -354,7 +352,7 @@ int __neigh_event_send(struct neighbour *neigh, struct sk_buff *skb,
 int neigh_update(struct neighbour *neigh, const u8 *lladdr, u8 new, u32 flags,
 		 u32 nlmsg_pid);
 void __neigh_set_probe_once(struct neighbour *neigh);
-bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl);
+bool neigh_remove_one(struct neighbour *ndel);
 void neigh_changeaddr(struct neigh_table *tbl, struct net_device *dev);
 int neigh_ifdown(struct neigh_table *tbl, struct net_device *dev);
 int neigh_carrier_down(struct neigh_table *tbl, struct net_device *dev);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index f99354d768c2..59f359c7b5e3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -204,18 +204,12 @@ static void neigh_update_flags(struct neighbour *neigh, u32 flags, int *notify,
 	}
 }
 
-static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
-		      struct neigh_table *tbl)
+bool neigh_remove_one(struct neighbour *n)
 {
 	bool retval = false;
 
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
-		struct neighbour *neigh;
-
-		neigh = rcu_dereference_protected(n->next,
-						  lockdep_is_held(&tbl->lock));
-		rcu_assign_pointer(*np, neigh);
 		hlist_del_rcu(&n->hash);
 		neigh_mark_dead(n);
 		retval = true;
@@ -226,29 +220,6 @@ static bool neigh_del(struct neighbour *n, struct neighbour __rcu **np,
 	return retval;
 }
 
-bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
-{
-	struct neigh_hash_table *nht;
-	void *pkey = ndel->primary_key;
-	u32 hash_val;
-	struct neighbour *n;
-	struct neighbour __rcu **np;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
-	hash_val = tbl->hash(pkey, ndel->dev, nht->hash_rnd);
-	hash_val = hash_val >> (32 - nht->hash_shift);
-
-	np = &nht->hash_buckets[hash_val];
-	while ((n = rcu_dereference_protected(*np,
-					      lockdep_is_held(&tbl->lock)))) {
-		if (n == ndel)
-			return neigh_del(n, np, tbl);
-		np = &n->next;
-	}
-	return false;
-}
-
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
@@ -276,7 +247,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				remove = true;
 			write_unlock(&n->lock);
 
-			if (remove && neigh_remove_one(n, tbl))
+			if (remove && neigh_remove_one(n))
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
@@ -387,22 +358,15 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 					lockdep_is_held(&tbl->lock));
 
 	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct neighbour __rcu **np = &nht->hash_buckets[i];
 		struct hlist_node *tmp;
 		struct neighbour *n;
 
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev) {
-				np = &n->next;
+			if (dev && n->dev != dev)
 				continue;
-			}
-			if (skip_perm && n->nud_state & NUD_PERMANENT) {
-				np = &n->next;
+			if (skip_perm && n->nud_state & NUD_PERMANENT)
 				continue;
-			}
-			rcu_assign_pointer(*np,
-				   rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
+
 			hlist_del_rcu(&n->hash);
 			write_lock(&n->lock);
 			neigh_del_timer(n);
@@ -531,9 +495,7 @@ static void neigh_get_hash_rnd(u32 *x)
 
 static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 {
-	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
-	size_t size = (1 << shift) * sizeof(struct neighbour *);
-	struct neighbour __rcu **buckets;
+	size_t size = (1 << shift) * sizeof(struct hlist_head);
 	struct hlist_head *hash_heads;
 	struct neigh_hash_table *ret;
 	int i;
@@ -542,18 +504,11 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 	if (!ret)
 		return NULL;
 
-	buckets = kvzalloc(size, GFP_ATOMIC);
-	if (!buckets) {
-		kfree(ret);
-		return NULL;
-	}
-	hash_heads = kvzalloc(hash_heads_size, GFP_ATOMIC);
+	hash_heads = kvzalloc(size, GFP_ATOMIC);
 	if (!hash_heads) {
-		kvfree(buckets);
 		kfree(ret);
 		return NULL;
 	}
-	ret->hash_buckets = buckets;
 	ret->hash_heads = hash_heads;
 	ret->hash_shift = shift;
 	for (i = 0; i < NEIGH_NUM_HASH_RND; i++)
@@ -567,7 +522,6 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
 						    struct neigh_hash_table,
 						    rcu);
 
-	kvfree(nht->hash_buckets);
 	kvfree(nht->hash_heads);
 	kfree(nht);
 }
@@ -596,11 +550,6 @@ static struct neigh_hash_table *neigh_hash_grow(struct neigh_table *tbl,
 
 			hash >>= (32 - new_nht->hash_shift);
 
-			rcu_assign_pointer(n->next,
-					   rcu_dereference_protected(
-						new_nht->hash_buckets[hash],
-						lockdep_is_held(&tbl->lock)));
-			rcu_assign_pointer(new_nht->hash_buckets[hash], n);
 			hlist_del_rcu(&n->hash);
 			hlist_add_head_rcu(&n->hash, &new_nht->hash_heads[hash]);
 		}
@@ -705,10 +654,6 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 		list_add_tail(&n->managed_list, &n->tbl->managed_list);
 	if (want_ref)
 		neigh_hold(n);
-	rcu_assign_pointer(n->next,
-			   rcu_dereference_protected(nht->hash_buckets[hash_val],
-						     lockdep_is_held(&tbl->lock)));
-	rcu_assign_pointer(nht->hash_buckets[hash_val], n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
@@ -942,7 +887,6 @@ static void neigh_periodic_work(struct work_struct *work)
 {
 	struct neigh_table *tbl = container_of(work, struct neigh_table, gc_work.work);
 	struct neigh_hash_table *nht;
-	struct neighbour __rcu **np;
 	struct hlist_node *tmp;
 	struct neighbour *n;
 	unsigned int i;
@@ -970,8 +914,6 @@ static void neigh_periodic_work(struct work_struct *work)
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
-		np = &nht->hash_buckets[i];
-
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
 			unsigned int state;
 
@@ -981,7 +923,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			if ((state & (NUD_PERMANENT | NUD_IN_TIMER)) ||
 			    (n->flags & NTF_EXT_LEARNED)) {
 				write_unlock(&n->lock);
-				goto next_elt;
+				continue;
 			}
 
 			if (time_before(n->used, n->confirmed) &&
@@ -992,9 +934,6 @@ static void neigh_periodic_work(struct work_struct *work)
 			    (state == NUD_FAILED ||
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
@@ -1002,9 +941,6 @@ static void neigh_periodic_work(struct work_struct *work)
 				continue;
 			}
 			write_unlock(&n->lock);
-
-next_elt:
-			np = &n->next;
 		}
 		/*
 		 * It's fine to release lock here, even if hash table
@@ -1951,7 +1887,7 @@ static int neigh_delete(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     NETLINK_CB(skb).portid, extack);
 	write_lock_bh(&tbl->lock);
 	neigh_release(neigh);
-	neigh_remove_one(neigh, tbl);
+	neigh_remove_one(neigh);
 	write_unlock_bh(&tbl->lock);
 
 out:
@@ -3108,24 +3044,18 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 	for (chain = 0; chain < (1 << nht->hash_shift); chain++) {
-		struct neighbour __rcu **np;
 		struct hlist_node *tmp;
 		struct neighbour *n;
 
-		np = &nht->hash_buckets[chain];
 		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[chain]) {
 			int release;
 
 			write_lock(&n->lock);
 			release = cb(n);
 			if (release) {
-				rcu_assign_pointer(*np,
-					rcu_dereference_protected(n->next,
-						lockdep_is_held(&tbl->lock)));
 				hlist_del_rcu(&n->hash);
 				neigh_mark_dead(n);
-			} else
-				np = &n->next;
+			}
 			write_unlock(&n->lock);
 			if (release)
 				neigh_cleanup_and_release(n);
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..cb9a7ed8abd3 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1215,7 +1215,7 @@ int arp_invalidate(struct net_device *dev, __be32 ip, bool force)
 					   NEIGH_UPDATE_F_ADMIN, 0);
 		write_lock_bh(&tbl->lock);
 		neigh_release(neigh);
-		neigh_remove_one(neigh, tbl);
+		neigh_remove_one(neigh);
 		write_unlock_bh(&tbl->lock);
 	}
 
-- 
2.34.1


