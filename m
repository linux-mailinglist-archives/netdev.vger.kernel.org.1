Return-Path: <netdev+bounces-144328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5BF9C6937
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 07:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA828B20BFA
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BA717837A;
	Wed, 13 Nov 2024 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="SJm3YLfk"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15621BA34
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478934; cv=fail; b=Tg2N5bXHrX81O5AjOD6iQrclMiwYj9fWNPsI1wGveskex2psOf0n0q6pxjTuRpyTbJtb+Yf7DkKPz7ghwCwbMYhoZ3+jRImJzvbcDA83d6SUJzEjnmqhkldt+WKAysJiIa8O8LJJjgW7Id5tradvKnarRrhe+pn5kXa6ZFuwlA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478934; c=relaxed/simple;
	bh=CS7Nmk0gm5gPP/SMPFtPCQrXjvUR7p2nTITgzWL7js0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uaEPxLsDBW8BAvM2kWORiNUsIdmi2sj1x/I3477JHb4NlrDq6z6bPIIHcnb3AEGPUy7AzBa6wX9Mtp4EbnzMai3y49Cql2TvVZIn6V/aR5ao3XU6VaFJVmpT/XUjfanCpQu3uDp//UILJyQ3buaLWs7XLtDHc//zdnFw3+mCWmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=SJm3YLfk; arc=fail smtp.client-ip=185.132.181.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id CDF136C0057;
	Wed, 13 Nov 2024 06:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mY+9Ru9vY01NtJNxQk8JV8L47ae7mraHrQM35PTE5GFww+6+dNv6+yIk9jP63SMa2ShPv288mJhHu/AY2A8iOvP9Qm6Ia8Q6XhpfAGAMWF1maGFxDiFEyRaCKi/Cb28RNz2Rwc5bm97Ze7VB1Y7ZVhucZpo2d0DGRXE+RpT6p2ury2SAD+aBIdxh1JM5bYtaCOUtpHbbb7XkrMP2BBWyVSCpcecatiraRF3Py7jThpTEHX0eBYq7e3i7OoUmzQBILwBsuR5AgVAPeffJ4f7VYNWw5RFXVk9ifMiutn7wcHflE1sYy1rvzkN5+yz/ND/BhgNTcH7vvtBMeOSbUr5B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrkX1BWCgTjoJaMLeKmyQP+bd69H2cyFZgvcmAM+h0I=;
 b=Y/GkRw4vEsSWyjd6W4JOLE9v0uM5jjUFcksE42CE0g5EXHEW61XiGsgEZVGU9Iz3htbx6V6Y89nQGpgassC24Q3CmpCSK9+meZF6iquTXGtNTMGaK2KGmjETnoXQzyrONGulJjKywlg4FspMK6nCOF8PFFgLkyVH+keSwM7qAn101tU4GWjNhKH4PkTBMMOEh69/ozpj/KNxCKCnpylPu2NBt6StpuY2/sOicjKUnGbUhI0Gpv7ymh3el5UVjNuamYsVjkO4XCzAcdu5eGZd/asaLwPpE9Ud+5JN3o2g8s8s/ImTf1j5Hl0J7g3AHiPT8Vmwj5xM12FE1AGaVttEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrkX1BWCgTjoJaMLeKmyQP+bd69H2cyFZgvcmAM+h0I=;
 b=SJm3YLfkTf9d8csEghfEevMcNf4Rz8qSmydGefu5nPCwoivBszj0BaS8eWpaPJt0gHJC/lK65IP9NN2UH5sGtKU5YjRlF4aVdnjJCgqLy2GR54XMIuffVantIUXdQIUnCYfDnw09JcUE9xsi61bDjDVhz3sHwlbTzRiDfhO758w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DBAPR08MB5624.eurprd08.prod.outlook.com (2603:10a6:10:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 06:22:01 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 06:22:01 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	gnaaman@drivenets.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v2] Avoid traversing addrconf hash on ifdown
Date: Wed, 13 Nov 2024 06:21:47 +0000
Message-Id: <20241113062147.1444772-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ecdad6a5-d766-4ff2-a8ad-b605ebb3811c@redhat.com>
References: <ecdad6a5-d766-4ff2-a8ad-b605ebb3811c@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0067.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DBAPR08MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db36373-4460-43fe-3d85-08dd03ab7bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s50wcdKuU3+4mkEuETQdXobYS7PqF6AqCXfsKtAWkR5ahiAzJhBNyOKw4zFy?=
 =?us-ascii?Q?Ecac4X5oFOa32+9J/acO8bXRSuNw+up3bqpJwCVMxub7I6ML5Al7B7zpelcy?=
 =?us-ascii?Q?l8d7ZxmRIb9KKWZ4St/7Y2EF4N9EEPI4URt4+SwKvY1RRAqaBra88dsOgVAl?=
 =?us-ascii?Q?W/1Yybd2QUgcqE+HK0O1eSuH8Wwi901KO887TKq9kqL9pgPwWufStdvRWmfY?=
 =?us-ascii?Q?is8D/Gvwpe2IKne6WjYq/zNQ1ChdVd3EmJoiXgtfCW7rSgon+ZolzGSMQPra?=
 =?us-ascii?Q?Uap/JAaUZg6b+YgDvSPHnQ3nppv+f/81wPQEZIfPyoHHt7sXC5cba7woNDT8?=
 =?us-ascii?Q?oJHdPUnJuXZWhn/y08fYVvX010ipyt8FC0RXy6VdDPKIhJvnNXjdpM+tp1pv?=
 =?us-ascii?Q?757PfNkY5NAkuhEmO1S7jMmV4ovQRp5YRa/OMLHe7Qa9xEx2tk+hNcpfHL5B?=
 =?us-ascii?Q?iS6Q6pFTjy6cQnunHObtQBdN6rN6KU0kCu4oifVv2o6q/uqo53/hA8uKa1F0?=
 =?us-ascii?Q?jiMtUnZk4lGb2xOn5hVw/4DNHwuH56gNv4n9QtFyOzxbatwvgRPTW6A0GIB8?=
 =?us-ascii?Q?+1qv+5JVTcUdyBM/if0FxUsplikvwbdh5ETjtoFsSGoEDghMxhfGID53dUYP?=
 =?us-ascii?Q?heDoqPiskeOX4p3PUipYtJCqoJ3YOmSlU6ZTIr64wfSLIppzAA7eareL2QNs?=
 =?us-ascii?Q?N6pcMYXb8iH1kHpuzKb9pWh5LvOQItPvIg4ZhD+z/etD7mPp+eegPagy77yN?=
 =?us-ascii?Q?nGhJpL6SPGCHXAKw/xq2/dIQH9fBce7rTafKapi1TtyXtVlpQ4VAnLWXJYWp?=
 =?us-ascii?Q?UeATZAo3gFjF/N4/lbnXaP/vFPXIupkBtXcWOJOfxxD7ks9OafZzjD9wbN5D?=
 =?us-ascii?Q?mXTOACdUmst8MPzji6nj+F6iRfpCmgDVfgzlbpR2ditmSFX4pKt9PZMEiHzs?=
 =?us-ascii?Q?b72JQQ6S7Z981827RzvBzt3RhX3Iiw1W+jOacHsjf1IMR/bdZx8KIqYeIATQ?=
 =?us-ascii?Q?/RtFlCFTyiXiIg1zUnYG4k+rGgaEnxSHwW3Wsjl4x1pLwBqDnLE0olVfOU5X?=
 =?us-ascii?Q?CRDZMIbka/yMcVasVVccGXrl7ZESMukNv5ZoZfbpqOwkv0yv7iavul8S6Vy/?=
 =?us-ascii?Q?GZcS5tg5Sm3FwZ93f4I0/H+hyuJf+oP5j44fkO6tyq+p9Ai9IPQVCAPgavHu?=
 =?us-ascii?Q?okwqCZFjEzSqdPjjmJKFKPR1OZxAJ6FX4i1pGlDx95GXwEd7tc7T1vX26C3Y?=
 =?us-ascii?Q?pBTpAfc47abPMsBH+qdQfMLRHfJ6KOpDGwUHOxA0Pqr8vpDqyWI3KvfKErrS?=
 =?us-ascii?Q?cUiace71CbQjRGvL0tMBM44MHMwzkJd2L6ejCp8cDKW5pjPjCSMK/8fAXhQM?=
 =?us-ascii?Q?8+wZNK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X1HyqzrbmUUHQcjb6BXPaXPrSHujadIFuOZVBmYg3bEWT03m01PrO7qcVhbx?=
 =?us-ascii?Q?wp+CPNV2NzgZjx/nfxKtTxVaNQi3Nt6aNUbvwl2o3hUdpxsmna3J1iHNv6H6?=
 =?us-ascii?Q?rUV31LLljqyc0KRToUgl6uXCNQfLg30rCcjPOwacBg9vybWTYITrrfngn3Pg?=
 =?us-ascii?Q?e0Gypj6tAEMMDsXK9oxjq+YM298l8y+UsXUI2uaOLacYEqUiODB6RTAo4WX7?=
 =?us-ascii?Q?R//kD7vuf6pP70s7qOfIL/ztnMaNEUHdHqch7Vm1TlRsc/lndWBrIhD3QVlb?=
 =?us-ascii?Q?GCN8c3T15hTysHZt91vLy3oMc37wofg3Apbldkq44LaHzgPrnn5Qh0jeVF2+?=
 =?us-ascii?Q?euZCcbwAB7LLfU+4fD0khuJHjycMHGqbx86Hz2/sLO+qJXMaMbT/l/DcxMPe?=
 =?us-ascii?Q?6V/8uezik85MdA8T4BHibtVSsGdPSDzLaGyl3H2M0Yt2EMlkIAgnqYLAQBg/?=
 =?us-ascii?Q?VH0YOb4obM/sEzYRVCnYQomL03UlIBW+nfmz1NucOuB/4Acd3WrNHzz5DeDw?=
 =?us-ascii?Q?v54aLGOxu9OgHtTGAPU7U1w/j0yFaAuxEtSuAJJ0jgxl3Ch0H6vD1w47WwRp?=
 =?us-ascii?Q?CQpFmzENMZ6fxAgpM3tjz4PRXqR5i9+sHdjMM78i1A+KTaFWKstSGdkuFtch?=
 =?us-ascii?Q?Z2Er7EXkTfV5dYhuOdov0qf7YaGNA+s7Q9Hbi9Ee6N9FKDay/2t+RO3LJIGB?=
 =?us-ascii?Q?aJ+86PqzT9bHP4tpTtCFIxeSG4+TRVF6Ie9zY8BNe+JnmhBJ24avo09QMzfv?=
 =?us-ascii?Q?2w26bN1bGfTRZtzBPzqJLZXc94ATT02FXEqHU6bdMHegh72fjIHR4ho2zy08?=
 =?us-ascii?Q?a8Hh5P8G7cLHzT7KKVZmktuNjYL6T63IZvBkM6GpZzPWQTSLISm2dZu7pHmj?=
 =?us-ascii?Q?DfDC0VcodPl4V8EMgF/tJozGcexvt/R3mjjFvvo0R/9kiswF480A5yhw5eXq?=
 =?us-ascii?Q?kP/JJ1WZw2ONq5PBaBZ9P/qJQIlvhUFAtU6/OkBzwPYP6ELEQ++4KFzJKeFk?=
 =?us-ascii?Q?pN6bomTuYRJxFncmc1Hv8Z8Rfwal92DSOR4avHtXR1tLihlOOAS7ArcrKlXz?=
 =?us-ascii?Q?VisInixs+/ovoElJNpVf5C3HFhdwjMdG+VKoE+zs12C8+OS+3Dihi2EUbUOp?=
 =?us-ascii?Q?yelT3A+7fri81vd+4FCCBDLiywzkUWAaf4iOD7kZBVoNwlPK1lpjvLGt5N9Q?=
 =?us-ascii?Q?o4UfOIxHGZD8UcosGFzbB9aHA1Cqs8x0t2uX8M88/xcT+Jl7hwPQ/hTD+xII?=
 =?us-ascii?Q?id/itQGT7X4AKLpsiO0gSLoMvrcNwLDpDM48Eo1vfBs6rfYWazSNg5ZbrAsG?=
 =?us-ascii?Q?oZyhWi9bj329AGT64do3MTitdfaawIIl+DdVz0QHLRinMiBuc8Sz0ATSyf3M?=
 =?us-ascii?Q?UMwG4MUS8hyU75pzjfqTA4rHr9o680q4KA78fUPrmjqDZWuNIPu98FbdCx8G?=
 =?us-ascii?Q?lA7Rwr/TFir9aom9EjCtq6RT6Ql6lvxemFkxqtbfWkJtJNLkRZIHEyELAcXc?=
 =?us-ascii?Q?1642St3CGjZctIPZGDgexhuBUEvW13kuxO6jzg6yVbQPP4cyEUeb9qOZA1cG?=
 =?us-ascii?Q?Bn9hOjV087gJ7gMxHtOunlRzhU13pZhr2gVJje0eMY0k+V7Wyzv2wCbGdiF3?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QhKtMzc14y32Fery7KPx7aqk3DIZ3QTmjQJDh176SpMNR8SG+ab4or4fSJUqd+KZ+rmMEeTZf96SdLBZIBL+khraPtq6Q4VpQtF9Mq1x78H91YCYLpgmoS6GyQ6ynJfC7yY+V9IZ5NFSCAJ6f5nWEDeCvlGBS80NYEJqE9iidqzuApZwXvoOvlV6wB9Os/Q0/OAnVlOQz0QxJ13y7OcuM+9Bte7d6+UbBtIRQOTIluLL28FqZRZ/E9iMOiNQRwG3her1y0mDyN7PSdVn8IVZEsZbABIxO33Bl81dCzrFJcPoCWHMecwBZvD2D0AkLj39+uulVeDkILZ/a2bhhGX5yDsyhnus8yu7BIJCds6LqkgoFG4FzZ/HAj5PkkA7DhbuMkJS60o/r6tquGbAc0XnM3a72m2pJwQg6kFXAYrngWc+c1Crfs49tEid3wHyW59E3x4Pfz45/XMkrA5rX55KlpPf/3+U1hLxjdw5RSh8wsH9WSzenRRYpVH7rbgv1JwADKd7+j/4pTt23MI9JkPca83+MPCtXJrdWOTfVQnXAj+qC1oDijhTWkwnCa6AtJzhG0ArzzfXLpVcVwfaGxiqzNQLv8/uZD4t7Ineu19N4yO3maKmLZ6x1XdosPPe2qzb
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db36373-4460-43fe-3d85-08dd03ab7bfe
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 06:22:01.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GJku6sU2NXIyi2Dxk3YoTusObuLMdpy4y/PnDCctUd5SKZtP1wkxu0OzZ6nfkQh0qrB8XiDNVw5Jv5Njrzw3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5624
X-MDID: 1731478924-NhZFWnSNTUGI
X-MDID-O:
 eu1;fra;1731478924;NhZFWnSNTUGI;<gnaaman@drivenets.com>;152b7a609c5631ab3aa4b4b3056c19be
X-PPE-TRUSTED: V=1;DIR=OUT;

>On 11/11/24 13:07, Vadim Fedorenko wrote:
>> On 11/11/2024 05:21, Gilad Naaman wrote:
>>>> On 10/11/2024 06:53, Gilad Naaman wrote:
>>>>>>> -           spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
>>>>>>> +   list_for_each_entry(ifa, &idev->addr_list, if_list) {
>>>>>>> +           addrconf_del_dad_work(ifa);
>>>>>>> +
>>>>>>> +           /* combined flag + permanent flag decide if
>>>>>>> +            * address is retained on a down event
>>>>>>> +            */
>>>>>>> +           if (!keep_addr ||
>>>>>>> +               !(ifa->flags & IFA_F_PERMANENT) ||
>>>>>>> +               addr_is_local(&ifa->addr))
>>>>>>> +                   hlist_del_init_rcu(&ifa->addr_lst);
>>>>>>>      }
>>>>>>>
>>>>>>> +   spin_unlock(&net->ipv6.addrconf_hash_lock);
>>>>>>> +   read_unlock_bh(&idev->lock);
>>>>>>
>>>>>> Why is this read lock needed here? spinlock addrconf_hash_lock will
>>>>>> block any RCU grace period to happen, so we can safely traverse
>>>>>> idev->addr_list with list_for_each_entry_rcu()...
>>>>>
>>>>> Oh, sorry, I didn't realize the hash lock encompasses this one;
>>>>> although it seems obvious in retrospect.
>>>>>
>>>>>>> +
>>>>>>>      write_lock_bh(&idev->lock);
>>>>>>
>>>>>> if we are trying to protect idev->addr_list against addition, then we
>>>>>> have to extend write_lock scope. Otherwise it may happen that another
>>>>>> thread will grab write lock between read_unlock and write_lock.
>>>>>>
>>>>>> Am I missing something?
>>>>>
>>>>> I wanted to ensure that access to `idev->addr_list` is performed under lock,
>>>>> the same way it is done immediately afterwards;
>>>>> No particular reason not to extend the existing lock, I just didn't think
>>>>> about it.
>>>>>
>>>>> For what it's worth, the original code didn't have this protection either,
>>>>> since the another thread could have grabbed the lock between
>>>>> `spin_unlock_bh(&net->ipv6.addrconf_hash_lock);` of the last loop iteration,
>>>>> and the `write_lock`.
>>>>>
>>>>> Should I extend the write_lock upwards, or just leave it off?
>>>>
>>>> Well, you are doing write manipulation with the list, which is protected
>>>> by read-write lock. I would expect this lock to be held in write mode.
>>>> And you have to protect hash map at the same time. So yes, write_lock
>>>> and spin_lock altogether, I believe.
>>>>
>>>
>>> Note that within the changed lines, the list itself is only iterated-on,
>>> not manipulated.
>>> The changes are to the `addr_lst` list, which is the hashtable, not the
>>> list this lock protects.
>>>
>>> I'll send v3 with the write-lock extended.
>>> Thank you!
>> 
>> Reading it one more time, I'm not quite sure that locking hashmap
>> spinlock under idev->lock in write mode is a good idea... We have to
>> think more about it, maybe ask for another opinion. Looks like RTNL
>> should protect idev->addr_list from modification while idev->lock is
>> more about changes to idev, not only about addr_list.
>> 
>> @Eric could you please shed some light on the locking schema here?
>
>AFAICS idev->addr_list is (write) protected by write_lock(idev->lock),
>while net->ipv6.inet6_addr_lst is protected by
>spin_lock_bh(&net->ipv6.addrconf_hash_lock).
>
>Extending the write_lock() scope will create a lock dependency between
>the hashtable lock and the list lock, which in turn could cause more
>problem in the future.
>
>Note that idev->addr_list locking looks a bit fuzzy, as is traversed in
>several places under the RCU lock only. I suggest finish the conversion
>of idev->addr_list to RCU and do this additional traversal under RCU, too.

Sure, no problem.

I've looked over the usage of ->addr_list in this file and there are about four
places where I'm certain I can replace idev->lock with RCU:

 - dev_forward_change
 - inet6_addr_del
 - addrconf_dad_run
 - addrconf_disable_policy_idev

As for the rest, if it's okay to run it by you before submitting a patch:

 - ipv6_link_dev_addr:
   Modifies list directly under write-lock.

 -  __ipv6_get_lladdr & ipv6_inherit_eui64 & ipv6_lonely_lladdr: Traverse in
    reverse. According my (admittedly limited) understanding, this is not
    possible in RCU.

 - addrconf_permanent_addr: Not sure if this can be RCU'd, as there's no
   variant that is both _rcu and _safe.
   If it was safe to keep iterating with just `_rcu`, I'm not sure why
   `_safe` was needed in the first place.

 - addrconf_ifdown & inet6_set_iftoken:
   Seems like write-lock is taken anyway and regardless of the iteration,
   so I'm not sure it would benefit from introducing RCU.

 - check_cleanup_prefix_route:
   I'm conflicted about this one.
   When called from ipv6_del_addr(), the write lock is taken anyway.
   When called from inet6_addr_modify(), the write-lock is taken;
   where a read-lock could have done the job.

   Should this be RCU'd as well?

>Cheers,
>
>Paolo

Cheers


