Return-Path: <netdev+bounces-137415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314EA9A62B0
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60151F21412
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C6E1E47A2;
	Mon, 21 Oct 2024 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="cM9OacsF"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F67194C62
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506283; cv=fail; b=dQ5xbl2sN7nXQhooae2skoLytcpD/A6T3GeqKKOQAG4IGQ+wGFtCJGLWqJ3y96gmASkY6B1n4iM1QTBytQyyZpr1h2jgOhOeiclHwxgjuf6WeaQyOQss12B48+9K62kJVC9ak1vyzyfcEm/1aiTxTEdkiGUQJ4X5t1YWdlHt7Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506283; c=relaxed/simple;
	bh=kIC+fhwu8sjtq67PWLL7Yuqs39Wl0LnJ+X+PFeaVfUM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VWaQ7w+LOkyGmjVk2sHIe9TR2KQO7cQ5AuKLCkYXoRqkOiZJe1SaWg3q1Ui4BJa1BBYXh12gzntbs4xejLFQZx1ShvjZ99iEvWt3jyGy3WwamoXa0ow5BWSuXc2y9bdcP9CRECHOVMrpBUNZnMizT0/dBWSMGiPNlC96RagaHVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=cM9OacsF; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2FA1CC0074;
	Mon, 21 Oct 2024 10:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoArAG44rMEHF4xV1cpQooYEh7YRtvo5VdrGiYw4/qjIIQhD80iqwoFaeYZ9/4rWRej9/P2MBZtd7zgjfkAOM0DWEih1jrYH4ODVaRKAZ3SKsbdZNV77Egi57DDN0tye+yNSlRpe5WNq+Q3SschRHWNFUJ9BH7tS5+uyY4QWdCegxhRF1ZaIY6Gbj0hBs+P4KxeQ0HTz9R9isql/ps+ZxJ9+Va+DRTN9XlTEYVdfFbQ6FGOMrfuWmh6Ib1vVulL6WzuwGbdinDD49kcyuYvLS/nHHnU7/7CZFpLQFFbq93Hf03j1le7dSDlvYJX7pY2LRd0KV+3U8EMbMafjav8a+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2Kscf8KkG5GPmIPavVVs1GG6R+rN/pu4o+95Ofj5XM=;
 b=q0fKSnQAlMX9B19QEz599mwOqq+Ej7JIkjZTg+VnAxrXpDz5xaTuYKhIpquXDdLRp6BO++oRQBbxcmtfRHoC2LzS+RdHiUwctTRGQ2ph9ca5xd5D28qPZSp0znvr+hd+KPv+nSogC4LGPFW4+McY2hJo7vJgLsy3Zq75H7dD3xpyNHWLzEAs3K1mevWutyPyFaGJCASNo0EvIjP+U8fJOaD/+l/3m++8+z96SwiPp8Ncktzg2CFIuUq2UOfa0BTHqCmVXie86K9SzrUDXeNfcWXkFOKuMxcXsbmlMmhti49bJrZGyjWz4dhC7A/js0qtvleL7W9ofRdzRoNXVwfLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2Kscf8KkG5GPmIPavVVs1GG6R+rN/pu4o+95Ofj5XM=;
 b=cM9OacsF3VmDB6Wsl3mi4VhZTKf4qnbFIq/i7AwLYxSSmGQvoEgKqw73sTvIC0aRq5p+1yge/gQ+Be65hQ6aYD4eofLDsxzkOY5TrpyXeuHm/pUVL6EaQtJtbRip3229u4dZMj20RRzRJlEPK/7Wj1gLdJhK7qlap/4+LFr5T+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9051.eurprd08.prod.outlook.com (2603:10a6:10:470::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 10:24:31 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 10:24:31 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gnaaman@drivenets.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net-next v6 0/6] neighbour: Improve neigh_flush_dev performance
Date: Mon, 21 Oct 2024 10:20:52 +0000
Message-ID: <20241021102102.2560279-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
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
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 524c1627-d696-49c6-1020-08dcf1ba8cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rIM7H10kC06W5OZq4Zg0Yl6Wz7tgXpbt+BRk+3L2uQNfdOIU2JBcw3xhHKkI?=
 =?us-ascii?Q?DiReoswT1Ccgltogbzr4pXPJpc2GYMtk4dDz2SZnRgVzBKPgh4rI9riPRam+?=
 =?us-ascii?Q?H/4i8itfNtTh0X1y/WoAdP5jWIuCfioZ+PZtXOLi+bDYS/So8/C6RLiApdpF?=
 =?us-ascii?Q?VEl/+uPe8NRolUwnqbrE9x11feUfDz5qts0+IlPnytAhn90H7fSM180Qe+6y?=
 =?us-ascii?Q?BKd/dIOftBENxyFhNlj98ULUuLHP4OK5Z9Hw5G2gVR/vbwFQosjXSICec4qa?=
 =?us-ascii?Q?28Iuillozejdc5e8UrcmQzBHdDpmBQQAaqzbURq1drbbkF45zfldxWj2qBpF?=
 =?us-ascii?Q?w6d97jRH3+og+n8gVEtn4OMxn59kvPE5Hpcj/ucNoz0/jZ5Mzk9gMTykMYPI?=
 =?us-ascii?Q?ULeKSeNbtsyMIOhEIsjOUnpf4DNOKiIOYD18Piuo1/hJ+auobiCZDa0dJOjX?=
 =?us-ascii?Q?T9HQPRo+8TeLMRV0YaVfdtPwRKGjvy27ZytYz8xo16RBxHutCFyv0am1Wpa5?=
 =?us-ascii?Q?YARHRLuBGPy5I8yNZrXWBjcHlDHtD1rlXmI2QJ6NC73vK9SILPCM4ErjtGGY?=
 =?us-ascii?Q?J3DWhRUZs0YKsDKZnaQ4ze1nWAMD3bW83r8+yq2jgbjdZGVLGogkP7jzyat5?=
 =?us-ascii?Q?QaCb7Q5dOtzD4e9rp9gGm3ft3XBn1qdPesQpmY2zz4VV1NeukvFEwXQS8VGr?=
 =?us-ascii?Q?9wF7lvjh4dtHdOPFuwjT1yYjOjhgU8e2StFViz58EQ0t/3UPIEzBBlnFDCJ0?=
 =?us-ascii?Q?ZWoVLf+TNZ2s/JYOXG/HsShAxYf8kXLntMo4Z/d9G8poeEtwSiR3M5veKW1n?=
 =?us-ascii?Q?wVhkXh+ZJZCze6QagyuUM8NHZGl1rBTLt6rOEYNKXdnvIs6LkEScpriOSYiH?=
 =?us-ascii?Q?33KVlUTTyII4OIQ168lWdyE1mB4xokK4Z6p22iRwIrLPDvbz7TTX3uokEnZG?=
 =?us-ascii?Q?BhK8h86NJwPPphnOwvhZLsgjSp8udH3AgsDUsgyupJCyl0J9JLn89QhIUyc1?=
 =?us-ascii?Q?KNqwr5IvCHP7X5jMZivG1fLhuibIDwWZ483KMKMdGlz92RGEsmcw7TtYF7SU?=
 =?us-ascii?Q?JIGrcUydVql/LKzL68oSUvGSM10gUiEPZHDxcVbf+5v9yuRZ3tIuRK+OxDiB?=
 =?us-ascii?Q?oBz9en9D1Idc9rh+LAWVCUzJ6JIW4iUqoslTSev4AFa2pNtDnvkIz3BYClai?=
 =?us-ascii?Q?9DxqwGZ7gUKF2Tf/Lj4gYxeCBYH2hTUHJmJHnl/8fhozTJNyUpwduNXsdRQW?=
 =?us-ascii?Q?W7z7DmARF5GAP31KJMC10K4cbsNwBvaczv3oaWPcCi5wvWk/4y33ESRxRVpW?=
 =?us-ascii?Q?cfxWpuL6dyxQvx8nlzo6nDm6iWFBQkiWLWjsDiiwameNYfZekCtZm84b5EHP?=
 =?us-ascii?Q?9GGwdL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckbdnttGHlmNFyZX308+sxHaxNASj02XjXM4pYxL2G29YTctiNCfIQHIW1H+?=
 =?us-ascii?Q?tQ9RV+Qq9G7ObOT+etpJpcvQbVglcWoVXPcwcGnmSzkfjPAbJQpST7Inyrnf?=
 =?us-ascii?Q?BPXXnrR2eQS5sbuVkBBc8dX00SkmX1qWGCxDiBTBfcootVcUa3+l+uepWzGX?=
 =?us-ascii?Q?gaJVbfrgxNb1HSi9U9t+n58ug8x43+5KN65GSz8XRTb61VawBHjF9Fup54Am?=
 =?us-ascii?Q?5RZ1dwdCkiFgLqmU8LHcY4+EEkCQiGS+4yVav+9uUZ6Wq0DsdtYgqHZ7n6n1?=
 =?us-ascii?Q?Jckkzhq0NfvZMv1LTiA97qpV5B8aYbWjIA7BFUUvaPBswNono96OoecSx4fu?=
 =?us-ascii?Q?pN+G/1qR8dKmZHF4Qg3LeVJxZiHNDQlvcRKuwKdCXGg7MBA4LnsjOnx8qAgP?=
 =?us-ascii?Q?zxwqyYNmvKg21mFVZLiW1r88AA70G3CQwnYiLJwgK0XlmfxpNbV5fMlnObBH?=
 =?us-ascii?Q?LFzLD28oXn0qqXZay6dAXW/J49ocxD38JFAnPlWbLxggF1V4Fx0OYdEZO30K?=
 =?us-ascii?Q?gvnSCb94JeADPqFxEGSXgeb2pamrAX4w/9aX3ZCBiQJeTkd0G1gkDqitaEOp?=
 =?us-ascii?Q?0preBCGcpp7bornB/H5Y4TpcTRgCtrqmN2cFpEYv8dyWBH2B7T/rNxyRMFs+?=
 =?us-ascii?Q?Goi3jPQ++CedkKOF3O9ErLxoAS8oKn5X1RkWaIMoqVVEIQhyfouRrphagRDi?=
 =?us-ascii?Q?B0L0Yv9NqcSeyl1kmSRzKXX9emMYt2gdmq5q15NMDmU+KJdLMdr9sgf09dhw?=
 =?us-ascii?Q?zEoYwAoMSudhmgkgaqpdLjBkQ65lQqS9/wLdAI5q6gKfx2IPaQuA0CJiWsVV?=
 =?us-ascii?Q?5zg7xHcR5eIkzfL9k8GLIibXRzMJYLCHF0Uqathy3lA7kV/OULCSGw42qc2o?=
 =?us-ascii?Q?XPEzVEYK2hAQDrZ+kadZZ6ptW21lFD0xNp0AKg6YZcFHRkXbdIx/KJT97oF9?=
 =?us-ascii?Q?ZRzwWGB5/gDNWdj+EBtpmyJN0ww28wttEO/KlHrbg3iCQh31mm6byGV5qPsJ?=
 =?us-ascii?Q?0z/puOryJxtAkpe1dPhL4iSiaH/vj8lF6/v2SZBO8gSMpApgdC3p1Rw5ndEL?=
 =?us-ascii?Q?fAJMtW9jf6K8fs6dKFhf+J7Iodq5E+ktVmkinHD4Mjf0CRbkX/IwF8YxxyIg?=
 =?us-ascii?Q?4/MG9cvIQtpX83pPv96FEgjHd68KRFda31LQXKF7xpnUBKlusewp6kpNgDFT?=
 =?us-ascii?Q?34dsp5H89cbRg7dQYDTyij3eB4s26z4i6r/Je0tkP4B6jBV42nEY72A0r4wS?=
 =?us-ascii?Q?JNLdwc2Xqn/I43RpYFGAkVSA2zvq6JQs8sj7f/XDiel2JR5YXWcTAvjRPl2O?=
 =?us-ascii?Q?4UMWFVL95bvhJN0QYTKFMd9jtA+uN5BOWzM5MIB35zDRd3+zwiymhKIeuoVe?=
 =?us-ascii?Q?qJh6MTf4rVvJd3gt/I/x6bSWq1uUH6cwn5JTfrwPSCD076eqlXnCl+3ZXIEY?=
 =?us-ascii?Q?lxjweQmTVUlivi6+kAFIkgty+Kae6RrpOzda12jhlThneZJsexcccl5Zoh2m?=
 =?us-ascii?Q?Y7EAM1tQjcbJ5JRodLfNVJM+i1v7UGypY1F8j9zpU/mr6TnNWiCKhIxlKgzi?=
 =?us-ascii?Q?sRPIja6T/o15UkSDvNCJxsQSiX5xd/2UjIY+7XLjXEoWO/kvfRTPWkAt3zzS?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oOZd9HC9NKHnPxwKmBTow4nwfAaTmtZ+unJXWXtSTBgwtcwZ6Mgi7FCQXxYtp63sKBrMAQwsjonv7M/urSfcPlDxZR0/lX4zQU4bxS8fN7MPcwFOd1WKiFtuafbfYogvPyAbxMJ8uHyFoE5J6WMXhFF8wTaWaU2jU1v5nZUJECughM6VGK1JVY98dCzcCecojd1tGMwiK9WLp0OcLGA2C8yLF4A+bBIBz12pSJ+xvVbHuACTQIl3BP9/EFynGhBQ0qtXkYNGaei9d63/ZQGEJyVzx+gCpUejueu2iXgZtYUAlQIOpN/ie7wjbABn3M4xrI0QWOsmDV95dM1nu+0FW6F5nVO5YOHFm5F6JMpTuzTiyPRaWJoH028TPLjr2DQ06Fnf9z9qSdh6UlBcLzHqvVkPy10qaD8ddbMtWw8m2MXAJb8gdPxzmorYSn3bwqJO7sP8pmuKRd0uBq0guJoOxLCGMt6JnAqEu008ykdOpjcbQHJzlqkghBMHanF3ztjP62bFtrd0m9yJ6SsV8HF0hTH/zftUManje3lHWlnWSglxzVVWb3mGShU6PI5qogcpGazzSBnKfpOlZoewbhyN08Pc1uqTyjVPC6xaOgaTi4TK+cPaTX4OGOBTHv31jTbS
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524c1627-d696-49c6-1020-08dcf1ba8cd2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 10:24:31.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApEDDHeDuiJkW6oQMhBIK7oVF4+xPjlhcSQ8TkdVq6OZGJSfgP/qrQdmaOi9tB3Kcza+hp/hBm7bnyyK8gekWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9051
X-MDID: 1729506274-13njvSLbyJ5m
X-MDID-O:
 eu1;fra;1729506274;13njvSLbyJ5m;<gnaaman@drivenets.com>;495c1e7a27a6c3e35a5fabc922783896
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

Changes in v6:

 - Reverse changes to mellanox driver
 - Rename iteration macros to emphasize `in_bucket`
 - Remove now-unused variables and parameters

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
 net/core/neighbour.c                          | 338 ++++++++----------
 net/ipv4/arp.c                                |   2 +-
 6 files changed, 175 insertions(+), 209 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

-- 
2.46.0


