Return-Path: <netdev+bounces-303134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q51GEruwQ2rPfAoAu9opvQ
	(envelope-from <netdev+bounces-303134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:04:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C588A6E3F47
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:04:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=qiFmjVRc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303134-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303134-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07F6430172CE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B17407570;
	Tue, 30 Jun 2026 11:56:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C138940627B;
	Tue, 30 Jun 2026 11:56:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820591; cv=fail; b=g0AGDGOIhKN6qXVX9N01lIPAB2mQSNcNTcTYhjRXzHZoxXGxI7SHVTiHCiLvb0eQImXDDEemOisfIWeFJE4pzDMuzHf+RrGcjql7jUeECo64MwbCd23kjTCwIq+pu0VFV9QtMigwu0rBXdxvgiMpxD8gCDwrMNVQdP3iMwvYumw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820591; c=relaxed/simple;
	bh=j1tjeByXeIHinLjHoJARApYbtqw5FLZrQo/H1IVDTic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jn9bLfG9KuBL6l3Y6UEPF6cdRgjXPHo2iakDI9rdTQk+zz8bF9kWjr0vOCPzylIUdtW1u2CL/YHdt0WjAQ6lJ2UIyr77p3n3qfzGN04CZ6yNV94YgaDt7R7T6n8T1G+aVks8HrTQH8x7Bf1Zhnyw3UP2+daX2fTTNigEKh4l27Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qiFmjVRc; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIeFIEIEKdT0r2A3VbiURcEJ6jfaiYmkKnbyzq4ftOWE6VYQdwp6WeY8ntMZAIz2WW32ld9Tbb1T/aiLJCwJaTpUOtCizfyeRCfX5aOXMCUrXiC7kTDL6g0VApADZTHq41kCmpSBzjYl7OKMR+KcPPmCgXIe6YgLbYvdI7PjjASiFhDJpBi0rJQwI7y8+3zArVu6o2M/XoaCF9m2NZGKWEkfUOl1NwfSaxlZjKRw07BJr4iazvz5J71qbwrm92m8nsTgvIwTGkoX2ri7SV8NEouR4Zv9o0bYfaZAKi0Ikqrjea0sBMwMfnA6fqFFzxOdM2gbwPnEAwiP1by3Gy8jfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=iwgUq1axlzZiKqCsuI+tYMKP0/HeA4sxE3El9ex91a9jCcQbJ1i8uu91ND7lDYL+nfBKXUjYUQmCzjnzRALUK70tHUdhf7m7KjSnnmbWryANpnxdm5YmEV3TMkbQQOBTyfsIERwzY0929M6c3eu1d8Xmaili6yhy2B3OMvontlABGu8sFyyI6885218tV3Sy+N8wUgaonoHzjdBRPIZJaOxQoDQ7vQlizGF2gZ4epFanJBSB4zyIz72O1mRv1Ay/+dQ6k5EcUI+i5eYzKXJf8zpYKS7cXdB8BWMlh4bIWUu0ucjF4r5IuYnGPxLGyLjdZlA7NKmWWQYjSNayQjcGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6OgbckISqAtzhoezk8E1ClROdhN3BCX2f8lIC8DmhQ=;
 b=qiFmjVRcq5IVwvwFtplJtHFPoxP6MWAT4Yr34EO5JzuZ6lK2Irlcy4M+wWP9pAGT5kyrBsx7gQMjCwfoZxR9HkTdocUGd0ZLvJch1NBXTe0VScgsEPwCdeqF9+lllJh5FoPtg38kWtkv1zVncel67UtoOHwPzosM3wI4zKhSsj7MugM2UI/+spWp7N6yVPjE5XsXY87MrDiLOBoDWMnyivgvKUDkUEvILJenl1hYezK985R5BLykDJebf0jBQNgYm/D+DfK+SejJOkfMxhmpsXTz1nEXucS8bltc1sYssRFKZLsmtr5M0REPGvBG4wYCBD87/nX11/SbkoawzV1vrg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BY5PR03MB4919.namprd03.prod.outlook.com (2603:10b6:a03:1ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 11:56:25 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 11:56:25 +0000
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
Date: Tue, 30 Jun 2026 04:56:20 -0700
Message-ID: <20260630115622.9426-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To SJ0PR03MB6964.namprd03.prod.outlook.com
 (2603:10b6:a03:432::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6964:EE_|BY5PR03MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d85296-71f2-43a1-1ed9-08ded69e9c65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|55112099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bj65sbIqKnJswauaA95VIKqUq1uIzUeNxPkdd20vM+OQO2Ve/sX0wGyNUsdd5pjvCg0NDryPDNL+hXBY6nchZD6tRrbewGkWiT+trp2Aa4iVFw7LV3DCIZxGtHBuM/Md76L5C8tkEPGRuosWoDVG8+cBt8QOQLY2K1IOihynDvZPUVrxLzD+fUmhuH16lTgW9HO0Ouu+TSIT1gF9FCq3WDrV234tNxGPvBiYKNzCpvCdQcznXO2WXlWEDNt38jRodEeVaona4mD2DA6EMWxeqIiM6UT11s53pkH3abp0A4Cq/zQCRWVpIcdlBBGD1IkELU7iFKOMbnvRgiJg0k4vhITi2Xc1IOHJG4hl6IDDsO087YYMGhQwhN8VhTd0/fd1aOqbzvy8GaBfFu+1USzM5l2KLNSVKbQZIfzCiGTUDlbsMx7K+LVmFl3BfwqZZCkXVWlXFV3epkxruRhi6x9Kv1rn/wP6PHQXvq+XounpPhHZGzbq8m33689B3zCPJM54ge/0AYnIChAp4kARtIlPyQbKzuQCnC6gTboo2I3ZY7NIyY5AdQ4Xac5bAWL++9omCJKWUm3kTX76wnsAtri4oemdWyM2qyydVVw3c0f0ih9b7wDwrcwwyTThq1BPe4Aif83xmpM+KTVqxy3p26/88tdjneO+f3R/PsXL5y32FVQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YQ52sLJVlqnDD+DLWqEWjMiDeTCw2swNp2Et7JeJ29M21xbrsTPdF0lWBpVF?=
 =?us-ascii?Q?2AtehL6EChZ1h2+jgcI1qzfb9YYV+en73VwO1tuqc2rsgMhn+f8+sgrSmaxk?=
 =?us-ascii?Q?Z8iYikeSjnpbNc0R7ccQw5Z/s8EURLsjBtaQCC1zvoUa83LvXMYnBNZfrbNF?=
 =?us-ascii?Q?aJ1Q6h18D7IZiruDlKGKWrhAKSFY8lmjHyYLakltlTUZcTf1iO2Zdp/EYv2h?=
 =?us-ascii?Q?haWqwiVgIxKC9wzJluknK9lpGMPdIFSXQ0qYE5n5Ac+p45kYgY2eAAPydLSp?=
 =?us-ascii?Q?/YMSdbQuINgsKIGXX/+uznEmJSu83emnWCFxPyf90o+PXIOpcGY1i3e52cof?=
 =?us-ascii?Q?CH0TnDtQca0D+XuB8ltu5YzRUDcijIuxpcgGIhRDOftXYpsLxhfLn+75Ji7x?=
 =?us-ascii?Q?WzhrD3vbXi5JMRSzowDqG8NLQXpEmIYHFs4XhXsxO5Lzhs/EueKYTkYCdQ3t?=
 =?us-ascii?Q?TYAn9k5/hWJVn3i8xPsmwD0WNWhgrUAJ2fX2QPJdwVlUj43qcOA2omRkVhN+?=
 =?us-ascii?Q?OxHRbtOjwT6RGdaTHYP0+z+oGePPy5fkcJEGHVUG2p20KEwsvULtIg2tJw2H?=
 =?us-ascii?Q?r6aG8LEaCbTvWCni6eEBZfjJ8GE4xAMPAfgr39d6TKTgzJuarNlCLNvL2j5Y?=
 =?us-ascii?Q?JcRkrCb1EjE9xZ3xUidNx4lKoRWd1Q2fsg17cD7NgfnY76zPjDbe4oR+2lVc?=
 =?us-ascii?Q?tYZaOmvuPvsJjlcvoCYpEtGuzdLhYPtPLa7nu0IN67Hyirb6+kY/ng+0ws9v?=
 =?us-ascii?Q?t8znOn5K6/zLBYfOCdqXeXAH53vWCqNYYeqp6ilPuZAOz2CIa8cl2RQdsHfv?=
 =?us-ascii?Q?ed2U89u+WWh61n/qyM8x3oXNY61rtr/jluFuICCkNDJhikBs0poZhOGoXADX?=
 =?us-ascii?Q?3B+of/Nwxx/DAOD6ewgaKp5smfu2TqVd7Z1zvoPW2gbkYUsyd31/eN4OaZHA?=
 =?us-ascii?Q?ceUZqpw42Ry5KdfDZJRF2VvkeWufm54dpMkdMaS/KXzKKJXNDhNze5FU19ws?=
 =?us-ascii?Q?n4SKMSsO6H6+qUT+L1EqcoDCdamqVaWJrYx+rMceb8Rmarte9baqHwiqo54Q?=
 =?us-ascii?Q?PZ93PTGt45ZKudEiWrqc7SnksFZzrrVojTV9F1FoGEQzu57H06mWCM/qS4Ve?=
 =?us-ascii?Q?PUd9ocMNXa8gXq1XgVMKFSAxFv5CXQSAcXXzSVn8S1DCuXOU7VdD6jGOuFKu?=
 =?us-ascii?Q?KiKopjGnJ8DRTlSIQyipUe6NCO2pciUvvrrx59aNcYQv5uIKhizeXGO0yNpl?=
 =?us-ascii?Q?DFpVi/IShwvouyoH4RMEDED32TdjH2Kb7VEhvnUnwJvOdZ1fs6zpuKKPPnXq?=
 =?us-ascii?Q?q5nCo8O1jUv3GHDb8KMlCAvofVkvP9XSJh+vH//9RctnkP0FImXL4k3vsPAl?=
 =?us-ascii?Q?2kdGDzH7bqqwocT2FpgA+PqTaLarL2MGV8c2oVh97GiA/vqrQNdXHZ2I1k+Q?=
 =?us-ascii?Q?0J3ElIO2WGkDA3QgJQdmradzaVp1QLy3Mg+xv45GbFIXNkO2DnSaH2y1etbm?=
 =?us-ascii?Q?o9g4T5moIlB/QrUdVE8QjlCJvH46rmo9CEOKSrcVj2fGsZm4uNhGhbUJVRX2?=
 =?us-ascii?Q?SmcgDC4YUui72ptl0Ay6F4w5V8im/N2xrw2ZcIwO/nXp/3hgBH0g9IiboyCU?=
 =?us-ascii?Q?OGha+RxYAyQ6GCtLqg6VUrDLeDq7OU66Z7v40i3s9Jjb5+7U9466GUEeYwgS?=
 =?us-ascii?Q?kSi2IUNa+/48uR0waqqXCEDq3mSJvTaNElH0py9hd+K/bO3VgYcEqbplOMZX?=
 =?us-ascii?Q?rbGyS0CJUe6ZrLxP6XR2qoyCXd8oglmaY/VxrxfLr/+4NeKwZea0+L+blQdX?=
X-MS-Exchange-AntiSpam-MessageData-1: yTipqxw9CWBCxQ==
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d85296-71f2-43a1-1ed9-08ded69e9c65
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:56:25.1415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUHBxBQPdgyTTy9bRvmj77Qvj7TWvxj+m85KdDpbRsOUYq6R6JoUqdgvZugIngTNMgmh7ABLK0Gb0m75qcThEsOtON2GTooT0oWN4BKdyrqIefKbj/gV5JjqqAFUtkxiwuZi9hVWKXpfvTJnT7hUOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4919
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303134-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C588A6E3F47

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


