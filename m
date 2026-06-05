Return-Path: <netdev+bounces-295687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZJ/8A6F6ImqjYAEAu9opvQ
	(envelope-from <netdev+bounces-295687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:28:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D23B645F8D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:28:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=dMGwoHLU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295687-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295687-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7FFA304D48D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B347AF43;
	Fri,  5 Jun 2026 07:23:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C447A0C7;
	Fri,  5 Jun 2026 07:23:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644208; cv=fail; b=muKJ0r2rKhk8tb/TGzwnl6yHoTea/c4+1c9/8V0oSXFIDbta+6R/jbIisrwYMNtc4fRboGNG0i4C3HSusV+gTddxGjYpfmunlAeVpGrJeOSqSurJ0gRwrb0RKDDCGR+tTr5GR7WiB5HylOhVTpjZf4OK62xJcZvBA5ri9uF0JBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644208; c=relaxed/simple;
	bh=dIIxd9Jy2Rm8U/n7EnZT5c2SpYqBBow0Y14aSQ+7FpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfvwm5NPlasHxvuyeRBWgXJnGnJPs4lIeEAZFKooa/CmZKZkNqIQOqfEtI20/r9OfgtHMjNTTfatk2I7ZT4GwsSUaPlBBvdvFU8r4nrN3Qux3COJQq8nGmo1r1ARdRn54WlIquSxBKmeDbOFbaGRU6tQLL0/gbUrviaFELwb/lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dMGwoHLU; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIehVYWJuBwLGNnHta4RJHmUFKniFv5vNRIhYlcTb/XCagWNoSBnrtsYLLpri1oYDUTT5I2JVVrDM1Qdye4E3S5285mb5hCj+v6f2CccRhO1HZ+zMCNdsQiWoPdNu1ZMWaFW2POFljPIC9VSHeuaKRmGUMwi52IPUpYstSQe+qnihwN8ogXpAXRNz1q3B25oCHZgfV9+1uMRX+ycAoFx4cOPscHTyA0LPzd39t0UI2Oxf2D0s0CTfZng/C1l8Kj6xPpkE8vEKPLBKw93F/wdjGuoXq0iE387/nIzzJVZCXyK8gSY+YIL+lGUU19A8riOHOPH5+rtkOPOPq7tVxdS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRh9Ic1cPesdVKoUks623xlWgPT96E1rH1ZYLsw6/WM=;
 b=Fbu82pUhlxjr9oUUMOdU6nw7f2Rm9us/Hep7iH872/WyfLZdvqDtJxzKmHYFZgXzgt4Wt/w85+USsNnlFyUNFZGU7t2w5fW40O5vk18QOLyUgUpfN0boD31lwXkbuPuxO31WfFfSqibJKoa7a6/VEpAikNVvz5zX5q9DmhbHEZoHDgS3VsxY7FPD9knRgIk05Y44ItJzZ1pstCoMmYD3RlxLJCC+6p6YIF2nVmLdkwU8aUBKZZzsj/3HUNRiB99a2HiAWdeE1+XbED3O6QJ4/S++EIiJWOXxNMShw2Q5xP2ka9Z/8PxZ0I3kbDyHfmwY3AFFtRH4asSNg1dqMCS+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRh9Ic1cPesdVKoUks623xlWgPT96E1rH1ZYLsw6/WM=;
 b=dMGwoHLUMOQ8COjlPXXOvWI6mi4XQt4y3xYarZ089J1jsTIheBzugQtBlOnbVLsMS3U4RCmrKtpXGxlJGxV7XqiXCge1Jc0ArA0xvF1bi2XKIummdA9NejgkibH3HmlOymeEEGO7b5t7HK1+7bj9j45DSGJbSPAN1AhF9/SC6sRbVMQhGp6lzmTPT1KnbScKwIb04WRU9R3jes2oxzpKtst+bQVOF2mdljdG70okwE4V2TqkEZ6wz2myGnB/AsfnC2ieQpVQPVcRNBCTfPt2+G8XnrpGuLsMot6rdaAqe5EQ9CN/Z+7MSU3tnhBO/5cA9rDPmotPjMB8PqPx8RyPuQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:24 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:24 +0000
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
Subject: [PATCH net-next 05/15] net: enetc: use enetc_set_si_hw_addr() to set VF MAC address
Date: Fri,  5 Jun 2026 14:55:40 +0800
Message-Id: <20260605065550.3038579-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 178a96b0-ee47-41eb-b8fa-08dec2d3548c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|22082099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	So+Zz8ZseQPfxdkJRivCIu63KbAe5YSMn5QbfL5RoTlfPWzkldKpW0Dx2hJc0pcbtNhr6IFxBw14MKKXVuls9wCoAKajC/Bm+zaoCGtIZqVXUP9QjyErgh1yAM24OTOlSlnH7UzhlPZj1Bs3Cg5jgdf46exWIIOgVkgz/B3BTIiPAeL15eXhqN/VUD8jO27KzABErK3fE60r+aTMkymu4PkKrLk7WQy4AiY42sQbwGwAP0P34uOlyUT7AIKTKUF/pqrjR1Zl8haTxSqTTD2248sOnHAHsPK+RTwcJ46Z7T99JFWPeZglOkCzWDKeKF8jp6V9ymswMKefAVr+C4YNQBl/lV3avMg66zdJttCPwWUmuyES2htHzuzN0+PhwvVRYYdrMhVj6OyLRJIk1ERPAiqk1mROiy+aW8UrumGPy0z1lwQfylQgLIhJ3GeMsmpwIX1yNuuKX7r9moeEduIJgU1HxXQrE0tQgAeclnhrdxatwZuHUpsHj2C4YI++k3RzHijlGqpIrLv4LFxSwUnHaJofL0CvMxLSnEVJW6EYIsxeQFY/udPA/mJGdILX7n9ZPQZfh+IMCoVG19WAX7nVT+tITpc1dkshOM333MdOS3BW2YdZjvO4im1QMOcxBwXeZZAprL2HxJX2+P34FmXsjOBZoOCXAM/871xNwxGek6j7VK1+k3hK9Gguv18dH+NeJKaeXm/QEHa8dYsSY8KCKI3QuyV14ZPGsEABTCJHA88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(22082099003)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9tmDz1V6Ceka5JP5v7iFckw803NGOcqP8UjbNR4lpN2T4UVbhkfbAxggvVt1?=
 =?us-ascii?Q?SQ6suPLSaxh/dU+Nib56CrRh3neQnldk8NxabeJTONJcZQSt+BwtvPTZedtT?=
 =?us-ascii?Q?/qnsYP8AHwQyumYL5Kk0dju4JzTlu11+zRiy9owC5fkUyPofzA9HToHGN/fP?=
 =?us-ascii?Q?LsVWZcKlq6P77TV8fOoR8RS0ZLQzjOR2yJ0PMROo8Rd7D2SxW+/F5KKqIukh?=
 =?us-ascii?Q?F5LEkj/HT6rgy5NLnAjl/yL/FALg8FSlZRr3gJflF9JQTySYZkaKsof/qMm5?=
 =?us-ascii?Q?WyvC421pq84x/FGxC9J4kU8FBNyQeZ/PMp4JaBGLWzdvyiKh4l3MlQPzBYVV?=
 =?us-ascii?Q?8GhbXwBzAl0sUYhw+k6c+cbiCL0avZojBJQFYdGjrLvU1i/PWoTK3dDMNQ/s?=
 =?us-ascii?Q?uv6IevthA7j3T3m7qjnDdnFwkdmoAv3b1h748/yWFc7N407xU/WsnbTn6waZ?=
 =?us-ascii?Q?Oj6GItvafhK2bLIHIm4kN3uCtve93TvfNh2PuK0lDV2whvTWaio56ABozX7z?=
 =?us-ascii?Q?itBasjJOtS/ZzjYMDAlp7c97cVDEtcr1mYKj9C3/O7Jq/dRT3B40CHeiojHA?=
 =?us-ascii?Q?SC63loSUbpNK5FU3Ab3tm3Gn66f/styHDy7iclUoPJQKCqrlf84FRb/3e5nO?=
 =?us-ascii?Q?iTkDWrx/qmKuTfDj8nWJO/GEqkxDAdhY9wVVhk+iWhqVJzGHKCoHAy9gv0dL?=
 =?us-ascii?Q?HDpUNSBDLWxZHXxt4lwl8DqU5arFI5Tpa18M2flhi1kXPXKOupRjczwI+V11?=
 =?us-ascii?Q?PlLK1Wfqh0HVsZ2B95F3V//VDW8yqcOk7aax9D2AcjREJ9IyaMsKGuVm9Ihr?=
 =?us-ascii?Q?SY4Vz1VqcCfW9hN94QFE/OuhGVHeKp+orzaM4CoXYGyD8ZEAqQ4qnfWPXW5L?=
 =?us-ascii?Q?pxo4ZMlz2BSFc58qVjzpSfzVhGBiXz8boS1awLZ7hcCZHpPnda4hNLh3RUax?=
 =?us-ascii?Q?5/NhTKOykA28bMhOISyO8ilmoyQIhOIA2Voqh6BEZouL6fxZn9WWYpY+IheN?=
 =?us-ascii?Q?s/dnbRiCEd9N1gRpZIoCZO1RIfeLLNriawoxOhjLTaVRmZaPlqWtce2tawQK?=
 =?us-ascii?Q?+tcK0eHKRSCzGN3J5XxUtqdx9K9NpKbYjIh1B0tbj7xAz3eAaBx5HUfsmFHY?=
 =?us-ascii?Q?1yPpR8x4CeIW2EpEFX+i4RMiiPE6CXMHyBfPnjfhlpl0nJh5V5J12YCKhMe/?=
 =?us-ascii?Q?lOrwh06SflzxgNvSp3wd6j4Y1fHqozr8XU8jHCP3NrF+Mtvjaqmgvxpk7BfT?=
 =?us-ascii?Q?bzDAVWIMGLuE3hBhilScgPWn+H+eddgszeotyymMRdtxyB2lYcJdwWqJSPbH?=
 =?us-ascii?Q?VSxhm9tOls+/lzApsmFK8TQFzUwmwigHkLCjtEKM2M6qSOQwGV3vwjdlJUMr?=
 =?us-ascii?Q?B9qyw/YB0Gwhn7tjK52WMmw6VPxipbAROdnpP7G4QImZtSXTcm/i6ahqRBP8?=
 =?us-ascii?Q?lozdxBrcmRMX9zF4C1diKqqBHLXL/bRbeOYqu2yiiOTK0zHlFQgi2DqYYfzC?=
 =?us-ascii?Q?WvZGuEHvJ0+0qznhnOpby3u4H9Y8idUuPM5ASmuxUudPlQlRvpObZP8hDHFo?=
 =?us-ascii?Q?NLpiyzzO3jE3ZbW9qGXDuWlWtkujibImFjn7BFWJ2Spe782ddMkx9vJ9T4Ld?=
 =?us-ascii?Q?njEmI+4dWp2iOETKBjEGw+tViTWKPkQHUiLX9cNIYvpGS/O41+PkMKrKIAgy?=
 =?us-ascii?Q?HEbF2WVxxXnV3Gj/LcsoHe51bFqBfjN8qVxhq5rMx519Q7V0E8Z+Y8Vb+5nN?=
 =?us-ascii?Q?708i+1MHzLlvpqgaSkEsAXTQyPGoKEE1bYY6vVS6/LbYUHXM8O3A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178a96b0-ee47-41eb-b8fa-08dec2d3548c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:24.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ni2WCa3pf4r6OuQNxkUPMzhRHR2F6rEaionRAn5zl/KbgVkpgQM51x6bvfla5smhbH2kiD7quR97kDz6XQCoIvqAjC700n+X88mTs8ArrD8LQ5y0tn4qbQVGynS+pkrf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295687-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D23B645F8D

From: Wei Fang <wei.fang@nxp.com>

Prepare for moving enetc_pf_set_vf_mac() into the enetc-pf-common driver
by replacing enetc_pf_set_primary_mac_addr() with enetc_set_si_hw_addr().

This makes the VF primary MAC configuration path generic and allows
future enetc v4 PF driver to reuse the same interface.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 8957e74314d1..4a16bc49312b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -255,7 +255,7 @@ static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 
 	mutex_lock(&vf_state->lock);
 	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, vf + 1, mac);
+	enetc_set_si_hw_addr(pf, vf + 1, mac);
 	mutex_unlock(&vf_state->lock);
 
 	return 0;
-- 
2.34.1


