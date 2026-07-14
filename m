Return-Path: <netdev+bounces-307341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ycyeKUehVWqOrAAAu9opvQ
	(envelope-from <netdev+bounces-307341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:39:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B8E750687
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:39:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=jCT6gDgY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307341-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307341-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED71303B7CE
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD513815CB;
	Tue, 14 Jul 2026 02:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D1381B00;
	Tue, 14 Jul 2026 02:37:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996653; cv=fail; b=eWDpD0yAYbrSXYDTdBDQ2+4sW45GdlWTPm4esW8pnyDfeQ7ytTY87GDbnpgP6U9XBtKQaEHCVDWhthn2Dz4fId9ZHjExnO3Ci+9rPokBiRbXJvagyfw5PdJxZ7++5PsBDNgfxJ49mX6Os5RPU5e3XLtdWF89EG4w6JcTqgw/KDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996653; c=relaxed/simple;
	bh=j1tjeByXeIHinLjHoJARApYbtqw5FLZrQo/H1IVDTic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nO3Fijwryjjppcp/8wqxt9zZqNhySRJQwmZ8ATTw7PbKuw7dyWGMHsyW3qIOBXkWCrzdsQuhXtVjXdSBP/XadU8hMs+v5kd8LJLn1ZmQLNnEWPaAiYGP3OgybclG5+uA/SlnpUV0L6JEVmgTLnSlJxgk29Yt/l1USu9kSwM+B2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jCT6gDgY; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W98pWArnnUyCNg0AB3Ue8gOWVugEdr+zCTAd1xXIHzeVWIynXdN2pxj3aqv0BvBALnF1jxWKYPapJeSL0HOZ/j42r2w+LuLhIvxzAeeZH3myBCZ9/j9EDT8tc7/XwZCObxNIssfvsYLZZG3LItqeSTx47KSF7z6OJaHbDx/79qw5UUGIhqclBhiWaecSEJdzmSa556pXCh8qO/9ToTJO9kBYpckAyANEmG5dMxrXrqUaRMPYdsADsLsKrqxzD91YSfJbRvXKR4G5X0S1gTD18YCtXWEVCT712iwcYvJrjuAV5mBxz2OZu8xBF9iU65lcVJ61C9DobcPlhyVn3ReTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=b01TPkqKVsVGE9saRyf6PVtgzKGP+u9PS7Fa4/kzImWaG6enyQ4tKQSX/DSY5cteAiWL6PZNGxpqu5ldR8W+1Aanln0cVb6XdVjn4dpCANMZ2JJ1Oli8Ak8q1W8UIXdENN5ZmnK2bn7tCkGw07C/YDs60wN2KoubFqwZZFbHhG/vw77eVtsWLGJSKTYDWcra34AQ3U+uxjqXjy6ixt5z/HNx+EZPZYLpEfOK2jb9/Jn7ZXoKVl1lsfh3oxbEWS2rd92hSw8UvrviGEiG6YwUDFPAZgKa9HpjHtLP2v1gwzzpUtWy3i9KIcdurkEKnzc2BnNX8Wnw7hYcoimD0Mfsbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=jCT6gDgYx/1e3dOapej8zr6prMsUhXZCr6AQuyAbHBp2yA+S3D7GSAiCfEwRkZkxxQaMl00r0I8thHsQWtpxVzFj0dcB26YTJG929fTmVHTaNSnyifoTNDKQXHJrjXVl0k/5PYVPk/DrLqE6QOkKsblM0aikPv36VP4DDTXtx+T0F/d13PKAebrIZ4luW0igkSva5YPN6Oc75H4l/A/MFBOu3g8W+hu/nfQsAmDgsGO+gj4HuTaoTmaow8KelI/exSylBa3GVcjP8AUQcluAGo9C4r5PhG2Bk1KhWN1kf3qACpRc/uoHOvr7krgtT1FcJIzRl2xq2i34c8IR4NMgTQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DM4PR03MB6032.namprd03.prod.outlook.com (2603:10b6:5:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 02:37:18 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:37:18 +0000
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
Subject: [PATCH net v3 1/3] net: stmmac: xgmac: fix l4 filter port overwrite on register update
Date: Mon, 13 Jul 2026 19:37:14 -0700
Message-ID: <20260714023716.29865-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260714023716.29865-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|DM4PR03MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc602f0-d6ba-469d-1e15-08dee150d279
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	HbTjE3TI9DRIGBKhdM5ZOxH7RC1wJ1hXIias/I6Ss9MVbVg+or/QND8w0+5Zr/DHeo8ZdkFdnvWtVFl0ctJR0OCWynuf0hcHvZoLuuUiQUG01CqfjtEP5855aqAGSSOs0Fv2hcCjSrsgx0ygzTfbIt9yA3uZMB36+rTLIF4deqF2SBLVe31KXV4CCfXy3b6kFLrFQuxhcU9FWHzuVmNLAF3Jy2ZlNxRHzAInsPBcdnfUQ4y6SVN8OI99mBOAT8E1ZXiDMUoI3Vi9YImnF4FiQTqD6sal8x99oHMNTHQGlOKj8V2wCci7/T3uzoDQXhJokkoJmbGx8ZGyoJHuQP0fxa+e9fvVWxu+N9YmbAogXPc4gXabC2ug2gObsVOdEpRD5pXI6z5Qop8ufy8GrG4yabMKS7DqUeSu0bBNWwxgxS9QdrPwtx+uo2ElRFbUpMPBqbuypuLb0adE8zCWDzXIM9dFDjQaW94eFiKo15+zGS43UJXd/0q/9ORYzo2sdzzsCQl1OMASv6IGcY/uJG2O/t7skFq9ardMM3+KVqc4YWj+cgWgJ4t/sst4vK6d4o8EuS60VN+Xtk6j8cclKetAZ8PkdOpVoC7iWQ5iip6ziHLrfIoU8zQK3x2Bh7ZdUM9DqipjuU85AGQB5tYyL4Z+/VPi+PSmBbBRJ5jyNXjnWho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQGfhlK1QbDUXOWxcExUsmsP8inAouSLszVFI0HjYVQ5JHl1BrMox+QzbsNG?=
 =?us-ascii?Q?WL4iIAJeJwC26eyBDxsDk41Tkir4dPZOrgMomeG3ZNPMfBJLkyEbCTcl6qTE?=
 =?us-ascii?Q?LTtrEP03Dko19ulXXXJ7yFw7z0XX/EnJLnrFEZIDfR+G6a38cqNaSenEHzGp?=
 =?us-ascii?Q?b+DJX7vLNdJa9XIOsOhB+CiGKe3tWAVtfTuq8QKcYyjItoeyFYLqD1JANM+N?=
 =?us-ascii?Q?zWQ1GpqXBgQVKTcQc6c8j+dpZC5szqlNjleTzN4LWU5CaT6s876DXvc8kvwf?=
 =?us-ascii?Q?b1LlvcIZg4dixAm+/obqtOK/idugp0/G2oJpBHKPVsA8K3f6bSqs5fPO8sfP?=
 =?us-ascii?Q?juS5Qm3qlOgiWcATxhxZy5LJj9u2hc2v2PPd7DeDH8Scnh2q8KCP6+pAi7d1?=
 =?us-ascii?Q?+xcx3aNXVTQmhwCIYmEChQ+t58L4azxqmOuqH6I874cuDnwSwb6/KR+E7RTJ?=
 =?us-ascii?Q?NpVFM3F+d8NSbExkf2Hlt36myaReCV0yGv+fpxIoTYJweIuSG8dISEov/YwT?=
 =?us-ascii?Q?86D0WilgYzOlCkk5n0VucbtM/pQFeCZOWiGHNfc7S+T8UtBLYusJ+h7iCuPl?=
 =?us-ascii?Q?fNdMP1eK8ppDe2iYJeCljJO6xCSq+Tia3UXIOwv302Yjq7z36ft8TFPkMHpV?=
 =?us-ascii?Q?cMIr/YUQ9utukQ39U+cf6blFjMwbjqUoMnXwmmt0t7KIyXIXm/E2tJTHzv9l?=
 =?us-ascii?Q?4RFuVQtHFG06GWgHyK5QPG7SYnnIwbGOv2JM1HTyaqtcPHG9PzZN5HSO0ibD?=
 =?us-ascii?Q?VQMhf5tNdOIRkhtzIeoEv5kkd8Ay32ahsfWNr9cu8eiYedZQKsXdoFEYm1rf?=
 =?us-ascii?Q?qbWWDp1QcP2zb+KVUdN7Hf9Zhk9qky212DXyfbjdkbJNITtc0RRC0q6aPXSw?=
 =?us-ascii?Q?ykJWDbId1yl9RmwLcclWvr3jYMnSY2yhelV0JZHD+He/VbN4l8Eu0MKOgNZB?=
 =?us-ascii?Q?zNoH6DjyuQC8vqIsO27CwzqDXUGXQjhj6TBEgk8M74fYjf48yK9gvLWM+PIr?=
 =?us-ascii?Q?vl8zaMiwv0SZbSr9Ej5WjK8k5wl8a+LUoQn4FvICuUDhEuujmkASU6wgEs8c?=
 =?us-ascii?Q?RMIVwXPabgWS7OUUn09IOU0wj/S+1uaFOn92TC7LmY3zewpLuzsFHyZlau4c?=
 =?us-ascii?Q?8+DNw2LzotGqc89rXLzvIcjCS+g/hnsdFl/mFoDF+7P2xPGf2JSnABUF/U6+?=
 =?us-ascii?Q?alMtUPzEkzDpFnpPLIUDR+EtMN6RTAPa9IobY05Adekf/oFsgAq9DQctqOXj?=
 =?us-ascii?Q?ntnefQsOr2TE/vP8TAWl4oqP95QJc8jV4Q2UFI5KEAYWPpZPAX2fQ9+arF9G?=
 =?us-ascii?Q?3uY318gAYOr/1HagIQeUTNc3JUpJCBmOKudX+AoZ8xmHpURHZEWPMSG/pjgq?=
 =?us-ascii?Q?91unoTKBpUPaUr/Z7jCpDp1EPZFIEL8VWFbvQmQWdaOOnP5p+4EcsG0dhXbm?=
 =?us-ascii?Q?3BkQetyP4Zkcf9dFYNyxSh8k6PJc7BUHJiMCXpQOT5lBp/wM0Ei+j97ckFsZ?=
 =?us-ascii?Q?AmflVIV5GAWbPev5RIGqeJzsNb/g3vdfwgTpjiqb2B7XgDhi8JKx9BajBBf2?=
 =?us-ascii?Q?PT0o9YRq2E+YIF6k3hVIVhuczBiPVi0/GM6B0LFPCAlTXzimkJYU0zN7jsac?=
 =?us-ascii?Q?O3F+LGhd8MvYB5j8n6v/Ntj3cHEsdQ2Id62xHwXeicD5VOpQDbfrV8w3X+u1?=
 =?us-ascii?Q?yGifVMGgtu650v4eVBNRxxPrfAxy/QHCGaGW64seNI+ndI0t6ztWWHAthKNb?=
 =?us-ascii?Q?HUOk4AEKx51j2SVfyrFzdI9wsbnWvC3uMySq98s/I6FwgWj/aBS9x0FMPtar?=
X-MS-Exchange-AntiSpam-MessageData-1: CGlfCRT/OTJkGA==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc602f0-d6ba-469d-1e15-08dee150d279
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 02:37:17.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 047qngN6sksOxr9rzeEoATBT5t4lzpciZpwYJvsQvx6rfbiAz2Z7i3f7FTpVD0Krrg3yd/ZG1UKpYx/ifjASz6WKcglTUYAEu7WUa/Sd75v7uTJohqqPiKhR77AlUq1rdzvaI5KmPWHi7vETqIsKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6032
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307341-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0B8E750687

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


