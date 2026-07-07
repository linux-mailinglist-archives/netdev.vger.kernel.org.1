Return-Path: <netdev+bounces-305346-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qHdwFJS+TGpNpAEAu9opvQ
	(envelope-from <netdev+bounces-305346-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:53:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A68A719644
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:53:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=pBIlw2tn;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305346-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305346-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6904D302BE83
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061BD36EAB8;
	Tue,  7 Jul 2026 08:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83168367F26;
	Tue,  7 Jul 2026 08:47:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414071; cv=fail; b=j4AwIEJamDRQWkox4AZNsUAHucp8v1fpFMy++lOWoohZn07U1BFZ1lvN20xZ+AnhJcp+8INXTVDwq0rHaPX2JISmROpik7jdu5rQIaurxQ4CdVIGPma5on2zMrYnm9GJhyQqGFhhHTO++pA6WZuaKb5145AncMHjWROjhrwhQkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414071; c=relaxed/simple;
	bh=XKD6xvrfVu8mH4lBD+ZuWbD8Fbd1xu9EJHwDhOceSgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHrGwIuzch2lzkSnPEbKT2xEgx2pQhu2894SwjYFLjA39QJ/VuksUV+Pdbgqay75KqCys42843RmDSnz5aS5K5NdDvQXwarMXiBjUROdAWkn0nBEbmLg4Xlqi8lZWgHXMekgQIftxpuLticXOZPDcWxv8/r3OX02sW7EUVnr5eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pBIlw2tn; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g49M+7P0HvF5ksDL1wfZDkGYMeamOAK1MwNBz/YgP4W7xgR7G1l6A9OEFB5S3dUNv18tZ/ACbQcR15BsgSF4p0kQ53cIoybv15z4a0hqOH3e1CcXGoGqs8nd11CFY/a25uy4Ns9kTHJIa+wbGtFxTh5biT2MeFFsXbparFJFL1Bp7NoYXF+jVPbhr3O+Iui6DsWPKCNwoSshjf1EkUQYgwsX61cXQ6KXdqluC5bY2EZvZlBMNEbRzLW9TLaoKxh1m6xefZz/8xRIbT03sgcMwy3BxoRWEiauVD7zOgQYQKdSizO+uJu+6VlfYY6HIXQawl+QzoV/X7QmwprQNL5P2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
 b=rwa4UCuNXEOiSS/fFudcOxDRD0o9mNGVRodeEtCvIu/WRrfEJBJe8RQzVt4OMvR256NDSxl6i7Tkk0lHuOCj5NvORY/Tv33D3bflJeJf58an9wTYifMbqYx/HNgcELus97YYiPqCKbYdpiKKrrlgUygqux/NEUrFyg4fn3tVu77qHpTV/YJ4Bch+f201yQ0oGuf4bXhqnWet21g8YY8Xz6Ylx5B4+v04iLzF1AxXq+aE6Y6Q73NthCztS7YRTQhBN+PLNAbYgm+T1W4kH8lmKRBPttlyvhfAYz8dmKINAgJYpu9nVK7hezzmTw6OXW4ROiJSBjMxpoFuMg74May35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmvpWVF47jUc8h9psj97e6zsVGtTYxdvQZtCviyJaDU=;
 b=pBIlw2tn7xc9V0PEULBHFC+zgtT9smOsChuhlnJE9PcIqGU4/RNHmzOEPzE0YGrA/wri58f5bl9rQ2MGZIGcaJf1Gi/mhJCeoNf869x5g7JICCnfMsE0WKKSWjyPf7nlcFQfVh/DRYWaniNs/8CFjfhJ2jH/Umg9HVHCvGAk0mQtejp+uZASlNVIxJg9CCsIe94kGZzGa8o3zaN2la93qRAkA8vQz8R0OIxCdnrkTwn9Ix8QZIeW/mNU80AYEV/E6TC+6mzf2ltWLl9Rmfomjr/0j0yvDnHLlnysCYLXn8wq3xjSWlsFP82vWmPRlVYGijPzrZsm7VvDycQ0lTQXww==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:47 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:47 +0000
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
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 09/14] net: enetc: open-code enetc4_set_default_si_vlan_promisc()
Date: Tue,  7 Jul 2026 16:18:29 +0800
Message-Id: <20260707081834.710730-10-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4fdf13-5b92-4306-2bfc-08dedc046b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	InPvcSiE66104x9Op3XtB0UFgtfvfNVBBZmBtVfkovdochT9SBca70seNugh+viNUBlbJVJ44xWiKVPZzHb7teSCYfqzvSk55Vg5qupX4/1ps5G566PjlXwiNd8xaakWDIzBu8Eath7Pjy2XF2V0SJGBR6m7Q9QlW5yrec7ZVMqvskGZ49sYzAyDwMiWG3eLQVJi0J9fb/cXLiQQFJBwEWGvBZ6Ba6bMyJPPVvy9Xj3C9UcYV3U9swPivbkuyItli1Q25FluzdBRi8on8BK8MXJOYBD0Vvq3HDOmwA3kVyBiGjiqHGrpAArN+kXsWeVM46BssB0dHOSYWkHxlwdrDybhwkXemQXPWW/nhEXF+lj34oPxGU6wcd0K0qFkt3auInDxYKDIMz5z69TcP6ojVukgDjlBBrxfwuTTzFC2tDXuQCjp/HoL5YdzZfcmqG8Wfts2avQ9lg0onT7/ahLtXFggAIBGQlYwkSEeV9o+N59qIXizp1ddWlY06NmW/pWxGQW7/GJHm/tQ0FgEioJTAP7LKZFXqWa+SL2ocTHhhOA3n6jpnfWEr5cXq3r0Fu1b3N9/nDkbC2q03J4jnWGJy3l5lnu5ZuFue9xiwEil8Hu+gUZLPXuEhd5QS/e3lPwudy0y0p4Y4+92P1EM7dAm7TzK+BlvSORi7kImDY1SjT6VLefocDocyElNonAcirAXukzqAW5GhzJ2rOeXRM7ljw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x/CzgU9MEZnUKMLZKnDuhzdyvmuk4OWK2gIIN1PeH0yntHS37SFE+hiNY2o+?=
 =?us-ascii?Q?ZHeguraHagUsHznn0DqZjKccwWXRvaqIB0xRWNjZ3RQB1YSK8l/MYD/cWwHc?=
 =?us-ascii?Q?VBFf9Bsy884fl6zZH6264uVIV+FXXlcki1q1VBw+tZMi9G8H6xM8qUYbTJfL?=
 =?us-ascii?Q?u0Oc5VXgg/IsgU80qIblsLd8NCHCgZFvCRqY/Cbq3kTeSOW2hkCxGXQ2ySOL?=
 =?us-ascii?Q?yGCPb0ick3LWaoE0LO8sGBb7psVHoexU63NJM98amzqJbjpvmectSaLgBpv1?=
 =?us-ascii?Q?/yNx10D0F4/VYLQd1rfIgSKjRGi7cnFFXos9liVc7g5OmxpyjeRGzi22WQ8x?=
 =?us-ascii?Q?cQJAk5uTdqPOScKHKPfSeyttdOCA7oqqsAPbo2JiQTA8iACZENOrFzwaiUaq?=
 =?us-ascii?Q?ck6Stf9WvkBWc/cO1838cQkbvp/62Y9UA6Ri3k9vMKgnm2gTg3VNRnwrfxK5?=
 =?us-ascii?Q?mp1wxoLvX/b6jc87MKIH1jpHsEPVEbOYGvJCcJNYwSrl5S5FBh72FDt3yUnL?=
 =?us-ascii?Q?Gzf0hdVRowFsyR8UId5vMwW++oor4H4UzRUj0tBVHVlbviAclCSPRVqEAhrq?=
 =?us-ascii?Q?an2tU93ktfJCMplHmbWhEQAj0U2kjKk9mUbzwDD75KesrjR42FFyW6s7E3a9?=
 =?us-ascii?Q?gVFoccUmEhomBoS1ApyusKkfZYpOQ0Iz2x3od6JqYgXOPsFO3kdhAswJjpsd?=
 =?us-ascii?Q?dU+BRJ11Q8oPjwRFEvCMNSQ6gfkBLb+L+1r/WAk3dCRL7MMWaZ+GMvlUa4kC?=
 =?us-ascii?Q?HFBTfHJGJEjcBtdkKExKrb/IOtTlCVrpYcmUQPrrRE7NNEUcgpXsM/NeV0cL?=
 =?us-ascii?Q?dpyjbg1HMqYoWwBmPV8GEP/FALJYX1HOZghNdaXjh8xDj5KFJ7cZMuPIGiKQ?=
 =?us-ascii?Q?5DQ5rW8sqJnDQaqSj1WmZv9Sk+tVfK+N7InWTHXT05jipkeYXgVrYKaj1Fvu?=
 =?us-ascii?Q?O0gU7hfGBjcZS5/ASKw4GaXXBcplECGRiq683KMbdeNu7/y+YQ5oS7hK2qul?=
 =?us-ascii?Q?EdFcEDU/lqkr3XPBvo8Kwa3aAI5QIEuQD+4s2kI2ABDYPm61ggW40k5xc9sn?=
 =?us-ascii?Q?PZOahmyEJVED/eUtmtxsr/l48CXCxYbLMmU4ma4i4ziwuV6larZ6J7cQOcMA?=
 =?us-ascii?Q?eWXWEZzyAgHhhf/fL9SGD/EMRYD5jDm1pcbCw/5AmsQZIkelXFXZke2oGhFL?=
 =?us-ascii?Q?poXe6yBdKYrVihCi9Y4C1nglakYcu/aGOMG9+d22yatObbJR2IMl4aVYYJWJ?=
 =?us-ascii?Q?NCUXfyoDh4gTzFLVsWRoZxI+AUOUfPKhzwCe91epDZqsAJpKdmFNwEKbMNHG?=
 =?us-ascii?Q?oO1FB42UGwCRImysKcsHhax7cxzL+2rs5zS0j8s6whOGyEi2L8Ttq4/YZSJM?=
 =?us-ascii?Q?X42CS9s8+kZ74+a/A+5oij8W4VIjCGaG13tkb0xfLFhcPMSZ+VuX1i2Mqt9q?=
 =?us-ascii?Q?hgtz1Q4yEhFuxOe3eRhlhCYq4+hskiq3al00Z2iF1A9WHaYUUjpA3KC24odn?=
 =?us-ascii?Q?9f81XSaU60aqO1atCOUXDffGxyyef13yXbw36e5aOhbg1nQPm74PsxYrhq32?=
 =?us-ascii?Q?zn8g7tZ4ZdDPNlZfOyKKqeYVY6UG6rcwfZcRMzDGhKYSuS/dNDUJnIWwkyFd?=
 =?us-ascii?Q?cyvNgU81QwX584feFZXzyMQjxc11fHhkhqxSPztMSouNRGk139TBAyTpI2dk?=
 =?us-ascii?Q?qAmtkK8Bs0U1z2KwQlzC2tdPGKn/aHoRhvSYBg7qPTcpBl00VBTszosJJst/?=
 =?us-ascii?Q?nyCdfMQVm2XxrPqPUqqRyRF0pXrDR89unPs9JdKGQ1HMCMZxLN+/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4fdf13-5b92-4306-2bfc-08dedc046b7c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:47.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +A++iAtKY6H8KTxvZ/0S+PTZ+4BRKWeAhOz2ncTXVmeUoY9KQluDZQ5PF9Y9JVsJNLJX4sLZCjwwn/py0Lykz0fxG8vpQ9wm+BBm0F2RAPB18hkuVLG7qqn+DN/qduTA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305346-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:maxime.chevallier@bootlin.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A68A719644

From: Wei Fang <wei.fang@nxp.com>

The function enetc4_set_default_si_vlan_promisc() is only called once,
from enetc4_configure_port_si(). Open-code the loop at the call site
and remove the single-use wrapper.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 859b02f5170a..505e4abf6c37 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -307,17 +307,6 @@ static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
 	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
 }
 
-static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
-{
-	struct enetc_hw *hw = &pf->si->hw;
-	int num_si = pf->caps.num_vsi + 1;
-	int i;
-
-	/* enforce VLAN promiscuous mode for all SIs */
-	for (i = 0; i < num_si; i++)
-		enetc4_pf_set_si_vlan_promisc(hw, i, true);
-}
-
 /* Allocate the number of MSI-X vectors for per SI. */
 static void enetc4_set_si_msix_num(struct enetc_pf *pf)
 {
@@ -361,7 +350,9 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
 	/* Outer VLAN tag will be used for VLAN filtering */
 	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
 
-	enetc4_set_default_si_vlan_promisc(pf);
+	/* Enforce VLAN promiscuous mode for all SIs */
+	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
+		enetc4_pf_set_si_vlan_promisc(hw, i, true);
 
 	/* Disable SI MAC multicast & unicast promiscuous */
 	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
-- 
2.34.1


