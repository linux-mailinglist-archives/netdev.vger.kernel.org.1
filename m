Return-Path: <netdev+bounces-295696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HCb1Csx9ImpJYgEAu9opvQ
	(envelope-from <netdev+bounces-295696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:42:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7574F646151
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:42:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=w0VUqfkI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295696-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295696-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A954030B08CD
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7932480DE6;
	Fri,  5 Jun 2026 07:24:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581AD480DD2;
	Fri,  5 Jun 2026 07:24:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644269; cv=fail; b=FmoxtixSQjRo7x5TF7XuSGblgLhNIO4g30xQ+jWUaPUac2OsN0A/3XiIZEswIqv/iJ6GB4a7zdMVbZr67DzNh1JHFPlPnfzdq07IlZKyfy0yYKwQNCnIQFstWkCqp26lk50/bxtjpN7E5+jLtBvlEutEzVmvLMDsFE8c1cfp6cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644269; c=relaxed/simple;
	bh=rd4aMgXNsA4FZJpKEQC8+VIiuA8pNLF+eWio3ed2+kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NM5QOg6e6zPCbnSVeCTxUWiYw9reu+NJJVnXoG5DLljA7jTHEabe7NIn+ZqCGPkwkKjEWWpjELUJY+BFESm1sUiAhLE0jfDNnj8kTa/E+6KlglFF4ZIbkUHhHPXxo/1jWjwrgUglsG2L6rA8TSc4vW5zWs/LlgHv89K3lbvI5qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w0VUqfkI; arc=fail smtp.client-ip=52.101.83.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nw03I6OpxMCjeX4jegXub/lWRBoKO56YYSjlsGTdABzdGCit/XpjaV+ri4UgH2HlX0oKcTqhu3brfefoDEhD1Tjc0wlWn4RO8EKVWpHzVnOVfVCoMfe+c+KCCl/QbzlnE1Yw4jUMSCemVA2r4Ru3zPhnDyeYk/4TRxNgsBtKC3feWuenDMqoJHyNKqN4T8K4i59o8OBFtUD3+RvLOR67kEzVVHAlqaUdQPoKftgBWkObC6+Q8scinwb2bbe1mhPr2a88QhiWW1ovjrr3oYIIVeeVPNld4X/wJPmXKJ0RwE2N3U6/AkUpxWSFQ6FZcveK6Jzpq+n3KQENldlLCk+HHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro4EkTRzvQ+LjD59ITAL1bcIlX6wGE/X1h6KH3+9YXw=;
 b=gF5Yi/8CCMna3uFVRUqR0V6pM2wizNV74PqalFSb8LaHyQBoruf+D141gx4UWxa5xNJn3wzH+Cer/+Hp9yNFf0L/om3JrogJ9VjDtIZxdzBtvkORsrjiHX7NeTwx0tZs3eHJoYUUhor3q0D+csAB1WKggSC5n8RSdcsqYc2o4X0xDcAwmeR1q7EAWjfe1M0m0SG3Mf/XNKwyDsPzDEyB96bnAOOoaUFxTEa/KHKdecDi2jMejQiNFyrGzEWYeG920YRVXv+h/DXwjj5sLBvYLKy7kD5vqA9B1SMFiLkFBwnv5rQVortj6cqCNkAADxaEDNVIqtMJ1cGjwF8EEA1qYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro4EkTRzvQ+LjD59ITAL1bcIlX6wGE/X1h6KH3+9YXw=;
 b=w0VUqfkIgA7Fph0s31Nm4g/mFPzKJIUSNmldM9+kXg5uLqwMRjbz6yuRdS/Lx2sZxX9G9AcYqDF7mWoAV2kiof/hyqiTy0JgqNIv+UhBiF7HMHQ8RKR79shTFiX1rllfNRHf814UyS4A+CM3M5ggCVqNnbm8qEAcuKrVderZcjhyOb7x8HGZ6cZ0jbQ9OsesBcEN/vuDmU5dwkmqLyiBuBHnyPGgBLvs2tzlmtZkvWxm9DcrSJMOcbkdOAM6dKJIrNPM98swAn9GWUyqHXtvz/zg/qNjmEySwwwDx/ID0CZdJhoB6kkDWpgKA7KHm88sWm8Umz4ZqhevyaOqhmmXDA==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:24:23 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:24:23 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 14/15] net: enetc: add PSI-to-VSI link status notification support for VF
Date: Fri,  5 Jun 2026 14:55:49 +0800
Message-Id: <20260605065550.3038579-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 2290fb40-7dde-47c2-2777-08dec2d37766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zXgWxsCOG2+KfAAR9ZZD22iguLA9h9XYzSXBPiuDXn053CuLMgP4DReSqpvJ4CX46/98SU2Yr3n9xckTUKUPyr1ZTKR3i2G3yNa+PYB00JXoyyAESM4ttt14gduqP0MMVMRLytoDDVxMX7G1fY0YFR1fJMF+em93KuiU3GbKe37QcmUwwqXGzfengnj+kk2e645icF1J6VGvmhBAtsngLBudW6yvQbKjeZeFlyOtwpDPZ9W1lmPpStaEB3niZ4oFZ8tR7A+RJKd1h0FRf2chm8DttVCaM8wycRlUYpfLG0ZNj5+sSsMrpr46m1G0zHfiNN3Sh0dISrzGjOudaCAWJMlXKSsT7/SBOR3fEDF/+p2IFqmZ0xIbYgOGjqCHusFw1GRAAcdQfcvt4a2D4j+2qckn7QmC9qBYqNNePcCR8qCVh+Zz0cMI6me76dHvb9EviBT3IucRNKBg5nz/gntjgo+/gXjHMmDUyUVx5oLQN+fwcsWF0qSc5IL5JlsjU/V9zLl+q9YbOoXGE/6+N603LX8qpfIWDgNzBzDRojpKyPxRbPA4bdY0+xvxxN3ByjGEsI2wVULYmHDMQH/5TZ5qs3saghrpXv+e7hV5+ln0CIqPXuZv7c3w8dne/RcgbRX2rwHV+G41FJyYYo5pR5izwXLKKL45kc8UwdZCiE8rVRd9wn5ZQE0hfCau7FOyqYT3bVoHfnnkTbO1A1UT0IJbSKBZWIQnWSnHvSo/h8TbEE4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYuajkC3HKci0bcohx90UzMpmQNvN9pGmnttV29+3q+2BgYns15TZG6Cs5to?=
 =?us-ascii?Q?BVC85AalDjjb0GUVmmROJKGUBfsj2q1wik3BWdW9I2PcinVIPfTKcU2f97GI?=
 =?us-ascii?Q?49bEQnLe1x2w8PnokSBsF1NKTRqDOw1cAQP6elNyZkV4r1WMSVooviy5gSO/?=
 =?us-ascii?Q?ivJkwrj7Kb7E6M0+iryXm1uydgHP9a0A/0D/+qkf3e6jWA2HNNl9ROQfE+NP?=
 =?us-ascii?Q?JfKFRvREB+1liKzGeF5rxVRTxz/V0dDsZyq20noNRKbee92UuM+HQxH483Rx?=
 =?us-ascii?Q?gPNn/GNI/kLLU3FXjIqyRW9LuwU4yFCpCe+TA62K6ahDxFzw/H3FQ7bqbTLb?=
 =?us-ascii?Q?IkGnKT52Ke/Fxbewsh4qWVUbfABVk7VKwwZHbEyikK0iQ9bPV18cqwaLUXoe?=
 =?us-ascii?Q?y7qHMIFk+iVkHma62EgRz5nqhrhwo6M6jqNHAuVJkhKG+Vi2TcxQdBHwIZfA?=
 =?us-ascii?Q?ZJpc0w7E5Baf+8Hi41ay9s9lidc0lN7Wnx5BTZ04StGCYzj+TJekWGHMtdUQ?=
 =?us-ascii?Q?lfINYZLpoliw+tnVOwrGMDXPkZRzjqCUT02LChTwZFEAVnbpQGmQqqzsFlw3?=
 =?us-ascii?Q?hFNdb1xh4GTbOidvcR9BCL6r/s9z+QTxWFrvgrdN1Ee2WN2lReRXj9LBwVMd?=
 =?us-ascii?Q?iSmMwaIL840xkSSQ+QSBSBMIJ7/N8lSjuoiWg11oNk+YWuY3uee62aSNxuSs?=
 =?us-ascii?Q?MAahEiA9ZYmAst9iif/nW71v8Om7dYdpRsOSAJCfxVoUBbbJk3aHotKYql/N?=
 =?us-ascii?Q?18zhrLAw8NVH1rJGqN+Pd8gYGA5l91YjOD9CPHgjk2sxO3bpvCcEnhduaDJk?=
 =?us-ascii?Q?MgyRoWyuu50FI+SRCHk/QEpf7yDiGCJ45T2Tw0Cax8ievk0olwR3pn8iZ8tK?=
 =?us-ascii?Q?95zk/vTV4CM4cOao4EmzLv9WI1IcfMzVmgDIg7BzooInfRUsI7Q0uwMV7BT1?=
 =?us-ascii?Q?5ulnkz3pJouR8LBRIs+4BCejdkM89RwQ3I4Zbi3NJDrN9PE9gijHYuNS0Z39?=
 =?us-ascii?Q?dl2rhRrSp5jNusMDaXChXPwm0vLqug8UIvPxaHXErm0ITN66MzgezJjH/KnI?=
 =?us-ascii?Q?U0FKtPVe3wanN3hixKlz7kVIcwJvIp6qQWEkUAxzbEYZo9w92jRBH/LimR8J?=
 =?us-ascii?Q?3RCvRIyHFxtqab4TzKj/ntsNWs9uvMEMI7kKkcGFmKx57o0ndHt6KegWgHWg?=
 =?us-ascii?Q?SzT7D9KcWPON0IoNMdS8acscqALSaXU0Esgbz9sLPCaM3azpvODRWtlwx/7l?=
 =?us-ascii?Q?A/TN/L1BRLDyN0LvPLR/WdHZTjY+W1Bj6X9ZRW+NZw95DFHkBpJ5z856ITZf?=
 =?us-ascii?Q?qSnKaVuqUbUnL8GlB/mp6MN21ZzwFo4PNWxmLAuyR5PToXc0F1ehnpa7hbut?=
 =?us-ascii?Q?xY4F59+tBSg4VVfJiPUFcMaKEwzVb4kngEQMGZ3X2G3naLbqvTd5kwSCV0QX?=
 =?us-ascii?Q?w/C9Se/YbFY5ghai4l+zOAGVeo6GY9jXx+ki8tcmosOZA1dRULIBN2i7Xyh2?=
 =?us-ascii?Q?k3HktCd9DAyFr2V7eMw/ZEQM4wTBo2v/hv3boSEyOqtpiBDeDH9I3T3yuFeg?=
 =?us-ascii?Q?eQnDu59j0i9enIQCO4VueUxtuzQx+GKy64cRAl4I+zpie5X/Llk+dD/EVLuT?=
 =?us-ascii?Q?SlruW8MOktwLbkjFlSOeZjni6Ffd/SfZuoJSUAoWWEg9qqsHQQLb5T02Hby0?=
 =?us-ascii?Q?olHERoK8qQOZBlfaUoL5D37IPT7pvqJiO535qagEbSPyOvsOOW2uhYaLgzgK?=
 =?us-ascii?Q?lomTIHsNDF1IbScWmkdlT0NsB64IIVVTHzSpKkvtfv/gG4VrhP6o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2290fb40-7dde-47c2-2777-08dec2d37766
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:24:23.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhRMUe3Zy+shIxU5QEe55Z3/j4lGPlSPTTVDDwUVfY9EGURmsyV0m1YjlV6ZfGMvr/GBxe6h3K2MkyTuWaHhQLJNADkULr47nuOZ4kayBnMGTYLYwbgE0Jvq5vgmbrxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295696-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:from_mime,oss.nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7574F646151

From: Wei Fang <wei.fang@nxp.com>

Add infrastructure for ENETC v4 VFs to track PF link status changes via
the PSI-to-VSI messaging channel. Two new ops,
vf_reg_link_status_notifier and vf_unreg_link_status_notifier, are added
to enetc_si_ops and wired into enetc_phylink_connect() and enetc_close()
for the phy-less path. The feature is populated only in enetc4_vsi_ops;
rev1 hardware is not affected.

On enetc_open(), the VF sends a REGISTER_LINK_CHANGE_NOTIFIER message to
the PF through the VSI-to-PSI messaging channel. The PF records the VF
in link_status_ms_mask, and immediately sends the current link status so
that the VF carrier reflects reality as soon as the interface comes up.
On every subsequent PF link transition the PF broadcasts a 16-bit
notification to all registered VFs.

On the VF side, a dedicated MSI-X vector handles incoming PSI-to-VSI
messages. The interrupt handler schedules a work item which parses the
notification and updates the carrier state via netif_carrier_on() or
netif_carrier_off() accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  |  11 ++
 drivers/net/ethernet/freescale/enetc/enetc.h  |   4 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   9 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 185 +++++++++++++++++-
 4 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index fdceaf36daa7..a1a8a1551cd8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2892,11 +2892,15 @@ static void enetc_clear_interrupts(struct enetc_ndev_priv *priv)
 static int enetc_phylink_connect(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
 	struct ethtool_keee edata;
 	int err;
 
 	if (!priv->phylink) {
 		/* phy-less mode */
+		if (si->ops->vf_reg_link_status_notifier)
+			return si->ops->vf_reg_link_status_notifier(si);
+
 		netif_carrier_on(ndev);
 		return 0;
 	}
@@ -2968,6 +2972,7 @@ int enetc_open(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr_resource *tx_res, *rx_res;
+	struct enetc_si *si = priv->si;
 	bool extended;
 	int err;
 
@@ -3010,6 +3015,8 @@ int enetc_open(struct net_device *ndev)
 err_alloc_tx:
 	if (priv->phylink)
 		phylink_disconnect_phy(priv->phylink);
+	else if (si->ops->vf_unreg_link_status_notifier)
+		si->ops->vf_unreg_link_status_notifier(si);
 err_phy_connect:
 	enetc_free_irqs(priv);
 err_setup_irqs:
@@ -3050,6 +3057,7 @@ EXPORT_SYMBOL_GPL(enetc_stop);
 int enetc_close(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
 
 	enetc_stop(ndev);
 
@@ -3057,6 +3065,9 @@ int enetc_close(struct net_device *ndev)
 		phylink_stop(priv->phylink);
 		phylink_disconnect_phy(priv->phylink);
 	} else {
+		if (si->ops->vf_unreg_link_status_notifier)
+			si->ops->vf_unreg_link_status_notifier(si);
+
 		netif_carrier_off(ndev);
 	}
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 24d9f89aee73..1666dfe81cbb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -300,6 +300,10 @@ struct enetc_si_ops {
 	int (*set_rss_table)(struct enetc_si *si, const u32 *table, int count);
 	int (*setup_cbdr)(struct enetc_si *si);
 	void (*teardown_cbdr)(struct enetc_si *si);
+
+	/* VSI-specific hooks */
+	int (*vf_reg_link_status_notifier)(struct enetc_si *si);
+	int (*vf_unreg_link_status_notifier)(struct enetc_si *si);
 };
 
 /* PCI IEP device data */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 62844344ff29..5dc4532607b3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -84,6 +84,9 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define  PSIMSGSR_MS(n)		BIT((n) + 1) /* n is VF index */
 #define  PSIMSGSR_MC		GENMASK(31, 16)
 
+#define ENETC_VSIMSGRR		0x208
+#define  VSIMSGRR_MC		GENMASK(31, 16)
+
 /* SI statistics */
 #define ENETC_SIROCT	0x300
 #define ENETC_SIRFRM	0x308
@@ -107,6 +110,12 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_SICAPR0	0x900
 #define ENETC_SICAPR1	0x904
 
+#define ENETC_VSIIER	0xa00
+#define  VSIIER_MRIE	BIT(9)
+
+#define ENETC_VSIIDR	0xa08
+#define  VSIIDR_MR	BIT(9)
+
 #define ENETC_PSIIER	0xa00
 #define ENETC_PSIIDR	0xa08
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 418ee98da17d..9cace77110b8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -131,6 +131,37 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 	return err;
 }
 
+static int enetc_msg_link_status_notifier(struct enetc_si *si, bool reg)
+{
+	struct device *dev = &si->pdev->dev;
+	struct enetc_msg_swbd msg_swbd;
+	u8 cmd_id;
+
+	msg_swbd.size = ALIGN(sizeof(struct enetc_msg_generic),
+			      ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
+		return -ENOMEM;
+
+	cmd_id = reg ? ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER :
+		       ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER;
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_LINK_STATUS,
+				  cmd_id, 0, 0);
+
+	return enetc_msg_vsi_send(si, &msg_swbd);
+}
+
+static int enetc_vf_reg_link_status_notifier(struct enetc_si *si)
+{
+	return enetc_msg_link_status_notifier(si, true);
+}
+
+static int enetc_vf_unreg_link_status_notifier(struct enetc_si *si)
+{
+	return enetc_msg_link_status_notifier(si, false);
+}
+
 static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 					      struct sockaddr *saddr)
 {
@@ -411,6 +442,113 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
 
+static void enetc_vf_enable_mr_int(struct enetc_hw *hw)
+{
+	u32 val = enetc_rd(hw, ENETC_VSIIER) | VSIIER_MRIE;
+
+	enetc_wr(hw, ENETC_VSIIER, val);
+}
+
+static void enetc_vf_disable_mr_int(struct enetc_hw *hw)
+{
+	u32 val = enetc_rd(hw, ENETC_VSIIER) & (~VSIIER_MRIE);
+
+	enetc_wr(hw, ENETC_VSIIER, val);
+}
+
+static void enetc_vf_msg_handle_link_status(struct enetc_si *si, u8 class_code)
+{
+	struct net_device *ndev = si->ndev;
+
+	switch (class_code) {
+	case ENETC_LINK_STATUS_CLASS_CODE_UP:
+		if (!netif_carrier_ok(ndev)) {
+			netif_carrier_on(ndev);
+			netdev_info(ndev, "Link is Up\n");
+		}
+		break;
+	case ENETC_LINK_STATUS_CLASS_CODE_DOWN:
+		if (netif_carrier_ok(ndev)) {
+			netif_carrier_off(ndev);
+			netdev_info(ndev, "Link is Down\n");
+		}
+		break;
+	}
+}
+
+static void enetc_vf_msg_task(struct work_struct *work)
+{
+	struct enetc_si *si = container_of(work, struct enetc_si, msg_task);
+	struct enetc_hw *hw = &si->hw;
+	u8 class_id, class_code;
+	u16 pf_msg;
+
+	pf_msg = FIELD_GET(VSIMSGRR_MC, enetc_rd(hw, ENETC_VSIMSGRR));
+	/* W1C to clear the message received interrupt event */
+	enetc_wr(hw, ENETC_VSIIDR, VSIIDR_MR);
+
+	class_id = FIELD_GET(ENETC_PF_MSG_CLASS_ID, pf_msg);
+	class_code = FIELD_GET(ENETC_PF_MSG_CLASS_CODE, pf_msg);
+
+	switch (class_id) {
+	case ENETC_MSG_CLASS_ID_LINK_STATUS:
+		enetc_vf_msg_handle_link_status(si, class_code);
+		break;
+	default:
+		dev_err(&si->pdev->dev,
+			"Unsupported Message Class ID (0x%02x) from PF\n",
+			class_id);
+	}
+
+	enetc_vf_enable_mr_int(hw);
+}
+
+static irqreturn_t enetc_vf_msg_msix_handler(int irq, void *data)
+{
+	struct enetc_si *si = (struct enetc_si *)data;
+
+	enetc_vf_disable_mr_int(&si->hw);
+	queue_work(si->workqueue, &si->msg_task);
+
+	return IRQ_HANDLED;
+}
+
+static int enetc_vf_register_msg_msix(struct enetc_si *si)
+{
+	int irq, err;
+
+	if (is_enetc_rev1(si))
+		return 0;
+
+	snprintf(si->msg_int_name, sizeof(si->msg_int_name), "%s-pfmsg",
+		 pci_name(si->pdev));
+	irq = pci_irq_vector(si->pdev, ENETC_SI_INT_IDX);
+	err = request_irq(irq, enetc_vf_msg_msix_handler, 0,
+			  si->msg_int_name, si);
+	if (err) {
+		dev_err(&si->pdev->dev,
+			"VF messaging: request_irq() failed!\n");
+		return err;
+	}
+
+	/* set one IRQ entry for PSI-to-VSI messaging */
+	enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
+
+	/* Enable message received interrupt */
+	enetc_vf_enable_mr_int(&si->hw);
+
+	return 0;
+}
+
+static void enetc_vf_free_msg_msix(struct enetc_si *si)
+{
+	if (is_enetc_rev1(si))
+		return;
+
+	enetc_vf_disable_mr_int(&si->hw);
+	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
+}
+
 static const struct enetc_si_ops enetc_vsi_ops = {
 	.get_rss_table = enetc_get_rss_table,
 	.set_rss_table = enetc_set_rss_table,
@@ -423,8 +561,36 @@ static const struct enetc_si_ops enetc4_vsi_ops = {
 	.set_rss_table = enetc4_set_rss_table,
 	.setup_cbdr = enetc4_setup_cbdr,
 	.teardown_cbdr = enetc4_teardown_cbdr,
+	.vf_reg_link_status_notifier = enetc_vf_reg_link_status_notifier,
+	.vf_unreg_link_status_notifier = enetc_vf_unreg_link_status_notifier,
 };
 
+static int enetc_vf_wq_task_init(struct enetc_si *si)
+{
+	char wq_name[24];
+
+	if (is_enetc_rev1(si))
+		return 0;
+
+	snprintf(wq_name, sizeof(wq_name), "enetc-%s", pci_name(si->pdev));
+	si->workqueue = create_singlethread_workqueue(wq_name);
+	if (!si->workqueue)
+		return -ENOMEM;
+
+	INIT_WORK(&si->msg_task, enetc_vf_msg_task);
+
+	return 0;
+}
+
+static void enetc_vf_wq_task_destroy(struct enetc_si *si)
+{
+	if (!si->workqueue)
+		return;
+
+	disable_work_sync(&si->msg_task);
+	destroy_workqueue(si->workqueue);
+}
+
 static int enetc_vf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -489,6 +655,18 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 		goto err_alloc_msix;
 	}
 
+	err = enetc_vf_wq_task_init(si);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to init workqueue\n");
+		goto err_wq_init;
+	}
+
+	err = enetc_vf_register_msg_msix(si);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register msg irq\n");
+		goto err_register_msg_msix;
+	}
+
 	err = register_netdev(ndev);
 	if (err)
 		goto err_reg_netdev;
@@ -498,6 +676,10 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 	return 0;
 
 err_reg_netdev:
+	enetc_vf_free_msg_msix(si);
+err_register_msg_msix:
+	enetc_vf_wq_task_destroy(si);
+err_wq_init:
 	enetc_free_msix(priv);
 err_config_si:
 err_alloc_msix:
@@ -524,7 +706,8 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 
 	priv = netdev_priv(si->ndev);
 	unregister_netdev(si->ndev);
-
+	enetc_vf_free_msg_msix(si);
+	enetc_vf_wq_task_destroy(si);
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-- 
2.34.1


