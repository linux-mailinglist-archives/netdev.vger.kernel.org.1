Return-Path: <netdev+bounces-305342-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id powtLgm+TGoupAEAu9opvQ
	(envelope-from <netdev+bounces-305342-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:51:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE687195D3
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:51:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=dX3IQEB1;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305342-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305342-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 936E13092FC6
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED0C347500;
	Tue,  7 Jul 2026 08:47:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46AC3321A1;
	Tue,  7 Jul 2026 08:47:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414047; cv=fail; b=lr3ygF6nSPWR2lEF4KaqKB3tvIvzlfGASzdoO9AwcO0XyCCOk77Ts7bPjB1wcEHKcDY8ZBLM6YXh1lEAvbD/XwyM2geHBzLPSR86m2hbd9PuP9mdd73UFVSlVmLWZq9kfFpQNsRFOEv0adSjWAUKGapcTldhukVqyXmpkZJ7Ijs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414047; c=relaxed/simple;
	bh=xvjOrl8j2+VZ3hmQF/ezfEMrX4IUC8KLg6KMN13jPpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWmlFl0U67TP9fLal7TBLNZMsQu/tHnOqzqGsF295FdeMYb9x6xS667+MvIhJFuEqr2CpLnvPiykruMecBzKgvPgulbd4UyLcbEOHtww66CBATunRvlAoo2bmxRzBrZVVogmKeD3OBZdx1uU7nX17HmfWiGFKqB2aNorQxDgRWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dX3IQEB1; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adcTlW5xZEckMiJ/VTf9Alah6hv4iVdk9paDrR6xPczySKiCNUqxNdAnhbCps/PLPyZyZHkaDGlCF24aouMondZa031+bqSN5LezNcMp+xmFZAp0wCJN/TJqZqRRGbR5BnwS95iMrw6TbJiWtACcgYz7v8Hdr574xdoj7rpZpmruzCP9YlLS4xGTx9sVmCpQFF7hznQkeD4dGqyCxuMSV4dJivKQWabx49t7uad8SloYfFcU552p1qD0vgrJioDlVVzXDFpATF1HgqDxtTT/IBGnx4gJQJoyDH2WeuXtP+/LtJlEdhndH9h1ZCkuM+PSgzk3ebjK76qsYZZc04BOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYjMGG0kvHDgPdRGauLzjXwroEFEnwIdqnPLvRwJK0Y=;
 b=vkVVdMCcS7t6xI156GLHzysVkPeSMdsfDGdV7KLqc8/jlhF52leofUntlzhGc/wlJzcee+YisaBZK+0TYgt7R5EZaH5/nh4Dd7VAEbuD8Ht0S25vQQoANLKUQGcTEtzZ895iWPw/jMVXawCZdqW1x+5AC8uouGOHxQfol6zuH3cQ3nd+IbIuSktiUpOt82Q6UOgyvVb+ZF6zDzslFoTIJyphFUOEVgMJ36G9mgGjti3KDfb7+LU551SiDSyid2xvI7G7b/0KYOA7uMWSwD37ycLGLJHeRYiIvaFCveFjdkdBHtNKrlFycYK3cSzw/o9ViAjy8djrzq7y9Ze1PlTqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYjMGG0kvHDgPdRGauLzjXwroEFEnwIdqnPLvRwJK0Y=;
 b=dX3IQEB1FNEPE1NtPd8gnn3dWl7l2kMyhLfA5gvKg0UU4IaoVam8wJF9K/Qv4NV9lR7d71klj5UyRgzPT/+CYPn1pyeC0KMUfSzX8ygGhf+tuiEoTQGFUKMDfD8PahzEQLYfy9l8WRS0r3Q9CgmUoeO0979MtYQCXQhStNJWQsAvSVyd+bMlH/Wh+ap1L+2CKw8eFN3OEthW8vAg10fz8uhd415Z0rB2qoVRFoGUeSQFbO+uUauFOvGRITX+xxR8yk3uTG+3jJ1zhFLk55aQjRvSnXMVIgB2xxwzv6REmkhoYIMSxIMgS1WZpABl5M3lx131/QxThpRLDLjf3JaUuQ==
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:22 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:22 +0000
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
Subject: [PATCH v4 net-next 05/14] net: enetc: use PCI device name for debugfs directory
Date: Tue,  7 Jul 2026 16:18:25 +0800
Message-Id: <20260707081834.710730-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ea96cd-ce12-4484-a21f-08dedc045c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	3UorJbcpQvZJh/jjhZdXuPSUX0EaimqzyVYk6EcYnNZXZjXVuC1FEjaVIrqK4ElmdZzLUjEIihhw8wZHrMTyQZAL0AgRmuRN8cFPDO6mzG2mWX1YJ1kvas8wxQF313yio1E+wIFB+rHrlNfBlUWu4MCCCmWXn8vnnaW3A6iRbYOsBQorXt8Wl7YY0qHNwSDxiJts2F28zG/U7r4NSQRT8DBeZA87GBe9xSxYOONM+GGqlTlsStb4c/gr1bZHIXG49tRCo35wo0n5mO21u9a9UP1TVNIXvzFQ5JAy6qXTzrvWsFCiBjLs9VfqvypihVwRFt7BNTgffp37q37bcsDU4IkE6l02k5+RrSS7TRH5uUziCF/KIyfo32hXwdsWVuvxhP9GPoYhs7E7qEenZV5E/AKdSQPClqeSpR/EnDCzLerfN2fDHK+1kdUTpsQ69CuWZsapRHOZJUBMSE3+tEHYJdvHuXlvd7axbrIZQoJ8OIQE4X7Ox+OEu5SNbJbiau+gHF9d7sjQuI4SzzdzkP2s/fcpR9yev/aR/8m6uKT6ereNKAILYyEHGMxT/BtoO0zejIR5pL9okzC+dlLS1Q6m1obXjnCEHYbEgc2A9TK3a8RuloWh8ZyDjKGP3uriHjex7MEQf4jt6exH9zFrVCDbfMLfVBNrHzLmasKSzacGtHjHmcQco7CiuEvCAtVPsMEXciwxxQkcgWc9+tfgnf8hNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?riEN7tMdwLYlab0rqH90eRiBZFHEPvBFR/nLcxZMaUG0iFdedR+WwmzkyuZ9?=
 =?us-ascii?Q?6sIGb5z6NIuWGRwV11aJiLmimUQq5WNwBCC6YqBhitKw8UD0gun+UtDgO4u/?=
 =?us-ascii?Q?7vZrxZuRJXxSRPKaJ1iVTTJ/JfLTL6Iv0rN5hqe/2Yawrodc7gS//nD0Cemw?=
 =?us-ascii?Q?BlEj7VGBaxQ+Lov9MtmFlHv+vtIpni2vYR2muoU1DbKCw3ey1sZnV2zsgba1?=
 =?us-ascii?Q?CJDgQx8cl1hibZYo/GXv3mEe2EYT1XfpdDqJEUIzKH7R6Qc1kXkGdThPdLhy?=
 =?us-ascii?Q?RrKSv7Kji8JquBBGFOpW5/Vf218sW6n+d++8vHOFmz4qdiuZzsMs9lahooyU?=
 =?us-ascii?Q?F1y371G7NA6xb0FmbSIZxIDXORB/PbEYnfVe/J6foQyGhNhAY7NIldaDu0W3?=
 =?us-ascii?Q?ekLg0HVExI9O6KMWxZNzAOKIGWx0xLryLEG4i7lWgd/VkvGQsfFbssELNtZ7?=
 =?us-ascii?Q?56NnjHBQWxpuBH4iODZPhXhuno0XQT/BxM6QL1IMYIgphBm02FZSFPY4gU0P?=
 =?us-ascii?Q?uoN19Tl6J9zd8KZVTPZj4vdO4idVYyTYxKHF/11ZQNDu/zmzmgBg9pY7DB16?=
 =?us-ascii?Q?ZN53i5Ow48RxB0lG5f+9K3gsn57Ga7AZgT9VZqz/017scCH6kZT0mc3ka5Pb?=
 =?us-ascii?Q?HhK01QbdQEn0XIdVH/5fDniqlmJSaUqszXxiU3UpOJNP+YmS21HLrji+hLxV?=
 =?us-ascii?Q?iLOrNa4j2cJel/aMdZDHU7DufSXboP3WZ2MCgY1XWxEqmDy/tTKO/tppAhZd?=
 =?us-ascii?Q?8xMp/ztHGyitJbpQ2/9XHfXn+vJy/jT8WRzrebNfJ6r3XSTXvbqTxdGNYxFM?=
 =?us-ascii?Q?/EYu61wd8YS36vrhNhnwq23mVCgZItUv3xdxUQi+GsJmIy+E1aeLUKab96xN?=
 =?us-ascii?Q?dk68m8sLu3+3vLJFxL1tEBm5GDmRb36ri093ruStkHau7WCDD6sQRdmQFeMr?=
 =?us-ascii?Q?m/au22/ysahiIzjU3sOdVJ+Yv+QTQYxu7+BAL0Co/L+BKQ4JNKOu8BbDn1m/?=
 =?us-ascii?Q?ssV41diGOQdwp9rcjIx5ZLM9Y66OU+3lD3Dt0QcxV4Olzdm1jd3f/lMt3Gye?=
 =?us-ascii?Q?w3NLcdPSHNf4CJDld1Qc1Z9KAactJW6PNsUtxqqdNhjJRY45uoESKak4yQc4?=
 =?us-ascii?Q?CHWvpyJhlKVWN1z4rmgsOgPAdjWvitoQn3dbv7Qx23pSPj5gwJZFWb+mSgkw?=
 =?us-ascii?Q?WRrnznzRhkJJa8SjiVrFwaIMcFzgzBG2vZ9PBf4WW1gCrD8t5ip/19ZtwzEz?=
 =?us-ascii?Q?INyLAS1T0/f6y7kUGknn8GlmgO8PMuaF6S8N4WN+FOZmmWW4AClcoZA9flTz?=
 =?us-ascii?Q?yv9zIv7qeb9r1zmrcL07v7tkbPApfzWBeA4F9nEkWHZGhxxBoQ7/3SfaiRUH?=
 =?us-ascii?Q?qTrcHDRA4TF7mPDOTgfkR/DGIJoAR9Nr+8i/9jTK+iBEJB7Ffbc77KakooR/?=
 =?us-ascii?Q?g+Q1Wm6cHcHBImtZyZjfcTzg1Aj5Fvmq/6gvrP3x2p4C+hvE+zZwdo52HIMF?=
 =?us-ascii?Q?+flZ3nsqOp+HYacLwBCLwJ8JzOuDNt/6JKQiluXQNCGcP7be+nVuwgrCWrR7?=
 =?us-ascii?Q?bRfVOs2+idWKXqiQz91MDLykikHTvWAivo1+CznbeveLiuuBcs/irUXx11fn?=
 =?us-ascii?Q?FesWP2hyoscLduGVWa0g1IyZtAmwa+L39JmE2YTlBtLi8r4/ksdPkeI82/R9?=
 =?us-ascii?Q?1yfKHCvYAc60ftwwslQiDo9H0nGkrPxXBjrNWITnX5Ppi7vGEx91souYXs0k?=
 =?us-ascii?Q?/n93Lkf6xh5XfrYIQ+U2U3GfooBIceWkNMD99zGory9TPiEQva/D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ea96cd-ce12-4484-a21f-08dedc045c9c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:22.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5s1wq6MJSzFLkLtQ5+vkf8ObTCb5/5XBBzGAuk/8ZG6dU4Y+XDX0XFXGm28nNLLeWBcHiLFNDzSdTxeXa8eHXkSlB68F7Y1XKjQOqWkaq8yibu8ymKcAY5uUDhIXGet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305342-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AE687195D3

From: Wei Fang <wei.fang@nxp.com>

enetc_create_debugfs() is called right after register_netdev(), at which
point ndev->name still holds the format "eth%d" (e.g., eth0) rather than
the final assigned name (e.g., via udev rules).

Use pci_name() instead of netdev_name() to name the debugfs directory.
The PCI device name is unique, stable, and available from the start,
making it a more reliable identifier for the debugfs entry. Therefore,
the observable debugfs path from something like
/sys/kernel/debug/eth0/mac_filter to a PCI BDF-style path such as
/sys/kernel/debug/0002:00:00.0/mac_filter.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 4a769d9e5679..be378bf8f74d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -81,10 +81,9 @@ DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
 
 void enetc_create_debugfs(struct enetc_si *si)
 {
-	struct net_device *ndev = si->ndev;
 	struct dentry *root;
 
-	root = debugfs_create_dir(netdev_name(ndev), NULL);
+	root = debugfs_create_dir(pci_name(si->pdev), NULL);
 	if (IS_ERR(root))
 		return;
 
-- 
2.34.1


