Return-Path: <netdev+bounces-135788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BAE99F393
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574B7284B1B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187111F9EC3;
	Tue, 15 Oct 2024 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="Np0BgQaH"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A5F1F76C6
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011595; cv=fail; b=NFuNr+DaHONrCHUULCalxY2dCoYB9ll/1OPLhTuae0suHz/9+oo60aYLbdnvD/jq5clJR5kk4OrVmCtAbBPAhIJaUyTDKQP6fc7A/8lZzTmQ/vLIrFHPfFk+uS2Sh3/hy33UrHSI6W8MR0+vLdm0Mw+/G31kHVs4jkir7E7a/Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011595; c=relaxed/simple;
	bh=cZ0xkR96fkOBNvwl2CPTUoEDacUmIp5i3LzzsO9AEcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kobR1cHbcfd+HZA8vzQRMMU9P6LjPFGEzHSW4gMU3AjjEUaV8AcfAbMDuRCN8q89ILonXIGISPRLuu9L6axeaIW+7uHd8ijMR5nqK2c+5EAzMFwz6nAoGrbFpH3PVm9C21JvIUn2AQ4KvkaTXepql68rXWCAw8SYY9SaAcbfbqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=Np0BgQaH; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 6057920005A;
	Tue, 15 Oct 2024 16:59:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLbxjO5OsJXJWneTs6pkS+yNVgQ4AVlz4ggJSJqCm2gww8+T17hHho2bdlEcgj3A0QNmkI2vByqN499JOu0ZyUPz4asaRuTFdKeCS3WSkqfivHT6IuAYQSHC/5p02w3F49QqbthT34HQ1e5dq0HWl5Yz91rtrYDGVZc53PUfGcY986C8HEb9m7I8Of2Cp7HBSgdFUDtZfGxnOz1ungwEVDwN8NoCKsC8TJQ8cvMgZRrYJKy83hnmSEMNsx5+d7BFIxesAmW/PDMbxdUDXzNv0jKHv8PLz6irF2dIqEeNq0F7miabDgGEgtwiUPwwavHuxPaPYE42dFaO/kYu7H8oRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9ssrDYMpF4+bD825oiW+rpMkk5jMJRW3sohGoIXtvg=;
 b=GRaXy4p9wEGdfgn4dwlBmLHB0n0YYlTFPH+AhAyQ8n4hbJ16ei4ttmhpv/ceoUGmd1aTktiGK9TbXrMBCNM9OcEtdNepqG9X65EGyFUCo/HycVgelqIMEu4zlnR0HRHDtjaQbN1Jc8vpWNM2i3uJzByzvo60nW4t5ownRNhEwT0AbId62RUeHxuT8JENj+Cq0kPg3SyIWQf4eHHhIXrJJ7h3KgvkTFgrLS1Yb3i01QjZIi3TblNwoXW4o71hErehRSF79aRAjV6bM6aT5NXUmMmH84PFLwbETKg9tJ3Z52SIGQvzt7CRwFsbSyk35oDhwvHlA4FqexRn+hvB8NyqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ssrDYMpF4+bD825oiW+rpMkk5jMJRW3sohGoIXtvg=;
 b=Np0BgQaHNXgIPVbmTJEmSnYlADLgz2Chnctz+lf+oJpGF+f8XddFKTgbPyasJJfdyBg9vqk5PdCKzqSwZlHEn4xqw1I+c8wHcQ/WVbJl1pKVm1Jt+iPMyXSsSBJsJiTntnAg8de8fvibJ8QBIyJtg3htZ+UWbMMBKnz48MN6qW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by AS8PR08MB8249.eurprd08.prod.outlook.com (2603:10a6:20b:53f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:59:44 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:59:44 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v4 3/6] Convert neigh_* seq_file functions to use hlist
Date: Tue, 15 Oct 2024 16:59:23 +0000
Message-ID: <20241015165929.3203216-4-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241015165929.3203216-1-gnaaman@drivenets.com>
References: <20241015165929.3203216-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|AS8PR08MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: b283ec86-412e-4413-4761-08dced3ac48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uSF17XTBGYU7RuqO5FQIplCUADHQxq8Vmdjpwzw+dryCrz1GBbYLZlCEGteT?=
 =?us-ascii?Q?k7ge1oM8pG1AGRnBauJ7yOx8faR9y0nWiywrajewgCkXxuu1MXGgdCs1n7st?=
 =?us-ascii?Q?8PpxerNd/jQeJJY/Uyl/arSyr4ZkLyS6UOzQmV0yKgL0p+veUr6SDG+Tfdc8?=
 =?us-ascii?Q?POFg6Jx5vkiompoRzlscb6NvTd1+fGVGRySHxM3HXCeFR4toxl+rl1FTKjK7?=
 =?us-ascii?Q?6TSbQ5gBlvTClCQpXlrEXJtY2ajClHzxKtNLvJR/Ry/dMrzTWryC5H7Q1gK9?=
 =?us-ascii?Q?cxS6vOOviCaAK0y8RNbVgoQuJ3bTqeN3gOZ7HZiMVwTIFacrDAQaHeBPr2WN?=
 =?us-ascii?Q?lW1BjVKwIc/Tpq3Wk2eHBiqjDRQKSxvjRAS82S8sho/AQRgeFfj4CELuO0Ma?=
 =?us-ascii?Q?W746d//jduWcOuE9SVKoBVBxSoats3Lwnbp5EMj9wgAOzI2dsocJ79975oBt?=
 =?us-ascii?Q?L5pxpMiuYODKPyQgueBovbRK6ERQSnqYlbeImdv5kIWv2UhNA9RtRyb/9YF9?=
 =?us-ascii?Q?2FxvXCUKbKTaxd8iF3Fnn5XkxVyqVTbP3ybLoX/LGjpTsdlM6UD5sFGGUWoM?=
 =?us-ascii?Q?QDoU61xQhA4LojpSVyR4Zkjwp9dSShFaO+QHb628qK3V1Qok8ULqP+RM6gth?=
 =?us-ascii?Q?BsOWwRMuPCXYEsjiF9Dzuj6dXP/CnispDPxSizBUKejipqixi7PExR1SxTfC?=
 =?us-ascii?Q?bW0fR9FbQcyrwfKSmQM9eqBHxt0O6teaxp1cwBfNNs1y2NqWU5igdjIBod5D?=
 =?us-ascii?Q?cDMsKiqjbk84huN1OgqcCVc4B+6jh4GTPMqpuXWCXgTPPZ0s68wz6ia8/ETS?=
 =?us-ascii?Q?onBsW5EgiW3Jp6LRL3Zx/ctaHb6P+uwFjTDOl7FICFS1BYcox/cG5WKYpBIo?=
 =?us-ascii?Q?jFUX9Afvj8J9nh1/kPoXPgPHracM7s3VKeo6u53d0IB3pW4PN/P+HYxAGPkr?=
 =?us-ascii?Q?5/7kO08w5oE7tY2K3cblbFwSXRX2MbJHjBYkl0PkR7i1XpvtzO5DTpb6EKlu?=
 =?us-ascii?Q?2E775RiGLSnLZwH+1ChELx9+Ga1b4fYAvB5QhC4lvmwDbyAZo0Z+KJyyo52y?=
 =?us-ascii?Q?M8uHIqf/11ui9ZDkwTwcgfESz3CiwfN+63I3LD3/orj2rSJtykO0J8KpkZCW?=
 =?us-ascii?Q?bBWDvY6tIyMdTj2fQYZ891eBSy54u6mtjQ3O1kV+bj0idmbCeiwj08hivlfv?=
 =?us-ascii?Q?DONYx94UzXA/di12G+3y0rKluan/nD+zNmf9IcPjmTRSDqWeDkVzlGqFRipQ?=
 =?us-ascii?Q?reL3hjDmrFkvFh/Kn8jEYDtScQbH/ukLcWvLrLJD02UezZ+y9nilQxpyl3iG?=
 =?us-ascii?Q?pSD/16ySwvL8AxXJE2lb1mex5zTh4mxhAjf+E2fwyVcEMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RCgfI3XkwlLTT/3a84nFsdOHVMrRG4Fh98ZGDiBGvoVG8c4GTWugPQdWNikT?=
 =?us-ascii?Q?i2zWn8mnB03JFf2saPjKQc/5uCOfKhNs8FyfK0GIIB/XuTQAqpJsMFcdd5lP?=
 =?us-ascii?Q?VRbSlTPsvgGvI1jaPnKCgE75dMH7G1PXgWfNilxIl6T2OFsQsVumGHJXqlHm?=
 =?us-ascii?Q?+BpTuRnlb4oHOKaxi+GYUBqeoSMiRPrbTTOoJM9BnjA8H4j+9NNVVzewBjYA?=
 =?us-ascii?Q?x0HRzoImJJLAzfS4OHJLuDstFoareUXOVfZPdG4QA+NAYxc2TqGe6dNcgbxt?=
 =?us-ascii?Q?hMlmW1YVgsF4Y0kYUwCpB4tphh4vp8Qj0lkFYd4yZRs10pPAQrivl0y1NNVD?=
 =?us-ascii?Q?89Sl91cXdRp57KqQ6zZ6xKMJg99vmpBQxALWJsdi3EI7KVE0bbZU6GjaVriq?=
 =?us-ascii?Q?7OXdolAuyW88U4KIZARafOAYDT9pYe6wt5l9UL37steAHqxXamZbFzlXCSpD?=
 =?us-ascii?Q?095syZjG+PjZaP11Wm2MRxEl6Pa+yBf6ff3TdzZ7Yypi1ynApDbukAuhA+T6?=
 =?us-ascii?Q?FAclAL31p8dj3jSRxnJ+n0vNk4Kb+kANnBedn+ufX396iH56hXUp8gR3JRj9?=
 =?us-ascii?Q?xn/Yl/FxezL9RnNcdHEr8NHdSFh1Jtlyk4aNiMz6Jy5qFWAfr+Y+IbPAISVg?=
 =?us-ascii?Q?eKkPlsCtOOjgFFRtgBs72GlJDWeW1FuIfx48+z7d6j//TTKC0oXQMeIESdmx?=
 =?us-ascii?Q?Xd8Ts6SkWuCrkRMNQDV4b/6kopjSC/o+Xzp8cFIXF8K+sWQeNbq7raDPkB1s?=
 =?us-ascii?Q?8ioMzBuwGJ76h+4JSpF15ChCoGFHdIT58VGwcMZpbnf0gXEyQUkMyp1cgYuc?=
 =?us-ascii?Q?K20dX40ARLgP3gSbPpztS9IC/ut9wgD7HM6ICxnOY1M8+SmrlEPriBGdxe6f?=
 =?us-ascii?Q?8HMBkpHDqJAUm8YeaWlE+AfTRMU7XDmduYPhT+6RBoU9phleNCIH0i/HOzNc?=
 =?us-ascii?Q?E2evWGGyChJ3o/hgmzVqSWSpPkme29RDwqtBSGLlPAESqCCjlXtkgCrjxyYp?=
 =?us-ascii?Q?7joqiwyLq+zQz/7phn1iS8WUQTr1BmcLQ6dbF+V/jtU+BClJ7jgwuDmC8gT4?=
 =?us-ascii?Q?UB7c9rW21b9u5SoZpC8lv/h6cEy24+fHr7dS6bbmS7lxT+c9j08OUscxM6uc?=
 =?us-ascii?Q?Lz3SJcTWenWujyL9/vgWqsG8VFB1DbHZBqZk7MBw7xY3aNMD98m6Pqygtw7f?=
 =?us-ascii?Q?Z5+gUYtyQzsaigCpeCMlg2yFIRn1uCGfRTmzJYmPabeY++XMHXdgdeKIP0Vk?=
 =?us-ascii?Q?ORkUxec8ySr94JRPBpCGFAwpp0JzRm6PYO/2F+9uvlNPtd/145W+q6qsc4g+?=
 =?us-ascii?Q?BPE2FCelAxKfXUydh+R+gnElQeVL89ktBaa4CdORxHa6BysNQKAGAlr4wut7?=
 =?us-ascii?Q?5H9Ew1KZAuCr5sQ1W/CsFbXkKPCub0kSGkIwP9HzlrXOkgMqo/S0fbEz70JM?=
 =?us-ascii?Q?vJml784eN8VvyMmiSToB69R7bM6zBd1FAZnMHEVOSGghxlWOnnrTRf3KijxB?=
 =?us-ascii?Q?cd2TTEJMj3LkQSTwe38fHJ6lCU0bmWho90Djkuzl3MLA+658B2+CJbhRkjrr?=
 =?us-ascii?Q?tvmwykRp600uFDp1kfp89lr0MLERbTKtfovBZpGZAcI83DBkVhyOYyJSL3pR?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jy9H+DFbzbghi4Eejwam5z8tGvkUOhD3AhWko0VL9ipffuwNTslfeG//wTlpk9kptANSW7OSjGyqW23GE/zq9y/wZuRcT9D6wpuZe39T8xnN3jHlQq5QsieqNiC2UXtpdetd/bGuIr6TLoql96H3uxF64fGGKac9uadeNCQfFO5aKjXKz0lP7iCbh5YPyGfimp+6rcMd+19Tw+VsSTi81jOhxl7gT4OKB0zX43FjdcXtxtWnmIzUg1oh9AL2b4QfiqG4bvPRI93bT68b5n8WHRfHmJ/GkE5Vwh7/MdhF2rUfxv7I9tUTLf2StK94KLBh3k0fjhQYv6HYXwx+J/Kv1Foj6kRLNEFS3Pexa1Hv/f8AMOoPbBBSMYYu2ujav2ReLMrpQGel8nHQ00wu5Dngg9JPdPTHm00977XyX7Cawza5tWMimLDyxSm6DFL1VVwpV0pV4c86W5ICGnWEkM+gfiZNV8OhUHwME3aeFG3kZMjGcRue5+y5PcHzkUowfhaHlE7BbEVggJUmrU2Ueuv8UQiAesJiVDCUdPvnoln8UWTkGuQMBB69Je3sewga/udfUlg2GU5x05wJIHrI5Nky4ibU87Jc1NE3P6/sKjiExHwgnsbnMXFbUfdCadBOjWv7
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b283ec86-412e-4413-4761-08dced3ac48d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:59:44.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leRPBA09SCSRKE9YK8PdQ50psrqvdzziT9ISO+GjfiWlgvfkJOykowhFV2jMODWb9pI8djGkLzmbJt96JDjacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8249
X-MDID: 1729011586-a7Gou46vFKQv
X-MDID-O:
 eu1;ams;1729011586;a7Gou46vFKQv;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
X-PPE-TRUSTED: V=1;DIR=OUT;

Convert seq_file-related neighbour functionality to use neighbour::hash
and the related for_each macro.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 include/net/neighbour.h |  4 ++++
 net/core/neighbour.c    | 26 ++++++++++----------------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 2f4cb9e51364..7dc0d4d6a4a8 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -279,6 +279,10 @@ static inline void *neighbour_priv(const struct neighbour *n)
 extern const struct nla_policy nda_policy[];
 
 #define neigh_for_each(pos, head) hlist_for_each_entry(pos, head, hash)
+#define neigh_hlist_entry(n) hlist_entry_safe(n, struct neighbour, hash)
+#define neigh_first_rcu(bucket) \
+	neigh_hlist_entry(rcu_dereference(hlist_first_rcu(bucket)))
+
 
 static inline bool neigh_key_eq32(const struct neighbour *n, const void *pkey)
 {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e91105a4c5ee..4bdf7649ca57 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3207,25 +3207,21 @@ static struct neighbour *neigh_get_first(struct seq_file *seq)
 
 	state->flags &= ~NEIGH_SEQ_IS_PNEIGH;
 	for (bucket = 0; bucket < (1 << nht->hash_shift); bucket++) {
-		n = rcu_dereference(nht->hash_buckets[bucket]);
-
-		while (n) {
+		neigh_for_each(n, &nht->hash_heads[bucket]) {
 			if (!net_eq(dev_net(n->dev), net))
-				goto next;
+				continue;
 			if (state->neigh_sub_iter) {
 				loff_t fakep = 0;
 				void *v;
 
 				v = state->neigh_sub_iter(state, n, &fakep);
 				if (!v)
-					goto next;
+					continue;
 			}
 			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
 				break;
 			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
 				break;
-next:
-			n = rcu_dereference(n->next);
 		}
 
 		if (n)
@@ -3249,34 +3245,32 @@ static struct neighbour *neigh_get_next(struct seq_file *seq,
 		if (v)
 			return n;
 	}
-	n = rcu_dereference(n->next);
 
 	while (1) {
-		while (n) {
+		hlist_for_each_entry_continue_rcu(n, hash) {
 			if (!net_eq(dev_net(n->dev), net))
-				goto next;
+				continue;
 			if (state->neigh_sub_iter) {
 				void *v = state->neigh_sub_iter(state, n, pos);
 				if (v)
 					return n;
-				goto next;
+				continue;
 			}
 			if (!(state->flags & NEIGH_SEQ_SKIP_NOARP))
 				break;
 
 			if (READ_ONCE(n->nud_state) & ~NUD_NOARP)
 				break;
-next:
-			n = rcu_dereference(n->next);
 		}
 
 		if (n)
 			break;
 
-		if (++state->bucket >= (1 << nht->hash_shift))
-			break;
+		while (!n && ++state->bucket < (1 << nht->hash_shift))
+			n = neigh_first_rcu(&nht->hash_heads[state->bucket]);
 
-		n = rcu_dereference(nht->hash_buckets[state->bucket]);
+		if (!n)
+			break;
 	}
 
 	if (n && pos)
-- 
2.46.0


