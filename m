Return-Path: <netdev+bounces-304898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GTDREcNiS2onQgEAu9opvQ
	(envelope-from <netdev+bounces-304898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:09:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9433E70DEE3
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 10:09:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Aac4C8Xh;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304898-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304898-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9736A3005E90
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 08:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0552C0299;
	Mon,  6 Jul 2026 08:09:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9633E8C6F
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 08:09:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325374; cv=fail; b=Zd11aP8FnReUEnk8+Sqm+Qhx/w2h1A3/YRBU/rnC/sUCVAVR/mJyQGfWApdU/KqTmMYqoG7p6oWyp6ticix+CMkt3yqI5hzc/R/zRs/nM0413zKXECx3hs8RpexnU9wTZpGp7FaDCwzrxrZadG1zGehUGw41ltSaAzK4+JCy6+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325374; c=relaxed/simple;
	bh=XNzdhdWQ2X3GPwnVdvMwmXfNOebfZsB+JKfZS223VMo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hWFLuXW8RmBtoCO++yBAJZwuryVTok+4rQPRWPpM+EWsdOUkaTGyCyFittE30YCphVC81C+j1apNTNWqD03oucjxJF53u+8gWcChVFKCfBQObeftOe5504FR2BcabO6zfWDm8/cP33dWvBkepicE0XlLvqVNNe1IdPAPxzQ1M0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Aac4C8Xh; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V345XYsmXA7wvg1LB9b3Yi/BQSJ2Irn4o4Gc208fPfKCHOzPkHl0oFtl7qSZGFzJZwawnm1f3auIqb8SBYjMTrGKlJ7ffqFIJYK1kgEbetzw49AHt79fiDoxKqXW6LnpJsPSUoK95Meh0VlEAUKaLq0ZcnsdbttwadknD+cTWU6giTbmjOvj1MwPSrCdF35BEa1jV5fBPkEMiYqAsuW8XyDphlrig8KisQNss/fkikR2F4H+PZ5DhGBEEn4gWnuGKkofG5eoG6yQ1jajB1VC3dyMkZXtKByF4lknCX88ToNLlPmH/ntc8zEaIKD1Dhne18q9IZzkxnKZhdYM+VzzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYcBFQc5KfS80UzHV+Vmdge2YtvAKnLmA4mcsh1NvfA=;
 b=lLiUB8OR0btpBjN+3Zf5byVXQyJzfvYmV1adXvkkPkP3kYVu7lIZonPZlCCUMTWYwWyLkJR/g7SnJ9STipHP0n6U9VHjnd1nAzIZPTmU3bF435lbmicxbZo2tr1ZeuQgt2AMS/Ioo5aUXI+DvvjfEB2Py5WDHX3YyiQ0zulCaPkUqcvl8x9DID/60fqIC22XnEpDLdb3ncrp+TZoUhz8yjOtSGUARfa+//aIbzwT4OsNPVbO6R25ZdzwZ+JL6MWpFmqRVrj9pK7zrqChkH+/t92syEJHoTFo5WGFVZ7WqMR/4dPTat8MNs9+GX9IOL+64LKNGdZWhtsC8rQUIeh0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYcBFQc5KfS80UzHV+Vmdge2YtvAKnLmA4mcsh1NvfA=;
 b=Aac4C8Xha6wxJFVrUErx8RNf2dxJMNig2GTVAmvWmpGg42P/hVGVzGDlzQpfCO6Mou4YqAzLgkyVB7YW5CQX6zpvjjBAbyL7DVH4W1SYinxNHH7wdiUggwaYoOf/P1/ha0jhpiF+pGJJFS8f67/beFi+VS261jRZRhRtVUO/Wy3omP/FftTYK2AxuE9TSNeNZ0v1ZzBqgenZYTMNqBiZBC5597ShwX5sD9M7a7QZa1EkB1uBawx9WviDhOuTI0zwcyvh9KuxG34RRk4WxZBsgEGBkvI/ryGoPb21zLxdVQ8FBow8GfW/AAn7Wym4PKTKMz1syDmj+pUT3dNdX4wL4w==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10437.eurprd04.prod.outlook.com (2603:10a6:800:216::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 08:09:21 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 08:09:21 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: netdev@vger.kernel.org,
	imx@lists.linux.dev,
	wei.fang@nxp.com
Subject: [PATCH net] ptp: netc: explicitly clear TMR_OFF during initialization
Date: Mon,  6 Jul 2026 16:12:32 +0800
Message-Id: <20260706081232.3661826-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB10437:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbb2249-534e-450f-02a3-08dedb35e224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|23010399003|366016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zEPFlJDtIuK+z+DivJRALk7U2zbhgypRkIQcSNNpawlpXjPCztE4Nc5wJJtmTF4OgtkIfVteZoNLs9yDl7JeExucHOMR4TFB9t+grB055DBURw2jFiV+IHZw2xP8wIJdYhEmJjCwLZFQMopENLH/OYuKfOLFm9PCQgdUyu+43oX//zJwDtsOn2QkBhS2qm8HqcZXmLemjAIEhJdoSVX4sKsrYKXRq1xK7w1AlFf+DGfNBh1nW0iwyO99HrtTTpST0chXA9t0Kg9F7AS/BnPl+fqWmNIUmjA1/kdgJEY4bEjL8IaEJ3oKocq5/YMS+275gZ2hRjJMHu+11vwfk5xXTKZI/oyevy7UqDKQwXYMeozOpnMmYOa9cWkvHbi9s0kmVZ4vZhUYngOCVO7NtgYHs07J/MCKqRDubEJwmg5uKfM0Xgd68s5o7J9Wnc2TAA+UwjsNF+P3CfbVFffNQbEbJBYwPdCscJuDn+qOu79j1Z8vbuzaOdg02DhkKkDlNwuGQ40Got24vCRK3BdsQSgbJv5vOgrQ9Z251ZJSNzehovsirp7U3RSr7XHJ3fTJqePpQZ2vsCtRWHXsH3IUmoFTXtMBE0IvKFTFzrgrco90GBxJbWzPT101jg1HJ4wSvOIp2XQgTNzD0wNpZ3gC2C25mpvTMJUSb405qEkaXgXZdP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(23010399003)(366016)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B625627w0i+a/iPw3BVgYeLXCyERGpk3oIg6p70DRsVey2EibW0JQ+c1SvVz?=
 =?us-ascii?Q?R7Ne1HN2HVb3C3/F4zq2OxLW5ObNOKYFfOqPFKb/OcvTQfbVnswMRKvxgxPM?=
 =?us-ascii?Q?8gRZdmB51LTQPYrIJ0/PajgBbxT0nybB73zGD4NsIxoXgfm8Uq8sQLlzzSMw?=
 =?us-ascii?Q?YIqPlCsbxG/u91jZ4gKmDXzMYcCp8SecVwAuoc+xExf4pLTPMnAVuSZFK6ku?=
 =?us-ascii?Q?aHxriblkVy+QQJz0DdeaQ8TsISp7Hezu8+0Cl526nXLFf/GGZAbohNsQp9ZD?=
 =?us-ascii?Q?D7tG7Q1jYl/RNCa3ulux37Ke4Vll1GdOcZpBpgOnFl343/rTkHLYkqLaHdw8?=
 =?us-ascii?Q?8fN+oVkx1/is96F5Ds68lBFX0B4Ht7Y0bki0EwBtLowptelT6QKKPUZ4WTOZ?=
 =?us-ascii?Q?smcwiI5HgSTCCLWouV65UGkHtTnF4xhgqg/IW2blFKkYB7+rn6h+YSjmBFVX?=
 =?us-ascii?Q?wjvI8TxNyUyzb7lwhDmwwN7HNZHawgO3xM+EYyCdfxhebEpMq0VfridjgBAJ?=
 =?us-ascii?Q?XimuX6RvXQdOUkZfUgqRTACurA7XAmeLiEGNGF3bwcOSL7IM+P6A5VoH4di7?=
 =?us-ascii?Q?uddAhHIuW74ZMUaYd4nzsywBPXi4KCMx+3gauH2pA90nE/qcyxll9E8HZsAP?=
 =?us-ascii?Q?88yN1PTT+giJ/R7pibj/9TehJXwjwcuaIKVYtrs5d4+4YjJOqVWCaMKVdhMd?=
 =?us-ascii?Q?OI4RsUj7lNfYHffcvz4iICcYVBP4JKvRrH44uDPw5KG2kMuGc2HdWGhbdQJb?=
 =?us-ascii?Q?VMNFXahIBYVHdkhHi1uEFvxmKwS0ZrsuZKcOfFdNyW6BHUd7wqVGnbb2vlJq?=
 =?us-ascii?Q?rm+NEt/RQ71rC65qjMFFzrz6XClG5IkbMutc5e/7Pl8baV9aIYlDXufB6fjl?=
 =?us-ascii?Q?+OQV1GvYZEZlXhn4KLsKSwPZpzga5IhGz/gckR9xKC54Z1b2oWMI5QiAtq7V?=
 =?us-ascii?Q?VvEjnWo4HruineqmTw6/jW83s4YK7JvQVjKTsY3JAl6kKdUs5SmNliX7+7Vt?=
 =?us-ascii?Q?Xp6twQhkOTwKRU626USONxhGbBN+Gvxs0lWSDKzVKtrV1NSXYGypbyw3vYOB?=
 =?us-ascii?Q?7EOTEwHSBynuFSPIebzCWbqmVMoCKMwxMVpbPMCPCWvOLfHRh+FSksxmnxME?=
 =?us-ascii?Q?zPNhRXwowi2acrZhcFOnq1Eprf3jf7fRcvytQy0EPKMjx9iYysfoAwjVmzgj?=
 =?us-ascii?Q?5QN64GYvzMQsZwQKW2102w+bvMfQDtwh6Dm+77hcUVzQDzYDizKaFNlhuP1T?=
 =?us-ascii?Q?nlDw7Y3tZhYErpnmsLfB43Aorz9W88DpusTi9ABIAO1n8PpotNIWdSlXdDx5?=
 =?us-ascii?Q?25d2ZYOWFiuFxWdEtHvnftuJiwWncjToPDjzrqCKDRUN2tjNQTjESaou/zp2?=
 =?us-ascii?Q?Bf98anpGeXGiFjY6m9z8PMUE/YixCCK5v9Li38OiXnpR/whAOWqqJ9PmTTog?=
 =?us-ascii?Q?kXWpbLwAUH/AEq0zeUQC+3HyIrGxkas0jok/tHxZ48KfYd6XNwTbxY7ETi2l?=
 =?us-ascii?Q?wp1Iu0/2R549mAMSKzyNKnDG5bBBcsmrpJUYszH7vdNxAqxXlQYS6IPBlL8t?=
 =?us-ascii?Q?T3cdoKCUO/JNJxv+62CFs21EAg64EDcpQJ/lWGsJGWzRE1Ahv/yxIK9rqJ+Q?=
 =?us-ascii?Q?OXmJfk75W6SpbWhW2T3+cEbVTQm8leVpT+mFOlaJuhpeuDx7QelSDPiqoSp5?=
 =?us-ascii?Q?I+GQtZ6DKn2sd1lrxOTR6lYZeFnRb+JDPhkcHvSlsSrNbV7uTE5R0o2ktF08?=
 =?us-ascii?Q?7yKgIBOt8SnFwT6KbCzsiHI6E0xmuEcz4jPogGTCAk9SfXLZjkT3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbb2249-534e-450f-02a3-08dedb35e224
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 08:09:21.2276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QizmUVfDpR2ugK+PLWLGvVR3iK1OjQRRD9vuw9RG+ouQ307bkZbRnlvzoF/PWb3qOlJQCYmQH4lx8+WXpLSH6debtPxFE+vnEbplqnrOFFS9BjWrayyLQObe2TrTbNTy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10437
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304898-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:richardcochran@gmail.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Frank.Li@nxp.com,m:netdev@vger.kernel.org,m:imx@lists.linux.dev,m:wei.fang@nxp.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9433E70DEE3

From: Clark Wang <xiaoning.wang@nxp.com>

The NETC timer does not support function level reset, so TMR_OFF_L/H
registers are not cleared by pcie_flr(). If TMR_OFF was set to a
non-zero value in a previous binding, it will persist across driver
rebind and cause inaccurate PTP time.

There is also a hardware issue: after a warm reset or soft reset,
TMR_OFF_L/H registers appear to be cleared to zero, but the timer clock
domain internally retains the stale value. When the timer is re-enabled,
TMR_CUR_TIME continues to track the old offset until TMR_OFF is written
explicitly. This can cause incorrect PTP timestamps and even PTP clock
synchronization failures.

Per the recommendation from the IP team, explicitly write 0 to TMR_OFF
in netc_timer_init() to flush the internally cached value and ensure
TMR_CUR_TIME follows the freshly initialized counter.

Fixes: 87a201d59963 ("ptp: netc: add NETC V4 Timer PTP driver support")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 94e952ee6990..5e381c354d74 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -779,6 +779,7 @@ static void netc_timer_init(struct netc_timer *priv)
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
 
+	netc_timer_offset_write(priv, 0);
 	ktime_get_real_ts64(&now);
 	ns = timespec64_to_ns(&now);
 	netc_timer_cnt_write(priv, ns);
-- 
2.34.1


