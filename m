Return-Path: <netdev+bounces-301559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dUkbOyqIO2pQZQgAu9opvQ
	(envelope-from <netdev+bounces-301559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE786BC311
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:32:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=m2LIYQFF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301559-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301559-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC2630E9235
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5F393DE2;
	Wed, 24 Jun 2026 07:24:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011028.outbound.protection.outlook.com [40.107.130.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396F3921DD;
	Wed, 24 Jun 2026 07:24:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285864; cv=fail; b=uLosDHIjObgUbRplzBTC2msER/L3wo8VRCInmIujQgiotQtNyd73eipe7/9K04QnnMgD9p25F1FN8NewL9k2SqmW9VFuRTaVm1WJ4E/8FP+tpJsXznD2uykNE92rG5NK6eraY9OuHVsFHrk1GqmF0wjJBErxkBZBigUNNCCToJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285864; c=relaxed/simple;
	bh=KI0BMEDKLM3WIg890uWhaeIvhIOf6EqrQLeVqZjljZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pSMVv8DCVBniJIQlahTLRsThtMkU4eq5oGmLwgQL1t9CVsmcUOQO/xGDgNoC6spCcoCGLAzNKJFKgi3UGAhquwr0G1gWKvbxzyzJTSeM1fwsjinQpv2z0z4h6C3pd0fcGiaF/Ai8ZSrCOZqDw1TtwRzAllybgjK1E+jEXAUP7dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=m2LIYQFF; arc=fail smtp.client-ip=40.107.130.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUJm8hoBXPQXkOhF4X8BkfPVKEaFBQjtifEbGUGQwwwWc8VREDQq4Wwp8al1YjwmMe1zUAcIMQpP0skOCXZkHctOQjnOlDAVgTtKr0w+k14p7spo9zyLEu9Gv+g5NpUgYXCzVh8nuVW7Ihp593mbjUlEQKqCO+Z6qaN+6R4zyMcTW9l45OtN3fh9LJEAsb+t+G5HusmolPUsRcuu7TsdofQDmZHsQHTYGRiMf7PL/+RQV4aNPBf4mejo/Mzc+gCX3in2sIz8ueaUA2drtJLx1+NihsezJ92MODcPyKOnnVrmFD2Dln8r8XbK5spVptnGMEC/TtdrrnOqWRqvHaq3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERNhWlS/hiidztpcwZacXfFL1MiM/wvrbRkPvUMEIxc=;
 b=mWDQ2etp5yxABxBgQLnb4C8wgH/pQE2IBfTaFoespO+sdx3jKHnD59nxaKsWyN0IL+/zTpR/6axZ7GrrLPdNcPhRrHSTDkYa04avOxd90VB3xsetdCsUEdh/ySo3uPWyLFq3Z+L9rh/NA9MGq/GC07WCt95lkREYeDpJWxrzmHpE+YiVFVoBDa0VgN+NKKxpWFR+Mldy1voBkIOLQRPlREjpFcfzGSnMM4HJKjVi/lWQkqXvWO1XTyQEzM3/uXUe2OLJunuC0R2xW8mD4K3UYiLOlsvMh8oYy+fcZCytMSmEwzj1nmeVp/l5S2rH9Tm8aJgGCctPDvy1mDUa233/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERNhWlS/hiidztpcwZacXfFL1MiM/wvrbRkPvUMEIxc=;
 b=m2LIYQFFxJhqxhKik2fUx2Xh6srN0EoMkG15X91ZAWmm5ONX3gbrd2wpMdo9uZXc3yQ74up/xK8D2xMu/bOJBWarhWV/tr87v6eQe5UVVxmDZ4SNRm2KYlOmWDH9eKzp0VNyg1Skzs1a8jP23RElUqCWLYyT/SNj5zrOx79SWZdQU7rtsSlPLcd2HJdAt4GWdkjjbbiYxrQhq0gDeXznXf97ybn7xaNg0RZIRpJ3qv6BD2t59nZcW9BSgZ2ok2CndCYB3YU3B5uXLJdWVzr6J0jDafFZcUqdbpcpwJrnsmgmVz9NtfDT40P9kgHo76EEi+Lk4QXnahEDHCHtaGh0JA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 07:24:15 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.014; Wed, 24 Jun 2026
 07:24:14 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Frank.Li@nxp.com,
	wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: enetc: fix potential divide-by-zero when num_vsi is zero
Date: Wed, 24 Jun 2026 15:27:26 +0800
Message-Id: <20260624072726.1238903-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU2PR04MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3c143c-1959-4602-ab84-08ded1c1976d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|23010399003|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZBATqeTAG8OVh2qW+DmHuKfg1K64ShOp/1FsL6b71zrpiuZd8Hz7Y6L73It1ZhFKHTogwGilpcRNEQ4fKMPTwDFoUjLQEwypC9kZFIR0ADMuHxiydBKSfKGE+sbbteV4XQCWlQXjVRVfXpVBqH83wDLrCa0lqul6a0LLPuCQ8Y1hTsc8gdqGxN3CebMYAsFFqVga+1rkVb6PgpadpwPD2PZWIKy9nCTc3inMR3H8RqlM3UrLo7MKv6AWomwEZ7Rv/4SHttIkDr8GRr+uooxI2aYJe7/BFnaqI/9EiLFuUigUG8Au0TvPusQtVMGkoQM8hhuXh36hRJPcC9a9rXSxjQ+QOyDJXwgB7eEH3rgYnQ9s0HIgMulVVIMfuuFEzWpQasQgYP2kwK/MFNEBGFyZWJnC/I1sWff7Bf14Eb0Kx/wojpF2NJMnr0X7Ja4vuTJbm/+D4I2KQKTpEBT0dkGlCwjz/0N7lwX6vAjhUKMCqknoAW2F3azEggxwcOCaICNsMts1CZ+l6aetv0ZQRQxzdgHATofIQqpjU7iaKwYc62u3kf/gqWL1jAMGP1p03kKtHrco4CjANGhEFHeqgB2UbrA6LYhb0YVZ2HLKreJKSKx5PcZAKYRMXxQ64M5ZyPMGoRT4kIItnzrRTyM9MMfY/4C4I+cp2T7NF5dnRX9O+6E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(23010399003)(18002099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cOobiyH2y44yzuUSUjdRhQ+ooj35InLmNz0gwrXWjUdIjLyw6tz5scLi4bUP?=
 =?us-ascii?Q?4d6+f3MMNdWl1lMFuQ+FE55aLsL6mM+tn/VBGbUVmrxIFHN0vv9HTVeC1cco?=
 =?us-ascii?Q?wozhlUxP8SvFWNJYdn/SJG+/YmBWmgtvWUFZTa5wOT751kBWVZk+g3OM7LV7?=
 =?us-ascii?Q?qj5kkQcql7McuD3op4gCAFVyk1ycp2Tj9mh83pEBdCN6+YP7NlqUi/ZkokRF?=
 =?us-ascii?Q?5WdBzkVhaqKZ03HTK8tkur6dArlOvWYEA2C4O5EfJidiWFGmQ5H5iSIPtfOU?=
 =?us-ascii?Q?jhtej5qZ+UPd/Yj2O04i2CoyX9SFXTeUk2CkaBzbcXV7ZiH9R290UJn+SQnE?=
 =?us-ascii?Q?YnvOQ60oSya2Y6QOEq5b1yDqUL39aIsqmGt2PXHE7Qpk/pO6mfg0CkINivBN?=
 =?us-ascii?Q?X4Lnw7HoFf5BfFR1syvcOcOgSr5svaHSO+o02W85PGUr7dD8UA6tQc/q1Cj2?=
 =?us-ascii?Q?BvFTetDPnbWgHTZr6hLXh/7bAx63S7/Zriqtt3fv5wquNF5SFPMrcmALgJri?=
 =?us-ascii?Q?ndlcnNK3WJl9KRyXHgu1G6hfdcQYMbM+NMGbcswpK9ZLMaqcbIzRWWcwygJu?=
 =?us-ascii?Q?NglIHtihNR3qCHmriUA25bq6FxpIYPNcEV7kZCdC6xPoQKhEEpCOEGGkywdy?=
 =?us-ascii?Q?L13/M0J7SNPv9M1GO4yh6ev0dK6K5MQcKHw1SBkjlMtQjMqNE55HlBSYBgyr?=
 =?us-ascii?Q?5eW1QrldgpYBP41yA5t3fHovi7x20pzmpmEBui4AV3yEspNaW+cBimCpJr77?=
 =?us-ascii?Q?5pYTT3uZpSB4i3WKnF31kXBkrrqQcdC5+d8y/oWzyBD6jKJ3aKss8oRuZ41f?=
 =?us-ascii?Q?+le84gW5THIDdmwA4qhzpEPsIY73S0YBH5NPOm3gLzN/QtP51GFUQchfm3V/?=
 =?us-ascii?Q?rOq7SK3Xuh9Ne6WWbMFjGp6w/H5fUUYA+85HfBvGeTWRtkHwSfJfeLaQOZTR?=
 =?us-ascii?Q?rL07jbY+Y6u05W0TBaziXbqmBT3XFndtx/IkHfY4e/xeEBNlZVBno16fXMwh?=
 =?us-ascii?Q?Li/spSi58HifekS1LksnHy4eUmvK9uDpqdFa8AO1VRuEVCkaVxIFYJq/BBnj?=
 =?us-ascii?Q?M3ra/bA0RL0brJpTIALTQHetGi5Vygf9ruOpQPJMB64hx6vLTEZcUApY7kKo?=
 =?us-ascii?Q?Ap5G5Sl38xbZ93PqX65aWEXO2lLeXO/YmEvRRi43eGDSJIdoNWOOqPBG5Ff+?=
 =?us-ascii?Q?DRTOVsntU1qbZJKmi4HabuEgQ4i8h1XhZ7SQ+3HJg3mRETexiO27eiNja+EZ?=
 =?us-ascii?Q?Fxj4ang5p8wAeqNkcsvYaCMRrMZ+9Hl2ZIiyVU5hjU9if9b+fDnN5f7h3i2e?=
 =?us-ascii?Q?TUXgIrtcoZpXcTl/ItZpM51w2/z9WcpzfMuxr0HAWTfCblT+EGptVBtDmLvD?=
 =?us-ascii?Q?pnrnpsX33TkfPWyKiLBNk3pP1+lxzQZDlKkGZKiT/cO5XUCgwBwCt4dMV+uo?=
 =?us-ascii?Q?XAZMRqhv4xqY+0CN2KZgAGYhZUhZZz1OQQjTjCxobAmvR/tinXx6kuXzo7VQ?=
 =?us-ascii?Q?OrGgcMMy6GAJnietj5Fsc2vHWJ8ujgpVdqG79XBCdfU0P+8HsG3tp/qbaPT/?=
 =?us-ascii?Q?Emi2ApJsqbyRWhFs6r2qPHLI+modsQ9mJO5zzMJaAcO136Z4xAXPqFkiguxt?=
 =?us-ascii?Q?NtVfSDfoCCcdI1qPFDIjzdqce7dWKuFjUF30KkOhTVKh1daziRYa/sMGiHEb?=
 =?us-ascii?Q?xeyWpSe+RmIUb92OkWeVg0MENQRMdIf1PGe1C/VyzLTNR85XYgEVO3y8QsK8?=
 =?us-ascii?Q?cW7AlI8NxwBTrnFUU1utPzvmGsqy5CXaX4zasIoMiKadGO43vdMp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3c143c-1959-4602-ab84-08ded1c1976d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:24:14.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2C2o9eO8BCboJkYUJN52FK+JSyx3fbOVZYkEsejl+DhFf74X507cg/+V5GLd81SKojokWnZia4mB7p/Ffp5u0iA5PR1Eh7K4Lzh1O88yupCh0zK1F1twov0Lo/FbOtW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301559-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Frank.Li@nxp.com,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CE786BC311

From: Wei Fang <wei.fang@nxp.com>

For i.MX94 series, all the standalone ENETCs do not support SR-IOV, so
pf->caps.num_vsi is zero. This leads to a divide-by-zero in
enetc4_default_rings_allocation() when distributing rings among PF and
VFs.

Division by zero is undefined behavior in C. On ARM64, the UDIV/SDIV
instructions silently return zero rather than raising an exception, so
the issue does not cause a visible crash. However, relying on this
behavior is incorrect and poses a cross-platform compatibility risk.

Add an explicit check for num_vsi == 0 and return early after the PF's
rings have been configured.

Fixes: 2d673b0e2f8d ("net: enetc: add standalone ENETC support for i.MX94")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 4e771f852358..437a15bbb47b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -322,6 +322,9 @@ static void enetc4_default_rings_allocation(struct enetc_pf *pf)
 	val = enetc4_psicfgr0_val_construct(false, num_tx_bdr, num_rx_bdr);
 	enetc_port_wr(hw, ENETC4_PSICFGR0(0), val);
 
+	if (!pf->caps.num_vsi)
+		return;
+
 	num_rx_bdr = pf->caps.num_rx_bdr - num_rx_bdr;
 	rx_rem = num_rx_bdr % pf->caps.num_vsi;
 	num_rx_bdr = num_rx_bdr / pf->caps.num_vsi;
-- 
2.34.1


