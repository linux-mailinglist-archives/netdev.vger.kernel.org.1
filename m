Return-Path: <netdev+bounces-252607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPTzNJ7ccmmNqgAAu9opvQ
	(envelope-from <netdev+bounces-252607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:27:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85C6F9B6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E695F3043D55
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE693793B5;
	Fri, 23 Jan 2026 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ks74pUty"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838430AAB8;
	Fri, 23 Jan 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769135028; cv=fail; b=Ev1N49hW8TYItaf+TsN6Msa8ZekQbnIw4IaYMmocq1P9u4XH1e7cTM5EEeifXlYLv26gHKCit0jScA4cMdJ8tiOkNQYXuoZPSyqErS42S6Fr1h679nHKuePt5CU1XQUL+crphkvi+Uy3TAVe1lN+KtcBm4XNS9G5rrhCgx1mjBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769135028; c=relaxed/simple;
	bh=xYz1sFsdu0olCRgAKr/ByP69H8K9fVtA4KdG2fZV0NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JZljYwoBUBSi5gfI67F5VAPth2XY9aAD1ByqhhiYMsZhvDHUwRKpuHASicsLDcniSwJlU8pkDOx2X5RnxFZnz2zGYj5YxQBJNWssSp8xh1+0hFEkSuXmrqenExp7Nw4PqWZ3qN9zzAT3mOBe6eEwRbt5yxgGV4YUg8D1cBT5FdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ks74pUty; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8OlYoj0uzmyxkkbl9REfxE+pe3TTjjt5LEqv83lKkx24oZHOJIdPKfKoDcmAb+HGaEbhSn+ndvA6feeuGrzMHtxohdNbQRkC+q7c54bYp74SvxWDSAewDboFJ6jF4lvf4CsaO2u+L0hEoL9CON0y3VbrRmX/YQc5D+jJKNHnuXx3GpEe0Eey/7bO83FXgecdNGwihiLsDGQD+PD4K/L+7gQzxs9uXH7y+EOnUZc9xmE52ysgcfz4EEe1txQFKCA03DM7aALfYCC63hVh1tYQtIXci56l1JRMmWbduzGVRGQE1vlsd1MoGP2Rdna9q8j7LBCGOaxYeCG0WMsCNBRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95h6F/7FVVkL2vmRhn8X0v4AHM/PT7tYFczJWtOZx64=;
 b=e1+I7PtESuyPPZD3GSq/nrEQ9GrpaG4DP7KtK+TA0WHgZemvdVMALNztRo3SlnRACZl1XCsinqiAcdzEhkFVPiNGFEs/0Ucz24mycMiRwiNFrtLdoFsQxt0hbtHqJAtBwz2umxZ0Dbb5H8cZ3WSV0o0cPv9NqJlaAMIcS4QIZdI2dR+Kti7VvViWPBHrcwqL9LRf66HWGyO95Wq4ef/1U82k/djgS4A/t71cteCNiQY3uXWirBItRiTWPA5Zwn3xK3diu5/x9NIY0mAOdi4kUcMgMobWj7X8NWq8e8qdQIzDXIDQMw3CjCcJZidsypfAO+OIEOdScWuhS7R0TVVjZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95h6F/7FVVkL2vmRhn8X0v4AHM/PT7tYFczJWtOZx64=;
 b=ks74pUtyiyCigKNlB+pOJsdCFG9L1BxwaH4owW3kANL96xzk/LHq2aFrZcYR0wqQlEb+XhsrhAbbWhmi2yQLh0fRji86DtWMRTjwyVhY8o353phrWtbxpubkmTn9Eih0Jl/e3EPolrJZmTFqVWGLZ4QdndE5b4rAtg60wtIRthBiNfFfHXnKSCePKN8j4yb9sfsb5hAzgkSvVJXfmOUFqq74QKVV1CBCOfucZFHOEJ53VcFJ76bsaA5HSVUXFvp9X76aFlbPWdcx3PJAslfShR8jV5sfCFGgNfWvJM3+S61TRw+EoZl+p1rINZBvViVUYKUqkPnyWFuiTPYr+fy3BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11974.eurprd04.prod.outlook.com (2603:10a6:150:2e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 23 Jan
 2026 02:22:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Fri, 23 Jan 2026
 02:22:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v4 net-next 06/15] net: fec: add fec_enet_rx_queue_xdp() for XDP path
Date: Fri, 23 Jan 2026 10:21:34 +0800
Message-Id: <20260123022143.4121797-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123022143.4121797-1-wei.fang@nxp.com>
References: <20260123022143.4121797-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV4PR04MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d06e38a-414d-40c8-ff92-08de5a2642c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3sIkFlhGQL9IZVgcSlPsiltBObepf4rN8fv/z/6jMctFLYBFJU8ek4AZWHzO?=
 =?us-ascii?Q?zfIU9v4vsuqQ5He3epeNl5rl64zTMnCQ9pi9PCsJztByaljJBuTzk8Vjenx8?=
 =?us-ascii?Q?5JJT9Z+4MGhWE8MdpesdDPWoTWZbzDOvZp7L+o+sFb7wT1HD+3RcGLvj57bo?=
 =?us-ascii?Q?KKNt/N88CELsTEDh7WJkCkGj7iP0dDCqR3maSWCKtvHZaBVXEj1RJFcHyu14?=
 =?us-ascii?Q?uKVPOS3xukgibKvZ3IW/+PjDA5shlm3F1kljCidWfJzSH5JlH0JzVt9IMCsL?=
 =?us-ascii?Q?VjnmAGh7SRAVs4qvUo9dhpIJYnAd25jJkGGMMp0K0iLKuzQJ4Ui2E7MJyHyY?=
 =?us-ascii?Q?4agZTWzx3x28n2EmQYmx+QFrJjAN1qnTXzb14Q96WDM1CIdYY3iBUzdil86F?=
 =?us-ascii?Q?6Oz3xzE5RSUgCSAffbtZ9D6mMddJId6PkxuEODusuIhJsbGHSC74GRYLh5F5?=
 =?us-ascii?Q?qqfYd+RkRC3VSktql1GwiST/OCt5Fr9hU0LULF9AiwlstXVOBFZQQzE1+VU1?=
 =?us-ascii?Q?WiowL94QgOt5KwNFndvA+ZzuTks7dA3TiCX6w0Gc4f/4/XvVXT8yIHdHg9aI?=
 =?us-ascii?Q?X+H//JiihO1C538ylw6oISsQ+fVKBScfps5giXqeJd0Klflvii2w6etOK1Kl?=
 =?us-ascii?Q?DOVJE4zODUZN0Lujkun43KZJ6nYkwnTH6faA3dBzJ1G83DojDFpaiG5vDOEv?=
 =?us-ascii?Q?J9+qfSLOfAq5ez+KjI8Ids1QkTSbmWcC8p6nvT32HvynfRI5qmutG8fr2Vfl?=
 =?us-ascii?Q?hP5fGdoNSgsrGbjVO/B1N/CpLeZtvsanQbngA7c1yKjS8ejgwsUmy6sQtE9L?=
 =?us-ascii?Q?wwn40Q2TBo+pD3Vbpjl8cvDf7Sn4CTwWaq5TMlGNU6F9+0k+KNFi4UIZqYBe?=
 =?us-ascii?Q?+WjlxMxcOBlRL7jvrr7nThl8ViY91umWpnLNS7GltUxmKV0XjT3zWXFm5/Sg?=
 =?us-ascii?Q?ePf6Styv9iF6k1Va5oV+XrUw2sgrnWN5fJlzAZZj8mQRR54c6UDqmbycDm4G?=
 =?us-ascii?Q?/xjmbgK6xltZ5bDy0PH7SHGKqMzFGO2wy5jUmb2MtooDqN5Dx5rrKcMkv/Nt?=
 =?us-ascii?Q?pa33GXo+5Q7OqEwimQjg9/WU3mu5f9u2rgZPrC0tC4DpyT3ir358bONTbMET?=
 =?us-ascii?Q?ajapGiFtzvwGnE32ORT5EzbXaa9yPsLDwgojzQrSroYbT8g3zdK/nWeQcKsb?=
 =?us-ascii?Q?ayOIFkQPMI9mMPpdFjxaOIVY8arrYnrAR18/bluGW5vUO9lebz5yPBZshKTX?=
 =?us-ascii?Q?lanYHnrfVlaLRPuDZ9BbjfIzZiM7xwuarI/2YjaTBmP35b8gr472vCba7H/m?=
 =?us-ascii?Q?sdkp27j/W9THpEnzTdTKpXCBMZ5o4XRiPuSuSGz7J6fLA9N1NkbiY3RjTBot?=
 =?us-ascii?Q?+I01Dgqppa+ReShTTOyG9LuMQIhlhqhiyYkP1nruMM7FAKHX8krPamHiiN0v?=
 =?us-ascii?Q?5+UYb8KVuBMv0kUqbFi+8VrMkp/B4S0MAZcIMim4ofpaGaQR53yUr+st5Vi/?=
 =?us-ascii?Q?PWXpTjdEvLJEJJ/lbujnKkKGlruv8Sl4PuPyGge00e5fP9nZoPA0qdPfZQ7/?=
 =?us-ascii?Q?ulXX7AV0N59WkXCkJQFYa8qPqJERh9ZmSrBVP8vbhmGbkPXr1dvde+LQT3g8?=
 =?us-ascii?Q?1GwBXQivwkvCmmcbrwiZv1BkNrvssDTXiLpjhj6WjpcV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/qrlXHtJSiHKG7vth5JmIdD64hm93VKOXP8vwvEbNNhUuIayOi6KEOFF/AXP?=
 =?us-ascii?Q?Z5aNIDVJcVzn7HYz81f77kyWevcSyjEZWlXAT3k2bjvakHM04Uicvz+s789i?=
 =?us-ascii?Q?ZDKsq5s3OlcwMi29U4fY/m84o5T6tIcayBk9F646kwUMuU3k6eEfj9Sl6olh?=
 =?us-ascii?Q?l0JT7MtvKljCies0Dt2qXRiFhOTCbie0gpISskls8IMZOpZc+y+OoeqmxmTM?=
 =?us-ascii?Q?/2kSOIfT6qvEoNE/aI2Idx5CKEMqbBFHpijlnTQ/FMQD2nvrz+Piqdchs5b4?=
 =?us-ascii?Q?PiWjZ2f2N6QmMxufRxS3n03L/Qj0Z0ea6A2Tmx4/6RwL2hPyvvUNTYodvAc5?=
 =?us-ascii?Q?Iw7OK+L0c9n701e7GkWdY0xFvAD/sE8CXw2VdPx4oWshohg519to8dDD5Ra5?=
 =?us-ascii?Q?ULaMQnfMfC45igXFFdL6tUJxClHDMFo22DHrgao4Phqfxe7Bl4pb1BmCoCdw?=
 =?us-ascii?Q?d/fxq+GySYCDQtqAR1E57ojoCjqtUftICTFFzHr4FLd8gNzx6doNLiZGRQ8p?=
 =?us-ascii?Q?npEgw3BvYU2BzOpCsEglhbLYfJpKiUcO1p/geZGgN2D/lrlEuPmwnPrbSTbt?=
 =?us-ascii?Q?nBwONyPPYko0FmKvBWKz5Cxgj/49NXsF7tqjAwagS0TJh4ZSAl+fR0MgORIO?=
 =?us-ascii?Q?Bnwd0TMcgzYHXJUpXo4BWzxbk+ExlSCEo6FHSHhcI8kHgysnBMECfFfPYWo+?=
 =?us-ascii?Q?PxC7uytYS52TsZxCzMIOp5YZY20yaC3s8TeSld5UixX7QDQvC8YE6202vRcl?=
 =?us-ascii?Q?VcU1oVxzAEPt1GHrvmg9N/jlEjmKfFJdCbRk/uGYbdLuj9EYjiOjKciX3QSg?=
 =?us-ascii?Q?Tb7LESpIqyMD/IozHOWP7QPzxGc+19DHAixmyOKCxTnDlDhPxY0Cb47dO/vB?=
 =?us-ascii?Q?qNN/6irVN5kH/KNFrDnfFfxqZR4FoyEJYtZW7DDE/KqDtipbPxR4LtHUiEna?=
 =?us-ascii?Q?Rayqcr4xQXGiXmdqZqEoHkfGwergdawJVZWhaCkTx+k/7oL60WcufLkAp1bi?=
 =?us-ascii?Q?DK5jwZLVO4+j9D4w7uXgwkcFuyAc5uqtbYie8MGEpo2Pc/ggtA9ygj9AIo0h?=
 =?us-ascii?Q?DiQaiB8lj9D/J7cdhZilwd9h3Qp2jO7rm1yuLJ1srhUVHmEqfSv+EM79yWCR?=
 =?us-ascii?Q?COTevOmApw3wCQwRwN9Rc70N8gCbBKs5NyrQ9Rqxdl5hVQM4zYh4Z7Mk10I/?=
 =?us-ascii?Q?gKvaACY0p+j76OeU2RKXzoh4JtQfYqFKTS7pl5veQKiz7KztSOQdlGYuBL+x?=
 =?us-ascii?Q?2gn1pAOzLz8XffPBopLQdkF7jJ4293z8ZIzw9cUWZcHBjxWCE8NA8p8cydXb?=
 =?us-ascii?Q?4Y7IC+RtsGYi+aSKE80nSGQfq0uWBSPoz0dbfETvL8HemxKg0S3/taJKb5Gh?=
 =?us-ascii?Q?v0O6b70W+Mlfm3w7zRIBqwair+Di2Ve33fvBbL51FC9MSvxITWPjX2jS6Ktl?=
 =?us-ascii?Q?LnAf8sMlF5fZo2hrYQERRV2IYl5WzKvGiCEoTaWIs0OWIdZg/BOprDEORiy8?=
 =?us-ascii?Q?3rv4w9wbQBvb+7qwqmyCdUv5w/JT3+ffHymF1kRpoQPk1oz0dy1RuEctQWv5?=
 =?us-ascii?Q?6EJsgNPrE3S+5AfqLo5fwBgigd33Ebd54GG/quUDRjIFRAf1VexvsD4EiOS8?=
 =?us-ascii?Q?AsXW/DefogvgyrJNxScJnLOKeClmvArET/JV2y4B5+K1VHOh/vMwXPxg9A/C?=
 =?us-ascii?Q?rW40kpA5zp0vMdH+9L6bsbU7wJnmyNudlcRBquKU6cmtLci4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d06e38a-414d-40c8-ff92-08de5a2642c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:22:31.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvUKLetYBo4C5raeZ4vu8aguss1aUVSSY3eHfXFleX/Af+Dyvq+Ex5ubvcsiV+KKia8zH3zdzCdYlib7Hf3Adg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252607-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 4D85C6F9B6
X-Rspamd-Action: no action

Currently, the processing of XDP path packets and protocol stack packets
are both mixed in fec_enet_rx_queue(), which makes the logic somewhat
confusing and debugging more difficult. Furthermore, some logic is not
needed by each other. For example, the kernel path does not need to call
xdp_init_buff(), and XDP path does not support swap_buffer(), etc. This
prevents XDP from achieving its maximum performance. Therefore, XDP path
packets processing has been separated from fec_enet_rx_queue() by adding
the fec_enet_rx_queue_xdp() function to optimize XDP path logic and
improve XDP performance.

The XDP performance on the iMX93 platform was compared before and after
applying this patch. Detailed results are as follows and we can see the
performance has been improved.

Env: i.MX93, packet size 64 bytes including FCS, only single core and RX
BD ring are used to receive packets, flow-control is off.

Before the patch is applied:
xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After the patch is applied:
xdp-bench tx eth0
Summary                   409,975 rx/s                  0 err,drop/s
Summary                   411,073 rx/s                  0 err,drop/s

xdp-bench drop eth0
Summary                   700,681 rx/s                  0 err/s
Summary                   698,102 rx/s                  0 err/s

xdp-bench pass eth0
Summary                   211,356 rx/s                  0 err,drop/s
Summary                   210,629 rx/s                  0 err,drop/s

xdp-bench redirect eth0 eth0
eth0->eth0                320,351 rx/s                  0 err,drop/s      320,348 xmit/s
eth0->eth0                318,988 rx/s                  0 err,drop/s      318,988 xmit/s

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 256 ++++++++++++++--------
 1 file changed, 170 insertions(+), 86 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 0529dc91c981..86447a7cb963 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1665,71 +1665,6 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	return 0;
 }
 
-static u32
-fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
-		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
-{
-	unsigned int sync, len = xdp->data_end - xdp->data;
-	u32 ret = FEC_ENET_XDP_PASS;
-	struct page *page;
-	int err;
-	u32 act;
-
-	act = bpf_prog_run_xdp(prog, xdp);
-
-	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
-	 * max len CPU touch
-	 */
-	sync = xdp->data_end - xdp->data;
-	sync = max(sync, len);
-
-	switch (act) {
-	case XDP_PASS:
-		rxq->stats[RX_XDP_PASS]++;
-		ret = FEC_ENET_XDP_PASS;
-		break;
-
-	case XDP_REDIRECT:
-		rxq->stats[RX_XDP_REDIRECT]++;
-		err = xdp_do_redirect(fep->netdev, xdp, prog);
-		if (unlikely(err))
-			goto xdp_err;
-
-		ret = FEC_ENET_XDP_REDIR;
-		break;
-
-	case XDP_TX:
-		rxq->stats[RX_XDP_TX]++;
-		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
-		if (unlikely(err)) {
-			rxq->stats[RX_XDP_TX_ERRORS]++;
-			goto xdp_err;
-		}
-
-		ret = FEC_ENET_XDP_TX;
-		break;
-
-	default:
-		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
-		fallthrough;
-
-	case XDP_ABORTED:
-		fallthrough;    /* handle aborts by dropping packet */
-
-	case XDP_DROP:
-		rxq->stats[RX_XDP_DROP]++;
-xdp_err:
-		ret = FEC_ENET_XDP_CONSUMED;
-		page = virt_to_head_page(xdp->data);
-		page_pool_put_page(rxq->page_pool, page, sync, true);
-		if (act != XDP_DROP)
-			trace_xdp_exception(fep->netdev, prog, act);
-		break;
-	}
-
-	return ret;
-}
-
 static void fec_enet_rx_vlan(const struct net_device *ndev, struct sk_buff *skb)
 {
 	if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX) {
@@ -1842,19 +1777,14 @@ static struct sk_buff *fec_build_skb(struct fec_enet_private *fep,
 static int fec_enet_rx_queue(struct fec_enet_private *fep,
 			     u16 queue, int budget)
 {
-	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
 	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
-	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	bool need_swap = fep->quirks & FEC_QUIRK_SWAP_FRAME;
-	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
 	struct net_device *ndev = fep->netdev;
 	struct bufdesc *bdp = rxq->bd.cur;
 	u32 sub_len = 4 + fep->rx_shift;
-	int cpu = smp_processor_id();
 	int pkt_received = 0;
 	u16 status, pkt_len;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
 	struct page *page;
 	dma_addr_t dma;
 	int index;
@@ -1870,8 +1800,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	/* First, grab all of the stats for the incoming packet.
 	 * These get messed up if we get called due to a busy condition.
 	 */
-	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
-
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
 		if (pkt_received >= budget)
@@ -1902,17 +1830,6 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 					DMA_FROM_DEVICE);
 		prefetch(page_address(page));
 
-		if (xdp_prog) {
-			xdp_buff_clear_frags_flag(&xdp);
-			/* subtract 16bit shift and FCS */
-			xdp_prepare_buff(&xdp, page_address(page),
-					 data_start, pkt_len - sub_len, false);
-			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
-			xdp_result |= ret;
-			if (ret != FEC_ENET_XDP_PASS)
-				goto rx_processing_done;
-		}
-
 		if (unlikely(need_swap)) {
 			u8 *data;
 
@@ -1961,7 +1878,168 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 	}
 	rxq->bd.cur = bdp;
 
-	if (xdp_result & FEC_ENET_XDP_REDIR)
+	return pkt_received;
+}
+
+static void fec_xdp_drop(struct fec_enet_priv_rx_q *rxq,
+			 struct xdp_buff *xdp, u32 sync)
+{
+	struct page *page = virt_to_head_page(xdp->data);
+
+	page_pool_put_page(rxq->page_pool, page, sync, true);
+}
+
+static int fec_enet_rx_queue_xdp(struct fec_enet_private *fep, int queue,
+				 int budget, struct bpf_prog *prog)
+{
+	u32 data_start = FEC_ENET_XDP_HEADROOM + fep->rx_shift;
+	struct fec_enet_priv_rx_q *rxq = fep->rx_queue[queue];
+	struct net_device *ndev = fep->netdev;
+	struct bufdesc *bdp = rxq->bd.cur;
+	u32 sub_len = 4 + fep->rx_shift;
+	int cpu = smp_processor_id();
+	int pkt_received = 0;
+	struct sk_buff *skb;
+	u16 status, pkt_len;
+	struct xdp_buff xdp;
+	struct page *page;
+	u32 xdp_res = 0;
+	dma_addr_t dma;
+	int index, err;
+	u32 act, sync;
+
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
+	flush_cache_all();
+#endif
+
+	xdp_init_buff(&xdp, PAGE_SIZE << fep->pagepool_order, &rxq->xdp_rxq);
+
+	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
+		if (pkt_received >= budget)
+			break;
+		pkt_received++;
+
+		writel(FEC_ENET_RXF_GET(queue), fep->hwp + FEC_IEVENT);
+
+		/* Check for errors. */
+		status ^= BD_ENET_RX_LAST;
+		if (unlikely(fec_rx_error_check(ndev, status)))
+			goto rx_processing_done;
+
+		/* Process the incoming frame. */
+		ndev->stats.rx_packets++;
+		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
+		ndev->stats.rx_bytes += pkt_len - fep->rx_shift;
+
+		index = fec_enet_get_bd_index(bdp, &rxq->bd);
+		page = rxq->rx_buf[index];
+		dma = fec32_to_cpu(bdp->cbd_bufaddr);
+
+		if (fec_enet_update_cbd(rxq, bdp, index)) {
+			ndev->stats.rx_dropped++;
+			goto rx_processing_done;
+		}
+
+		dma_sync_single_for_cpu(&fep->pdev->dev, dma, pkt_len,
+					DMA_FROM_DEVICE);
+		prefetch(page_address(page));
+
+		xdp_buff_clear_frags_flag(&xdp);
+		/* subtract 16bit shift and FCS */
+		pkt_len -= sub_len;
+		xdp_prepare_buff(&xdp, page_address(page), data_start,
+				 pkt_len, false);
+
+		act = bpf_prog_run_xdp(prog, &xdp);
+		/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync
+		 * for_device cover max len CPU touch.
+		 */
+		sync = xdp.data_end - xdp.data;
+		sync = max(sync, pkt_len);
+
+		switch (act) {
+		case XDP_PASS:
+			rxq->stats[RX_XDP_PASS]++;
+			/* The packet length includes FCS, but we don't want to
+			 * include that when passing upstream as it messes up
+			 * bridging applications.
+			 */
+			skb = fec_build_skb(fep, rxq, bdp, page, pkt_len);
+			if (!skb) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_PASS);
+			} else {
+				napi_gro_receive(&fep->napi, skb);
+			}
+			break;
+		case XDP_REDIRECT:
+			rxq->stats[RX_XDP_REDIRECT]++;
+			err = xdp_do_redirect(ndev, &xdp, prog);
+			if (unlikely(err)) {
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_REDIRECT);
+			} else {
+				xdp_res |= FEC_ENET_XDP_REDIR;
+			}
+			break;
+		case XDP_TX:
+			rxq->stats[RX_XDP_TX]++;
+			err = fec_enet_xdp_tx_xmit(fep, cpu, &xdp, sync);
+			if (unlikely(err)) {
+				rxq->stats[RX_XDP_TX_ERRORS]++;
+				fec_xdp_drop(rxq, &xdp, sync);
+				trace_xdp_exception(ndev, prog, XDP_TX);
+			}
+			break;
+		default:
+			bpf_warn_invalid_xdp_action(ndev, prog, act);
+			fallthrough;
+		case XDP_ABORTED:
+			/* handle aborts by dropping packet */
+			fallthrough;
+		case XDP_DROP:
+			rxq->stats[RX_XDP_DROP]++;
+			fec_xdp_drop(rxq, &xdp, sync);
+			break;
+		}
+
+rx_processing_done:
+		/* Clear the status flags for this buffer */
+		status &= ~BD_ENET_RX_STATS;
+		/* Mark the buffer empty */
+		status |= BD_ENET_RX_EMPTY;
+
+		if (fep->bufdesc_ex) {
+			struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
+
+			ebdp->cbd_esc = cpu_to_fec32(BD_ENET_RX_INT);
+			ebdp->cbd_prot = 0;
+			ebdp->cbd_bdu = 0;
+		}
+
+		/* Make sure the updates to rest of the descriptor are
+		 * performed before transferring ownership.
+		 */
+		dma_wmb();
+		bdp->cbd_sc = cpu_to_fec16(status);
+
+		/* Update BD pointer to next entry */
+		bdp = fec_enet_get_nextdesc(bdp, &rxq->bd);
+
+		/* Doing this here will keep the FEC running while we process
+		 * incoming frames. On a heavily loaded network, we should be
+		 * able to keep up at the expense of system resources.
+		 */
+		writel(0, rxq->bd.reg_desc_active);
+	}
+
+	rxq->bd.cur = bdp;
+
+	if (xdp_res & FEC_ENET_XDP_REDIR)
 		xdp_do_flush();
 
 	return pkt_received;
@@ -1970,11 +2048,17 @@ static int fec_enet_rx_queue(struct fec_enet_private *fep,
 static int fec_enet_rx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct bpf_prog *prog = READ_ONCE(fep->xdp_prog);
 	int i, done = 0;
 
 	/* Make sure that AVB queues are processed first. */
-	for (i = fep->num_rx_queues - 1; i >= 0; i--)
-		done += fec_enet_rx_queue(fep, i, budget - done);
+	for (i = fep->num_rx_queues - 1; i >= 0; i--) {
+		if (prog)
+			done += fec_enet_rx_queue_xdp(fep, i, budget - done,
+						      prog);
+		else
+			done += fec_enet_rx_queue(fep, i, budget - done);
+	}
 
 	return done;
 }
-- 
2.34.1


