Return-Path: <netdev+bounces-305344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I/9ZGM2+TGpZpAEAu9opvQ
	(envelope-from <netdev+bounces-305344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:54:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE98719676
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:54:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Q19T5qLt;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305344-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305344-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF69F3110A45
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C424B33BBCB;
	Tue,  7 Jul 2026 08:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0C37EFF0;
	Tue,  7 Jul 2026 08:47:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414059; cv=fail; b=qJHXvkV+ajBHp7PvL19K3vkjYZnpVwcEQGt75jm5SAwx2942+0omDEgvlCfkoz5no3B0D2uwp3m+STdXA/u9+OF+AYUKYWV5A+8ry8AENvW5xIhaYKBtS8xhTRmCoBJKsK11aYWs24eA/tL8tGDVW5HywUyiSscOIFKbNkZNTJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414059; c=relaxed/simple;
	bh=bHKC97jZ63s6Jb95NrktiwUZ+LNixxlw3EPgJ8VzS7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D99TnETBo0eUKdHFajjjWBouLHEUw+tugFClpbDkkS8DVdvBoXBXpOcxDi+5uRmkeGaoPnTmuPlyO5ggI5qmSCviVmchvM4GzlKrdjJ+pyNMIJ00eoa1sbENtPOA6BtvGosWFH2k/o37mpDlBlogBaW99cuCNjqmK5KRLuP99Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Q19T5qLt; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4KWc7C7ZGz7azsGQKB21JSU9XNygY/A1raUUT/aZLed4bKpGlyQsIlKDixakzQg0VSSXtY4R59Mxb5WhD6BYeY7vDY1hp9F/OdVZ8a9Ejrpi3RnFtUI5/t0ZdxPwKh8WphTBqOcWKJNOsh2hWCYSVOkLsvSw39vqlpxn/XUy9g6kOVxRcYG90blGxHFAFtw/wyHbjWIZ/KbqqUVze+0/dgVEhMr6wGQ0Dr+aDgYVzGBi+45Nztq46iZe9r1ns9BKdp8sJIK6RgyYIBinrBFdTUobPJBNSE/oabPyaXV30gI7YozfKcdh+cQp/nusCHrPRSFz+dhDyYS06v8T0Rm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inQ3ZI5MR1NIw05ZhIFaYKjrAJlJ+Efmiu4/L2Xnz1A=;
 b=QR64K2N5s2bETBC8MyE6HCnc7dkRFwZVyaHj1Bubbt2Lf4E+gadQZUbZLWSSSzhsdJUu3tSQXVac2Pb9mClLQ8HeE8hIusgbWPUPmpKx2xCqijes0ckojuZ33cyfX2jUliVnkkT1HUQuCem2nJUK2fCnfx5xCzmxu/Xoei3Vl8HI/7DCwLtjnCyaP4M8xYLwPDAL0uWKrAzSsT8f2rmzQF4WqbsbNYRTs748DGS+7lxXMTwDU9r7oz96xIxEK5BHYFoAVSvkixyhn/j63ipAniuES6lxQXC2HxtZDPOwbDg4IgnGbl61NlzjRyBcQGzc1Vb2c+Y/R39Z/7y9D/BbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inQ3ZI5MR1NIw05ZhIFaYKjrAJlJ+Efmiu4/L2Xnz1A=;
 b=Q19T5qLtOsZLsc8uF9L+YNRcFGcoaj7oAyqmjUGgiE74xVX8XCnRlUAPyq+h0iUCLBER8hg+0iboSe3e7zy2nb8SJjtSwCMkIID4asCT0eD1tVesuR54vaI+twKiogfG7coRMnwfmHXvCEP9/rv/Qe2MHhAjethVUnj5T1BIy2mu6qODbmJFCFa07+/3b+2TaLx5O8W1YAYwmSQYrbDTxGL8WaTiZKzR6mxgogfUx0jDheGZPxCg6l/BDN+Jw16JYIvKhnldU6WNNqswB9A52tesfzbDKc4GIAlAPwR8jFCWJdlOi2QnM/iPb63cTtjbWJIggApaIYNe3gjxrI38ew==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:35 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:34 +0000
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
Subject: [PATCH v4 net-next 07/14] net: enetc: differentiate phylink capabilities for pseudo-MAC and standalone MAC
Date: Tue,  7 Jul 2026 16:18:27 +0800
Message-Id: <20260707081834.710730-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd281af-8901-483a-109b-08dedc0463ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|19092799006|56012099006|6133799003|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	wl0k5sgnl1n1MSQTTgXCEBfA3s7CxN7QqljEqA+5+9oqaq19CZm1N8nhLaCT3minKeAWZBKlDmwVWAerlQxVlfZ6b6B2zWPUWNlXBRwvGIzuEk6SCWShwJIIvWuC5BHvU+QrN8v/PZXMtQH1Ml/f9+1/jUQcQz8M33s4L21nMtRa3OaiMEM8MbZcPEhI+3puO0Z40RA581g0wmUu9B+X0BJ0w5DcRwlmZhrHfxwwDbYNOwexQbigeMIkOv5j5wZgOkI/Sgu30rUpZTe2Z42zh/NUX6JEnkEUKI0YGKC6EjOi3MRNOrrxdrNj+tfyG/I1kZ3Hvi4q/BGwYBlYporcOjrqrFj4nAQ+zzWnOST+YnkGwojlJ2B1ju6LZz38kFfmwo2w9OdnZOciBOrFd5BEnpiG5NMbOMp3gJHIMfuoLD63GrUkC9HTaOQXIYMpX2sV56gF8Xr3Jrr0qm9h8WbB9ImtqJBpRQDUp7TO9MCKRW3/BI2ba+iVP7pEosq2Dp+YD77naBZvROiGRBE7/m+ulpAdEkRzAsSqIiatjvi21EjCDZFB7LDHSCF6PkieMBk3vby5q87IYVMWeJdtE5NrP/5V5VcjD3AGELcoNHyQ5QJNv/VkdD3jfLKe0apW73aTjwKLDBFXnpnnnSl6W17kf9T+f53BiAAMoCUCoqZV2vAFP4tb3r0jDox7EJe7LtOG33YUz5rD8Rg+6imlbnF56g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(19092799006)(56012099006)(6133799003)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rsx0HTbmn2jLyBlq3Wr1gLJgrzZ5tvzc6TEi4PT2xvl/ogrN8rNM+kOlhqza?=
 =?us-ascii?Q?YU5IZac2UsTbL47/wO50Ot1X6KKneKe1Hu/CUsV5xUdpyw2M1a12FPuMBDGJ?=
 =?us-ascii?Q?tCNDwcfssfyoXLB/QyXLrG86tAGmf5uPR9ylUg60E9rTBgBMraykTWGJ8Zer?=
 =?us-ascii?Q?j5scw90WcNsl5Qe3JLw3esoATRn8e6uS4mLOiW0lP/6+tgqI2zRfNiiL61U3?=
 =?us-ascii?Q?kRdnHiEchZZ/Q3OcogwHstQDENUDVZTqT5yS9PKfNYYt7PTdjz32R3IOtJLS?=
 =?us-ascii?Q?Ec2ugCQnIJd5p3/gjic8n5Y4ZEsQY5uKkzE1aIQsOUxGtbIQTCfMqBHX5khT?=
 =?us-ascii?Q?tfwyvirgmgeBWG7Z9kdzqvQLp7KU7xWKMnQwJMcGd0v1qcfdapbfxsDTXyxw?=
 =?us-ascii?Q?pSaN19hQ7QfR1ZPPfwvmqmC2OoDUlqAeknAYrj2IRC2Dus/gxZ4L80nAFHef?=
 =?us-ascii?Q?oS+78YqSgPta3ZxdxAyR8V1g6LdFMggIMl8wBrgjyzzElgUwp4vaLWMz9b4L?=
 =?us-ascii?Q?mFKpTPKzJvI2xIHqOEI182HxIK/LgZOAzkVwMtILEsA1mDums4CeJH8lrHco?=
 =?us-ascii?Q?FIm3IKQmQR15NeNqmhdGc0rFPFc0epaRzUjXKjYuVgcjBe54X79ZnMr/2Oht?=
 =?us-ascii?Q?MePcAR7MbQ+tRoy2ypSMSlk5LwJ5SH0iNSggwu9ae8XQ5sDq43yQD3gWpjsy?=
 =?us-ascii?Q?jWRetskzN0VF5LCUGheBuCWLH7Qf/bQ6MxExNNYnAm2G/5nxuMi5ziCwszfY?=
 =?us-ascii?Q?B150Gbi3nyWTnSYRuWcpAg02XsRzY4eE3vM3MlOORmwnkztUPyXByrvSXM56?=
 =?us-ascii?Q?K8SI1XQR/HiQ1e/SjziwW037OfrQrS6EWsudXh7JG83PD5CfaTAuTo7+veut?=
 =?us-ascii?Q?i2YmrBNu3LC2USGmGZ0sXMRsq4aDHB1q6SX68gBClCgLti9rMWBgrpwcCSyO?=
 =?us-ascii?Q?Kk4UNRcmJ1ws8MkRi6N32ZwzUr2XTLBraNeV2g3ch2aTzFCBoCt4tIpA4heT?=
 =?us-ascii?Q?MLvfLcry8tl5q/PY9VzyCRKfp+2lDEYWof47VIdNpYhnmG6EsU1lb/syhzL/?=
 =?us-ascii?Q?vUmuFSn/gYl2Nba1ZWhE5SmFdMoHi0B7F+dLqUpFk0rQbmO8XpZcKVHRrEU3?=
 =?us-ascii?Q?FCnnEAxoFzuLjd7ayaORn9gCRsoSUlj+xC2dR0UNDaT4afSnM2A1iTik5zyl?=
 =?us-ascii?Q?UTWi40Pv/qXfDsDSo/MMKEqtU3QkFha2jIR0O6X/CIl+5L8hUCmOLeKk4E7B?=
 =?us-ascii?Q?+zC+oAZGPVXtaL/jsG7P6UCSltArPnoorymmzEA0dgtDvmjyMlv83Rck6jY1?=
 =?us-ascii?Q?VS5Jp2R/rr3eghBXjiuSsVrdVYGyS5aspmLXxlGjRAr+IZs1m22eDZOfsqoZ?=
 =?us-ascii?Q?y21chmQjtuGYGKIS9EdBGg3CS5XJg+/eyHf50eUaLOfFLnvFh9P1HrdtoUzs?=
 =?us-ascii?Q?uelNNFwylDntcWioddFjte2HQkg68xeROMIEJPo0zDj5+HPkpG26Gm5emv8Z?=
 =?us-ascii?Q?RkNhrfFjPnC1yMbiThQSYzmg4UzgrS+v1h9YeV59JoFs1x1CKy9jGDpOaOKo?=
 =?us-ascii?Q?yVuRp9TH+95vM6WYz4U/Er2T9/G0/9cPx4E9X1HPYGtnkg9s1yuwg+Aukekx?=
 =?us-ascii?Q?NUI3zRxi6yj/xD+ETLK+hSE8TOnjMlKnVgfz5ino85EPYia3iYDyQnkxDene?=
 =?us-ascii?Q?Kg4iakDj3q9CbCvMNs6CJhKWjr4Z3aUAkabcuBMYooe9NjeqEBiYo/r/1lQD?=
 =?us-ascii?Q?5WnnyvOlvjCESub18mT+BNgPvydj/2KT/Lef2KUqZ+j64L+4FQ/r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd281af-8901-483a-109b-08dedc0463ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:34.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2PPA+tdbwfIctDu1VDo8IaoTXWhMn5iSRywQ4D6gbFVvGd6Ub28QHr5VF0FcX/TVZhOAGZBsxFQcXmxJs09xarjGrwVmTcvMjVGDPLJsllLLRC4dyDgKd33EnHiymKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
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
	TAGGED_FROM(0.00)[bounces-305344-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,oss.nxp.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABE98719676

From: Claudiu Manoil <claudiu.manoil@nxp.com>

The ENETC pseudo-MACs are proprietary internal links that do not
implement any standard MII interface, so restrict their supported PHY
interface modes to PHY_INTERFACE_MODE_INTERNAL only.

Since pseudo-MACs can operate at any speed between 10Mbps and 25Gbps
in multiples of 10Mbps, set their MAC capabilities to cover the full
range of standard full-duplex speeds: 10/100/1000/2500/5000/10000/
20000/25000 Mbps.

For standalone ENETC (v4), expand the supported interface modes to
include 10GBASER in addition to the existing RGMII, SGMII, 1000BASEX,
2500BASEX and USXGMII modes, with MAC capabilities up to 10G. MAC_1000
is replaced with MAC_1000FD to explicitly exclude 1000M half-duplex,
which is not supported.

Note that 10GBASE-R mode of ENETC v4 has not supported yet, the current
patch adds PHY_INTERFACE_MODE_10GBASER simply as preparation for the
upcoming support of the 10GBASE-R mode.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  1 -
 .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++------
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 06a9f1ee0970..8839cfb49bcf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2017-2019 NXP */
+/* Copyright 2017-2019, 2025-2026 NXP */
 
 #include <linux/timer.h>
 #include <linux/pci.h>
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index f24269a48c26..75ee117e9b1d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -602,7 +602,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 		val |= IFMODE_SGMII;
 		break;
 	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_XGMII:
 	case PHY_INTERFACE_MODE_USXGMII:
 		val |= IFMODE_XGMII;
 		break;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3597cb81a7cc..781b22198ca8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2024 NXP */
+/* Copyright 2024-2026 NXP */
 
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
@@ -359,7 +359,8 @@ static bool enetc_port_has_pcs(struct enetc_pf *pf)
 	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
 		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
 		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
+		pf->if_mode == PHY_INTERFACE_MODE_USXGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_10GBASER);
 }
 
 int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
@@ -400,25 +401,42 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 {
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct phylink *phylink;
+	unsigned long mac_caps;
 	int err;
 
 	pf->phylink_config.dev = &priv->ndev->dev;
 	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
 
 	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
 
+	mac_caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
+	if (!enetc_is_pseudo_mac(priv->si)) {
+		mac_caps |= MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD;
+
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pf->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  pf->phylink_config.supported_interfaces);
+
+		if (!is_enetc_rev1(priv->si)) {
+			mac_caps |= MAC_5000FD | MAC_10000FD;
+			__set_bit(PHY_INTERFACE_MODE_10GBASER,
+				  pf->phylink_config.supported_interfaces);
+		}
+
+		phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+	} else {
+		mac_caps |= MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD |
+			    MAC_5000FD | MAC_10000FD | MAC_20000FD |
+			    MAC_25000FD;
+	}
+
+	pf->phylink_config.mac_capabilities = mac_caps;
 	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
 				 pf->if_mode, ops);
 	if (IS_ERR(phylink)) {
-- 
2.34.1


