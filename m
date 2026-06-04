Return-Path: <netdev+bounces-295106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OC5tLAc7IWoDBgEAu9opvQ
	(envelope-from <netdev+bounces-295106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:44:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F1363E19B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:44:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=a69jwHBY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295106-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295106-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3DA03046355
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5863BB138;
	Thu,  4 Jun 2026 08:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011009.outbound.protection.outlook.com [40.93.194.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A13A1CFE;
	Thu,  4 Jun 2026 08:34:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562049; cv=fail; b=lcphqcK4UxbkIStCNdEg7X2f+Je6r95H9SoA5P1/hUwxEKPbR6WKnZx7CX9Bp3KQi7j1wWYY2qxggtL/UFgCGnYtmzMYFDZoyCoOCFHR+hHHUp4BnIvf4KMx26d4Jm9hXJxpk0m5/upeyIE5J8tNMbsySjPd+h0kJ3xRruSSaHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562049; c=relaxed/simple;
	bh=j1tjeByXeIHinLjHoJARApYbtqw5FLZrQo/H1IVDTic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4ohwzYZZpCP9b9SoACRpVOhbZ7x7ezdPj/iROwGdm8P23muD1lNUbDE3XAbNJk9bhFri0egLCUfeRPqjiq1f3YsZuEQ9Wsq9xq0u/P6xihGlwb/ogcT81PS6RV4VzOXamQRaozyFZKDZHKupfydfryL8r6B/5JZDb870gf5Bms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=a69jwHBY; arc=fail smtp.client-ip=40.93.194.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtzDMfbFE3pdYnyRp6roNWuDd2q+QWZisC/39q/yoYAzY+CrbJjPvgfwUVfwX39x3SwEfY6sfoP4l7MiLArlu73jKKxAwuBNUD46B2BPGZcCAfb4/J/T92HEM3BTTroc6OJX6L7nRQsN4FIBWQJAu2QBjOmvFVweWLGorVcVx9//iuQWX1MRlk3Syx98EMW59Gz0W/ebnFRozR+GR9ez8v5rildi6asbFkg2/TmW2a8t5g3s4pg3clP1Uzp/0SutN11rerPZpmscplmvnq63KvziN4vK1sLOLSsMzYcCoDG0qAMaix6KL72a6SZB1U05XG1HhbjoYYy+GjmG9Rnc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=FWKR09AsMNz5diXDc2qFq4T0EIcBo7/YEm6GhJQ2KHRbOBSVizvCDSdEmPPhRZ34VoGjYIQy61MQl/SQdFTbYMFJcRbzgxhcFg686QZZgKnuSdyr6hV82q9r3lwVlWgXysgTWqiGKJtu6C3x+83f6bD2I0w5aY6B4luUsye1vzXMxM54cql6KRvKevCFpijUh1Sis34N71CS2yphlbzuvRxLul3WzKgIAUNydChrvUfoQDtvMPJBs04zOLhBhoPKTpgnCBcz2aFwloPw/ilGuHU4jep4Kw/zOaKEkPv97mIoWp7p+ngmsAi7h9kqtiSZVs11U+WwFlBhx1tAEBUQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=a69jwHBYBckjj6zaZkmV7FWqiywdmPv2EqXs/1ET3LBkdcGrm2uKt9k/cvoDM3l9GopkAteJoEMxzwfDi4NxxF5TrbzNamBIUZ6R7gAKyDY/wwT5VppPr0we+wCGtU9RxXtHVp6//u4KV4+2l8UtNraCa5SLFV+xTTOc6jHpqKp+WKRwCSN+JdEI51HuZZGFx6UHFdx+PHAsHHSzXCgDlaXJ3vdZX9YXJBuWV59yP5xL4GbqGky5Aqpxt3BNOwQ0i614J2FE2EGZ+liEdn1MOncp70dKQgZ3g0Lwq0/I4ZIeZXIgoW9CbStF2TJ0gq1uVGzJ1W0soq+3tR3CaU22qQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 08:33:53 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 08:33:53 +0000
From: muhammad.nazim.amirul.nazle.asmade@altera.com
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] net: stmmac: xgmac: fix l4 filter port overwrite on register update
Date: Thu,  4 Jun 2026 01:33:48 -0700
Message-ID: <20260604083350.1701-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260604083350.1701-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7cd9b5-a9ce-4a19-9edb-08dec214028f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	/l4yea4tS1TCIEs54ZHl01loWqhNGKhER2NJQnAqYdIPP6cSXA4KT8KCxmek32NkzBIfQ8f2ZCwWm+UNnSdCPuF5OrWUpnRNx5QH38YyMMj/MiSDeqzNNwnnnRfej58BvsYBmJPq4DN9M98CBPDCkKFzzbsaX+bxd3IJLQNomiXjgIdh2u7GPQ2t6Abnd6LsgpSoxtay/36ES4tJsr6wVH1zrG9PwdJenXRL0nvMXydc88eETTz5nRq5mH+X9DUV+FuWWtfXfDgh5dlDZDGWmrfwdotZhH2BZ62bNXQvMoyngkz3aE1kNzd/SeLaIWAFD49TP0bgCIXYRDnOpie5YbQPjRxbdcx3wManpezYze6UsPVSRW5qT5CfDRiVWFqDZYTbKRTRp6QPdOg5UCrq279mR0u+Ty9DfHp3JoCoOs2RatdEBobTGw5BizH2kUweSfvWKHQWdwug2XFldg8g2NnG5Rcz2lqBE8PTmvdV9GW4622d8DqpY5j/4o+5bz7r61z++l5rdRx7YUK+nVk8veK8yKApFORqqnyRtf0ZKWk5sX85bpnwF8jOqUYSwPACYcOP4VFo33ca1w1LnqUxFcY7WkwDOmUBFUJtS+PmwC6M0mk9GMsaDoj2jvICqj76gATFpiVABIy2jRCPPTqSBYi7RbMzKADuXlErTQjx/ylWJLsiYs2INYlqEugDMv2Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j5cuHSzNEXWTUL5lq/Qx/CxRa9kvW2AYJWMz/HQlDDI6c6BRdqAykaWcGtlE?=
 =?us-ascii?Q?f2CETNRpSSxK/dr68zKi/XOBU43p93u/SPVpXb+9roleNZa9sct8MUd5Q8Xy?=
 =?us-ascii?Q?Kyj2hkyTN2HoIkuL5YJbPFQEL9toSHgFa2vbWcvOUF+utnYe+AR3+m95Az0i?=
 =?us-ascii?Q?ZAeUTucO3sEs3Gpsr4Bj9D/WASUpSdh50cx/7dZ9E/4MktqhuVVjrXvX75t6?=
 =?us-ascii?Q?iTxG5b6zyvuyq0xpBknkKVKrX8K9Ty3HLy8XBmd+fwd6LgvAvONFVEHR25aF?=
 =?us-ascii?Q?71mfyGiS3K8zuYFzs7RbQWIu4q0BEYbwnba/9UnJS9ySHHGjOrKVZbS+rzOe?=
 =?us-ascii?Q?fGwc8nuiLroZyG05Vo7l8GJLU6CcAf18rmkR0CRcEHy7OsJoGEKPytWFq/h0?=
 =?us-ascii?Q?itcmqbBCTEg1Gu84/J81PonB+NngzWTqEoxVuam/TOLL01BLH1tufC9+d8Gp?=
 =?us-ascii?Q?Tp8JNoBQ5PRpObt+Y18SEyqB+8ju1nA0jHsbkom78noLhFamdvQtmB+j1qox?=
 =?us-ascii?Q?rAaVQF3jX0knk8fK35SxloHhXnlNA4NtbNK7dRRt/V1gDgL+HioIHH8UVpVs?=
 =?us-ascii?Q?Q5zUstns1AOIhEhDc0aY43TDRkETzVZbl8eGxA/YksNAVtWYITc9qh9j7owd?=
 =?us-ascii?Q?7v1eeomWTpz0q861Pq2Og039oHggZOk9st/CVrW80becMHuhefSNi9veP44S?=
 =?us-ascii?Q?XBbw1Uk1sLw/yl9LTmhYgkuSW1tjvIJl2vUwsfA519BKFuZhr7mwlRL2e+ko?=
 =?us-ascii?Q?lg6xvu+2omzw86lctn0YOw5b9+uQz3OCTzqeM/XaMJgo6dzfKpBd/HyEeybR?=
 =?us-ascii?Q?hcKD7fWuwIsWDrzhB9eEwXUd4cWZahTueIS5P3hQ0FY7n3q6fPnO9sJSzw/+?=
 =?us-ascii?Q?e4JwiNOLJ7emyQIzY3POF5eH/MsKcAopsg81fQ8n4qO7R2eTLgj1X8Q7rNje?=
 =?us-ascii?Q?TZ6evMbiRhAMiOuW47I3Zd9xhqPo/BiulqdVbHJwUWd+V699whTBQ5AlXDdm?=
 =?us-ascii?Q?sctf0J5U90inycbdngnO52YHM5jnmNxqGee4jqLUncQY/cWSjVbryx4EX6Kz?=
 =?us-ascii?Q?DtcIDR1X4frmlyzOXLKziqxlKyN/aCxmpIVJ17P6exznBLCu+Dz3lGNUynng?=
 =?us-ascii?Q?jtKvPW/GCu4AFPUmswZF5WrCASRp/PBe78Heegq/ESFob+sFrJAl0w0JW5fO?=
 =?us-ascii?Q?i7MWzalY1wX9/0wLzeBtkLhtyN0xk1fKKJGRhP/6TGaz/Jdl2z10BT+l/VvV?=
 =?us-ascii?Q?p9UrzldbZRGVQ2KcVyqb2gJX4FKO34gsvsYzfv0U7EbUJ8UJOb/mmlpNb6Qi?=
 =?us-ascii?Q?ntNmrEQZyn0/9c+WWDEmMoEBJdCyQwG8aG58XW4UX65v93wWrFV1F6IxZKXg?=
 =?us-ascii?Q?yqT0hpGQWwL/RwVUaD+tynsChRX+4lVE5lgAjkIF2iXm09niNxlXqSVlApHD?=
 =?us-ascii?Q?/5k894txGsc9t8aBHxmfHOSv24ylXyr4WHFHUiR4KabnCRXp1NLaKAMCRqGi?=
 =?us-ascii?Q?LV3KoM99aYifzzjaAuf5P3tUlRo41Eok6WNigitc+vnpjTIEWae+HBvqnrHi?=
 =?us-ascii?Q?raMc2I9hXDuRNfweggdZsAraI53DdWbNW9DimRyJgY3x5qDlPC9BOQHh8zvo?=
 =?us-ascii?Q?rHRZ8b26NEHINWMy9LEgrYzzpSaK84EqQv+XGC3Syi3NTCIPKPzAJy5bRylP?=
 =?us-ascii?Q?E7R5zwvy8xgEKLsgb+tBs1JKS4Zw4bv3BVK8qxarMXKVpF4ejyT1hjqoeTZO?=
 =?us-ascii?Q?7uHQBsnbsfEVB7K3kICoMxCy6BwFaRL4rDDmILGRC42lFSzRInlkkp181V8H?=
X-MS-Exchange-AntiSpam-MessageData-1: KMlQ0KpH7J3huw==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7cd9b5-a9ce-4a19-9edb-08dec214028f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 08:33:53.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxIILy9YH4kHHovzv7HIvENbdNVAmXOGgq4n3v1OuhST1fA78HYBK+KiPrZTEwKtfOkFAK2e/qKoAMJGKEDnf7noU7y1gqcdhTS8G8mOMMIma8HnOBE4JxSV9uBsWZoAT4p8dqihcVPLCbCqHVy4Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295106-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35F1363E19B

From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

The XGMAC_L4_ADDR register holds both source and destination port
match values. The current implementation overwrites the entire register
when configuring either port, so setting one silently erases the other.

Fix this by reading the register first, then masking and updating only
the relevant field before writing back.

Fixes: 425eabddaf0f ("net: stmmac: Implement L3/L4 Filters using TC Flower")
Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
---
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f02b434bbd50..52054f31376d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1370,36 +1370,40 @@ static int dwxgmac2_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 		value &= ~XGMAC_L4PEN0;
 	}
 
-	value &= ~(XGMAC_L4SPM0 | XGMAC_L4SPIM0);
-	value &= ~(XGMAC_L4DPM0 | XGMAC_L4DPIM0);
 	if (sa) {
 		value |= XGMAC_L4SPM0;
 		if (inv)
 			value |= XGMAC_L4SPIM0;
+		else
+			value &= ~XGMAC_L4SPIM0;
 	} else {
 		value |= XGMAC_L4DPM0;
 		if (inv)
 			value |= XGMAC_L4DPIM0;
+		else
+			value &= ~XGMAC_L4DPIM0;
 	}
 
 	ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L3L4_CTRL, value);
 	if (ret)
 		return ret;
 
-	if (sa) {
-		value = FIELD_PREP(XGMAC_L4SP0, match);
+	ret = dwxgmac2_filter_read(hw, filter_no, XGMAC_L4_ADDR, &value);
+	if (ret)
+		return ret;
 
-		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
-		if (ret)
-			return ret;
+	if (sa) {
+		value &= ~XGMAC_L4SP0;
+		value |= FIELD_PREP(XGMAC_L4SP0, match);
 	} else {
-		value = FIELD_PREP(XGMAC_L4DP0, match);
-
-		ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
-		if (ret)
-			return ret;
+		value &= ~XGMAC_L4DP0;
+		value |= FIELD_PREP(XGMAC_L4DP0, match);
 	}
 
+	ret = dwxgmac2_filter_write(hw, filter_no, XGMAC_L4_ADDR, value);
+	if (ret)
+		return ret;
+
 	if (!en)
 		return dwxgmac2_filter_write(hw, filter_no, XGMAC_L3L4_CTRL, 0);
 
-- 
2.43.7


