Return-Path: <netdev+bounces-137419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F569A62B4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEC01F22652
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6391E5037;
	Mon, 21 Oct 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="DQa/it87"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136071E376F
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506285; cv=fail; b=jlgjFhrqGpwUssPwsNrs+aN3fbdsUAtaQKQx2L9Kltkr4wS8IqtBkHw3QjKmWkCb6ShvutL4YXihAYZS6fUWbzUFZnbZ2jCtpbiUF/2MFDDINrROlVNHf3gcs4Hm+NXyHCNy8vccfKLxi0ObUs7aeldi3L0gfTBTlljPUdLQt4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506285; c=relaxed/simple;
	bh=deDKQYDIYSLQUSmzxOwY9tjDxARHkMwfVIVlyEVrzOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCyg4ELIQz7tCwIH9opa+4JiTw7YDP1PhUlu2HOGKrJKHtwr3rY54JWe6e0/KS/w37t5L7eGBI3rvZmMU4QOeMdiY9khJBp9DLKVfa4WHVGY4uDRUc6Oo6zoBQi+L+mLWYPrnhhvzNcxoEziWRa5UFJhy+cgpzzyNJ5kSFtc2ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=DQa/it87; arc=fail smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from eu1-mdac22-5.fra.proofpoint.com (unknown [10.70.45.132])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6B9AD200C1;
	Mon, 21 Oct 2024 10:24:41 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02lp2105.outbound.protection.outlook.com [104.47.11.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8F3B4C0061;
	Mon, 21 Oct 2024 10:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4FqCvGs3zqV4ozZcbhAIWbvEtIav8IeBviTZJtfDybV1Blx50LkY6owKtL/aGZNz+ezQkHvZxlP5LxW0TGkG4fAy+stJ9CT4iZZLV/pHe8BjRJFaViat67Vky93T4P5hzXTul32t7v1bdpc7aTFkPzYD2c5oi1+/wxgj5sCKf2yLvJ1oatH8W/revRXuy7GVDlbFRnYrI5ZmDPofqft/dld5nt55uD0Spk9echfLX7DPCtfOIhwfsiyEZmxWoaCldQje84Ruf40Pm3pn14gic089e1BWvxFStuhE9mUkVMxv0sB0En85oosRUwydjkpC2xNzDZdsqGvIDt6LHWRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah2ZnSH0F8oXkIftLqxT1Ne/AAu07vzhaYPbiIt3vIk=;
 b=gnnIlu9jgMoxQDn+J0+Lwchf5a80EP/rub3JNRSG/81Hkmsixq7hhRLd4a2YXNreiGFGwdupZ9c1v+7ieg/tivNmd7yRVAIPpxmK4oChKes4Nt/qVGeaK25QnJqHxTPVi5e2RqtXxcgb7HjPfuN1hofHuKORn06lu1z5BusAPO7X/msIzdqwmGz3EKiLCeB+NilMdH/ZyWRBo/pOKBu++h0JreA2NQJt+xQljQJacx820SL1NlCrWhq5+bBFPDsAPAsVfMs8NCblV7JSGA53J8ItzAOYzT16LNPUsSNWcp66/gMqrYySKr4DEmG8rSvrcnzCgc7d6dsfsJheZmGsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah2ZnSH0F8oXkIftLqxT1Ne/AAu07vzhaYPbiIt3vIk=;
 b=DQa/it87GDIyQDekK1OttgDyRwc+Fz8lTNqhh+kFFuVjUrqOoIAVSOpyTH4LV2nbjgDcj5+6Dbp1Q1MjUlsvJHBnowTe4T7cqv7kdpZVjyIMSElHXatzzYXNVEWVX52nXYNs8rGap6tH8sP0uwdEDgDRcqXW/wcAPA/RJJ2F8OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by GV1PR08MB7707.eurprd08.prod.outlook.com (2603:10a6:150:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Mon, 21 Oct
 2024 10:24:37 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:24:37 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v6 6/6] neighbour: Create netdev->neighbour association
Date: Mon, 21 Oct 2024 10:20:58 +0000
Message-ID: <20241021102102.2560279-7-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021102102.2560279-1-gnaaman@drivenets.com>
References: <20241021102102.2560279-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|GV1PR08MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4defa4-9f81-4255-2fe8-08dcf1ba905e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8zbawtcEkvoHL41Gxdgq7hgPjgNyrx8HZAinofnjuvxa+lGgAtVUuaXlQ37?=
 =?us-ascii?Q?EJLDc3l3qFz+/08nc8ivx/37eCEX2as7ydtaMh8jWZ7WNsTMg6FqNmmc3QAw?=
 =?us-ascii?Q?iu3TY6a4GB6MFYcQ1iPgsCjP4s7MlDbSJfoZnVi5IG+LoR9RzE4dkG3iOazE?=
 =?us-ascii?Q?ArCkPtJKdMJsPMDuo6XQUOXvwlslkHQexnuCZkOfVwUd5yKpv+2saa/C8C8t?=
 =?us-ascii?Q?kpz32jtGbmgQKQBG8wZAI6p+pKgbEXm2xNSHqeL0tNd+KD6UBGf/Sco7uWa9?=
 =?us-ascii?Q?7ezHA/vERAyCi+MoVKIp+ZU0+dla2+WKiWgNipYkQy6yZYdxGQkioRNTmGbz?=
 =?us-ascii?Q?nQWkbWgMUdcZUvyHUIbJYea0hXRriO9seV4Sj9fRIt4l4o842delDGOeiR5t?=
 =?us-ascii?Q?jCeRWFN22nVEDdss9g8kZDMmlNa0VGAKLvk3Sd7IJqFM0UaeIV5r1NOcin+0?=
 =?us-ascii?Q?+QWiDHP99eayRJnXwzq9bf1CTJpob8OkBxWSIVKZ6RDSqWo2cBHTvEiaHs4c?=
 =?us-ascii?Q?Nv/2W+3H95NaLluojrihmFukJaPLbC4QOWfhftpu8l2oIDIVqd5iMFqGu/mk?=
 =?us-ascii?Q?05MLvRdaumCWEbVlIiE5jhS/4svqMC8HW3YEUhROqv406vDDKkh5pfyKd07Q?=
 =?us-ascii?Q?4zarumS8QsLV2zWmifQyBNzoGkucIi+qxz4vlRC1VeJu3vNPHGTiLqxb7DEN?=
 =?us-ascii?Q?qfFy8UjGPO7Vak/ehmuK/huNtZWbrMMJRH+HOY//4/IDYb2cXDgy5wZILVFg?=
 =?us-ascii?Q?iAGESM5Osi57nCgxPW8L8bej1tI0t1xD8v3ClamCXQ8Go2M6bPcv7Niu7t0t?=
 =?us-ascii?Q?buRrDBfI3stGusmkRKabF/hzF0+/Dlf24BUhJsEp0MJ7PpOTP+6axzJaPMkf?=
 =?us-ascii?Q?cZmeDWFnCLZ6m+4UGXhN8N13lI9rbNl3T3uTGzvc6h9Mg7Y3T3D86N4fCw+P?=
 =?us-ascii?Q?kBoFs7BvhwWWYv+BJwlCqttyrHhVfOxLkaGBz9FaDXgO567QDeIfSov0zyJ+?=
 =?us-ascii?Q?ekwXmNSElonbDKbCRni1gAH49NWBfWQpq7gKbf7cRwOQ2mR5H9tp7xWKSTaw?=
 =?us-ascii?Q?JfriVv+JWHFtsIc07WWALgg20HGCTL1Cxl7XG4Jn2YsHbgzHcdJ8aKwcnvuI?=
 =?us-ascii?Q?8Rh7Il9H59N9MyA97UaC9DnyoEIkoRcy14E6oc+A0m/S1jnq1HYKRlEMM6R9?=
 =?us-ascii?Q?oMmiuFj1fHxVwunAA2BCL1AE5RDyifX5aBf/WSzrgKz0D1QyVMKkE/+ot3yF?=
 =?us-ascii?Q?/i5wqnGUhlBa/GNgCYtXZJx7C+ZnZIiifrrWfJSaV7MW2Q6rigFBQY0MRvCR?=
 =?us-ascii?Q?7NBnjzOCpmn3GRo5JIibg4aUZ+JADVeUSw+Jn+Le70TxHyJCQO7oJZgHt6DQ?=
 =?us-ascii?Q?8M5k+Zk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QZIqUaeIniEIutsoasagJawHjuazmN3tFFlq0xtIee4ibeLhzfmFYVJ1VKhc?=
 =?us-ascii?Q?NeLYUOHc1/QUorCxtBlA8iZ2++pY4a2LfkV5Zucq6uahyA8DKI4ryXMGPv4l?=
 =?us-ascii?Q?FlNhHhzUR/jrtAPwTFiM5g36wU3I3l4+dMmHO/o+y8rxMoGpULCBXPqBGvzC?=
 =?us-ascii?Q?k8sldweDuuc9kxQ3FG6DtWIFdWNfUjhPsWKpsxo5E0eZf+T4RR4UCrek/1jj?=
 =?us-ascii?Q?SACg+f0s8DAqBcy6uVIPqhzCur8hlBe3c1qKy2xpdtClXSA2sMAO93sk7pbl?=
 =?us-ascii?Q?lJkW6WqbOelhRC+PJT59wwuVIfe4dJ3n1KivGrbEybD2zVPuYl/24wtkF+u2?=
 =?us-ascii?Q?fwK2Ijl95p29SlhSFQFh2unQjee/4vGet/f2a0fvImF/txXntIdeYzwdYnVq?=
 =?us-ascii?Q?Q/Y0E1oXsuOF+FfJBjTSnaYVfz1AYWpy7bU6JR20iztxUfBH/ZiKMj1EIbnk?=
 =?us-ascii?Q?GwjRsnfQ6VUoQb63KM/tTeJmST7AZaWZZOc5muHOEBYjAAN8TsyXG671RZJS?=
 =?us-ascii?Q?4HxofP2/vZW9SySU+D+KndGx9tpcpQNPh/X7W83k/Ftqu5Kjo9sk8bWuMwCf?=
 =?us-ascii?Q?G74n4+eZwfRXchRiPxkwmCiP06lPgQmuoiYpqELvgX6tTu9JZbbt8vOkC5Oj?=
 =?us-ascii?Q?8MUq5tZnjxccgVQJ5LXHtb+wj2lcfhSKpEfld1p/R5Ksf2lnuLyd/30t0/NM?=
 =?us-ascii?Q?B4fgns/6rMjOgIGWiOYmehKugessMueEtD2NO23jkV7ubdXtclKDLiUcoE8T?=
 =?us-ascii?Q?i4EHROa5NC9t1ARSax/M0v/jP9QN9AAqT7PN/07E07QicyfvEz9VnxzEMO6o?=
 =?us-ascii?Q?Xi9Cbr3/HZRT+fhljDEexB9/4M3bbQQMHSct4AztousJIv8Q6XXkSVHZzeTO?=
 =?us-ascii?Q?mPZqtM6WnYykui1Ly/fJ/0uzNUrgRJ2ZfnjEvd0IzC6N0fsWx0bW7Y75FXaD?=
 =?us-ascii?Q?vxacWOIcid20LCDNY0kSitU6d5aB+OXKnSeembja1fP/D/X4HIz5kmNqxgEp?=
 =?us-ascii?Q?jPg9qlDFGsFsSVi/j9tzWHn1IoUXu6zvIpccx5moeCaMTMuRUrFUpEBtAVwR?=
 =?us-ascii?Q?vpfhh6SB04ldv26wm2WD1ymz6rXvsDt+L0EFasyWk+suUv34QT0YJFWq4jya?=
 =?us-ascii?Q?UM6TTHweeo4ONWjyvBuM9TJi8DU+DYQc+EKTDEoa9runsiw1C6mgFG0sd5th?=
 =?us-ascii?Q?du8Nl5r8HB04JgE7wWRbtg1SrZ3uQslx4FYfoHlOtjQmP1uv/pJe5Gb+Bv4v?=
 =?us-ascii?Q?PBDrahxViRsARCwWTf3LIkpXA1dIvLD3s3mpKdvZ6ZmjmRVdWf9xScDxuLnS?=
 =?us-ascii?Q?nFLMQe1xin9KtSE0e87UmQcPw4iC7RL+8m632UDpVc0j1ub48V9WvMNNEy0G?=
 =?us-ascii?Q?Jcqh+XwJ19voqp1Y/rwPyDwmrSupVPFWdSdr7SaPWfnloO0V9Ist49KQaLh+?=
 =?us-ascii?Q?PefDDxuGVERRAQ7bZxBSk5RTm+yTdfAFyPO6E/1qf4pK6uOxxDUuqvW4qvCL?=
 =?us-ascii?Q?3jMkepgtefBrfM143dLLe3RuNS+ddFHufnOtFKw2SgZHKI0en5p2S95cYsI5?=
 =?us-ascii?Q?l4WqgpCBLkR3uADF7sTWHDDIR571qPx0sAP+I90NewFrejOx5t+sFYHKZTs7?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xRqyAPlnGPOCtxGu0Si4eBUqaeQ//2tc0Ogl9MLDEkhmI6/FpCxiBrZVJDvbCwSTq9jbqOaWHL4YxS8v/8+6fyXgjQtBCnF6Iy0bd14oTy23t6sH7o7JjaIQ6Ae2rPBIg5JG6MAPwB8KZhZPW+ZyrgtKkl+estCynYMcCLWxfEeNJs3uCoXygJC9S3U0fCUqg77/9weCLPKIT0KynhJp/Xp76aww5KhA1Mqyp8Gwn263c9z2gez89QsGg6oZ4eOfc8gjC8cID2wAsAahL+6K2P9Ozb9faMWzkQEUNtChxnzSfDPzaOqCC5Rk9DNHAicbUPKlFGY1oCBbQ+Q3pOEI+g8EiN8OzHSYFNSQ5d8ibK/oZ+DPYtV5TsD3QiH+4I4vnbxAeJA9Te3IQgAr0IySATwYEj/ZWSSQuGCBMPSWenJPkC/B+GOspoBXKt6rtXt570VWRiz7b/jnG7fgHjDWOIBTRAJKISDiQ4PGmi4VQ9lyJIXJiysMOZgwyKTBzLYyY1GnyDXqQMLMMDfiENM0gETl9wigDuaph3PyVwBIaWbcJA95WZooHhEIS4te9GJlBWYdDTl7h4ytLnqyrwM0DqnRSa4aSnGN9t5kR/6O/n+yHGBol54Qfv/xRBnRDsPf
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4defa4-9f81-4255-2fe8-08dcf1ba905e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:24:36.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEjanCManvCAHJWpfkPsDoiS97B8RnrNja2/FgV+sYXhkZI+laWzYwNReaCDWWub5YuV5S5F9199cQulxYfknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7707
X-MDID: 1729506281-n6WWp9Isinzv
X-MDID-O:
 eu1;fra;1729506281;n6WWp9Isinzv;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Create a mapping between a netdev and its neighoburs,
allowing for much cheaper flushes.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  7 ++
 include/net/neighbour.h                       |  9 +-
 include/net/neighbour_tables.h                | 12 +++
 net/core/neighbour.c                          | 95 +++++++++++--------
 5 files changed, 79 insertions(+), 45 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index db6192b2bb50..2edb6ac1cab4 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -189,4 +189,5 @@ u64                                 max_pacing_offload_horizon
 struct_napi_config*                 napi_config
 unsigned_long                       gro_flush_timeout
 u32                                 napi_defer_hard_irqs
+struct hlist_head                   neighbours[2]
 =================================== =========================== =================== =================== ===================================================================================
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8feaca12655e..80bde95cc302 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -52,6 +52,7 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/neighbour_tables.h>
 
 struct netpoll_info;
 struct device;
@@ -2034,6 +2035,9 @@ enum netdev_reg_state {
  *	@napi_defer_hard_irqs:	If not zero, provides a counter that would
  *				allow to avoid NIC hard IRQ, on busy queues.
  *
+ *	@neighbours:	List heads pointing to this device's neighbours'
+ *			dev_list, one per address-family.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2443,6 +2447,9 @@ struct net_device {
 	 */
 	struct net_shaper_hierarchy *net_shaper_hierarchy;
 #endif
+
+	struct hlist_head neighbours[NEIGH_NR_TABLES];
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0244fbd22a1f..bb345ce8bbf8 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -29,6 +29,7 @@
 #include <linux/sysctl.h>
 #include <linux/workqueue.h>
 #include <net/rtnetlink.h>
+#include <net/neighbour_tables.h>
 
 /*
  * NUD stands for "neighbor unreachability detection"
@@ -136,6 +137,7 @@ struct neigh_statistics {
 
 struct neighbour {
 	struct hlist_node	hash;
+	struct hlist_node	dev_list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -236,13 +238,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
-	NEIGH_NR_TABLES,
-	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
-};
-
 static inline int neigh_parms_family(struct neigh_parms *p)
 {
 	return p->tbl->family;
diff --git a/include/net/neighbour_tables.h b/include/net/neighbour_tables.h
new file mode 100644
index 000000000000..bcffbe8f7601
--- /dev/null
+++ b/include/net/neighbour_tables.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_NEIGHBOUR_TABLES_H
+#define _NET_NEIGHBOUR_TABLES_H
+
+enum {
+	NEIGH_ARP_TABLE = 0,
+	NEIGH_ND_TABLE = 1,
+	NEIGH_NR_TABLES,
+	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
+};
+
+#endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 47eadf1b2881..69c570c2a919 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -61,6 +61,25 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
+static struct hlist_head *neigh_get_dev_table(struct net_device *dev, int family)
+{
+	int i;
+
+	switch (family) {
+	default:
+		DEBUG_NET_WARN_ON_ONCE(1);
+		fallthrough; /* to avoid panic by null-ptr-deref */
+	case AF_INET:
+		i = NEIGH_ARP_TABLE;
+		break;
+	case AF_INET6:
+		i = NEIGH_ND_TABLE;
+		break;
+	}
+
+	return &dev->neighbours[i];
+}
+
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
 
@@ -352,48 +371,42 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
-	int i;
-	struct neigh_hash_table *nht;
-
-	nht = rcu_dereference_protected(tbl->nht,
-					lockdep_is_held(&tbl->lock));
+	struct hlist_head *dev_head;
+	struct hlist_node *tmp;
+	struct neighbour *n;
 
-	for (i = 0; i < (1 << nht->hash_shift); i++) {
-		struct hlist_node *tmp;
-		struct neighbour *n;
+	dev_head = neigh_get_dev_table(dev, tbl->family);
 
-		neigh_for_each_in_bucket_safe(n, tmp, &nht->hash_heads[i]) {
-			if (dev && n->dev != dev)
-				continue;
-			if (skip_perm && n->nud_state & NUD_PERMANENT)
-				continue;
+	hlist_for_each_entry_safe(n, tmp, dev_head, dev_list) {
+		if (skip_perm && n->nud_state & NUD_PERMANENT)
+			continue;
 
-			hlist_del_rcu(&n->hash);
-			write_lock(&n->lock);
-			neigh_del_timer(n);
-			neigh_mark_dead(n);
-			if (refcount_read(&n->refcnt) != 1) {
-				/* The most unpleasant situation.
-				   We must destroy neighbour entry,
-				   but someone still uses it.
-
-				   The destroy will be delayed until
-				   the last user releases us, but
-				   we must kill timers etc. and move
-				   it to safe state.
-				 */
-				__skb_queue_purge(&n->arp_queue);
-				n->arp_queue_len_bytes = 0;
-				WRITE_ONCE(n->output, neigh_blackhole);
-				if (n->nud_state & NUD_VALID)
-					n->nud_state = NUD_NOARP;
-				else
-					n->nud_state = NUD_NONE;
-				neigh_dbg(2, "neigh %p is stray\n", n);
-			}
-			write_unlock(&n->lock);
-			neigh_cleanup_and_release(n);
+		hlist_del_rcu(&n->hash);
+		hlist_del_rcu(&n->dev_list);
+		write_lock(&n->lock);
+		neigh_del_timer(n);
+		neigh_mark_dead(n);
+		if (refcount_read(&n->refcnt) != 1) {
+			/* The most unpleasant situation.
+			 * We must destroy neighbour entry,
+			 * but someone still uses it.
+			 *
+			 * The destroy will be delayed until
+			 * the last user releases us, but
+			 * we must kill timers etc. and move
+			 * it to safe state.
+			 */
+			__skb_queue_purge(&n->arp_queue);
+			n->arp_queue_len_bytes = 0;
+			WRITE_ONCE(n->output, neigh_blackhole);
+			if (n->nud_state & NUD_VALID)
+				n->nud_state = NUD_NOARP;
+			else
+				n->nud_state = NUD_NONE;
+			neigh_dbg(2, "neigh %p is stray\n", n);
 		}
+		write_unlock(&n->lock);
+		neigh_cleanup_and_release(n);
 	}
 }
 
@@ -671,6 +684,10 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->hash, &nht->hash_heads[hash_val]);
+
+	hlist_add_head_rcu(&n->dev_list,
+			   neigh_get_dev_table(dev, tbl->family));
+
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -952,6 +969,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3071,6 +3089,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			release = cb(n);
 			if (release) {
 				hlist_del_rcu(&n->hash);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 			}
 			write_unlock(&n->lock);
-- 
2.46.0


