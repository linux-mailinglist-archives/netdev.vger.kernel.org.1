Return-Path: <netdev+bounces-134196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38209998576
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA48B1F249B1
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8411C2DD0;
	Thu, 10 Oct 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="lH1w827k"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4F1BD4FD
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561722; cv=fail; b=ZGdbWl2Y/EGMT8VYjZv/oQrjXxB+0qJPFAsAeI/nYkbeQCkgaOND86bZcw4I9IWbg3/jnLeqEqyZtVzcYMUBB/z3hWotLigFPIe+OGcsmL7Ci/goS2rps2MhCFuQDckhXkvSbz9kGcDvI4Eol2PaDLZQzdXLd4SAEW9TeO3fwqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561722; c=relaxed/simple;
	bh=fwIZxAxDhbZn+Nxn6m8p7bg1JU9VpYmOAsmfXPwcf30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N0x4SCVQyobUJTAVsHwhf9HWUnQrGoaLwJPS5RpRpJh2ZsRUD9+WVqA3GghrkhN++gB3vDcfcgFi9HLQ8PO1yyXmsAD02BL+IMVXx64KtyMhsYQZ1tzK625gKrbUGIHZYNrDlOFRAcEXUntZCaiBeep9LHdnmcdHm+6LmD0F3mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=lH1w827k; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03lp2172.outbound.protection.outlook.com [104.47.51.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4C93A1C0062;
	Thu, 10 Oct 2024 12:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr245rYF5tGZruTZRSdjg4Nf1MStGbLUH5lENYBLX+UIixgQyDO3rngbsEnU0j0KhImmlMhE+vjOHDUQhOqB7nj87QQ+8hcJdgmyBmXDORmrOQ6E4g4T3swrZyOyyrfMUqg0ftgl9fCdfDVRZ3p4ZIGUS+gve7bFunZ6qveZ3yTFTnZbpMCtqDej2VQU/oo6fc/DD2gzmV/eIH5aNiiGnVz+fQNTKX+/BpZmgBEn8/+oI3dy1uQVXpUznwv+NStUSypY8SmPFQxenXT9ZPiconzhOE8dVOErOtRFs/34JKsFXOly5T0ecwDsjwsKZtGuqg0vaiDLXeseRbPtr02IFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQqNQaNaIw5ZhmAhzFasp5uSjKUMMwf/EiAZ+GjfQUs=;
 b=ap+QsPxbB4+1/dpYXOj8uQXI7r4cQjyuApd24KdN9nOjN6IsMbAGEnuVzfZ6noDmozDphyB5Mk4JD9jx7OH2XVJmZ81kzH1gc4NsH0KSCyelZk7EYyKdzBPeUw/52NGNWCI9XfUb/M02c6D3jGWZs6RTMRvhX6G6945BCSihLNg1HN/gcFOU53Y0WGi2/GZMQH66bc4Qzawgw/ujJHeN+Kw1v60jZ2k4nP5Fehco+GXv5u7btCR9c7TrksV0yXaCZznA0pNBFzlVTB5GPgISsjBQkP1B/SqZGUWlw8zOLafRWwpTfoQ/lVIBaHazcWoGf1UQSw2s8k+EuBjFc1RVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQqNQaNaIw5ZhmAhzFasp5uSjKUMMwf/EiAZ+GjfQUs=;
 b=lH1w827k40QKE9E0jNWcbu7l6zgQizew44O8x7Ca67Uj+nyr2bCBixY0T4Z8GgAo/BGzRA97pQnCOCPU2Dqibdidza7CwxB0T3FH6sGZcSEapbHUQWDL+G7jGadPfgh4071JFVy+5Ir8fWpXwqDWAzmjA0UuaWr0OJ/bTDanNp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB9909.eurprd08.prod.outlook.com (2603:10a6:10:403::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 12:01:51 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 12:01:50 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: netdev <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gilad Naaman <gilad@naaman.io>,
	Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v3 2/2] Create netdev->neighbour association
Date: Thu, 10 Oct 2024 12:01:25 +0000
Message-ID: <20241010120139.2856603-3-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241010120139.2856603-1-gnaaman@drivenets.com>
References: <20241010120139.2856603-1-gnaaman@drivenets.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: daf230f9-e956-430c-0704-08dce9235329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b9q5xg2qfuv353AjfiTvUQ9vhvP+BwirWZKsSB6WdpZKC6mONYpQrswBRJZG?=
 =?us-ascii?Q?8RlR9xb3rkXUBuqYlSKMZ6C5R1IzOCFXQ/EuzLP7C8y6FeApAEWreLbVByIO?=
 =?us-ascii?Q?BnsF74e7EF44rGFUv4VF49Wtw33EqNiY+Qb0ygBXNeSsUKzdh/NLl833iHwZ?=
 =?us-ascii?Q?8GNX5FNKemFyXTJEcC4M+3i9+nyfyVBUsfcZ2YErf9GM63mPEdp04c3aufnX?=
 =?us-ascii?Q?CyZzp63ORuUtLJvZTXjkMj+U1MiwHDazihXmcYIH4dRkXJkHdaw7eVj/1GT3?=
 =?us-ascii?Q?aL/TuoW65DWjBoDTEeaDFQaCzfDDHmNfGziRJhxl0eP+xvOmWJ7WoNbS+y1p?=
 =?us-ascii?Q?UmygnJJfShKF0vxoC4CBIIcLMI0DXZ4+UgG3W6HbJnAwTpSSTY5Qu6ldE06J?=
 =?us-ascii?Q?1eLtrsdxv9nVhGxLp0ldCVJHv6ygg/cspeekpQQJnZfpO5lCiK5lAGHYOucN?=
 =?us-ascii?Q?pbHdXoJUQ1kZ0Q5nBGvmHY7JEWEKsL1zvSJaO6/mYTBbdgIER2FSSCwiFYNO?=
 =?us-ascii?Q?p8v/39ADJGxkkji6mxznv7qJzCOMUpVnJHyp+3/lOxuq6sCTtxgjJ1BDuqqX?=
 =?us-ascii?Q?gic8l6U2atgrJ32bL0kajIzaVCaCnNVnixNAj4NyVaQFqlpQJ3BKABzOQ4GT?=
 =?us-ascii?Q?CFAFLyP29GxeaNFe9vqJQVBwM17Pt2KA20HFC2vYJnb9xV8s5tasHjk+IjJl?=
 =?us-ascii?Q?syPSURbTa2jGkiYllWXntM6rdkah/pPuqcCmuy3aA3FzfBYPldBvhmuQyMfn?=
 =?us-ascii?Q?Pz/ql4IIeN7S/jzGFvDamrx6NILrcQDA1WHT+bB3XNP9NANOseubSmgrz9D3?=
 =?us-ascii?Q?bDKs05NfEnXlTHCi0/FKVUlR+F2+3tYQ8D91OIxxnm7/7vDnD4uILgTE5ALr?=
 =?us-ascii?Q?ZGjJM7ei9bhIQo6i3cXO5FeSW2PZJJOY9xQCVQEmA0ZOvCVL2yRj9xle0zqQ?=
 =?us-ascii?Q?SNgtwKPG0EzD4au0KQwWkBx4kEfq9C27LzoVWP1p645VJ0cnewOeArzsslsc?=
 =?us-ascii?Q?dY/C0O1RCZmDxEdhNMhmpiTbtkaDyGhK65c0yQvdIK7vuGm1VH+gd5H6K02e?=
 =?us-ascii?Q?uO5c43Mrr94PnDj11BvKTFYpTo/bbJmV1sMpPrABgohWi6tBGcoMt+Yepo9S?=
 =?us-ascii?Q?sg2WymcHtkHlVjJyfE7vV5o3c1r/oSvprOXXENKEFQ1TLsEP9dhAqv+PxM0n?=
 =?us-ascii?Q?VK8K1V72n7nfTUt2I5/hdcEg2UOgYHk4AWuB7s4IkZl/nY6kv3+h6/JEJIQi?=
 =?us-ascii?Q?CZt0FXiF5WBN36c91F2IGT3ZK9eeBt92QqjS5CJKXc48P0WrGwwptWwfneqg?=
 =?us-ascii?Q?/odKVynEFqy+BSi81tKxkSEeKpq70mLURWwyrXaT56Phig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxJghioerHSLMu2aL1qD1vPlI4tctnK8pLANzyK2v4EkqzKh4vbiiw8nwnog?=
 =?us-ascii?Q?i+1i1SSvnn07w9h2drtxfDef6gIbmulgOCneWMNjFFDulGsD4caDnHkXzGlU?=
 =?us-ascii?Q?/5sWVgASVQSnNxDoT2+t+Mz1W2kKBR1wmM5gNkBhYNTwLE9JEesSgPCZ4n0z?=
 =?us-ascii?Q?GFmkpZC2ENzMDu9A9B8G8BXjtq3eKyf0Cz/1wNkkiiCj1W1XYUuzxKKpaO0L?=
 =?us-ascii?Q?RbPDCQLwOs4sLX2hJU8q+5pKqiL9O6N7ZRrpHHnotXTl5OufOyotjcamU0VX?=
 =?us-ascii?Q?FFOa6rBdliRGQ52BsXHFeUX1bdO3DXyifcXZY0JHEoo/J1/ZDnvJaOmYnXqc?=
 =?us-ascii?Q?ROjzymyee3SHg8i36ckCY0HQDF+SXooIdYiWUxDxKUJ7qI5Z8Zw5+lgq5Yi2?=
 =?us-ascii?Q?qljasT9HPx3xcteyvtXpRR4fo7KvpqTM8Rtk+TK3vAn7gKi0uUvhM0xUYmXQ?=
 =?us-ascii?Q?cKUITnA06NlDeXLXPaCTcXJmLvpap3Jmf2eM1OgDkA+YeNhLpQcEfIjM2nR6?=
 =?us-ascii?Q?yFlnUi8qKokqJhtPTsN//iqiXbW2ZGBG6xoIcW6ZEntIJey9Oupuqf77+YSL?=
 =?us-ascii?Q?73eQsnuBJjeJaQ0MFxX4j7qRUARaIrpWRb0OQ8I+T8Ddf26x9DU4dvRz7mfo?=
 =?us-ascii?Q?A1PJxvAP0CllTGdDy66R3jWsftQYKKnlu1bkE6Tbd0lspu+U0stsNAp8Gv5q?=
 =?us-ascii?Q?RMizw3iQLneFMV6K6MF8e48VQu1SFBMeX6tvm3Y+VTj+RfHlY0wNgLRV21DB?=
 =?us-ascii?Q?+oUIiVpwY7aJjXeHNMubgnaREE3apOZPtag3RzEtFpERwecPaBBEnxnOPFdA?=
 =?us-ascii?Q?XdYTxKqtbRkvNk8NIGSZmd8W2+RKhsjFfpIRRW2PMBWeU/zQJoHmOkxx4SwZ?=
 =?us-ascii?Q?a5REp+nzhViCPpYUnNQSzm7RUXCVPQHDpxrls27CEJy39x7lkQlFk1SWSzuJ?=
 =?us-ascii?Q?s9fxB+LQg6L1IDwcuVaBD8kbYsTf9m1tJ7nW4RNp/A90dbJ2hGTIDvLJBY2U?=
 =?us-ascii?Q?yN1ZadZ1UJPBEagJtLxn5WHHGfNje8p/JcrdmmIQKLGo+h2Jzz14xUpmMbYs?=
 =?us-ascii?Q?iS5OJ1qZDQcRVN6gUs6/zhvyzIm2TPFIF+uEDhD5T8zUhlwmUkdRj8KUzhIt?=
 =?us-ascii?Q?ZpoUYQmaVpy47o/SDo12cptrr+eGN7ikTUGd0eGkRadtze3jQWdgIIUdfEUf?=
 =?us-ascii?Q?/y4Ng9NAX6Y6+BerCf/7egpnJUc692mLXS0kb2WXx7Tz/HAwXJNikUU7rM8+?=
 =?us-ascii?Q?Q/x4O9+OXTKxEYG44imZKDXEQQalMZ90RLADuwbiprph/LG8uTwBWRGlRqDg?=
 =?us-ascii?Q?cXZWAsnFQxVyVWxT51xeV7bTUL2cT7sqzs+QOol0Bw33+NsfvadzzFVBjb8z?=
 =?us-ascii?Q?qTVk/o7+5qTd3wE8Kpk/Pthg18nVi7AKNC/TeiktvRI2ZOFYBltYYtBW5CZ8?=
 =?us-ascii?Q?o+th087Kzj6RYIQvH+Er56w86+H2j0O+UV0/Ih7oeeK7pd+vxgrsyPl03TGH?=
 =?us-ascii?Q?RqrwwEndbYLOlRk/t5C+cCId4XUOpcWkBL/RI7/YYniHs9CYpgo4oQCB+2zC?=
 =?us-ascii?Q?p49FER8NH7wv4oqvuY9hAyBBtOTy+/3Cfz53x3qy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RvEbdQoqBl9AVrL/CpCRORwXk6FnZ0DNX+OaJNHJEGT6NQWlkK2wsLNwLcj+1KmDzvJb/lyIN+v4uw80nEvNTOfV+BHInLyxvCPHVQw3Oe5pLz4GkO9l5zzXW4FeydVpsN3KK89iVHE3TuP0YuqHPZPqMYAItk0jvS+1pYGTYnRuesQWHtvait8qsdtTJj4fcfabW4LlB3/+cwjQol0Bz0VbSu/I5OCmDE6Uyy2ELZ+ZoO7MHk1mncVQ3e5qqaK01xc0TxG1ljM7UZWFxSWu6v+V5Gc4ivjs8eQrrZlX4q4qNzz0IrMf2kmJcjJ6dSlOQqiCtpnHsA6K1NR2cw3JNU/CPMgv5+ll3BHL+HIJkozSnDd6tiRhqvqxUT8bPjzGfLBxvECqe9yHmGG5+WL8GJjVtuTZ9nudlhYjTybp9YUyjNbTpxx3Lk4yhIBCjX5rl15XWxR2WmA2zyBbzJPkrLWJef8iP060g3LJtsNQNvFO4v6tqzeLlJokTHB0RTZrbpti+muMmWu7c1/upzOkOxv9t+tAeLyvDvH7aywD9yZfOGiOKohYKUl3+hsjnqiq0htGuh5Cyiowkj3Nx7XIcMPNWhy58lTrBDEc03lP9WYWRglR19LfpQhom9u3a/Iz
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf230f9-e956-430c-0704-08dce9235329
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:01:50.9367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr/Ch150EZxuNTBUUsuvX0M5qxYthez6+ocqAWkZM4TGr3FycvwywXOyzuRWne/F12ks31WHzsJ0jdf8MyfnHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9909
X-MDID: 1728561713-klDZZ4FsnO-B
X-MDID-O:
 eu1;ams;1728561713;klDZZ4FsnO-B;<gnaaman@drivenets.com>;2328388050003780ca43480a2715a176
X-PPE-TRUSTED: V=1;DIR=OUT;

Create a mapping between a netdev and its neighoburs,
allowing for much cheaper flushes.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   6 +
 include/net/neighbour.h                       |  10 +-
 include/net/neighbour_tables.h                |  13 ++
 net/core/neighbour.c                          | 112 ++++++++++++++----
 5 files changed, 109 insertions(+), 33 deletions(-)
 create mode 100644 include/net/neighbour_tables.h

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 1b018ac35e9a..889501a16da2 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -186,4 +186,5 @@ struct dpll_pin*                    dpll_pin
 struct hlist_head                   page_pools
 struct dim_irq_moder*               irq_moder
 u64                                 max_pacing_offload_horizon
+struct hlist_head                   neighbours[3]
 =================================== =========================== =================== =================== ===================================================================================
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3baf8e539b6f..900977881007 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -52,6 +52,7 @@
 #include <net/net_trackers.h>
 #include <net/net_debug.h>
 #include <net/dropreason-core.h>
+#include <net/neighbour_tables.h>
 
 struct netpoll_info;
 struct device;
@@ -2011,6 +2012,9 @@ enum netdev_reg_state {
  *
  *	@max_pacing_offload_horizon: max EDT offload horizon in nsec.
  *
+ *	@neighbours:	List heads pointing to this device's neighbours'
+ *			dev_list, one per address-family.
+ *
  *	FIXME: cleanup struct net_device such that network protocol info
  *	moves out.
  */
@@ -2406,6 +2410,8 @@ struct net_device {
 
 	u64			max_pacing_offload_horizon;
 
+	struct hlist_head neighbours[NEIGH_NR_TABLES];
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 93903f9854f9..f86f552e1860 100644
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
 	struct hlist_node	list;
+	struct hlist_node	dev_list;
 	struct neigh_table	*tbl;
 	struct neigh_parms	*parms;
 	unsigned long		confirmed;
@@ -236,14 +238,6 @@ struct neigh_table {
 	struct pneigh_entry	**phash_buckets;
 };
 
-enum {
-	NEIGH_ARP_TABLE = 0,
-	NEIGH_ND_TABLE = 1,
-	NEIGH_DN_TABLE = 2,
-	NEIGH_NR_TABLES,
-	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
-};
-
 static inline int neigh_parms_family(struct neigh_parms *p)
 {
 	return p->tbl->family;
diff --git a/include/net/neighbour_tables.h b/include/net/neighbour_tables.h
new file mode 100644
index 000000000000..ad98b49d58db
--- /dev/null
+++ b/include/net/neighbour_tables.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_NEIGHBOUR_TABLES_H
+#define _NET_NEIGHBOUR_TABLES_H
+
+enum {
+	NEIGH_ARP_TABLE = 0,
+	NEIGH_ND_TABLE = 1,
+	NEIGH_DN_TABLE = 2,
+	NEIGH_NR_TABLES,
+	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
+};
+
+#endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index bf7f69b585d6..5f467040c32c 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -78,10 +78,36 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 #define neigh_next_rcu_protected(n, c) \
 	neigh_hlist_entry(rcu_dereference_protected(hlist_next_rcu(&(n)->list), c))
 
+#define neigh_hlist_dev_entry(n) hlist_entry_safe(n, struct neighbour, dev_list)
+
+#define neigh_dev_first_rcu_protected(head, c) \
+	neigh_hlist_dev_entry(rcu_dereference_protected(hlist_first_rcu(head), c))
+#define neigh_dev_next_rcu_protected(n, c) \
+	neigh_hlist_dev_entry(rcu_dereference_protected(hlist_next_rcu(&(n)->dev_list), c))
+
+#define neigh_dev_for_each_safe_rcu_protected(pos, n, head, c)		\
+	for (pos = neigh_dev_first_rcu_protected(head, c);		\
+	     pos && ({ n = neigh_dev_next_rcu_protected(pos, c); 1; });	\
+	     pos = n)
+
 #ifdef CONFIG_PROC_FS
 static const struct seq_operations neigh_stat_seq_ops;
 #endif
 
+static int family_to_neightbl_index(int family)
+{
+	switch (family) {
+	case AF_INET:
+		return NEIGH_ARP_TABLE;
+	case AF_INET6:
+		return NEIGH_ND_TABLE;
+	case AF_DECnet:
+		return NEIGH_DN_TABLE;
+	default:
+		return -1;
+	}
+}
+
 /*
    Neighbour hash table buckets are protected with rwlock tbl->lock.
 
@@ -233,6 +259,7 @@ static bool neigh_del(struct neighbour *n, struct neigh_table *tbl)
 	write_lock(&n->lock);
 	if (refcount_read(&n->refcnt) == 1) {
 		hlist_del_rcu(&n->list);
+		hlist_del_rcu(&n->dev_list);
 		neigh_mark_dead(n);
 		retval = true;
 	}
@@ -375,12 +402,63 @@ static void pneigh_queue_purge(struct sk_buff_head *list, struct net *net,
 	}
 }
 
+static void _neigh_flush_free_neigh(struct neighbour *n)
+{
+	hlist_del_rcu(&n->list);
+	hlist_del_rcu(&n->dev_list);
+	write_lock(&n->lock);
+	neigh_del_timer(n);
+	neigh_mark_dead(n);
+	if (refcount_read(&n->refcnt) != 1) {
+		/* The most unpleasant situation.
+		 * We must destroy neighbour entry,
+		 * but someone still uses it.
+		 *
+		 * The destroy will be delayed until
+		 * the last user releases us, but
+		 * we must kill timers etc. and move
+		 * it to safe state.
+		 */
+		__skb_queue_purge(&n->arp_queue);
+		n->arp_queue_len_bytes = 0;
+		WRITE_ONCE(n->output, neigh_blackhole);
+		if (n->nud_state & NUD_VALID)
+			n->nud_state = NUD_NOARP;
+		else
+			n->nud_state = NUD_NONE;
+		neigh_dbg(2, "neigh %p is stray\n", n);
+	}
+	write_unlock(&n->lock);
+	neigh_cleanup_and_release(n);
+}
+
+static void neigh_flush_dev_fast(struct neigh_table *tbl,
+				 struct hlist_head *head,
+				 bool skip_perm)
+{
+	struct neighbour *n, *next;
+
+	neigh_dev_for_each_safe_rcu_protected(n, next, head,
+					      lockdep_is_held(&tbl->lock)) {
+		if (skip_perm && n->nud_state & NUD_PERMANENT)
+			continue;
+
+		_neigh_flush_free_neigh(n);
+	}
+}
+
 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			    bool skip_perm)
 {
 	int i;
 	struct neigh_hash_table *nht;
 
+	i = family_to_neightbl_index(tbl->family);
+	if (i != -1) {
+		neigh_flush_dev_fast(tbl, &dev->neighbours[i], skip_perm);
+		return;
+	}
+
 	nht = rcu_dereference_protected(tbl->nht,
 					lockdep_is_held(&tbl->lock));
 
@@ -396,31 +474,8 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 			if (skip_perm && n->nud_state & NUD_PERMANENT) {
 				continue;
 			}
-			hlist_del_rcu(&n->list);
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
+
+			_neigh_flush_free_neigh(n);
 		}
 	}
 }
@@ -701,6 +756,11 @@ ___neigh_create(struct neigh_table *tbl, const void *pkey,
 	if (want_ref)
 		neigh_hold(n);
 	hlist_add_head_rcu(&n->list, &nht->hash_buckets[hash_val]);
+
+	error = family_to_neightbl_index(tbl->family);
+	if (error != -1)
+		hlist_add_head_rcu(&n->dev_list, &dev->neighbours[error]);
+
 	write_unlock_bh(&tbl->lock);
 	neigh_dbg(2, "neigh %p is created\n", n);
 	rc = n;
@@ -982,6 +1042,7 @@ static void neigh_periodic_work(struct work_struct *work)
 			     !time_in_range_open(jiffies, n->used,
 						 n->used + NEIGH_VAR(n->parms, GC_STALETIME)))) {
 				hlist_del_rcu(&n->list);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 				write_unlock(&n->lock);
 				neigh_cleanup_and_release(n);
@@ -3102,6 +3163,7 @@ void __neigh_for_each_release(struct neigh_table *tbl,
 			release = cb(n);
 			if (release) {
 				hlist_del_rcu(&n->list);
+				hlist_del_rcu(&n->dev_list);
 				neigh_mark_dead(n);
 			}
 			write_unlock(&n->lock);
-- 
2.46.0


