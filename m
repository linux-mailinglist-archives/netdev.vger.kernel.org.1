Return-Path: <netdev+bounces-295571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z/KEOsctImodTgEAu9opvQ
	(envelope-from <netdev+bounces-295571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:00:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C30A64490C
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 04:00:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Xm9+dEmP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295571-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295571-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87DD930FD690
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D8311C35;
	Fri,  5 Jun 2026 01:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA243E9C25;
	Fri,  5 Jun 2026 01:46:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623972; cv=fail; b=PgngiWH2cAv3E/hLq7gL9z9Gx+HqJxiW70SJVkeqiU6CKn0GEH0+ZJJ8llHlK6EjJPSOoCSzVjqw0k5FSTnq/7OIc8MGe/sX9Tet3IPVDg3oYOGm5+Suj/gKMopGgIORPHCgQTsvqbnspN5vFCP7mpipei+k1QBepHgM6zbckW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623972; c=relaxed/simple;
	bh=19e08ZR58v5OhaGMPjpoHwC4hp+fIzhn/7bn4JDwcPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s58FnitHXdjtaLt0MetYXaLtnFXhp4UCvQb2kxhTnh0gVus5+yqIzjuMbVYvoy+FCPY2JJGru1+QmWEkPWmwk4SyNMy3NCb2uXPRYSupbggimnogU/HEfOQhRcYORFM3KUH6OHcedzXh7c8sjEG03SdKrWKgJDfq6SfgqxpOyEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Xm9+dEmP; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cf/MAzJjPS/GLzarX7DoZ7lt5f4dS4syA4vHWhT7prT23uQ/Qes1BdDsIDFGL38OzUO2ZiG3B7fKcVgfCMTWNZiADGYLadPukNlidjx5/omuakKJKqWyhCS3+vOC1KmDTiT5NU0A0SuG2RqEDLziWBXxQAOeEHWd/6rkG0OarjNSilzTnzvVEAZ5fOhY3raFUa20pIDnFHRGLYq6QBOtpWi7JZZ4bf5b6Y2AQ5XfVZI1Rurr4PT8Cm4wZb/p3QeFWhHJwZISnZHJkNTOy/myqhs+a4fIKz+m8924kkmlb0ytigIXHAEiKaKSwBq3fifZ25ySrLr3kWTp8wTX70d9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8hv5F2uO3P4Fc3Roxp7usnuzMdModucCgQrnh7OEI0=;
 b=gvWiodQvG0By1aIe5ebedgPdfl/4dNjASHSENbk9BKom7hMzuangPafbInWxRpliKZB09wb/+1XASbrnm07DwvX3J0GDSMb/jRxcK2gjEa6rV4zNUm5SupMgGPVCvGExzuwtKUXHGrz0UXD63afhiExT9vrtsNJ6kQnZkPogGNZKVulgNA+St+09N50IpobNVYSKrD4eYk7Xg9veox5YumKSl/tTuCbAg3ObkaUWACy36jbUNWzaQ7F5MWnUs6Lyva3TA19EW+xL5fg99pIe9KlZbD+U2Z6I9cEjXQxCDDHv60SYNO1pypqNYdselI6McA8XcTsACV9D6mgt4joLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8hv5F2uO3P4Fc3Roxp7usnuzMdModucCgQrnh7OEI0=;
 b=Xm9+dEmPHuXR4BVFRj+vLrNtvrwtO5FORNPL0B6N90uzyiBVS5244A8K7CQxe7vdroLuhBSL5yeG9HhLmlZFSldZFdQv/9WdYdqcoY80lE9oSk+nguOEWYd6iF8KQKFoYXkF2VbIGPUp+sbJolywWUWYX/50qG4JNHl1nwW99/g7Z8WdcHZkBzP26ZTMjnYqpeqjgTV9cOasPpwT9RhZqZy9X8dtvSo4rU1Vk0mtJQJrYrNWsnd4h16uAw9Me+G9RK2zoAT7cI+wYMnya/akgGg6Sm/CoZCgaEI23/f5ucrOwd84e/hVqtFebhAjia4K8jmyXRwY4OvZTYEh9FwPFQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB9375.eurprd04.prod.outlook.com (2603:10a6:102:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:45:43 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:45:43 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 7/9] net: dsa: netc: add VLAN filter table and egress treatment management
Date: Fri,  5 Jun 2026 09:48:06 +0800
Message-Id: <20260605014808.686024-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605014808.686024-1-wei.fang@oss.nxp.com>
References: <20260605014808.686024-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: 26eff897-0b5f-489b-1259-08dec2a4280d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|6133799003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	vntxzHcy3kzctTGnr5PAOWbjCa8SFn5csO9QGQ+sWR5Apuk084+R4uDFrrr5yC3eB+xjTFsmQCly+pbNyjggTsVuS2HetZ5pC+Ap8UwgT++MQvDVjYlOeeqoIy14AwfbRbqx2/1DxweibO3lSgGCqbfkmTItZcn9uLYx4vAejlTgGSs71uqREF83IqAQRafD8/BN/1LH9nN0XvZzR2PyZ/S5BGCEGyYtMg2uwRbXzO/7ezLDEb2EXNpLIgLif/viHHG4i4FqiVu+rtjOUf+KRltkG0iT05sq61OXh+3PCIXOB7D1vmuFEoCblJdsXeQNNzkCRH1Kh9p3dJipiFE86y0fZCrvoTQLPely6N1pWpOUZy/4FNp8PVVFPUvOb/fob6jHo9XJXsbYa+/oIjwZHlbeqiknedQ7JlU2dE5lSS8tA1+g8sJRhmAs7uqRtzOHNbmUt6TKL5+fO9quODLoQRMYN5daP2eZx8pZz4kp5CTGfqxh0cRhQ+Q/q0f3w0KIwyFB7wTWNAjPuZLTHbwIKduKuQ9xSCla9FiCozOjlMKq5CJ59m0IG+TpEjqqfA7MzU8Z58Ls9h2Vm872FeQV+hGgt4zrRo6j68svrnV9QXpm2RhKfGexCqnRCge3GTGcmRrHQyfaB8YN0+L/qfZGpDG6KEelJ8jyGk9MpJ32B6hRC5YHyPyg+NZno1qFneKdEV1AJlsxMkgt5s5gcCK/l1IxBbIj/C3z4fMjYeo83Hg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PgCDY8MJ+lprQ5gkBvjU8FDIn9anSnNpdhEzyEQCzbd11iKcugQgUyPURtAU?=
 =?us-ascii?Q?9tdBmEZxfMYeznMjYUPMPoO9yreAR5Bb6ZRl9EI+g+TjL2wiiFLkGmCdjiGx?=
 =?us-ascii?Q?AFqvceF5PYRyEF1sanHkkSak5qyvog+0aepuk/6/1G2QXQvZR6T4a5aJZ3tz?=
 =?us-ascii?Q?O9Mkn6rgOuX/ac0HawEtxTIUgwDh/RHmlFbdf1v2x3qkdWPHhz2NVjXaqSI0?=
 =?us-ascii?Q?5dc0nRa+A4t70pzVL58oFvr+k/XtdhkXbWuimLlAFEGY2J6W3gWdHeSjAcJ3?=
 =?us-ascii?Q?YOnWnWiGY/kUbrjH26UuLTOdECDUkqxOEeBHdUy4p17TScvJWVSZ41oR+E4L?=
 =?us-ascii?Q?40DrSFtIWDagm0tj79ljwZCNjUGUmBDn1ailLyp0vwREH93aGJBuPjKV80qL?=
 =?us-ascii?Q?MrHPSmYMgwQ15TcRDV/bzeEuPFDMWqbGm23cbgGSL2m4O0TnRjQOLaeHk1fO?=
 =?us-ascii?Q?Bc72OZapzeuI7vEhJVaXBoQJfWF2Oxu3UTrdRaDIZ2KGWQfJFxEVibKXKcDx?=
 =?us-ascii?Q?VbFd/9zeDeoE1ms01mfjKmw0mxdhI39JTrJeXHu6E5BsV5OD0GxCbYIloMKe?=
 =?us-ascii?Q?eZ/vShRRw6YRnJ6i5tUMljhEBATsRep4tA+NPn/i8ulEQ3wqCH/6YtY9ukEC?=
 =?us-ascii?Q?U/43E4AVRtZHCEP4rUcMIyAVKN5G62xGTESPE6W3Bryp/7Xb/dmcKGLjvhah?=
 =?us-ascii?Q?yuMfPgbl9AfEjLLxlKP6z7MV8PWGJp8V52fxjH4JTLqove31WrKaOr8RSn/5?=
 =?us-ascii?Q?03UrGysd3QMYv2BKEathay499fdynjN6WR33jxTDAGXL27CtM3sAXdMf4DWK?=
 =?us-ascii?Q?kdzE0sEbLDnreKHvAAjwxl31d+AAERETVS4EsvXKTcZnPAakulqh7yzEYH99?=
 =?us-ascii?Q?wMWDSLDCHey+0JhxDKt2tGXHaFPGa/+vBmYt0GSSlyNajSDwz7Az7UaQS0wR?=
 =?us-ascii?Q?ezgD0/i2bSN+btq5EPV+r4rwLat6hJFT3B2f58301oeulCIMUozfe+qLQ6ic?=
 =?us-ascii?Q?e0x3/RnX2HUlGqA8myE2vkiQcDZldILY9CEMkOuRkdaj7eQ1QmfAEG9EY65k?=
 =?us-ascii?Q?rcQuehtG/tSKwt6NLdQb+KhsB86H5DVqSGUXdbxND1MoKHsbraCEZKPwOQAo?=
 =?us-ascii?Q?7q3nNLze4DSWCESPuxBNnBxBryXn3XuVjjR19UpkBARq1wFW+zqhWX86k8Lj?=
 =?us-ascii?Q?VcEbW8d5zxONEHGVCWInlirTmbvAkysjNMoOmtaJ2LyWRr7t64uD0m0KiqgN?=
 =?us-ascii?Q?SZfFM3JjZj+V3zpxXXczBg9PV5m+XCaUbuHkT/a08b6EzldZprFrZtRFc+Mt?=
 =?us-ascii?Q?cUFDX0BoMfolxJ/oxUP7L9xx/xuwLSU/HGquuvtThHJCopWXn5k5dIhvI05T?=
 =?us-ascii?Q?4EnHXrEwB48YCZXPqzjLRwWFHJAM4nlP5vihHzaB+3IJRz6VH4WhO+H0H9ec?=
 =?us-ascii?Q?ElVSg5GfbxBEWEb6d8dEpDHWoipinAXWvgze1xl3a9zfu3qKZQBiKVrbhmkx?=
 =?us-ascii?Q?ifDIee1a0gzhEA+k4dW6c4yJ0khyU7RSpLNfm6SBm6E5p6G1AZzNmsyD5TSY?=
 =?us-ascii?Q?e2/+XO6ZRWVm1O6TZrG28m6lwNIEaPAypMc+VWhfYTtAN7BDnl7yrumhvxip?=
 =?us-ascii?Q?daCbdZjSEQhb2nTtdXEwm2rzRnV7Cl5vZck+RA8UVrXZkfx3+dT2v4ZEriDl?=
 =?us-ascii?Q?/905/PNYYmSGdK90gekWa5Xcwg2pvXNXcqhU47aEaWsG8tz0WGYgVJGr7z8r?=
 =?us-ascii?Q?xUwf5LnBkf2yiwBZK7AQVI8BEQAe22Z+Fh93b4Ww/AwTHlroCYNJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26eff897-0b5f-489b-1259-08dec2a4280d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:45:43.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ctptm6nVvoRjS41V249peSz0vRrJa9fZ1bQMh6GbWd/OWxf3sWBlNJTj9dI5A9CXChtlizLBXmzS8m0HyQ+zeLk3U46emQpg6PZXFqLfVbfoHyvacTnQ+4Hu2YtdSRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9375
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295571-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chleroy@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.nxp.com:from_mime,oss.nxp.com:mid,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C30A64490C

From: Wei Fang <wei.fang@nxp.com>

Implement the DSA .port_vlan_add and .port_vlan_del operations to enable
VLAN-aware bridge offloading on the NETC switch.

VLAN membership is maintained in the VLAN Filter Table (VFT). Adding the
first port to a VLAN creates a new VFT entry with hardware MAC learning
and flood-on-miss forwarding; subsequent ports update the existing
entry's membership bitmap. Removing the last port deletes the entry.

Egress tagging is handled through the Egress Treatment Table (ETT). Each
VLAN is allocated a group of ETT entries, one per available port. Ports
are assigned a sequential ett_offset during initialisation, used to
address each port's entry within the group. Untagged ports configure the
ETT to strip the outer VLAN tag; tagged ports pass frames through
unmodified. Each ETT group is optionally paired with an Egress Counter
Table (ECT) group for per-port frame counting, allocated on a best-effort
basis. When the egress rule of an ETT entry changes, the counter of the
corresponding ECT entry will be recounted to track the number of frames
that match the new egress rule.

A software shadow list serialised by vft_lock tracks active VLAN state
across both port membership and egress tagging. VID 0 is used for single
port mode and is ignored by both callbacks.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 438 +++++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h |  24 ++
 include/linux/fsl/ntmp.h           |  15 +
 3 files changed, 477 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index d4475ad7ed6c..1e1873528ccc 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -37,6 +37,27 @@ static void netc_destroy_fdb_list(struct netc_switch *priv)
 		netc_del_fdb_entry(entry);
 }
 
+static struct netc_vlan_entry *
+netc_lookup_vlan_entry(struct netc_switch *priv, u16 vid)
+{
+	struct netc_vlan_entry *entry;
+
+	hlist_for_each_entry(entry, &priv->vlan_list, node)
+		if (entry->vid == vid)
+			return entry;
+
+	return NULL;
+}
+
+static void netc_destroy_vlan_list(struct netc_switch *priv)
+{
+	struct netc_vlan_entry *entry;
+	struct hlist_node *tmp;
+
+	hlist_for_each_entry_safe(entry, tmp, &priv->vlan_list, node)
+		netc_del_vlan_entry(entry);
+}
+
 static enum dsa_tag_protocol
 netc_get_tag_protocol(struct dsa_switch *ds, int port,
 		      enum dsa_tag_protocol mprot)
@@ -222,6 +243,7 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	struct device *dev = priv->dev;
 	struct netc_port *np;
 	struct dsa_port *dp;
+	int ett_offset = 0;
 	int err;
 
 	priv->ports = devm_kcalloc(dev, priv->info->num_ports,
@@ -251,6 +273,8 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	dsa_switch_for_each_available_port(dp, priv->ds) {
 		np = priv->ports[dp->index];
 		np->dp = dp;
+		np->ett_offset = ett_offset++;
+		priv->port_bitmap |= BIT(dp->index);
 
 		err = netc_port_get_info_from_dt(np, dp->dn, dev);
 		if (err)
@@ -831,6 +855,8 @@ static int netc_setup(struct dsa_switch *ds)
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
+	INIT_HLIST_HEAD(&priv->vlan_list);
+	mutex_init(&priv->vft_lock);
 
 	netc_switch_fixed_config(priv);
 
@@ -858,6 +884,7 @@ static int netc_setup(struct dsa_switch *ds)
 	 * hardware state.
 	 */
 	mutex_destroy(&priv->fdbt_lock);
+	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
 
 	return err;
@@ -867,6 +894,8 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 {
 	netc_destroy_fdb_list(priv);
 	mutex_destroy(&priv->fdbt_lock);
+	netc_destroy_vlan_list(priv);
+	mutex_destroy(&priv->vft_lock);
 }
 
 static void netc_free_host_flood_rules(struct netc_switch *priv)
@@ -1025,6 +1054,384 @@ static void netc_switch_get_ip_revision(struct netc_switch *priv)
 	priv->revision = FIELD_GET(IPBRR0_IP_REV, val);
 }
 
+static void netc_init_ett_cfge(struct ett_cfge_data *cfge,
+			       bool untagged, u32 ect_eid)
+{
+	u32 vuda_sqta = FMTEID_VUDA_SQTA;
+	u16 efm_cfg = 0;
+
+	if (ect_eid != NTMP_NULL_ENTRY_ID) {
+		/* Increase egress frame counter */
+		efm_cfg |= FIELD_PREP(ETT_ECA, ETT_ECA_INC);
+		cfge->ec_eid = cpu_to_le32(ect_eid);
+	}
+
+	/* If egress rule is VLAN untagged */
+	if (untagged) {
+		/* delete outer VLAN tag */
+		vuda_sqta |= FIELD_PREP(FMTEID_VUDA, FMTEID_VUDA_DEL_OTAG);
+		/* length change: twos-complement notation */
+		efm_cfg |= FIELD_PREP(ETT_EFM_LEN_CHANGE,
+				      ETT_FRM_LEN_DEL_VLAN);
+	}
+
+	cfge->efm_eid = cpu_to_le32(vuda_sqta);
+	cfge->efm_cfg = cpu_to_le16(efm_cfg);
+}
+
+static int netc_add_ett_entry(struct netc_switch *priv, bool untagged,
+			      u32 ett_eid, u32 ect_eid)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+	struct ett_cfge_data cfge = {};
+
+	netc_init_ett_cfge(&cfge, untagged, ect_eid);
+
+	return ntmp_ett_add_entry(ntmp, ett_eid, &cfge);
+}
+
+static int netc_update_ett_entry(struct netc_switch *priv, bool untagged,
+				 u32 ett_eid, u32 ect_eid)
+{
+	struct ntmp_user *ntmp = &priv->ntmp;
+	struct ett_cfge_data cfge = {};
+
+	netc_init_ett_cfge(&cfge, untagged, ect_eid);
+
+	return ntmp_ett_update_entry(ntmp, ett_eid, &cfge);
+}
+
+static int netc_add_ett_group_entries(struct netc_switch *priv,
+				      u32 untagged_port_bitmap,
+				      u32 ett_base_eid,
+				      u32 ect_base_eid)
+{
+	struct netc_port **ports = priv->ports;
+	u32 ett_eid, ect_eid;
+	bool untagged;
+	int i, err;
+
+	for (i = 0; i < priv->info->num_ports; i++) {
+		if (!ports[i]->dp)
+			continue;
+
+		untagged = !!(untagged_port_bitmap & BIT(i));
+		ett_eid = ett_base_eid + ports[i]->ett_offset;
+		ect_eid = NTMP_NULL_ENTRY_ID;
+		if (ect_base_eid != NTMP_NULL_ENTRY_ID)
+			ect_eid = ect_base_eid + ports[i]->ett_offset;
+
+		err = netc_add_ett_entry(priv, untagged, ett_eid, ect_eid);
+		if (err)
+			goto clear_ett_entries;
+	}
+
+	return 0;
+
+clear_ett_entries:
+	while (--i >= 0) {
+		if (!ports[i]->dp)
+			continue;
+
+		ett_eid = ett_base_eid + ports[i]->ett_offset;
+		ntmp_ett_delete_entry(&priv->ntmp, ett_eid);
+	}
+
+	return err;
+}
+
+static int netc_add_vlan_egress_rule(struct netc_switch *priv,
+				     struct netc_vlan_entry *entry)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 ect_eid = NTMP_NULL_ENTRY_ID;
+	u32 ett_eid, ett_gid, ect_gid;
+	int err;
+
+	/* Step 1: Find available egress counter table entries and update
+	 * these entries.
+	 */
+	ect_gid = ntmp_lookup_free_eid(ntmp->ect_gid_bitmap,
+				       ntmp->ect_bitmap_size);
+	if (ect_gid == NTMP_NULL_ENTRY_ID) {
+		dev_info(priv->dev,
+			 "No egress counter table entries available\n");
+	} else {
+		ect_eid = ect_gid * num_ports;
+		for (int i = 0; i < num_ports; i++)
+			/* There is no need to check the return value, the only
+			 * issue is that the entry's counter might be inaccurate,
+			 * but it will not affect the functionality, it is only
+			 * for future debugging.
+			 */
+			ntmp_ect_update_entry(ntmp, ect_eid + i);
+	}
+
+	/* Step 2: Find available egress treatment table entries and add
+	 * these entries.
+	 */
+	ett_gid = ntmp_lookup_free_eid(ntmp->ett_gid_bitmap,
+				       ntmp->ett_bitmap_size);
+	if (ett_gid == NTMP_NULL_ENTRY_ID) {
+		dev_err(priv->dev,
+			"No egress treatment table entries available\n");
+		err = -ENOSPC;
+		goto clear_ect_gid;
+	}
+
+	ett_eid = ett_gid * num_ports;
+	err = netc_add_ett_group_entries(priv, entry->untagged_port_bitmap,
+					 ett_eid, ect_eid);
+	if (err)
+		goto clear_ett_gid;
+
+	entry->cfge.et_eid = cpu_to_le32(ett_eid);
+	entry->ect_gid = ect_gid;
+
+	return 0;
+
+clear_ett_gid:
+	ntmp_clear_eid_bitmap(ntmp->ett_gid_bitmap, ett_gid);
+
+clear_ect_gid:
+	if (ect_gid != NTMP_NULL_ENTRY_ID)
+		ntmp_clear_eid_bitmap(ntmp->ect_gid_bitmap, ect_gid);
+
+	return err;
+}
+
+static void netc_delete_vlan_egress_rule(struct netc_switch *priv,
+					 struct netc_vlan_entry *entry)
+{
+	u32 num_ports = netc_num_available_ports(priv);
+	struct ntmp_user *ntmp = &priv->ntmp;
+	u32 ett_eid, ett_gid;
+
+	ett_eid = le32_to_cpu(entry->cfge.et_eid);
+	if (ett_eid == NTMP_NULL_ENTRY_ID)
+		return;
+
+	ett_gid = ett_eid / num_ports;
+	ntmp_clear_eid_bitmap(ntmp->ett_gid_bitmap, ett_gid);
+	for (int i = 0; i < num_ports; i++)
+		ntmp_ett_delete_entry(ntmp, ett_eid + i);
+
+	if (entry->ect_gid == NTMP_NULL_ENTRY_ID)
+		return;
+
+	ntmp_clear_eid_bitmap(ntmp->ect_gid_bitmap, entry->ect_gid);
+}
+
+static int netc_port_update_vlan_egress_rule(struct netc_port *np,
+					     struct netc_vlan_entry *entry)
+{
+	bool untagged = !!(entry->untagged_port_bitmap & BIT(np->dp->index));
+	u32 num_ports = netc_num_available_ports(np->switch_priv);
+	u32 ett_eid = le32_to_cpu(entry->cfge.et_eid);
+	struct netc_switch *priv = np->switch_priv;
+	u32 ect_eid = NTMP_NULL_ENTRY_ID;
+	int err;
+
+	if (ett_eid == NTMP_NULL_ENTRY_ID)
+		return 0;
+
+	ett_eid += np->ett_offset;
+	err = netc_update_ett_entry(priv, untagged, ett_eid, ect_eid);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to update VLAN %u egress rule on port %d\n",
+			entry->vid, np->dp->index);
+		return err;
+	}
+
+	if (entry->ect_gid != NTMP_NULL_ENTRY_ID) {
+		/* Each ETT entry maps to an ECT entry if ect_gid is not NULL
+		 * entry ID. The offset of the ECT entry corresponding to the
+		 * port in the group is equal to ett_offset.
+		 */
+		ect_eid = entry->ect_gid * num_ports + np->ett_offset;
+		ntmp_ect_update_entry(&priv->ntmp, ect_eid);
+	}
+
+	return 0;
+}
+
+static int netc_port_add_vlan_entry(struct netc_port *np, u16 vid,
+				    bool untagged)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	u32 index = np->dp->index;
+	u32 bitmap_stg;
+	int err;
+	u16 cfg;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->vid = vid;
+	entry->ect_gid = NTMP_NULL_ENTRY_ID;
+
+	bitmap_stg = BIT(index) | VFT_STG_ID(0);
+	cfg = FIELD_PREP(VFT_MLO, MLO_HW) |
+	      FIELD_PREP(VFT_MFO, MFO_NO_MATCH_FLOOD);
+
+	cfge = &entry->cfge;
+	cfge->et_eid = cpu_to_le32(NTMP_NULL_ENTRY_ID);
+	cfge->bitmap_stg = cpu_to_le32(bitmap_stg);
+	cfge->fid = cpu_to_le16(vid);
+	cfge->cfg = cpu_to_le16(cfg);
+	cfge->eta_port_bitmap = cpu_to_le32(priv->port_bitmap);
+
+	if (untagged)
+		entry->untagged_port_bitmap = BIT(index);
+
+	err = netc_add_vlan_egress_rule(priv, entry);
+	if (err)
+		goto free_vlan_entry;
+
+	err = ntmp_vft_add_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to add VLAN %u entry on port %d\n",
+			vid, index);
+		goto delete_vlan_egress_rule;
+	}
+
+	netc_add_vlan_entry(priv, entry);
+
+	return 0;
+
+delete_vlan_egress_rule:
+	netc_delete_vlan_egress_rule(priv, entry);
+free_vlan_entry:
+	kfree(entry);
+
+	return err;
+}
+
+static bool netc_port_vlan_egress_rule_changed(struct netc_vlan_entry *entry,
+					       int port, bool untagged)
+{
+	bool old_untagged = !!(entry->untagged_port_bitmap & BIT(port));
+
+	return old_untagged != untagged;
+}
+
+static int netc_port_set_vlan_entry(struct netc_port *np, u16 vid,
+				    bool untagged)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	int port = np->dp->index;
+	bool changed;
+	int err = 0;
+
+	mutex_lock(&priv->vft_lock);
+
+	entry = netc_lookup_vlan_entry(priv, vid);
+	if (!entry) {
+		err = netc_port_add_vlan_entry(np, vid, untagged);
+		goto unlock_vft;
+	}
+
+	/* Check whether the egress VLAN rule is changed */
+	changed = netc_port_vlan_egress_rule_changed(entry, port, untagged);
+	if (changed) {
+		entry->untagged_port_bitmap ^= BIT(port);
+		err = netc_port_update_vlan_egress_rule(np, entry);
+		if (err) {
+			entry->untagged_port_bitmap ^= BIT(port);
+			goto unlock_vft;
+		}
+	}
+
+	cfge = &entry->cfge;
+	if (cfge->bitmap_stg & cpu_to_le32(BIT(port)))
+		goto unlock_vft;
+
+	cfge->bitmap_stg |= cpu_to_le32(BIT(port));
+	err = ntmp_vft_update_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		dev_err(priv->dev,
+			"Failed to update VLAN %u entry on port %d\n",
+			vid, port);
+
+		goto restore_bitmap_stg;
+	}
+
+	mutex_unlock(&priv->vft_lock);
+
+	return 0;
+
+restore_bitmap_stg:
+	cfge->bitmap_stg &= cpu_to_le32(~BIT(port));
+	if (changed) {
+		entry->untagged_port_bitmap ^= BIT(port);
+		/* Recover the corresponding ETT entry. It doesn't matter
+		 * if it fails because the bit corresponding to the port
+		 * in the port bitmap of the VFT entry is not set. so the
+		 * frame will not match that ETT entry.
+		 */
+		if (netc_port_update_vlan_egress_rule(np, entry))
+			entry->untagged_port_bitmap ^= BIT(port);
+	}
+unlock_vft:
+	mutex_unlock(&priv->vft_lock);
+
+	return err;
+}
+
+static int netc_port_del_vlan_entry(struct netc_port *np, u16 vid)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_vlan_entry *entry;
+	struct vft_cfge_data *cfge;
+	int port = np->dp->index;
+	u32 vlan_port_bitmap;
+	int err = 0;
+
+	mutex_lock(&priv->vft_lock);
+
+	entry = netc_lookup_vlan_entry(priv, vid);
+	if (!entry)
+		goto unlock_vft;
+
+	cfge = &entry->cfge;
+	vlan_port_bitmap = FIELD_GET(VFT_PORT_MEMBERSHIP,
+				     le32_to_cpu(cfge->bitmap_stg));
+	/* If the VLAN only belongs to the current port */
+	if (vlan_port_bitmap == BIT(port)) {
+		err = ntmp_vft_delete_entry(&priv->ntmp, vid);
+		if (err)
+			goto unlock_vft;
+
+		netc_delete_vlan_egress_rule(priv, entry);
+		netc_del_vlan_entry(entry);
+
+		goto unlock_vft;
+	}
+
+	if (!(vlan_port_bitmap & BIT(port)))
+		goto unlock_vft;
+
+	cfge->bitmap_stg &= cpu_to_le32(~BIT(port));
+	err = ntmp_vft_update_entry(&priv->ntmp, vid, cfge);
+	if (err) {
+		cfge->bitmap_stg |= cpu_to_le32(BIT(port));
+		goto unlock_vft;
+	}
+
+unlock_vft:
+	mutex_unlock(&priv->vft_lock);
+
+	return err;
+}
+
 static int netc_port_enable(struct dsa_switch *ds, int port,
 			    struct phy_device *phy)
 {
@@ -1297,6 +1704,35 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	netc_port_remove_host_flood(np, old_host_flood);
 }
 
+static int netc_port_vlan_add(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan,
+			      struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	bool untagged;
+
+	/* The 8021q layer may attempt to change NETC_STANDALONE_PVID
+	 * (VID 0), so we need to ignore it.
+	 */
+	if (vlan->vid == NETC_STANDALONE_PVID)
+		return 0;
+
+	untagged = !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
+
+	return netc_port_set_vlan_entry(np, vlan->vid, untagged);
+}
+
+static int netc_port_vlan_del(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (vlan->vid == NETC_STANDALONE_PVID)
+		return 0;
+
+	return netc_port_del_vlan_entry(np, vlan->vid);
+}
+
 static void netc_phylink_get_caps(struct dsa_switch *ds, int port,
 				  struct phylink_config *config)
 {
@@ -1575,6 +2011,8 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.port_mdb_add			= netc_port_mdb_add,
 	.port_mdb_del			= netc_port_mdb_del,
 	.port_set_host_flood		= netc_port_set_host_flood,
+	.port_vlan_add			= netc_port_vlan_add,
+	.port_vlan_del			= netc_port_vlan_del,
 	.get_pause_stats		= netc_port_get_pause_stats,
 	.get_rmon_stats			= netc_port_get_rmon_stats,
 	.get_eth_ctrl_stats		= netc_port_get_eth_ctrl_stats,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 4fbd12825b67..9ff334301fbc 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -74,6 +74,7 @@ struct netc_port {
 	struct dsa_port *dp;
 	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	struct mii_bus *emdio;
+	int ett_offset;
 
 	u16 enable:1;
 	u16 uc:1;
@@ -94,6 +95,14 @@ struct netc_fdb_entry {
 	struct hlist_node node;
 };
 
+struct netc_vlan_entry {
+	u16 vid;
+	u32 ect_gid;
+	u32 untagged_port_bitmap;
+	struct vft_cfge_data cfge;
+	struct hlist_node node;
+};
+
 struct netc_port_stat {
 	int reg;
 	char name[ETH_GSTRING_LEN] __nonstring;
@@ -108,10 +117,13 @@ struct netc_switch {
 	const struct netc_switch_info *info;
 	struct netc_switch_regs regs;
 	struct netc_port **ports;
+	u32 port_bitmap; /* bitmap of available ports */
 
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+	struct hlist_head vlan_list;
+	struct mutex vft_lock; /* VLAN filter table lock */
 
 	/* Switch hardware capabilities */
 	u32 htmcapr_num_words;
@@ -153,6 +165,18 @@ static inline void netc_del_fdb_entry(struct netc_fdb_entry *entry)
 	kfree(entry);
 }
 
+static inline void netc_add_vlan_entry(struct netc_switch *priv,
+				       struct netc_vlan_entry *entry)
+{
+	hlist_add_head(&entry->node, &priv->vlan_list);
+}
+
+static inline void netc_del_vlan_entry(struct netc_vlan_entry *entry)
+{
+	hlist_del(&entry->node);
+	kfree(entry);
+}
+
 int netc_switch_platform_probe(struct netc_switch *priv);
 
 /* ethtool APIs */
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 4d329488763d..d3b6c476b91a 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -262,6 +262,21 @@ struct bpt_cfge_data {
 	__le32 fc_ports;
 };
 
+union ntmp_fmt_eid {
+	__le32 index;
+#define	FMTEID_INDEX		GENMASK(12, 0)
+	__le32 vuda_sqta;
+#define FMTEID_VUDA		GENMASK(1, 0)
+#define FMTEID_VUDA_DEL_OTAG	2
+#define FMTEID_SQTA		GENMASK(4, 2)
+#define FMTEID_SQTA_DEL		2
+#define FMTEID_VUDA_SQTA	BIT(13)
+	__le32 vara_vid;
+#define FMTEID_VID		GENMASK(11, 0)
+#define FMTEID_VARA		GENMASK(13, 12)
+#define FMTEID_VARA_VID		BIT(14)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
-- 
2.34.1


